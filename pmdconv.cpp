//pmd参考：https://github.com/mistydemeo/pmdmini
//midifile参考：https://github.com/craigsapp/midifile
#ifdef _DEBUG
#pragma comment(lib,"midifile\\visual-studio\\DebugLib\\midifile.lib")
#pragma comment(lib,"pmdplay\\Debug\\pmdplay.lib")
#else
#pragma comment(lib,"midifile\\visual-studio\\ReleaseLib\\midifile.lib")
#pragma comment(lib,"pmdplay\\Release\\pmdplay.lib")
#endif
#define _WINDOWS
#include"midifile\include\MidiFile.h"
#include"pmdplay\pmdwin\pmdwinimport.h"
#include<iostream>
#include<fstream>
#define MAX_PMD_PATCH 256
int g_patch[MAX_PMD_PATCH];
void InitPatch()
{
	std::ifstream pf("patch.txt", std::ios::in);
	for (int i = 0; i < MAX_PMD_PATCH; i++)g_patch[i] = i % 128;
	if (!pf)
	{
		printf("未找到 patch.txt, 程序将以PMD音色作为GM音色处理。"
			"建议你创建该文件并在每行写入PMD到GM的对应音色，否则转换出来的MIDI效果可能不理想。\n");
	}
	else
	{
		int i = 0;
		while (i < MAX_PMD_PATCH)
		{
			pf >> g_patch[i];
			if (g_patch[i] > 127)printf("音色[%d]=%d, 超出最大值 127.\n", i, g_patch[i]);
			i++;
			if (pf.eof())break;
		}
		printf("读取了%d个音色。\n", i);
	}
}
struct ChannelNote
{
	int note = 0, last_note = 0;
	int volume = 0;//FM最大127，SSG最大15
	int patch = 0;
	int ch = 0;
	bool keyison = false;
	void UpdateChannel()
	{
		volume = getpartwork(ch)->volume;
		last_patch = patch;
		patch = getpartwork(ch)->voicenum;
		last_note = note;
		note = (getpartwork(ch)->onkai & 0xF) + ((getpartwork(ch)->onkai >> 4) * 12);
		last_key_on_count = key_on_count;
		key_on_count = getpartwork(ch)->keyon_flag;
	}
	bool IsOnNoteOn()
	{
		return (key_on_count != last_key_on_count) || (note < 128 && last_note >= 128);
	}
	bool IsOnNoteOff()
	{
		return (getpartwork(ch)->keyoff_flag != 0) || (note >= 128 && last_note < 128);
	}
	bool IsOnProgramChange()
	{
		return last_patch != patch;
	}
	int GetVolumeInGM()
	{
		if (ch < 6)return volume;
		else return 127 * volume / 15;
	}
private:
	int last_key_on_count = 0;
	int last_patch = 0;
	int key_on_count = 0;
};
struct ChannelRhythm
{
	int notes[128] = { 0 };
	int volume = 0;//最大63
	void UpdateChannel()
	{
		volume = getopenwork()->rhyvol;
	}
};
struct Channels
{
	ChannelNote chnote[9];
	ChannelRhythm chrhy;
	Channels()
	{
		for (int i = 0; i < 9; i++)chnote[i].ch = i;
	}
	void Update()
	{
		for (int i = 0; i < 9; i++)chnote[i].UpdateChannel();
		last_tempo = tempo;
		tempo = getopenwork()->tempo_48 * 2;
	}
	int tempo = 120;
	bool IsTempoChanged()
	{
		return last_tempo != tempo;
	}
private:
	int last_tempo = 120;
};
int Convert(const char *infile, const char *outfile)
{
	pmdwininit(".");
	setppsuse(false);
	setrhythmwithssgeffect(true);
	getopenwork()->effflag = 0;
	setfmcalc55k(true);
	setpcmrate(SOUND_44K);
	char musicfilepath[_MAX_PATH];
	strcpy(musicfilepath, infile);
	if (music_load(musicfilepath))
	{
		printf("加载文件 %s 时出错，请检查该文件是否是有效的 PMD 文件。\n", musicfilepath);
		return -1;
	}
	music_start();
	int tpq = getopenwork()->syousetu_lng / 4;
	MidiFile mf;
	Channels pmdch;
	int bytesof_buf = SOUND_44K * 2 * 2;//一秒音频的内存长度
	char *renbuf = new char[bytesof_buf];
	mf.addTrack(10);
	mf.setTicksPerQuarterNote(tpq);
	for (int i = 0; i < 9; i++)
	{
		char tname[32];
		sprintf(tname, "PMD Ch %c", 'A' + i);
		mf.addTrackName(i, 0, tname);
	}
	int nowtick = getpos2();
	int lengthtick = 0, looplengthtick = 0;
	getlength2(musicfilepath, &lengthtick, &looplengthtick);
	for (int i = 6; i <= 8; i++)mf.addPatchChange(i + 1, 0, i, 80);
	while (nowtick < lengthtick)
	{
		pmdch.Update();
		if (pmdch.IsTempoChanged())mf.addTempo(0, nowtick, pmdch.tempo);
		for (int i = 0; i < 9; i++)
		{
			if (pmdch.chnote[i].IsOnNoteOn())
			{
				if (pmdch.chnote[i].keyison)mf.addNoteOff(i + 1, nowtick, i, pmdch.chnote[i].last_note);
				pmdch.chnote[i].keyison = true;
				if (pmdch.chnote[i].note < 128)
					mf.addNoteOn(i + 1, nowtick, i, pmdch.chnote[i].note, pmdch.chnote[i].GetVolumeInGM());
			}
			if (pmdch.chnote[i].IsOnNoteOff())
			{
				pmdch.chnote[i].keyison = false;
				if (pmdch.chnote[i].last_note < 128)
					mf.addNoteOff(i + 1, nowtick, i, pmdch.chnote[i].last_note);
			}
			if (pmdch.chnote[i].IsOnProgramChange())mf.addPatchChange(i + 1, nowtick, i, g_patch[pmdch.chnote[i].patch]);
		}
		getpcmdata((short*)renbuf, min(SOUND_44K, SOUND_44K * 60 / tpq / pmdch.tempo));
		nowtick = getpos2();
	}
	for (int i = 0; i < 9; i++)
		if (pmdch.chnote[i].keyison)
			mf.addNoteOff(i + 1, nowtick, i, pmdch.chnote[i].note);
	//TODO:实现节奏通道转换
	delete[]renbuf;
	music_stop();
	mf.sortTracks();
	mf.write(outfile);
	return 0;
}
int main(int argc, char *argv[])
{
	char outfile[_MAX_PATH];
	const char *infile = argv[1];
	sprintf(outfile, "%s.mid", infile);
	switch (argc)
	{
	case 3:strcpy(outfile, argv[2]);
	case 2:
		break;
	default:
		printf("参数错误。\npmdconv <输入文件名> [输出文件名=<输入文件名>.mid]\n");
		return 1;
	}
	InitPatch();
	return Convert(infile, outfile);
}