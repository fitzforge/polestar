-- German (deDE): the guide forever/collectibles/mounts/horde/raptor (forever/collectibles/mounts/horde/raptor.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding · {faction:530} Darkspear Trolls
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} to Trolls for 100g (10% less at Honored with {faction:530}), and it comes with a raptor. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:7953} und die Raptoren von {npc:7952} stehen in {area:367} an der Küste von {zone:1411}. Auf Stufe 40 lehrt {npc:7953} Trolle {skill:762} für 100g (10% weniger bei Wohlwollend mit {faction:530}), und ein Raptor gehört dazu. Andere Rassen lernen {skill:762}, mit ihrem eigenen ersten Reittier, beim Reitlehrer ihrer eigenen Rasse.",
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
	["{npc:7952} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} verkauft die anderen Farben (je 20g im Forever-Client). Kaufe, was du willst, oder nichts, wenn dir dein erhaltenes Reittier gefällt.",
	-- {item:8588} Whistle of the Emerald Raptor
	["{item:8588}, 20g"] = "{item:8588}, 20g",
	-- {item:8591} Whistle of the Turquoise Raptor
	["{item:8591}, 20g"] = "{item:8591}, 20g",
	-- {item:8592} Whistle of the Violet Raptor
	["{item:8592}, 20g"] = "{item:8592}, 20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 40 {npc:7953} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Die Raptoren von {npc:7953} und {npc:7952} sind in {area:367} an der Küste von {zone:1411}. Ab Stufe 40 lehrt {npc:7953} {skill:762} (100g laut Blizzards Designern), und beim Erlernen bekommst du ein Reittier. Im Forever-Client dürfen alle Hordevölker diese reiten.",
}
