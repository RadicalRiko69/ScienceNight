return Def.ActorFrame {
	OnCommand=cmd(sleep,4;linear,0.5;diffusealpha,0;);
  Def.Sprite{
    Name= "team",
    OnCommand= cmd(zoom,0.6;x,SCREEN_CENTER_X-30;y,SCREEN_CENTER_Y-400;sleep,1;linear,0.1;addy,365;sleep,0.05;addy,-1;sleep,0.05;addy,1),
    Texture= "team (doubleres).png",
  },
  Def.Sprite{
    Name= "sushi",
    OnCommand= cmd(zoom,0.6;x,SCREEN_CENTER_X+30;y,SCREEN_CENTER_Y+400;sleep,1;linear,0.1;addy,-365;sleep,0.05;addy,1;sleep,0.05;addy,-1),
    Texture= "sushi (doubleres).png",
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
