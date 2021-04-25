
HotKeySet("{f1}","_pos1")
HotKeySet("{f2}","_pos2")
HotKeySet("{space}","_click")
HotKeySet("{F3}","_sleep")

Global $aPos1[2], $aPos2[2]

While 1
	Sleep(100)
WEnd

Func _sleep()
	While 1
		Sleep(100)
	WEnd
EndFunc

Func _pos1()
	$aPos1= MouseGetPos()
EndFunc

Func _pos2()
	$aPos2= MouseGetPos()
EndFunc

Func _click()
	While 1
		MouseClick("left", $aPos1[0], $aPos1[1])
		Sleep(100)
		MouseClick("left", $aPos2[0], $aPos2[1])
		Sleep(800)
	WEnd
EndFunc