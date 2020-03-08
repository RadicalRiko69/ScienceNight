
--[[
A list of songs that should have red names in the music select
Pointer comparison is significantly faster than
string comparison so use SONGMAN:FindSong() instead
of keeping strings in the array.
Yes, songs are pointers.
]]
redNames = {
	SONGMAN:FindSong("ScienceNight/ESCAPE"),
	SONGMAN:FindSong("19-DELTA NEX REBIRTH/Final Dance")
}


--If true, will show all song groups instead of the below array.
showAllGroups = false

--Song groups to show in the song select. Duh.
songGroups = {
	"19-DELTA NEX REBIRTH",
	"Anything else"
}
