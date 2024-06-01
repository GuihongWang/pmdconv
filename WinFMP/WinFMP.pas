//============================================================================
//                        WinFMP.dll include file
//                      Copyright & Programmed by C60
//============================================================================
unit WinFMP;

interface

// COM ���C���^�[�t�F�C�X���e�X�g����ꍇ�ɗL���ɂ���
{$DEFINE TESTCOMINTERFACE}


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

	WINFMP_DLLNAME							= 'WinFMP.dll';
	WINFMP_MININTERFACEVERSION	= 010;		// Ver 0.10 �ȏ�
	WINFMP_MAXINTERFACEVERSION	= 100;		// Ver 1.00 ����
	WINFMP_MSG_DLLNOTFOUND			= WINFMP_DLLNAME + '��������܂���';
	WINFMP_MSG_DLLBROKEN				= WINFMP_DLLNAME + '���ُ�ł�';
	WINFMP_MSG_ERROR_LOWER			= 'Ver 0.10 �ȍ~�� WinFMP.dll ���g�p���Ă�������';
	WINFMP_MSG_ERORR_UPPER			= 'Ver 1.00 ������ WinFMP.dll ���g�p���Ă�������';
  WINFMP_MSG_COMNOTFOUND			= 'WinFMP �� COM �C���X�^���X���m�ۂł��܂���ł���';


	//--------------------------------------------------------------------------
	//	�o�[�W�������
	//--------------------------------------------------------------------------
	FMP_InterfaceVersion					= 018;		// WinFMP.dll �̃C���^�[�t�F�C�X�o�[�W����

	//--------------------------------------------------------------------------
	//	DLL �̖߂�l
	//--------------------------------------------------------------------------
	WINFMP_OK											=   0;		// ����I��
	FMP_ERR_OPEN_MUSIC_FILE				=   1;		// �� �f�[�^���J���Ȃ�����
	FMP_ERR_WRONG_MUSIC_FILE			=   2;		// PMD �̋ȃf�[�^�ł͂Ȃ�����
	FMP_ERR_OPEN_PVI_FILE			 	  =   3;		// PVI ���J���Ȃ�����
	FMP_ERR_OPEN_PPZ1_FILE			 	=   6;		// PPZ1 ���J���Ȃ�����
	FMP_ERR_WRONG_PVI_FILE		 		=   8;		// PVI �ł͂Ȃ�����
	FMP_ERR_WRONG_PPZ1_FILE			 	=  11;		// PVI �ł͂Ȃ�����(PPZ1)
	FMP_WARNING_PVI_ALREADY_LOAD	=  13;		// PVI �͂��łɓǂݍ��܂�Ă���
	FMP_WARNING_PPZ1_ALREADY_LOAD	=  16;		// PPZ1 �͂��łɓǂݍ��܂�Ă���

	FMP_ERR_WRONG_PARTNO			 		=  30;		// �p�[�g�ԍ����s�K
//	FMP_ERR_ALREADY_MASKED			 	=  31;		// �w��p�[�g�͂��łɃ}�X�N����Ă���
	FMP_ERR_NOT_MASKED				 		=  32;		// �w��p�[�g�̓}�X�N����Ă��Ȃ�
	FMP_ERR_MUSIC_STOPPED			 		=  33;		// �Ȃ��~�܂��Ă���̂Ƀ}�X�N���������

	FMP_ERR_OUT_OF_MEMORY			 		=  99;		// ������������Ȃ�

	//--------------------------------------------------------------------------
	//	�v�h�m�e�l�o��p�̒�`
	//--------------------------------------------------------------------------
	FMP_MAX_PCMDIR					 			=  64;
	
	//--------------------------------------------------------------------------
	//	���̑���`
	//--------------------------------------------------------------------------
	FMP_NumOfFMPart								=   6;
	FMP_NumOfSSGPart							=   3;
	FMP_NumOfADPCMPart						=   1;
	FMP_NumOFOPNARhythmPart				=   1;
	FMP_NumOfExtPart							=   3;
	FMP_NumOfPPZ8Part							=   8;
	FMP_NumOfAllPart							= (FMP_NumOfFMPart+FMP_NumOfSSGPart+FMP_NumOfADPCMPart+FMP_NumOFOPNARhythmPart+FMP_NumOfExtPart+FMP_NumOfPPZ8Part);

	FMP_MUSDATASIZE				  		= 65536;		// �ő�ȃf�[�^�T�C�Y
	FMP_COMMENTDATASIZE	 		   	=  8192;		// �ő�R�s�R�����g�T�C�Y

	//--------------------------------------------------------------------------
	//	�e�l�o�e���ԕێ�������
	//
	//            fedcba98 76543210
	// FMP_sysbit xxxxxxxx xxxxxxxx
	//            |||||||| |||||||+---�@
	//            |||||||| ||||||+----�@
	//            |||||||| |||||+-----�@
	//            |||||||| ||||+------�@�o�o�y�W�ło�u�h�G�~�����[�g��
	//            |||||||| |||+-------�@
	//            |||||||| ||+--------�@
	//            |||||||| |+---------�@�o�o�y�W���t��
	//            |||||||| +----------�@
	//            ||||||||
	//            |||||||+------------�@
	//            ||||||+-------------�@
	//            |||||+--------------�@
	//            ||||+---------------�@
	//            |||+----------------�@
	//            ||+-----------------�@�t�F�[�h�A�E�g��
	//            |+------------------�@���[�v����
	//            +-------------------�@���t��~��
	//
	//--------------------------------------------------------------------------
	FMP_SYS_PPZ8PVI							= $0008;	// �o�o�y�W�G�~�����[�g��
	FMP_SYS_PPZ8USE							= $0040;	// �o�o�y�W�t�@�C���g�p��
	FMP_SYS_FADE								= $2000;	// �t�F�[�h�A�E�g��
	FMP_SYS_LOOP								= $4000;	// ���[�v����
	FMP_SYS_STOP								= $8000;	// ���t��~��
	FMP_SYS_INIT								= FMP_SYS_STOP;

	//--------------------------------------------------------------------------
	//	�o�b�l��`�t���O
	//--------------------------------------------------------------------------
	FMP_PCM_USEV1								= $0001;	// �o�u�h�P�g�p��
	FMP_PCM_USEZ1								= $0010;	// �o�o�y�P�g�p��

	FMP_WLFO_SYNC								= $0080;	// �V���N���r�b�g
																				// ���ʂS�r�b�g���X���b�g�}�X�N


