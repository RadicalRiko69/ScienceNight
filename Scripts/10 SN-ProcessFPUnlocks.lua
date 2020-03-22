--This file handles processing of unlocks for free play in ScienceNight.
--Note that 09 QuestMode.lua is required.

SNUNLOCK = {
	--allUnlocked = false; --Debugging only.
	savefile = "SN_UnlockedSongs.json",
	
	--Songs that are unlocked by default. This is on a per-folder basis.
	--If you don't define a folder here, all songs will be unlocked.
	--So if you want a folder to be full of locked songs but also no free unlocks, define an empty folder (ex. put in ["19-Delta 2"],)
	InitialUnlocks = {
		--Folder name
		["ScienceNight"] = {
			--List of songs to be unlocked
			"A - Could This Be Real",
			"A - Dance (The Way It Moves)",
			"A - Don't Let Me Down",
			"A - Hush",
			"A - I Took A Pill In Ibiza (SeeB Remix)",
			"A - Stressed Out",
			"K - One",
			"K - Rooftop",
			"K - Sugar Free"
		},
		["19-DELTA NEX REBIRTH"] = {
			"A",
			"Lionheart",
			"Routing"
		}
	},
	--A table containing POINTERS to songs, not song titles.
	UnlockedSongs = nil;
	--A table containing the unlocked songs as strings. It's necessary so we don't unlock the same song twice. It's only loaded during mission mode, though.
	--UnlockedSongsStrings = nil;
}

SNUNLOCK.GetSaveDataPath=function(self,player)
	local profileDir = PROFILEMAN:GetProfileDir(ProfileSlot[PlayerNumber:Reverse()[player]+1])
	--We want to return nil if they're not using a profile.
	--[[if profileDir == '' then
		return nil
	end]]
	assert(profileDir ~= '',"No profile is loaded for "..player.." ("..ProfileSlot[PlayerNumber:Reverse()[player]+1].."). Cannot load/save mission data.")
	return profileDir..self.savefile
end;


local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

--This loads the unlock status for free play, not the table used for storing unlock status
--The naming isn't very good
SNUNLOCK.LoadUnlockStatus = function(self)
	self.UnlockedSongs = {};
	--TODO: It might be faster just to cache the folder of inital unlocks on startup?
	for folderName,songs in pairs(self.InitialUnlocks) do
		self.UnlockedSongs[folderName] = {};
		--Fill the table with songs
		for i,songName in ipairs(songs) do 
			self.UnlockedSongs[folderName][i] = SONGMAN:FindSong(folderName.."/"..songName);
		end;
	end
	
	
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		local path = self:GetSaveDataPath(pn);
		--If it doesn't already exist then they just get the default unlocks.
		if path ~= nil and FILEMAN:DoesFileExist(path) then
			local tempArr = json.decode(lua.ReadFile(path))
			if tempArr then
				for folderName,songs in pairs(tempArr) do
					--Pointer to UnlockedSongs[folderName] because I like shorter variables
					local fPointer = self.UnlockedSongs[folderName];
					fPointer = {};
					--Fill the table with songs
					for i,songName in ipairs(songs) do
						local song = SONGMAN:FindSong(folderName.."/"..songName);
						if not has_value(fPointer,song) then --Check if exists in case P1 and P2 both have the song unlocked.
							fPointer[i] = song;
						end;
					end;
				end
			else
				
			end;
		end;
	end;
	
	--For some reason the count doesn't work correctly but the unlock print works so it's fine
	--Trace("SNUNLOCK: "..#self.UnlockedSongs.." groups in unlocked songs table.");
	for group,contents in pairs(self.UnlockedSongs) do
		local st = group..": ";
		for song in ivalues(contents) do
			st = st..song:GetTranslitMainTitle()..", "
		end;
		Trace(st);
	end;
	--lua.Flush();
	return true;
end;


--By Alisson (ROAD24)
local function GetTagValue(file,tag)
	if FILEMAN:DoesFileExist(file) then
		local readfile = File.Read( file )
			if not readfile then return "" end
		local fnd = string.find(readfile , "#"..tag..":")
			if not fnd then return "" end
		local last = string.find(readfile , ";" , fnd)
		local found = string.sub(readfile,fnd,last)
			found = string.gsub(found, "\r", "")
			found = string.gsub(found, "\n", "")
			found = string.gsub(found,  "#"..tag..":", "")
			found = string.gsub(found, ";", "")
		return found
	else
		return ""
	end
end;

--Simple function, opens the save file, adds folder and name to the unlock json and saves it.
SNUNLOCK.UnlockSong=function(self,player,songFolder,songName)
	local path = self:GetSaveDataPath(player);
	if FILEMAN:DoesFileExist(path) then
		local unlocks = json.decode(lua.ReadFile(path))
		if unlocks then
			--If table doesn't already exist, create a new table.
			if not unlocks[songFolder] then
				unlocks[songFolder] = {};
			end;
			--Don't unlock it twice!
			if has_value(unlocks[songFolder],songName) then return false end;
			unlocks[songFolder][#unlocks[songFolder]+1] = songName;
		else
			error("Error parsing the unlocks table. Your save file is corrupt!");
			return false;
		end;
	else
		--No file yet. Make a new one.
		unlocks = {};
		unlocks[songFolder] = {};
		unlocks[songFolder][1] = songName;
	end;
	
	local strToWrite = json.encode(unlocks)
	local file= RageFileUtil.CreateRageFile()
	if not file:Open(path, 2) then
		error("Could not open '" .. path .. "' to write song unlock save file.")
		return false;
	else
		file:Write(strToWrite)
		file:Close()
		file:destroy()
		return true
	end
end;

SNUNLOCK.GetSongsInGroup=function(self,folderName)
	assert(self.UnlockedSongs,"Unlocked songs table is nil! Please load it first...");
	if self.UnlockedSongs[folderName] then
		return self.UnlockedSongs[folderName]
	else
		--SCREENMAN:SystemMessage(folderName.." not found in unlocked songs table.");
		return SONGMAN:GetSongsInGroup(folderName)
	end;
end;

--Not part of the SNUNLOCK class because it's more centric towards ScienceNight than anything else.
--Unlock information is stored in the ssc.
function SN_unlockFromSSC(player, song)
	--local fand = RageFileUtil.CreateRageFile()
	local songToUnlock = GetTagValue(song:GetSongFilePath(),"SONGUNLOCK")
	local posToCut = string.find(songToUnlock, "/", 1)
	local songFolder = string.sub(songToUnlock, 1, posToCut - 1)
	local songName = string.sub(songToUnlock, posToCut + 1)
	return SNUNLOCK:UnlockSong(player,songFolder,songName);
	--local song = SONGMAN:FindSong(songToUnlock);
	--assert(song, "SONGMAN failed to find the song to unlock. Check if you have any typos.");
	
end;
