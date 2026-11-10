-- German (deDE): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Saber"] = "Säbler",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Reiten lernen",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {faction:69}. At 40 {npc:4753} teaches {skill:762} to Night Elves for 100g (10% less at Honored with {faction:69}), and it comes with a saber. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4753} und die Nachtsäbler von {npc:4730} stehen auf dem Reitgelände der {area:1658} bei {faction:69}. Auf Stufe 40 lehrt {npc:4753} Nachtelfen {skill:762} für 100g (10% weniger bei Wohlwollend mit {faction:69}), und ein Nachtsäbler gehört dazu. Andere Rassen lernen {skill:762}, mit ihrem eigenen ersten Reittier, beim Reitlehrer ihrer eigenen Rasse.",
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
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} verkauft die anderen Farben (je 20g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das erhaltene Reittier gefällt.",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}, 20g",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}, 20g",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}, 20g",
	["new in Forever, 20g; beta players found it here"] = "neu in Forever, 20g; Beta-Spieler fanden es hier",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706} ist ein neuer Forever-Säbler (Stufe 40, 20g im Client), dessen Quelle noch unbekannt ist.",
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4753} und die Säbler von {npc:4730} sind auf dem Reitplatz im {area:1658} in {zone:1457}. Auf Stufe 40 lehrt {npc:4753} {skill:762} (100g laut Blizzards Designern), und dabei erhältst du ein Reittier. Im Forever-Client können alle Allianzvölker diese reiten.",
}
