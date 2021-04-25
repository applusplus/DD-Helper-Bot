#include-once

#region ReadMemory
Func _readMana()
	$iManaValue = _MemoryRead($ManaAdress,$pInfoDD)
	If $iManaValue < 0 Then
		GUICtrlSetData($InMana, "Error")
	Else
		GUICtrlSetData($InMana, $iManaValue)
	EndIf
EndFunc

Func _readCore()
	For $i = 0 To UBound($CoreAdress)-1
		$aCoreValue[$i] = _MemoryRead($CoreAdress[$i], $pInfoDD)
		If $aCoreValue[$i] < 1 Or $aCoreValue[$i] > 1000000 Then
			$aCoreValue[$i] = "No Core"
		EndIf
		GUICtrlSetData($inCore[$i], $aCoreValue[$i])
	Next
	For $i = 0 To UBound($MaxCoreAdress)-1
		$aMaxCoreValue[$i] = _MemoryRead($MaxCoreAdress[$i], $pInfoDD)
		If $aMaxCoreValue[$i] < 1 Or $aMaxCoreValue[$i] > 1000000 Then
			$aMaxCoreValue[$i] = "No Core"
		EndIf
		GUICtrlSetData($inMaxCore[$i], $aMaxCoreValue[$i])
	Next
EndFunc

Func _readStartWave()
	$iStartWaveValue = _MemoryRead($StartWaveAdress,$pInfoDD)
	If $iStartWaveValue < 1 Then
		GUICtrlSetData($InStartWave, "Not found")
	Else
		GUICtrlSetData($InStartWave, $iStartWaveValue)
	EndIf
EndFunc

Func _readCurWave()
	$iWaveValue = _MemoryRead($WaveAdress,$pInfoDD)
	If $iWaveValue < 1 Then
		GUICtrlSetData($inCurWave, "Not found")
	ElseIf $iWaveValue > 10000 Then
		GUICtrlSetData($inCurWave, "Error")
	Else
		GUICtrlSetData($inCurWave, $iWaveValue)
	EndIf
EndFunc

Func _readPlayHp()
	$iPlayHpValue = _MemoryRead($PlayHpAdress,$pInfoDD)
	If $iPlayHpValue < 0 Then
		GUICtrlSetData($InPlayHp, "Error")
	Else
		GUICtrlSetData($InPlayHp, $iPlayHpValue)
	EndIf
	$iPlayMaxHpValue = _MemoryRead($PlayMaxHpAdress,$pInfoDD)
	If $iPlayMaxHpValue < 0 Then
		GUICtrlSetData($InPlayMaxHp, "Error")
	Else
		GUICtrlSetData($InPlayMaxHp, $iPlayMaxHpValue)
	EndIf
EndFunc

Func _readPlayMana()
	$iPlayManaValue = _MemoryRead($PlayManaAdress,$pInfoDD)
	If $iPlayManaValue < 0 Then
		GUICtrlSetData($InPlayMana, "Error")
	Else
		GUICtrlSetData($InPlayMana, $iPlayManaValue)
	EndIf
	$iPlayMaxManaValue = _MemoryRead($PlayMaxManaAdress,$pInfoDD)
	If $iPlayMaxManaValue < 0 Then
		GUICtrlSetData($InPlayMaxMana, "Error")
	Else
		GUICtrlSetData($InPlayMaxMana, $iPlayMaxManaValue)
	EndIf
EndFunc

Func _readUnits()
	$iUnitsValue = _MemoryRead($UnitsAdress,$pInfoDD)
	If $iUnitsValue < 0 Then
		GUICtrlSetData($InUnits, "Error")
	Else
		GUICtrlSetData($InUnits, $iUnitsValue)
	EndIf
	$iMaxUnitsValue = _MemoryRead($MaxUnitsAdress,$pInfoDD)
	If $iMaxUnitsValue < 0 Then
		GUICtrlSetData($InMaxUnits, "Error")
	Else
		GUICtrlSetData($InMaxUnits, $iMaxUnitsValue)
	EndIf
EndFunc
#endregion ReadMemory

#region WriteMemory
Func _writeMana($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Mana Value!")
		_readMana()
	Else
		_MemoryWrite($ManaAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writeStartWave($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Start Wave Value!")
		_readStartWave()
	Else
		_MemoryWrite($StartWaveAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writeWave($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 1 Then
		MsgBox(48, "Error", "Wrong Wave Value!")
		_readCurWave()
	Else
		_MemoryWrite($WaveAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writeCore($iValue, $iCore)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Core Health Value!")
		_readCore()
	Else
		_MemoryWrite($CoreAdress[$iCore], $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writeMaxCore($iValue, $iCore)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Max Core Health Value!")
		_readCore()
	Else
		_MemoryWrite($MaxCoreAdress[$iCore], $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writePlayHp($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Health Value!")
		_readPlayHp()
	Else
		_MemoryWrite($PlayHpAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writePlayMaxHp($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Max Health Value!")
		_readPlayHp()
	Else
		_MemoryWrite($PlayMaxHpAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writePlayMana($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Mana Value!")
		_readPlayMana()
	Else
		_MemoryWrite($PlayManaAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writePlayMaxMana($iValue)
	If StringIsInt($iValue) <> 1 Or $iValue < 0 Then
		MsgBox(48, "Error", "Wrong Max Mana Value!")
		_readPlayMana()
	Else
		_MemoryWrite($PlayMaxManaAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writeUnits($iValue)
	If StringIsInt($iValue) <> 1 Then
		MsgBox(48, "Error", "Wrong Units Value!")
		_readUnits()
	Else
		_MemoryWrite($UnitsAdress, $pInfoDD, $iValue)
	EndIf
EndFunc

Func _writeMaxUnits($iValue)
	If StringIsInt($iValue) <> 1 Then
		MsgBox(48, "Error", "Wrong Max Units Value!")
		_readUnits()
	Else
		_MemoryWrite($MaxUnitsAdress, $pInfoDD, $iValue)
	EndIf
EndFunc
#endregion WriteMemory