type
	//==========================================================================
	//	�k�e�n���[�N�\���̒�`
	//==========================================================================
	//--------------------------------------------------------------------------
	//	�r�u���[�g���[�N�\����
	//--------------------------------------------------------------------------
	PLFOS = ^TLFOS;
	TLFOS = record
		LfoSdelay					: Integer; // �r�u���[�g �f�B���C�l
		LfoSspeed					: Integer; // �r�u���[�g �X�s�[�h
		LfoScnt_dly				: Integer; // �r�u���[�g �f�B���C�J�E���^
		LfoScnt_spd				: Integer; // �r�u���[�g �X�s�[�h�J�E���^
		LfoSdepth					: Integer; // �r�u���[�g ���炵�J�E���g�l
		LfoScnt_dep				: Integer; // �r�u���[�g ���炵�J�E���^
		LfoSrate1					: Integer; // �r�u���[�g ������l
		LfoSrate2					: Integer; // �r�u���[�g ������l�i�T�u�j
		LfoSwave					: Integer; // �r�u���[�g �g�`
	end;

	//--------------------------------------------------------------------------
	//	�g���������[�N�\����
	//--------------------------------------------------------------------------
	PTALFOS = ^TALFOS;
	TALFOS = record
		AlfoSdelay				: Integer; // �g������ �f�B���C�l
		AlfoSspeed				: Integer; // �g������ �X�s�[�h
		AlfoScnt_dly			: Integer; // �g������ �f�B���C�J�E���^
		AlfoScnt_spd			: Integer; // �g������ �X�s�[�h
		AlfoSdepth				: Integer; // �g������ �ω���
		AlfoScnt_dep			: Integer; // �g������ �ω��ʃJ�E���^
		AlfoSrate					: Integer; // �g������ ������l
		AlfoSrate_org			: Integer; // �g������ ������l
	end;

	//--------------------------------------------------------------------------
	//	���E���E���[�N�\����
	//--------------------------------------------------------------------------
	PWLFOS = ^TWLFOS;
	TWLFOS = record
		WlfoSdelay				: Integer; // ���E���E �f�B���C�l
		WlfoSspeed				: Integer; // ���E���E �X�s�[�h
		WlfoScnt_dly			: Integer; // ���E���E �f�B���C�J�E���^
		WlfoScnt_spd			: Integer; // ���E���E �X�s�[�h�J�E���^
		WlfoSdepth				: Integer; // ���E���E �ω���
		WlfoScnt_dep			: Integer; // ���E���E �ω��ʃJ�E���^
		WlfoSrate					: Integer; // ���E���E ������l
		WlfoSrate_org			: Integer; // ���E���E ���݂̂��炵�l
		WlfoSrate_now			: Integer; // ���E���E ���݂̂��炵�l
		WlfoSsync					: Integer; // ���E���E �V���N���^�}�X�N
	end;

	//==========================================================================
	//	�s�b�`�x���h���[�N�\���̒�`
	//==========================================================================
	PPITS = ^TPITS;
	TPITS = record
		PitSdat						: Integer; // �s�b�`�x���h�ω��l
		PitSdelay					: Integer; // �f�B���C�l
		PitSspeed					: Integer; // �X�s�[�h
		PitScnt						: Integer; // �X�s�[�h�J�E���^
		PitSwave					: Integer; // �ڕW���g��
		PitStarget				: Integer; // �ڕW���K
	end;

	//--------------------------------------------------------------------------
	//	�r�r�f�G���x���[�v���[�N�\����
	//--------------------------------------------------------------------------
	PENVS = ^TENVS;
	TENVS = record
		EnvSsv						: Integer; // �X�^�[�g���H���[��
		EnvSar						: Integer; // �A�^�b�N���[�g
		EnvSdr						: Integer; // �f�B�P�C���[�g
		EnvSsl						: Integer; // �T�X�e�B�����x��
		EnvSsr						: Integer; // �T�X�e�B�����[�g
		EnvSrr						: Integer; // �����[�X���[�g
	end;

	//==========================================================================
	//	�p�[�g���[�N�\���̒�`
	//==========================================================================
	PCPATS  = ^TCPATS;
	TCPATS = record
		PartSlfo_f				: Integer; // �k�e�n��ԃt���O
		PartSdeflen				: Integer; // �f�t�H���g�̉���

		PartSvol					: Integer; // ���݂̉���
		PartSdat_q				: Integer; // �Q�[�g������r�l
		
		PartScnt					: Integer; // ������J�E���^
		PartSorg_q				: Integer; // �Q�[�g�����p�J�E���^
		
		PartStmpvol				: Integer; // ���ۂ̏o�͉���
		PartSdat_k				: Integer; // �j����������x�点��l
		
		PartScnt_k				: Integer; // �j���������x�点�����p�J�E���^
		PartSbefore				: Integer; // �P�O�̉���
		
		PartSstatus				: Integer; // ��ԃt���O
		PartSsync					: Integer; // �V���N���t���O
		
		PartSdetune				: Integer; // �f�`���[���l
		
		PartSpitch				: TPITS;   // �s�b�`�x���h�p���[�N
		PartSlfo					: Array[0..3-1] of TLFOS;
												         // �r�u���[�g�k�e�n�i���O�C���P�C���Q�j
		PartSwave					: Integer; // ���ۂ̏o�͎��g��
	
		PartSwave2				: Integer; // �P�O�̏o�͎��g��

		PartSxtrns				: Integer; // ���K�̂���p
		PartStone					: Integer; // ���݂̉��F�ԍ�

		PartSkeyon				: Integer; // �O���j���������擾�p

		PartSpan					: Integer; // �p���擾�p
		PartSalg					: Integer; // ���݂̃A���S���Y���ԍ�

		PartSio						: Integer; // �o�͂h�^�n�A�h���X
		PartSpoint				: Pointer; // �ǂݍ��݃|�C���^
		PartSloop					: Pointer; // ����Ԃ��|�C���^
		PartSchan					: Integer; // �`�����l�����ʗp
		PartSbit					: Integer; // �`�����l������bit
		PartSport					: Integer; // �e�l���A�h���X�A�N�Z�X�p

	end;

	//--------------------------------------------------------------------------
	//	�e�l�p�[�g���[�N�\����
	//--------------------------------------------------------------------------
	PFPATS = ^TFPATS;
	TFPATS = record
		FpatSaddr					: Pointer; // �s�k�A�h���X
		FpatSalfo					: TALFOS;  // �g�������p���[�N
		FpatSwlfo					: TWLFOS;  // ���E���E�p���[�N
		FpatS_hdly				: Integer; // �g�k�e�n�f�B���C
		FpatS_hdlycnt			: Integer; // �g�k�e�n�J�E���^
		FpatS_hfreq				: Integer; // �g�k�e�n�@��������
		FpatS_hapms				: Integer; // �g�k�e�n�@�o�l�r�^�`�l�r
		FpatSextend				: Integer; // extend���[�h
		FpatSslot_v				: Array[0..4-1] of Integer; // �X���b�g���Ƃ̑��Βl
	end;

	//--------------------------------------------------------------------------
	//	�r�r�f�p�[�g���[�N�\����
	//--------------------------------------------------------------------------
	PSPATS = ^TSPATS;
	TSPATS = record
		SpatSnow_vol			: Integer; // ���݂̉���
		SpatSflg					: Integer; // �G�����F���[�v��ԃt���O
		SpatSoct					: Integer; // �I�N�^�[�u
		SpatSvol					: Integer; // ���݂̏o�͉���
		SpatSenv					: TENVS;   // �\�t�g�E�F�A�G���x���[�v
		SpatSenvadr				: PENVS;   // SSG Env pattern Address
	end;

	//--------------------------------------------------------------------------
	//	�`�c�o�b�l�p�[�g���[�N�\����
	//--------------------------------------------------------------------------
	PAPATS = ^TAPATS;
	TAPATS = record
		ApatSstart				: Integer; // �o�b�l �X�^�[�g�A�h���X
		ApatSend					: Integer; // �o�b�l �G���h�A�h���X
		ApatSdelta				: Integer; // �o�b�l ���m�l
	end;

	//--------------------------------------------------------------------------
	//	�p�[�g���[�N�\����
	//--------------------------------------------------------------------------
	PPARTS = ^TPARTS;
	TPARTS = record
		CPatS							: TCPATS;  // ���ʃ��[�N
		case Integer of
			0: (
				FPatS		 			: TFPATS;  // �e�l�p�[�g���[�N�\����
			);
			1: (
				SPatS		 			: TSPATS;  // �r�r�f�p�[�g���[�N�\����
			);
			2: (
				APatS		 			: TAPATS;  // �`�c�o�b�l�p�[�g���[�N�\����
			);
	end;

	//--------------------------------------------------------------------------
	//	�t�F�[�h�A�E�g�f�[�^�\����
	//--------------------------------------------------------------------------
	PFADES = ^TFADES;
	TFADES = record
		FadeSfm						: Integer;
		FadeSssg					: Integer;
		FadeSrhy					: Integer;
		FadeSapcm					: Integer;
	end;

	//--------------------------------------------------------------------------
	//	�O���������[�N�\����
	//--------------------------------------------------------------------------
	PSYNCS = ^TSYNCS;
	TSYNCS = record
		SyncSdat					: Integer; // �����f�[�^
		SyncScnt					: Integer; // �����J�E���g
	end;

	//--------------------------------------------------------------------------
	//	�e�l�o�������[�N�\����
	//--------------------------------------------------------------------------
	PFMPS = ^TFMPS;
	TFMPS = record
		FmpStempo					: Integer; // 00 ���݂̃e���|
		FmpSsync					: TSYNCS;  // 01 �O�������f�[�^
		FmpSsysbit				: Integer; // 0a �e�l�o�X�e�[�^�X������
		FmpScnt_c					: Integer; // 0c �ȉ��t���N���b�N
		FmpScnt_t					: Integer; // 0e �҂��J�E���^
		FmpSfade					: TFADES;  // 0f �t�F�[�h�A�E�g����
		FmpSfade_o				: TFADES;  // 13 �t�F�[�h�A�E�g���ʁi�I���W�i���j
		FmpSloop_c				: Integer; // 14 �ȃ��[�v��
		FmpStempo_t				: Integer; // 17 ���݂̃e���|�i�\���j
		FmpSmix_s					: Integer; // 18 ??FEDFED
		FmpStimer					: Integer; // 19 �^�C�}�[���[�h�l
		FmpSnoise					: Integer; // 1a �r�r�f�̃m�C�Y���g��
		FmpSsho						: Integer; // 1b ���߃J�E���^
		FmpSpcmuse				: Integer; // 1d �o�b�l�g�p��
		FmpScnt_ct				: Integer; // 1f �ȑS�̃J�E���g��
		FmpScnt_cl				: Integer; // 23 �ȃ��[�v�J�E���g��
		FmpSmix_e					: Integer; // 29 ���ʉ���������mixer
		FmpStempo_e				: Integer; // 2a ���ʉ����̃f�t�H���g�e���|
	end;

	//--------------------------------------------------------------------------
	//	�S�̃��[�N
	//--------------------------------------------------------------------------
	PWORKS = ^TWORKS;
	TWORKS = record
		ExtBuff						: TFMPS;   // �O���Q�Ƌ����[�N
		_F : Array[0..FMP_NumOfFMPart  -1] of TPARTS; // �e�l�������[�N
		_A																	: TPARTS; // �`�c�o�b�l�������[�N
		_X : Array[0..FMP_NumOfExtPart -1] of TPARTS; // �e�lextend���[�N
		_P : Array[0..FMP_NumOfPPZ8Part-1] of TPARTS; // �o�b�l(ppz8)�������[�N
		_S : Array[0..FMP_NumOfSSGPart -1] of TPARTS; // �r�r�f�������[�N

		//------------------------------------------------------------------------
		//	���Y�����������[�N
		//------------------------------------------------------------------------
		R_key							: Array[0..16-1] of Integer; // ��΂ɕς����Ȃ�
		R_mask						: Integer;
		R_Oncho_cnt				: Integer;
		R_Oncho_def				: Integer;
		RTL_vol						: Integer;
		R_vol							: Array[0..6-1] of Integer;
		R_pan							: Array[0..6-1] of Integer;
		R_Loop_now				: Integer;
		R_Sync_flg				: Integer;
		R_State_flg				: Integer; // �C�l�[�u���t���O
		_R								: TPARTS;

		//------------------------------------------------------------------------
		//	���������f�[�^���[�N
		//------------------------------------------------------------------------
		TotalLoop					: Integer; // ���[�v�I���J�E���^
		Loop_cnt					: Integer; // ���[�v�I����
		Int_fcT						: Integer; // ���荞�݃t�F�[�h�J�E���^
		Int_fc						: Integer; // ���荞�݃t�F�[�h�J�E���^
		TimerA_cnt				: Integer; // �s���������f�B���C
		Ver								: Integer; // �ȃf�[�^�o�[�W����
		NowPPZmode				: Integer; // ���݂̂o�o�y�̍Đ����[�h
		MusicClockCnt			: Integer; // �Ȃ̃N���b�N�J�E���g(C??)
		ClockCnt					: Integer; // �N���b�N�J�E���g
		PcmHardVol				: Integer; // �o�b�l�n�[�h����
		ExtendKeyon				: Integer; // extend��Ԃ�3ch��keyon
		ExtendAlg					: Integer; // extend�`�����l���̃A���S���Y��

		//------------------------------------------------------------------------
		//	���������f�[�^���[�N
		//------------------------------------------------------------------------
		FM_effect_dat : Array[0..4-1] of Integer;		// ���ʉ����[�h���炵�l
		Play_flg					: Integer; // ���t���t���O
		Loop_flg					: Integer; // ���[�v�t���O
		Int_CX						: Integer; // ���荞�݃t�F�[�h�J�E���^

		//------------------------------------------------------------------------
		//	�`�����l���ʃ��[�N�A�h���X�e�[�u��
		//------------------------------------------------------------------------
		Chan_tbl_R				: PPARTS;  // ���Y��
		Chan_tbl : Array[0..FMP_NumOfFMPart+FMP_NumOfSSGPart+FMP_NumOfPPZ8Part+1+FMP_NumOfExtPart+1-1] of PPARTS;

		//------------------------------------------------------------------------
		//	�r�r�f�G���x���[�v���[�N
		//------------------------------------------------------------------------
		EnvAddr : Array[0..FMP_NumOfSSGPart - 1] of TENVS;

		//------------------------------------------------------------------------
		//	���t���̋Ȃ̃t�@�C����
		//------------------------------------------------------------------------
		Music_name : Array[0.._MAX_PATH-1] of Char;	// ���t���̋Ȃ̃t�@�C����

		//------------------------------------------------------------------------
		//	���݂̂o�u�h�t�@�C����
		//------------------------------------------------------------------------
		PVI_name : Array[0.._MAX_PATH-1] of Char;   // ���݂̂o�b�l�t�@�C����

		//------------------------------------------------------------------------
		//	�v�h�m�e�l�o��p�f�[�^
		//------------------------------------------------------------------------
		rate							: Integer; //	PCM �o�͎��g��(11k, 22k, 44k, 55k)
		ppz8ip						: Boolean; // PPZ8 �ŕ⊮���邩
		fadeout2_speed		: Integer; // fadeout(������)speed(>0�� fadeout)
		lastSyncExtTime		: Integer; // �Ō�� Sync_Ext �����s��������(ms/�J���I�P�p�j
		pcmdir : Array[0..FMP_MAX_PCMDIR+1-1, 0.._MAX_PATH-1] of char;	//	PCM �����f�B���N�g��
	end;


	//--------------------------------------------------------------------------
	//	�S�̃��[�N�i�|�t�@�C�����������j
	//--------------------------------------------------------------------------
	PWORKS2 = ^TWORKS2;
	TWORKS2 = record
		ExtBuff						: TFMPS;   // �O���Q�Ƌ����[�N
		_F : Array[0..FMP_NumOfFMPart  -1] of TPARTS; // �e�l�������[�N
		_A																	: TPARTS; // �`�c�o�b�l�������[�N
		_X : Array[0..FMP_NumOfExtPart -1] of TPARTS; // �e�lextend���[�N
		_P : Array[0..FMP_NumOfPPZ8Part-1] of TPARTS; // �o�b�l(ppz8)�������[�N
		_S : Array[0..FMP_NumOfSSGPart -1] of TPARTS; // �r�r�f�������[�N

		//------------------------------------------------------------------------
		//	���Y�����������[�N
		//------------------------------------------------------------------------
		R_key							: Array[0..16-1] of Integer; // ��΂ɕς����Ȃ�
		R_mask						: Integer;
		R_Oncho_cnt				: Integer;
		R_Oncho_def				: Integer;
		RTL_vol						: Integer;
		R_vol							: Array[0..6-1] of Integer;
		R_pan							: Array[0..6-1] of Integer;
		R_Loop_now				: Integer;
		R_Sync_flg				: Integer;
		R_State_flg				: Integer; // �C�l�[�u���t���O
		_R								: TPARTS;

		//------------------------------------------------------------------------
		//	���������f�[�^���[�N
		//------------------------------------------------------------------------
		TotalLoop					: Integer; // ���[�v�I���J�E���^
		Loop_cnt					: Integer; // ���[�v�I����
		Int_fcT						: Integer; // ���荞�݃t�F�[�h�J�E���^
		Int_fc						: Integer; // ���荞�݃t�F�[�h�J�E���^
		TimerA_cnt				: Integer; // �s���������f�B���C
		Ver								: Integer; // �ȃf�[�^�o�[�W����
		NowPPZmode				: Integer; // ���݂̂o�o�y�̍Đ����[�h
		MusicClockCnt			: Integer; // �Ȃ̃N���b�N�J�E���g(C??)
		ClockCnt					: Integer; // �N���b�N�J�E���g
		PcmHardVol				: Integer; // �o�b�l�n�[�h����
		ExtendKeyon				: Integer; // extend��Ԃ�3ch��keyon
		ExtendAlg					: Integer; // extend�`�����l���̃A���S���Y��

		//------------------------------------------------------------------------
		//	���������f�[�^���[�N
		//------------------------------------------------------------------------
		FM_effect_dat : Array[0..4-1] of Integer;		// ���ʉ����[�h���炵�l
		Play_flg					: Integer; // ���t���t���O
		Loop_flg					: Integer; // ���[�v�t���O
		Int_CX						: Integer; // ���荞�݃t�F�[�h�J�E���^

		//------------------------------------------------------------------------
		//	�`�����l���ʃ��[�N�A�h���X�e�[�u��
		//------------------------------------------------------------------------
		Chan_tbl_R				: PPARTS;  // ���Y��
		Chan_tbl : Array[0..FMP_NumOfFMPart+FMP_NumOfSSGPart+FMP_NumOfPPZ8Part+1+FMP_NumOfExtPart+1-1] of PPARTS;
	end;

	//--------------------------------------------------------------------------
	//	�R�s�R�����g�|�C���^���[�N
	//--------------------------------------------------------------------------
	PComment = ^TComment;
	TComment = Array[0..3-1] of PChar;


