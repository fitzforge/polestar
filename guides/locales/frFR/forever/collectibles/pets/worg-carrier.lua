-- French (frFR): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} à {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} se tient à {area:251}, au nord de {zone:1428}, près du chemin de {area:254}.",

	-- Step 2: Upper Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Upper {area:1583}"] = "{area:1583} supérieur",
	-- {area:1583} Blackrock Spire · {npc:10260} Kibler · {npc:10221} Bloodaxe Worg Pup · {item:12263} Caged Worg Pup
	["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "{area:1583} supérieur est un raid jusqu'à dix joueurs, niveau 58-60. Utilisez la cage de {npc:10260} sur un {npc:10221} (repaire de Halycon) pour obtenir le {item:12263}.",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Retour à {npc:10260}",
}
