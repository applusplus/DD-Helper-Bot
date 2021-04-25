
#region Changelog
Func _showChangelog()
	Local $fopen, $sChangeLog

	FileInstall(".\ReadMe.txt", $CHANGE_LOG, 1)
	GUISetState(@SW_DISABLE, $Form)
	$FromLog = GUICreate("Changelog", 453, 367, -1, -1, BitOR($DS_MODALFRAME, $DS_SETFOREGROUND, $WS_SYSMENU), $WS_EX_TOOLWINDOW, $Form)
	$ChangeEdit = GUICtrlCreateEdit("", 4, 4, 441, 337, BitOR($GUI_SS_DEFAULT_EDIT,$ES_READONLY))
	GUISetState(@SW_SHOW)
	$fopen = FileOpen($CHANGE_LOG)
	$sChangeLog = FileRead($fopen)
	FileClose($fopen)
	GUICtrlSetData($ChangeEdit, $sChangeLog)
	While 1
        If GUIGetMsg() = $GUI_EVENT_CLOSE Then
			ExitLoop
		EndIf
    WEnd
	_changeLogClose()
EndFunc

Func _changeLogClose()
	GUISetState(@SW_ENABLE, $Form)
	GUIDelete($FromLog)
	FileDelete($CHANGE_LOG)
EndFunc
#endregion Changelog
