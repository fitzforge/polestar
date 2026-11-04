-- French (frFR): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "Bélier",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Apprenez à monter",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding · {faction:47} Ironforge
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} to Dwarves for 100g (10% less at Honored with {faction:47}), and it comes with a ram. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "Le {area:803} est à l'est de {area:131}, sur la route du {zone:1432} ; {npc:4772} se tient à côté des béliers de {npc:1261}. Au niveau 40, {npc:4772} enseigne la {skill:762} aux Nains pour 100 po (10 % de moins à Honoré auprès de {faction:47}), avec un bélier. Les autres races apprennent la {skill:762}, avec leur propre première monture, auprès du maître de monte de leur race.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, maître d'équitation",

	-- Step 2: Ram Riding for other races
	-- {spell:826} Ram Riding
	["{spell:826} for other races"] = "{spell:826} pour les autres races",
	-- {spell:826} Ram Riding · {skill:762} Riding · {npc:4772} Ultham Ironhorn · {faction:47} Ironforge
	["Any Alliance race can buy these rams, but riding one also takes {spell:826}, which only Dwarves get with {skill:762}. {npc:4772} teaches it to other races once they are Exalted with {faction:47} (the Ironforge Reputation guide shows the way). Until then, don't buy a ram for this character."] = "Toute race de l'Alliance peut acheter ces béliers, mais en monter un demande aussi {spell:826}, que seuls les Nains reçoivent avec la {skill:762}. {npc:4772} l'enseigne aux autres races une fois Exaltées auprès de {faction:47} (le guide de réputation de Forgefer montre le chemin). D'ici là, n'achetez pas de bélier pour ce personnage.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Choisissez une couleur",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} vend les autres couleurs (20 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}, 20 po",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}, 20 po",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}, 20 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803} se trouve à l'est de {area:131}, sur la route du {zone:1432} ; {npc:4772} se tient à côté des béliers de {npc:1261}. Au niveau 40, {npc:4772} enseigne {skill:762} (100 po selon les concepteurs de Blizzard), et l'apprendre vous donne une monture. Le client Forever permet à toutes les races de l'Alliance de les monter.",
}
