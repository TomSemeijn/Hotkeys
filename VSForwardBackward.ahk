#Requires AutoHotkey v2.0
#SingleInstance Force

#Hotif WinActive("ahk_exe devenv.exe")
!left::
{
	Send "^-"
}

#Hotif WinActive("ahk_exe devenv.exe")
!right::
{
	Send "^+-"
}