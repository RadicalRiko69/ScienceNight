local scaw = 200		--banner scale width
local scah = 200		--banner scale height
--reflect effect controls
local ftop = 1	--fadetop
local ctop = 0.25	--croptop
local alph = 0.5	--diffusealpha

return Def.ActorFrame{

	Def.Sprite{		--Normal song banner item
		Name="SongBanner";
		InitCommand=cmd(scaletoclipped,scaw,scah);
		SetMessageCommand=function(self,param)
			local song = param.Song
			if song then
				local path = song:GetJacketPath();
				if path then
					self:Load(path)
					--self:LoadFromCached("Jacket",path);
				else
					path = song:GetBannerPath();
					if path then
						self:Load(path)
						--self:LoadFromCached("Banner",path);
					else
						self:Load(THEME:GetPathG("Common","fallback banner"))
					end;
				end;
			else
				self:Load(THEME:GetPathG("Common fallback","banner")) --// load the fallback banner if we panic
			end;
		end;
	};



};
--]]
