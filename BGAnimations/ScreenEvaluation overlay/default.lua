local t = Def.ActorFrame {
	OffCommand=function()
		setenv("StageFailed",false);
	end;
};

local function BannerUpdate(self)
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
end;
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(x,SCREEN_LEFT+250;y,SCREEN_CENTER_Y-55;SetUpdateFunction,BannerUpdate);
	Def.Sprite {
		Name="Banner";
		OnCommand=cmd(scaletoclipped,500,500;diffusealpha,0;sleep,1;decelerate,1;diffusealpha,1);
		OffCommand=cmd(decelerate,0.5;zoom,0;diffusealpha,0);
	};	
};

t[#t+1] = LoadActor("AR Results")..{OnCommand=cmd(play)};	--Music

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do	
	t[#t+1] = LoadActor("DanceGrade",pn);
end;

t[#t+1] = LoadActor("music (loop)")..{						
		InitCommand=cmd(sleep,3.5;queuecommand,"PlaySound");
		PlaySoundCommand=cmd(play);
		OffCommand=cmd(stop);
	};
--songinfo
local cursong =		GAMESTATE:GetCurrentSong()
local song =		cursong:GetDisplayMainTitle()
local artist =		GAMESTATE:GetCurrentSong():GetDisplayArtist()

	t[#t+1] = LoadActor("top_title")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+100;horizalign,center;zoomx,0;zoomy,1;sleep,0.5;linear,0.2;zoomx,1);
		OffCommand=cmd(decelerate,0.5;zoomx,0);
	};

	--[[t[#t+1] = LoadActor("PlayerGrade", pn)..{
		InitCommand=cmd(xy,SCREEN_CENTER_X-120+grades_xPos*position,SCREEN_CENTER_Y+100);
		OffCommand=cmd(linear,0.25;diffusealpha,0);
	};--]]
	
	t[#t+1] = Def.ActorFrame {
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+149;diffusealpha,0;sleep,1.5;linear,0.75;diffusealpha,1;);
		OffCommand=cmd(decelerate,0.5;diffusealpha,0);
	
		LoadFont("_alternategotno2 40px")..{	--SONG + (SUBTITLE)
			InitCommand=cmd(zoom,1;diffuse,0,0,0,1;horizalign,center;settext,cursong:GetDisplayFullTitle();maxwidth,1250);
			OnCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					self:settext(GAMESTATE:GetCurrentCourse():GetDisplayFullTitle());
				end;
			end;
		};
	};

return t;