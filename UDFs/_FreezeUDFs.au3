#include-once

#region Freeze functions
Func _core0Freeze()
	Local $iCore = 0
	$aCoreValue[$iCore] = _MemoryRead($CoreAdress[$iCore],$pInfoDD)
	If $aCoreValue[$iCore] <> $aCoreValue_frozen[$iCore] Then
		_MemoryWrite($CoreAdress[$iCore], $pInfoDD, $aCoreValue_frozen[$iCore])
	EndIf
EndFunc

Func _core1Freeze()
	Local $iCore = 1
	$aCoreValue[$iCore] = _MemoryRead($CoreAdress[$iCore],$pInfoDD)
	If $aCoreValue[$iCore] <> $aCoreValue_frozen[$iCore] Then
		_MemoryWrite($CoreAdress[$iCore], $pInfoDD, $aCoreValue_frozen[$iCore])
	EndIf
EndFunc

Func _core2Freeze()
	Local $iCore = 2
	$aCoreValue[$iCore] = _MemoryRead($CoreAdress[$iCore],$pInfoDD)
	If $aCoreValue[$iCore] <> $aCoreValue_frozen[$iCore] Then
		_MemoryWrite($CoreAdress[$iCore], $pInfoDD, $aCoreValue_frozen[$iCore])
	EndIf
EndFunc

Func _core3Freeze()
	Local $iCore = 3
	$aCoreValue[$iCore] = _MemoryRead($CoreAdress[$iCore],$pInfoDD)
	If $aCoreValue[$iCore] <> $aCoreValue_frozen[$iCore] Then
		_MemoryWrite($CoreAdress[$iCore], $pInfoDD, $aCoreValue_frozen[$iCore])
	EndIf
EndFunc

Func _manaFreeze()
	$iManaValue = _MemoryRead($ManaAdress,$pInfoDD)
	If $iManaValue <> $iManaValue_frozen Then
		_MemoryWrite($ManaAdress, $pInfoDD, $iManaValue_frozen)
	EndIf
EndFunc

Func _playHpFreeze()
	$iPlayHpValue = _MemoryRead($PlayHpAdress,$pInfoDD)
	If $iPlayHpValue <> $iPlayHpValue_frozen Then
		_MemoryWrite($PlayHpAdress, $pInfoDD, $iPlayHpValue_frozen)
	EndIf
EndFunc

Func _playManaFreeze()
	$iPlayManaValue = _MemoryRead($PlayManaAdress,$pInfoDD)
	If $iPlayManaValue <> $iPlayManaValue_frozen Then
		_MemoryWrite($PlayManaAdress, $pInfoDD, $iPlayManaValue_frozen)
	EndIf
EndFunc

Func _unitsFreeze()
	$iUnitsValue = _MemoryRead($UnitsAdress,$pInfoDD)
	If $iUnitsValue <> $iUnitsValue_frozen Then
		_MemoryWrite($UnitsAdress, $pInfoDD, $iUnitsValue_frozen)
	EndIf
EndFunc
#endregion Freeze functions

#region Check the Freeze Checkbox
Func _freezeManaCheck()
	If GUICtrlRead($checkManaFreeze) = $GUI_CHECKED Then
		$iManaValue_frozen = GUICtrlRead($InMana)
		_changeManaState($GUI_DISABLE, 2)
		AdlibRegister("_manaFreeze", 300)
	Else
		_changeManaState($GUI_ENABLE, 2)
		AdlibUnRegister("_manaFreeze")
	EndIf
EndFunc

Func _freezeCoreCheck($iCore)
	If GUICtrlRead($checkCoreFreeze[$iCore]) = $GUI_CHECKED Then
		$aCoreValue_frozen[$iCore] = GUICtrlRead($inCore[$iCore])
		_changeCoreState($GUI_DISABLE, $iCore, 2)
		AdlibRegister("_core"&$iCore&"Freeze", 400)
	Else
		_changeCoreState($GUI_ENABLE, $iCore, 2)
		AdlibUnRegister("_core"&$iCore&"Freeze")
	EndIf
EndFunc

Func _freezePlayHpCheck()
	If GUICtrlRead($checkPlayHpFreeze) = $GUI_CHECKED Then
		$iPlayHpValue_frozen = GUICtrlRead($inPlayHp)
		_changePlayHpState($GUI_DISABLE, 2)
		AdlibRegister("_playHpFreeze", 350)
	Else
		_changePlayHpState($GUI_ENABLE, 2)
		AdlibUnRegister("_playHpFreeze")
	EndIf
EndFunc

Func _freezePlayManaCheck()
	If GUICtrlRead($checkPlayManaFreeze) = $GUI_CHECKED Then
		$iPlayManaValue_frozen = GUICtrlRead($inPlayMana)
		_changePlayManaState($GUI_DISABLE, 2)
		AdlibRegister("_playManaFreeze", 350)
	Else
		_changePlayManaState($GUI_ENABLE, 2)
		AdlibUnRegister("_playManaFreeze")
	EndIf
EndFunc

Func _freezeUnitsCheck()
	If GUICtrlRead($checkUnitsFreeze) = $GUI_CHECKED Then
		$iUnitsValue_frozen = GUICtrlRead($InUnits)
		_changeUnitsState($GUI_DISABLE, 2)
		AdlibRegister("_unitsFreeze", 300)
	Else
		_changeUnitsState($GUI_ENABLE, 2)
		AdlibUnRegister("_unitsFreeze")
	EndIf
EndFunc
#endregion Check the Freeze Checkbox