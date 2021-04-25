#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=legendary-defender.ico
#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=1.5.2.0
#AutoIt3Wrapper_Res_ProductVersion=1.5.2.0
#AutoIt3Wrapper_Res_LegalCopyright=applusplus
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#Obfuscator_Parameters=/cs=1 /cn=0 /cf=1 /cv=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs=============================================================================
  AutoIt Version: 3.3.8.1
  Author: applusplus
  Description: This is a bot and hack for the game Dungeon Defenders
			It´s have a lots of function and features, that helps you survive all waves.
			The programm may need a pointer and offset update. If you have some Cheats Engine knowledge,
			you can easily update the offsets and use DD Helper Bot until the next game update.
#ce============================================================================

#include <Misc.au3>
If _Singleton("DD Helper Bot", 1) = 0 Then
    MsgBox(0, "Error", "DD Helper Bot is already running!")
    Exit
EndIf
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <File.au3>
#include <Array.au3>
#include "Memory.au3"
#include "JSON.au3"

#include "Const\ColorConst.au3"
#include "UDFs\_ScreenCaptureEx.au3"
#include "UDFs\_ReadPointer.au3"
#include "UDFs\_KeyManager.au3"
#include "UDFs\_Display.au3"


Global Const $VERSION = "1.5.2"
Global Const $NAME = "DD Helper Bot v"
Global Const $INI  = @ScriptDir&"\ddbot.ini"
Global Const $COPYRIGHT = "applusplus"
Global Const $CRYPT_PW = "6967726f6d616e7275"
Global Const $CHANGE_LOG = @TempDir & "\DDHB_Changelog.txt"
Global Const $SCREEN_SHOT = @TempDir & "\DDDisplay.jpg"

FileInstall(".\activated.wav", @TempDir & "\activated.wav", 1)
FileInstall(".\deactivated.wav", @TempDir & "\deactivated.wav", 1)

Global $sOffsIniPath = @ScriptDir&"\DDHBOffsets.ini"
Global $sOffsIniDate = ""
Global $bOffsLoaded = False
Global $pInfoDD, $hDll
Global $ManaAdress, $iManaValue, $iManaValue_o, $iManaValue_frozen
Global $WaveAdress, $iWaveValue, $iWaveValue_o
Global $CoreAdress[4], $aCoreValue[4]
Global $MaxCoreAdress[4], $aMaxCoreValue[4]
Global $aCoreValue_frozen[UBound($aCoreValue)]
Global $aCoreValue_o[UBound($aCoreValue)]
Global $StartWaveAdress, $iStartWaveValue, $iStartWaveValue_o
Global $PlayHpAdress, $iPlayHpValue, $iPlayHpValue_o, $iPlayHpValue_frozen
Global $PlayManaAdress, $iPlayManaValue, $iPlayManaValue_o, $iPlayManaValue_frozen
Global $UnitsAdress, $iUnitsValue, $iUnitsValue_o, $iUnitsValue_frozen
Global $PlayMaxHpAdress, $PlayMaxManaAdress, $MaxUnitsAdress
Global $iPlayMaxHpValue, $iPlayMaxManaValue, $iMaxUnitsValue
Global $PressKey, $bPressActiv
Global $PressWaveKey, $bPressWaveActiv
Global $bStatus = False, $bActivate = False

Global $FromLog, $FormDisplay

Dim $xManaOffs[6] = [0x012014C8, 0x418, 0x5E8, 0x28, 0x34C, 0x0]
Dim $xStartWaveOffs[6] = [0x01201EE0, 0x1B4, 0x10, 0x28, 0x10, 0x40]
Dim $xWavesOffs[6] = [0x01118A18, 0x10, 0xA8, 0x4, 0x0, 0x94]
Dim $xCore1[6] = [0x0121742C, 0x0, 0x60, 0x4, 0x78, 0x208]
Dim $xCore2 = _getMaxOffs($xCore1, 5)
Dim $xCore3 = _getMaxOffs($xCore2, 5)
Dim $xCore4 = _getMaxOffs($xCore3, 5)
Dim $xCoresOffs[4] = [$xCore1, $xCore2, $xCore3, $xCore4]
Dim $xCoresMaxOffs[4]
Dim $xPlayHpOffs[6] = [0x0111A7B8, 0x1F8, 0x778 ,0x20C, 0x104, 0x310]
Dim $xPlayHpMaxOffs
Dim $xPlayManaOffs[6] = [0x01116920, 0x24C, 0x24C ,0x1F8, 0x778, 0x6A0]
Dim $xPlayManaMaxOffs
Dim $xUnitsOffs[6] = [0x011A045C, 0x1C8, 0x550, 0x1B4 ,0x0, 0x374]
Dim $xUnitsMaxOffs
_calcMaxOffs()

