-- German (deDE): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "Schneller Widder",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803} liegt östlich von {area:131} an der Straße nach {zone:1432}; {npc:4772} steht neben den Widdern von {npc:1261}. Ab Stufe 60 lehrt {npc:4772} {skill:762} (Geselle) (laut Blizzards Designern 1.000g); laut Blizzard bekommst du beim Erlernen ein Reittier. Der Forever-Client verkauft jeden schnellen Widder für 200g ab Stufe 60.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, Reitlehrer",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} verkauft die anderen Farben (im Forever-Client je 200g). Kauf, was du willst, oder nichts, wenn dir das erhaltene Reittier gefällt.",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}, 200g",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}, 200g",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}, 200g",
}
