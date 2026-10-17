-- German (deDE): the guide forever/collectibles/mounts/alliance/swift-mechanostrider (forever/collectibles/mounts/alliance/swift-mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Mechanostrider"] = "Schneller Roboschreiter",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift mechanostrider for 200g at level 60."] = "{area:189} liegt direkt östlich von {area:131}; {npc:7954} steht neben den Roboschreitern von {npc:7955}. Ab Stufe 60 lehrt {npc:7954} {skill:762} (Geselle) (laut Blizzards Designern 1.000g); laut Blizzard bekommst du beim Erlernen ein Reittier. Der Forever-Client verkauft jeden schnellen Roboschreiter für 200g ab Stufe 60.",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, Reitlehrer",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} verkauft die anderen Farben (im Forever-Client je 200g). Kauf, was du willst, oder nichts, wenn dir das erhaltene Reittier gefällt.",
	-- {item:18772} Swift Green Mechanostrider
	["{item:18772}, 200g"] = "{item:18772}, 200g",
	-- {item:18773} Swift White Mechanostrider
	["{item:18773}, 200g"] = "{item:18773}, 200g",
	-- {item:18774} Swift Yellow Mechanostrider
	["{item:18774}, 200g"] = "{item:18774}, 200g",
}
