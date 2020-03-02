local gc = Var("GameCommand");
local index = gc:GetIndex()+1;

return Def.ActorFrame {
	LoadFont("_charter bt 40px") .. {
		Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
		OnCommand=cmd(horizalign,right;addx,-100;diffusealpha,0;sleep,3+index*.1;decelerate,.2;addx,100;diffusealpha,1);
		GainFocusCommand=cmd(stoptweening;linear,.1;zoom,0.8);
		LoseFocusCommand=cmd(stoptweening;linear,.1;zoom,0.7);
	};
};
