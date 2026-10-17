-- French (frFR): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Saber"] = "Sabres rapides",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Compagnon)",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "Les sabres de {npc:4753} et {npc:4730} sont dans le terrain de monte de l'{area:1658}, à {zone:1457}. Au niveau 60, {npc:4753} enseigne {skill:762} (Compagnon) (1,000 po selon les concepteurs de Blizzard) ; selon Blizzard, apprendre la monte donne une monture. Le client Forever vend chaque sabre rapide 200 po au niveau 60.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, maître de monte",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} vend les autres couleurs (200 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}, 200 po",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}, 200 po",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}, 200 po",
}
