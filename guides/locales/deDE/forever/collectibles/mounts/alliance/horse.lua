-- German (deDE): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "Pferd",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Reiten lernen",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} to Humans for 100g (10% less at Honored with {faction:72}), and it comes with a horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4732} und das Pferdegehege von {npc:384} liegen bei {area:88} im Osten von {zone:1429}. Auf Stufe 40 lehrt {npc:4732} Menschen {skill:762} für 100g (10% weniger bei Wohlwollend mit {faction:72}), und ein Pferd gehört dazu. Andere Rassen lernen {skill:762}, mit ihrem eigenen ersten Reittier, beim Reitlehrer ihrer eigenen Rasse.",
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
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} verkauft die anderen Farben (je 20g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das Reittier gefällt, das du bekommen hast.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20g",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20g",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20g",

	-- Step 4: Black Stallion in Menethil Harbor
	-- {npc:5404} Black Stallion · {area:150} Menethil Harbor
	["{npc:5404} in {area:150}"] = "{npc:5404} in {area:150}",
	-- {npc:5404} Black Stallion · {npc:384} Katie Hunter · {npc:1460} Unger Statforth · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["The {npc:5404} is not at {npc:384}: {npc:1460} sells it, at the stables of {area:150} in the {zone:1437} (20g in the Forever client). Skip this unless you want that colour."] = "Das {npc:5404} gibt es nicht bei {npc:384}: {npc:1460} verkauft es in den Ställen von {area:150} in den {zone:1437} (20g im Forever-Client). Überspringe das, es sei denn, du willst genau diese Farbe.",
	-- {item:2411} Black Stallion Bridle · {npc:1460} Unger Statforth
	["{item:2411}, 20g, {npc:1460}"] = "{item:2411}, 20g, {npc:1460}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411} ist im Client vorhanden, aber für Forever ist kein Händler bestätigt, der es verkauft.",
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "Der Pferdepferch von {npc:4732} und {npc:384} ist in {area:88} im Osten von {zone:1429}. Mit 40 lehrt dich {npc:4732} {skill:762} (100g laut den Designern von Blizzard), und wenn du es lernst, bekommst du ein Reittier. Im Forever-Client dürfen alle Völker der Allianz diese reiten.",
}
