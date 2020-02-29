local t = Def.ActorFrame {};
t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black"));
	StartTransitioningCommand=cmd(diffusealpha,0;sleep,0;linear,4;diffusealpha,1);
};

t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("White"));
	StartTransitioningCommand=cmd(diffusealpha,1;sleep,0;linear,2;diffusealpha,0);
};

t[#t+1] = LoadFont("Common Normal")..{
	Text="Hold center step to access options";
	InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_BOTTOM-100);
	StartTransitioningCommand=cmd(diffusealpha,1;linear,4;diffusealpha,0);
};

return t
