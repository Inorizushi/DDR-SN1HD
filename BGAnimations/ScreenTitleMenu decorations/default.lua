local t = LoadFallbackB()

t[#t+1] = StandardDecorationFromFile("Version","Version")

--if Endless mode didn't get a chance to clean up after itself properly,
--ComboContinuesBetweenSongs will still be set. IMO it's not commonly used enough
--that just forcing it off will be a problem. Maybe it could be a theme pref.
if PREFSMAN:GetPreference("ComboContinuesBetweenSongs") then
	print("ComboContinuesBetweenSongs was disabled.")
	PREFSMAN:SetPreference("ComboContinuesBetweenSongs", false)
end

local counter = 0;
local t = Def.ActorFrame{};

if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
--XXX: it's easier to have it up here
local path

local heardBefore = false

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:zoom(1);
	end;
	LoadActor(THEME:GetPathS("","Title_In"))..{
		OnCommand=cmd(play);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0"));
		OnCommand=cmd(diffusealpha,0;linear,0.4;diffusealpha,0.4);
	};
	LoadActor("left_panel")..{
		InitCommand=cmd(x,SCREEN_LEFT+47;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,-94;decelerate,0.2;addx,94);
	};
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_LEFT-92;y,SCREEN_CENTER_Y-80);
		OnCommand=cmd();
		TitleSelectionMessageCommand=function(self, params)
			path = "/Themes/"..THEME:GetCurThemeName().."/Graphics/_TitleImages/"..string.lower(params.Choice)..".png"
			self:finishtweening():x(SCREEN_LEFT+182)
			if heardBefore then
				self:accelerate(0.05);
			else heardBefore = true end
			self:addx(-274):queuecommand("TitleSelectionPart2")
		end;
		TitleSelectionPart2Command=function(self)
			if FILEMAN:DoesFileExist(path) then
				self:Load(path)
			end;
			self:sleep(0.2)
			self:accelerate(0.2);
			self:addx(274);
		end;
		OffCommand=cmd(accelerate,0.4;addx,-274);
	};
	LoadActor("cover")..{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_CENTER_Y-80);
		OnCommand=cmd(addx,-34;decelerate,0.2;addx,34);
	};
	LoadActor("home_dialog")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-80);
		OnCommand=cmd(zoomy,0;sleep,0.1;accelerate,0.3;zoomy,1);
	};
	Def.BitmapText{
		Font="_russell square 16px";
		Text="";
		InitCommand=function(self) self:hibernate(0.4):skewx(-0.15):Center(X):y(SCREEN_BOTTOM-95):zoom(0.75):strokecolor(color("0,0,0,1")):maxwidth(513):wrapwidthpixels(513):valign(0):vertspacing(-2) end;
		TitleSelectionMessageCommand=function(self, params) self:settext(THEME:GetString("ScreenTitleMenu","Description"..params.Choice)) end;
		OnCommand=cmd(cropbottom,1;sleep,0.1;accelerate,0.3;cropbottom,0);
	};
};
end


t[#t+1] = Def.ActorFrame {
	Def.BitmapText{
	Font="Common normal",
	Text=themeInfo["Name"] .. " version " .. themeInfo["Version"] .. " by " .. themeInfo["Author"] .. (SN3Debug and " (debug mode)" or "") ,
	InitCommand=cmd(halign,0;valign,0;x,SCREEN_LEFT+40;y,SCREEN_TOP+5;shadowlength,1; zoom, 0.6;diffusealpha,0.5)
	};
}

if PROFILEMAN:GetNumLocalProfiles() <1 then
	t[#t+1] = Def.ActorFrame{
		LoadActor("../profile")..{
			InitCommand=cmd(Center);
			OnCommand=cmd(bob;effectmagnitude,0,5,0);
			OffCommand=cmd(sleep,0.2;linear,0.3;zoomy,0;diffusealpha,0);
		};
	};
end

return t
