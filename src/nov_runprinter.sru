$PBExportHeader$nov_runprinter.sru
forward
global type nov_runprinter from nonvisualobject
end type
type process_information from structure within nov_runprinter
end type
type startupinfo from structure within nov_runprinter
end type
type shellexecuteinfo from structure within nov_runprinter
end type
type str_security_attributes from structure within nov_runprinter
end type
end forward

type process_information from structure
	long		hprocess
	long		hthread
	long		dwprocessid
	long		dwthreadid
end type

type startupinfo from structure
	long		cb
	string		lpreserved
	string		lpdesktop
	string		lptitle
	long		dwx
	long		dwy
	long		dwxsize
	long		dwysize
	long		dwxcountchars
	long		dwycountchars
	long		dwfillattribute
	long		dwflags
	unsignedinteger		wshowwindow
	unsignedinteger		cbreserved2
	long		lpreserved2
	long		hstdinput
	long		hstdoutput
	long		hstderror
end type

type shellexecuteinfo from structure
	unsignedlong		cbsize
	unsignedlong		fmask
	long		hwnd
	string		lpverb
	string		lpfile
	string		lpparameters
	string		lpdirectory
	long		nshow
	long		hinstapp
	long		lpidlist
	string		lpclass
	long		hkeyclass
	long		hicon
	long		hmonitor
	long		hprocess
end type

type str_security_attributes from structure
	long		nLength
	long		lpSecurityDescriptor
	long		bInheritHandle
end type

global type nov_runprinter from nonvisualobject autoinstantiate
end type

type prototypes
Function Boolean CreateProcess ( &
	String lpApplicationName, &
	Ref String lpCommandLine, &
	long lpProcessAttributes, &
	long lpThreadAttributes, &
	Boolean bInheritHandles, &
	Long dwCreationFlags, &
	long lpEnvironment, &
	String lpCurrentDirectory, &
	STARTUPINFO lpStartupInfo, &
	Ref PROCESS_INFORMATION lpProcessInformation &
	) Library "kernel32.dll" Alias For "CreateProcessW"

Function Long WaitForSingleObject ( &
	long hHandle, &
	Long dwMilliseconds &
	) Library "kernel32.dll"

Function Boolean CloseHandle ( &
	long hObject &
	) Library "kernel32.dll"

Function Boolean GetExitCodeProcess ( &
	long hProcess, &
	Ref Long lpExitCode &
	) Library "kernel32.dll"

Function Boolean TerminateProcess ( &
	long hProcess, &
	Long uExitCode &
	) Library "kernel32.dll"

Function Long ExpandEnvironmentStrings ( &
	String lpSrc, &
	Ref String lpDst, &
	Long nSize &
	) Library "kernel32.dll" Alias For "ExpandEnvironmentStringsW"
	
Function Boolean ShellExecuteEx ( &
	Ref SHELLEXECUTEINFO lpExecInfo &
	) Library "shell32.dll" Alias For "ShellExecuteExW"
	
FUNCTION ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath ) LIBRARY "KERNEL32.DLL"  ALIAS FOR "GetModuleFileNameA;ansi"  // ;ansi  required for PB10 or better

Subroutine SleepMS ( &
	ulong dwMilliseconds &
	) Library "kernel32.dll" Alias For "Sleep"

Function long GetDesktopWindow ( &
	) Library "user32.dll"

Function long GetWindow ( &
	long hWnd, &
	ulong uCmd &
	) Library "user32.dll"

Function long GetWindowText ( &
	long hWnd, &
	Ref string lpString, &
	long nMaxCount &
	) Library "user32.dll" Alias For "GetWindowTextW"

Function ulong GetWindowThreadProcessId ( &
	long hWnd, &
	Ref ulong lpdwProcessId &
	) Library "user32.dll"

Function long SetParent ( &
	long hWndChild, &
	long hWndNewParent &
	) Library "user32.dll"

Function boolean MoveWindow ( &
	long hWnd, &
	long xpos, &
	long ypos, &
	long nWidth, &
	long nHeight, &
	boolean bRepaint &
	) Library "user32.dll"

Function boolean ShowWindow ( &
	long hWnd, &
	long nCmdShow &
	) Library "user32.dll"

Function Long SetWindowLong( &
	long hWnd, &
	long nIndex, &
	ulong dwNewLong &
	) Library "user32.dll" Alias For "SetWindowLongW"

FUNCTION ulong CreatePipe(ref ulong phReadPipe,ref ulong phWritePipe, &
 ref str_security_attributes lpPipeAttributes,ulong nSize) LIBRARY "kernel32.dll" 

function long ReadFile( ulong hFile,  ref blob lpBuffer, long nNumberOfBytesToRead, &
 ref long lpNumberOfBytesRead, ulong lpOverlapped) library "kernel32.dll"

function ulong GetLastError() library "kernel32.dll" 

FUNCTION ulong PeekNamedPipe(ulong hNamedPipe,ref blob lpBuffer,ulong nBufferSize,&
 ref ulong lpBytesRead,ref ulong lpTotalBytesAvail,ref ulong lpBytesLeftThisMessage) LIBRARY "kernel32.dll"
 
 //length of the ansi string
private function long lstrlenA(long lpString1)library "kernel32.dll" alias for "lstrlenA"
private function long lstrlenA(ref blob b)library 'kernel32' alias for 'lstrlenA'

//convert multibyte to wide char
private function long MultiByteToWideChar(ulong CodePage, long dwFlags, long lpMBStr, long cchMB, ref string lpWStr, long cchWStr)library 'kernel32.dll' alias for 'MultiByteToWideChar'
private function long MultiByteToWideChar(ulong CodePage, long dwFlags, readonly blob lpMBStr, long cchMB, ref string lpWStr, long cchWStr)library 'kernel32.dll' alias for 'MultiByteToWideChar'

private function long WideCharToMultiByte(ulong CodePage,long dwFlags,readonly string lpWideCharStr,long cchWideChar,long mbstr,long cchMultiByte,long lpDefaultChar, ref long lpUsedDefaultChar)library 'kernel32.dll' alias for 'WideCharToMultiByte'

private function long WideCharToMultiByte(ulong CodePage,long dwFlags,readonly string lpWideCharStr,long cchWideChar,ref blob mbstr,long cchMultiByte,long lpDefaultChar, long lpUsedDefaultChar)library 'kernel32.dll' alias for 'WideCharToMultiByte'


