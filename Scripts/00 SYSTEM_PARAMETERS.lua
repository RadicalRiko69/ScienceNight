
--[[
A list of songs that should have red names in the music select
Pointer comparison is significantly faster than
string comparison so use SONGMAN:FindSong() instead
of keeping strings in the array.
Yes, songs are pointers.
]]

--For boss songs, regular and Quest bosses.
redNames = {
	SONGMAN:FindSong("ScienceNight/ZBOSS - ESCAPE"),
	SONGMAN:FindSong("ScienceNight/ZBOSS - POSSESSION"),
	SONGMAN:FindSong("ScienceNight/ZBOSS - Anti-Matter"),
	SONGMAN:FindSong("World 1/QBOSS - Up Up And Away")
}

--For free songs, all unlocked and original songs will be white.
freeSongs = {
	SONGMAN:FindSong("ScienceNight/A - Could This Be Real"),
	SONGMAN:FindSong("ScienceNight/A - Dance (The Way It Moves)"),
	SONGMAN:FindSong("ScienceNight/A - Don't Let Me Down"),
	SONGMAN:FindSong("ScienceNight/A - Hush"),
	SONGMAN:FindSong("ScienceNight/A - I Took A Pill In Ibiza (SeeB Remix)"),
	SONGMAN:FindSong("ScienceNight/A - Stressed Out"),
	SONGMAN:FindSong("ScienceNight/K - One"),
	SONGMAN:FindSong("ScienceNight/K - Rooftop"),
	SONGMAN:FindSong("ScienceNight/K - Sugar Free")
}


--If true, will show all song groups instead of the below array.
showAllGroups = false

--Song groups to show in the song select. Duh.
songGroups = {
	"Composite",
	"ScienceNight",
	"Infinity",
	"Custom Music",
	"Prime 2",
	"00-Snap Tracks",
	"01-Country",
	"02-EDM",
	"03-Hip Hop",
	"04-Latin",
	"05-K-Pop",
	"06-Pop",
	"07-Rock",
	"08-Season 2",
	"09-Season 2 FINAL",
	"10-Classic",
	"80-Full Tracks",
	"81-Rave",
	"99-Special",
}
