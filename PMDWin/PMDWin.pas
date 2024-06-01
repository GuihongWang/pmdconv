//============================================================================
//                        PMDWin.dll include file
//                      Copyright & Programmed by C60
//============================================================================
unit PMDWin;

interface

// COM ���C���^�[�t�F�C�X���e�X�g����ꍇ�ɗL���ɂ���
//{$DEFINE TESTCOMINTERFACE}


{$IFDEF VER90}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delphi 2.0J
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uses
	Windows, Dialogs, PCMMusDriver, FMPMDDefine;
{$ELSE}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delphi3 �ȍ~
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uses
	Windows, Dialogs, ActiveX, PCMMusDriver, FMPMDDefine;
{$ENDIF}

//=============================================================================
// �萔��`
//=============================================================================
const
	//--------------------------------------------------------------------------
	//	�G���[���b�Z�[�W��
	//--------------------------------------------------------------------------

	PMDWIN_DLLNAME							= 'PMDWin.dll';
	PMDWIN_MININTERFACEVERSION	= 117;		// Ver 0.17 �ȏ�
	PMDWIN_MAXINTERFACEVERSION	= 200;		// Ver 1.00 ����
	PMDWIN_MSG_DLLNOTFOUND			= PMDWIN_DLLNAME + '��������܂���';
	PMDWIN_MSG_DLLBROKEN				= PMDWIN_DLLNAME + '���ُ�ł�';
	PMDWIN_MSG_ERROR_LOWER			= 'Ver 0.17 �ȍ~�� PMDWin.dll ���g�p���Ă�������';
	PMDWIN_MSG_ERORR_UPPER			= 'Ver 1.00 ������ PMDWin.dll ���g�p���Ă�������';
  PMDWIN_MSG_COMNOTFOUND			= 'PMDWin �� COM �C���X�^���X���m�ۂł��܂���ł���';

	//--------------------------------------------------------------------------
	//	�o�[�W�������
	//--------------------------------------------------------------------------
	InterfaceVersion					= 117;		// PMDWin.dll �̃C���^�[�t�F�C�X�o�[�W����

	//--------------------------------------------------------------------------
	//	DLL �̖߂�l
	//--------------------------------------------------------------------------
	PMDWIN_OK									=   0;		// ����I��
	ERR_OPEN_MUSIC_FILE				=   1;		// �� �f�[�^���J���Ȃ�����
	ERR_WRONG_MUSIC_FILE			=   2;		// PMD �̋ȃf�[�^�ł͂Ȃ�����
	ERR_OPEN_PPC_FILE			 	  =   3;		// PPC ���J���Ȃ�����
	ERR_OPEN_P86_FILE		 	  	=   4;		// P86 ���J���Ȃ�����
	ERR_OPEN_PPS_FILE		 		  =   5;		// PPS ���J���Ȃ�����
	ERR_OPEN_PPZ1_FILE			 	=   6;		// PPZ1 ���J���Ȃ�����
	ERR_OPEN_PPZ2_FILE			 	=   7;		// PPZ2 ���J���Ȃ�����
	ERR_WRONG_PPC_FILE		 		=   8;		// PPC/PVI �ł͂Ȃ�����
	ERR_WRONG_P86_FILE			 	=   9;		// P86 �ł͂Ȃ�����
	ERR_WRONG_PPS_FILE			 	=  10;		// PPS �ł͂Ȃ�����
	ERR_WRONG_PPZ1_FILE			 	=  11;		// PVI/PZI �ł͂Ȃ�����(PPZ1)
	ERR_WRONG_PPZ2_FILE		 		=  12;		// PVI/PZI �ł͂Ȃ�����(PPZ2)
	WARNING_PPC_ALREADY_LOAD	=  13;		// PPC �͂��łɓǂݍ��܂�Ă���
	WARNING_P86_ALREADY_LOAD	=  14;		// P86 �͂��łɓǂݍ��܂�Ă���
	WARNING_PPS_ALREADY_LOAD	=  15;		// PPS �͂��łɓǂݍ��܂�Ă���
	WARNING_PPZ1_ALREADY_LOAD	=  16;		// PPZ1 �͂��łɓǂݍ��܂�Ă���
	WARNING_PPZ2_ALREADY_LOAD	=  17;		// PPZ2 �͂��łɓǂݍ��܂�Ă���

	ERR_WRONG_PARTNO			 		=  30;		// �p�[�g�ԍ����s�K
//	ERR_ALREADY_MASKED			 	=  31;		// �w��p�[�g�͂��łɃ}�X�N����Ă���
	ERR_NOT_MASKED				 		=  32;		// �w��p�[�g�̓}�X�N����Ă��Ȃ�
	ERR_MUSIC_STOPPED			 		=  33;		// �Ȃ��~�܂��Ă���̂Ƀ}�X�N���������
	ERR_EFFECT_USED				 		=  34;		// ���ʉ��Ŏg�p���Ȃ̂Ń}�X�N�𑀍�ł��Ȃ�

	ERR_OUT_OF_MEMORY			 		=  99;		// ������������Ȃ�
	ERR_OTHER									= 999;		// ���̑��̃G���[

	//--------------------------------------------------------------------------
	//	PMDWin ��p�̒�`
	//--------------------------------------------------------------------------
	MAX_PCMDIR							=    64;

	//--------------------------------------------------------------------------
	//	���̑���`
	//--------------------------------------------------------------------------
	NumOfFMPart			      	=     6;
	NumOfSSGPart						=     3;
	NumOfADPCMPart		      =     1;
	NumOFOPNARhythmPart	    =     1;
	NumOfExtPart		        =     3;
	NumOfRhythmPart		      =     1;
	NumOfEffPart		        =     1;
	NumOfPPZ8Part		        =     8;
	NumOfAllPart		        = (NumOfFMPart+NumOfSSGPart+NumOfADPCMPart+NumOFOPNARhythmPart+NumOfExtPart+NumOfRhythmPart+NumOfEffPart+NumOfPPZ8Part);



