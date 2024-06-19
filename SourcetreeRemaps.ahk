#Requires AutoHotkey v2.0
#SingleInstance Force

#Hotif WinActive("ahk_exe SourceTree.exe")
#escape::
{
	Send "+^{R}"
}