function ResetGame()
	ActiveModifiers = {
		P1 = table.shallowcopy(PlayerDefaults),
		P2 = table.shallowcopy(PlayerDefaults),
		P3 = table.shallowcopy(PlayerDefaults),
		P4 = table.shallowcopy(PlayerDefaults),
		--EDIT = table.shallowcopy(PlayerDefaults),
		--Save values here if editing profile
	}
	
	QUESTMODE:Reset();
	PREFSMAN:SetPreference("AllowW1",'AllowW1_Never');
	--PREFSMAN:SetPreference("MusicWheelUsesSections",'Never');
	PREFSMAN:SetPreference("TimingWindowSecondsAttack",0.135000);
	PREFSMAN:SetPreference("TimingWindowSecondsHold",0.350);
	PREFSMAN:SetPreference("TimingWindowSecondsMine",0.070);
	PREFSMAN:SetPreference("TimingWindowSecondsRoll",100000.350);
	PREFSMAN:SetPreference("TimingWindowSecondsW1",0.000);
	PREFSMAN:SetPreference("TimingWindowSecondsW2",0.085);
	PREFSMAN:SetPreference("TimingWindowSecondsW3",0.100);
	PREFSMAN:SetPreference("TimingWindowSecondsW4",0.145);
	PREFSMAN:SetPreference("TimingWindowSecondsW5",0.000);
end
