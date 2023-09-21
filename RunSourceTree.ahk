#Requires AutoHotkey v2.0
#SingleInstance Force

#s::
{
	try
		if WinExist("ahk_class" WinGetClass("Sourcetree"))
			WinActivate  ; Activate the window found above
		else
			Run "C:\Users\tsemeijn\AppData\Local\SourceTree\SourceTree"
	catch as e
		Run "C:\Users\tsemeijn\AppData\Local\SourceTree\SourceTree"
}