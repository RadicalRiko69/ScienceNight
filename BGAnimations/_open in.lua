return Def.Quad {
	InitCommand=cmd(FullScreen; diffuse, Color.Black),
	StartTransitioningCommand=cmd(diffusealpha,0; linear,0.4;diffusealpha,0; sleep,1.25)
}
