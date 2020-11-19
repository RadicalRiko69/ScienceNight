local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(FullScreen; diffuse, Color.Black);
		OnCommand=cmd(diffusealpha,0.8);
	};
};


t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(Center);
	Def.ActorFrame {
		InitCommand=cmd(x,-420;y,-100);
		LoadActor(THEME:GetPathG("","_dialogue/box")) .. {
			InitCommand=cmd(zoom,0.6;xy,SCREEN_CENTER_X,SCREEN_CENTER_Y;addx,25);
		};

		LoadActor("mask")..{
			InitCommand=cmd(zoomto,150,150;y,SCREEN_CENTER_X,SCREEN_CENTER_Y;addx,180;addy,-210;MaskSource);
		};
	
		LoadActor("grid") .. {
			InitCommand=cmd(zoomto,150,150;xy,SCREEN_CENTER_X,SCREEN_CENTER_Y;addx,-300;MaskDest);
			OnCommand=cmd(texcoordvelocity,0,0.1;fadetop,1);
		};
	
		LoadActor(THEME:GetPathG("","_dialogue/elayna")) .. {
			InitCommand=cmd(zoomto,150,150;xy,SCREEN_CENTER_X,SCREEN_CENTER_Y;addx,-300;MaskDest);
		};
	
		LoadActor("frame") .. {
			InitCommand=cmd(zoomto,150,150;xy,SCREEN_CENTER_X,SCREEN_CENTER_Y;addx,-300);
		};
};
};
t[#t+1] = LoadFont("_charter bt 40px")..{
	Name="Name";
	Text="Elayna Ramirez";
	InitCommand=cmd(addx,340;y,SCREEN_CENTER_Y+120;halign,0;valign,0;zoom,0.5;wrapwidthpixels,1300;shadowlength,1;sleep,1;linear,0.5;diffusealpha,1);
};

t[#t+1] = LoadFont("extras/_zona pro bold outline 40px")..{
	Name="Dialogue";
	Text="You are about to select Mission Mode, however, this is only\ncompatible with the P1 side of the pad.\n\nDo you wish to continue?";
	InitCommand=cmd(addx,340;y,SCREEN_CENTER_Y+150;halign,0;valign,0;zoom,0.35;wrapwidthpixels,1300;shadowlength,1;sleep,1;linear,0.5;diffusealpha,1);
};

return t;
