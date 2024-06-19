#Requires AutoHotkey v2.0
#SingleInstance Force

#Hotif WinActive("ahk_exe devenv.exe")
#escape::
{
	Send "^{CtrlBreak}"
	Send "+{F5}"
}