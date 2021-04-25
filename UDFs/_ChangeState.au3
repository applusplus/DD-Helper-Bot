
#include-once

Func _changePressState($bState = $GUI_DISABLE)
	GUICtrlSetState($InPress, $bState)
	GUICtrlSetState($InInterval, $bState)
	GUICtrlSetState($checkPressHide, $bState)
EndFunc

Func _changeWavePressState($bState = $GUI_DISABLE)
	GUICtrlSetState($InWavePress, $bState)
	GUICtrlSetState($InWaveInterval, $bState)
	GUICtrlSetState($checkWavePressHide, $bState)
	GUICtrlSetState($cbWave, $bState)
EndFunc

Func _changeStartWaveState($bState = $GUI_DISABLE)
	GUICtrlSetState($InStartWave, $bState)
	GUICtrlSetState($ButStartWave, $bState)
EndFunc

Func _changeCoreState($bState, $iCore, $iCtrlID = 3)
	If $iCtrlID >= 1 Then
		GUICtrlSetState($inCore[$iCore], $bState)
		GUICtrlSetState($inMaxCore[$iCore], $bState)
	EndIf
	If $iCtrlID >= 2 Then
		GUICtrlSetState($ButCore[$iCore], $bState)
	EndIf
	If $iCtrlID >= 3 Then
		GUICtrlSetState($checkCoreFreeze[$iCore], $bState)
	EndIf
EndFunc

Func _changeManaState($bState, $iCtrlID = 3)
	If $iCtrlID >= 1 Then
		GUICtrlSetState($InMana, $bState)
	EndIf
	If $iCtrlID >= 2 Then
		GUICtrlSetState($ButMana, $bState)
	EndIf
	If $iCtrlID >= 3 Then
		GUICtrlSetState($checkManaFreeze, $bState)
	EndIf
EndFunc

Func _changePlayHpState($bState, $iCtrlID = 3)
	If $iCtrlID >= 1 Then
		GUICtrlSetState($inPlayHp, $bState)
		GUICtrlSetState($inPlayMaxHp, $bState)
	EndIf
	If $iCtrlID >= 2 Then
		GUICtrlSetState($ButPlayHp, $bState)
	EndIf
	If $iCtrlID >= 3 Then
		GUICtrlSetState($checkPlayHpFreeze, $bState)
	EndIf
EndFunc

Func _changePlayManaState($bState, $iCtrlID = 3)
	If $iCtrlID >= 1 Then
		GUICtrlSetState($inPlayMana, $bState)
		GUICtrlSetState($inPlayMaxMana, $bState)
	EndIf
	If $iCtrlID >= 2 Then
		GUICtrlSetState($ButPlayMana, $bState)
	EndIf
	If $iCtrlID >= 3 Then
		GUICtrlSetState($checkPlayManaFreeze, $bState)
	EndIf
EndFunc

Func _changeUnitsState($bState, $iCtrlID = 3)
	If $iCtrlID >= 1 Then
		GUICtrlSetState($InUnits, $bState)
		GUICtrlSetState($InMaxUnits, $bState)
	EndIf
	If $iCtrlID >= 2 Then
		GUICtrlSetState($ButUnits, $bState)
	EndIf
	If $iCtrlID >= 3 Then
		GUICtrlSetState($checkUnitsFreeze, $bState)
	EndIf
EndFunc