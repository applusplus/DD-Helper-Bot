#include-once

Func _PressKeysManager($sKey)
	Switch $sKey
		Case "Mouse1"
			$sKey = "01"
		Case "Mouse2"
			$sKey = "02"
		Case "Mouse3"
			$sKey = "04"
		Case "Mouse4"
			$sKey = "05"
		Case "Mouse5"
			$sKey = "06"
		Case "F1"
			$sKey = "70"
		Case "F2"
			$sKey = "71"
		Case "F3"
			$sKey = "72"
		Case "F4"
			$sKey = "73"
		Case "F5"
			$sKey = "74"
		Case "F6"
			$sKey = "75"
		Case "F7"
			$sKey = "76"
		Case "F8"
			$sKey = "77"
		Case "F9"
			$sKey = "78"
		Case "F10"
			$sKey = "79"
		Case "F11"
			$sKey = "7A"
		Case "F12"
			$sKey = "7B"
		Case "Spacebar"
			$sKey = "20"
	EndSwitch
	Return $sKey
EndFunc   ;==>_PressKeysManager