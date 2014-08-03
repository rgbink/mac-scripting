property lb_prefix : "tel:"

on handle_string(s)

	tell application "System Events"
		set front_app to the name of first process whose frontmost is true
	end tell

	tell application "Dialectic"
		activate
		set theList to (get name of every location)
		choose from list theList with prompt "Please choose dialing location…"
		set answer to item 1 of the result
		--display dialog answer
		set current of location answer to true
	end tell

	tell application "System Events"
		set visible of process front_app to true
	end tell


	if s starts with lb_prefix then set s to (text ((count lb_prefix) + 1) thru -1 of s) --trim the LaunchBar prefix if it exists
	tell application "Dialectic" to dial number s --dial the number from LaunchBar
end handle_string