Function ULong SHGetFolderPath(ULong hwndOwner, Long nFolder, ULong hToken, Long dwFlags, Ref String pszPath) Library 'shell32.dll' Alias For "SHGetFolderPathA;Ansi"





end prototypes

type variables
 long il_ansi_cp
Boolean ib_terminate
Long il_millsecs


Constant Long INFINITE			 = -1
Constant Long WAIT_ABANDONED	 = 128
Constant Long WAIT_COMPLETE	 = 0
Constant Long WAIT_OBJECT_0	 = 0
Constant Long WAIT_TIMEOUT		 = 258

Constant Long SW_HIDE				 = 0
Constant Long SW_SHOWNORMAL		 = 1
Constant Long SW_NORMAL				 = 1
Constant Long SW_SHOWMINIMIZED	 = 2
Constant Long SW_SHOWMAXIMIZED	 = 3
Constant Long SW_MAXIMIZE			 = 3
Constant Long SW_SHOWNOACTIVATE	 = 4
Constant Long SW_SHOW				 = 5
Constant Long SW_MINIMIZE			 = 6
Constant Long SW_SHOWMINNOACTIVE	 = 7
Constant Long SW_SHOWNA				 = 8
Constant Long SW_RESTORE			 = 9
Constant Long SW_SHOWDEFAULT		 = 10
Constant Long SW_FORCEMINIMIZE	 = 11
Constant Long SW_MAX					 = 11

Constant Long STARTF_USESHOWWINDOW		 = 1
Constant Long STARTF_USESIZE				 = 2
Constant Long STARTF_USEPOSITION			 = 4
Constant Long STARTF_USECOUNTCHARS		 = 8
Constant Long STARTF_USEFILLATTRIBUTE	 = 16
Constant Long STARTF_RUNFULLSCREEN		 = 32
Constant Long STARTF_FORCEONFEEDBACK	 = 64
Constant Long STARTF_FORCEOFFFEEDBACK	 = 128
Constant Long STARTF_USESTDHANDLES		 = 256
Constant Long STARTF_USEHOTKEY			 = 512

Constant Long CREATE_DEFAULT_ERROR_MODE	 = 67108864
Constant Long CREATE_FORCEDOS					 = 8192
Constant Long CREATE_NEW_CONSOLE				 = 16
Constant Long CREATE_NEW_PROCESS_GROUP		 = 512
Constant Long CREATE_NO_WINDOW				 = 134217728
Constant Long CREATE_SEPARATE_WOW_VDM		 = 2048
Constant Long CREATE_SHARED_WOW_VDM			 = 4096
Constant Long CREATE_SUSPENDED				 = 4
Constant Long CREATE_UNICODE_ENVIRONMENT	 = 1024
Constant Long DEBUG_PROCESS					 = 1
Constant Long DEBUG_ONLY_THIS_PROCESS		 = 2
Constant Long DETACHED_PROCESS				 = 8

Constant Long HIGH_PRIORITY_CLASS		 = 128
Constant Long IDLE_PRIORITY_CLASS		 = 64
Constant Long NORMAL_PRIORITY_CLASS		 = 32
Constant Long REALTIME_PRIORITY_CLASS	 = 256


Constant Long Null = 0
Constant Long GWL_STYLE		 = -16
Constant ULong GW_HWNDNEXT	 = 2
Constant ULong GW_OWNER		 = 4
Constant ULong GW_CHILD		 = 5
Constant ULong WS_POPUP		 = 2147483648
Constant ULong WM_SIZE		 = 5
Constant ULong WM_CLOSE		 = 16

Long il_hWnd
String is_commandline

String is_message
String is_printexe 


end variables

forward prototypes
public subroutine of_set_options (boolean ab_terminate, decimal adec_seconds)
private function long of_run (string as_exefullpath, long al_showwindow)
public function long of_run (string as_exefullpath, trigevent a_windowstate)
public function long of_run (string as_exefullpath, windowstate a_windowstate)
public function string of_get_shellexecute (string as_filename, string as_shellverb)
public function long of_shellrun (string as_filename, string as_shellverb, long al_showwindow)
public function long of_shellrun (string as_filename, string as_shellverb, trigevent a_windowstate)
public function long of_shellrun (string as_filename, string as_shellverb, windowstate a_windowstate)
public function integer of_lastpos (string as_str1, string as_str2)
public function string of_getcurfolderfile (string as_path)
public function string of_getfilename (string as_path)
public function string of_getfolder (string as_path)
public function string of_getmodulepath ()
public function integer of_readfile_encode (string as_file, ref string as_returnstring)
public function integer of_readfile (string as_file, ref string as_returnstring)
public subroutine of_parse (string as_parse, string as_list, ref string as_array[])
public subroutine of_createlocalfolders (string as_filename)
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
private function long of_run_hand (string as_exefullpath, long al_showwindow)
public subroutine of_resize (integer newwidth, integer newheight)
private function long of_getmbcp (boolean ab_utf8)
public function long of_string2mb (boolean ab_utf8, string src, ref blob dst)
public function boolean of_writetext_utf8 (string filename, string text, encoding e, ref string as_error)
public function string of_getappname ()
public function string of_getappname_notextention ()
public function string of_getsysdir ()
public function string of_getappdirtemp ()
public subroutine of_cleardirtemp (string as_remark)
public subroutine of_cleardirtemp ()
public function integer of_parse (string as_string, ref string as_array[], ref integer ai_count, string as_delimiter)
public function integer of_printing (string as_filepdf, string as_printername)
public function string of_getprinterdefalut ()
public function integer of_getprinterlist (ref string as_printer_name[])
end prototypes

public subroutine of_set_options (boolean ab_terminate, decimal adec_seconds);//====================================================================
// Function: n_ftpcs.of_set_options()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	boolean	ab_terminate	
// 	decimal	adec_seconds	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


ib_terminate = ab_terminate
il_millsecs = adec_seconds * 1000

end subroutine

private function long of_run (string as_exefullpath, long al_showwindow);//====================================================================
// Function: n_ftpcs.of_run()
//--------------------------------------------------------------------
// Description: Run And Read Message
//--------------------------------------------------------------------
// Arguments:
// 	string	as_exefullpath	
// 	long  	al_showwindow 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


//constant ulong 			STARTF_USESHOWWINDOW = 1
//constant ulong 			STARTF_USESTDHANDLES = 256
Constant ULong 			DUPLICATE_SAME_ACCESS = 2
Constant ULong 			BUFSIZE = 1024
Constant ULong 			PIPE_READMODE_BYTE = 0
Constant ULong 			PIPE_NOWAIT = 1


