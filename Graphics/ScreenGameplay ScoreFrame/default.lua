local endless = (GAMESTATE:Env()).EndlessState ~= nil

local endlessScoreDigits = 30

local function BaseEndlessText(value)
	return string.rep('0', endlessScoreDigits-#value)..value
end

local fullEndlessLength = #(commify(BaseEndlessText('')))

local function EndlessDarkLength(comValue)
	return fullEndlessLength-#comValue
end

local oldScoreString = nil
local function EndlessScoreDisplayUpdate(self, _)
	local eState = (GAMESTATE:Env()).EndlessState
	if not eState then return end
	local curScoreString = eState.scoring.getScoreString()
	if oldScoreString~=curScoreString then
		oldScoreString = curScoreString
		local sText = self:GetChild("ScoreText")
		local commifiedBrightPart = commify(curScoreString)
		local newText = commify(BaseEndlessText(curScoreString))
		sText:settext(newText)
		sText:ClearAttributes()
		local darkLen = EndlessDarkLength(commifiedBrightPart)
		--this color is calculated by dividing the bright text color by 2
		sText:AddAttribute(0, {Length=darkLen, Diffuse=color "#7D8010"})
	end
end

local t = Def.ActorFrame{
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
--P1 Score Frame
t[#t+1]=Def.ActorFrame{
	InitCommand=cmd(zoomx,pn=="PlayerNumber_P2" and -1 or 1;x,pn=="PlayerNumber_P2" and SCREEN_RIGHT or SCREEN_LEFT);
	LoadActor("score")..{
		InitCommand=cmd(halign,0;y,SCREEN_BOTTOM-34);
	};
	Def.ActorFrame{
		InitCommand=function(s)
			if GAMESTATE:PlayerIsUsingModifier(pn, "Reverse") then
				s:y(SCREEN_TOP+46)
			else
				s:y(SCREEN_BOTTOM-56)
			end
		end,
		LoadActor("DiffFrame")..{
			InitCommand=function(s)
				if GAMESTATE:PlayerIsUsingModifier(pn, "Reverse") then s:zoomy(-1) end
				s:halign(0)
			end,
		};
		Def.BitmapText{
			Font="_russell square 16px";
			InitCommand=function(s)
				if GAMESTATE:PlayerIsUsingModifier(pn, "Reverse") then s:y(2) else s:y(0) end
			end,
			SetCommand=function(s)
				local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
				s:x(61):settext(THEME:GetString("LongCustomDifficulty",ToEnumShortString(diff))):diffuse(CustomDifficultyToColor(diff)):zoomx(pn=="PlayerNumber_P2" and -0.67 or 0.67):zoomy(0.5)
			end,
			CurrentSongChangedMessageCommand=function(s) s:playcommand("Set") end,

		}
	};
};

if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
	t[#t+1]=Def.ActorFrame{
		LoadFont("_futura std medium 20px")..{
			InitCommand=function(self)
				self:settext("Level:")
				:halign(pn=="PlayerNumber_P2" and 1 or 0):x(pn=="PlayerNumber_P2" and SCREEN_RIGHT-80 or SCREEN_LEFT+40):y(2)
				:diffuse(color("#F9FF20"))
			end;
		};
	};
end
	--[[if endless then
		t[#t+1]=Def.ActorFrame{
			InitCommand=cmd(addy,24;SetUpdateFunction,EndlessScoreDisplayUpdate);
			Def.Quad{
				InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,542,24;diffuse,color("#666666"));
			};
			Def.Quad{
				InitCommand=cmd(halign,0;x,SCREEN_LEFT;setsize,540,20;diffuse,color("0,0,0,1"));
			};
			Def.BitmapText{
				Font="ScoreDisplayNormal Text",
				Name="ScoreText",
				Text='',
				InitCommand=function(s) s:x(SCREEN_LEFT+530):halign(1):diffuse(color "#F9FF20") end
			};
		};
	end]]--
end;

return t;
