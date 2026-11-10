-- German (deDE): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Horse"] = "Schnelles Pferd",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "Geselle: {skill:762}",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} to Humans for 1,000g (10% less at Honored with {faction:72}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift horse costs 200g here."] = "{npc:4732} und das Pferdegehege von {npc:384} liegen bei {area:88} im Osten von {zone:1429}. Auf Stufe 60 lehrt {npc:4732} Menschen {skill:762} (Geselle) für 1.000g (10% weniger bei Wohlwollend mit {faction:72}); laut Blizzard gehört ein Reittier dazu. Andere Rassen lernen es beim Reitlehrer ihrer eigenen Rasse. Jedes schnelle Pferd kostet hier 200g.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, Reitlehrer",

	-- Step 2: Horse Riding for other races
	-- {spell:824} Horse Riding
	["{spell:824} for other races"] = "{spell:824} für andere Rassen",
	-- {spell:824} Horse Riding · {skill:762} Riding · {npc:4732} Randal Hunter · {faction:72} Stormwind
	["Any Alliance race can buy these horses, but riding one also takes {spell:824}, which only Humans get with {skill:762}. {npc:4732} teaches it to other races once they are Exalted with {faction:72} (the Stormwind Reputation guide shows the way). Until then, don't buy a horse for this character."] = "Jede Allianzrasse kann diese Pferde kaufen, aber um eines zu reiten, braucht man auch {spell:824}, das nur Menschen mit {skill:762} bekommen. {npc:4732} lehrt es andere Rassen, sobald sie bei {faction:72} Ehrfürchtig sind (der Ruf-Guide für Stormwind zeigt den Weg). Bis dahin kaufe für diesen Charakter kein Pferd.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} verkauft die anderen Farben (je 200g im Forever-Client). Kaufe, was du willst, oder nichts, wenn dir dein erhaltenes Reittier gefällt.",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}, 200g",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}, 200g",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "Die Pferdekoppel von {npc:4732} und {npc:384} liegt beim {area:88} im Osten von {zone:1429}. Ab Stufe 60 lehrt {npc:4732} Geselle: {skill:762} (1.000g laut Blizzards Designern); laut Blizzard bekommst du beim Erlernen ein Reittier. Der Forever-Client verkauft jedes schnelle Pferd für 200g ab Stufe 60.",
}
