🚀 How to Use (Step-by-Step Guide)
1. Initialization
Download the project as a ZIP file and extract it.
Run the Python script first. A command window will open.
⚠️ Important: Do NOT close the Python window. Minimize it and keep it running in the background.
Now, launch the AutoHotkey (.ahk) script.
2. Preparing the Data
Copy the required data from your source one by one in the exact sequence of the Google Form.
The script will store these copies in a clipboard queue.
3. Executing the Auto-Fill
Open your Google Form and click on the first input field.
Start Pasting: If there are no drop-down menus in the form, press the Home key.
The tool will start pasting your data automatically within 1 second.
⌨️ Smart Controls & Hotkeys
Key	Action	Description
F8	Auto-Flow	Use this when form fields are in sequence. It will Auto-Tab and fill fields continuously.
Ctrl	Pause / Resume	If you need to skip a field (e.g., Address is next but you didn't copy Phone No.), press Ctrl to pause, manually tab to the next field, and press Ctrl again to resume.
F2	Auto-Submit	Once all data is pasted, press this to automatically scroll down and click the Submit button.
F9	Reset	If you make a mistake or copy the wrong data, press this to reset the clipboard queue and start fresh.
🔔 Important Alerts
Beep Sound: When the script finishes pasting all your copied data, you will hear a Beep sound. This is your signal that the clipboard is empty and you can now press F2 to submit.
📂 File Functions
autosubmit.py: Manages the backend submission process.
FormFill_v2.ahk: The main automation engine for keystrokes.
AutoPaste_Manual-Auto.ahk: Handles advanced pasting logic.
po.ahk: Supporting automation script.