#include "UDFs\_FreezeUDFs.au3"
#include "UDFs\_HelperForm.au3"
#include "UDFs\_ReadAndWrite.au3"
#include "UDFs\_ChangeState.au3"
#include "UDFs\_ChangeLog.au3"
#include "UDFs\_SaveAndLoad.au3"

_GDIPlus_Startup()

If FileExists($INI) Then
	_loadCfg()
EndIf

If FileExists($sOffsIniPath) Then
	_loadOffs()
EndIf

$hDll = DllOpen("user32.dll")

While 1
	$nMsg = GUIGetMsg()
	_eventGUI($nMsg)

	Local $pid = ProcessExists("DunDefGame.exe")
	If $pid <> 0 And $bStatus = False Then
		$pInfoDD = _MemoryOpen($pid)
		_readAll()
		$bStatus = True
		GUICtrlSetColor($LabStatus, $MY_COLOR_GREEN)
		GUICtrlSetData($LabStatus, "Running")
		GUICtrlSetState($ceckActiv, $GUI_ENABLE)
	ElseIf $pid = 0 And $bStatus = True Then
		$bStatus = False
		GUICtrlSetColor($LabStatus, $MY_COLOR_RED)
		GUICtrlSetData($LabStatus, "Waiting")
		GUICtrlSetState($ceckActiv, $GUI_UNCHECKED)
		GUICtrlSetState($ceckActiv, $GUI_DISABLE)
		_activate()
		_MemoryClose($pInfoDD)
	EndIf
	If $bStatus = True And $bActivate = True Then
		_hotkeyEvent()
		_eventChanges()
	EndIf
WEnd

Func _hotkeyEvent()
	If _IsPressed($PressKey ,$hDll) Then
		While _IsPressed($PressKey ,$hDll) = 1
			Sleep(100)
		WEnd
		If $bPressActiv = False Then
			SoundPlay(@TempDir & "\activated.wav")
			$bPressActiv = True
			AdlibRegister("_sendPress", GUICtrlRead($InInterval))
			_changePressState($GUI_DISABLE)
			If GUICtrlRead($checkPressHide) = $GUI_CHECKED Then
				WinSetState("Dungeon Defenders", "", @SW_HIDE )
			EndIf
		ElseIf $bPressActiv = True Then
			SoundPlay(@TempDir & "\deactivated.wav")
			$bPressActiv = False
			AdlibUnRegister("_sendPress")
			_changePressState($GUI_ENABLE)
			If GUICtrlRead($checkPressHide) = $GUI_CHECKED Then
				WinSetState("Dungeon Defenders", "", @SW_SHOW )
			EndIf
		EndIf
	EndIf
	If _IsPressed($PressWaveKey ,$hDll) Then
		While _IsPressed($PressWaveKey ,$hDll) = 1
			Sleep(100)
		WEnd
;~ 		MsgBox(64, "Info", "Press on Wave function is not available in this version!")
		If $bPressWaveActiv = False Then
			SoundPlay(@TempDir & "\activated.wav")
			$bPressWaveActiv = True
			AdlibRegister("_eventWaveChange", GUICtrlRead($InWaveInterval)*1000)
			_changeWavePressState($GUI_DISABLE)
			If GUICtrlRead($checkWavePressHide) = $GUI_CHECKED Then
				WinSetState("Dungeon Defenders", "", @SW_HIDE )
			EndIf
		ElseIf $bPressWaveActiv = True Then
			SoundPlay(@TempDir & "\deactivated.wav")
			$bPressWaveActiv = False
			AdlibUnRegister("_eventWaveChange")
			_changeWavePressState($GUI_ENABLE)
			If GUICtrlRead($checkWavePressHide) = $GUI_CHECKED Then
				WinSetState("Dungeon Defenders", "", @SW_SHOW )
			EndIf
		EndIf
	EndIf
