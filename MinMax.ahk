#Requires AutoHotkey v2.0
#SingleInstance Force

lastMinimized := -1

^MButton::
{
	MouseGetPos ,,&winID
	state := WinGetMinMax("ahk_id" winID)
	if(state != 0)
	{
		WinRestore("ahk_id" winID)
	}
	else
	{
		WinMaximize("ahk_id" winID)
	}
}

+MButton::
{
	global lastMinimized
	MouseGetPos ,,&winID
	if(ShouldApplyToWindow(winID))
	{
		state := WinGetMinMax("ahk_id" winID)
		WinMinimize("ahk_id" winID)
		lastMinimized := winID
	}
}

#MButton::
{
	MouseGetPos ,,&winID
	if(ShouldApplyToWindow(winID))
	{
		state := WinGetMinMax("ahk_id" winID)
		WinClose("ahk_id" winID)
	}
}

+RButton::
{
	global lastMinimized
	if(WinExist("ahk_id" lastMinimized))
	{
		WinRestore "ahk_id" lastMinimized
	}
}

ShouldApplyToWindow(winID)
{
	try
	{
		return WinGetProcessName("ahk_id" winID) != "blender.exe"
	}
	return False
}