local t = Def.ActorFrame{};


--[[
A list of songs that should have red names
Pointer comparison is significantly faster than
string comparison so use SONGMAN:FindSong() instead
of keeping strings in the array.
Yes, songs are pointers.
]]
local redNames = {
	SONGMAN:FindSong("ScienceNight/ESCAPE"),
	SONGMAN:FindSong("19-DELTA NEX REBIRTH/3y3s")
}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


t[#t+1] = Def.ActorFrame{

	-- CURRENT SONG NAME
		LoadFont("_charter bt 40px")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP-50;zoom,.75;maxwidth,700;diffusealpha,0);
			OnCommand=cmd(sleep,0.25;decelerate,0.5;addy,75);
			OffCommand=cmd(decelerate,0.15;zoom,0);
			CurrentSongChangedMessageCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					self:settext(song:GetDisplayFullTitle());
					self:diffusealpha(1);
					if has_value(redNames,song) then
						self:diffusecolor(color("#b90000"));
					else
						self:diffusecolor(Color("White"));
					end;
				else
					self:diffusealpha(0);
				end;
			end;

		};
		-- CURRENT SONG ARTIST
		LoadFont("_charter bt 40px")..{	
			InitCommand=cmd(zoom,.5;maxwidth,900;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-100);
			OnCommand=cmd(sleep,0.25;decelerate,0.5;addy,150);
			OffCommand=cmd(decelerate,0.15;zoom,0);
			CurrentSongChangedMessageCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					self:settext(song:GetDisplayArtist());
					self:diffusealpha(1);
					if has_value(redNames,song) then
						self:diffusecolor(color("#b90000"));
					else
						self:diffusecolor(Color("White"));
					end;
				else
					self:diffusealpha(0);
				end;
			end;


		};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10);
	
	LoadActor(THEME:GetPathG("","DifficultyDisplay"))..{
		InitCommand=cmd(zoom,0;y,0);
		OnCommand=cmd(sleep,0.25;decelerate,0.5;zoom,1.25);
		SongChosenMessageCommand=cmd(decelerate,0.05;addy,10;zoom,1.8);
		SongUnchosenMessageCommand=cmd(decelerate,0.05;addy,-10;zoom,1.25);
		OffCommand=cmd(decelerate,0.15;zoom,0);
	};
		--BPM DISPLAY
	LoadFont("_charter bt 40px")..{
		Text="BPM:";
		InitCommand=cmd(x,-200;y,40;zoom,0.5;diffusealpha,0;sleep,0.7;linear,1;diffusealpha,1;horizalign,left);
		SongChosenMessageCommand=cmd(finishtweening;decelerate,0.05;addy,20);
		SongUnchosenMessageCommand=cmd(decelerate,0.05;addy,-20);
		OffCommand=cmd(visible,false);
	};
	
	--add 80 to the x value
	LoadFont("_charter bt 40px")..{
		InitCommand=cmd(horizalign,left;x,-140;y,40;zoom,0.5;maxwidth,200;diffusealpha,0;sleep,0.7;linear,1;diffusealpha,1;);
		SongChosenMessageCommand=cmd(finishtweening;decelerate,0.05;addy,20);
		SongUnchosenMessageCommand=cmd(decelerate,0.05;addy,-20);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)

			local song = GAMESTATE:GetCurrentSong();
			if song then
				local speedvalue;
				if song:IsDisplayBpmRandom() then
					speedvalue = "???";
				else
					local rawbpm = GAMESTATE:GetCurrentSong():GetDisplayBpms();
					local lobpm = math.ceil(rawbpm[1]);
					local hibpm = math.ceil(rawbpm[2]);
					if lobpm == hibpm then
						speedvalue = hibpm
					else
						speedvalue = lobpm.."-"..hibpm
					end;
				end;
				self:settext(speedvalue);
			else
				self:settext("N/A");
			end;
		end;
	};


	--LENGTH DISPLAY
	LoadFont("_charter bt 40px")..{
		Text="LENGTH:";
		InitCommand=cmd(x,40;y,40;zoom,0.5;diffusealpha,0;sleep,0.7;linear,1;diffusealpha,1;horizalign,left);
		SongChosenMessageCommand=cmd(finishtweening;decelerate,0.05;addy,20);
		SongUnchosenMessageCommand=cmd(decelerate,0.05;addy,-20);
		OffCommand=cmd(visible,false);
	};

	LoadFont("_charter bt 40px")..{
		InitCommand=cmd(horizalign,left;x,140;y,40;zoom,0.5;maxwidth,120;diffusealpha,0;sleep,0.7;linear,1;diffusealpha,1);
		SongChosenMessageCommand=cmd(finishtweening;decelerate,0.05;addy,20);
		SongUnchosenMessageCommand=cmd(decelerate,0.05;addy,-20);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
		if GAMESTATE:GetCurrentSong() then
			local length = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
			self:settext(SecondsToMMSS(length));
		else
			self:settext("N/A");
		end;
	end;
	};

		--GROUP DISPLAY
	--[[LoadFont("_charter bt 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-240;y,SCREEN_CENTER_Y-100;zoom,0.7;diffusealpha,0);
		OnCommand=cmd(sleep,1;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("GROUP:");
			(cmd(finishtweening;zoom,0.7)) (self)
		end;
	};]]

	LoadFont("_charter bt 40px")..{
		InitCommand=cmd(horizalign,center;xy,0,-40;zoom,0.5;maxwidth,800;diffusealpha,0;sleep,0.7;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				self:settext("GROUP: "..GAMESTATE:GetCurrentSong():GetGroupName());
			else
				self:settext("GROUP: N/A");
			end;
		end;
	};
}

local helpText = {
	"Select any song you desire!",
	"Use &LEFT; and &RIGHT; to select a song.",
	"Use &UP; and &DOWN; to change group.",
	"Press &START; to pick a song.",
	"Press &LEFT; and &RIGHT; three times to access the command window."
}
local curHelpText = 1;

local helpDifficultyText = {
	"Use &LEFT; and &RIGHT; to select a difficulty.",
	"Press &UP; or &DOWN; to cancel.",
	"Press &START; to confirm your choice.",
}
local curhelpDifficultyText = 1;

t[#t+1] = Def.ActorFrame{



	LoadActor("arrows")..{
		InitCommand=cmd(zoom,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(sleep,0.25;decelerate,0.5;zoom,1);
		OffCommand=cmd(decelerate,0.5;zoom,0);
	};

	Def.Sprite{
		Texture="pill",
		InitCommand=cmd(zoom,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+160);
		OnCommand=cmd(sleep,0.45;decelerate,0.5;zoom,1);
		OffCommand=cmd(decelerate,0.5;zoom,0);
	};

	--help text
	LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+160;zoom,.6;diffusealpha,0;valign,.65;maxwidth,1050);
		OnCommand=cmd(sleep,1.2;linear,1;diffusealpha,1;queuecommand,"Set");
		OffCommand=cmd(visible,false);
		Text="Select any song you desire!";
		
		SetCommand=function(self)
            if curHelpText+1 > #helpText then
               	curHelpText = 1
            else
                curHelpText = curHelpText+1;
            end;
            self:settext(helpText[curHelpText]);
            self:linear(0.2);
            self:diffusealpha(1);
            self:sleep(2);
            self:linear(0.2);
            self:diffusealpha(0);
            self:queuecommand("Set");
		end;
		
		Set2Command=function(self)
            if curhelpDifficultyText+1 > #helpDifficultyText then
               	curhelpDifficultyText = 1
            else
                curhelpDifficultyText = curhelpDifficultyText+1;
            end;
            self:settext(helpDifficultyText[curhelpDifficultyText]);
            self:linear(0.2);
            self:diffusealpha(1);
            self:sleep(2);
            self:linear(0.2);
            self:diffusealpha(0);
            self:queuecommand("Set2");
		end;
		
		SongChosenMessageCommand=function(self)
			self:stoptweening();
			self:settext(helpDifficultyText[curhelpDifficultyText]):queuecommand("Set2");
			--(cmd(linear,0.25;zoom,1)) (self)
		end;
		SongUnchosenMessageCommand=function(self)
			self:settext(helpText[curHelpText]):queuecommand("Set");
		end;
	};

	--[[help text
	LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+160;zoom,.6;diffusealpha,0;valign,.65;maxwidth,1050);
		OnCommand=cmd(sleep,1.2;linear,1;diffusealpha,0);
		OffCommand=cmd(visible,false);
		Text="Select difficulty!";
		
		SetCommand=function(self)
            if curhelpDifficultyText+1 > #helpDifficultyText then
               	curhelpDifficultyText = 1
            else
                curhelpDifficultyText = curhelpDifficultyText+1;
            end;
            self:settext(helpDifficultyText[curhelpDifficultyText]);
            self:linear(0.2);
            self:diffusealpha(1);
            self:sleep(2);
            self:linear(0.2);
            self:diffusealpha(0);
            self:queuecommand("Set");
        end;
		SongChosenMessageCommand=cmd(playcommand,"Set");
		SongUnchosenMessageCommand=function(self)
			self:diffusealpha(0);
		end;
	};--]]
};


