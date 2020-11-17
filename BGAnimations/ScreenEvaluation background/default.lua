local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor("BG") .. {
		InitCommand=cmd(zoom,0.5;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	};
	Def.ActorFrame{
		LoadActor("space")..{
			OnCommand=cmd(Center;zoom,0.8;diffusealpha,0.15)
		};
	};
};

t[#t+1] = Def.ActorFrame {
	FOV=120;
	InitCommand=cmd(Center;spin;effectmagnitude, 0,0,20);
	  Def.ActorFrame {
		  LoadActor("_checkerboard") .. {
			  InitCommand=cmd(y,SCREEN_CENTER_Y+100;rotationy,-30;rotationz,180;rotationx,90/4*3.5;zoomto,SCREEN_WIDTH*4,SCREEN_HEIGHT*2;customtexturerect,0,0,SCREEN_WIDTH*4/256,SCREEN_HEIGHT*4/256);
			  OnCommand=cmd(texcoordvelocity,0,-1;diffuse,color("#a41a4d");fadetop,2);
		  };
	  };
	  Def.ActorFrame {
		  LoadActor("_checkerboard") .. {
			  InitCommand=cmd(y,SCREEN_CENTER_Y-750;rotationy,-30;rotationz,180;rotationx,90/4*3.5;zoomto,SCREEN_WIDTH*4,SCREEN_HEIGHT*2;customtexturerect,0,0,SCREEN_WIDTH*4/256,SCREEN_HEIGHT*4/256);
			  OnCommand=cmd(texcoordvelocity,0,-1;diffuse,color("#a41a4d");fadetop,2);
		  };
	  };
	  LoadActor("_particleLoader") .. {
		  InitCommand=cmd(x,-SCREEN_CENTER_X;y,-SCREEN_CENTER_Y);
	  };
  };

  t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		Name="Banner";
		Texture=getJacketOrBanner(GAMESTATE:GetCurrentSong());
		OnCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffusealpha,0;sleep,1;decelerate,1;diffusealpha,0.2);
	};	
};


return t;
