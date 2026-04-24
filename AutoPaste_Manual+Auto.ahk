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

; --- Home: আলোর গতি (অপরিবর্তিত) ---
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
    SendInput {Tab}
    idx++
}
GoSub, FinalReset
return

; --- F8: কন্ট্রোল মোড (সাথে সাথে Pause/Resume হবে) ---
F8::  
count := items.MaxIndex()
if (count = "" || idx > count) {
    MsgBox, 48, Warning, No items found!
    return
}

isPaused := false 
capture := false

while (idx <= count) {
    ; পজ চেক
    if (isPaused) {
        ; যদি Ctrl চাপা হয়, সাথে সাথে রিজিউম হবে
        if (GetKeyState("Control", "P")) {
            isPaused := false
            ToolTip, RESUMING...
            KeyWait, Control ; বাটন ছেড়ে দেওয়া পর্যন্ত অপেক্ষা করবে (ভুল এড়াতে)
            ToolTip
        }
        Sleep, 10 ; খুব ছোট বিরতি যাতে লুপটি দ্রুত চেক করে
        continue
    }

    ; পেস্ট করার আগে চেক করবে Ctrl চাপা হয়েছে কি না
    if (GetKeyState("Control", "P")) {
        isPaused := true
        ToolTip, PAUSED: Press Control to Resume
        KeyWait, Control ; সাথে সাথে পজ নিশ্চিত করবে
        continue
    }

    val := items[idx]
    SendInput {Raw}%val%
    SendInput {Tab}
    idx++
    
    ; পেস্টের পর দ্রুত পজ চেক করার লুপ (স্প্লিট বিরতি)
    Loop, 20 { 
        if (GetKeyState("Control", "P")) {
            isPaused := true
            ToolTip, PAUSED: Press Control to Resume
            KeyWait, Control
            break
        }
        if (isPaused)
            break
        Sleep, 10 ; মোট ২০০ মিলিসেকেন্ড বিরতি, কিন্তু প্রতি ১০ms পর পর চেক করবে
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
