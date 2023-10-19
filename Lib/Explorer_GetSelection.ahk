Explorer_GetSelection(hwnd := '', selection := True) {
	; https://www.autohotkey.com/boards/viewtopic.php?p=509165#p509165
	hwWindow := ''
	Switch window := explorerGetWindow(hwnd) {
		Case '': Return 'ERROR'
		Case 'desktop':
			Try hwWindow := ControlGetHwnd('SysListView321', 'ahk_class Progman')
				hwWindow := hwWindow || ControlGetHwnd('SysListView321', 'A')
			Loop Parse ListViewGetContent((selection ? 'Selected' : '') ' Col1', hwWindow), '`n', '`r'
				ret .= A_Desktop '\' A_LoopField '`n'
		Default:
			For item in selection ? window.document.SelectedItems : window.document.Folder.Items
				ret .= item.path '`n'
	}
	Return getFilesWithExtenstions(Trim(ret, '`n'))
}

explorerGetWindow(hwnd := '') {
	class := WinGetClass(hwnd := hwnd || WinExist('A'))
	Switch {
		Case WinGetProcessName(hwnd) != 'explorer.exe': Return
		Case class ~= 'Progman|WorkerW': Return 'desktop'
		Case class ~= '(Cabinet|Explore)WClass':
			For window in ComObject('Shell.Application').Windows
				Try If window.hwnd = hwnd
					Return window
	}
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