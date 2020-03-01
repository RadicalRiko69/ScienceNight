local NumSongsToLevelUp = 4
local MaxLevel=100

local function calcPlayerLevel(numSongsPlayed)
	if numSongsPlayed > MaxLevel*NumSongsToLevelUp then
		return MaxLevel;
	else
		return numSongsPlayed/NumSongsToLevelUp
	end;
end

local function rectGen(width, height, lineSize, lineColor, bgColor)
    return Def.ActorFrame{
    
        --Background transparency
        Def.Quad{
            InitCommand=cmd(setsize,width, height;diffuse,bgColor);
            
        };
        --Bottom line
        Def.Quad{
            InitCommand=cmd(setsize,width + lineSize, lineSize;addy,height/2;diffuse,lineColor--[[horizalign,0;vertalign,2]]);
            
        };
        --Top line
        Def.Quad{
            InitCommand=cmd(setsize,width + lineSize, lineSize;addy,-height/2;diffuse,lineColor--[[horizalign,2;vertalign,0]]); --2 = right aligned
            
        };
        --Left line
        Def.Quad{
            InitCommand=cmd(setsize,lineSize, height + lineSize;addx,-width/2;diffuse,lineColor--[[vertalign,0;horizalign,2]]); --2 = right aligned
            
        };
        --Right line
        Def.Quad{
            InitCommand=cmd(setsize,lineSize, height + lineSize;addx,width/2;diffuse,lineColor--[[vertalign,2;horizalign,0]]); --2 = bottom aligned
            
        };
        

    };
end;

return Def.ActorFrame{
	InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_BOTTOM+25);
	OnCommand=cmd(decelerate,0.5;addy,-55;diffusealpha,1);
	OffCommand=cmd(decelerate,0.5;addy,55;diffusealpha,0);
	Def.Sprite{
		Texture="altBanner";
	};
	
	Def.Quad{
		InitCommand=cmd(diffuse,color("#000000BB");horizalign,left;vertalign,bottom;setsize,200,5;xy,-250/2+50,25);
	};
	Def.Quad{
		--setsize(200*percent)
		InitCommand=cmd(diffuse,color("#FFFFFF");horizalign,left;vertalign,bottom;setsize,111,5;xy,-250/2+50,25);
	};

	Def.Sprite{
		Texture=THEME:GetPathG("","Avatars/"..ThemePrefs.Get("ProfilePictures"));
		InitCommand=cmd(zoomto,50,50;x,-250/2+.5;horizalign,left);
	};
	rectGen(250,50,1.5,color("#000000FF"),color("#00000000"));
	    --The vertical alignment on this font is beyond stupid
    LoadFont("_alternategotno2 40px")..{
        InitCommand=cmd(zoom,.5;horizalign,left;vertalign,top;xy,-70,-25;skewx,-.2);
		--Text=THEME:GetString("Common","Username");
		--[[
		Return string before '.' character:
		:match("[^.]+")
		ex. local str = "Nine The Phantom.jpg"
		str:match("[^.]+") -> Nine The Phantom
		]]
		Text=ThemePrefs.Get("ProfilePictures"):match("[^.]+")
	};
	LoadFont("extras/_bebas neue 40px")..{
		Text="Lv.";
		InitCommand=cmd(zoom,.3;horizalign,left;vertalign,bottom;xy,-70,15);
	};
	LoadFont("extras/_zona pro extralight 60px")..{
		Text="999";
		InitCommand=cmd(zoom,.4;horizalign,left;vertalign,bottom;xy,-58,15;);
	};
	
	LoadFont("extras/_bebas neue 40px")..{
		Text="??%";
		InitCommand=cmd(zoom,.3;horizalign,right;vertalign,bottom;xy,250/2-2,17);
	};

};