str_security_attributes	lstr_secure_attrib
startupinfo lstr_si
process_information lstr_pi
Long ll_null, ll_creationflags, ll_exitcode, ll_msecs
String ls_null, ls_message, ls_messtemp
UnsignedLong 			lul_null, luoverlapped, lul_err
UnsignedLong 			hpiperead,hpipewrite
UnsignedLong 			lpbytesread, lptotalbytesavail, lpbytesleft, lpbufoutlen
Boolean 					lb_created
Blob						lbl_read
Long						  lbytesread, lpipeoutlen
Long ll_flagmess

// initialize arguments
lbl_read = Blob(Space(BUFSIZE))
SetNull(ll_null)
SetNull(ls_null)
SetNull(lul_null)
luoverlapped = 0

lstr_secure_attrib.nLength = 12
lstr_secure_attrib.bInheritHandle = 1
lstr_secure_attrib.lpSecurityDescriptor = 0


//lstr_si.cb = 72
lstr_si.cb = 17 *4
//lstr_si.dwFlags = STARTF_USESHOWWINDOW 
lstr_si.dwFlags = STARTF_USESHOWWINDOW   + STARTF_USESTDHANDLES
lstr_si.wShowWindow = al_showwindow
//ll_CreationFlags = CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS
ll_creationflags = 0

If CreatePipe(hpiperead, hpipewrite, lstr_secure_attrib, 0) = 0 Then
	//messageBox("error", "create pipe failed")
	Return -1
End If

lstr_si.hStdOutput  = hpipewrite
lstr_si.hStdError = hpipewrite
lstr_si.hStdInput = hpipewrite

// create process/thread and execute the passed program
If CreateProcess(ls_null, as_exefullpath, ll_null, ll_null, True, ll_creationflags, ll_null, ls_null, lstr_si, lstr_pi) Then
	// wait for the process to complete
	If il_millsecs > 0 Then
		// wait until process ends or timeout period expires
		ll_exitcode = WaitForSingleObject(lstr_pi.hProcess, il_millsecs)
		// terminate process if not finished
		If ib_terminate And ll_exitcode = WAIT_TIMEOUT Then
			TerminateProcess(lstr_pi.hProcess, -1)
			ll_exitcode = WAIT_TIMEOUT
		Else
			// check for exit code
			GetExitCodeProcess(lstr_pi.hProcess, ll_exitcode)
		End If
	Else
		
		// close hPipeWrite and thread handles
		CloseHandle(hpipewrite)
		CloseHandle(lstr_pi.hThread)
		
		//redirect out message
		lbytesread = ReadFile( hpiperead, lbl_read, BUFSIZE,lpipeoutlen, 0)
		If lbytesread = 0 Then
			lul_err = GetLastError()
			If lul_err = 109 Then
				//messagebox("error reading", "error 109 - broken pipe")
			Else
				//messagebox("error reading", string(lul_err))
			End If
		End If
		ls_message = ""
		ll_flagmess = 0
		Do While lbytesread > 0 And lpipeoutlen > 0

			ls_messtemp = String(BlobMid(lbl_read,1, lpipeoutlen), EncodingUTF8!)
			lbytesread = ReadFile( hpiperead, lbl_read, BUFSIZE,lpipeoutlen, 0)
			
			If ll_flagmess > 0 Then
				if len(trim(ls_messtemp)) > 0 then
					ls_message += ls_messtemp
				end if
			End If
			
			If Pos(ls_messtemp, "JOBSTARTFLAG") > 0 Then
				ll_flagmess ++
			End If
			
		Loop
		is_message = ls_message
		
		// wait until process ends
		WaitForSingleObject(lstr_pi.hProcess, INFINITE)
		// check for exit code
		GetExitCodeProcess(lstr_pi.hProcess, ll_exitcode)
	End If
	
	// close process and hPipeRead
	closeHandle(hpiperead)
	CloseHandle(lstr_pi.hProcess)
	//CloseHandle(lstr_pi.hThread)
Else
	// return failure
	ll_exitcode = -1
End If

Return ll_exitcode




