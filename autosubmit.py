import keyboard
import pyautogui
import time

def jump_to_end():
    # ১. স্ক্রিনের একদম কোণায় (ফাঁকা জায়গায়) একটা ক্লিক করবে যাতে কার্সার ফিল্ড থেকে বেরিয়ে যায়
    # x=10, y=500 হলো স্ক্রিনের বাম দিকের মাঝখানের ফাঁকা অংশ
    pyautogui.click(10, 500)
    time.sleep(0.1)
    
    # ২. এবার Esc চাপবে কনফার্ম হওয়ার জন্য
    pyautogui.press('esc')
    time.sleep(0.1)
    
    # ৩. সবশেষে End বাটন চেপে পেজের নিচে নিয়ে যাবে
    pyautogui.press('end')
    print("Cursor focus removed and scrolled to bottom.")

# F4 কী সেট করা হলো
keyboard.add_hotkey('f2', jump_to_end)

print("Script running... Browser-e giye F2 chapun.")
keyboard.wait()
