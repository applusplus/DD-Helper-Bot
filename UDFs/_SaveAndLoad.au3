#include-once

#region Save-Load
Func _loadCfg()
	Local $readvar

	;Press
	$readvar = IniRead($INI, "Settings", "PressString", "e")
	GUICtrlSetData($InPress, $readvar)
	$readvar = IniRead($INI, "Settings", "PressInterval", "100")
	GUICtrlSetData($InInterval, $readvar)
	$readvar = IniRead($INI, "Settings", "PressHotkey", "F8")
	GUICtrlSetData($cbPressHotk, $readvar)
	$readvar = IniRead($INI, "Settings", "PressHide", "0")
	GUICtrlSetState($checkPressHide, $readvar)
	;Press Wave
	$readvar = IniRead($INI, "Settings", "PressWaveString", "g")
	GUICtrlSetData($InWavePress, $readvar)
	$readvar = IniRead($INI, "Settings", "PressWaveInterval", "60")
	GUICtrlSetData($InWaveInterval, $readvar)
	$readvar = IniRead($INI, "Settings", "PressWaveHotkey", "F7")
	GUICtrlSetData($cbPressWaveHotk, $readvar)
	$readvar = IniRead($INI, "Settings", "Wave", "0")
	GUICtrlSetData($cbWave, $readvar)
	$readvar = IniRead($INI, "Settings", "PressWaveHide", "0")
	GUICtrlSetState($checkWavePressHide, $readvar)
	;Settings
	$readvar = IniRead($INI, "Settings", "ExtOffsPath", $sOffsIniPath)
	If StringReplace($sOffsIniPath, " ", "") = "" Then
		$sOffsIniPath = $readvar
	EndIf
EndFunc

Func _saveCfg()

	If GUICtrlRead($checkSave) = $GUI_CHECKED Then
		;Press
		IniWrite($INI, "Settings", "PressString", GUICtrlRead($InPress))
		IniWrite($INI, "Settings", "PressInterval", GUICtrlRead($InInterval))
		IniWrite($INI, "Settings", "PressHotkey", GUICtrlRead($cbPressHotk))
		IniWrite($INI, "Settings", "PressHide", GUICtrlRead($checkPressHide))
		;Press Wave
		IniWrite($INI, "Settings", "PressWaveString", GUICtrlRead($InWavePress))
		IniWrite($INI, "Settings", "PressWaveInterval", GUICtrlRead($InWaveInterval))
		IniWrite($INI, "Settings", "PressWaveHotkey", GUICtrlRead($cbPressWaveHotk))
		IniWrite($INI, "Settings", "Wave", GUICtrlRead($cbWave))
		IniWrite($INI, "Settings", "PressWaveHide", GUICtrlRead($checkWavePressHide))

		;Settings
		If $sOffsIniPath <> @ScriptDir&"\DDHBOffsets.ini" Then
			IniWrite($INI, "Settings", "ExtOffsPath", $sOffsIniPath)
		EndIf
	EndIf
EndFunc
#endregion Save-Load

#region Save/Load Offsets
Func _loadOffs()
	Local $read

	$sOffsIniDate = IniRead($sOffsIniPath, "Offsets", "GameVer", "")
	$read = IniRead($sOffsIniPath, "Offsets", "ManaBank", _JSONEncode($xManaOffs))
	_updateOffs($read, $xManaOffs, "ManaBank")
	$read = IniRead($sOffsIniPath, "Offsets", "StartWave", _JSONEncode($xStartWaveOffs))
	_updateOffs($read, $xStartWaveOffs, "StartWave")
	$read = IniRead($sOffsIniPath, "Offsets", "Wave", _JSONEncode($xWavesOffs))
	_updateOffs($read, $xWavesOffs, "Wave")
	$read = IniRead($sOffsIniPath, "Offsets", "Core1", _JSONEncode($xCore1))
	_updateOffs($read, $xCore1, "Core1")
	$read = IniRead($sOffsIniPath, "Offsets", "Core2", _JSONEncode(_getMaxOffs($xCore1, 5)))
	If $read = "" Then
		_updateOffs($read, _JSONEncode(_getMaxOffs($xCore1, 5)), "Core2")
	Else
		_updateOffs($read, $xCore2, "Core2")
	EndIf
	$read = IniRead($sOffsIniPath, "Offsets", "Core3", _JSONEncode(_getMaxOffs($xCore2, 5)))
	If $read = "" Then
		_updateOffs($read, _JSONEncode(_getMaxOffs($xCore2, 5)), "Core2")
	Else
		_updateOffs($read, $xCore3, "Core3")
	EndIf
	$read = IniRead($sOffsIniPath, "Offsets", "Core4", _JSONEncode(_getMaxOffs($xCore3, 5)))
	If $read = "" Then
		_updateOffs($read, _JSONEncode(_getMaxOffs($xCore3, 5)), "Core2")
	Else
		_updateOffs($read, $xCore4, "Core4")
	EndIf
	$xCoresOffs[0] = $xCore1
	$xCoresOffs[1] = $xCore2
	$xCoresOffs[2] = $xCore3
	$xCoresOffs[3] = $xCore4
	$read = IniRead($sOffsIniPath, "Offsets", "PlayerHealth", _JSONEncode($xPlayHpOffs))
	_updateOffs($read, $xPlayHpOffs, "PlayerHealth")
	$read = IniRead($sOffsIniPath, "Offsets", "PlayerMana", _JSONEncode($xPlayManaOffs))
	_updateOffs($read, $xPlayManaOffs, "PlayerMana")
	$read = IniRead($sOffsIniPath, "Offsets", "DefUnits", _JSONEncode($xUnitsOffs))
	_updateOffs($read, $xUnitsOffs, "DefUnits")
	_calcMaxOffs()

	_iniState("Loaded", 0x00AD00 )
	GUICtrlSetState($ButIniShow, $GUI_ENABLE)
