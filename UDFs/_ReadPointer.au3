
#include-once

Func _readPointer($aOffsets, $pInfo, $iPointer = 0)
	Local $adress
	$adress = 0x400000
	For $i = 0 To UBound($aOffsets)-1
		If $adress <> 0 Then
			If $i = UBound($aOffsets)-1 And ($iPointer <> 1 Or $aOffsets[$i] = 0) Then
				$adress = $adress+$aOffsets[$i]
			Else
				$adress = _MemoryRead($adress+$aOffsets[$i],$pInfo)
			EndIf
		ElseIf $adress = 0 Then
			Return -1
		EndIf
	Next
	Return $adress
EndFunc

Func _getMaxOffs($aOffsets, $iRightItem = 1)
	If IsArray($aOffsets) Then
		$aOffsets[UBound($aOffsets)-$iRightItem] += 4
		Return $aOffsets
	EndIf
	Return -1
EndFunc

Func _calcMaxOffs()
	$xCoresMaxOffs[0] = _getMaxOffs($xCore1)
	$xCoresMaxOffs[1] = _getMaxOffs($xCore2)
	$xCoresMaxOffs[2] = _getMaxOffs($xCore3)
	$xCoresMaxOffs[3] = _getMaxOffs($xCore4)
	$xPlayHpMaxOffs = _getMaxOffs($xPlayHpOffs)
	$xPlayManaMaxOffs = _getMaxOffs($xPlayManaOffs)
	$xUnitsMaxOffs = _getMaxOffs($xUnitsOffs)
EndFunc