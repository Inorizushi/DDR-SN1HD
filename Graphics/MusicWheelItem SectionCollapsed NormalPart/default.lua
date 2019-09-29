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

local group_names = {
	["1-Licenses"]= "Licenses",
	["2-KONAMI Originals"]= "KONAMI Originals",
	["3-Requests"]= "Requests",
	["4-Revivials"]= "Revivals",
	["5-NOVAmix"]= "NOVAmix",
	["6a-ENCORE EXTRA STAGE"]= "ENCORE EXTRA STAGE",
	["6b-EXTRA STAGE"]= "EXTRA STAGE",
	["7-DLC"]= "DLC",
};

local t = Def.ActorFrame {
	LoadActor("../_section inner")..{
		SetMessageCommand=function(self, param)
			local group = param.Text;
			local so = GAMESTATE:GetSortOrder()
			if so == "SortOrder_Group" then
				self:diffuse(SongAttributes.GetGroupColor(group));
			else
				self:diffuse(color(color_group[group]));
			end
		end;
	};
	LoadActor("../_section outer");
};

t[#t+1] = Def.ActorFrame{
	--GroupName
	Def.BitmapText{
		Font="_@apex commercial 20px";
		InitCommand=cmd(halign,0;x,-140;maxwidth,256;zoomx,1.3;skewx,-0.1);
		SetMessageCommand=function(self, param)
			local group = param.Text;
			local so = GAMESTATE:GetSortOrder()
			if so == "SortOrder_Group" then
				self:diffuse(SongAttributes.GetGroupColor(group));
			else
				self:diffuse(Color.Yellow);
			end;
			if group_name[group] ~= nil then
				self:settext(group_rename[group])
			else
				self:settext(group);
			end
		end;
	};
};

return t;