/*
//====================================================================
// Function: n_ftpcs.of_run()
//--------------------------------------------------------------------
// Description: Run And Read Message
//--------------------------------------------------------------------
// Arguments:
// 	string	as_exefullpath	
// 	long  	al_showwindow 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


//constant ulong 			STARTF_USESHOWWINDOW = 1
//constant ulong 			STARTF_USESTDHANDLES = 256
Constant ULong 			DUPLICATE_SAME_ACCESS = 2
Constant ULong 			BUFSIZE = 1024
Constant ULong 			PIPE_READMODE_BYTE = 0
Constant ULong 			PIPE_NOWAIT = 1


str_security_attributes	lstr_secure_attrib
startupinfo lstr_si
process_information lstr_pi
Long ll_null, ll_creationflags, ll_exitcode, ll_msecs
String ls_null, ls_message
UnsignedLong 			lul_null, luoverlapped, lul_err
UnsignedLong 			hpiperead,hpipewrite
UnsignedLong 			lpbytesread, lptotalbytesavail, lpbytesleft, lpbufoutlen
Boolean 					lb_created
Blob						lbl_read
Long						  lbytesread, lpipeoutlen
Long ll_row, ll_pos
String ls_tmp

// initialize arguments
lbl_read = Blob(Space(BUFSIZE))
SetNull(ll_null)
SetNull(ls_null)
SetNull(lul_null)
luoverlapped = 0

lstr_secure_attrib.nLength = 12
lstr_secure_attrib.bInheritHandle = 1
lstr_secure_attrib.lpSecurityDescriptor = 0


//lstr_si.cb = 72
lstr_si.cb = 17 *4
//lstr_si.dwFlags = STARTF_USESHOWWINDOW 
lstr_si.dwFlags = STARTF_USESHOWWINDOW   + STARTF_USESTDHANDLES
lstr_si.wShowWindow = al_showwindow
//ll_CreationFlags = CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS
ll_creationflags = 0

If CreatePipe(hpiperead, hpipewrite, lstr_secure_attrib, 0) = 0 Then
	//messageBox("error", "create pipe failed")
	Return -1
End If

lstr_si.hStdOutput  = hpipewrite
lstr_si.hStdError = hpipewrite
lstr_si.hStdInput = hpipewrite

// create process/thread and execute the passed program
If CreateProcess(ls_null, as_exefullpath, ll_null, ll_null, True, ll_creationflags, ll_null, ls_null, lstr_si, lstr_pi) Then
	// wait for the process to complete
	If il_millsecs > 0 Then
		// wait until process ends or timeout period expires
		ll_exitcode = WaitForSingleObject(lstr_pi.hProcess, il_millsecs)
		// terminate process if not finished
		If ib_terminate And ll_exitcode = WAIT_TIMEOUT Then
			TerminateProcess(lstr_pi.hProcess, -1)
			ll_exitcode = WAIT_TIMEOUT
		Else
			// check for exit code
			GetExitCodeProcess(lstr_pi.hProcess, ll_exitcode)
		End If
	Else
		
		// close hPipeWrite and thread handles
		CloseHandle(hpipewrite)
		CloseHandle(lstr_pi.hThread)
		
		//redirect out message
		lbytesread = ReadFile( hpiperead, lbl_read, BUFSIZE,lpipeoutlen, 0)
		If lbytesread = 0 Then
			lul_err = GetLastError()
			If lul_err = 109 Then
				//messagebox("error reading", "error 109 - broken pipe")
			Else
				//messagebox("error reading", string(lul_err))
			End If
		End If
		ls_message = ""
		ll_row = 0
		ls_tmp = ""
		Do While lbytesread > 0 And lpipeoutlen > 0
			
			ls_tmp = String(BlobMid(lbl_read,1, lpipeoutlen), encodingANSI!)
			If ll_row > 0 Then
				ls_message += ls_tmp
			End If
			If ll_row = 0 Then
				ll_pos = Pos(ls_tmp, "CONNECT_DATA", 1)
				If ll_pos > 0 Then
					ll_row ++
				End If
			End If
			lbytesread = ReadFile( hpiperead, lbl_read, BUFSIZE,lpipeoutlen, 0)
		Loop
		is_message = ls_message
		
		// wait until process ends
		WaitForSingleObject(lstr_pi.hProcess, INFINITE)
		// check for exit code
		GetExitCodeProcess(lstr_pi.hProcess, ll_exitcode)
	End If
	
	// close process and hPipeRead
	closeHandle(hpiperead)
	CloseHandle(lstr_pi.hProcess)
	//CloseHandle(lstr_pi.hThread)
Else
	// return failure
	ll_exitcode = -1
End If

Return ll_exitcode


*/





end function

public function long of_run (string as_exefullpath, trigevent a_windowstate);//====================================================================
// Function: n_ftpcs.of_run()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string   	as_exefullpath	
// 	trigevent	a_windowstate 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_rtn

CHOOSE CASE a_windowstate
	CASE Hide!
		// run the passed program
		ll_rtn = this.of_Run(as_exefullpath, SW_HIDE)
		//ll_rtn = this.of_Run_hand(as_exefullpath, SW_HIDE)
	CASE ELSE
		// valid trigevent but invalid windowstate
		SetNull(ll_rtn)
END CHOOSE

Return ll_rtn

end function

public function long of_run (string as_exefullpath, windowstate a_windowstate);//====================================================================
// Function: n_ftpcs.of_run()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string     	as_exefullpath	
// 	windowstate	a_windowstate 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_rtn

CHOOSE CASE a_windowstate
	CASE Normal!
		ll_rtn = this.of_Run(as_exefullpath, SW_SHOWNORMAL)
	CASE Maximized!
		ll_rtn = this.of_Run(as_exefullpath, SW_SHOWMAXIMIZED)
	CASE Minimized!
		ll_rtn = this.of_Run(as_exefullpath, SW_SHOWMINIMIZED)
END CHOOSE

Return ll_rtn

end function

public function string of_get_shellexecute (string as_filename, string as_shellverb);//====================================================================
// Function: n_ftpcs.of_get_shellexecute()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_filename 	
// 	string	as_shellverb	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_regkey, ls_class, ls_runcmd
String ls_regcmd, ls_regcmdex, ls_subkeys[]
Integer li_rc, li_pos1, li_pos2

// get file extension classname
ls_regkey = "HKEY_CLASSES_ROOT\." + Right(as_filename, 3)
RegistryGet(ls_regkey, "", RegString!, ls_class)
If ls_class = "" Then
	MessageBox(	"of_Get_ShellExecute Error", &
					"There is no association for the file type!", StopSign!)
	Return ""
End If

// get default shell verb if not given
ls_regkey = "HKEY_CLASSES_ROOT\" + ls_class + "\shell"
If as_shellverb = "" Then
	RegistryGet(ls_regkey, "", RegString!, as_shellverb)
	If as_shellverb = "" Then
		// get list of verb keys
		RegistryKeys(ls_regkey, ls_subkeys)
		If UpperBound(ls_subkeys) = 0 Then
			MessageBox(	"of_Get_ShellExecute Error", &
							"There are no shell verbs for the file type!", StopSign!)
			Return ""
		Else
			// default to first one
			as_shellverb = ls_subkeys[1]
		End If
	End If
End If

// get command string for the given shell verb
ls_regkey = ls_regkey + "\" + as_shellverb + "\command"
li_rc = RegistryGet(ls_regkey, "", RegString!, ls_regcmdex)
If li_rc = 1 Then
	ls_regcmd = Space(500)
	ExpandEnvironmentStrings(ls_regcmdex, ls_regcmd, 500)
Else
	li_rc = RegistryGet(ls_regkey, "", RegExpandString!, ls_regcmdex)
	If li_rc = 1 Then
		ls_regcmd = Space(500)
		ExpandEnvironmentStrings(ls_regcmdex, ls_regcmd, 500)
	Else
		MessageBox(	"of_Get_ShellExecute Error", &
						"The verb is invalid for the file type!", StopSign!)
		Return ""
	End If
End If

// add file name to command string
li_pos1 = Pos(ls_regcmd, "%1")
If li_pos1 = 0 Then
	ls_runcmd = ls_regcmd + " ~"" + as_filename + "~""
Else
	li_pos2 = Pos(ls_regcmd, "~"%1~"")
	If li_pos2 = 0 Then
		ls_runcmd = Replace(ls_regcmd, li_pos1, 2, "~"" + as_filename + "~"")
	Else
		ls_runcmd = Replace(ls_regcmd, li_pos1, 2, as_filename)
	End If
End If

Return ls_runcmd

end function

