--Uncomment to enable alternate nameplates
--You probably need 1080p to see them
--do return Def.ActorFrame{ LoadActor("alternate"); } end;


return Def.ActorFrame {
    Def.Sprite{
    	Texture=THEME:GetPathG("","Avatars/"..ThemePrefs.Get("ProfilePictures"));
        InitCommand=cmd(zoomto,40,40;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;diffusealpha,0);
        OnCommand=cmd(decelerate,0.5;addy,-50;diffusealpha,1);
        OffCommand=cmd(decelerate,0.5;addy,50;diffusealpha,0);
    };
    LoadActor("blackline")..{
        InitCommand=cmd(zoom,.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+20;diffusealpha,0);
        OnCommand=cmd(decelerate,0.5;addy,-45;diffusealpha,1);
        OffCommand=cmd(decelerate,0.5;addy,50;diffusealpha,0);
    };
    --The vertical alignment on this font is beyond stupid
    LoadFont("_alternategotno2 40px")..{
        InitCommand=cmd(zoom,.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+20;diffusealpha,0;decelerate,0.5;addy,-40;diffusealpha,1);
		OffCommand=cmd(decelerate,0.5;addy,50;diffusealpha,0);
		--Text=THEME:GetString("Common","Username");
		--[[
		Return string before '.' character:
		:match("[^.]+")
		ex. local str = "Nine The Phantom.jpg"
		str:match("[^.]+") -> Nine The Phantom
		]]
		Text=ThemePrefs.Get("ProfilePictures"):match("[^.]+")
		--[[OnCommand=function(self)
			self:settext("ScienceNight");
			(cmd(zoom,.5)) (self)
		end;]]
	};
	--[[OnCommand=function(self)
		SCREENMAN:SystemMessage("HELLO WORLD");
	end;]]
};
