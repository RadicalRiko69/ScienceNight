return Def.ActorFrame {
	OnCommand=cmd(sleep,2;linear,0.5;diffusealpha,0;);
  Def.Sprite{
        Name= "team",
        OnCommand= cmd(zoom,0.65;x,SCREEN_CENTER_X-58;y,SCREEN_CENTER_Y-800;sleep,1;linear,0.1;addy,728;sleep,0.05;addy,-1;sleep,0.05;addy,1;),
        Texture= "team",
      },
  Def.Sprite{
        Name= "sushi",
        OnCommand= cmd(zoom,0.58;x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y+800;sleep,1;linear,0.1;addy,-728;sleep,0.05;addy,1;sleep,0.05;addy,-1;),
        Texture= "sushi",
      },
     
    LoadFont("Common Normal")..{
    	Text="With help from";
    	OnCommand=cmd(Center;addy,275/2;diffusealpha,0;sleep,1;linear,.1;diffusealpha,1;);
    };
	Def.Sprite{
		Texture="RhythmLunatic Logo";
		InitCommand=cmd(Center;addy,375/2;diffusealpha,0);
		OnCommand=cmd(sleep,1;linear,0.1;diffusealpha,1);
	};
	
};
