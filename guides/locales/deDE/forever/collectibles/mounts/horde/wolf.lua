-- German (deDE): the guide forever/collectibles/mounts/horde/wolf (forever/collectibles/mounts/horde/wolf.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wolf"] = "Wolf",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Reiten lernen",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {faction:76} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {faction:76}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} to Orcs for 100g (10% less at Honored with {faction:76}), and it comes with a wolf. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4752} und der Zwinger von {npc:3362} stehen in der {object:172958} von {faction:76}. Auf Stufe 40 lehrt {npc:4752} Orcs {skill:762} für 100g (10% weniger bei Wohlwollend mit {faction:76}), und ein Wolf gehört dazu. Andere Rassen lernen {skill:762}, mit ihrem eigenen ersten Reittier, beim Reitlehrer ihrer eigenen Rasse.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, Reitlehrer",

	-- Step 2: Wolf Riding for other races
	-- {spell:825} Wolf Riding
	["{spell:825} for other races"] = "{spell:825} für andere Rassen",
	-- {spell:825} Wolf Riding · {skill:762} Riding · {npc:4752} Kildar · {faction:76} Orgrimmar
	["Any Horde race can buy these wolves, but riding one also takes {spell:825}, which only Orcs get with {skill:762}. {npc:4752} teaches it to other races once they are Exalted with {faction:76} (the Orgrimmar Reputation guide shows the way). Until then, don't buy a wolf for this character."] = "Jede Hordenrasse kann diese Wölfe kaufen, aber um einen zu reiten, braucht man auch {spell:825}, das nur Orcs mit {skill:762} bekommen. {npc:4752} lehrt es andere Rassen, sobald sie bei {faction:76} Ehrfürchtig sind (der Ruf-Guide für Orgrimmar zeigt den Weg). Bis dahin kaufe für diesen Charakter keinen Wolf.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362} verkauft die anderen Farben (je 20g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das Reittier gefällt, das du bekommen hast.",
	-- {item:1132} Horn of the Timber Wolf
	["{item:1132}, 20g"] = "{item:1132}, 20g",
	-- {item:5665} Horn of the Dire Wolf
	["{item:5665}, 20g"] = "{item:5665}, 20g",
	-- {item:5668} Horn of the Brown Wolf
	["{item:5668}, 20g"] = "{item:5668}, 20g",
	-- {item:1041} Horn of the Black Wolf
	["{item:1041} is in the client (20g) but our data has no vendor selling it."] = "{item:1041} ist im Client vorhanden (20g), aber unsere Daten kennen keinen Händler, der es verkauft.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Der Zwinger von {npc:4752} und {npc:3362} ist in {object:172958} in {zone:1454}. Mit 40 lehrt dich {npc:4752} {skill:762} (100g laut den Designern von Blizzard), und wenn du es lernst, bekommst du ein Reittier. Im Forever-Client dürfen alle Völker der Horde diese reiten.",
}
