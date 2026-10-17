-- German (deDE): the guide forever/collectibles/mounts/horde/raptor (forever/collectibles/mounts/horde/raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Raptor"] = "Raptor",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Lerne reiten",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Die Raptoren von {npc:7953} und {npc:7952} sind in {area:367} an der Küste von {zone:1411}. Ab Stufe 40 lehrt {npc:7953} {skill:762} (100g laut Blizzards Designern), und beim Erlernen bekommst du ein Reittier. Im Forever-Client dürfen alle Hordevölker diese reiten.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} verkauft die anderen Farben (je 20g im Forever-Client). Kaufe, was du willst, oder nichts, wenn dir dein erhaltenes Reittier gefällt.",
	-- {item:8588} Whistle of the Emerald Raptor
	["{item:8588}, 20g"] = "{item:8588}, 20g",
	-- {item:8591} Whistle of the Turquoise Raptor
	["{item:8591}, 20g"] = "{item:8591}, 20g",
	-- {item:8592} Whistle of the Violet Raptor
	["{item:8592}, 20g"] = "{item:8592}, 20g",
}
