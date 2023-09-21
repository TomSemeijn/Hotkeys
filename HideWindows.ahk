#Requires AutoHotkey v2.0
#SingleInstance Force

hidden := Array()

#h::
{
	if(WinGetTitle("A") == "")
	{
		return
	}
	current := WinGetId("A")
	hidden.Push(current)
	WinHide("ahk_id" current)
}

#+h::
{
	if(hidden.Length > 0)
	{
		UnhideLast()
	}
}

#!h::
{
	while(hidden.Length > 0)
	{
		UnhideLast()
	}
}

UnhideLast() {
	global hidden
	try
	{
		WinShow("ahk_id" hidden[hidden.Length])
		WinActivate("ahk_id" hidden[hidden.Length])
	}
	catch as e
	{
	}
	hidden.Pop()
}