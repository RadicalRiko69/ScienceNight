local t = Def.ActorFrame {};

--I know I could just load directly from graphics but panicked.
-- ~Gio

t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		Name="background",
		Texture="BG.png",
		InitCommand=function(self)
			self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):Center()
		end;
	};
	Def.Sprite {
		Name="logo",
		Texture="logo.png",
		InitCommand=function(self)
			self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):Center()
		end;
	};
};

t[#t+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};

return t;