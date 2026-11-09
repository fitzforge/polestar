-- German (deDE): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Saber"] = "Schneller Säbler",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 60 {npc:4753} teaches Journeyman {skill:762} to Night Elves for 1,000g (10% less at Honored with {faction:69}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift saber costs 200g here."] = "{npc:4753} und die Nachtsäbler von {npc:4730} stehen auf dem Reitgelände der {area:1658} bei {faction:69}. Auf Stufe 60 lehrt {npc:4753} Nachtelfen {skill:762} (Geselle) für 1.000g (10% weniger bei Wohlwollend mit {faction:69}); laut Blizzard gehört ein Reittier dazu. Andere Rassen lernen es beim Reitlehrer ihrer eigenen Rasse. Jeder schnelle Nachtsäbler kostet hier 200g.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, Reitlehrer",

	-- Step 2: Tiger Riding for other races
	-- {spell:828} Tiger Riding
	["{spell:828} for other races"] = "{spell:828} für andere Rassen",
	-- {spell:828} Tiger Riding · {skill:762} Riding · {npc:4753} Jartsam · {faction:69} Darnassus
	["Any Alliance race can buy these sabers, but riding one also takes {spell:828}, which only Night Elves get with {skill:762}. {npc:4753} teaches it to other races once they are Exalted with {faction:69} (the Darnassus Reputation guide shows the way). Until then, don't buy a saber for this character."] = "Jede Allianzrasse kann diese Nachtsäbler kaufen, aber um einen zu reiten, braucht man auch {spell:828}, das nur Nachtelfen mit {skill:762} bekommen. {npc:4753} lehrt es andere Rassen, sobald sie bei {faction:69} Ehrfürchtig sind (der Ruf-Guide für Darnassus zeigt den Weg). Bis dahin kaufe für diesen Charakter keinen Nachtsäbler.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} verkauft die anderen Farben (je 200g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das Reittier gefällt, das du bekommen hast.",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}, 200g",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}, 200g",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "Die Säbler von {npc:4753} und {npc:4730} sind auf dem Reitplatz von {area:1658} in {zone:1457}. Mit 60 lehrt dich {npc:4753} {skill:762} (Geselle) (1,000g laut den Designern von Blizzard); laut Blizzard bekommst du beim Erlernen des Reitens ein Reittier. Der Forever-Client verkauft jeden schnellen Säbler für 200g ab Stufe 60.",
}
