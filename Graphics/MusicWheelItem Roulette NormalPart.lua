return Def.ActorFrame {
	LoadActor("_section inner")..{
		SetMessageCommand=function(self)
			self:diffuse(Color.Blue);
		end;
	};
	LoadActor("_section outer");
};