{$IFDEF VER90}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delphi 2.0J
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	//===========================================================================
	// IWINFMP : WINFMP �� Interface Class
	//===========================================================================
	IWINFMP = class(IFMPMD)
		function maskon(rhythm_flag : Boolean; ah : Integer) : Integer; virtual; stdcall; abstract;
		function maskoff(rhythm_flag : Boolean; ah : Integer) : Integer; virtual; stdcall; abstract;
		procedure setfmvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setssgvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setrhythmvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setadpcmvoldown(voldown : Integer); virtual; stdcall; abstract;
		procedure setppzvoldown(voldown : Integer); virtual; stdcall; abstract;
		function getfmvoldown : Integer; virtual; stdcall; abstract;
		function getssgvoldown : Integer; virtual; stdcall; abstract;
		function getrhythmvoldown : Integer; virtual; stdcall; abstract;
		function getadpcmvoldown : Integer; virtual; stdcall; abstract;
		function getppzvoldown : Integer; virtual; stdcall; abstract;
		function getcomment(dest : PChar; musdata : Pointer; size : Integer) : PChar; virtual; stdcall; abstract;
		function getcomment2(dest : PChar; musdata : Pointer; size : Integer) : PChar; virtual; stdcall; abstract;
		function getcomment3(dest : TComment; musdata : Pointer; size : Integer) : PComment; virtual; stdcall; abstract;
		function fgetcomment(dest : PChar; filename : PChar) : Integer; virtual; stdcall; abstract;
		function fgetcomment2(dest : PChar; filename : PChar)  : Integer; virtual; stdcall; abstract;
		function fgetcomment3(dest : TComment; filename : PChar)  : Integer; virtual; stdcall; abstract;
		function getdefinedpcmfilename(dest : PChar; musdata : Pointer; size : Integer) : PChar; virtual; stdcall; abstract;
		function getdefinedppzfilename(dest : PChar; musdata : Pointer; size : Integer; bufnum : Integer) : PChar; virtual; stdcall; abstract;
		function fgetdefinedpcmfilename(dest : PChar; filename : PChar) : Integer; virtual; stdcall; abstract;
		function fgetdefinedppzfilename(dest : PChar; filename : PChar; bufnum : Integer) : Integer; virtual; stdcall; abstract;
		function getsyncscnt : Integer; virtual; stdcall; abstract;
		function getlastsyncexttime : Integer; virtual; stdcall; abstract;
		function getworks : PWORKS; virtual; stdcall; abstract;
		procedure setadpcmppz8emulate(flag : Boolean); virtual; stdcall; abstract;
    function querypdzfz8xinterface(const riid: TIID; var ppv): HResult; virtual; stdcall; abstract;
	end;


