#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=good_student.ico
#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=applusplus
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <String.au3>
#include <Array.au3>
#cs=============================================================================
  AutoIt Version: 3.3.8.1
  Author: applusplus
  Description: The Offset Manager helps you to generate a file with offsets
			for the DD Helper Bot. You just need some Cheats Engine knowledge
			to find out offsets for the last game update.
#ce============================================================================
Global Const $VERSION = "1.0"
Global Const $NAME = "Offsets Manager v"
Global Const $COPYRIGHT = "applusplus"
Global Const $CRYPT_PW = "6967726f6d616e7275"

Global $sIniPath  = @ScriptDir&"\DDHBOffsets.ini"

If $CmdLine[0] > 0 And $CmdLine[1] = "/ini" Then
	$sIniPath = $CmdLine[2]
EndIf

#Region ### START Koda GUI section ### Form=C:\Users\alexanderp\Sachen\AIT\DD Helper Bot\DD Helper Bot - Offsets Manager\Offsets Manager.kxf
$Form1 = GUICreate("DD Helper Bot - " & $NAME & $VERSION , 402, 443, -1, -1)
$aSize = WinGetClientSize($Form1)
$LabCopyright = GUICtrlCreateLabel($COPYRIGHT & " © 2012", $aSize[0]/2-50, $aSize[1]-18, 99, 21)
GUICtrlSetFont(-1, 8, 800, 0, "Ebrima")
GUICtrlSetColor(-1, 0x0066CC)
$GroupTavern = GUICtrlCreateGroup("Tavern", 12, 12, 373, 85)
$LabManaBank = GUICtrlCreateLabel("Mana Bank:", 16, 34, 62, 17)
$InManaBank = GUICtrlCreateInput("", 82, 31, 281, 21)
$LabStartWave = GUICtrlCreateLabel("Start Wave:", 16, 64, 61, 17)
$InStartWave = GUICtrlCreateInput("", 82, 61, 281, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupIngame = GUICtrlCreateGroup("Ingame", 12, 100, 373, 123)
$LabWave = GUICtrlCreateLabel("Wave:", 16, 118, 36, 17)
$InWave = GUICtrlCreateInput("", 82, 115, 281, 21)
$LabPlayerHp = GUICtrlCreateLabel("Player HP:", 16, 144, 54, 17)
$InPlayerHp = GUICtrlCreateInput("", 82, 141, 281, 21)
$InPlayerMana = GUICtrlCreateInput("", 82, 167, 281, 21)
$LabPlayerMana = GUICtrlCreateLabel("Player Mana:", 16, 170, 63, 17)
$LabUnits = GUICtrlCreateLabel("Def Units:", 16, 196, 63, 17)
$InUnits = GUICtrlCreateInput("", 82, 193, 281, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupCores = GUICtrlCreateGroup("Crystals Health", 12, 226, 373, 125)
$LabCore1 = GUICtrlCreateLabel("Core 1:", 20, 244, 38, 17)
$InCore1 = GUICtrlCreateInput("", 82, 240, 281, 21)
$LabCore2 = GUICtrlCreateLabel("Core 2:", 20, 270, 38, 17)
$InCore2 = GUICtrlCreateInput("", 82, 266, 281, 21)
$LabCore3 = GUICtrlCreateLabel("Core 3:", 20, 298, 38, 17)
$InCore3 = GUICtrlCreateInput("", 82, 294, 281, 21)
$LabCore4 = GUICtrlCreateLabel("Core 4:", 20, 328, 38, 17)
$InCore4 = GUICtrlCreateInput("", 82, 324, 281, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$LabVer = GUICtrlCreateLabel("Game Ver.:", 20, 358, 60, 17)
$InVer = GUICtrlCreateInput("", 82, 354, 104, 21)
$ButCreate = GUICtrlCreateButton("Create INI", 12, 384, 79, 30)
$ButHelp = GUICtrlCreateButton("?", 352, 384, 30, 30)
GUICtrlSetFont(-1, 10, 800, 0, "Arial")
$ButIniOpen = GUICtrlCreateButton("Open INI", 134, 384, 79, 30)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

If FileExists($sIniPath) Then
	_loadOffs()
EndIf

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			_exit()
		Case $ButCreate
			_createIni()
		Case $ButIniOpen
			_openIni()
	EndSwitch
WEnd

Func _createIni()
	Local $sPath = FileSaveDialog("Save DDHBOffsets.ini", @ScriptDir&"\", "INI-File (*.ini)", 2+16, "DDHBOffsets.ini")
	If Not @error Then
		$sIniPath = $sPath
		_saveOffs()
	EndIf
EndFunc

Func _openIni()
	Local $sPath = FileOpenDialog("Choose DDHBOffsets.ini", @ScriptDir&"\", "INI-File (*.ini)", 1, "DDHBOffsets.ini")
	If Not @error Then
		$sIniPath = $sPath
		_loadOffs()
	EndIf
EndFunc

Func _exit()
	Exit
EndFunc

#region Save/Load Offsets
Func _loadOffs()
	Local $read

	$read = IniRead($sIniPath, "Offsets", "ManaBank", "")
	_updateOffs($read, $InManaBank, "ManaBank")
	$read = IniRead($sIniPath, "Offsets", "StartWave", "")
	_updateOffs($read, $InStartWave, "StartWave")
	$read = IniRead($sIniPath, "Offsets", "Wave", "")
	_updateOffs($read, $InWave, "Wave")
	$read = IniRead($sIniPath, "Offsets", "Core1", "")
	_updateOffs($read, $InCore1, "Core1")
	$read = IniRead($sIniPath, "Offsets", "Core2", "")
	_updateOffs($read, $InCore2, "Core2")
	$read = IniRead($sIniPath, "Offsets", "Core3", "")
	_updateOffs($read, $InCore3, "Core3")
	$read = IniRead($sIniPath, "Offsets", "Core4", "")
	_updateOffs($read, $InCore4, "Core4")
	$read = IniRead($sIniPath, "Offsets", "PlayerHealth", "")
	_updateOffs($read, $InPlayerHp, "PlayerHealth")
	$read = IniRead($sIniPath, "Offsets", "PlayerMana", "")
	_updateOffs($read, $InPlayerMana, "PlayerMana")
	$read = IniRead($sIniPath, "Offsets", "DefUnits", "")
	_updateOffs($read, $InUnits, "DefUnits")
	$read = IniRead($sIniPath, "Offsets", "GameVer", "")
	GUICtrlSetData( $InVer, $read)
EndFunc

Func _updateOffs($read, $hItem, $sKey = "")
	Local $sArray = ""

	If $read <> "" Then
		$sArray = _formatArray($read)
		GUICtrlSetData($hItem, $sArray)
	EndIf
EndFunc


Func _Hex($iHex)
	$iHex = Hex(StringReplace($iHex, " ", ""))
	For $i=1 To StringLen($iHex)-1
		If StringLeft($iHex, 1) = "0" Then
			$iHex = StringTrimLeft($iHex, 1)
		Else
			ExitLoop
		EndIf
	Next
	Return "0x" & $iHex
EndFunc

Func _saveOffs()
	IniWrite($sIniPath, "Offsets", "UpdateDate", @MDAY&"/"&@MON&"/"&@YEAR)
	IniWrite($sIniPath, "Offsets", "GameVer", GUICtrlRead($LabVer) )
	_iniWrite(GUICtrlRead($InManaBank), "ManaBank")
	_iniWrite(GUICtrlRead($InStartWave), "StartWave")
	_iniWrite(GUICtrlRead($InWave), "Wave")
	_iniWrite(GUICtrlRead($InCore1), "Core1")
	_iniWrite(GUICtrlRead($InCore2), "Core2")
	_iniWrite(GUICtrlRead($InCore3), "Core3")
	_iniWrite(GUICtrlRead($InCore4), "Core4")
	_iniWrite(GUICtrlRead($InPlayerHp), "PlayerHealth")
	_iniWrite(GUICtrlRead($InPlayerMana), "PlayerMana")
	_iniWrite(GUICtrlRead($InUnits), "DefUnits")
EndFunc

Func _iniWrite($sArray, $sKey)
	$sArray = _formatArray($sArray)
	IniWrite($sIniPath, "Offsets", $sKey, $sArray)
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
				$sArray &= StringReplace($aSplit[$i], " ", "")
				If $i < $aSplit[0] Then
					$sArray &= ", "
				EndIf
			Next
			$sArray &= " }"
		EndIf
	EndIf
	Return $sArray
EndFunc
#endregion Save/Load Offsets

;~ Func _updateOffs($read, $hItem, $sKey)
;~ 	Local $sArray = ""
;~ 	Local $aSplit

;~ 	If $read <> "" Then
		; $sArray = BinaryToString(_AesDecrypt($CRYPT_PW+$sKey, $read))
;~ 		$sArray = $read
;~ 		If StringReplace($sArray, " ", "") <> "" Then
;~ 			$sArray = StringReplace($sArray, "[", "")
;~ 			$sArray = StringReplace($sArray, "]", "")
;~ 			$aSplit = StringSplit($sArray, ",")
;~ 			If IsArray($aSplit) Then
;~ 				$sArray = "{ "
;~ 				For $i = 1 To $aSplit[0]
;~ 					$sArray &= _Hex($aSplit[$i])
;~ 					If $i < $aSplit[0] Then
;~ 						$sArray &= ", "
;~ 					EndIf
;~ 				Next
;~ 				$sArray &= " }"
;~ 				GUICtrlSetData($hItem, $sArray)
;~ 			EndIf
;~ 		EndIf
;~ 	EndIf
;~ EndFunc

;~ Func _iniWrite($sArray, $sKey)
;~ 	If StringReplace($sArray, " ", "") <> "" Then
;~ 		$sArray = StringReplace($sArray, "{", "{")
;~ 		$sArray = StringReplace($sArray, "}", "}")
;~ 		$aSplit = StringSplit($sArray, ",")
;~ 		If IsArray($aSplit) Then
;~ 			$sArray = "[ "
;~ 			For $i = 1 To $aSplit[0]
;~ 				$sArray &= Dec(Hex(StringReplace($aSplit[$i], " ", "")))
;~ 				If $i < $aSplit[0] Then
;~ 					$sArray &= ", "
;~ 				EndIf
;~ 			Next
;~ 			$sArray &= " ]"
;~ 		EndIf
;~ 		; $sArray = _AesEncrypt( $CRYPT_PW+$sKey, $sArray)
;~ 	EndIf
;~ 	IniWrite($sIniPath, "Offsets", $sKey, $sArray)
;~ EndFunc