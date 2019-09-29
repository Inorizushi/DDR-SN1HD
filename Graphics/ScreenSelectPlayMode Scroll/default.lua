local t = Def.ActorFrame{};
local gc = Var("GameCommand");

t[#t+1] = Def.ActorFrame{
	GainFocusCommand=cmd(linear,0.1;addx,-10);
	LoseFocusCommand=cmd(finishtweening;linear,0.1;addx,10);
	OffCommand=cmd(sleep,0.116;linear,0.066;zoomy,0;diffusealpha,0);
	-- Information panel
	LoadActor(THEME:GetPathG("","_PlayMode/bar.png"));
	LoadActor(THEME:GetPathG("","_PlayMode/highlight.png"))..{
		GainFocusCommand=cmd(diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,0.4");effectcolor2,color("1,1,1,0.3");effectperiod,0.5);
		LoseFocusCommand=cmd(stopeffect;diffusealpha,0);
	};
	LoadFont("_russell square 16px")..{
        InitCommand=function(s)
            s:halign(0):xy(-70,2):zoom(0.75)
            s:settext(THEME:GetString("ScreenSelectPlayMode",gc:GetName()))
        end,
		GainFocusCommand=cmd(diffuse,color("#43ff02"));
		LoseFocusCommand=cmd(diffuse,color("#787878"));
	};
};


return t;