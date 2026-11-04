-- French (frFR): the guide forever/collectibles/mounts/alliance/swift-mechanostrider (forever/collectibles/mounts/alliance/swift-mechanostrider.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Mechanostrider"] = "Mécanotrotteur rapide",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Compagnon)",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding · {faction:54} Gnomeregan Exiles
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} to Gnomes for 1,000g (10% less at Honored with {faction:54}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift mechanostrider costs 200g here."] = "Le {area:189} est juste à l'est de {area:131} ; {npc:7954} se tient à côté des mécanotrotteurs de {npc:7955}. Au niveau 60, {npc:7954} enseigne la {skill:762} (compagnon) aux Gnomes pour 1 000 po (10 % de moins à Honoré auprès des {faction:54}) ; d'après Blizzard, elle s'accompagne d'une monture. Les autres races l'apprennent auprès du maître de monte de leur race. Chaque mécanotrotteur rapide coûte ici 200 po.",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, maître de monte",

	-- Step 2: Mechanostrider Piloting for other races
	-- {spell:10907} Mechanostrider Piloting
	["{spell:10907} for other races"] = "{spell:10907} pour les autres races",
	-- {spell:10907} Mechanostrider Piloting · {skill:762} Riding · {npc:7954} Binjy Featherwhistle · {faction:54} Gnomeregan Exiles
	["Any Alliance race can buy these mechanostriders, but riding one also takes {spell:10907}, which only Gnomes get with {skill:762}. {npc:7954} teaches it to other races once they are Exalted with {faction:54} (the Gnomeregan Exiles Reputation guide shows the way). Until then, don't buy a mechanostrider for this character."] = "Toute race de l'Alliance peut acheter ces mécanotrotteurs, mais en monter un demande aussi {spell:10907}, que seuls les Gnomes reçoivent avec la {skill:762}. {npc:7954} l'enseigne aux autres races une fois Exaltées auprès des {faction:54} (le guide de réputation des Exilés de Gnomeregan montre le chemin). D'ici là, n'achetez pas de mécanotrotteur pour ce personnage.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Choisissez une couleur",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} vend les autres couleurs (200 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:18772} Swift Green Mechanostrider
	["{item:18772}, 200g"] = "{item:18772}, 200 po",
	-- {item:18773} Swift White Mechanostrider
	["{item:18773}, 200g"] = "{item:18773}, 200 po",
	-- {item:18774} Swift Yellow Mechanostrider
	["{item:18774}, 200g"] = "{item:18774}, 200 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift mechanostrider for 200g at level 60."] = "Le {area:189} est juste à l'est de {area:131} ; {npc:7954} se tient à côté des mécanotrotteurs de {npc:7955}. Au niveau 60, {npc:7954} enseigne {skill:762} (Compagnon) (1 000 po selon les concepteurs de Blizzard) ; selon Blizzard, apprendre la monte donne une monture. Le client Forever vend chaque mécanotrotteur rapide 200 po au niveau 60.",
}
