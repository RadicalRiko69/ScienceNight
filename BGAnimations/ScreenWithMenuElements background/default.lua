local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor("BG") .. {
		InitCommand=cmd(zoom,0.5;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	};
};

t[#t+1] = Def.ActorFrame {
  FOV=90;
  InitCommand=cmd(Center);
	Def.ActorFrame {
		InitCommand=cmd(hide_if,hideFancyElements;);
		LoadActor("_checkerboard") .. {
			InitCommand=cmd(rotationy,0;rotationz,0;rotationx,-90/4*3.5;zoomto,SCREEN_WIDTH*9,SCREEN_HEIGHT*9;addy,50;customtexturerect,0,0,SCREEN_WIDTH*16/256,SCREEN_HEIGHT*16/256);
			OnCommand=cmd(texcoordvelocity,0,0.1;diffuse,color("#ff7dad");fadetop,5);
		};
	};
	LoadActor("_particleLoader") .. {
		InitCommand=cmd(x,-SCREEN_CENTER_X;y,-SCREEN_CENTER_Y);
	};
};

--[[ Background!
t[#t+1] = Def.ActorFrame {
	LoadActor("web") .. {
		InitCommand=cmd(zoom,0.5;bob;effectmagnitude,0,5,0);
	};
}; --]]

t[#t+1] = Def.ActorFrame {
	LoadActor("moon") .. {
		InitCommand=cmd(zoom,0.25;x,SCREEN_CENTER_X+250;y,SCREEN_CENTER_Y-200;diffusealpha,0.5);
	};
};

return t;
