local t = Def.ActorFrame {};
t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black"));
	StartTransitioningCommand=cmd(diffusealpha,0;sleep,0;linear,4;diffusealpha,1);
};

t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("White"));
	StartTransitioningCommand=cmd(diffusealpha,1;sleep,0;linear,2;diffusealpha,0);
};

return t
