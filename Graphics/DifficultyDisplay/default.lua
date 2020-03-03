local t = Def.ActorFrame{}
local baseZoom = 0.3
local spacing = 29;
local delay = 2

local baseX = -(spacing*5.5);
--Don't ever make this anything other than 0, it just messes up your theme
local baseY = 0;

local stepsArray;

local isMissionMode = (getenv("PlayMode") == "Missions")
local mmProgress;

local function SortCharts(a,b)
    local bST = StepsType:Compare(a:GetStepsType(),b:GetStepsType()) < 0
    if a:GetStepsType() == b:GetStepsType() then
        return a:GetMeter() < b:GetMeter()
    else
        return bST
    end;
end

function bToStr(b)
	if b == true then
		return "TRUE"
	end;
	return "FALSE"
end;

function bArrayToString(a)
	local s = "";
	for i = 1, #a do
		if type(a[i]) == "string" then
			s = s..a[i]..",";
		elseif type(a[i]) == "boolean" then
			s = s..bToStr(a[i])..",";
		else
			s = s.."ERROR,";
		end;
	end
	return s;
end

t[#t+1] = Def.ActorFrame{
	CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
	RefreshCommand=function(self)
			self:stoptweening();
			local song = GAMESTATE:GetCurrentSong();
			if song then
				--stepsArray = song:GetAllSteps();
				stepsArray = SongUtil.GetPlayableSteps(song);
				--Doesn't work with quest mode.
				--table.sort(stepsArray, SortCharts)
				
				if isMissionMode then
					assert(GAMESTATE:GetMasterPlayerNumber(),"No master player!")
					assert(getenv("cur_group"),"Current group var not set!")
					mmProgress = QUESTMODE[GAMESTATE:GetMasterPlayerNumber()][getenv("cur_group")][song:GetTranslitFullTitle()]
					--SCREENMAN:SystemMessage(bArrayToString(mmProgress))
				end;
			else
				stepsArray = nil;
			end;
	end;
	--[[Def.Quad{
		InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,60;diffuse,0,0,0,1;fadebottom,0.9);
	};]]
	
	LoadActor("bg diff_12")..{
		InitCommand=cmd(addy,baseY-35;zoomy,0.71;zoomx,0.665;);
	};
	
	--[[LoadFont("venacti/_venacti_outline 26px bold diffuse")..{
		InitCommand=cmd(Center;addx,-100);
		--InitCommand=cmd(draworder,999);
		CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
		RefreshCommand=function(self)
			if stepsArray then
				self:settext(#stepsArray);
			else
				self:settext("nil");
			end;
		end;
	};]]
}



for i=1,12 do

	--The original code was an absolute fucking nightmare
	t[#t+1] = Def.ActorFrame{
		LoadActor("_icon")..{
			InitCommand=cmd(zoom,baseZoom-0.05;x,baseX+spacing*(i-1);y,baseY;animate,false);
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Refresh");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Refresh");
			CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
			NextSongMessageCommand=cmd(playcommand,"Refresh");
			PreviousSongMessageCommand=cmd(playcommand,"Refresh");
			RefreshCommand=function(self)
				--[[
				The PIU default colors are
				Single = Orange
				Double = Green
				Single Performance = Purple
				Double Performance = Blue
				Co-Op / Routine = Yellow
				Halfdouble = Cyan (It's green in PIU, but it doesn't tell you if it's halfdouble)
				]]
				
				if stepsArray then
					local j;
					--TODO: Fix it so it can account for over 24 charts.
					if GetCurrentStepsIndex(PLAYER_1,stepsArray) > 12 or GetCurrentStepsIndex(PLAYER_2,stepsArray) > 12 then
						j = i+12;
					else
						j = i;
					end;
					if stepsArray[j] then

						local steps = stepsArray[j];
						self:diffusealpha(1);
						if steps:GetStepsType() == "StepsType_Pump_Single" then
							self:setstate(2);
						elseif steps:GetStepsType() == "StepsType_Pump_Double" then
							--Check for StepF2 Double Performace tag
							if string.find(steps:GetDescription(), "Double Performance") then
								self:setstate(0);
							elseif string.find(steps:GetDescription(), "Single Performance") then
								self:setstate(5);
							else
								self:setstate(6);
							end;
						elseif steps:GetStepsType() == "StepsType_Pump_Couple" then
							self:setstate(5);
						elseif steps:GetStepsType() == "StepsType_Pump_Halfdouble" then
							self:setstate(1);
						elseif steps:GetStepsType() == "StepsType_Pump_Routine" then
							self:setstate(4);
						else
							self:setstate(3);
						end;
					else
						self:diffusealpha(0);
					end;
				end
			end
		};

		LoadFont("_dotty matrix 40px")..{
			InitCommand=cmd(zoom,0.4;x,baseX-0.03+spacing*(i-1);y,baseY-0.33;);
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Refresh");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Refresh");
			CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
			NextSongMessageCommand=cmd(playcommand,"Refresh");
			PreviousSongMessageCommand=cmd(playcommand,"Refresh");
			RefreshCommand=function(self)
				self:stoptweening();
				if stepsArray then
					local j;
					--TODO: Fix it so it can account for over 24 charts.
					if GetCurrentStepsIndex(PLAYER_1,stepsArray) > 12 or GetCurrentStepsIndex(PLAYER_2,stepsArray) > 12 then
						j = i+12;
					else
						j = i;
					end;
					if stepsArray[j] then
						self:diffusealpha(1);
						local steps = stepsArray[j];
						if steps:GetMeter() == 99 then
							self:settext("??");
						elseif steps:GetMeter() == 100 then
							    self:settext("X");
						elseif steps:GetMeter() == 200 then
							    self:settext("XX");
						elseif steps:GetMeter() == 300 then
							    self:settext("XXX");
						elseif steps:GetMeter() == 2222 then
							    self:settext("X2");
						elseif steps:GetMeter() == 3333 then
							    self:settext("X3");
						elseif steps:GetMeter() == 4444 then
						    self:settext("X4");
					    else
							--THIS IS FOR SINGLE DIGIT VALUES
							self:settextf("%02d",steps:GetMeter());
						end
					else
						self:diffusealpha(0.3);
						self:settext("  ");
					end
				end
			end


		};
		Def.Sprite{
			Condition=isMissionMode;
			Texture="Lock";
			InitCommand=cmd(x,baseX+spacing*(i-1);y,baseY;zoom,.3);
			CurrentSongChangedMessageCommand=function(self)
				self:visible(mmProgress ~= nil and i>1 and mmProgress[i-1]==false and i <= #mmProgress)
			end;
		};
	};


end


for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("UnifiedCursor", pn)..{
		InitCommand=cmd(zoom,baseZoom-0.05;x,baseX;y,baseY;rotationx,180;rotationz,180;spin;playcommand,"Set";visible,GAMESTATE:IsSideJoined(pn));
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		NextSongMessageCommand=cmd(playcommand,"Set");
		PreviousSongMessageCommand=cmd(playcommand,"Set");

		--I know this looks moronic, but I don't think there's any other way to do it...
		SetCommand=function(self)
			if stepsArray then
				local index = GetCurrentStepsIndex(pn,stepsArray);
				if index > 12 then
					index = index%12;
				end;
				self:x(baseX+spacing*(index-1));
			end;
		end;
	}
end

return t
