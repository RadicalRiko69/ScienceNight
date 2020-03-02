--[[
Mission mode for ~~RIO~~ ScienceNight
Designed to be as idiot proof as possible
Now without courses, because ScienceNight doesn't use courses (lol)
Ignore the instructions below because they're not accurate

Setup:
1. Make a folder in Courses with the name of your mission group.
2. Fill it with up to 6 courses. In each course, put in a #MISSIONID tag with the number you want this course to be in the group. (Ranging from 1-6, since the theme only displays 6 missions at a time)
3. Add to this script.

Refer to https://github.com/stepmania/stepmania/wiki/Courses on help with making courses.
Unique tags for RIO missions:
NOT USED : #MINSCORE:    minimum score needed to pass.
#MINACCURACY: minimum accuracy needed to pass.
#MINGRADE:    minimum grade needed to pass? Isn't this just minaccuracy again?
#MINCOMBO:    minimum combo needed to pass.
#MAXBREAK:    maximum combo breaks allowed.
(Unimplemented) #LIMITBREAK: maximum number of misses allowed

]]
--[[
Sorry jousway lol you can put it in the config.ini if you want
This controls the number of courses you can skip before going on to the next mission group.
So let's say you completed 3 out of 5 missions for the group it's set to 2, now you can
go on to the next group.
]]
NUM_MISSIONS_SKIPPABLE = 0
--[[
There are as many course worlds as you want, with course areas inside those course worlds,
with courses inside the course area folders
Since SM doesn't support nested course folders, you just have to prefix them and specify the
folder.
Ingame it will be changed so "EASY - The First Step" -> "The First Step"
Note: Obviously don't reuse the same folders for all three mission worlds, then
you'd have the same grades for all the courses.
]]


--[[
The mission groups that will be used for P ScienceNight.
They're in order, so you have to clear the first mission group to unlock the next, etc...
]]
MISSION_GROUPS = {
	"April Fools"
}

-- 'QUESTMODEMAN' was a bit too verbose
QUESTMODE = {
	allMissionsPlayable = false, --DEBUGGING
	currentWorld = nil,
	savefile = "SN_MissionSaveData.json",
	PlayerNumber_P1 = nil,
	PlayerNumber_P2 = nil
}

QUESTMODE.Reset = function(self)
	self[PLAYER_1] = nil;
	self[PLAYER_2] = nil;
end;

QUESTMODE.GetSaveDataPath=function(self,player)
	local profileDir = PROFILEMAN:GetProfileDir(ProfileSlot[PlayerNumber:Reverse()[player]+1])
	assert(profileDir ~= '',"No profile is loaded for "..player.." ("..ProfileSlot[PlayerNumber:Reverse()[player]+1].."). Cannot load/save mission data.")
	return profileDir..self.savefile
end;

function GetCurrentStepsIndex(pn,stepsArray)
	local playerSteps = GAMESTATE:GetCurrentSteps(pn);
	for i=1,#stepsArray do
		if playerSteps == stepsArray[i] then
			return i;
		end;
	end;
	--If it reaches this point, the selected steps doesn't equal anything.
	return -1;
end;

QUESTMODE.CheckAndUpdateMissionStatus=function(self,player)
	local clearStatus = self:HasPassedMission(player);
	
	assert(self.currentWorld, "current world string not set!")
	assert(self[player][self.currentWorld], pname(player).." table does not contain the world '"..self.currentWorld.."'. This is a fatal error, you will have to recreate your save file.")
	assert(self[player][self.currentWorld][GAMESTATE:GetCurrentSong():GetTranslitFullTitle()],"The "..pname(player).." table doesn't have the current song! Current World: "..self.currentWorld);
	
	local curIndex = GetCurrentStepsIndex(player,GAMESTATE:GetCurrentSong():GetAllSteps())
	assert(curIndex, "No valid steps?")
	assert(#self[player][self.currentWorld][GAMESTATE:GetCurrentSong():GetTranslitFullTitle()] > curIndex, "curIndex > number of steps in song. numSteps: "..
	#self[player][self.currentWorld][GAMESTATE:GetCurrentSong():GetTranslitFullTitle()]..
	" | curIndex: "..curIndex
	);
	
	--If it's not already passed, update the clear status. Since we don't want to set a cleared mission back to uncleared.
	if self[player][self.currentWorld][GAMESTATE:GetCurrentSong():GetTranslitFullTitle()][curIndex] ~= true then
		self[player][self.currentWorld][GAMESTATE:GetCurrentSong():GetTranslitFullTitle()][curIndex] = clearStatus;
	end;
	return clearStatus;