EndFunc

Func _iniState($sState, $xColor, $sPath = $sOffsIniPath)
	GUICtrlSetData($InOffsIni, $sPath)
	GUICtrlSetData($LabOffsIniState, $sState)
	GUICtrlSetColor($LabOffsIniState, $xColor)
EndFunc

Func _updateOffs($read, ByRef $aOffs, $sKey = "")
	Local $array

	If $read <> "" Then
		$read = _formatArray($read)
		$array = _JSONDecode($read)
		If IsArray($array) Then
			ReDim $aOffs[UBound($array)]
			$aOffs = $array
		EndIf
	EndIf
EndFunc

Func _formatArray($sArray)
	If StringReplace($sArray, " ", "") <> "" Then
		$sArray = StringReplace($sArray, "[", "")
		$sArray = StringReplace($sArray, "]", "")
		$sArray = StringReplace($sArray, "{", "")
		$sArray = StringReplace($sArray, "}", "")
		$aSplit = StringSplit($sArray, ",")
		If IsArray($aSplit) Then
			$sArray = "{ "
			For $i = 1 To $aSplit[0]
				$sArray &= Dec(Hex(StringReplace($aSplit[$i], " ", "")))
				If $i < $aSplit[0] Then
					$sArray &= ", "
				EndIf
			Next
			$sArray &= " }"
		EndIf
	EndIf
	Return $sArray
EndFunc

;~ Func _saveOffs()
;~ 	Local $sCrypt
;~ 	;$sCrypt = _AesEncrypt($CRYPT_PW+"Check", $sCheckOffs)
;~ 	;IniWrite($sOffsIniPath, "Offsets", "Check", $sCrypt)
;~ 	_iniWrite($xManaOffs, "ManaBank")
;~ 	_iniWrite($xStartWaveOffs, "StartWave")
;~ 	_iniWrite($xWavesOffs, "Wave")
;~ 	_iniWrite($xCore1, "Core1")
;~ 	_iniWrite($xCore2, "Core2")
;~ 	_iniWrite($xCore3, "Core3")
;~ 	_iniWrite($xCore4, "Core4")
;~ 	_iniWrite($xPlayHpOffs, "PlayerHealth")
;~ 	_iniWrite($xPlayManaOffs, "PlayerMana")
;~ 	_iniWrite($xUnitsOffs, "DefUnits")
;~ EndFunc

;~ Func _iniWrite($aOffs, $sKey)
;~ 	Local $sJSON

;~ 	$sJSON = _JSONEncode($aOffs)
;~ 	;$sJSON = _AesEncrypt($CRYPT_PW+$sKey, $sJSON)
;~ 	IniWrite($sOffsIniPath, "Offsets", $sKey, $sJSON)
;~ EndFunc
#endregion Save/Load Offsets

;~ Func _updateOffs($read, ByRef $aOffs, $sKey)
;~ 	Local $array

;~ 	If $read <> "" Then
;~ 		;$read = BinaryToString(_AesDecrypt($CRYPT_PW+$sKey, $read))
;~ 		If $read <> "" Then
;~ 			$array = _JSONDecode($read)
;~ 			If IsArray($array) Then
;~ 				ReDim $aOffs[UBound($array)]
;~ 				$aOffs = $array
;~ 			EndIf
;~ 		EndIf
;~ 	EndIf
;~ EndFunc

