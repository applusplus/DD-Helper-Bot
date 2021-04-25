#include-once

Global $inCore[4], $inMaxCore[4], $ButCore[4], $checkCoreFreeze[4]	;Core handels
Global $bMouseDown = False

#Region GUI
$Form = GUICreate($NAME & $VERSION & " :: by applusplus", 353, 230, -1, -1 )
$aSize = WinGetClientSize($Form)
$LabCopyright = GUICtrlCreateLabel("applusplus © 2012", $aSize[0]/2-50, $aSize[1]-20, 99, 21)
GUICtrlSetFont(-1, 8, 800, 0, "Ebrima")
GUICtrlSetColor(-1, $MY_COLOR_IGRO_BLUE)
$LabChangeLog = GUICtrlCreateLabel("ChangeLog", $aSize[0]-70, $aSize[1]-19, 90, 21)
GUICtrlSetFont(-1, 8, 800, 4, "Arial")
GUICtrlSetCursor (-1, 0)
$LabSt = GUICtrlCreateLabel("DD Status:", 12, 10, 56, 17)
$LabStatus = GUICtrlCreateLabel("Waiting", 70, 10, 47, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, $MY_COLOR_RED)
$ceckActiv = GUICtrlCreateCheckbox("Activate", 150, 10, 65, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkSave = GUICtrlCreateCheckbox("Save on Exit", 250, 10, 85, 17)
GUICtrlSetState(-1, $GUI_CHECKED)

$Tab1 = GUICtrlCreateTab(2, 28, 350, 180)
$TabPress = GUICtrlCreateTabItem("Press Bot")

#Region Press
$LabPress = GUICtrlCreateLabel("Press:", 12, 70, 33, 17)
$InPress = GUICtrlCreateInput("e", 46, 66, 75, 21)
$LabInterval = GUICtrlCreateLabel("Interval:", 126, 70, 42, 17)
$InInterval = GUICtrlCreateInput("100", 170, 66, 45, 21)
$LabMs1 = GUICtrlCreateLabel("ms", 218, 70, 17, 17)
$LabPressHotk = GUICtrlCreateLabel("Hotkey:", 242, 70, 41, 17)
$cbPressHotk = GUICtrlCreateCombo("", 284, 66, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12", "F8")
$checkPressHide = GUICtrlCreateCheckbox("Hide the Game", 46, 90, 97, 17)
#Endregion Press

#Region Waves Press
$LabOnWave = GUICtrlCreateLabel("Press on Waves:", 12, 118, 103, 17)
$LabWavePress = GUICtrlCreateLabel("Press:", 12, 138, 33, 17)
$InWavePress = GUICtrlCreateInput("g", 46, 134, 75, 21)
$LabWaveInterval = GUICtrlCreateLabel("Interval:", 126, 138, 42, 17)
$InWaveInterval = GUICtrlCreateInput("60", 170, 134, 45, 21)
$LabS1 = GUICtrlCreateLabel("s", 218, 138, 17, 17)
$LabPressWaveHotk = GUICtrlCreateLabel("Hotkey:", 242, 138, 41, 17)
$cbPressWaveHotk = GUICtrlCreateCombo("", 284, 134, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12", "F7")
$LabWaves = GUICtrlCreateLabel("Waves:", 12, 164, 41, 17)
$cbWave = GUICtrlCreateCombo("", 54, 160, 37, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25", "0")
$LabCurWave = GUICtrlCreateLabel("Currently Wave:", 96, 164, 101, 17)
$inCurWave = GUICtrlCreateInput("", 176, 160, 37, 21, $ES_READONLY)
$ButCurWave = GUICtrlCreateButton("Change", 216, 159, 55, 24)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkWavePressHide = GUICtrlCreateCheckbox("Hide the Game", 46, 185, 97, 17)
#endregion Waves Press

#Region Tavern
$TabTavern = GUICtrlCreateTabItem("Tavern")
#Region Mana Hack
$LabMana = GUICtrlCreateLabel("Mana:", 12, 72, 34, 17)
$InMana = GUICtrlCreateInput("", 47, 68, 100, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButMana = GUICtrlCreateButton("Change", 154, 66, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkManaFreeze = GUICtrlCreateCheckbox("Freeze Mana", 238, 70, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
#endregion Mana Hack
#Region StartWave Hack
$LabStartWave = GUICtrlCreateLabel("Start Wave:", 12, 102, 60, 17)
$InStartWave = GUICtrlCreateInput("", 75, 98, 72, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButStartWave = GUICtrlCreateButton("Change", 154, 96, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
#endregion StartWave Hack
#endregion Tavern

#Region Ingame
$TabIngame = GUICtrlCreateTabItem("Ingame")
GUICtrlCreateGroup("Player", 6, 50, 340, 80)
#Region Player Health
$LabPlayHp = GUICtrlCreateLabel("Health:", 12, 72, 34, 17)
$inPlayHp = GUICtrlCreateInput("", 47, 68, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabPlayMaxHp = GUICtrlCreateLabel("/", 93, 72, 5, 17)
$inPlayMaxHp = GUICtrlCreateInput("", 100, 68, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButPlayHp = GUICtrlCreateButton("Change", 154, 66, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkPlayHpFreeze = GUICtrlCreateCheckbox("Freeze Health", 238, 70, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
#EndRegion Player Health
#Region Player Mana
$LabPlayMana = GUICtrlCreateLabel("Mana:", 12, 102, 34, 17)
$inPlayMana = GUICtrlCreateInput("", 47, 98, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabPlayMaxMana = GUICtrlCreateLabel("/", 93, 102, 5, 17)
$inPlayMaxMana = GUICtrlCreateInput("", 100, 98, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButPlayMana = GUICtrlCreateButton("Change", 154, 96, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkPlayManaFreeze = GUICtrlCreateCheckbox("Freeze Mana", 238, 100, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
#EndRegion Player Mana
GUICtrlCreateGroup("", -99, -99, 1, 1)
#Region Player Health
$LabUnits = GUICtrlCreateLabel("Units:", 12, 142, 34, 17)
$InUnits = GUICtrlCreateInput("", 47, 138, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabMaxUnits = GUICtrlCreateLabel("/", 93, 142, 5, 17)
$inMaxUnits = GUICtrlCreateInput("", 100, 138, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButUnits = GUICtrlCreateButton("Change", 154, 136, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkUnitsFreeze = GUICtrlCreateCheckbox("Freeze Units", 238, 140, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
#EndRegion Player Health
#EndRegion Ingame

#Region Cores Health Hack
$TabCores = GUICtrlCreateTabItem("Cores Health")
$LabCore1 = GUICtrlCreateLabel("Core 1:", 12, 72, 34, 17)
$inCore[0] = GUICtrlCreateInput("", 47, 68, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabMaxCore1 = GUICtrlCreateLabel("/", 93, 72, 5, 17)
$inMaxCore[0] = GUICtrlCreateInput("", 100, 68, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButCore[0] = GUICtrlCreateButton("Change", 154, 66, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkCoreFreeze[0] = GUICtrlCreateCheckbox("Freeze Health", 238, 70, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabCore2 = GUICtrlCreateLabel("Core 2:", 12, 102, 34, 17)
$inCore[1] = GUICtrlCreateInput("", 47, 98, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabMaxCore2 = GUICtrlCreateLabel("/", 93, 102, 5, 17)
$inMaxCore[1] = GUICtrlCreateInput("", 100, 98, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButCore[1] = GUICtrlCreateButton("Change", 154, 96, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkCoreFreeze[1] = GUICtrlCreateCheckbox("Freeze Health", 238, 100, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabCore3 = GUICtrlCreateLabel("Core 3:", 12, 132, 34, 17)
$inCore[2] = GUICtrlCreateInput("", 47, 128, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabMaxCore3 = GUICtrlCreateLabel("/", 93, 132, 5, 17)
$inMaxCore[2] = GUICtrlCreateInput("", 100, 128, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButCore[2] = GUICtrlCreateButton("Change", 154, 126, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkCoreFreeze[2] = GUICtrlCreateCheckbox("Freeze Health", 238, 130, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabCore4 = GUICtrlCreateLabel("Core 4:", 12, 162, 34, 17)
$inCore[3] = GUICtrlCreateInput("", 47, 158, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$LabMaxCore4 = GUICtrlCreateLabel("/", 93, 162, 5, 17)
$inMaxCore[3] = GUICtrlCreateInput("", 100, 158, 45, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButCore[3] = GUICtrlCreateButton("Change", 154, 156, 75, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$checkCoreFreeze[3] = GUICtrlCreateCheckbox("Freeze Health", 238, 160, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
#endregion Cores Health Hack

$TabDisplay = GUICtrlCreateTabItem("Display")
#Region Display
$PicDisplay = GUICtrlCreatePic("", 60, 50, 240, 153 )
#EndRegion Display

$TabSettings = GUICtrlCreateTabItem("Settings")
#Region Settings
$LabOffsIni = GUICtrlCreateLabel("External Offsets Ini:", 11, 58, 99, 18)
$LabOffsIniState = GUICtrlCreateLabel("", 104, 58, 200, 18)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$InOffsIni = GUICtrlCreateInput("", 11, 78, 270, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$ButOffsIni = GUICtrlCreateButton("Load", 286, 76, 60, 25)
$ButIniShow = GUICtrlCreateButton("Edit", 11, 103, 60, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$ButIniLoad = GUICtrlCreateButton("Download", 80, 103, 70, 25)
#EndRegion Settings

GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion GUI

Func _eventGUI($nMsg)
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			_exit()
		Case $ceckActiv
			_activate()
		Case $ButMana
			_writeMana(GUICtrlRead($InMana))
		Case $checkManaFreeze
			_freezeManaCheck()
		Case $ButCore[0]
			_writeCore(GUICtrlRead($inCore[0]), 0)
			_writeMaxCore(GUICtrlRead($inMaxCore[0]), 0)
		Case $ButCore[1]
			_writeCore(GUICtrlRead($inCore[1]), 1)
			_writeMaxCore(GUICtrlRead($inMaxCore[1]), 1)
		Case $ButCore[2]
			_writeCore(GUICtrlRead($inCore[2]), 2)
			_writeMaxCore(GUICtrlRead($inMaxCore[2]), 2)
		Case $ButCore[3]
			_writeCore(GUICtrlRead($inCore[3]), 3)
			_writeMaxCore(GUICtrlRead($inMaxCore[3]), 3)
		Case $checkCoreFreeze[0]
			_freezeCoreCheck(0)
		Case $checkCoreFreeze[1]
			_freezeCoreCheck(1)
		Case $checkCoreFreeze[2]
			_freezeCoreCheck(2)
		Case $checkCoreFreeze[3]
			_freezeCoreCheck(3)
		Case $ButStartWave
			_writeStartWave(GUICtrlRead($InStartWave))
		Case $ButCurWave
			_writeWave(GUICtrlRead($inCurWave))
		Case $checkPlayHpFreeze
			_freezePlayHpCheck()
		Case $checkPlayManaFreeze
			_freezePlayManaCheck()
		Case $ButPlayHp
			_writePlayHp(GUICtrlRead($inPlayHp))
			_writePlayMaxHp(GUICtrlRead($inPlayMaxHp))
		Case $ButPlayMana
			_writePlayMana(GUICtrlRead($inPlayMana))
			_writePlayMaxMana(GUICtrlRead($inPlayMaxMana))
		Case $ButUnits
			_writeUnits(GUICtrlRead($InUnits))
			_writeMaxUnits(GUICtrlRead($InMaxUnits))
		Case $checkUnitsFreeze
			_freezeUnitsCheck()
		Case $ButOffsIni
			_openIni()
		Case $ButIniShow
			_showIni()
		Case $ButIniLoad
			_downloadIni()
		Case $LabChangeLog
			_showChangelog()
		Case $Tab1
			If GUICtrlRead($Tab1,1) = $TabDisplay And $bStatus = True Then
				_createDisplay()
				AdlibRegister("_createDisplay", 5000)
			ElseIf GUICtrlRead($Tab1,1) = $TabDisplay And $bStatus = False Then
				MsgBox(64, "Warning", "This Tab is only available if the Game is running!")
				GUICtrlSetState($TabPress, $GUI_SHOW)
			ElseIf GUICtrlRead($Tab1,1) <> $TabDisplay Then
				AdlibUnRegister("_createDisplay")
			EndIf
		Case $PicDisplay
			If $bStatus = True And FileExists($SCREEN_SHOT) = 1 Then
				_createHDDisplay()
			EndIf
	EndSwitch
EndFunc