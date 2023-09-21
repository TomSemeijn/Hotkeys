#Requires AutoHotkey v2.0
#SingleInstance Force

#Include "%A_ScriptDir%"
#include "Lib/GetAppData.ahk"

#s::
{
	try
		if WinExist("ahk_class" WinGetClass("Sourcetree"))
			WinActivate  ; Activate the window found above
		else
			Run GetAppData() "\Local\SourceTree\SourceTree"
	catch as e
		Run GetAppData() "\Local\SourceTree\SourceTree"
}