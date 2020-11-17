-- To save on intense copy/pasting, this file was made to be loaded by actual in/out bganim files,
-- whose only real jobs are to pass in the transition type (in or out), and in certain cases, the
-- color (as is the case in ScreenEditMenu in, ScreenSelectMusic in, etc).
-- Other than that, there isn't really too much to say.
local t = Def.ActorFrame {}

for i=6,1,-1 do
	local sleep_time = 0.1 * i
	t[#t+1] = LoadActor(THEME:GetPathG("", "_pt" .. i)) .. {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center),
		OnCommand=cmd(diffusealpha,1;sleep,sleep_time;linear,0.10;diffusealpha,0)
	}
	t[#t+1] = LoadActor(THEME:GetPathG("", "logo")) .. {
		InitCommand=cmd(zoom,0.3;Center),
		OnCommand=cmd(diffusealpha,1;sleep,sleep_time;linear,0.10;diffusealpha,0)
	}
	t[#t+1] = LoadFont("extras/_zona pro thin 40px") .. {
		Text="READY!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+100;skewx,-0.2;zoom,0.5);
		OnCommand=cmd(diffusealpha,1;sleep,sleep_time;linear,0.10;diffusealpha,0);
	}
end
	
return t
