-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/raptor (forever/collectibles/mounts/horde/raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Raptor"] = "Raptor",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprenda a montar",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Os raptores de {npc:7953} e {npc:7952} ficam em {area:367}, no litoral de {zone:1411}. No nível 40, {npc:7953} ensina {skill:762} (100g segundo os designers da Blizzard), e aprendê-la dá uma montaria. O cliente Forever permite que todas as raças da Horda montem estes.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} vende as outras cores (20g cada no cliente Forever). Compre as que quiser, ou nenhuma se gostar da montaria que ganhou.",
	-- {item:8588} Whistle of the Emerald Raptor
	["{item:8588}, 20g"] = "{item:8588}, 20g",
	-- {item:8591} Whistle of the Turquoise Raptor
	["{item:8591}, 20g"] = "{item:8591}, 20g",
	-- {item:8592} Whistle of the Violet Raptor
	["{item:8592}, 20g"] = "{item:8592}, 20g",
}