type
	//==========================================================================
	// �p�[�g���[�N�̒�`
	//==========================================================================
	PQQ = ^TQQ;
	TQQ = record		//	�p�[�g���[�N�̍\����
		address					: PByte;		//	2 �ݿ���� � ���ڽ
		partloop				: PByte;		//	2 �ݿ� �� �ܯ�ķ � ���ػ�
		leng						: Integer;	//	1 ɺ� LENGTH
		qdat						: Integer;	//	1 gatetime (q/Q�l���v�Z�����l)
		fnum						: Cardinal; //	2 �ݿ���� � BLOCK/FNUM
		detune					: Integer;	//	2 ������
		lfodat					: Integer;	//	2 LFO DATA
		porta_num				: Integer;	//	2 �|���^�����g�̉����l�i�S�́j
		porta_num2			: Integer;	//	2 �|���^�����g�̉����l�i���j
		porta_num3			: Integer;	//	2 �|���^�����g�̉����l�i�]��j
		volume					: Integer;	//	1 VOLUME
		shift						: Integer;	//	1 �ݶ� ��� � ���
		delay						: Integer;	//	1 LFO	[DELAY] 
		speed						: Integer;	//	1	[SPEED]
		step						: Integer;	//	1	[STEP]
		time						: Integer;	//	1	[TIME]
		delay2					: Integer;	//	1	[DELAY_2]
		speed2					: Integer;	//	1	[SPEED_2]
		step2						: Integer;	//	1	[STEP_2]
		time2						: Integer;	//	1	[TIME_2]
		lfoswi					: Integer;	//	1 LFOSW. B0/tone B1/vol B2/���� B3/porta
										  					//	         B4/tone B5/vol B6/����
		volpush					: Integer;	//	1 Volume PUSHarea
		mdepth					: Integer;	//	1 M depth
		mdspd						: Integer;	//	1 M speed
		mdspd2					: Integer;	//	1 M speed_2
		envf						: Integer;	//	1 PSG ENV. [START_FLAG] / -1��extend
		eenv_count			: Integer;	//	1 ExtendPSGenv/No=0 AR=1 DR=2 SR=3 RR=4
		eenv_ar					: Integer;	//	1 	/AR		/��pat
		eenv_dr					: Integer;	//	1	/DR		/��pv2
		eenv_sr					: Integer;	//	1	/SR		/��pr1
		eenv_rr					: Integer;	//	1	/RR		/��pr2
		eenv_sl					: Integer;	//	1	/SL
		eenv_al					: Integer;	//	1	/AL
		eenv_arc				: Integer;	//	1	/AR�̃J�E���^	/��patb
		eenv_drc				: Integer;	//	1	/DR�̃J�E���^
		eenv_src				: Integer;	//	1	/SR�̃J�E���^	/��pr1b
		eenv_rrc				: Integer;	//	1	/RR�̃J�E���^	/��pr2b
		eenv_volume			: Integer;	//	1	/Volume�l(0�`15)/��penv
		extendmode			: Integer;	//	1 B1/Detune B2/LFO B3/Env Normal/Extend
		fmpan						: Integer;	//	1 FM Panning + AMD + PMD
		psgpat					: Integer;	//	1 PSG PATTERN [TONE/NOISE/MIX]
		voicenum				: Integer;	//	1 ���F�ԍ�
		loopcheck				: Integer;	//	1 ���[�v������P �I��������R
		carrier					: Integer;	//	1 FM Carrier
		slot1						: Integer;	//	1 SLOT 1 � TL
		slot3						: Integer;	//	1 SLOT 3 � TL
		slot2						: Integer;	//	1 SLOT 2 � TL
		slot4						: Integer;	//	1 SLOT 4 � TL
		slotmask				: Integer;	//	1 FM slotmask
		neiromask				: Integer;	//	1 FM ���F��`�pmaskdata
		lfo_wave				: Integer;	//	1 LFO�̔g�`
		partmask				: Integer;	//	1 PartMask b0:�ʏ� b1:���ʉ� b2:NECPCM�p
										  					//	   b3:none b4:PPZ/ADE�p b5:s0�� b6:m b7:�ꎞ
		keyoff_flag			: Integer;	//	1 Keyoff�������ǂ�����Flag
		volmask					: Integer;	//	1 ����LFO�̃}�X�N
		qdata						: Integer;	//	1 q�̒l
		qdatb						: Integer;	//	1 Q�̒l
		hldelay					: Integer;	//	1 HardLFO delay
		hldelay_c				: Integer;	//	1 HardLFO delay Counter
		_lfodat					: Integer;	//	2 LFO DATA
		_delay					: Integer;	//	1 LFO	[DELAY] 
		_speed					: Integer;	//	1		[SPEED]
		_step						: Integer;	//	1		[STEP]
		_time						: Integer;	//	1		[TIME]
		_delay2					: Integer;	//	1		[DELAY_2]
		_speed2					: Integer;	//	1		[SPEED_2]
		_step2					: Integer;	//	1		[STEP_2]
		_time2					: Integer;	//	1		[TIME_2]
		_mdepth					: Integer;	//	1 M depth
		_mdspd					: Integer;	//	1 M speed
		_mdspd2					: Integer;	//	1 M speed_2
		_lfo_wave				: Integer;	//	1 LFO�̔g�`
		_volmask				: Integer;	//	1 ����LFO�̃}�X�N
		mdc							: Integer;	//	1 M depth Counter (�ϓ��l)
		mdc2						: Integer;	//	1 M depth Counter
		_mdc						: Integer;	//	1 M depth Counter (�ϓ��l)
		_mdc2						: Integer;	//	1 M depth Counter
		onkai						: Integer;	//	1 ���t���̉��K�f�[�^ (0ffh:rest)
		sdelay					: Integer;	//	1 Slot delay
		sdelay_c				: Integer;	//	1 Slot delay counter
		sdelay_m				: Integer;	//	1 Slot delay Mask
		alg_fb					: Integer;	//	1 ���F��alg/fb
		keyon_flag			: Integer;	//	1 �V���K/�x���f�[�^������������inc
		qdat2						: Integer;	//	1 q �Œ�ۏؒl
		onkai_def				: Integer;	//	1 ���t���̉��K�f�[�^ (�]�������O / ?fh:rest)
		shift_def				: Integer;	//	1 �}�X�^�[�]���l
		qdat3						: Integer;	//	1 q Random
	end;
	
	//==========================================================================
	// OPEN_WORK �̒�`
	//==========================================================================
	POPEN_WORK = ^TOPEN_WORK;
	TOPEN_WORK = record
		MusPart : Array[0..NumOfAllPart-1] of PQQ;	// �p�[�g���[�N�̃|�C���^
		mmlbuf					: PByte;		//	Musicdata��address+1
		tondat					: PByte;		//	Voicedata��address
		efcdat					: PByte;		//	FM  Effecdata��address
		prgdat_adr			: PByte;		//	�ȃf�[�^�����F�f�[�^�擪�Ԓn
		radtbl					: PWord;		//	R part offset table �擪�Ԓn
		rhyadr					: PByte;		//	R part ���t���Ԓn
		rhythmmask			: Integer;	//	Rhythm�����̃}�X�N x8c/10h��bit�ɑΉ�
		fm_voldown			: Integer;	//	FM voldown ���l
		ssg_voldown			: Integer;	//	PSG voldown ���l
		pcm_voldown			: Integer;	//	ADPCM voldown ���l
		rhythm_voldown	: Integer;	//	RHYTHM voldown ���l
		prg_flg					: Integer;	//	�ȃf�[�^�ɉ��F���܂܂�Ă��邩flag
		x68_flg					: Integer;	//	OPM flag
		status					: Integer;	//	status1
		status2					: Integer;	//	status2
		tempo_d					: Integer;	//	tempo (TIMER-B)
		fadeout_speed		: Integer;	//	Fadeout���x
		fadeout_volume	: Integer;	//	Fadeout����
		tempo_d_push		: Integer;	//	tempo (TIMER-B) / �ۑ��p
		syousetu_lng		: Integer;	//	���߂̒���
		opncount				: Integer;	//	�ŒZ�����J�E���^
		TimerAtime			: Integer;	//	TimerA�J�E���^
		effflag					: Integer;	//	PSG���ʉ�����on/off flag(���[�U�[�����)
		psnoi						: Integer;	//	PSG noise���g��
		psnoi_last			: Integer;	//	PSG noise���g��(�Ō�ɒ�`�������l)
		pcmstart				: Integer;	//	PCM���F��start�l
		pcmstop					: Integer;	//	PCM���F��stop�l
		rshot_dat				: Integer;	//	���Y������ shot flag
		rdat						: Array[0..6-1] of Integer;	//	���Y������ ����/�p���f�[�^
		rhyvol					: Integer;	//	���Y���g�[�^�����x��
		kshot_dat				: Integer;	//	�r�r�f���Y�� shot flag
		play_flag				: Integer;	//	play flag
		fade_stop_flag	: Integer;	//	Fadeout�� MSTOP���邩�ǂ����̃t���O
		kp_rhythm_flag	: Boolean;	//	K/Rpart��Rhythm������炷��flag
		pcm_gs_flag			: Integer;	//	ADPCM�g�p ���t���O (0�ŋ���)
		slot_detune1		: Integer;	//	FM3 Slot Detune�l slot1
		slot_detune2		: Integer;	//	FM3 Slot Detune�l slot2
		slot_detune3		: Integer;	//	FM3 Slot Detune�l slot3
		slot_detune4		: Integer;	//	FM3 Slot Detune�l slot4
		TimerB_speed		: Integer;	//	TimerB�̌��ݒl(=ff_tempo�Ȃ�ff��)
		fadeout_flag		: Integer;	//	��������fout���Ăяo������1
		revpan					: Integer;	//	PCM86�t��flag
		pcm86_vol				: Integer;	//	PCM86�̉��ʂ�SPB�ɍ��킹�邩?
		syousetu				: Integer;	//	���߃J�E���^
		port22h					: Integer;	//	OPN-PORT 22H �ɍŌ�ɏo�͂����l(hlfo)
		tempo_48				: Integer;	//	���݂̃e���|(clock=48 t�̒l)
		tempo_48_push		: Integer;	//	���݂̃e���|(����/�ۑ��p)
		_fm_voldown			: Integer;	//	FM voldown ���l (�ۑ��p)
		_ssg_voldown		: Integer;	//	PSG voldown ���l (�ۑ��p)
		_pcm_voldown		: Integer;	//	PCM voldown ���l (�ۑ��p)
		_rhythm_voldown	: Integer;	//	RHYTHM voldown ���l (�ۑ��p)
		_pcm86_vol			: Integer;	//	PCM86�̉��ʂ�SPB�ɍ��킹�邩? (�ۑ��p)
		rshot_bd				: Integer;	//	���Y������ shot inc flag (BD)
		rshot_sd				: Integer;	//	���Y������ shot inc flag (SD)
		rshot_sym				: Integer;	//	���Y������ shot inc flag (CYM)
		rshot_hh				: Integer;	//	���Y������ shot inc flag (HH)
		rshot_tom				: Integer;	//	���Y������ shot inc flag (TOM)
		rshot_rim				: Integer;	//	���Y������ shot inc flag (RIM)
		rdump_bd				: Integer;	//	���Y������ dump inc flag (BD)
		rdump_sd				: Integer;	//	���Y������ dump inc flag (SD)
		rdump_sym				: Integer;	//	���Y������ dump inc flag (CYM)
		rdump_hh				: Integer;	//	���Y������ dump inc flag (HH)
		rdump_tom				: Integer;	//	���Y������ dump inc flag (TOM)
		rdump_rim				: Integer;	//	���Y������ dump inc flag (RIM)
		ch3mode					: Integer;	//	ch3 Mode
		ppz_voldown			: Integer;	//	PPZ8 voldown ���l
		_ppz_voldown		: Integer;	//	PPZ8 voldown ���l (�ۑ��p)
		TimerAflag			: Integer;	//	TimerA���荞�ݒ��H�t���O
		TimerBflag			: Integer;	//	TimerB���荞�ݒ��H�t���O

		// for PMDWin
		rate						: Integer;	//	PCM �o�͎��g��(11k, 22k, 44k, 55k)
		ppz8ip					: Boolean;	//	PPZ8 �ŕ⊮���邩
		ppsip						: Boolean;	//	PPS  �ŕ⊮���邩
		p86ip						: Boolean;	//	P86  �ŕ⊮���邩
		use_p86					: Boolean;	//	P86  ���g�p���Ă��邩
		fadeout2_speed  : Integer;	//	fadeout(������)speed(>0�� fadeout)

		mus_filename : Array[0.._MAX_PATH-1] of char;	//	�Ȃ�FILE���o�b�t�@
		ppcfilename : Array[0.._MAX_PATH-1] of char;	//	PPC ��FILE���o�b�t�@
		pcmdir : Array[0..MAX_PCMDIR+1-1, 0.._MAX_PATH-1] of char;	//	PCM �����f�B���N�g��
	end;


	//==========================================================================
	// OPEN_WORK �̒�`�i�|�t�@�C�����������A�A�������ߖ�j
	//==========================================================================
	POPEN_WORK2 = ^TOPEN_WORK2;  		// OPEN_WORK - �t�@�C��������
	TOPEN_WORK2 = record
		MusPart : Array[0..NumOfAllPart-1] of PQQ;	// �p�[�g���[�N�̃|�C���^
		mmlbuf					: PByte;		//	Musicdata��address+1
		tondat					: PByte;		//	Voicedata��address
		efcdat					: PByte;		//	FM  Effecdata��address
		prgdat_adr			: PByte;		//	�ȃf�[�^�����F�f�[�^�擪�Ԓn
		radtbl					: PWord;		//	R part offset table �擪�Ԓn
		rhyadr					: PByte;		//	R part ���t���Ԓn
		rhythmmask			: Integer;	//	Rhythm�����̃}�X�N x8c/10h��bit�ɑΉ�
		fm_voldown			: Integer;	//	FM voldown ���l
		ssg_voldown			: Integer;	//	PSG voldown ���l
		pcm_voldown			: Integer;	//	ADPCM voldown ���l
		rhythm_voldown	: Integer;	//	RHYTHM voldown ���l
		prg_flg					: Integer;	//	�ȃf�[�^�ɉ��F���܂܂�Ă��邩flag
		x68_flg					: Integer;	//	OPM flag
		status					: Integer;	//	status1
		status2					: Integer;	//	status2
		tempo_d					: Integer;	//	tempo (TIMER-B)
		fadeout_speed		: Integer;	//	Fadeout���x
		fadeout_volume	: Integer;	//	Fadeout����
		tempo_d_push		: Integer;	//	tempo (TIMER-B) / �ۑ��p
		syousetu_lng		: Integer;	//	���߂̒���
		opncount				: Integer;	//	�ŒZ�����J�E���^
		TimerAtime			: Integer;	//	TimerA�J�E���^
		effflag					: Integer;	//	PSG���ʉ�����on/off flag(���[�U�[�����)
		psnoi						: Integer;	//	PSG noise���g��
		psnoi_last			: Integer;	//	PSG noise���g��(�Ō�ɒ�`�������l)
		pcmstart				: Integer;	//	PCM���F��start�l
		pcmstop					: Integer;	//	PCM���F��stop�l
		rshot_dat				: Integer;	//	���Y������ shot flag
		rdat						: Array[0..6-1] of Integer;	//	���Y������ ����/�p���f�[�^
		rhyvol					: Integer;	//	���Y���g�[�^�����x��
		kshot_dat				: Integer;	//	�r�r�f���Y�� shot flag
		play_flag				: Integer;	//	play flag
		fade_stop_flag	: Integer;	//	Fadeout�� MSTOP���邩�ǂ����̃t���O
		kp_rhythm_flag	: Boolean;	//	K/Rpart��Rhythm������炷��flag
		pcm_gs_flag			: Integer;	//	ADPCM�g�p ���t���O (0�ŋ���)
		slot_detune1		: Integer;	//	FM3 Slot Detune�l slot1
		slot_detune2		: Integer;	//	FM3 Slot Detune�l slot2
		slot_detune3		: Integer;	//	FM3 Slot Detune�l slot3
		slot_detune4		: Integer;	//	FM3 Slot Detune�l slot4
		TimerB_speed		: Integer;	//	TimerB�̌��ݒl(=ff_tempo�Ȃ�ff��)
		fadeout_flag		: Integer;	//	��������fout���Ăяo������1
		revpan					: Integer;	//	PCM86�t��flag
		pcm86_vol				: Integer;	//	PCM86�̉��ʂ�SPB�ɍ��킹�邩?
		syousetu				: Integer;	//	���߃J�E���^
		port22h					: Integer;	//	OPN-PORT 22H �ɍŌ�ɏo�͂����l(hlfo)
		tempo_48				: Integer;	//	���݂̃e���|(clock=48 t�̒l)
		tempo_48_push		: Integer;	//	���݂̃e���|(����/�ۑ��p)
		_fm_voldown			: Integer;	//	FM voldown ���l (�ۑ��p)
		_ssg_voldown		: Integer;	//	PSG voldown ���l (�ۑ��p)
		_pcm_voldown		: Integer;	//	PCM voldown ���l (�ۑ��p)
		_rhythm_voldown	: Integer;	//	RHYTHM voldown ���l (�ۑ��p)
		_pcm86_vol			: Integer;	//	PCM86�̉��ʂ�SPB�ɍ��킹�邩? (�ۑ��p)
		rshot_bd				: Integer;	//	���Y������ shot inc flag (BD)
		rshot_sd				: Integer;	//	���Y������ shot inc flag (SD)
		rshot_sym				: Integer;	//	���Y������ shot inc flag (CYM)
		rshot_hh				: Integer;	//	���Y������ shot inc flag (HH)
		rshot_tom				: Integer;	//	���Y������ shot inc flag (TOM)
		rshot_rim				: Integer;	//	���Y������ shot inc flag (RIM)
		rdump_bd				: Integer;	//	���Y������ dump inc flag (BD)
		rdump_sd				: Integer;	//	���Y������ dump inc flag (SD)
		rdump_sym				: Integer;	//	���Y������ dump inc flag (CYM)
		rdump_hh				: Integer;	//	���Y������ dump inc flag (HH)
		rdump_tom				: Integer;	//	���Y������ dump inc flag (TOM)
		rdump_rim				: Integer;	//	���Y������ dump inc flag (RIM)
		ch3mode					: Integer;	//	ch3 Mode
		ppz_voldown			: Integer;	//	PPZ8 voldown ���l
		_ppz_voldown		: Integer;	//	PPZ8 voldown ���l (�ۑ��p)
		TimerAflag			: Integer;	//	TimerA���荞�ݒ��H�t���O
		TimerBflag			: Integer;	//	TimerB���荞�ݒ��H�t���O

		// for PMDWin
		rate						: Integer;	//	PCM �o�͎��g��(11k, 22k, 44k, 55k)
		ppz8ip					: Boolean;	//	PPZ8 �ŕ⊮���邩
		ppsip						: Boolean;	//	PPS  �ŕ⊮���邩
		p86ip						: Boolean;	//	P86  �ŕ⊮���邩
		use_p86					: Boolean;	//	P86  ���g�p���Ă��邩
		fadeout2_speed  : Integer;	//	fadeout(������)speed(>0�� fadeout)
	end;


