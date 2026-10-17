-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/swift-mechanostrider (forever/collectibles/mounts/alliance/swift-mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Mechanostrider"] = "Mecanostruz Veloz",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift mechanostrider for 200g at level 60."] = "A {area:189} fica logo a leste de {area:131}; {npc:7954} fica ao lado dos mecanostruzes de {npc:7955}. No nível 60, {npc:7954} ensina {skill:762} (Profissional) (1,000g segundo os criadores da Blizzard); a Blizzard diz que aprender montaria concede uma montaria. O cliente Forever vende cada mecanostruz veloz por 200g no nível 60.",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, instrutor de montaria",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} vende as outras cores (200g cada no cliente Forever). Compre as que quiser, ou nenhuma se a montaria que recebeu é a que você gosta.",
	-- {item:18772} Swift Green Mechanostrider
	["{item:18772}, 200g"] = "{item:18772}, 200g",
	-- {item:18773} Swift White Mechanostrider
	["{item:18773}, 200g"] = "{item:18773}, 200g",
	-- {item:18774} Swift Yellow Mechanostrider
	["{item:18774}, 200g"] = "{item:18774}, 200g",
}
