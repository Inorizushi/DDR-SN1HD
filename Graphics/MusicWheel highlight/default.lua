local t = Def.ActorFrame {
	LoadActor("Backing");
	LoadActor("light")..{
		InitCommand=cmd(x,-156;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.75");effectclock,'beatnooffset');
	};
	Def.Sprite {
	Texture="WheelEffect 3x4",
		InitCommand=function(self)
			self:draworder(100):x(-88)
			self:effectclock('beatnooffset'):SetAllStateDelays(0.1):diffusealpha(0.5)
		end,
	};
};

local PColor = {
    P1 = "#00dcff",
    P2 = "#ff00cf"
};

local xPosPlayer = {
	P1 = -158,
	P2 = -153
};

--lights
if SCREENMAN:GetTopScreen() ~= "ScreenNetRoom" then
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		table.insert(t, WheelLight(pn))
	end;
end;

--score underlay
if GAMESTATE:GetCoinMode() == 'CoinMode_Home' and SCREENMAN:GetTopScreen() ~= "ScreenNetRoom" then
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.ActorFrame {
	LoadActor("frame (doubleres).png")..{
	OnCommand=cmd(queuecommand,"Set");
	BeginCommand=function(self,param)
		if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
			self:croptop(0.5)
		elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
			self:cropbottom(0.5)
		end
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand= function(self)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;

	if SongOrCourse and StepsOrTrail then
		local st = StepsOrTrail:GetStepsType();
		local diff = StepsOrTrail:GetDifficulty();
		local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

		if PROFILEMAN:IsPersistentProfile(pn) then
			--player
			profile = PROFILEMAN:GetProfile(pn);
		else
			-- machine profile
			profile = PROFILEMAN:GetMachineProfile();
		end;

		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		if scores[1] then
			topscore = scores[1]:GetScore()
		else
			topscore = 0;
		end;
		assert(topscore)
		if topscore ~= 0 then
			self:diffusealpha(1)
		else
			self:diffusealpha(0)
		end
	else
		self:diffusealpha(0)
	end;
	end;
	};
};
end;
end

--Scores
local yPosPlayer = {
	P1 = -25,
	P2 = 25
};

--Player Scores
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.RollingNumbers{
	Font="ScreenSelectMusic score",
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	InitCommand=function(self)
		local short = ToEnumShortString(pn)
		self:x(40):y(yPosPlayer[short])
		:diffusealpha(0)
		:Load("RollingNumbersMusic")
	end;
	OnCommand=cmd(queuecommand,"Set");
	SetCommand= function(self)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;

	if SongOrCourse and StepsOrTrail then
		local st = StepsOrTrail:GetStepsType();
		local diff = StepsOrTrail:GetDifficulty();
		local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

		if PROFILEMAN:IsPersistentProfile(pn) then
			--player
			profile = PROFILEMAN:GetProfile(pn);
		else
			-- machine profile
			profile = PROFILEMAN:GetMachineProfile();
		end;

		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		if scores[1] then
			topscore = scores[1]:GetScore()
		else
			topscore = 0;
		end;
		assert(topscore)
		if topscore ~= 0 then
			self:diffusealpha(1)
			:targetnumber(topscore)
		else
			self:diffusealpha(0)
			:targetnumber(0)
		end
	else
		self:diffusealpha(0)
	end;
	end;
};
end;

--Grades
local yPosPlayerGrade = {
	P1 = -22,
	P2 = 22
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.Quad{
	InitCommand=function(self)
		local short = ToEnumShortString(pn)
		self:x(125):y(yPosPlayerGrade[short])
		:diffusealpha(0):zoom(0.25)
	end;
	OnCommand=cmd(zoom,0;sleep,1;bouncebegin,0.15;zoom,0.25);
	OffCommand=cmd(bouncebegin,0.15;zoom,0);
	BeginCommand=cmd(playcommand,"Set");
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand=function(self)
		local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;

		local profile, scorelist;
		local text = "";
		if SongOrCourse and StepsOrTrail then
			local st = StepsOrTrail:GetStepsType();
			local diff = StepsOrTrail:GetDifficulty();
			local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;

			scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(scorelist);
				local scores = scorelist:GetHighScores();
				assert(scores);
				local topscore=0;
				if scores[1] then
					topscore = scores[1]:GetScore();
				end;
				assert(topscore);
				local topgrade;
				if scores[1] then
					topgrade = scores[1]:GetGrade();
					assert(topgrade);
					if scores[1]:GetScore()>1  then
						if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then
							self:Load(THEME:GetPathG("GradeDisplayEval","Tier01"));
							self:diffusealpha(1);
						else
							self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString(topgrade)));
							self:diffusealpha(1);
						end;
					else
						self:diffusealpha(0);
					end;
				else
					self:diffusealpha(0);
				end;
		else
			self:diffusealpha(0);
		end;
	end;
};
end;

return t;
