-- French (frFR): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Horse"] = "Cheval rapide",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (compagnon)",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding · {faction:72} Stormwind
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} to Humans for 1,000g (10% less at Honored with {faction:72}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift horse costs 200g here."] = "{npc:4732} et l'enclos à chevaux de {npc:384} sont au {area:88}, dans l'est de la {zone:1429}. Au niveau 60, {npc:4732} enseigne la {skill:762} (compagnon) aux Humains pour 1 000 po (10 % de moins à Honoré auprès de {faction:72}) ; d'après Blizzard, elle s'accompagne d'une monture. Les autres races l'apprennent auprès du maître de monte de leur race. Chaque cheval rapide coûte ici 200 po.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, maître de monte",

	-- Step 2: Horse Riding for other races
	-- {spell:824} Horse Riding
	["{spell:824} for other races"] = "{spell:824} pour les autres races",
	-- {spell:824} Horse Riding · {skill:762} Riding · {npc:4732} Randal Hunter · {faction:72} Stormwind
	["Any Alliance race can buy these horses, but riding one also takes {spell:824}, which only Humans get with {skill:762}. {npc:4732} teaches it to other races once they are Exalted with {faction:72} (the Stormwind Reputation guide shows the way). Until then, don't buy a horse for this character."] = "Toute race de l'Alliance peut acheter ces chevaux, mais en monter un demande aussi {spell:824}, que seuls les Humains reçoivent avec la {skill:762}. {npc:4732} l'enseigne aux autres races une fois Exaltées auprès de {faction:72} (le guide de réputation de Hurlevent montre le chemin). D'ici là, n'achetez pas de cheval pour ce personnage.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} vend les autres couleurs (200 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}, 200 po",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}, 200 po",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}, 200 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "{npc:4732} et l'enclos à chevaux de {npc:384} sont au {area:88}, à l'est de la {zone:1429}. Au niveau 60, {npc:4732} enseigne la {skill:762} compagnon (1 000 po selon les concepteurs de Blizzard) ; d'après Blizzard, apprendre la monte donne une monture. Le client Forever vend chaque cheval rapide 200 po au niveau 60.",
}
