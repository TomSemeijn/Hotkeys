#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#include "Lib/Explorer_GetSelection.ahk"

#p::
{
	select := Explorer_GetSelection()
	if(strLen(select) > 0)
	{
		For index, filePath in StrSplit(select, "`n")
		{
			Run Format('paintdotnet:"{1}"', filePath)
			if WinWait("ahk_exe paintdotnet.exe", , 3)
			{
				WinActivate ; Use the window found by WinWait.
			}
		}
	}
	else
	{
		DetectHiddenWindows True
		if(WinGetProcessName("A") == "paintdotnet.exe")
		{
			Return
		}
		else if WinExist("ahk_exe paintdotnet.exe")
		{
			WinActivate
		}
		else
		{
			Run "paintdotnet.exe"
			if WinWait("ahk_exe paintdotnet.exe", , 3)
			{
				WinActivate ; Use the window found by WinWait.
			}
		}
	}
}