end;

QUESTMODE.HasPassedMission=function(self,player)
	assert(self[player],"LoadCurrentProgress hasn't been called yet!")
	--Check this first
	local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
	if stats:GetFailed() == true then
		return false;
	end;
	
	--local hasPassed = true;
	--TODO: reimplement for SN
	--[[local crsFile = GAMESTATE:GetCurrentCourse():GetCourseDir();
	local minimumAccuracy = tonumber(GetTagValue(crsFile,"MINACCURACY"))
	if minimumAccuracy then
		local p1accuracy = getenv(pname(player).."_accuracy") or 0;
		if p1accuracy < minimumAccuracy then
			return false;
		end;
	end;
	
	--RIO scoring isn't working right now, so this will be done later...
	--local minimumScore = tonumber(GetTagValue(song:GetSongFilePath(),"MINSCORE"))
	
	local minimumCombo = tonumber(GetTagValue(crsFile,"MINCOMBO"))
	if minimumCombo then
		if stats:MaxCombo() < minimumCombo then
			return false;
		end;
	end
	
	local minimumGrade = GetTagValue(crsFile,"MINGRADE")
	if minimumGrade ~= "" then
		--In ScoreGradeManager
		local grade = getGradeAsInt(player);
		assert(GRADE_TABLE[minimumGrade], "MINGRADE has an invalid grade: "..minimumGrade);
		if grade < GRADE_TABLE[minimumGrade] then
			return true;
		end;
	end;]]
	
	--You might be wondering where maxBreak is, well it's handled by the gameplay lua so we don't actually need to check here.
	--If you go over the max breaks allowed you'll just fail the song immediately
	return true;
end;

QUESTMODE.SaveCurrentProgress=function(self,player)
	assert(self[player],"LoadCurrentProgress hasn't been called yet!")
	local path = self:GetSaveDataPath(player);
	local strToWrite = json.encode(self[player])
	local file= RageFileUtil.CreateRageFile()
	if not file:Open(path, 2) then
		error("Could not open '" .. path .. "' to write quest mode save file.")
		return false;
	else
		file:Write(strToWrite)
		file:Close()
		file:destroy()
		return path
	end
end;

QUESTMODE.GenerateNewFile=function()
	local tempArr = {};
	for mWorldName in ivalues(MISSION_GROUPS) do
		tempArr[mWorldName] = {};
		--No need, the songwheel can generate it on the fly when it sees the song..
		--[[for song in ivalues(SONGMAN:GetSongsInGroup(mWorldName,true)) do
			--Always get TranslitFullTitle since it doesn't depend on user settings
			tempArr[mWorldName][song:GetTranslitFullTitle()] = {}
			for i,steps in pairs(song:GetAllSteps())
				tempArr[mWorldName][song:GetTranslitFullTitle()][i] = false;
			end;
		end;]]
	end;
	return tempArr;
end;

QUESTMODE.LoadCurrentProgress=function(self,player)
	local path = self:GetSaveDataPath(player);
	if FILEMAN:DoesFileExist(path) then
		local tempArr = json.decode(lua.ReadFile(path))
		if tempArr then
			self[player] = tempArr
			return true;
		else
			
		end;
	end;
	self[player] = self:GenerateNewFile();
	return true;
end;
