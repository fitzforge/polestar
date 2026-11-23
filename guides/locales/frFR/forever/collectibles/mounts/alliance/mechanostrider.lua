-- French (frFR): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Mechanostrider"] = "Mécanotrotteur",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Apprenez la monte",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding · {faction:54} Gnomeregan Exiles
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} to Gnomes for 100g (10% less at Honored with {faction:54}), and it comes with a mechanostrider. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "Le {area:189} est juste à l'est de {area:131} ; {npc:7954} se tient à côté des mécanotrotteurs de {npc:7955}. Au niveau 40, {npc:7954} enseigne la {skill:762} aux Gnomes pour 100 po (10 % de moins à Honoré auprès des {faction:54}), avec un mécanotrotteur. Les autres races apprennent la {skill:762}, avec leur propre première monture, auprès du maître de monte de leur race.",
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
	["{npc:7955} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} vend les autres couleurs (20 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:8563} Red Mechanostrider
	["{item:8563}, 20g"] = "{item:8563}, 20 po",
	-- {item:8595} Blue Mechanostrider
	["{item:8595}, 20g"] = "{item:8595}, 20 po",
	-- {item:13321} Green Mechanostrider
	["{item:13321}, 20g"] = "{item:13321}, 20 po",
	-- {item:13322} Unpainted Mechanostrider
	["{item:13322}, 20g"] = "{item:13322}, 20 po",
	-- {spell:10907} Mechanostrider Piloting
	["In Classic only Dwarves and Gnomes could ride mechanostriders; in Forever every Alliance race can learn {spell:10907}."] = "Dans Classic, seuls les Nains et les Gnomes pouvaient monter les mécanotrotteurs ; dans Forever, toute race de l'Alliance peut apprendre {spell:10907}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "Era ne permettait qu'aux nains et aux gnomes de monter les mécanotrotteurs ; le client Forever l'autorise à toutes les races de l'Alliance.",
	-- ["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:189} est juste à l'est de {area:131} ; {npc:7954} se tient à côté des mécanotrotteurs de {npc:7955}. Au niveau 40, {npc:7954} enseigne {skill:762} (100 po selon les concepteurs de Blizzard), et l'apprendre vous donne une monture. Le client Forever permet à toutes les races de l'Alliance de les monter.",
}