{$IFDEF VER90}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delphi 2.0J
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	//===========================================================================
	// IPMDWIN : PMDWIN �� Interface Class
	//===========================================================================
	IPMDWIN = class(IFMPMD)
		procedure setppsuse(value : Boolean); virtual; stdcall; abstract;
		procedure setrhythmwithssgeffect(value : Boolean); virtual; stdcall; abstract;
		procedure setpmd86pcmmode(value : Boolean); virtual; stdcall; abstract;
		function getpmd86pcmmode : Boolean; virtual; stdcall; abstract;
		procedure setppsinterpolation(ip : Boolean); virtual; stdcall; abstract;
		procedure setp86interpolation(ip : Boolean); virtual; stdcall; abstract;
		function maskon(ch : Integer) : Integer; virtual; stdcall; abstract;
		function maskoff(ch : Integer) : Integer; virtual; stdcall; abstract;
		procedure setfmvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setssgvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setrhythmvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setadpcmvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setppzvoldown(voldown : Integer); virtual; stdcall; abstract;
		function getfmvoldown : Integer; virtual; stdcall; abstract;
		function getfmvoldown2 : Integer; virtual; stdcall; abstract;
		function getssgvoldown : Integer; virtual; stdcall; abstract;
		function getssgvoldown2 : Integer; virtual; stdcall; abstract;
		function getrhythmvoldown : Integer; virtual; stdcall; abstract;
		function getrhythmvoldown2 : Integer; virtual; stdcall; abstract;
		function getadpcmvoldown : Integer; virtual; stdcall; abstract;
		function getadpcmvoldown2 : Integer; virtual; stdcall; abstract;
		function getppzvoldown : Integer; virtual; stdcall; abstract;
		function getppzvoldown2 : Integer; virtual; stdcall; abstract;
		function getmemo(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; virtual; stdcall; abstract;
		function getmemo2(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; virtual; stdcall; abstract;
		function getmemo3(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; virtual; stdcall; abstract;
		function fgetmemo(dest : PChar; filename : PChar; al : Integer) : Integer; virtual; stdcall; abstract;
		function fgetmemo2(dest : PChar; filename : PChar; al : Integer) : Integer; virtual; stdcall; abstract;
		function fgetmemo3(dest : PChar; filename : PChar; al : Integer) : Integer; virtual; stdcall; abstract;
		function getppcfilename(dest : PChar) : PChar; virtual; stdcall; abstract;
		function getppsfilename(dest : PChar) : PChar; virtual; stdcall; abstract;
		function getp86filename(dest : PChar) : PChar; virtual; stdcall; abstract;
		function ppc_load(filename : PChar) : Integer; virtual; stdcall; abstract;
		function pps_load(filename : PChar) : Integer; virtual; stdcall; abstract;
		function p86_load(filename : PChar) : Integer; virtual; stdcall; abstract;
		function ppz_load(filename : PChar; bufnum : Integer) : Integer; virtual; stdcall; abstract;
		function getopenwork : POPEN_WORK; virtual; stdcall; abstract;
		function getpartwork(ch : Integer) : PQQ; virtual; stdcall; abstract;
	end;


{$ELSE}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delphi3 �ȍ~
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	//===========================================================================
	// IPMDWIN : PMDWIN �� Interface Class
	//===========================================================================
	IPMDWIN = interface(IFMPMD)
  	['{C07008F4-CAE0-421C-B08F-D8B319AFA4B4}']
		procedure setppsuse(value : Boolean); stdcall;
		procedure setrhythmwithssgeffect(value : Boolean); stdcall;
		procedure setpmd86pcmmode(value : Boolean); stdcall;
		function getpmd86pcmmode : Boolean; stdcall;
		procedure setppsinterpolation(ip : Boolean); stdcall;
		procedure setp86interpolation(ip : Boolean); stdcall;
		function maskon(ch : Integer) : Integer; stdcall;
		function maskoff(ch : Integer) : Integer; stdcall;
		procedure setfmvoldown(voldown : Integer); stdcall;
		procedure setssgvoldown(voldown : Integer); stdcall;
		procedure setrhythmvoldown(voldown : Integer); stdcall;
		procedure setadpcmvoldown(voldown : Integer); stdcall;
		procedure setppzvoldown(voldown : Integer); stdcall;
		function getfmvoldown : Integer; stdcall;
		function getfmvoldown2 : Integer; stdcall;
		function getssgvoldown : Integer; stdcall;
		function getssgvoldown2 : Integer; stdcall;
		function getrhythmvoldown : Integer; stdcall;
		function getrhythmvoldown2 : Integer; stdcall;
		function getadpcmvoldown : Integer; stdcall;
		function getadpcmvoldown2 : Integer; stdcall;
		function getppzvoldown : Integer; stdcall;
		function getppzvoldown2 : Integer; stdcall;
		function getmemo(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
		function getmemo2(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
		function getmemo3(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
		function fgetmemo(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
		function fgetmemo2(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
		function fgetmemo3(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
		function getppcfilename(dest : PChar) : PChar; stdcall;
		function getppsfilename(dest : PChar) : PChar; stdcall;
		function getp86filename(dest : PChar) : PChar; stdcall;
		function ppc_load(filename : PChar) : Integer; stdcall;
		function pps_load(filename : PChar) : Integer; stdcall;
		function p86_load(filename : PChar) : Integer; stdcall;
		function ppz_load(filename : PChar; bufnum : Integer) : Integer; stdcall;
		function getopenwork : POPEN_WORK; stdcall;
		function getpartwork(ch : Integer) : PQQ; stdcall;
	end;

{$ENDIF}


//=============================================================================
// Interface ID(IID) & Class ID(CLSID)
//=============================================================================
const
	// GUID of IPMDWIN Interface ID
	IID_IPMDWIN : TIID =
		(D1:$C07008F4; D2:$CAE0; D3:$421C; D4:($B0,$8F,$D8,$B3,$19,$AF,$A4,$B4));

	// GUID of PMDWIN Class ID
	CLSID_PMDWIN : TCLSID =
		(D1:$97C7C3F0; D2:$35D8; D3:$4304; D4:($8C,$1B,$AA,$92,$6E,$7A,$EC,$5C));



//=============================================================================
// DLL Interface
//=============================================================================
var
	HPMDWin : HMODULE;
{$IFDEF TESTCOMINTERFACE}
	pPMDWin  : IPMDWIN;
	pPMDWin2 : IPMDWIN;
{$ENDIF}

	getversion : function : Integer; stdcall;
	getinterfaceversion : function : Integer; stdcall;
	pmd_CoCreateInstance : function(const rclsid: TCLSID; pUnkOuter: IUnknown;
		dwClsContext: Longint; const riid: TIID; var ppv): HResult; stdcall;

{$IFDEF TESTCOMINTERFACE}
	function pmdwininit(path : PChar) : Boolean; stdcall;
	function loadrhythmsample(path : PChar) : Boolean; stdcall;
	function setpcmdir(pcmdir : PChar) : Boolean; stdcall;
	procedure setpcmrate(rate : Integer); stdcall;
	procedure setppzrate(rate : Integer); stdcall;
	procedure setppsuse(value : Boolean); stdcall;
	procedure setrhythmwithssgeffect(value : Boolean); stdcall;
	procedure setpmd86pcmmode(value : Boolean); stdcall;
	function getpmd86pcmmode: Boolean; stdcall;
	function music_load(filename : PChar) : Integer; stdcall;
	function music_load2(musdata : Pointer; size : Integer) : Integer; stdcall;
	procedure music_start; stdcall;
	procedure music_stop; stdcall;
	procedure fadeout(speed : Integer); stdcall;
	procedure fadeout2(speed : Integer); stdcall;
	procedure getpcmdata(buf : PSmallInt; nsamples : Integer); stdcall;
	procedure setfmcalc55k(flag : Boolean); stdcall;
	procedure setppsinterpolation(ip : Boolean); stdcall;
	procedure setp86interpolation(ip : Boolean); stdcall;
	procedure setppzinterpolation(ip : Boolean); stdcall;
	function getmemo(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
	function getmemo2(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
	function getmemo3(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
	function fgetmemo(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
	function fgetmemo2(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
	function fgetmemo3(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
	function getmusicfilename(dest : PChar) : PChar; stdcall;
	function getpcmfilename(dest : PChar) : PChar; stdcall;
	function getppcfilename(dest : PChar) : PChar; stdcall;
	function getppsfilename(dest : PChar) : PChar; stdcall;
	function getp86filename(dest : PChar) : PChar; stdcall;
	function getppzfilename(dest : PChar; bufnum : Integer) : PChar; stdcall;
	function ppc_load(filename : PChar) : Integer; stdcall;
	function pps_load(filename : PChar) : Integer; stdcall;
	function p86_load(filename : PChar) : Integer; stdcall;
	function ppz_load(filename : PChar; bufnum : Integer) : Integer; stdcall;
	function maskon(ch : Integer) : Integer; stdcall;
	function maskoff(ch : Integer) : Integer; stdcall;
	procedure setfmvoldown(voldown : Integer); stdcall;
	procedure setssgvoldown(voldown : Integer); stdcall;
	procedure setrhythmvoldown(voldown : Integer); stdcall;
	procedure setadpcmvoldown(voldown : Integer); stdcall;
	procedure setppzvoldown(voldown : Integer); stdcall;
	function getfmvoldown: Integer; stdcall;
	function getfmvoldown2: Integer; stdcall;
	function getssgvoldown: Integer; stdcall;
	function getssgvoldown2: Integer; stdcall;
	function getrhythmvoldown: Integer; stdcall;
	function getrhythmvoldown2: Integer; stdcall;
	function getadpcmvoldown: Integer; stdcall;
	function getadpcmvoldown2: Integer; stdcall;
	function getppzvoldown: Integer; stdcall;
	function getppzvoldown2: Integer; stdcall;
	procedure setpos(pos : Integer); stdcall;
	procedure setpos2(pos : Integer); stdcall;
	function getpos: Integer; stdcall;
	function getpos2: Integer; stdcall;
	function getlength(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	function getlength2(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	function getloopcount: Integer; stdcall;
	procedure setfmwait(nsec : Integer); stdcall;
	procedure setssgwait(nsec : Integer); stdcall;
	procedure setrhythmwait(nsec : Integer); stdcall;
	procedure setadpcmwait(nsec : Integer); stdcall;
	function getopenwork: POPEN_WORK; stdcall;
	function getpartwork(ch : Integer) : PQQ; stdcall;

{$ELSE}
	pmdwininit : function(path : PChar) : Boolean; stdcall;
	loadrhythmsample : function(path : PChar) : Boolean; stdcall;
	setpcmdir : function(pcmdir : PChar) : Boolean; stdcall;
	setpcmrate : procedure(rate : Integer); stdcall;
	setppzrate : procedure(rate : Integer); stdcall;
	setppsuse : procedure(value : Boolean); stdcall;
	setrhythmwithssgeffect : procedure(value : Boolean); stdcall;
	setpmd86pcmmode : procedure(value : Boolean); stdcall;
	getpmd86pcmmode : function : Boolean; stdcall;
	music_load : function(filename : PChar) : Integer; stdcall;
	music_load2 : function(musdata : Pointer; size : Integer) : Integer; stdcall;
	music_start : procedure; stdcall;
	music_stop : procedure; stdcall;
	fadeout : procedure(speed : Integer); stdcall;
	fadeout2 : procedure(speed : Integer); stdcall;
	getpcmdata : procedure(buf : PSmallInt; nsamples : Integer); stdcall;
	setfmcalc55k : procedure(flag : Boolean); stdcall;
	setppsinterpolation : procedure(ip : Boolean); stdcall;
	setp86interpolation : procedure(ip : Boolean); stdcall;
	setppzinterpolation : procedure(ip : Boolean); stdcall;
	getmemo : function(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
	getmemo2 : function(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
	getmemo3 : function(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
	fgetmemo : function(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
	fgetmemo2 : function(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
	fgetmemo3 : function(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
	getmusicfilename : function(dest : PChar) : PChar; stdcall;
	getpcmfilename : function(dest : PChar) : PChar; stdcall;
	getppcfilename : function(dest : PChar) : PChar; stdcall;
	getppsfilename : function(dest : PChar) : PChar; stdcall;
	getp86filename : function(dest : PChar) : PChar; stdcall;
	getppzfilename : function(dest : PChar; bufnum : Integer) : PChar; stdcall;
	ppc_load : function(filename : PChar) : Integer; stdcall;
	pps_load : function(filename : PChar) : Integer; stdcall;
	p86_load : function(filename : PChar) : Integer; stdcall;
	ppz_load : function(filename : PChar; bufnum : Integer) : Integer; stdcall;
	maskon : function(ch : Integer) : Integer; stdcall;
	maskoff : function(ch : Integer) : Integer; stdcall;
	setfmvoldown : procedure(voldown : Integer); stdcall;
	setssgvoldown : procedure(voldown : Integer); stdcall;
	setrhythmvoldown : procedure(voldown : Integer); stdcall;
	setadpcmvoldown : procedure(voldown : Integer); stdcall;
	setppzvoldown : procedure(voldown : Integer); stdcall;
	getfmvoldown : function : Integer; stdcall;
	getfmvoldown2 : function : Integer; stdcall;
	getssgvoldown : function : Integer; stdcall;
	getssgvoldown2 : function : Integer; stdcall;
	getrhythmvoldown : function : Integer; stdcall;
	getrhythmvoldown2 : function : Integer; stdcall;
	getadpcmvoldown : function : Integer; stdcall;
	getadpcmvoldown2 : function : Integer; stdcall;
	getppzvoldown : function : Integer; stdcall;
	getppzvoldown2 : function : Integer; stdcall;
	setpos : procedure(pos : Integer); stdcall;
	setpos2 : procedure(pos : Integer); stdcall;
	getpos : function : Integer; stdcall;
	getpos2 : function : Integer; stdcall;
	getlength : function(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	getlength2 : function(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	getloopcount : function : Integer; stdcall;
	setfmwait : procedure(nsec : Integer); stdcall;
	setssgwait : procedure(nsec : Integer); stdcall;
	setrhythmwait : procedure(nsec : Integer); stdcall;
	setadpcmwait : procedure(nsec : Integer); stdcall;
	getopenwork : function : POPEN_WORK; stdcall;
	getpartwork : function(ch : Integer) : PQQ; stdcall;
{$ENDIF}


implementation

//=============================================================================
// �֐��A�h���X���擾�ł��Ȃ��Ƌ����I��
//=============================================================================
function GetProcAddress2(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall;
begin
	Result := GetProcAddress(hModule, lpProcName);
	if(result = nil) then begin
		ShowMessage(PMDWIN_MSG_DLLBROKEN);
		Halt;
	end;
end;


{$IFDEF TESTCOMINTERFACE}
//----------------------------------------------------------------------------
// �֐��� COM���C���^�[�t�F�C�X�Ăяo���ɕϊ����邾���̊֐��Q
//----------------------------------------------------------------------------
function pmdwininit(path : PChar) : Boolean; stdcall;
begin
	pPMDWIN2.init(path);
	Result := pPMDWIN.init(path);
(*
	pPMDWIN2.setfmwait(0);				// �Ȓ��v�Z�������̂���
	pPMDWIN2.setssgwait(0);				// �Ȓ��v�Z�������̂���
	pPMDWIN2.setrhythmwait(0);		// �Ȓ��v�Z�������̂���
	pPMDWIN2.setadpcmwait(0);			// �Ȓ��v�Z�������̂���
*)
end;


function loadrhythmsample(path : PChar) : Boolean; stdcall;
begin
	Result := pPMDWIN.loadrhythmsample(path);
end;


function setpcmdir(pcmdir : PChar) : Boolean; stdcall;
begin
	Result := pPMDWIN.setpcmdir(pcmdir);
end;


procedure setpcmrate(rate : Integer); stdcall;
begin
	pPMDWIN.setpcmrate(rate);
end;


procedure setppzrate(rate : Integer); stdcall;
begin
	pPMDWIN.setppzrate(rate);
end;


procedure setppsuse(value : Boolean); stdcall;
begin
	pPMDWIN.setppsuse(value);
end;


procedure setrhythmwithssgeffect(value : Boolean); stdcall;
begin
	pPMDWIN.setrhythmwithssgeffect(value);
end;


procedure setpmd86pcmmode(value : Boolean); stdcall;
begin
	pPMDWIN.setpmd86pcmmode(value);
end;


function getpmd86pcmmode: Boolean; stdcall;
begin
	Result := pPMDWIN.getpmd86pcmmode;
end;


function music_load(filename : PChar) : Integer; stdcall;
begin
	Result := pPMDWIN.music_load(filename);
end;


function music_load2(musdata : Pointer; size : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.music_load2(musdata, size);
end;


procedure music_start; stdcall;
begin
	pPMDWIN.music_start;
end;


procedure music_stop; stdcall;
begin
	pPMDWIN.music_stop;
end;


procedure fadeout(speed : Integer); stdcall;
begin
	pPMDWIN.fadeout(speed);
end;


procedure fadeout2(speed : Integer); stdcall;
begin
	pPMDWIN.fadeout2(speed);
end;


procedure getpcmdata(buf : PSmallInt; nsamples : Integer); stdcall;
begin
	pPMDWIN.getpcmdata(buf, nsamples);
end;


procedure setfmcalc55k(flag : Boolean); stdcall;
begin
	pPMDWIN.setfmcalc55k(flag);
end;


procedure setppsinterpolation(ip : Boolean); stdcall;
begin
	pPMDWIN.setppsinterpolation(ip);
end;


procedure setp86interpolation(ip : Boolean); stdcall;
begin
	pPMDWIN.setp86interpolation(ip);
end;


procedure setppzinterpolation(ip : Boolean); stdcall;
begin
	pPMDWIN.setppzinterpolation(ip);
end;


function getmemo(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
begin
	Result := pPMDWIN.getmemo(dest, musdata, size, al);
end;


function getmemo2(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
begin
	Result := pPMDWIN.getmemo2(dest, musdata, size, al);
end;


function getmemo3(dest : PChar; musdata : Pointer; size, al : Integer) : PChar; stdcall;
begin
	Result := pPMDWIN.getmemo3(dest, musdata, size, al);
end;


function fgetmemo(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.fgetmemo(dest, filename, al);
end;


function fgetmemo2(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.fgetmemo2(dest, filename, al);
end;


function fgetmemo3(dest : PChar; filename : PChar; al : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.fgetmemo3(dest, filename, al);
end;


function getmusicfilename(dest : PChar) : PChar; stdcall;
begin
	Result := pPMDWIN.getmusicfilename(dest);
end;


function getpcmfilename(dest : PChar) : PChar; stdcall;
begin
	Result := pPMDWIN.getpcmfilename(dest);
end;


function getppcfilename(dest : PChar) : PChar; stdcall;
begin
	Result := pPMDWIN.getppcfilename(dest);
end;


function getppsfilename(dest : PChar) : PChar; stdcall;
begin
	Result := pPMDWIN.getppsfilename(dest);
end;


function getp86filename(dest : PChar) : PChar; stdcall;
begin
	Result := pPMDWIN.getp86filename(dest);
end;


function getppzfilename(dest : PChar; bufnum : Integer) : PChar; stdcall;
begin
	Result := pPMDWIN.getppzfilename(dest, bufnum);
end;


function ppc_load(filename : PChar) : Integer; stdcall;
begin
	Result := pPMDWIN.ppc_load(filename);
end;


function pps_load(filename : PChar) : Integer; stdcall;
begin
	Result := pPMDWIN.pps_load(filename);
end;


function p86_load(filename : PChar) : Integer; stdcall;
begin
	Result := pPMDWIN.p86_load(filename);
end;


function ppz_load(filename : PChar; bufnum : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.ppz_load(filename, bufnum);
end;


function maskon(ch : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.maskon(ch);
end;


function maskoff(ch : Integer) : Integer; stdcall;
begin
	Result := pPMDWIN.maskoff(ch);
end;


procedure setfmvoldown(voldown : Integer); stdcall;
begin
	pPMDWIN.setfmvoldown(voldown);
end;


procedure setssgvoldown(voldown : Integer); stdcall;
begin
	pPMDWIN.setssgvoldown(voldown)
end;


procedure setrhythmvoldown(voldown : Integer); stdcall;
begin
	pPMDWIN.setrhythmvoldown(voldown);
end;


procedure setadpcmvoldown(voldown : Integer); stdcall;
begin
	pPMDWIN.setadpcmvoldown(voldown);
end;


procedure setppzvoldown(voldown : Integer); stdcall;
begin
	pPMDWIN.setppzvoldown(voldown);
end;


function getfmvoldown: Integer; stdcall;
begin
	Result := pPMDWIN.getfmvoldown;
end;


function getfmvoldown2: Integer; stdcall;
begin
	Result := pPMDWIN.getfmvoldown2;
end;


function getssgvoldown: Integer; stdcall;
begin
	Result := pPMDWIN.getssgvoldown;
end;


function getssgvoldown2: Integer; stdcall;
begin
	Result := pPMDWIN.getssgvoldown2;
end;


function getrhythmvoldown: Integer; stdcall;
begin
	Result := pPMDWIN.getrhythmvoldown;
end;


function getrhythmvoldown2: Integer; stdcall;
begin
	Result := pPMDWIN.getrhythmvoldown2;
end;


function getadpcmvoldown: Integer; stdcall;
begin
	Result := pPMDWIN.getadpcmvoldown;
end;


function getadpcmvoldown2: Integer; stdcall;
begin
	Result := pPMDWIN.getadpcmvoldown2;
end;


function getppzvoldown: Integer; stdcall;
begin
	Result := pPMDWIN.getppzvoldown;
end;


function getppzvoldown2: Integer; stdcall;
begin
	Result := pPMDWIN.getppzvoldown2;
end;


procedure setpos(pos : Integer); stdcall;
begin
	pPMDWIN.setpos(pos);
end;


procedure setpos2(pos : Integer); stdcall;
begin
	pPMDWIN.setpos2(pos);
end;


function getpos: Integer; stdcall;
begin
	Result := pPMDWIN.getpos;
end;


function getpos2: Integer; stdcall;
begin
	Result := pPMDWIN.getpos2;
end;


function getlength(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
begin
	Result := pPMDWIN2.getlength(filename, length, loop);
end;


function getlength2(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
begin
	Result := pPMDWIN2.getlength2(filename, length, loop);
end;


function getloopcount: Integer; stdcall;
begin
	Result := pPMDWIN.getloopcount;
end;


procedure setfmwait(nsec : Integer); stdcall;
begin
	pPMDWIN.setfmwait(nsec);
end;


procedure setssgwait(nsec : Integer); stdcall;
begin
	pPMDWIN.setssgwait(nsec);
end;


procedure setrhythmwait(nsec : Integer); stdcall;
begin
	pPMDWIN.setrhythmwait(nsec);
end;


procedure setadpcmwait(nsec : Integer); stdcall;
begin
	pPMDWIN.setadpcmwait(nsec);
end;


function getopenwork: POPEN_WORK; stdcall;
begin
	Result := pPMDWIN.getopenwork;
end;


function getpartwork(ch : Integer) : PQQ; stdcall;
begin
	Result := pPMDWIN.getpartwork(ch);
end;

{$ENDIF}

initialization
//=============================================================================
// DLL �ǂݍ��݁��֐��A�h���X�擾
//=============================================================================
	HPMDWin := LoadLibrary(PMDWIN_DLLNAME);
	if(HPMDWin = 0) then begin
		ShowMessage(PMDWIN_MSG_DLLNOTFOUND);
		Halt;
	end;

	// �o�[�W�����`�F�b�N
	getversion := GetProcAddress2(HPMDWin, 'getversion');
	getinterfaceversion := GetProcAddress2(HPMDWin, 'getinterfaceversion');


	if(getinterfaceversion < PMDWIN_MININTERFACEVERSION) then begin
		ShowMessage(PMDWIN_MSG_ERROR_LOWER);
		Halt;
	end;

	if(getinterfaceversion >= PMDWIN_MAXINTERFACEVERSION) then begin
		ShowMessage(PMDWIN_MSG_ERORR_UPPER);
		Halt;
	end;


	// �C���X�^���X�擾�֐�
	pmd_CoCreateInstance := GetProcAddress2(HPMDWin, 'pmd_CoCreateInstance');


{$IFDEF TESTCOMINTERFACE}
//=============================================================================
// �C���X�^���X�擾
//=============================================================================

	if(pmd_CoCreateInstance(CLSID_PMDWIN, Nil, CLSCTX_ALL, IID_IPMDWIN, pPMDWIN) <> S_OK) then begin
		ShowMessage(PMDWIN_MSG_COMNOTFOUND);
	end;

	if(pmd_CoCreateInstance(CLSID_PMDWIN, Nil, CLSCTX_ALL, IID_IPMDWIN, pPMDWIN2) <> S_OK) then begin
		ShowMessage(PMDWIN_MSG_COMNOTFOUND);
	end;

{$ELSE}

	// �c��̊֐��A�h���X�̎擾
	pmdwininit := GetProcAddress2(HPMDWin, 'pmdwininit');
	loadrhythmsample := GetProcAddress2(HPMDWin, 'loadrhythmsample');
	setpcmdir := GetProcAddress2(HPMDWin, 'setpcmdir');
	setpcmrate := GetProcAddress2(HPMDWin, 'setpcmrate');
	setppzrate := GetProcAddress2(HPMDWin, 'setppzrate');
	setppsuse := GetProcAddress2(HPMDWin, 'setppsuse');
	setrhythmwithssgeffect := GetProcAddress2(HPMDWin, 'setrhythmwithssgeffect');
	setpmd86pcmmode := GetProcAddress2(HPMDWin, 'setpmd86pcmmode');
	getpmd86pcmmode := GetProcAddress2(HPMDWin, 'getpmd86pcmmode');
	music_load := GetProcAddress2(HPMDWin, 'music_load');
	music_load2 := GetProcAddress2(HPMDWin, 'music_load2');
	music_start := GetProcAddress2(HPMDWin, 'music_start');
	music_stop := GetProcAddress2(HPMDWin, 'music_stop');
	fadeout := GetProcAddress2(HPMDWin, 'fadeout');
	fadeout2 := GetProcAddress2(HPMDWin, 'fadeout2');
	getpcmdata := GetProcAddress2(HPMDWin, 'getpcmdata');
	setfmcalc55k := GetProcAddress2(HPMDWin, 'setfmcalc55k');
	setppsinterpolation := GetProcAddress2(HPMDWin, 'setppsinterpolation');
	setp86interpolation := GetProcAddress2(HPMDWin, 'setp86interpolation');
	setppzinterpolation := GetProcAddress2(HPMDWin, 'setppzinterpolation');
	getmemo := GetProcAddress2(HPMDWin, 'getmemo');
	getmemo2 := GetProcAddress2(HPMDWin, 'getmemo2');
	getmemo3 := GetProcAddress2(HPMDWin, 'getmemo3');
	fgetmemo := GetProcAddress2(HPMDWin, 'fgetmemo');
	fgetmemo2 := GetProcAddress2(HPMDWin, 'fgetmemo2');
	fgetmemo3 := GetProcAddress2(HPMDWin, 'fgetmemo3');
	getmusicfilename := GetProcAddress2(HPMDWin, 'getmusicfilename');
	getpcmfilename := GetProcAddress2(HPMDWin, 'getpcmfilename');
	getppcfilename := GetProcAddress2(HPMDWin, 'getppcfilename');
	getppsfilename := GetProcAddress2(HPMDWin, 'getppsfilename');
	getp86filename := GetProcAddress2(HPMDWin, 'getp86filename');
	getppzfilename := GetProcAddress2(HPMDWin, 'getppzfilename');
	ppc_load := GetProcAddress2(HPMDWin, 'ppc_load');
	pps_load := GetProcAddress2(HPMDWin, 'pps_load');
	p86_load := GetProcAddress2(HPMDWin, 'p86_load');
	ppz_load := GetProcAddress2(HPMDWin, 'ppz_load');
	maskon := GetProcAddress2(HPMDWin, 'maskon');
	maskoff := GetProcAddress2(HPMDWin, 'maskoff');
	setfmvoldown := GetProcAddress2(HPMDWin, 'setfmvoldown');
	setssgvoldown := GetProcAddress2(HPMDWin, 'setssgvoldown');
	setrhythmvoldown := GetProcAddress2(HPMDWin, 'setrhythmvoldown');
	setadpcmvoldown := GetProcAddress2(HPMDWin, 'setadpcmvoldown');
	setppzvoldown := GetProcAddress2(HPMDWin, 'setppzvoldown');
	getfmvoldown := GetProcAddress2(HPMDWin, 'getfmvoldown');
	getfmvoldown2 := GetProcAddress2(HPMDWin, 'getfmvoldown2');
	getssgvoldown := GetProcAddress2(HPMDWin, 'getssgvoldown');
	getssgvoldown2 := GetProcAddress2(HPMDWin, 'getssgvoldown2');
	getrhythmvoldown := GetProcAddress2(HPMDWin, 'getrhythmvoldown');
	getrhythmvoldown2 := GetProcAddress2(HPMDWin, 'getrhythmvoldown2');
	getadpcmvoldown := GetProcAddress2(HPMDWin, 'getadpcmvoldown');
	getadpcmvoldown2 := GetProcAddress2(HPMDWin, 'getadpcmvoldown2');
	getppzvoldown := GetProcAddress2(HPMDWin, 'getppzvoldown');
	getppzvoldown2 := GetProcAddress2(HPMDWin, 'getppzvoldown2');
	setpos := GetProcAddress2(HPMDWin, 'setpos');
	setpos2 := GetProcAddress2(HPMDWin, 'setpos2');
	getpos := GetProcAddress2(HPMDWin, 'getpos');
	getpos2 := GetProcAddress2(HPMDWin, 'getpos2');
	getlength := GetProcAddress2(HPMDWin, 'getlength');
	getlength2 := GetProcAddress2(HPMDWin, 'getlength2');
	getloopcount := GetProcAddress2(HPMDWin, 'getloopcount');
	setfmwait := GetProcAddress2(HPMDWin, 'setfmwait');
	setssgwait := GetProcAddress2(HPMDWin, 'setssgwait');
	setrhythmwait := GetProcAddress2(HPMDWin, 'setrhythmwait');
	setadpcmwait := GetProcAddress2(HPMDWin, 'setadpcmwait');
	getopenwork := GetProcAddress2(HPMDWin, 'getopenwork');
	getpartwork := GetProcAddress2(HPMDWin, 'getpartwork');

{$ENDIF}


//=============================================================================
// DLL �J��
//=============================================================================
finalization

{$IFDEF TESTCOMINTERFACE}
	{$IFDEF VER90}
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	// Delphi 2.0J
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		pPMDWIN.Release;
		pPMDWIN2.Release;
	{$ELSE}
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	// Delphi3 �ȍ~
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 		pPMDWIN := nil;
 		pPMDWIN2 := nil;

	{$ENDIF}
{$ENDIF}

	if(HPMDWin <> 0) then begin
		FreeLibrary(HPMDWin);
	end;

end.
