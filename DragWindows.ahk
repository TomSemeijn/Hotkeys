#Requires AutoHotkey v2.0
#SingleInstance Force

draggedWindow := -1
windowMouseOffsetX := 0
windowMouseOffsetY := 0

#LButton::
{
	global draggedWindow
	global windowMouseOffsetX
	global windowMouseOffsetY
	MouseGetPos &mouseX,&mouseY,&currentWindow
	state := WinGetMinMax("ahk_id" currentWindow)
	if(state != 0)
	{
		WinRestore("ahk_id" currentWindow)
		sleep 100
		WinGetPos(,,&winWidth,&winHeight,"ahk_id" currentWindow)
		windowMouseOffsetX := -Round(winWidth / 2)
		windowMouseOffsetY := -Round(winHeight / 2)
	}
	else
	{
		WinGetPos(&winX,&winY,,,"ahk_id" currentWindow)
		windowMouseOffsetX := Round(winX - mouseX)
		windowMouseOffsetY := Round(winY - mouseY)
	}
	draggedWindow := currentWindow
}

#LButton Up::
{
	global draggedWindow
	draggedWindow := -1
	windowMouseOffsetX := 0
	windowMouseOffsetY := 0
}

lastMouseX := -1
lastMouseY := -1
CoordMode "Mouse", "Screen"
loop
{
	If(draggedWindow != -1)
	{
		MouseGetPos(&mouseX, &mouseY)
		if(mouseX != lastMouseX or mouseY != lastMouseY)
		{
			WinMove(Round(mouseX + windowMouseOffsetX), Round(mouseY + windowMouseOffsetY),,,"ahk_id" draggedWindow)
			lastMouseX := mouseX
			lastMouseY := mouseY
		}
	}
	Else
	{
		sleep 100
	}
}