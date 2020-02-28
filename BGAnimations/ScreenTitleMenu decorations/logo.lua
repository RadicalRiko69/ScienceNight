return Def.ActorFrame {
    LoadActor("project")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-600;y,SCREEN_CENTER_Y-130;zoom,1);
    };
    LoadActor("sciencenight")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1);
    };
    LoadActor("pumpitup")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+90;zoom,1);
	};
};
