
#include-once

Func _CaptureWindow( $hWnd, $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1)
    Local $tRect = _WinAPI_GetClientRect($hWnd)
    $iLeft += DllStructGetData($tRect, "Left")
    $iTop += DllStructGetData($tRect, "Top")
    If $iRight = -1 Then $iRight = DllStructGetData($tRect, "Right") - DllStructGetData($tRect, "Left")
    If $iBottom = -1 Then $iBottom = DllStructGetData($tRect, "Bottom") - DllStructGetData($tRect, "Top")
    $iRight += DllStructGetData($tRect, "Left")
    $iBottom += DllStructGetData($tRect, "Top")
    If $iLeft > DllStructGetData($tRect, "Right") Then $iLeft = DllStructGetData($tRect, "Left")
    If $iTop > DllStructGetData($tRect, "Bottom") Then $iTop = DllStructGetData($tRect, "Top")
    If $iRight > DllStructGetData($tRect, "Right") Then $iRight = DllStructGetData($tRect, "Right")
    If $iBottom > DllStructGetData($tRect, "Bottom") Then $iBottom = DllStructGetData($tRect, "Bottom")
    Return _Capture( $hWnd, $iLeft, $iTop, $iRight, $iBottom)
EndFunc

Func _Capture( $hWnd,$iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1)
    If $iRight = -1 Then $iRight = _WinAPI_GetSystemMetrics($__SCREENCAPTURECONSTANT_SM_CXSCREEN)
    If $iBottom = -1 Then $iBottom = _WinAPI_GetSystemMetrics($__SCREENCAPTURECONSTANT_SM_CYSCREEN)
    If $iRight < $iLeft Then Return SetError(-1, 0, 0)
    If $iBottom < $iTop Then Return SetError(-2, 0, 0)

    Local $iW = ($iRight - $iLeft) + 1
    Local $iH = ($iBottom - $iTop) + 1

    Local $hDDC = _WinAPI_GetDC($hWnd)
    Local $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
    Local $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iW, $iH)
    _WinAPI_SelectObject($hCDC, $hBMP)
     DllCall("User32.dll", "int", "PrintWindow", "hwnd", $hWnd, "hwnd", $hCDC, "int", 0)
    _WinAPI_BitBlt($hCDC, 0, 0, $iW, $iH, $hDDC, $iLeft, $iTop, $__SCREENCAPTURECONSTANT_SRCCOPY)

    _WinAPI_ReleaseDC($hWnd, $hDDC)
    _WinAPI_DeleteDC($hCDC)
    Return $hBMP
EndFunc
