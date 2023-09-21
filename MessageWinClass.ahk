#Requires AutoHotkey v2.0
#SingleInstance Force
^!w::MsgBox "The active window's class is " WinGetClass("A") " and its title is " WinGetTitle("A") " and its exe is " WinGetProcessName("A")