public function long of_shellrun (string as_filename, string as_shellverb, long al_showwindow);// -----------------------------------------------------------------------------
// SCRIPT:     n_runandwait.of_ShellRun
//
// PURPOSE:    This function starts the program that is defined to perform
//					the action on the file. It then waits for it to finish.
//					If a timeout period has been set, it optionally can terminate
//					the process.
//
// ARGUMENTS:  as_exefullpath	- Path of program to execute
//					as_shellverb	- Shell action verb (blank for default)
//             ai_showwindow	- Show window option
//
// RETURN:		Return code of the program or:
//					-1  = Create Process failed
//					258 = Process terminated after timeout
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 07/16/2003	RolandS		Initial Coding
// -----------------------------------------------------------------------------

CONSTANT Long SEE_MASK_NOCLOSEPROCESS = 64
SHELLEXECUTEINFO lstr_sei
Long ll_ExitCode


// initialize structure values
lstr_sei.cbSize = 60
lstr_sei.fMask  = SEE_MASK_NOCLOSEPROCESS
lstr_sei.hWnd   = Handle(this)
lstr_sei.lpVerb = as_shellverb
lstr_sei.lpFile = as_filename
lstr_sei.nShow  = al_showwindow

If ShellExecuteEx(lstr_sei) Then
	// wait for the process to complete
	If il_millsecs > 0 Then
		// wait until process ends or timeout period expires
		ll_ExitCode = WaitForSingleObject(lstr_sei.hProcess, il_millsecs)
		// terminate process if not finished
		If ib_terminate And ll_ExitCode = WAIT_TIMEOUT Then
			TerminateProcess(lstr_sei.hProcess, -1)
			ll_ExitCode = WAIT_TIMEOUT
		Else
			// check for exit code
			GetExitCodeProcess(lstr_sei.hProcess, ll_ExitCode)
		End If
	Else
		// wait until process ends
		WaitForSingleObject(lstr_sei.hProcess, INFINITE)
		// check for exit code
		GetExitCodeProcess(lstr_sei.hProcess, ll_ExitCode)
	End If
	// close process and thread handles
	CloseHandle(lstr_sei.hProcess)
Else
	// return failure
	ll_ExitCode = -1
End If

Return ll_ExitCode

end function

public function long of_shellrun (string as_filename, string as_shellverb, trigevent a_windowstate);// -----------------------------------------------------------------------------
// SCRIPT:     n_runandwait.of_ShellRun
//
// PURPOSE:    This function takes the Hide! enumerated value and
//             passes SW_HIDE to the form of the function that
//					actually does the processing.
//
// ARGUMENTS:  as_exefullpath	- Path of program to execute
//					as_shellverb	- Shell action verb (blank for default)
//             a_windowstate	- Show window option
//
// RETURN:		Return code from processing
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 07/16/2003	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long ll_rtn

CHOOSE CASE a_windowstate
	CASE Hide!
		// run the passed file
		ll_rtn = this.of_ShellRun(as_filename, as_shellverb, SW_HIDE)
	CASE ELSE
		// valid trigevent but invalid windowstate
		SetNull(ll_rtn)
END CHOOSE

Return ll_rtn

end function

public function long of_shellrun (string as_filename, string as_shellverb, windowstate a_windowstate);// -----------------------------------------------------------------------------
// SCRIPT:     n_runandwait.of_ShellRun
//
// PURPOSE:    This function takes the Normal!, Maximized and
//					Minimized! enumerated values and passes the
//             corresponding value to the form of the function
//					that actually does the processing.
//
// ARGUMENTS:  as_exefullpath	- Path of program to execute
//					as_shellverb	- Shell action verb (blank for default)
//             a_windowstate	- Show window option
//
// RETURN:		Return code from processing
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 07/16/2003	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long ll_rtn

CHOOSE CASE a_windowstate
	CASE Normal!
		ll_rtn = this.of_ShellRun(as_filename, as_shellverb, SW_SHOWNORMAL)
	CASE Maximized!
		ll_rtn = this.of_ShellRun(as_filename, as_shellverb, SW_SHOWMAXIMIZED)
	CASE Minimized!
		ll_rtn = this.of_ShellRun(as_filename, as_shellverb, SW_SHOWMINIMIZED)
END CHOOSE

Return ll_rtn

end function

public function integer of_lastpos (string as_str1, string as_str2);//====================================================================
// Function: of_lastpos()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_str1	
// 	string	as_str2	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2018.10.09
//--------------------------------------------------------------------
//	Copyright (c) 2018  PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_pos
Integer li_rtn

If ((((IsNull(as_str1)) Or (IsNull(as_str2))) Or (Trim(as_str1) = "")) Or (Trim(as_str2) = "")) Then
	Return 0
End If

Do
	li_rtn = li_pos
	li_pos = Pos(as_str1,as_str2,li_pos + 1)
Loop While li_pos > 0

Return li_rtn

end function

public function string of_getcurfolderfile (string as_path);//====================================================================
// Function: n_ftpcs.of_getcurfolderfile()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_path	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Integer li_pos
String ls_fullfolder , ls_curfolderfile , ls_curpath

li_pos = of_lastpos(as_path,"/")

If li_pos > 0 Then
	ls_fullfolder = Mid(as_path,1,li_pos - 1)
else
	ls_fullfolder = as_path
End If

li_pos = of_lastpos(ls_fullfolder,"//")
If li_pos > 0 Then
	ls_curfolderfile =  Mid(ls_fullfolder,li_pos + 2)
Else
	ls_curfolderfile = ls_fullfolder
End If

li_pos = pos(ls_curfolderfile,"/")
If li_pos > 0 Then
	ls_curpath =  Mid(ls_curfolderfile,li_pos + 1)
Else
	ls_curpath = ls_curfolderfile
End If

Return ls_curpath

end function

public function string of_getfilename (string as_path);//====================================================================
// Function: n_ftpcs.of_getfilename()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_path	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Integer li_pos

li_pos = of_lastpos(as_path,"/")

If li_pos > 0 Then
	Return Mid(as_path,li_pos + 1)
Else
	Return ""
End If

end function

public function string of_getfolder (string as_path);//====================================================================
// Function: of_getfolder()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_path	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/01/16
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_pos
String ls_folder

li_pos = of_lastpos(as_path,"/")

If li_pos > 0 Then
	ls_folder = Mid(as_path,1,li_pos - 1)
End If

Return ls_folder

end function

public function string of_getmodulepath ();//====================================================================
// Function: n_ftpcs.of_getmodulepath()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


