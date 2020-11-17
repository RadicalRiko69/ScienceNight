local t =			Def.ActorFrame {};


--TODO: These should probably be metrics
local sepx =		100					--horizontal spacing from labels
local sepy =		35					--vertical spacing factor starting from 1st item
local iniy =		SCREEN_TOP+70		--vertical starting point for evaluation data
local initzoom = 	2.5
local datazoom = 	1
local intw =		0.1					--"in tween" animation
local fx =			1.8-intw			--sound effect sleep time
local inc =			0.15				--increment time between items

for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
	--scoring
	local stagemaxscore = 100000000*GAMESTATE:GetNumStagesForCurrentSongAndStepsOrCourse()

	-- players stage data
	local css1 =		STATSMAN:GetCurStageStats():GetPlayerStageStats(player);

	local p1holdstr	=	css1:GetTapNoteScores("TapNoteScore_CheckpointHit")		--AMAZING (HOLD STREAM) -> Amazin'
	local p1w1 =		css1:GetTapNoteScores("TapNoteScore_W1")				--AMAZING -> Amazin'
	local p1nomine =	css1:GetTapNoteScores("TapNoteScore_AvoidMine")			--Avoided Mines
	local p1w2 =		css1:GetTapNoteScores("TapNoteScore_W2")				--RAVIN' -> same in S2
	local p1w3 =		css1:GetTapNoteScores("TapNoteScore_W3")				--COOL -> Stylin'
	local p1w4 =		css1:GetTapNoteScores("TapNoteScore_W4")				--OKAY -> Trippin'
	local p1misses =		css1:GetTapNoteScores("TapNoteScore_Miss")				--MISS - Missin'
	local p1holdmiss =	css1:GetTapNoteScores("TapNoteScore_CheckpointMiss")	--MISS (HOLD STREAM)
	local p1minest =	css1:GetTapNoteScores("TapNoteScore_HitMine")			--MISS (MINE HIT)
	local maxcp1 =		css1:MaxCombo()											--Max Combo for this stage

	local p1score =		css1:GetScore()			--score :v

	--round(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()*100)
	local p1accuracy = round(css1:GetPercentDancePoints()*100);


	local p1ravins =	p1holdstr+p1w1
	local p1kcal = tonumber(string.format("%.1f",css1:GetCaloriesBurned()))

	if THEME:GetMetric("Gameplay","AvoidMineIncrementsCombo") then
		p1ravins =		p1holdstr+p1w1+p1nomine
	end;

	if THEME:GetMetric("Gameplay","MineHitIncrementsMissCombo") then
		p1misses =		p1misses+p1holdmiss+p1minest
	end;

	local p1none =		css1:GetTapNoteScores("TapNoteScore_None")				--No step (DDR1st Hard mode)
	--

	--Sorry
	function gs(s)
		return THEME:GetString("JudgmentLine",s)
	end

	local datalabelslist = {gs("W1"),gs("W2"),gs("W3"),gs("W4"),gs("Miss"),gs("MaxCombo"),"TOTAL SCORE","PRECISION","CALORIE (KCAL)"};
	local p1datalist =	{p1ravins,string.format("%03d",p1w2),string.format("%03d",p1w3),string.format("%03d",p1w4),string.format("%03d",p1misses),maxcp1,p1score,p1accuracy.."%",p1kcal};

	local noFantastics = (PREFSMAN:GetPreference("AllowW1") == "AllowW1_Never") --Used in two places
	if noFantastics then
		datalabelslist = {gs("W2"),gs("W3"),gs("W4"),gs("Miss"),gs("MaxCombo"),"PRECISION","TOTAL SCORE","CALORIE (KCAL)"};
		p1datalist =	{p1ravins+p1w2,string.format("%03d",p1w3),string.format("%03d",p1w4),string.format("%03d",p1misses),maxcp1,p1accuracy.."%",p1score,p1kcal};
	end;
		



	local xOffset = (player == PLAYER_1) and -460/2 or 460/2
	local align = player == PLAYER_1 and left or right;
	--See above.
	for i = 1,#datalabelslist,1 do

		local initsleeps = {}
		for n=0,#datalabelslist do
		  initsleeps[n] = fx+(inc*n)
		end
		
		t[#t+1] = LoadFont("_alternategotno2 40px")..{		--JUDGEMENT LABELS
			InitCommand=cmd(xy,_screen.cx,iniy+(i*sepy);horizalign,center;zoom,initzoom;settext,datalabelslist[i];diffusealpha,0);
			OnCommand=cmd(sleep,initsleeps[i];accelerate,intw;diffusealpha,1;zoom,datazoom-0.25;addy,1);
			OffCommand=cmd(decelerate,0.2;zoomx,0);
		};
		t[#t+1] = LoadFont("_alternategotno2 40px")..{		--stats p1
			InitCommand=cmd(xy,_screen.cx+xOffset,iniy+(i*sepy);zoom,initzoom;horizalign,align;settext,p1datalist[i];diffusealpha,0);
			OnCommand=cmd(sleep,initsleeps[i];accelerate,intw;diffusealpha,1;zoom,datazoom-0.15;);
			OffCommand=cmd(decelerate,0.2;zoomx,0);
		};
		
	end;


	--P1 RANK CODE
	if css1:IsDisqualified()==false then

		local initzoomp1 = 1.2;
		--The graphics aren't centered properly and using SCREEN_WIDTH isn't really the best either
		--Should use the aspect ratio to calculate, but whatever..
		local finalzoomp1 = .5;
		local p1initx = (player == PLAYER_1) and SCREEN_RIGHT-130 or 130;
		local p1inity = SCREEN_CENTER_Y-50;

		--TODO: investigate why this exists later
		--[[if GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType() == "StepsType_Pump_Routine" and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then
			initzoomp1 = 0
			finalzoomp1 = 0
		end]]
		local gradep1 = getGradeFromStats(player);
		--local gradep1 = "S3"
		--assert(false,gradep1);


		t[#t+1] = LoadActor(THEME:GetPathG("","GradeDisplayEval/Grade-"..gradep1))..{
			InitCommand=cmd(x,p1initx;y,p1inity;draworder,100;diffusealpha,0;zoom,initzoomp1;sleep,3;linear,.2;diffusealpha,1;zoom,initzoomp1-0.25;linear,.3;zoom,finalzoomp1);
			OffCommand=cmd(decelerate,0.5;zoom,0;diffusealpha,0);
		};

		t[#t+1] = LoadActor("flash")..{
			InitCommand=cmd(blend,Blend.Add;x,p1initx;y,p1inity;draworder,100;diffusealpha,0;zoom,initzoomp1;sleep,3;diffusealpha,1;linear,.5;diffusealpha,0;zoom,finalzoomp1;);
			OffCommand=cmd(decelerate,0.5;zoom,0;diffusealpha,0);
		};

		t[#t+1] = LoadActor(THEME:GetPathG("","GradeDisplayEval/Grade-"..gradep1))..{
			InitCommand=cmd(horizalign,center;blend,Blend.Add;x,p1initx;y,p1inity;draworder,101;diffusealpha,0;zoom,initzoomp1;sleep,3;linear,.2;diffusealpha,1;zoom,initzoomp1-0.25;linear,.5;diffusealpha,0;zoom,finalzoomp1;);
			OffCommand=cmd(decelerate,0.5;zoom,0;diffusealpha,0);
		};


		--[[t[#t+1] = LoadActor(THEME:GetPathS("","DanceGrade/male/RANK_"..gradep1))..{
			OnCommand=cmd(sleep,2.75;queuecommand,'Play');
			PlayCommand=cmd(stop;play);
			OffCommand=cmd(stop;)
		};--]]
	end;
end;

return t
