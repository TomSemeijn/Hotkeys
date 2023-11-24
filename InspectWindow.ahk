#Requires AutoHotkey v2.0
#SingleInstance Force

isEnabled := false

^+t:: {
	global isEnabled
	isEnabled := !isEnabled
	
	; Reset tooltip on disable
	if(!isEnabled)
	{
		ToolTip()
	}
}

loop {
	if(isEnabled)
	{
		MouseGetPos(,,&wID, &controlName)
		wTitle := WinGetTitle("ahk_id" wID)
		wClass := WinGetClass("ahk_id" wID)
		wPID := WinGetPID("ahk_id" wID)
		wProcessName := WinGetProcessName("ahk_id" wID)
		wProcessPath := WinGetProcessPath("ahk_id" wID)
		controlText := ""
		try controlText := ControlGetText(controlName, "ahk_id" wID)
		ToolTip("Window: {`n`tID: `t" wID "`n`tPID: `t" wPID "`n`ttitle: `t`"" wTitle "`"`n`tclass: `t`"" wClass "`"`n`tProcess: `t`"" wProcessName "`"`n`tPath: `t`"" wProcessPath "`"`n}`n`nControl: {`n`tName:`t`"" controlName "`"`n`tText:`t`"" controlText "`"`n}")
	}
	sleep(200)
}