string	ls_AppPath
string	ls_FullPath
string	ls_Exe
int	li_Ret
int	li_Pos = 0
ulong lul_handle, lul_length = 1024
ClassDefinition  lcd

ls_Fullpath = Space (1024)
IF handle(getapplication()) = 0 THEN
	// running from the IDE
    lcd=getapplication().classdefinition
    ls_FullPath = lcd.libraryname
	if len(ls_FullPath) > 0 then
		li_ret = 1
	else
		li_ret = 0
	end if
else
	// running from EXE
    lul_handle = handle( getapplication() )
    ls_fullpath=space(lul_length) 
    li_ret = GetModuleFilename( lul_handle, ls_FullPath, lul_length )
end if

if li_Ret > 0 then 
	// ls_AppPath will be something line <drive><full path>\<exe name>
	// You can then strip off the exe name using:
	do while (Pos (ls_FullPath, "\", li_Pos + 1) > 0)
		li_Pos = Pos (ls_FullPath, "\", li_Pos + 1)
	loop
	
	ls_AppPath	= Mid (ls_FullPath, 1, li_Pos - 1)
	ls_Exe		= Mid (ls_FullPath, li_Pos + 1)

	//ls_apppath
	//ls_fullpath
	// ls_exe
	return ls_apppath
end if
return ""



end function

public function integer of_readfile_encode (string as_file, ref string as_returnstring);//====================================================================
// Function: n_ftpcs.of_readfile_encode()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	      	string	as_file	
// 	ref   	string 	as_returnstring	
//--------------------------------------------------------------------
// Returns:  tring
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_FileNum, loops, j
Long flen, bytes_read
Integer fh, ret
Blob b, tot_b,C
String  ls_string
Long ll_rowerror

flen = FileLength(as_file)
li_FileNum = FileOpen(as_file,  StreamMode!, Read!, LockRead!)
If li_FileNum < 0 Then
	//messagebox('thong bao', 'doc file loi ' +as_file)
	Return 1
End If
If flen > 32765 Then
	If Mod(flen, 32765) = 0 Then
		loops = flen/32765
	Else
		loops = (flen/32765) + 1
	End If
Else
	loops = 1
End If
For j = 1 To loops
	bytes_read = FileRead(li_FileNum, b)
	tot_b = tot_b + b
Next
FileClose(li_FileNum)

as_returnstring = String(tot_b, EncodingUTF8!)
Return 0


end function

public function integer of_readfile (string as_file, ref string as_returnstring);//====================================================================
// Function: n_ftpcs.of_readfile()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	      	string	as_file	
// 	ref   	string 	as_returnstring	
//--------------------------------------------------------------------
// Returns:  tring
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Integer li_loops, li_i
Integer li_FileNum
Long ll_fLen, ll_bRead, ll_NewPos
String ls_tmp, ls_string_file

// Get the file length and open the file
ll_fLen = FileLength(as_file)
li_FileNum = FileOpen(as_file,StreamMode!, Read!, Shared!)
If li_FileNum < 0 Then
	//messagebox('thong bao', 'doc file loi ' +as_file)
	FileClose(li_FileNum)
	Return 1
End If

// Determine how many times to call FileRead
If ll_fLen > 32765 Then
	If Mod(ll_fLen, 32765) = 0 Then
		li_loops = ll_fLen/32765
	Else
		li_loops = (ll_fLen/32765) + 1
	End If
Else
	li_loops = 1
End If

// Read the file
ls_tmp = ''
ls_string_file = ''
ll_NewPos = 1
For li_i = 1 To li_loops
	ll_bRead = FileRead(li_FileNum, ls_tmp)
	If ll_bRead < 0 Then
		//messagebox('thong bao', 'doc file loi ' +as_file)
		FileClose(li_FileNum)
		Return 1
	End If
	ls_string_file = ls_string_file + ls_tmp
Next

FileClose(li_FileNum)
as_returnstring = ls_string_file
Return  0

end function

public subroutine of_parse (string as_parse, string as_list, ref string as_array[]);//====================================================================
// Function: n_ftpcs.of_parse()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	      	string	as_parse	
// 	      	string	as_list 	
// 	ref   	string  	as_array[]	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_pos, ll_cnt, ll_start
String ls_empty[]
Integer li_next

as_array = ls_empty
as_list = Trim(as_list)
If Right(as_list, 1) <> as_parse Then
	as_list = as_list + as_parse
End If

ll_start = 1
ll_pos = Pos(as_list, as_parse, ll_start)
do while ll_pos > 1
	li_next = UpperBound(as_array) + 1
	as_array[li_next] = Mid(as_list, ll_start, (ll_pos - ll_start))
	ll_start = ll_pos + 1
	ll_pos = Pos(as_list, as_parse, ll_start)
loop

end subroutine

public subroutine of_createlocalfolders (string as_filename);//====================================================================
// Function: n_ftpcs.of_createlocalfolders()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_filename	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_parts[], ls_path
Integer li_idx, li_max

of_Parse("\", as_filename, ls_parts)

li_max = UpperBound(ls_parts) - 1
For li_idx = 1 To li_max
	If li_idx > 1 Then
		ls_path += "\"
	End If
	ls_path += ls_parts[li_idx]
	If Not DirectoryExists(ls_path) Then
		CreateDirectory(ls_path)
	End If
Next


end subroutine

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);//====================================================================
// Function: n_ftpcs.of_replaceall()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_oldstring	
// 	string	as_findstr  	
// 	string	as_replace  	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/12/14
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring


end function

private function long of_run_hand (string as_exefullpath, long al_showwindow);// -----------------------------------------------------------------------------
// SCRIPT:     n_runandwait.of_Run
//
// PURPOSE:    This function starts the process and waits for it to
//             finish.  If a timeout period has been set, it
//					optionally can terminate the process.
//
// ARGUMENTS:  as_exefullpath	- Path of program to execute
//             ai_showwindow	- Show window option
//
// RETURN:		Return code of the program or:
//					-1  = Create Process failed
//					258 = Process terminated after timeout
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 07/16/2003	RolandS		Initial Coding
// -----------------------------------------------------------------------------
/*
STARTUPINFO lstr_si
PROCESS_INFORMATION lstr_pi
Long ll_null, ll_CreationFlags, ll_ExitCode, ll_msecs
String ls_null
Long  ll_loop
Long ll_hWnd
ULong lul_hProcess, lul_hThread
Long al_hwnd

// initialize arguments
SetNull(ll_null)
SetNull(ls_null)
//lstr_si.cb = 72
//lstr_si.dwFlags = STARTF_USESHOWWINDOW
//lstr_si.wShowWindow = al_showwindow
//ll_CreationFlags = CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS

// initialize arguments
lstr_si.cb = 68
lstr_si.dwFlags = STARTF_USESHOWWINDOW
lstr_si.wShowWindow = SW_HIDE
ll_CreationFlags = CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS


// create process/thread and execute the passed program
If CreateProcess(ls_null, as_exefullpath, ll_null, &
	ll_null, False, ll_CreationFlags, ll_null, &
	ls_null, lstr_si, lstr_pi) Then
	// close process and thread handles
	CloseHandle(lstr_pi.hProcess)
	CloseHandle(lstr_pi.hThread)
	
	// find the external program's main window
	For ll_loop = 1 To 100
		// wait 10 milliseconds
		SleepMS(10)
		// walk through all open windows
		ll_hWnd = GetWindow(GetDesktopWindow(), GW_CHILD)
		Do Until ll_hWnd = 0
			// get the thread/process that owns the window
			lul_hThread = GetWindowThreadProcessId(ll_hWnd, lul_hProcess)
			If lul_hProcess = lstr_pi.dwProcessId Then
				// make sure it is a main window
				If GetWindow(ll_hWnd, GW_OWNER) = 0 Then
					Open(w_hand_progress)
					al_hwnd = Handle(w_hand_progress)
					//is_commandline = as_commandline
					SetParent(ll_hWnd, al_hwnd)
					SetWindowLong(ll_hWnd, GWL_STYLE, WS_POPUP)
					ShowWindow(ll_hWnd, SW_NORMAL)
					of_Resize(w_hand_progress.WorkspaceWidth() , w_hand_progress.WorkspaceHeight())
					exit
				End If
			End If
			ll_hWnd = GetWindow(ll_hWnd, GW_HWNDNEXT)
		Loop
	Next
	
	// wait until process ends
	WaitForSingleObject(lul_hProcess, INFINITE)
	// check for exit code
	GetExitCodeProcess(lul_hProcess, ll_ExitCode)
	
//	// wait until process ends
//	WaitForSingleObject(lstr_pi.hProcess, INFINITE)
//	// check for exit code
//	GetExitCodeProcess(lstr_pi.hProcess, ll_ExitCode)

	If ll_hWnd > 0 Then
		Send(ll_hWnd, WM_CLOSE, 0, 0)
	End If
	close(w_hand_progress)
Else
	// return failure
	ll_ExitCode = -1
End If

Return ll_ExitCode
*/
return 1


end function

public subroutine of_resize (integer newwidth, integer newheight);// Resize the attached window

Long ll_width, ll_height

If il_hWnd > 0 Then
	ll_width  = UnitsToPixels(newwidth, XUnitsToPixels!)
	ll_height = UnitsToPixels(newheight, YUnitsToPixels!)
	MoveWindow(il_hWnd, 0, 0, ll_width, ll_height, True)
End If

end subroutine

private function long of_getmbcp (boolean ab_utf8);//returns multibyte charset for internal use for WidechartoMultibyte and vice-versa
long CP_ACP=0  //
long CP_UTF8=65001
long CP_THREAD_ACP=3


if ab_utf8 then return CP_UTF8
return il_ansi_cp
//return CP_THREAD_ACP

end function

public function long of_string2mb (boolean ab_utf8, string src, ref blob dst);//returns the length of the blob in bytes
long len
long cp

cp=of_getMbCP(ab_utf8)

len=WideCharToMultiByte( cp,0,src,-1, dst,0,0,0)
dst=blob(space(len+1),EncodingANSI!) //+1 because PB removes zerochar at the end of string :(
WideCharToMultiByte( cp,0,src,-1, dst,len+1,0,0)

return len

end function

public function boolean of_writetext_utf8 (string filename, string text, encoding e, ref string as_error);int f
long i
blob b

if e=EncodingANSI! then
	//for ansi use winapi convert, because PB uses system instead of user conversation
	f=FileOpen(filename, StreamMode!, Write!, LockWrite!, Replace!)
elseif e=EncodingUTF8! then
	//for utf8 avoid adding BOM!
	//required by isql???
	f=FileOpen(filename, StreamMode!, Write!, LockWrite!, Replace!)
else
	f=FileOpen(filename, TextMode!, Write!, LockWrite!, Replace!,e)
end if

if f=-1 then 
	as_error = "Can't create the file~r~n~""+filename+'"'
	return false
end if


if e=EncodingANSI! then
	//i=gn_unicode.of_string2mb( /*boolean ab_utf8*/ false, text, b)
	i= of_string2mb(true, text, b)
	i=len(text)
	i=FileWriteEx(f, b ,i)
elseif e=EncodingUTF8! then
	//for utf8 avoid adding BOM!
	//required by isql???
	i=FileWriteEx(f, blob(text,EncodingUTF8!) )
else
	i=FileWriteEx(f, text)
end if


FileClose(f)

return true

end function

public function string of_getappname ();//====================================================================
// Function: n_inboundfunsys.of_getappname()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/11/21
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_AppPath
String	ls_FullPath
String	ls_Exe
Int	li_Ret
Int	li_Pos = 0
ULong lul_handle, lul_length = 1024
ClassDefinition  lcd

ls_FullPath = Space (1024)
If Handle(GetApplication()) = 0 Then
	// running from the IDE
	lcd = GetApplication().ClassDefinition
	ls_FullPath = lcd.LibraryName
	If Len(ls_FullPath) > 0 Then
		li_Ret = 1
	Else
		li_Ret = 0
	End If
Else
	// running from EXE
	lul_handle = Handle( GetApplication() )
	ls_FullPath = Space(lul_length)
	li_Ret = GetModuleFilename( lul_handle, ls_FullPath, lul_length )
End If

If li_Ret > 0 Then
	// ls_AppPath will be something line <drive><full path>\<exe name>
	// You can then strip off the exe name using:
	Do While (Pos (ls_FullPath, "\", li_Pos + 1) > 0)
		li_Pos = Pos (ls_FullPath, "\", li_Pos + 1)
	Loop
	
	ls_AppPath	 = Mid (ls_FullPath, 1, li_Pos - 1)
	ls_Exe		 = Mid (ls_FullPath, li_Pos + 1)
	
	//ls_apppath
	//ls_fullpath
	// ls_exe
	Return ls_Exe
End If
Return ""





end function

public function string of_getappname_notextention ();String ls_exe
Int li_Pos

ls_exe = of_getappname()
li_Pos =  Pos (ls_exe, ".", 1)
ls_exe = Mid(ls_exe, 1 ,li_Pos - 1)

Return ls_exe


end function

public function string of_getsysdir ();//====================================================================
// Function: n_inboundfunsys.of_getsysdir()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/11/21
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Constant Long CSIDL_PERSONAL = 5 // current user My Documents
Constant Long CSIDL_APPDATA = 26 // current user Application Data
Constant Long CSIDL_LOCAL_APPDATA = 28 // local settings Application Data
Constant Long CSIDL_COMMON_DOCUMENTS = 46 // all users My Documents
Constant Long CSIDL_COMMON_APPDATA = 35 // all users Application Data
String ls_path
ULong lul_handle, lul_rc, lul_hToken

ls_path = Space(256)
lul_handle = Handle(This)
SetNull(lul_hToken)
lul_rc = SHGetFolderPath(lul_handle, CSIDL_LOCAL_APPDATA, lul_hToken, 0, ls_path)

Return ls_path // path


end function

public function string of_getappdirtemp ();//====================================================================
// Function: n_inboundfunsys.of_getappdirtemp()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/11/21
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_dirsys

ls_dirsys = of_getsysdir() + "\" + of_getappname_notextention()

If  Not DirectoryExists ( ls_dirsys ) Then
	CreateDirectory (ls_dirsys )
End If

Return ls_dirsys


end function

public subroutine of_cleardirtemp (string as_remark);//====================================================================
// Function: n_inboundfunsys.of_cleardirtemp()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_remark	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2019/11/21
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_sysdir, ls_filename
Int li_items , li_i

ls_sysdir = of_getsysdir() + "\" + of_getappname_notextention()

If Not (IsNull(as_remark) Or Len(Trim(as_remark)) = 0) Then
	ls_sysdir += "\" + as_remark
End If

window lw_tmp
listbox llb_tmp

Open( lw_tmp )
lw_tmp.Visible = False
lw_tmp.OpenUserObject( llb_tmp )

llb_tmp.DirList(ls_sysdir,0)
li_items = llb_tmp.TotalItems()

For li_i = 1 To li_items
	ls_filename = llb_tmp.Text( li_i )
	If FileExists ( ls_sysdir + '\' + ls_filename ) Then FileDelete ( ls_sysdir + '\' + ls_filename )
Next

lw_tmp.CloseUserObject( llb_tmp )
Close( lw_tmp )



end subroutine

public subroutine of_cleardirtemp ();of_cleardirtemp("")
end subroutine

public function integer of_parse (string as_string, ref string as_array[], ref integer ai_count, string as_delimiter);//====================================================================
// Function: nov_runjobs.of_parse()
//--------------------------------------------------------------------
// Description: Takes a  string and separates elements into an array
//--------------------------------------------------------------------
// Arguments:
// 	value    	string 	as_string   	Source string containing values delimited by as_delimiter
// 	reference	string 	as_array[]  	Destination array, passed by value
// 	reference	integer	ai_count    	Returns count of items in array
// 	value    	string 	as_delimiter	delimiter value
//--------------------------------------------------------------------
// Returns:  integer  0 = success  1 = error
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2023/07/24
//--------------------------------------------------------------------
// Usage: nov_runjobs.of_parse ( string as_string, ref string as_array[], ref integer ai_count, string as_delimiter )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int   li_pos // position of commas
Int   li_len // string parsing
Int   li_start // string parsing
String  ls_item // single item parsed from string

If Len( as_string ) < 1 Then
	ai_count = 0
	Return 1
End If

// parse out items and insert into array

li_pos  = 1
li_start = 1
ai_count = 0

Do While li_pos > 0
	
	li_pos = Pos ( as_string, as_delimiter, li_start )
	
	If li_pos = 0 Then
		ls_item = Mid ( as_string, li_start )
	Else
		ls_item = Mid ( as_string, li_start, li_pos - li_start )
	End If
	
	
	ls_item = Trim ( ls_item )
	
	If Len ( ls_item ) > 0 Then
		ai_count++
		as_array[ai_count] = ls_item
	End If
	
	li_start = li_pos + 1
	
Loop

Return 0

end function

public function integer of_printing (string as_filepdf, string as_printername);If IsNull(is_printexe) Or Len(Trim(is_printexe)) = 0 Then
	is_message = "printexe is null "
	Return -1
End If
If Not FileExists(is_printexe) Then
	is_message = "printexe Is Not Exists " + is_printexe
	Return -1
End If

If Not FileExists(as_filepdf) Then
	is_message = "file PDF Is Not Exists " + is_printexe
	Return -1
End If

String ls_execute

If IsNull(as_printername) Or Len(Trim(as_printername)) = 0 Then
	ls_execute = '"' + is_printexe +  '" "' + as_filepdf +'"'
Else
	ls_execute = '"' + is_printexe +  '" "' + as_filepdf + '" "' +  as_printername + '"'
End If

Long ll_rc
ll_rc = of_run(ls_execute, Hide!)
Choose Case ll_rc
	Case 1 //OK
		Return ll_rc
	Case -1
		Return -1
	Case Else
		Return -1
End Choose

Return ll_rc



end function

public function string of_getprinterdefalut ();String ls_name , ls_fullstring
Long  ll_place

ls_fullstring = PrintGetPrinter()
ll_place = Pos (ls_fullstring, "~t")
ls_name = Left(ls_fullstring, ll_place -1)
Return ls_name


end function

public function integer of_getprinterlist (ref string as_printer_name[]);String ls_prntrs
String ls_printer[]
Int li_cnt, li_rtn, li_i
Long ll_pos

ls_prntrs  = PrintGetPrinters ( )
li_rtn = of_parse(ls_prntrs,ls_printer, li_cnt, "~n")
If li_rtn = -1 Then Return 0

For li_i = 1 To  UpperBound(ls_printer)
	ll_pos = Pos (ls_printer[li_i], "~t")
	as_printer_name[UpperBound(as_printer_name) + 1] = Left(ls_printer[li_i], ll_pos -1)
Next
Return  UpperBound(as_printer_name)



end function

on nov_runprinter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nov_runprinter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_printexe = of_getmodulepath( ) + "\printer.exe"
end event

