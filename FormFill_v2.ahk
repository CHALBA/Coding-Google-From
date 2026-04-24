F2::
; Save current mouse position
MouseGetPos, ox, oy

; Click Form 1
Click, 419, 547
Sleep, 500  ; wait 0.5 second

; Click Form 2
Click, 417, 552

; Move mouse back to original position
MouseMove, ox, oy
return

; Mouse X,Y check
F4::
MouseGetPos, x, y
MsgBox, X=%x% Y=%y%
return
