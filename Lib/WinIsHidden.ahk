WinIsHidden(winID) {
	try
	{
		style := WinGetStyle("ahk_id" winID)
		if(style & 0x10000000)
		{
			return False
		}
	}
	return True
}