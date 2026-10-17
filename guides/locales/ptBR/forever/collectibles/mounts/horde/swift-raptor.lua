-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/swift-raptor (forever/collectibles/mounts/horde/swift-raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Raptor"] = "Raptor Veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift raptor for 200g at level 60."] = "{npc:7953} e os raptores de {npc:7952} estão em {area:367}, na costa de {zone:1411}. No nível 60, {npc:7953} ensina {skill:762} (Profissional) (1,000g segundo os criadores da Blizzard); a Blizzard diz que aprender montaria concede uma montaria. O cliente Forever vende cada raptor veloz por 200g no nível 60.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} vende as outras cores (200g cada no cliente Forever). Compre as que quiser, ou nenhuma se a montaria que recebeu é a que você gosta.",
	-- {item:18788} Swift Blue Raptor
	["{item:18788}, 200g"] = "{item:18788}, 200g",
	-- {item:18789} Swift Olive Raptor
	["{item:18789}, 200g"] = "{item:18789}, 200g",
	-- {item:18790} Swift Orange Raptor
	["{item:18790}, 200g"] = "{item:18790}, 200g",
	-- {item:46102} Whistle of the Venomhide Ravasaur
	["{item:46102} (level 60) is in the Forever client, but its source is not known yet."] = "O {item:46102} (nível 60) está no cliente Forever, mas a origem dele ainda não é conhecida.",
}
