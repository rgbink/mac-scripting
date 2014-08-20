set originalVolume to output volume of (get volume settings) as number
property returnVolume : output volume of (get volume settings) as number

tell application "System Preferences"
	reveal anchor "output" of pane id Â
		"com.apple.preference.sound"
end tell

tell application "System Events"
	set S to value of text field 1 of row 1 of table 1 of Â
		scroll area 1 of tab group 1 of window "Sound" of Â
		application process "System Preferences"
end tell

if S = "Headphones" then
	set lowVolume to 9
else
	set lowVolume to 22
end if

-- lower it if above min volume

if originalVolume > lowVolume then
	set newVolume to lowVolume
	set volume output volume newVolume
	set returnVolume to originalVolume
else
	set volume output volume returnVolume
end if