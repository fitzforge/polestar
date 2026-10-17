-- Korean (koKR): the guide forever/collectibles/mounts/horde/swift-raptor (forever/collectibles/mounts/horde/swift-raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Raptor"] = "날쌘 랩터",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift raptor for 200g at level 60."] = "{npc:7953}와(과) {npc:7952}의 랩터는 {zone:1411} 해안의 {area:367}에 있습니다. 60레벨에 {npc:7953}이(가) 수습 {skill:762}을(를) 가르쳐 줍니다(블리자드 개발진에 따르면 1,000골드). 블리자드에 따르면 탈것 타기를 배우면 탈것을 받습니다. Forever 클라이언트에서는 날쌘 랩터를 60레벨에 각 200골드에 팝니다.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, 탈것 상급자",

	-- Step 2: Pick a colour
	["Pick a colour"] = "색상 고르기",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952}이(가) 다른 색상을 팝니다(Forever 클라이언트에서 각 200골드). 원하는 것을 사거나, 받은 탈것이 마음에 들면 사지 않아도 됩니다.",
	-- {item:18788} Swift Blue Raptor
	["{item:18788}, 200g"] = "{item:18788}, 200골드",
	-- {item:18789} Swift Olive Raptor
	["{item:18789}, 200g"] = "{item:18789}, 200골드",
	-- {item:18790} Swift Orange Raptor
	["{item:18790}, 200g"] = "{item:18790}, 200골드",
	-- {item:46102} Whistle of the Venomhide Ravasaur
	["{item:46102} (level 60) is in the Forever client, but its source is not known yet."] = "{item:46102}(60레벨)은(는) Forever 클라이언트에 있지만 아직 획득처가 알려지지 않았습니다.",
}
