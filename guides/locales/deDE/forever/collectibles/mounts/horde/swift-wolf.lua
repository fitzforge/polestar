-- German (deDE): the guide forever/collectibles/mounts/horde/swift-wolf (forever/collectibles/mounts/horde/swift-wolf.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Wolf"] = "Schneller Wolf",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {faction:76} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {faction:76}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} to Orcs for 1,000g (10% less at Honored with {faction:76}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift wolf costs 200g here."] = "{npc:4752} und der Zwinger von {npc:3362} stehen in der {object:172958} von {faction:76}. Auf Stufe 60 lehrt {npc:4752} Orcs {skill:762} (Geselle) für 1.000g (10% weniger bei Wohlwollend mit {faction:76}); laut Blizzard gehört ein Reittier dazu. Andere Rassen lernen es beim Reitlehrer ihrer eigenen Rasse. Jeder schnelle Wolf kostet hier 200g.",
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
	["{npc:3362} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362} verkauft die anderen Farben (je 200g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das erhaltene Reittier gefällt.",
	-- {item:18796} Horn of the Swift Brown Wolf
	["{item:18796}, 200g"] = "{item:18796}, 200g",
	-- {item:18797} Horn of the Swift Timber Wolf
	["{item:18797}, 200g"] = "{item:18797}, 200g",
	-- {item:18798} Horn of the Swift Gray Wolf
	["{item:18798}, 200g"] = "{item:18798}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift wolf for 200g at level 60."] = "{npc:4752} und der Zwinger von {npc:3362} sind im {object:172958} von {zone:1454}. Auf Stufe 60 lehrt {npc:4752} {skill:762} (Geselle) (1.000g laut Blizzards Designern); laut Blizzard gibt das Erlernen ein Reittier. Der Forever-Client verkauft jeden schnellen Wolf für 200g auf Stufe 60.",
}
