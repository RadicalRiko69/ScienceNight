Branch.OptionsEdit = function()
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	return "ScreenEditMenu"
end

Branch.AfterSelectProfile = function()
	-- load the unlock data here.
	SNUNLOCK:LoadUnlockStatus()
	GAMESTATE:ApplyGameCommand("playmode,regular")
	
	if ( THEME:GetMetric("Common","AutoSetStyle") == true ) then
		return "ScreenSelectMusicCustom"
	end
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusicCustom"
	end
end
