local function inputs(event)
	
	local pn= event.PlayerNumber
	local button = event.button

	-- If it's a release, ignore it.
	if event.type == "InputEventType_Release" then return end
	
	if button == "Center" or button == "Start" then
		SCREENMAN:GetTopScreen():SetNextScreenName("ScreenPlayerOptions");
		SCREENMAN:SystemMessage("Entering Options...");
	end;
end;

return Def.ActorFrame{
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(inputs);
	end;

	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black");Center);
		
		--sleeping the ActorFrame locks input. So instead we put it inside this quad.
		OnCommand=function(self)
			self:sleep(.1):queuecommand("NextScreen");
		end;
		NextScreenCommand=function(self)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
		end;
	};
};