{$ELSE}
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delphi3 �ȍ~
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	//===========================================================================
	// IWINFMP : WINFMP �� Interface Class
	//===========================================================================
	IWINFMP = interface(IFMPMD)
		['{B7910277-0295-4052-9A65-5AD48D0F3477}']
		function maskon(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
		function maskoff(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
		procedure setfmvoldown(voldown : Integer); stdcall;
		procedure setssgvoldown(voldown : Integer); stdcall;
		procedure setrhythmvoldown(voldown : Integer); stdcall;
		procedure setadpcmvoldown(voldown : Integer); stdcall;
		procedure setppzvoldown(voldown : Integer); stdcall;
		function getfmvoldown : Integer; stdcall;
		function getssgvoldown : Integer; stdcall;
		function getrhythmvoldown : Integer; stdcall;
		function getadpcmvoldown : Integer; stdcall;
		function getppzvoldown : Integer; stdcall;
		function getcomment(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
		function getcomment2(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
		function getcomment3(dest : TComment; musdata : Pointer; size : Integer) : PComment; stdcall;
		function fgetcomment(dest : PChar; filename : PChar) : Integer; stdcall;
		function fgetcomment2(dest : PChar; filename : PChar)  : Integer; stdcall;
		function fgetcomment3(dest : TComment; filename : PChar)  : Integer; stdcall;
		function getdefinedpcmfilename(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
		function getdefinedppzfilename(dest : PChar; musdata : Pointer; size : Integer; bufnum : Integer) : PChar; stdcall;
		function fgetdefinedpcmfilename(dest : PChar; filename : PChar) : Integer; stdcall;
		function fgetdefinedppzfilename(dest : PChar; filename : PChar; bufnum : Integer) : Integer; stdcall;
		function getsyncscnt : Integer; stdcall;
		function getlastsyncexttime : Integer; stdcall;
		function getworks : PWORKS; stdcall;
		procedure setadpcmppz8emulate(flag : Boolean); stdcall;
    function querypdzfz8xinterface(const riid: TIID; var ppv): HResult; stdcall;
	end;

{$ENDIF}


//=============================================================================
// Interface ID(IID) & Class ID(CLSID)
//=============================================================================
const
	// GUID of IWINFMP Interface ID
	IID_IWINFMP : TIID =
		(D1:$B7910277; D2:$0295; D3:$4052; D4:($9A,$65,$5A,$D4,$8D,$0F,$34,$77));

	// GUID of WINFMP Class ID
	CLSID_WINFMP : TCLSID =
		(D1:$3E7816B4; D2:$EB8F; D3:$435F; D4:($BC,$37,$01,$CE,$DB,$F4,$22,$87));



//=============================================================================
// DLL Interface
//=============================================================================
var
	HWinFMP : HMODULE;
{$IFDEF TESTCOMINTERFACE}
	pWinFMP  : IWINFMP;
	pWinFMP2 : IWINFMP;
{$ENDIF}
	
	fmp_getversion : function : Integer; stdcall;
	fmp_getinterfaceversion : function : Integer; stdcall;
	fmp_CoCreateInstance : function(const rclsid: TCLSID; pUnkOuter: IUnknown;
		dwClsContext: Longint; const riid: TIID; var ppv): HResult; stdcall;

{$IFDEF TESTCOMINTERFACE}
	function fmp_init(path : PChar) : Boolean; stdcall;
	function fmp_load(filename : PChar) : Integer; stdcall;
	function fmp_load2(musdata : Pointer; size : Integer) : Integer; stdcall;
	procedure fmp_start; stdcall;
	procedure fmp_stop; stdcall;
	procedure fmp_getpcmdata(buf : PSmallInt; nsamples : Integer); stdcall;
	function fmp_maskon(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
	function fmp_maskoff(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
	function fmp_loadrhythmsample(path : PChar) : Boolean; stdcall;
	function fmp_setpcmdir(pcmdir : PChar) : Boolean ; stdcall;
	procedure fmp_setpcmrate(rate : Integer); stdcall;
	procedure fmp_setppzrate(rate : Integer); stdcall;
	procedure fmp_fadeout(speed : Integer); stdcall;
	procedure fmp_fadeout2(speed : Integer); stdcall;
	procedure fmp_setfmcalc55k(flag : Boolean); stdcall;
	procedure fmp_setppzinterpolation(ip : Boolean); stdcall;
	procedure fmp_setadpcmppz8emulate(flag : Boolean); stdcall;
	function fmp_getcomment(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
	function fmp_getcomment2(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
	function fmp_getcomment3(dest : TComment; musdata : Pointer; size : Integer) : PComment; stdcall;
	function fmp_fgetcomment(dest : PChar; filename : PChar) : Integer; stdcall;
	function fmp_fgetcomment2(dest : PChar; filename : PChar) : Integer; stdcall;
	function fmp_fgetcomment3(dest : TComment; filename : PChar) : Integer; stdcall;
	function fmp_getdefinedpcmfilename(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
	function fmp_getdefinedppzfilename(dest : PChar; musdata : Pointer; size : Integer; bufnum : Integer) : PChar; stdcall;
	function fmp_fgetdefinedpcmfilename(dest : PChar; filename : PChar) : Integer; stdcall;
	function fmp_fgetdefinedppzfilename(dest : PChar; filename : PChar; bufnum : Integer) : Integer; stdcall;
	function fmp_getmusicfilename(dest : PChar) : PChar; stdcall;
	function fmp_getpcmfilename(dest : PChar) : PChar; stdcall;
	function fmp_getppzfilename(dest : PChar; bufnum : Integer) : PChar; stdcall;
	procedure fmp_setfmvoldown(voldown : Integer); stdcall;
	procedure fmp_setssgvoldown(voldown : Integer); stdcall;
	procedure fmp_setrhythmvoldown(voldown : Integer); stdcall;
	procedure fmp_setadpcmvoldown(voldown : Integer); stdcall;
	procedure fmp_setppzvoldown(voldown : Integer); stdcall;
	function fmp_getfmvoldown : Integer; stdcall;
	function fmp_getssgvoldown : Integer; stdcall;
	function fmp_getrhythmvoldown : Integer; stdcall;
	function fmp_getadpcmvoldown : Integer; stdcall;
	function fmp_getppzvoldown : Integer; stdcall;
	procedure fmp_setpos(pos : Integer); stdcall;
	procedure fmp_setpos2(pos : Integer); stdcall;
	function fmp_getpos : Integer; stdcall;
	function fmp_getpos2 : Integer; stdcall;
	function fmp_getlength(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	function fmp_getlength2(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	function fmp_getloopcount : Integer; stdcall;
	procedure fmp_setfmwait(nsec : Integer); stdcall;
	procedure fmp_setssgwait(nsec : Integer); stdcall;
	procedure fmp_setrhythmwait(nsec : Integer); stdcall;
	procedure fmp_setadpcmwait(nsec : Integer); stdcall;
	function fmp_getsyncscnt : Integer; stdcall;
	function fmp_getlastsyncexttime : Integer; stdcall;
	function fmp_getworks : PWORKS; stdcall;
  function fmp_querypdzfz8xinterface(const riid: TIID; var ppv): HResult; stdcall;


{$ELSE}
	fmp_init : function(path : PChar) : Boolean; stdcall;
	fmp_load : function(filename : PChar) : Integer; stdcall;
	fmp_load2 : function(musdata : Pointer; size : Integer) : Integer; stdcall;
	fmp_start : procedure; stdcall;
	fmp_stop : procedure; stdcall;
	fmp_getpcmdata : procedure(buf : PSmallInt; nsamples : Integer); stdcall;
	fmp_maskon : function(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
	fmp_maskoff : function(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
	fmp_loadrhythmsample : function(path : PChar) : Boolean; stdcall;
	fmp_setpcmdir : function(pcmdir : PChar) : Boolean ; stdcall;
	fmp_setpcmrate : procedure(rate : Integer); stdcall;
	fmp_setppzrate : procedure(rate : Integer); stdcall;
	fmp_fadeout : procedure(speed : Integer); stdcall;
	fmp_fadeout2 : procedure(speed : Integer); stdcall;
	fmp_setfmcalc55k : procedure(flag : Boolean); stdcall;
	fmp_setppzinterpolation : procedure(ip : Boolean); stdcall;
	fmp_setadpcmppz8emulate : procedure(flag : Boolean); stdcall;
	fmp_getcomment : function(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
	fmp_getcomment2 : function(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
	fmp_getcomment3 : function(dest : TComment; musdata : Pointer; size : Integer) : PComment; stdcall;
	fmp_fgetcomment : function(dest : PChar; filename : PChar) : Integer; stdcall;
	fmp_fgetcomment2 : function(dest : PChar; filename : PChar) : Integer; stdcall;
	fmp_fgetcomment3 : function(dest : TComment; filename : PChar) : Integer; stdcall;
	fmp_getdefinedpcmfilename : function(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
	fmp_getdefinedppzfilename : function(dest : PChar; musdata : Pointer; size : Integer; bufnum : Integer) : PChar; stdcall;
	fmp_fgetdefinedpcmfilename : function(dest : PChar; filename : PChar) : Integer; stdcall;
	fmp_fgetdefinedppzfilename : function(dest : PChar; filename : PChar; bufnum : Integer) : Integer; stdcall;
	fmp_getmusicfilename : function(dest : PChar) : PChar; stdcall;
	fmp_getpcmfilename : function(dest : PChar) : PChar; stdcall;
	fmp_getppzfilename : function(dest : PChar; bufnum : Integer) : PChar; stdcall;
	fmp_setfmvoldown : procedure(voldown : Integer); stdcall;
	fmp_setssgvoldown : procedure(voldown : Integer); stdcall;
	fmp_setrhythmvoldown : procedure(voldown : Integer); stdcall;
	fmp_setadpcmvoldown : procedure(voldown : Integer); stdcall;
	fmp_setppzvoldown : procedure(voldown : Integer); stdcall;
	fmp_getfmvoldown : function : Integer; stdcall;
	fmp_getssgvoldown : function : Integer; stdcall;
	fmp_getrhythmvoldown : function : Integer; stdcall;
	fmp_getadpcmvoldown : function : Integer; stdcall;
	fmp_getppzvoldown : function : Integer; stdcall;
	fmp_setpos : procedure(pos : Integer); stdcall;
	fmp_setpos2 : procedure(pos : Integer); stdcall;
	fmp_getpos : function : Integer; stdcall;
	fmp_getpos2 : function : Integer; stdcall;
	fmp_getlength : function(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	fmp_getlength2 : function(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
	fmp_getloopcount : function : Integer; stdcall;
	fmp_setfmwait : procedure(nsec : Integer); stdcall;
	fmp_setssgwait : procedure(nsec : Integer); stdcall;
	fmp_setrhythmwait : procedure(nsec : Integer); stdcall;
	fmp_setadpcmwait : procedure(nsec : Integer); stdcall;
	fmp_getsyncscnt : function : Integer; stdcall;
	fmp_getlastsyncexttime : function : Integer; stdcall;
	fmp_getworks : function : PWORKS; stdcall;
  fmp_querypdzfz8xinterface : function(const riid: TIID; var ppv): HResult; stdcall;
{$ENDIF}


implementation

//----------------------------------------------------------------------------
// �֐��A�h���X���擾�ł��Ȃ��Ƌ����I��
//----------------------------------------------------------------------------
function GetProcAddress2(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall;
begin
	Result := GetProcAddress(hModule, lpProcName);
	if(result = nil) then begin
		ShowMessage(WINFMP_MSG_DLLBROKEN);
		Halt;
	end;
end;


{$IFDEF TESTCOMINTERFACE}
//----------------------------------------------------------------------------
// �֐��� COM���C���^�[�t�F�C�X�Ăяo���ɕϊ����邾���̊֐��Q
//----------------------------------------------------------------------------
function fmp_init(path : PChar) : Boolean; stdcall;
begin
	pWINFMP2.init(path);
	Result := pWINFMP.init(path);

(*
	pWINFMP2.setfmwait(0);				// �Ȓ��v�Z�������̂���
	pWINFMP2.setssgwait(0);				// �Ȓ��v�Z�������̂���
	pWINFMP2.setrhythmwait(0);		// �Ȓ��v�Z�������̂���
	pWINFMP2.setadpcmwait(0);			// �Ȓ��v�Z�������̂���
*)
end;


function fmp_load(filename : PChar) : Integer; stdcall;
begin
	Result := pWINFMP.music_load(filename);
end;


function fmp_load2(musdata : Pointer; size : Integer) : Integer; stdcall;
begin
	Result := pWINFMP.music_load2(musdata, size);
end;


procedure fmp_start; stdcall;
begin
	pWINFMP.music_start;
end;


procedure fmp_stop; stdcall;
begin
	pWINFMP.music_stop;
end;


procedure fmp_getpcmdata(buf : PSmallInt; nsamples : Integer); stdcall;
begin
	pWINFMP.getpcmdata(buf, nsamples);
end;


function fmp_maskon(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
begin
	Result := pWINFMP.maskon(rhythm_flag, ah);
end;


function fmp_maskoff(rhythm_flag : Boolean; ah : Integer) : Integer; stdcall;
begin
	Result := pWINFMP.maskoff(rhythm_flag, ah);
end;


function fmp_loadrhythmsample(path : PChar) : Boolean; stdcall;
begin
	Result := pWINFMP.loadrhythmsample(path);
end;


function fmp_setpcmdir(pcmdir : PChar) : Boolean ; stdcall;
begin
	Result := pWINFMP.setpcmdir(pcmdir);
end;


procedure fmp_setpcmrate(rate : Integer); stdcall;
begin
	pWINFMP.setpcmrate(rate);
end;


procedure fmp_setppzrate(rate : Integer); stdcall;
begin
	pWINFMP.setppzrate(rate);
end;


procedure fmp_fadeout(speed : Integer); stdcall;
begin
	pWINFMP.fadeout(speed);
end;


procedure fmp_fadeout2(speed : Integer); stdcall;
begin
	pWINFMP.fadeout2(speed);
end;


procedure fmp_setfmcalc55k(flag : Boolean); stdcall;
begin
	pWINFMP.setfmcalc55k(flag);
end;


procedure fmp_setppzinterpolation(ip : Boolean); stdcall;
begin
	pWINFMP.setppzinterpolation(ip);
end;


procedure fmp_setadpcmppz8emulate(flag : Boolean); stdcall;
begin
	pWINFMP.setadpcmppz8emulate(flag);
end;


function fmp_getcomment(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
begin
	Result := pWINFMP.getcomment(dest, musdata, size);
end;


function fmp_getcomment2(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
begin
	Result := pWINFMP.getcomment2(dest, musdata, size);
end;


function fmp_getcomment3(dest : TComment; musdata : Pointer; size : Integer) : PComment; stdcall;
begin
	Result := pWINFMP.getcomment3(dest, musdata, size);
end;


function fmp_fgetcomment(dest : PChar; filename : PChar) : Integer; stdcall;
begin
	Result := pWINFMP.fgetcomment(dest, filename);
end;


function fmp_fgetcomment2(dest : PChar; filename : PChar) : Integer; stdcall;
begin
	Result := pWINFMP.fgetcomment2(dest, filename);
end;


function fmp_fgetcomment3(dest : TComment; filename : PChar) : Integer; stdcall;
begin
	Result := pWINFMP.fgetcomment3(dest, filename);
end;


function fmp_getdefinedpcmfilename(dest : PChar; musdata : Pointer; size : Integer) : PChar; stdcall;
begin
	Result := pWINFMP.getdefinedpcmfilename(dest, musdata, size);
end;


function fmp_getdefinedppzfilename(dest : PChar; musdata : Pointer; size : Integer; bufnum : Integer) : PChar; stdcall;
begin
	Result := pWINFMP.getdefinedppzfilename(dest, musdata, size, bufnum);
end;


function fmp_fgetdefinedpcmfilename(dest : PChar; filename : PChar) : Integer; stdcall;
begin
	Result := pWINFMP.fgetdefinedpcmfilename(dest, filename);
end;


function fmp_fgetdefinedppzfilename(dest : PChar; filename : PChar; bufnum : Integer) : Integer; stdcall;
begin
	Result := pWINFMP.fgetdefinedppzfilename(dest, filename, bufnum);
end;


function fmp_getmusicfilename(dest : PChar) : PChar; stdcall;
begin
	Result := pWINFMP.getmusicfilename(dest);
end;


function fmp_getpcmfilename(dest : PChar) : PChar; stdcall;
begin
	Result := pWINFMP.getpcmfilename(dest);
end;


function fmp_getppzfilename(dest : PChar; bufnum : Integer) : PChar; stdcall;
begin
	Result := pWINFMP.getppzfilename(dest, bufnum);
end;


procedure fmp_setfmvoldown(voldown : Integer); stdcall;
begin
	pWINFMP.setfmvoldown(voldown);
end;


procedure fmp_setssgvoldown(voldown : Integer); stdcall;
begin
	pWINFMP.setssgvoldown(voldown);
end;


procedure fmp_setrhythmvoldown(voldown : Integer); stdcall;
begin
	pWINFMP.setrhythmvoldown(voldown);
end;


procedure fmp_setadpcmvoldown(voldown : Integer); stdcall;
begin
	pWINFMP.setadpcmvoldown(voldown);
end;


procedure fmp_setppzvoldown(voldown : Integer); stdcall;
begin
	pWINFMP.setppzvoldown(voldown);
end;


function fmp_getfmvoldown : Integer; stdcall;
begin
	Result := pWINFMP.getfmvoldown;
end;


function fmp_getssgvoldown : Integer; stdcall;
begin
	Result := pWINFMP.getssgvoldown;
end;


function fmp_getrhythmvoldown : Integer; stdcall;
begin
	Result := pWINFMP.getrhythmvoldown;
end;


function fmp_getadpcmvoldown : Integer; stdcall;
begin
	Result := pWINFMP.getadpcmvoldown;
end;


function fmp_getppzvoldown : Integer; stdcall;
begin
	Result := pWINFMP.getppzvoldown;
end;


procedure fmp_setpos(pos : Integer); stdcall;
begin
	pWINFMP.setpos(pos);
end;


procedure fmp_setpos2(pos : Integer); stdcall;
begin
	pWINFMP.setpos2(pos);
end;


function fmp_getpos : Integer; stdcall;
begin
	Result := pWINFMP.getpos;
end;


function fmp_getpos2 : Integer; stdcall;
begin
	Result := pWINFMP.getpos2;
end;


function fmp_getlength(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
begin
	Result := pWINFMP2.getlength(filename, length, loop);
end;


function fmp_getlength2(filename : PChar; var length : Integer; var loop : Integer) : Boolean; stdcall;
begin
	Result := pWINFMP2.getlength2(filename, length, loop);
end;


function fmp_getloopcount : Integer; stdcall;
begin
	Result := pWINFMP.getloopcount;
end;


procedure fmp_setfmwait(nsec : Integer); stdcall;
begin
	pWINFMP.setfmwait(nsec);
end;


procedure fmp_setssgwait(nsec : Integer); stdcall;
begin
	pWINFMP.setssgwait(nsec);
end;


procedure fmp_setrhythmwait(nsec : Integer); stdcall;
begin
	pWINFMP.setrhythmwait(nsec);
end;


procedure fmp_setadpcmwait(nsec : Integer); stdcall;
begin
	pWINFMP.setadpcmwait(nsec);
end;


function fmp_getsyncscnt : Integer; stdcall;
begin
	Result := pWINFMP.getsyncscnt;
end;


function fmp_getlastsyncexttime : Integer; stdcall;
begin
	Result := pWINFMP.getlastsyncexttime;
end;


function fmp_getworks : PWORKS; stdcall;
begin
	Result := pWINFMP.getworks;
end;


function fmp_querypdzfz8xinterface(const riid: TIID; var ppv): HResult; stdcall;
begin
	Result := pWINFMP.querypdzfz8xinterface(riid, ppv);
end;


{$ENDIF}

initialization
//=============================================================================
// DLL �ǂݍ��݁��֐��A�h���X�擾
//=============================================================================
	HWinFMP := LoadLibrary(WINFMP_DLLNAME);
	if(HWinFMP = 0) then begin
		ShowMessage(WINFMP_MSG_DLLNOTFOUND);
		Halt;
	end;

	// �o�[�W�����`�F�b�N
	fmp_getversion := GetProcAddress2(HWinFMP, 'fmp_getversion');
	fmp_getinterfaceversion := GetProcAddress2(HWinFMP, 'fmp_getinterfaceversion');


	if(fmp_getinterfaceversion < WINFMP_MININTERFACEVERSION) then begin
		ShowMessage(WINFMP_MSG_ERROR_LOWER);
		Halt;
	end;

	if(fmp_getinterfaceversion >= WINFMP_MAXINTERFACEVERSION) then begin
		ShowMessage(WINFMP_MSG_ERORR_UPPER);
		Halt;
	end;


	// �C���X�^���X�擾�֐�
	fmp_CoCreateInstance := GetProcAddress2(HWinFMP, 'fmp_CoCreateInstance');


{$IFDEF TESTCOMINTERFACE}
//=============================================================================
// �C���X�^���X�擾
//=============================================================================

	if(fmp_CoCreateInstance(CLSID_WINFMP, Nil, CLSCTX_ALL, IID_IWINFMP, pWINFMP) <> S_OK) then begin
		ShowMessage(WINFMP_MSG_COMNOTFOUND);
	end;

	if(fmp_CoCreateInstance(CLSID_WINFMP, Nil, CLSCTX_ALL, IID_IWINFMP, pWINFMP2) <> S_OK) then begin
		ShowMessage(WINFMP_MSG_COMNOTFOUND);
	end;

{$ELSE}

	// �c��̊֐��A�h���X�̎擾
	fmp_init := GetProcAddress2(HWinFMP, 'fmp_init');
	fmp_load := GetProcAddress2(HWinFMP, 'fmp_load');
	fmp_load2 := GetProcAddress2(HWinFMP, 'fmp_load2');
	fmp_start := GetProcAddress2(HWinFMP, 'fmp_start');
	fmp_stop := GetProcAddress2(HWinFMP, 'fmp_stop');
	fmp_getpcmdata := GetProcAddress2(HWinFMP, 'fmp_getpcmdata');
	fmp_maskon := GetProcAddress2(HWinFMP, 'fmp_maskon');
	fmp_maskoff := GetProcAddress2(HWinFMP, 'fmp_maskoff');
	fmp_loadrhythmsample := GetProcAddress2(HWinFMP, 'fmp_loadrhythmsample');
	fmp_setpcmdir := GetProcAddress2(HWinFMP, 'fmp_setpcmdir');
	fmp_setpcmrate := GetProcAddress2(HWinFMP, 'fmp_setpcmrate');
	fmp_setppzrate := GetProcAddress2(HWinFMP, 'fmp_setppzrate');
	fmp_fadeout := GetProcAddress2(HWinFMP, 'fmp_fadeout');
	fmp_fadeout2 := GetProcAddress2(HWinFMP, 'fmp_fadeout2');
	fmp_setfmcalc55k := GetProcAddress2(HWinFMP, 'fmp_setfmcalc55k');
	fmp_setppzinterpolation := GetProcAddress2(HWinFMP, 'fmp_setppzinterpolation');
	fmp_setadpcmppz8emulate := GetProcAddress2(HWinFMP, 'fmp_setadpcmppz8emulate');
	fmp_getcomment := GetProcAddress2(HWinFMP, 'fmp_getcomment');
	fmp_getcomment2 := GetProcAddress2(HWinFMP, 'fmp_getcomment2');
	fmp_getcomment3 := GetProcAddress2(HWinFMP, 'fmp_getcomment3');
	fmp_fgetcomment := GetProcAddress2(HWinFMP, 'fmp_fgetcomment');
	fmp_fgetcomment2 := GetProcAddress2(HWinFMP, 'fmp_fgetcomment2');
	fmp_fgetcomment3 := GetProcAddress2(HWinFMP, 'fmp_fgetcomment3');
	fmp_getdefinedpcmfilename := GetProcAddress2(HWinFMP, 'fmp_getdefinedpcmfilename');
	fmp_getdefinedppzfilename := GetProcAddress2(HWinFMP, 'fmp_getdefinedppzfilename');
	fmp_fgetdefinedpcmfilename := GetProcAddress2(HWinFMP, 'fmp_fgetdefinedpcmfilename');
	fmp_fgetdefinedppzfilename := GetProcAddress2(HWinFMP, 'fmp_fgetdefinedppzfilename');
	fmp_getmusicfilename := GetProcAddress2(HWinFMP, 'fmp_getmusicfilename');
	fmp_getpcmfilename := GetProcAddress2(HWinFMP, 'fmp_getpcmfilename');
	fmp_getppzfilename := GetProcAddress2(HWinFMP, 'fmp_getppzfilename');
	fmp_setfmvoldown := GetProcAddress2(HWinFMP, 'fmp_setfmvoldown');
	fmp_setssgvoldown := GetProcAddress2(HWinFMP, 'fmp_setssgvoldown');
	fmp_setrhythmvoldown := GetProcAddress2(HWinFMP, 'fmp_setrhythmvoldown');
	fmp_setadpcmvoldown := GetProcAddress2(HWinFMP, 'fmp_setadpcmvoldown');
	fmp_setppzvoldown := GetProcAddress2(HWinFMP, 'fmp_setppzvoldown');
	fmp_getfmvoldown := GetProcAddress2(HWinFMP, 'fmp_getfmvoldown');
	fmp_getssgvoldown := GetProcAddress2(HWinFMP, 'fmp_getssgvoldown');
	fmp_getrhythmvoldown := GetProcAddress2(HWinFMP, 'fmp_getrhythmvoldown');
	fmp_getadpcmvoldown := GetProcAddress2(HWinFMP, 'fmp_getadpcmvoldown');
	fmp_getppzvoldown := GetProcAddress2(HWinFMP, 'fmp_getppzvoldown');
	fmp_setpos := GetProcAddress2(HWinFMP, 'fmp_setpos');
	fmp_setpos2 := GetProcAddress2(HWinFMP, 'fmp_setpos2');
	fmp_getpos := GetProcAddress2(HWinFMP, 'fmp_getpos');
	fmp_getpos2 := GetProcAddress2(HWinFMP, 'fmp_getpos2');
	fmp_getlength := GetProcAddress2(HWinFMP, 'fmp_getlength');
	fmp_getlength2 := GetProcAddress2(HWinFMP, 'fmp_getlength2');
	fmp_getloopcount := GetProcAddress2(HWinFMP, 'fmp_getloopcount');
	fmp_setfmwait := GetProcAddress2(HWinFMP, 'fmp_setfmwait');
	fmp_setssgwait := GetProcAddress2(HWinFMP, 'fmp_setssgwait');
	fmp_setrhythmwait := GetProcAddress2(HWinFMP, 'fmp_setrhythmwait');
	fmp_setadpcmwait := GetProcAddress2(HWinFMP, 'fmp_setadpcmwait');
	fmp_getsyncscnt := GetProcAddress2(HWinFMP, 'fmp_getsyncscnt');
	fmp_getlastsyncexttime := GetProcAddress2(HWinFMP, 'fmp_getlastsyncexttime');
	fmp_getworks := GetProcAddress2(HWinFMP, 'fmp_getworks');
  fmp_querypdzfz8xinterface := Nil;		// DLL�C���^�[�t�F�C�X�ł͖��T�|�[�g

{$ENDIF}


//----------------------------------------------------------------------------
// DLL �J��
//----------------------------------------------------------------------------
finalization

{$IFDEF TESTCOMINTERFACE}
	{$IFDEF VER90}
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	// Delphi 2.0J
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		pWINFMP.Release;
		pWINFMP2.Release;
	{$ELSE}
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	// Delphi3 �ȍ~
	//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 		pWINFMP := nil;
 		pWINFMP2 := nil;

	{$ENDIF}
{$ENDIF}

	if(HWinFMP <> 0) then begin
		FreeLibrary(HWinFMP);
	end;


end.
