local t = Def.ActorFrame{
	LoadFont("Common Normal")..{
		Text="StepMania build: "..ProductFamily().." "..ProductVersion();
		InitCommand=cmd(xy,SCREEN_CENTER_X,-20);
		--[[OnCommand=function(self)
			if ProductVersion() ~= "5.0.12" then
				self:settext(self:GetText().." (Incompatible version?)");
				self:diffuse(Color("Red"));
			else
				self:diffuse(Color("Green"));
			end;
		end;]]
	};

};

return t;
