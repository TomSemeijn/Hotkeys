Explorer_GetSelection() {

	;check if explorer
	winClass := WinGetClass("ahk_id" . hWnd := WinExist("A"))
	if !(winClass ~= "^(Progman|WorkerW|(Cabinet|Explore)WClass)$")
		Return
		
	;if desktop
	if (winClass ~= "Progman|WorkerW") ;IShellWindows::Item: https://goo.gl/ihW9Gm ; IShellFolderViewDual: https://goo.gl/gnntq3
	{
		shellWindows := ComObject("Shell.Application").Windows
		shellFolderView := shellWindows.Item(ComObject(VT_UI4 := 0x13, SWC_DESKTOP := 0x8)).Document
		result := ""
		for item in shellFolderView.SelectedItems
		{
			result .= (result = "" ? "" : "`n") . item.Path
		}
		return result
	}
	
	;if not desktop
	try activeTab := ControlGetHwnd("ShellTabWindowClass1", hwnd)
	for w in ComObject("Shell.Application").Windows {
		if w.hwnd != hwnd
			continue
		if IsSet(activeTab) {
			static IID_IShellBrowser := "{000214E2-0000-0000-C000-000000000046}"
			shellBrowser := ComObjQuery(w, IID_IShellBrowser, IID_IShellBrowser)
			ComCall(3, shellBrowser, "uint*", &thisTab:=0)
			if thisTab != activeTab
				continue
		}
		foundWin := w
		break
	}
	str := ""
	for i in foundWin.Document.SelectedItems
		str .= i.Path "`n"
	return str
}