return Def.ActorFrame {
	InitCommand=function(self)
		--Reset the vars, player options, etc here.
		ResetGame();
	end;
    LoadActor("elayna")..{
        InitCommand=cmd(zoom,0.25;x,SCREEN_LEFT-500;y,SCREEN_CENTER_Y+150);
        OnCommand=cmd(sleep,2;decelerate,1.5;x,SCREEN_CENTER_X-220);
    };
    LoadActor(THEME:GetPathG("", "logo")) .. {
		InitCommand=cmd(zoom,0.3;Center),
		OnCommand=cmd(diffusealpha,1;sleep,2;decelerate,0.5;zoom,0.15;addy,-220;addx,260)
	};
    LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(horizalign,left;x,SCREEN_LEFT+20;y,SCREEN_BOTTOM-40);
		OnCommand=function(self)
			self:settext("Project by Team Sushi\nProgramming by RhythmLunatic\nIllustration by UsagiSii");
			(cmd(finishtweening;zoom,0.4)) (self)
		end;
	};
};
