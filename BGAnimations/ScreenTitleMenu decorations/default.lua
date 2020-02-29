return Def.ActorFrame {
	InitCommand=function(self)
		QUESTMODE:Reset();
	end;
    LoadActor("science_night running")..{
        InitCommand=cmd(zoom,0.8;x,SCREEN_LEFT-500;y,SCREEN_CENTER_Y);
        OnCommand=cmd(sleep,2;decelerate,1.5;x,SCREEN_CENTER_X-520);
    };
    LoadActor("logo")..{
        InitCommand=cmd(zoom,1);
        OnCommand=cmd(sleep,2;decelerate,0.5;addy,-120;zoom,0.4);
    };
};
