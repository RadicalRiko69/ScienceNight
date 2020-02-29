local t = Def.ActorFrame{};

	t[#t+1] = LoadActor("stagebreak")..{
		InitCommand=cmd(Center;zoom,0.75;diffusealpha,0);
		OnCommand=cmd(linear,0.25;diffusealpha,1);
	};
	--1.5 for 1080p, 0.7 for 480p
	
	t[#t+1] = Def.Quad {
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH+1,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("1,1,1,0");sleep,6;playcommand,"Off");
--		OffCommand=cmd(diffusealpha,0;accelerate,0.001;diffusealpha,0);
	};
	

	t[#t+1] = LoadActor(THEME:GetPathS( Var "LoadingScreen", "failed" ) ) .. {
		StartTransitioningCommand=cmd(play);
	};


return t;