--Arrow text
t[#t+1] = Def.ActorFrame{
	--[[LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(x,SCREEN_LEFT+150;y,SCREEN_TOP+15;skewx,-0.2;zoom,1;diffusealpha,0);
		OnCommand=cmd(sleep,1;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("Previous Group");
			(cmd(finishtweening;zoom,1)) (self)
		end;
	};	
	LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(x,SCREEN_LEFT+150;y,SCREEN_TOP+42;zoom,0.7;diffusealpha,0);
		OnCommand=cmd(sleep,1;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("(PRESS TWICE)");
			(cmd(finishtweening;zoom,0.7)) (self)
		end;
	};
	LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(x,SCREEN_RIGHT-150;y,SCREEN_TOP+15;skewx,-0.2;zoom,1;diffusealpha,0);
		OnCommand=cmd(sleep,1;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("Next Group");
			(cmd(finishtweening;zoom,1)) (self)
		end;
	};
	LoadFont("_alternategotno2 40px")..{
		InitCommand=cmd(x,SCREEN_RIGHT-150;y,SCREEN_TOP+42;zoom,0.7;diffusealpha,0);
		OnCommand=cmd(sleep,1;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
		CurrentSongChangedMessageCommand=function(self)
			self:settext("(PRESS TWICE)");
			(cmd(finishtweening;zoom,0.7)) (self)
		end;
	};]]
	LoadFont("_alternategotno2 40px")..{
		Text="Select Group";
		InitCommand=cmd(x,SCREEN_LEFT+60;y,5;horizalign,left;vertalign,top;skewx,-0.2;zoom,.6;diffusealpha,0);
		OnCommand=cmd(sleep,0.5;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
	};
	LoadFont("_alternategotno2 40px")..{
		Text="Select Group";
		InitCommand=cmd(x,SCREEN_RIGHT-60;y,5;horizalign,right;vertalign,top;skewx,-0.2;zoom,.6;diffusealpha,0);
		OnCommand=cmd(sleep,0.5;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
	};
	LoadFont("_alternategotno2 40px")..{
		Text="Previous Song";
		InitCommand=cmd(x,SCREEN_LEFT+60;y,SCREEN_BOTTOM-10;horizalign,left;vertalign,bottom;skewx,-0.2;zoom,.6;diffusealpha,0);
		OnCommand=cmd(sleep,0.5;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
	};
	LoadFont("_alternategotno2 40px")..{
		Text="Next Song";
		InitCommand=cmd(x,SCREEN_RIGHT-60;y,SCREEN_BOTTOM-10;horizalign,right;vertalign,bottom;skewx,-0.2;zoom,.6;diffusealpha,0);
		OnCommand=cmd(sleep,0.5;linear,1;diffusealpha,1);
		OffCommand=cmd(visible,false);
	};
};

--Sound effects
t[#t+1] = Def.ActorFrame{
	LoadActor("sfx/explosion")..{
		OffCommand=cmd(queuecommand,"PlaySound");
		PlaySoundCommand=cmd(play);
	};
	LoadActor("sfx/accept")..{
		SongChosenMessageCommand=cmd(queuecommand,"PlaySound");
		PlaySoundCommand=cmd(play);
		OffCommand=function(self)
			SOUND:StopMusic()
		end;
	};
	LoadActor("sfx/cancel")..{
		SongUnchosenMessageCommand=cmd(queuecommand,"PlaySound");
		PlaySoundCommand=cmd(play);
	};
};


return t
