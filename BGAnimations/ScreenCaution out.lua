return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,0;linear,0.1;diffusealpha,1);
	};
	Def.Actor{
		OffCommand=function(s)
			SOUND:PlayOnce(THEME:GetPathS("","_Menu Begin"))
			s:sleep(0.2)
		end,
		
	};
}
