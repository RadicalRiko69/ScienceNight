local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black");Center);
	};
	LoadFont("Common Normal")..{
		Text="This theme does not support Free/Pay Mode.\nPlease hold F3 and press 1 to return to Home Mode.";
		InitCommand=cmd(Center);
	};
};

return t;
