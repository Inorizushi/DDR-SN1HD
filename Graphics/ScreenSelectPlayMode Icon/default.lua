local gc = Var("GameCommand");
local t = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_LEFT+195;y,SCREEN_BOTTOM-80);
	OnCommand=cmd(addx,-390;linear,0.133;addx,390);
	GainFocusCommand=function(s) s:visible(true):addx(-11):decelerate(0.1):addx(11) end,
	LoseFocusCommand=cmd(visible,false);
	OffCommand=cmd(linear,0.133;addx,-390);
	-- Information panel
	LoadActor(THEME:GetPathG("","_PlayMode/_infoback"))..{
		InitCommand=cmd(zoomx,-1);
	};
	LoadActor(THEME:GetPathG("","_PlayMode/MAX (doubleres).png"))..{
		InitCommand=cmd(halign,0;x,-170;y,40);
	};
	LoadActor(THEME:GetPathG("","_PlayMode/dots"))..{
		InitCommand=cmd(x,54;y,42);
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=function(s)
			s:skewx(-0.15):halign(0):xy(-180,-35):zoomx(1.75):zoomy(1.25)
			if gc:GetName() == "Starter" or gc:GetName() == "Nonstop" then
				s:diffuse(color("#3ef8fb"))
			elseif gc:GetName() == "Challenge" then
				s:diffuse(Color.Red)
			else
				s:diffuse(color("#fbfa3e"))
			end
			s:settext(THEME:GetString("ScreenSelectPlayMode",gc:GetName()))
		end
	};
	LoadFont("_russell square 16px")..{
		InitCommand=function(s)
			s:skewx(-0.15):halign(0):xy(-180,-5):maxwidth(400):zoom(0.8):strokecolor(Color.Black)
			s:settext(THEME:GetString("ScreenSelectPlayMode",gc:GetName().."Explanation1"))
		end
	};
	LoadFont("_russell square 16px")..{
		InitCommand=cmd(skewx,-0.15;halign,0;y,10;x,-180;zoom,0.8;maxwidth,435;strokecolor,color("#000000"));
		InitCommand=function(s)
			s:skewx(-0.15):halign(0):xy(-180,10):maxwidth(400):zoom(0.8):strokecolor(Color.Black)
			s:settext(THEME:GetString("ScreenSelectPlayMode",gc:GetName().."Explanation2"))
		end
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(halign,0;x,-98;skewx,-0.25;y,44;zoom,1.1;zoomx,2;diffuse,color("#613103"));
		OnCommand=function(self)
		local stages = PREFSMAN:GetPreference("SongsPerPlay")
			self:settext(stages);
		end;
	};
	LoadFont("_@apex commercial 20px")..{
		InitCommand=cmd(halign,0;x,-100;skewx,-0.25;y,42;zoom,1.1;zoomx,2;diffuse,color("#fd8304"));
		OnCommand=function(self)
		local stages = PREFSMAN:GetPreference("SongsPerPlay")
			self:settext(stages);
		end;
	};
};

return t;
