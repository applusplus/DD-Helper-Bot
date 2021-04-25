
#include-once

Func _createDisplay()
	Local $hDD

	$hDD = WinGetHandle("Dungeon Defenders")
	If $hDD <> "" And WinGetState($hDD) <> 16 Then
		$hBitmap = _CaptureWindow($hDD)
		_ScreenCapture_SaveImage($SCREEN_SHOT, $hBitmap, True)
		_WinAPI_DeleteObject($hBitmap)
	EndIf
	GUICtrlSetImage($PicDisplay, $SCREEN_SHOT)
EndFunc

Func _createHDDisplay()
	GUICtrlSetState($PicDisplay, $GUI_DISABLE)
	AdlibUnRegister("_createDisplay")

	Local $hDD = WinGetHandle("Dungeon Defenders")
	If $hDD = ""  Then
		MsgBox(48, "Caption Error", "Game is not running!")
		Return -1
	ElseIf WinGetState($hDD) = 16 Then
		MsgBox(48, "Caption Error", "Game is minimized!")
		Return -1
	EndIf
	Local $hBitmap = _CaptureWindow($hDD);_GDIPlus_ImageLoadFromFile($SCREEN_SHOT)
	Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
	Local $iWidth = _GDIPlus_ImageGetWidth($hImage)
	Local $iHeight = _GDIPlus_ImageGetHeight($hImage)

	If $iWidth > 1500 Then
		$iHeight /= 3
		$iWidth /= 3
	ElseIf $iWidth > 500 Then
		$iHeight /= 2
		$iWidth /= 2
	EndIf


;~ 	GUISetState(@SW_DISABLE, $Form)
	$FormDisplay = GUICreate("Game Display", $iWidth, $iHeight, -1, -1, BitOR($DS_MODALFRAME, $DS_SETFOREGROUND, $WS_SYSMENU), BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST), $Form)
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($FormDisplay)
	GUISetState(@SW_SHOW)
	_GDIPlus_GraphicsDrawImageRect($hGraphic,$hImage,0,0,$iWidth,$iHeight)

	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)
	While 1
		$nMsg = GUIGetMsg()
        If $nMsg = $GUI_EVENT_CLOSE Then
			GUICtrlSetState($PicDisplay, $GUI_ENABLE)
			ExitLoop
		Else
			_eventGUI($nMsg)
		EndIf
		$hDD = WinGetHandle("Dungeon Defenders")
		If $hDD = "" Then
			ExitLoop
		EndIf
		If WinGetState($hDD) <> 16 Then
			$hBitmap = _CaptureWindow($hDD)
			$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
			_GDIPlus_GraphicsDrawImageRect($hGraphic,$hImage,0,0,$iWidth,$iHeight)
			_GDIPlus_ImageDispose($hImage)
			_WinAPI_DeleteObject($hBitmap)
		EndIf
    WEnd
	_GDIPlus_GraphicsDispose($hGraphic)
;~ 	GUISetState(@SW_ENABLE, $Form)
	GUIDelete($FormDisplay)
	WinActivate($Form)
EndFunc