-- German (deDE): the guide forever/collectibles/mounts/horde/swift-raptor (forever/collectibles/mounts/horde/swift-raptor.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Raptor"] = "Schneller Raptor",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding · {faction:530} Darkspear Trolls
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} to Trolls for 1,000g (10% less at Honored with {faction:530}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift raptor costs 200g here."] = "{npc:7953} und die Raptoren von {npc:7952} stehen in {area:367} an der Küste von {zone:1411}. Auf Stufe 60 lehrt {npc:7953} Trolle {skill:762} (Geselle) für 1.000g (10% weniger bei Wohlwollend mit {faction:530}); laut Blizzard gehört ein Reittier dazu. Andere Rassen lernen es beim Reitlehrer ihrer eigenen Rasse. Jeder schnelle Raptor kostet hier 200g.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",

	-- Step 2: Raptor Riding for other races
	-- {spell:10861} Raptor Riding
	["{spell:10861} for other races"] = "{spell:10861} für andere Rassen",
	-- {spell:10861} Raptor Riding · {skill:762} Riding · {npc:7953} Xar'Ti · {faction:530} Darkspear Trolls
	["Any Horde race can buy these raptors, but riding one also takes {spell:10861}, which only Trolls get with {skill:762}. {npc:7953} teaches it to other races once they are Exalted with {faction:530} (the Darkspear Trolls Reputation guide shows the way). Until then, don't buy a raptor for this character."] = "Jede Hordenrasse kann diese Raptoren kaufen, aber um einen zu reiten, braucht man auch {spell:10861}, das nur Trolle mit {skill:762} bekommen. {npc:7953} lehrt es andere Rassen, sobald sie bei {faction:530} Ehrfürchtig sind (der Ruf-Guide für die Dunkelspeertrolle zeigt den Weg). Bis dahin kaufe für diesen Charakter keinen Raptor.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} verkauft die anderen Farben (im Forever-Client je 200g). Kauf, was du willst, oder nichts, wenn dir das erhaltene Reittier gefällt.",
	-- {item:18788} Swift Blue Raptor
	["{item:18788}, 200g"] = "{item:18788}, 200g",
	-- {item:18789} Swift Olive Raptor
	["{item:18789}, 200g"] = "{item:18789}, 200g",
	-- {item:18790} Swift Orange Raptor
	["{item:18790}, 200g"] = "{item:18790}, 200g",
	-- {item:46102} Whistle of the Venomhide Ravasaur
	["{item:46102} (level 60) is in the Forever client, but its source is not known yet."] = "{item:46102} (Stufe 60) gibt es im Forever-Client, aber die Quelle ist noch unbekannt.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift raptor for 200g at level 60."] = "{npc:7953} und die Raptoren von {npc:7952} sind in {area:367} an der Küste von {zone:1411}. Ab Stufe 60 lehrt {npc:7953} {skill:762} (Geselle) (laut Blizzards Designern 1.000g); laut Blizzard bekommst du beim Erlernen ein Reittier. Der Forever-Client verkauft jeden schnellen Raptor für 200g ab Stufe 60.",
}
