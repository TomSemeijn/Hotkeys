#Requires AutoHotkey v2.0
#SingleInstance Force
^space::
{
	try
		WinSetAlwaysOnTop -1, "A"
}