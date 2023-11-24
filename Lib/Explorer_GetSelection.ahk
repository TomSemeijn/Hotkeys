Explorer_GetSelection() {

	;check if explorer
	winClass := WinGetClass("ahk_id" . hWnd := WinExist("A"))
	if !(winClass ~= "^(Progman|WorkerW|(Cabinet|Explore)WClass)$")
		Return
		
	;if desktop
	if (winClass ~= "Progman|WorkerW") ;IShellWindows::Item: https://goo.gl/ihW9Gm ; IShellFolderViewDual: https://goo.gl/gnntq3
	{
		ret := ""
		Try hwWindow := ControlGetHwnd('SysListView321', 'ahk_class Progman')
				hwWindow := ControlGetHwnd('SysListView321', 'A')
		Loop Parse ListViewGetContent('Selected Col1', hwWindow), '`n', '`r'
			ret .= A_Desktop '\' A_LoopField '`n'
		Return getFilesWithExtenstions(Trim(ret, '`n'))
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
	if(StrLen(str) > 0)
		str := SubStr(str, 1, StrLen(str) - 1)
	return str
}

getFilesWithExtenstions(files)
{
	if(strLen(files) > 0)
	{
		newStr := ""
		For index, filePath in StrSplit(files, "`n")
		{
			SplitPath filePath, &name, &dir, &ext, &name_no_ext, &drive
			if(strLen(ext) > 0)
			{
				newStr .= filepath "`n"
			}
			else
			{
				Loop Files, dir "/*", "F"
				{
					SplitPath A_LoopFileFullPath,,,&currentExt,&currentName
					if(StrCompare(currentName, name, True) == 0)
					{
						newStr .= A_LoopFileFullPath "`n"
						break
					}
				}
			}
		}
		files := newStr
	}
	return Trim(files, '`n')
}