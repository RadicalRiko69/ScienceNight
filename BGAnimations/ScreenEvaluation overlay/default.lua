local t = Def.ActorFrame {
	OffCommand=function()
		setenv("StageFailed",false);
	end;
};

--[[local function BannerUpdate(self)
	local song = GAMESTATE:GetCurrentSong();
	local banner = self:GetChild("Banner");
	local height = banner:GetHeight();
	
	if song then
		if song:HasBanner() then
			banner:visible(true);
			banner:Load(song:GetBannerPath());
		else
			banner:visible(false);
		end;
	else
		banner:visible(false);
	end;
	
	self:zoom(0.57)
end;]]

local statsP1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1);
local statsP2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2);

local gradeP1 = statsP1:GetGrade();
local gradeP2 = statsP2:GetGrade();

local function failed(g)
	if g == "Grade_Failed" then
		return true;
	else
		return false;
	end
end

-- if (only P1) and (P1 failed)
if (GAMESTATE:IsHumanPlayer(PLAYER_1) and failed(gradeP1) and not GAMESTATE:IsHumanPlayer(PLAYER_2)) then
	t[#t+1] = LoadActor("failure (loop)")..{OnCommand=cmd(sleep,3.5;queuecommand,"PlaySound");PlaySoundCommand=cmd(play);OffCommand=cmd(stop);};	--Music
	
-- if (only P2) and (P2 failed)	
elseif (GAMESTATE:IsHumanPlayer(PLAYER_2) and failed(gradeP2) and not GAMESTATE:IsHumanPlayer(PLAYER_1)) then
	t[#t+1] = LoadActor("failure (loop)")..{OnCommand=cmd(sleep,3.5;queuecommand,"PlaySound");PlaySoundCommand=cmd(play);OffCommand=cmd(stop);};	--Music

-- if (both P1 and P2) and (both P1 and P2 failed)	
elseif (GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2) and failed(gradeP1) and failed(gradeP2) ) then
	t[#t+1] = LoadActor("failure (loop)")..{OnCommand=cmd(sleep,3.5;queuecommand,"PlaySound");PlaySoundCommand=cmd(play);OffCommand=cmd(stop);};	--Music

--if nobody failed?
else
	t[#t+1] = LoadActor("results (loop)")..{OnCommand=cmd(sleep,3.5;queuecommand,"PlaySound");PlaySoundCommand=cmd(play);OffCommand=cmd(stop);};	--Music
end

t[#t+1] = LoadActor("AR Results")..{OnCommand=cmd(play)};	--Music


--assert(GAMESTATE:IsSideJoined(GAMESTATE:GetMasterPlayerNumber()),"No players are joined. You shouldn't be able to get this far.")
--Yeah it's more code to maintain, but it's not really my job to fix it
if GAMESTATE:GetNumSidesJoined() == 1 then
	t[#t+1] = LoadActor("DanceGrade_Single")
else
	t[#t+1] = LoadActor("DanceGrade_Multi")
end;

--[[for pn in ivalues(GAMESTATE:GetHumanPlayers()) do	
	t[#t+1] = LoadActor("DanceGrade",pn);
end;]]

--songinfo
local cursong =		GAMESTATE:GetCurrentSong()
local artist =		GAMESTATE:GetCurrentSong():GetDisplayArtist()

t[#t+1] = Def.ActorFrame {
	--OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+149;);
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+50;);
	
	LoadActor("top_title")..{
		InitCommand=cmd(horizalign,center;zoomx,0;zoomy,1;sleep,0.5;linear,0.2;zoomx,1);
		OffCommand=cmd(decelerate,0.5;zoomx,0);
	};

	LoadFont("_alternategotno2 40px")..{	--SONG + (SUBTITLE)
		Text=cursong:GetDisplayFullTitle();
		InitCommand=cmd(zoom,.6;diffuse,0,0,0,1;horizalign,center;maxwidth,1250;y,19);
		OffCommand=cmd(decelerate,0.5;diffusealpha,0);
		OnCommand=function(self)
			(cmd(diffusealpha,0;sleep,1.5;linear,0.75;diffusealpha,1;))(self)
			if GAMESTATE:IsCourseMode() then
				self:settext(GAMESTATE:GetCurrentCourse():GetDisplayFullTitle());
			end;
		end;
	};
};

return t;