EndFunc

Func _readAll()
	_getAdress()
	_readMana()
	_readCore()
	_readStartWave()
	_readCurWave()
	_readPlayHp()
	_readPlayMana()
	_readUnits()
EndFunc

Func _eventChanges()
	$iManaValue = _MemoryRead($ManaAdress,$pInfoDD)
	If $iManaValue <> $iManaValue_o Then
		GUICtrlSetData($InMana, $iManaValue)
		If $iManaValue > 2000000000 Then
			_valueColor($InMana, "red")
		ElseIf $iManaValue > 200000000 Then
			_valueColor($InMana, "orange")
		Else
			_valueColor($InMana, "green")
		EndIf
		_readMana()
		$iManaValue_o = $iManaValue
	EndIf
	For $i = 0 To UBound($CoreAdress)-1
		$aCoreValue[$i] = _MemoryRead($CoreAdress[$i],$pInfoDD)
		If $aCoreValue[$i] <> $aCoreValue_o[$i] Then
			_readCore()
			$aCoreValue_o[$i] = $aCoreValue[$i]
		EndIf
	Next
	$iStartWaveValue = _MemoryRead($StartWaveAdress,$pInfoDD)
	If $iStartWaveValue <> $iStartWaveValue_o Then
		GUICtrlSetData($InStartWave, $iStartWaveValue)
		$iStartWaveValue_o = $iStartWaveValue
	EndIf
	$iWaveValue = _MemoryRead($WaveAdress,$pInfoDD)
	If $iWaveValue <> $iWaveValue_o Then
		If $iWaveValue > 10000 Then
			GUICtrlSetData($inCurWave, "Error")
		Else
			GUICtrlSetData($inCurWave, $iWaveValue)
		EndIf
		$iWaveValue_o = $iWaveValue
	EndIf
	$iPlayHpValue = _MemoryRead($PlayHpAdress,$pInfoDD)
	If $iPlayHpValue <> $iPlayHpValue_o Then
		_readPlayHp()
		$iPlayHpValue_o = $iPlayHpValue
	EndIf
	$iPlayManaValue = _MemoryRead($PlayManaAdress,$pInfoDD)
	If $iPlayManaValue <> $iPlayManaValue_o Then
		_readPlayMana()
		$iPlayManaValue_o = $iPlayManaValue
	EndIf
	$iUnitsValue = _MemoryRead($UnitsAdress,$pInfoDD)
	If $iUnitsValue <> $iUnitsValue_o Then
		_readUnits()
		$iUnitsValue_o = $iUnitsValue
	EndIf
EndFunc

Func _valueColor($hItem, $sColor = "green")
	Switch $sColor
		Case "green"
			$sColor = $MY_COLOR_GREEN
		Case "orange"
			$sColor = $MY_COLOR_ORANGE
		Case "red"
			$sColor = $MY_COLOR_RED
		Case Else
			Return 0
	EndSwitch
	GUICtrlSetColor($hItem, $sColor)
EndFunc

Func _sendPress()
	ControlFocus("Dungeon Defenders", "", "")
	ControlSend("Dungeon Defenders", "", "", GUICtrlRead($InPress))
EndFunc

Func _sendWavePress()
	ControlFocus("Dungeon Defenders", "", "")
	ControlSend("Dungeon Defenders", "", "", GUICtrlRead($InWavePress))
EndFunc

Func _activate()
	If GUICtrlRead($ceckActiv) = $GUI_CHECKED Then
		$bActivate = True
		_readAll()
		AdlibRegister("_readAll", 60*1000)
		GUICtrlSetState($cbPressHotk, $GUI_DISABLE)
		GUICtrlSetState($cbPressWaveHotk, $GUI_DISABLE)
		_changeAllState($GUI_ENABLE)
		$PressKey = _PressKeysManager(GUICtrlRead($cbPressHotk))
		$PressWaveKey = _PressKeysManager(GUICtrlRead($cbPressWaveHotk))
	Else
		$bPressActiv = False
		$bPressWaveActiv = False
		$bActivate = False
		AdlibUnRegister("_readAll")
		_changeAllState($GUI_DISABLE)
		GUICtrlSetState($cbPressHotk, $GUI_ENABLE)
		GUICtrlSetState($cbPressWaveHotk, $GUI_ENABLE)
		_changePressState($GUI_ENABLE)
		_changeWavePressState($GUI_ENABLE)
	EndIf
