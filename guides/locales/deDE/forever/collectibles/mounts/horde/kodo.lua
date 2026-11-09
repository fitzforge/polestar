-- German (deDE): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "Kodo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Reiten lernen",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} to Tauren for 100g (10% less at Honored with {faction:81}), and it comes with a kodo. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:3690} und die Kodos von {npc:3685} stehen in {area:222}, {zone:1412}. Auf Stufe 40 lehrt {npc:3690} Tauren {skill:762} für 100g (10% weniger bei Wohlwollend mit {faction:81}), und ein Kodo gehört dazu. Andere Rassen lernen {skill:762}, mit ihrem eigenen ersten Reittier, beim Reitlehrer ihrer eigenen Rasse.",
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
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} verkauft die anderen Farben (je 20g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das erhaltene Reittier gefällt.",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}, 20g",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}, 20g",
	["new in Forever, 20g; beta players found it here"] = "neu in Forever, 20g; Beta-Spieler fanden es hier",
	-- {item:277960} Lavender Kodo
	["{item:277960} is a new Forever kodo (level 40, 20g in the client) whose source is not known yet."] = "{item:277960} ist ein neuer Forever-Kodo (Stufe 40, 20g im Client), dessen Quelle noch nicht bekannt ist.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993} und {item:277960} sind neue Forever-Kodos (Stufe 40, 20g im Client), deren Quelle noch unbekannt ist.",
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:3690} und die Kodos von {npc:3685} sind in {area:222}, {zone:1412}. Auf Stufe 40 lehrt {npc:3690} {skill:762} (100g laut Blizzards Designern), und dabei erhältst du ein Reittier. Im Forever-Client können alle Hordenvölker diese reiten.",
}
