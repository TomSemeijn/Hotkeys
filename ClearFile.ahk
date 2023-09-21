#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#include "Lib/Explorer_GetSelection.ahk"

#+E::
{
	select := Explorer_GetSelection()
	if(strLen(select) > 0)
	{
		For index, filePath in StrSplit(select, "`n")
		{
			Run Format('powershell -Command Clear-Content """{1}"""', filePath)
		}
	}
}
