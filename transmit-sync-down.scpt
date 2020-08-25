--
--	Created by: Anthony DeCrescenzo
--	Created on: 6/12/20
--	Modified: 20200825.155146
--	Copyright © 2020 Anthony DeCrescenzo, All Rights Reserved
--
-- You might notice that the actual sync commands in the script
-- are all nested "if's." This is because the actual sync
-- command includes "with delete orphaned items." Thus, the 
-- remote appearance will be mirrored on the local. So if
-- you delete remote files, they will be deleted locally.
-- The nested "if's" are there to prevent file deletion in
-- any local folder other than the intended one. While 
-- testing this script it is recommended that you only 
-- uncomment the line with the "delete orphaned items" once
-- you are thoroughly sure that your folders reliably appear 
-- in Transmit's remote and local windows.
--
-- Further, all "notifications" and "delays" can be removed/commented,
-- but I prefer to watch the progress of the script as it runs.

use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

set localPath to "/your/local/hard/drive/path/"
set remotePath to "/your/ftp/remote/path/to/sync/with/"

tell application "System Events"
	display notification "Setting up to sync…"
	do shell script "open \"" & localPath & "\"" --escaped quotes around localPath for Mac terminal
	delay 1
end tell


tell application "Transmit"
	-- activate
	
	set myFave to item 1 of (favorites whose name is "Your Favorite Here")
	--set myRules to (skip rules whose name is "All Enabled Rules")
	
	tell current tab of (make new document at end)
		if (connect to myFave) then
			
			if (change location of local browser to path localPath) then
				display notification "Changed to local folder…"
				delay 1
				if (change location of remote browser to path remotePath) then
					display notification "Changed to remote folder…"
					delay 0.6
					display notification "Refreshing remote browser…"
					refresh remote browser
					delay 0.6
					display notification "Counting…"
					delay 0.6
					-- if count of items is 0 don't delete orphaned items
					set fileCount to (number of browser items of remote browser)
					if fileCount = 1 then
						set singPlural to {"is", "item"}
					else
						set singPlural to {"are", "items"}
					end if
					display notification "There " & item 1 of singPlural & " " & fileCount & " remote " & item 2 of singPlural & "."
					delay 2
					if fileCount = 0 then
						display notification "Nothing to sync."
						delay 2
						return
					else if fileCount > 0 then
						-- if (synchronize remote browser to local browser with time offset 0) then
						if (synchronize remote browser to local browser with time offset 0 with delete orphaned items) then
							do shell script "open \"" & localPath & "\"" --escaped quotes around localPath for Mac terminal
							display notification "Successfully synced down " & fileCount & " " & item 2 of singPlural & "."
							delay 2
						else
							display notification "Sync failed."
							delay 1
						end if
					end if
				else
					display notification "Failed to switch to remote folder…"
					delay 1
				end if
			else
				display notification "Failed to switch to local folder…"
				delay 1
			end if
			--close remote browser
		end if
	end tell
end tell