EndFunc

Func _changeAllState($bState)
	_changeManaState($bState)
	_changePlayHpState($bState)
	_changePlayManaState($bState)
	_changeStartWaveState($bState)
	_changeUnitsState($bState)
	For $i = 0 To UBound($inCore)-1
		_changeCoreState($bState, $i)
	Next
EndFunc

Func _getAdress()
	Local $ptr1, $ptr2, $ptr4, $ptr5, $ptr6

	$ManaAdress = _readPointer($xManaOffs, $pInfoDD)

	$StartWaveAdress = _readPointer($xStartWaveOffs, $pInfoDD)
	$WaveAdress = _readPointer($xWavesOffs, $pInfoDD)

	For $i = 0 To UBound($xCoresOffs)-1
		$CoreAdress[$i] = _readPointer($xCoresOffs[$i], $pInfoDD)
	Next

	$PlayHpAdress = _readPointer($xPlayHpOffs, $pInfoDD, 0)
	$PlayManaAdress = _readPointer($xPlayManaOffs, $pInfoDD)
	$UnitsAdress = _readPointer($xUnitsOffs, $pInfoDD)
EndFunc

Func _eventWaveChange()
	$iWaveValue = _MemoryRead($WaveAdress,$pInfoDD)
	If $iWaveValue <= GUICtrlRead($cbWave) Or GUICtrlRead($cbWave) = 0 Then
		_sendWavePress()
	EndIf
EndFunc

Func _openIni()
	Local $sIniPath = FileOpenDialog("Choose DDHBOffsets.ini", @ScriptDir&"\", "INI-File (*.ini)", 1, "DDHBOffsets.ini")
	If Not(@error) Then
		$sOffsIniPath = $sIniPath
		_loadOffs()
	EndIf
EndFunc

Func _showIni()
	If FileExists(@ScriptDir&"\Offsets Manager.exe") Then
		ShellExecute("Offsets Manager.exe", '"/ini" "'&$sOffsIniPath&'"', @ScriptDir)
	Else
		MsgBox(16, "Error",'This function request "Offsets Manager.exe"!'& @CRLF&@CRLF&'Put the "Offsets Manager.exe" in your'&@CRLF&'"'&@ScriptDir&'\"'&@CRLF&'folder and try again')
	EndIf
EndFunc

Func _downloadIni()
	Local $sOffsIniPath_bak

	SplashTextOn("", "Downloading Offsets from server, please wait...", 400, 100, -1, -1, 1+32)
	If FileExists(@TempDir&"\MyDDOffsets.ini") = 0 Then
		InetGet("http://svn.code.sf.net/p/ddhelperbot/code/trunk/MyDDOffsets.ini",  @TempDir&"\MyDDOffsets.ini")
		If @error Then
			SplashOff()
			GUICtrlSetState($ButIniLoad, $GUI_DISABLE)
			MsgBox(48, "Download Error", "The Offsets list couldn't be downloaded!"&@CRLF&"Missing File or no connection to the server!")
			Return -1
		EndIf
	EndIf
	$sOffsIniPath_bak = $sOffsIniPath
	$sOffsIniPath = @TempDir&"\MyDDOffsets.ini"
	_loadOffs()
	_iniState("for Game Ver.: "&$sOffsIniDate, 0x0026DC, "")
	GUICtrlSetState($ButIniShow, $GUI_ENABLE)
	$sOffsIniPath = $sOffsIniPath_bak
	SplashOff()
EndFunc

Func _exit()
	_MemoryClose($pInfoDD)
	DllClose($hDll)
	_SaveCfg()
;~ 	_saveOffs()
	_GDIPlus_Shutdown()
	SoundPlay(@TempDir & "\deactivated.wav")

	FileDelete(@TempDir & "\activated.wav")
	FileDelete(@TempDir & "\deactivated.wav")
	FileDelete(@TempDir & "\MyDDOffsets.ini")
	FileDelete($CHANGE_LOG)
	FileDelete($SCREEN_SHOT)
	Exit
EndFunc
