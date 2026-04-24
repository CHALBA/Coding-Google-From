#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 999999
ListLines Off
Process, Priority, , High
SetBatchLines, -1
SetKeyDelay, -1, -1
SendMode Input

; --- ভেরিয়েবল সেটআপ ---
global items := []       
global idx := 1          
global lastClip := ""    
global capture := true   
global isPaused := false

Clipboard := ""
lastClip := ""

SetTimer, CheckClipboard, 150
Return

; --- কপি মনিটর ---
CheckClipboard:
if (!capture)
    return
if (Clipboard == "" || Clipboard == lastClip)
    return

lastClip := Clipboard
items.Push(Clipboard)
count := items.MaxIndex()
ToolTip, [ %count% ] ITEM ADDED
SetTimer, RemoveTooltip, -800
return

RemoveTooltip:
ToolTip
return

; --- Home: অটোমেটিক নিচে নিচে পেস্ট (Excel Friendly) ---
Home::  
count := items.MaxIndex()
if (count = "" || idx > count) {
    MsgBox, 48, Warning, No items found!
    return
}
capture := false
while (idx <= count) {
    val := items[idx]
    SendInput {Raw}%val%
    SendInput {Enter} ; <--- Tab এর বদলে Enter দেওয়া হয়েছে যাতে নিচে নামে
    idx++
    Sleep, 50 ; এক্সেলে দ্রুত টাইপিং প্রসেস করার জন্য সামান্য বিরতি
}
GoSub, FinalReset
return

; --- F8: কন্ট্রোল মোড (নিচে নিচে পেস্ট করার জন্য আপডেট করা) ---
F8::  
count := items.MaxIndex()
if (count = "" || idx > count) {
    MsgBox, 48, Warning, No items found!
    return
}

isPaused := false 
capture := false

while (idx <= count) {
    if (isPaused) {
        if (GetKeyState("Control", "P")) {
            isPaused := false
            ToolTip, RESUMING...
            KeyWait, Control
            ToolTip
        }
        Sleep, 10
        continue
    }

    if (GetKeyState("Control", "P")) {
        isPaused := true
        ToolTip, PAUSED: Press Control to Resume
        KeyWait, Control
        continue
    }

    val := items[idx]
    SendInput {Raw}%val%
    SendInput {Enter} ; <--- এখানেও Enter ব্যবহার করা হয়েছে
    idx++
    
    Loop, 20 { 
        if (GetKeyState("Control", "P")) {
            isPaused := true
            ToolTip, PAUSED: Press Control to Resume
            KeyWait, Control
            break
        }
        if (isPaused)
            break
        Sleep, 10
    }
}
GoSub, FinalReset
return

; --- রিসেট এবং সাউন্ড ---
FinalReset:
capture := false
SoundBeep, 1000, 400
items := []
idx := 1
lastClip := ""
Clipboard := ""
Sleep, 200
capture := true
ToolTip, ALL DONE & RESET!
SetTimer, RemoveTooltip, -1500
return

; --- F9: ফুল রিসেট ---
F9::
capture := false
Clipboard := ""
lastClip := ""
Sleep, 200
Reload
