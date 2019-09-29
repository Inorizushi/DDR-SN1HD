return Def.ActorFrame {
	LoadActor("_section inner")..{
		SetMessageCommand=function(self)
			self:diffuse(Color.Red);
		end;
	};
	LoadActor("_section outer");
};