#Requires AutoHotkey v2.0
#SingleInstance Force

loop {
	; Wait for a popup to open
	winID := WinWait("Microsoft Visual Studio", "The source control provider associated with this solution could not be found.")
		
	; Close the popup by clicking on Buton2 (No)
	try {
		ControlClick("Button2", "ahk_id" winID)
	}
	catch as e
	{
		; In this case, this popup has been manually closed, this is fine, we skip
	}
	
	; Sleep for a bit before continuing
	; Ensures this popup is closed before we scan again
	sleep 1000
}