-- German (deDE): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "Großer Kodo",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} to Tauren for 1,000g (10% less at Honored with {faction:81}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each great kodo costs 200g here."] = "{npc:3690} und die Kodos von {npc:3685} stehen in {area:222}, {zone:1412}. Auf Stufe 60 lehrt {npc:3690} Tauren {skill:762} (Geselle) für 1.000g (10% weniger bei Wohlwollend mit {faction:81}); laut Blizzard gehört ein Reittier dazu. Andere Rassen lernen es beim Reitlehrer ihrer eigenen Rasse. Jeder Große Kodo kostet hier 200g.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, Reitlehrer",

	-- Step 2: Kodo Riding for other races
	-- {spell:18995} Kodo Riding
	["{spell:18995} for other races"] = "{spell:18995} für andere Rassen",
	-- {spell:18995} Kodo Riding · {skill:762} Riding · {npc:3690} Kar Stormsinger · {faction:81} Thunder Bluff
	["Any Horde race can buy these kodos, but riding one also takes {spell:18995}, which only Tauren get with {skill:762}. {npc:3690} teaches it to other races once they are Exalted with {faction:81} (the Thunder Bluff Reputation guide shows the way). Until then, don't buy a kodo for this character."] = "Jede Hordenrasse kann diese Kodos kaufen, aber um einen zu reiten, braucht man auch {spell:18995}, das nur Tauren mit {skill:762} bekommen. {npc:3690} lehrt es andere Rassen, sobald sie bei {faction:81} Ehrfürchtig sind (der Ruf-Guide für Thunder Bluff zeigt den Weg). Bis dahin kaufe für diesen Charakter keinen Kodo.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} verkauft die anderen Farben (je 200g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das erhaltene Reittier gefällt.",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}, 200g",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}, 200g",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "{npc:3690} und die Kodos von {npc:3685} sind in {area:222}, {zone:1412}. Auf Stufe 60 lehrt {npc:3690} {skill:762} (Geselle) (1.000g laut Blizzards Designern); laut Blizzard gibt das Erlernen ein Reittier. Der Forever-Client verkauft jeden großen Kodo für 200g auf Stufe 60.",
}
