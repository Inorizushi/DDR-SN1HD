return Def.ActorFrame{
    LoadActor(THEME:GetPathB("","ScreenLogo background/ddrsn_konami"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/serial"))..{
		InitCommand=cmd(halign,0;valign,0;x,SCREEN_LEFT-10;y,SCREEN_TOP+5);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/press_start1a"))..{
		InitCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
				self:visible(true)
				self:CenterX():y(SCREEN_CENTER_Y+121)
			else
				self:visible(false)
			end;
		end;
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/press_start1b"))..{
		InitCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
				self:visible(true)
				self:CenterX():y(SCREEN_CENTER_Y+121)
			else
				self:visible(false)
			end;
		end;
		OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,1;effectperiod,1.056);
	};
}