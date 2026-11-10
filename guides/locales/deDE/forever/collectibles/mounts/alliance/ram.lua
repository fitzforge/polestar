-- German (deDE): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "Widder",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Lerne reiten",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding · {faction:47} Ironforge
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} to Dwarves for 100g (10% less at Honored with {faction:47}), and it comes with a ram. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{area:803} liegt östlich von {area:131} an der Straße nach {zone:1432}; {npc:4772} steht neben den Widdern von {npc:1261}. Auf Stufe 40 lehrt {npc:4772} Zwerge {skill:762} für 100g (10% weniger bei Wohlwollend mit {faction:47}), und ein Widder gehört dazu. Andere Rassen lernen {skill:762}, mit ihrem eigenen ersten Reittier, beim Reitlehrer ihrer eigenen Rasse.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, Reitlehrer",

	-- Step 2: Ram Riding for other races
	-- {spell:826} Ram Riding
	["{spell:826} for other races"] = "{spell:826} für andere Rassen",
	-- {spell:826} Ram Riding · {skill:762} Riding · {npc:4772} Ultham Ironhorn · {faction:47} Ironforge
	["Any Alliance race can buy these rams, but riding one also takes {spell:826}, which only Dwarves get with {skill:762}. {npc:4772} teaches it to other races once they are Exalted with {faction:47} (the Ironforge Reputation guide shows the way). Until then, don't buy a ram for this character."] = "Jede Allianzrasse kann diese Widder kaufen, aber um einen zu reiten, braucht man auch {spell:826}, das nur Zwerge mit {skill:762} bekommen. {npc:4772} lehrt es andere Rassen, sobald sie bei {faction:47} Ehrfürchtig sind (der Ruf-Guide für Ironforge zeigt den Weg). Bis dahin kaufe für diesen Charakter keinen Widder.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} verkauft die anderen Farben (im Forever-Client je 20g). Kauf, was du willst, oder nichts, wenn dir das erhaltene Reittier gefällt.",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}, 20g",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}, 20g",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}, 20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803} liegt östlich von {area:131} an der Straße nach {zone:1432}; {npc:4772} steht neben den Widdern von {npc:1261}. Ab Stufe 40 lehrt {npc:4772} {skill:762} (laut Blizzards Designern 100g), und beim Erlernen bekommst du ein Reittier. Im Forever-Client darf jedes Allianzvolk sie reiten.",
}
