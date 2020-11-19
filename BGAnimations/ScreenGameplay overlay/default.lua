local t = Def.ActorFrame{}

local newBPS;
local oldBPS;

-- DECORATIONS ////////////////////////

--TODO: These need to be put in the "pn in ivalues" statement eventually but it would break doubles

-- Left Hex Corner Decoration
--[[t[#t+1] = LoadActor("decoration_corner") .. {
	InitCommand=cmd(visible,(GAMESTATE:IsHumanPlayer(PLAYER_1) or ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerTwoSides"));
	OnCommand=cmd(horizalign,left;x,SCREEN_LEFT;vertalign,top;y,SCREEN_TOP;zoomy,0.4;zoomx,0.6;diffusealpha,0.3;blend,Blend.Add); 
};

-- Right Hex Corner Decoration
t[#t+1] = LoadActor("decoration_corner") .. {
	InitCommand=cmd(visible,(GAMESTATE:IsHumanPlayer(PLAYER_2) or ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerTwoSides"));
	OnCommand=cmd(horizalign,left;x,SCREEN_RIGHT;vertalign,top;y,SCREEN_TOP;zoomy,0.4;;zoomx,-0.6;diffusealpha,0.3;blend,Blend.Add); 
};]]


-- WAVY LINE (thanks AJ) ////////////////////////





--Double
--customtexturerect,0,0,[PixelsToCoverWidth]/[ImageWidth],[PixelsToCoverHeight]/[ImageHeight]
--I said that I was gonna write it down. thx midi


-- METERS ////////////////////////
local style = ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType())


if style == "OnePlayerOneSide" and PREFSMAN:GetPreference("Center1Player") == true then
	t[#t+1] = LoadActor("centered_lifebar",GAMESTATE:GetMasterPlayerNumber())..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,34);
	};
elseif style == "TwoPlayersTwoSides" or style == "OnePlayerOneSide" then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local width = SCREEN_WIDTH/2-275
		local xPos = THEME:GetMetric("ScreenGameplay","Player"..pname(pn).."OnePlayerOneSideX")
		if pn == PLAYER_1 then
			xPos = xPos;
		else
			xPos = xPos;
		end;
		
		--The good lifebar
		t[#t+1] = LoadActor("centered_lifebar", pn,width)..{
			InitCommand=cmd(y,30);
			OnCommand=function(self)
				self:x(xPos);
				if pn == PLAYER_2 then
					self:rotationy(180);
				end;
				--[[if pn == PLAYER_1 then
					self:x(SCREEN_WIDTH/4);
					self:horizalign(left);
				else
					self:x(SCREEN_WIDTH*.75);
					self:horizalign(right);
				end;]]
			end;
		};
		t[#t+1] = Def.Sprite{
			Texture="border";
			InitCommand=cmd(zoomx,0.54;zoomy,0.55;addy,30);
		    OnCommand=function(self)
		    	if pn == PLAYER_1 then
		    		self:horizalign(right);
		    		self:x(xPos-width/2-25);
	    		else
					self:x(xPos+width/2+24);
	    			self:horizalign(left);
	    		end;
		    end;
		};
		t[#t+1] = Def.Sprite{
			Texture=getenv("profile_icon_"..pname(pn));
		    InitCommand=cmd(zoomto,39,38;y,30+19;vertalign,bottom;);
		    OnCommand=function(self)
		    	if pn == PLAYER_1 then
		    		self:horizalign(right);
		    		self:x(xPos-width/2-32);
	    		else
	    			self:x(xPos+width/2+32);
	    			self:horizalign(left);
	    		end;
		    end;
		};
		t[#t+1] = LoadFont("_charter bt 40px") .. {
			InitCommand=cmd(maxwidth,580;y,8;zoom,0.45;shadowlength,1);
			OnCommand=function(self)
				if pn == PLAYER_1 then
					self:horizalign(center);
					self:x(xPos-width/2+102);
				else
					self:horizalign(center);
					self:x(xPos+width/2-102);
				end;
			end;
		
			
			BeginCommand=function(self)
				local profile = PROFILEMAN:GetProfile(pn);
				local name = profile:GetDisplayName();
				
				if GAMESTATE:IsHumanPlayer(pn) == true then
					if name=="" and SCREENMAN:GetTopScreen():GetName() ~= "ScreenDemonstration" then
						self:settext("Player");
					else
						self:settext( name );
					end
				end	
				
			end;
		};
	end;
else

	local pn = GAMESTATE:GetMasterPlayerNumber()
	local width = SCREEN_WIDTH/2+50
	local xPos = SCREEN_CENTER_X+25
	-- Doubles... And legacy code.
	t[#t+1] = LoadActor("centered_lifebar", pn,width)..{
		InitCommand=cmd(xy,xPos-25,30);

	}
	t[#t+1] = Def.Sprite{
		Texture="border";
		InitCommand=cmd(zoomx,0.54;zoomy,0.55;addy,30);
		OnCommand=function(self)
			if pn == PLAYER_1 then
				self:horizalign(right);
				self:x(xPos-width/2-50);
			else
				self:x(xPos+width/2-1);
				self:horizalign(left);
			end;
		end;
	};
	t[#t+1] = Def.Sprite{
		Texture=getenv("profile_icon_"..pname(pn));
	    InitCommand=cmd(zoomto,39,38;y,30+19;vertalign,bottom;);
	    OnCommand=function(self)
	    	if pn == PLAYER_1 then
	    		self:horizalign(right);
	    		self:x(xPos-width/2-57);
    		else
    			self:x(xPos+width/2+7);
    			self:horizalign(left);
    		end;
	    end;
	};
	t[#t+1] = LoadFont("_charter bt 40px") .. {
		InitCommand=cmd(maxwidth,1200;y,8;zoom,0.45;shadowlength,1);
		OnCommand=function(self)
			if pn == PLAYER_1 then
				self:horizalign(center);
				self:x(SCREEN_CENTER_X);
			else
				self:horizalign(center);
				self:x(SCREEN_CENTER_X);
			end;
		end;
	
		
		BeginCommand=function(self)
			local profile = PROFILEMAN:GetProfile(pn);
			local name = profile:GetDisplayName();
			
			if GAMESTATE:IsHumanPlayer(pn) == true then
				if name=="" and SCREENMAN:GetTopScreen():GetName() ~= "ScreenDemonstration" then
					self:settext("Player");
				else
					self:settext( name );
				end
			end	
			
		end;
	};
end

--[[for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	--NAME
	t[#t+1] = LoadFont("venacti/_venacti_outline 26px bold diffuse") .. {
		InitCommand=cmd(maxwidth,300;y,SCREEN_TOP+14;zoom,0.45;shadowlength,1;uppercase,true);
		OnCommand=function(self)
			if pn == PLAYER_1 then
				self:horizalign(left);
				self:x(SCREEN_LEFT+30);
			else
				self:horizalign(right);
				self:x(SCREEN_RIGHT-30);
			end;
		end;
	
		
		BeginCommand=function(self)
			local profile = PROFILEMAN:GetProfile(pn);
			local name = profile:GetDisplayName();
			
			if GAMESTATE:IsHumanPlayer(pn) == true then
				if name=="" and SCREENMAN:GetTopScreen():GetName() ~= "ScreenDemonstration" then
					self:settext("Player");
				else
					self:settext( name );
				end
			end	
			
		end;
	};
end;]]

-- Progress bar
--[[t[#t+1] = Def.ActorFrame{

	InitCommand=cmd(y,SCREEN_BOTTOM-20);
	OnCommand=cmd(visible,SCREENMAN:GetTopScreen():GetName() ~= "ScreenDemonstration");
	LoadActor("progressmeter")..{
		InitCommand=cmd(diffusealpha,.8;zoomx,0;horizalign,left;x,SCREEN_CENTER_X-607/2);
		OnCommand=cmd(sleep,math.abs(GAMESTATE:GetCurrentSong():GetFirstBeat());linear,GAMESTATE:GetCurrentSong():GetStepsSeconds();zoomx,1);
	};

	LoadActor("progress-bar")..{
		InitCommand=cmd(x,SCREEN_CENTER_X);
	};

};]]

--The current stage
--[[t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(y,34;zoom,0.8);
	OnCommand=function(self)
		if style == "OnePlayerOneSide" and PREFSMAN:GetPreference("Center1Player") == true then
			self:x(SCREEN_CENTER_X-210);
		else
			self:x(SCREEN_CENTER_X);
		end;
	end;
	
	LoadActor(THEME:GetPathG("ScreenGameplay", "stage icon"))..{
	};
	
	LoadFont("combo/_handelgothic bt 70px") .. {
		InitCommand=cmd(addy,5;zoom,.5);
		--Text="Hello World";
		OnCommand=function(self)
			self:settextf("%02d",GAMESTATE:GetCurrentStageIndex()+1);
		end;
	};
}]]

			
--[[ MISC ///////////////////////////////////


	gonna save this for later


	HealthStateChangedMessageCommand=function(self,params)
		 local failure = (params.HealthState);
		 if params.PlayerNumber == PLAYER_1 then
			if failure=="HealthState_Dead" then  
				self:visible(false)
			end;
		 end;
    end;
	
	
	
	
	
	
	]]
			

return t
