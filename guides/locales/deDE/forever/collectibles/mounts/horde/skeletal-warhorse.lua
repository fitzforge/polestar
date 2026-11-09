-- German (deDE): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "Skelettschlachtross",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} to Undead for 1,000g (10% less at Honored with {faction:68}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each skeletal warhorse costs 200g here."] = "{npc:4773} und der Stall von {npc:4731} stehen in {area:159}, {zone:1420}. Auf Stufe 60 lehrt {npc:4773} Untote {skill:762} (Geselle) für 1.000g (10% weniger bei Wohlwollend mit {faction:68}); laut Blizzard gehört ein Reittier dazu. Andere Rassen lernen es beim Reitlehrer ihrer eigenen Rasse. Jedes Skeletal Warhorse kostet hier 200g.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrerin",

	-- Step 2: Undead Horsemanship for other races
	-- {spell:10906} Undead Horsemanship
	["{spell:10906} for other races"] = "{spell:10906} für andere Rassen",
	-- {spell:10906} Undead Horsemanship · {skill:762} Riding · {npc:4773} Velma Warnam · {faction:68} Undercity
	["Any Horde race can buy these skeletal horses, but riding one also takes {spell:10906}, which only Undead get with {skill:762}. {npc:4773} teaches it to other races once they are Exalted with {faction:68} (the Undercity Reputation guide shows the way). Until then, don't buy a skeletal horse for this character."] = "Jede Hordenrasse kann diese Skeletal Horses kaufen, aber um eines zu reiten, braucht man auch {spell:10906}, das nur Untote mit {skill:762} bekommen. {npc:4773} lehrt es andere Rassen, sobald sie bei {faction:68} Ehrfürchtig sind (der Ruf-Guide für Undercity zeigt den Weg). Bis dahin kaufe für diesen Charakter kein Skeletal Horse.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} verkauft die anderen Farben (je 200g im Forever-Client). Kauf, welche du willst, oder keine, wenn dir das Reittier gefällt, das du bekommen hast.",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}, 200g",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}, 200g",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Die neuen grünen, dunklen und purpurnen Skelettpferde aus Forever und {npc:265653} (Stufe 60) haben noch keine bekannte Quelle.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "Der Stall von {npc:4773} und {npc:4731} ist in {area:159}, {zone:1420}. Mit 60 lehrt dich {npc:4773} {skill:762} (Geselle) (1,000g laut den Designern von Blizzard); laut Blizzard bekommst du beim Erlernen des Reitens ein Reittier. Der Forever-Client verkauft jedes Skelettschlachtross für 200g ab Stufe 60.",
}
