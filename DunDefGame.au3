
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $iX = 5, $bFor = True

$Form1 = GUICreate("Dungeon Defenders", 416, 256, 450, 334)
$ButTest = GUICtrlCreateButton("Test", 5, 88, 75, 25)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
	_move()
	Sleep(20)
WEnd

Func _move()
	If $bFor = True Then
		$iX += 2
	Else
		$iX -= 2
	EndIf
	GUICtrlSetPos($ButTest, $iX)
	If $iX >= 320 Then
		$bFor = False
	ElseIf $iX < 6 Then
		$bFor = True
	EndIf
EndFunc