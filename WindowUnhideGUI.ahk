#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#include "Lib/WinIsHidden.ahk"

^+h::ShowGUI

MyGui := 0

ShowGUI()
{
	global MyGui
	MyGui := Gui()
	ListView := MyGui.Add("ListView", "w640 r30", ["exe", "title","winID"])
	ListView.OnEvent("DoubleClick", UnHide)
	
	DetectHiddenWindows True
	for winID in WinGetList(,, "Program Manager")
	{
		try
		{
			DetectHiddenWindows True
			title := WinGetTitle("ahk_id" winID)
			executable := WinGetProcessName("ahk_id" winID)
			if(StrLen(title) > 0)
			{
				if(WinIsHidden(winID))
				{
					ListView.Add(,executable,title,winID)
				}
			}
		}
	}
	
	ListView.ModifyCol(1,)
	ListView.ModifyCol(2,)
	ListView.ModifyCol(3,)
	ListView.ModifyCol(1,"Sort")
	
	MyGui.Show()
}

UnHide(ListView, RowNumber)
{
	global MyGui
	
	winID := ListView.GetText(RowNumber, 3)
	WinShow("ahk_id" winID)
	WinActivate("ahk_id" winID)
	ListView.Delete(RowNumber)
	
	MyGui.Hide()
}

