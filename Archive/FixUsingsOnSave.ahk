#Requires AutoHotkey v2.0
#SingleInstance Force

#Hotif WinActive("ahk_exe devenv.exe")
^s::
{
	Send "^r^g"
	Send "^s"
}