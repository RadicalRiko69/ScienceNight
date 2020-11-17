local t = Def.ActorFrame{};

	t[#t+1] = LoadActor("complete")..{
		InitCommand=cmd(Center;zoom,0);
		OnCommand=cmd(sleep,1;decelerate,0.5;zoom,0.7;decelerate,0.25;zoom,0.5;decelerate,1;rotationz,10);
	};

	t[#t+1] = LoadActor("_transition")..{
		InitCommand=cmd(sleep,3);
	};

	
return t;