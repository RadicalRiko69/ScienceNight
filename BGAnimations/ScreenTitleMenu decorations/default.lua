return Def.ActorFrame {
	InitCommand=function(self)
		--Reset the vars, player options, etc here.
		ResetGame();
	end;
	Def.Quad {
		InitCommand=cmd(FullScreen; diffuse, Color.Black);
		OnCommand=cmd(diffusealpha,0.8;sleep,3.4;diffusealpha,0);
	};
	Def.Quad {
		InitCommand=cmd(FullScreen; diffuse, Color.Black);
		OnCommand=cmd(diffusealpha,1;sleep,2;linear,1;diffusealpha,0);
	};
    LoadActor("elayna")..{
        InitCommand=cmd(zoom,0.25;x,SCREEN_LEFT-500;y,SCREEN_CENTER_Y+150; diffuse, Color.Black);
        OnCommand=cmd(sleep,2;decelerate,1.5;x,SCREEN_CENTER_X-220;sleep,0.01; diffuse, Color.White);
    };
	Def.Quad {
		InitCommand=cmd(FullScreen; diffuse, Color.White);
		OnCommand=cmd(diffusealpha,0;sleep,3.4;diffusealpha,1;linear,1;diffusealpha,0);
	};
    LoadActor(THEME:GetPathG("", "logo")) .. {
		InitCommand=cmd(zoom,0.3;Center),
		OnCommand=cmd(diffusealpha,1;sleep,1.35;decelerate,1;zoom,0.15;addy,-220;addx,260)
	};
	LoadActor("intro")..{
		--There's some way to pause a sound for a while without queuecommand, right?
		OnCommand=cmd(queuecommand,"PlaySound");
		PlaySoundCommand=cmd(play);
	};
    LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(horizalign,left;x,SCREEN_LEFT+20;y,SCREEN_BOTTOM-40);
		OnCommand=function(self)
			self:settext("Project by Team Sushi\nProgramming by RhythmLunatic\nIllustration by UsagiSii");
			(cmd(finishtweening;zoom,0.4)) (self)
		end;
	};
};
