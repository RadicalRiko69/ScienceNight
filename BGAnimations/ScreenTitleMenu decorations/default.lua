return Def.ActorFrame {
	InitCommand=function(self)
		--Reset the vars, player options, etc here.
		ResetGame();
	end;
    LoadActor("science_night running")..{
        InitCommand=cmd(zoom,0.4;x,SCREEN_LEFT-500;y,SCREEN_CENTER_Y);
        OnCommand=cmd(sleep,2;decelerate,1.5;x,SCREEN_CENTER_X-220);
    };
    LoadActor("logo")..{
        InitCommand=cmd(x,235;y,135;zoom,0.5);
        OnCommand=cmd(sleep,2;decelerate,0.5;addy,-150;addx,-140;zoom,0.25);
    };
    LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(horizalign,left;x,SCREEN_LEFT+20;y,SCREEN_BOTTOM-40);
		OnCommand=function(self)
			self:settext("Project by Team Sushi\nProgramming by RhythmLunatic\nIllustration by Giovanni Shawn");
			(cmd(finishtweening;zoom,0.4)) (self)
		end;
	};
};
