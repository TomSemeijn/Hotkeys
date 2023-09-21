#Requires AutoHotkey v2.0
#SingleInstance Force
#b::
{
	ids := WinGetList(,, "Program Manager")
	if(ids.Length > 0)
	{
		any_active := true
		active_id := -1
		try
			active_id := WinGetID("A")
		catch
			any_active := false
	
		target_id := ids[1]
		if(any_active)
		{
			Loop ids.Length
			{
				if(ids[A_Index] == active_id)
				{
					if(A_Index + 1 <= ids.Length)
					{
						target_id := ids[A_Index + 1]
					}
					break
				}
			}
		}
		WinMoveBottom("ahk_id" active_id)
		WinActivate("ahk_id" target_id)
	}
}