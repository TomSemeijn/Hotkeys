#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#include "Lib/Explorer_GetSelection.ahk"

#+D::
{
	select := Explorer_GetSelection()
	if(strLen(select) > 0)
	{
		For index, filePath in StrSplit(select, "`n")
		{
			SplitPath filePath, &filename
			Run Format('powershell -NoExit -Command $host.UI.RawUI.WindowTitle = """{2}"""; Get-Content """{1}""" -Wait | ForEach {Write-Host -ForegroundColor $(if($_ -clike """*ERROR*""" -or $_ -clike """*EROR*""") {"""Red"""} elseif($_ -clike """*WARN*""") {"""DarkYellow"""} elseif($_ -clike """*DBUG*""" -or $_ -clike """*DEBUG*""") {"""Magenta"""} elseif($_ -clike """##################*""") {"""DarkGreen"""} else {"""White"""}) "$_"}', filePath, filename)
		}
	}
}
