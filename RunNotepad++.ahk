#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#include "Lib/Explorer_GetSelection.ahk"
#n::
{
	select := Explorer_GetSelection()
	if(strLen(select) > 0)
	{
		For index, filePath in StrSplit(select, "`n")
		{
			Run Format('notepad++.exe "{1}"', filePath)
			if WinWait("ahk_class Notepad++", , 3)
			{
				WinActivate ; Use the window found by WinWait.
				WinSetStyle "-0xC00000", "A"
			}
		}
	}
	else
	{
		DetectHiddenWindows True
		if(WinGetClass("A") == "Notepad++")
		{
			WinClose "A"
		}
		else if WinExist("ahk_class Notepad++")
		{
			WinActivate
		}
		else
		{
			Run "notepad++"
			if WinWait("ahk_class Notepad++", , 3)
			{
				WinActivate ; Use the window found by WinWait.
				WinSetStyle "-0xC00000", "A"
			}
		}
	}
}
