#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#include "Lib/WinIsHidden.ahk"

^+h::ShowGUI

MyGui := 0
ListView := 0
SearchBox := 0
messageCheckbox := 0

DoMessage := False

ShowGUI()
{
	global MyGui
	global ListView
	global SearchBox
	global messageCheckbox
	
	MyGui := Gui()
	
	;messageCheckbox := MyGui.Add("Checkbox",,"Show Messages?")
	;messageCheckbox.OnEvent("Click", OnCheckUncheck)
	
	MyGui.Add("Text",,"Search: ")
	SearchBox := MyGui.Add("Edit", "w640",)
	SearchBox.OnEvent("Change", OnSearchChange)
	
	ListView := MyGui.Add("ListView", "w640 r30", ["exe", "title","winID"])
	ListView.OnEvent("DoubleClick", UnHide)
	
	PopulateListView()
	
	refreshButton := MyGui.Add("Button","xM+590 y0", "Refresh")
	refreshButton.OnEvent("Click", OnRefresh)
	
	MyGui.Show()
}

IsTitleExcluded(title)
{
	excludedTitles := ["Default IME", "MSCTFIME UI"]
	for excluded in excludedTitles
	{
		if(StrCompare(title, excluded, True) == 0)
		{
			return True
		}
	}
	return False
}

PopulateListView()
{
	global MyGui
	global ListView
	global SearchBox
	global DoMessage
	
	searchStr := SearchBox.Value
	doSearch := StrLen(searchStr) > 0
	
	ListView.Delete()
	
	DetectHiddenWindows True
	for winID in WinGetList(,, "Program Manager")
	{
		try
		{
			DetectHiddenWindows True
			title := WinGetTitle("ahk_id" winID)
			executable := WinGetProcessName("ahk_id" winID)
			if(doSearch == 0 or InStr(executable, searchStr) or InStr(title, searchStr))
			{
				if(StrLen(title) > 0)
				{
					if(!IsTitleExcluded(title) && WinIsHidden(winID))
					{
						ListView.Add(,executable,title,winID)
					}
				}
			}
		}
	}
	
	ListView.ModifyCol(1,)
	ListView.ModifyCol(2,)
	ListView.ModifyCol(3,)
	ListView.ModifyCol(1,"Sort")
}

OnSearchChange(*)
{
	PopulateListView()
}

OnRefresh(*)
{
	PopulateListView()
}

OnCheckUncheck(*)
{
	global messageCheckbox
	global DoMessage
	
	DoMessage := messageCheckbox.Value
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

