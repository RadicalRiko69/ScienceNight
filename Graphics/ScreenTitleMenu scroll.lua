local gc = Var("GameCommand");

return Def.ActorFrame {
	LoadFont("_charter bt 40px") .. {
		Text=THEME:GetString("ScreenTitleMenu",gc:GetText());
		GainFocusCommand=cmd(stoptweening;decelerate,.1;zoom,1;diffuse,color("#FFFFFF"));
		LoseFocusCommand=cmd(stoptweening;decelerate,.1;zoom,0.9;diffuse,color("#4d4d4d"));
	};
};
