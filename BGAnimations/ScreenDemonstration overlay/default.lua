local t = Def.ActorFrame{
	LoadActor("demup (doubleres)")..{
		InitCommand=cmd(x,SCREEN_LEFT;;halign,0;valign,0);
	};
	LoadActor("demdown (doubleres)")..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM;halign,1;valign,1);
	};
	LoadActor("demupglow")..{
		InitCommand=cmd(x,SCREEN_LEFT+124;y,SCREEN_TOP+18;blend,Blend.Add;);
		OnCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.5");effectperiod,1.056);
	};
	LoadActor("demdownglow")..{
		InitCommand=cmd(x,SCREEN_RIGHT-128;y,SCREEN_BOTTOM-18;blend,Blend.Add;);
		OnCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.5");effectperiod,1.056);
	};
};

return t;