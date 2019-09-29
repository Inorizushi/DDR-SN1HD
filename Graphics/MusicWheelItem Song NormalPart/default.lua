local group_colors = {
	["1-Licenses"]= "#FFFFFF",
	["2-KONAMI Originals"]= "#00CC00",
	["3-Requests"]= "#FFFF00",
	["4-Revivials"]= "#33CCFF",
	["5-NOVAmix"]= "#FF00FF",
	["6a-ENCORE EXTRA STAGE"]= "#FF9933",
	["6b-EXTRA STAGE"]= "#FF0000",
	["7-DLC"]= "#FF9933",
};

local t = Def.ActorFrame {
	LoadActor("../_section outer");
--new song
	LoadActor("../ScreenSelectMusic NewSong")..{
		InitCommand=cmd(x,-138;y,-25;finishtweening;draworder,1;visible,SCREENMAN:GetTopScreen() ~= "ScreenNetRoom");
		OnCommand=cmd(diffusealpha,0;sleep,1;diffusealpha,1);
		SetCommand=function(self,param)
			if param.Song then
				if PROFILEMAN:IsSongNew(param.Song) then
					self:visible(true);
				else
					self:visible(false);
				end
			else
				self:visible(false);
			end
		end;
	};
};
t[#t+1] = Def.ActorFrame{
	--Title/Subtitle
	Def.BitmapText{
		Font="_russell square 16px";
		InitCommand=cmd(halign,0;x,-140;maxwidth,300/0.8;wrapwidthpixels,2^24);
		SetMessageCommand=function(self, param)
			local Song = param.Song;
			local Course = param.Course;
			if Song then
				self:y(-6.4):zoom(0.64)
				self:settext(Song:GetDisplayFullTitle());
				self:diffuse(SongAttributes.GetMenuColor(Song))
			elseif Course then
				self:settext(Course:GetDisplayFullTitle());
			end
		end;
	};
	--Artist
	Def.BitmapText{
		Font="_russell square 16px";
		InitCommand=cmd(halign,0;xy,-140,7;maxwidth,300/0.6;zoom,0.48;wrapwidthpixels,2^24);
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
		ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
		SetMessageCommand=function(self, param)
			local Song = param.Song;
			local Course = param.Course;
			if Song then
				self:visible(true);
				self:settext(Song:GetDisplayArtist());
				self:diffuse(SongAttributes.GetMenuColor(Song))
			end
		end;
	};
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	table.insert(t, WheelLight(pn, true))
end

return t;
