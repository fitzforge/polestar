-- French (frFR): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "Cheval de guerre squelette",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Compagnon)",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} to Undead for 1,000g (10% less at Honored with {faction:68}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each skeletal warhorse costs 200g here."] = "{npc:4773} et l'écurie de {npc:4731} sont à {area:159}, dans les {zone:1420}. Au niveau 60, {npc:4773} enseigne la {skill:762} (compagnon) aux Morts-vivants pour 1 000 po (10 % de moins à Honoré auprès de {faction:68}) ; d'après Blizzard, elle s'accompagne d'une monture. Les autres races l'apprennent auprès du maître de monte de leur race. Chaque cheval de guerre squelette coûte ici 200 po.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maître de monte",

	-- Step 2: Undead Horsemanship for other races
	-- {spell:10906} Undead Horsemanship
	["{spell:10906} for other races"] = "{spell:10906} pour les autres races",
	-- {spell:10906} Undead Horsemanship · {skill:762} Riding · {npc:4773} Velma Warnam · {faction:68} Undercity
	["Any Horde race can buy these skeletal horses, but riding one also takes {spell:10906}, which only Undead get with {skill:762}. {npc:4773} teaches it to other races once they are Exalted with {faction:68} (the Undercity Reputation guide shows the way). Until then, don't buy a skeletal horse for this character."] = "Toute race de la Horde peut acheter ces chevaux squelettes, mais en monter un demande aussi {spell:10906}, que seuls les Morts-vivants reçoivent avec la {skill:762}. {npc:4773} l'enseigne aux autres races une fois Exaltées auprès de {faction:68} (le guide de réputation de Fossoyeuse montre le chemin). D'ici là, n'achetez pas de cheval squelette pour ce personnage.",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} vend les autres couleurs (200 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}, 200 po",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}, 200 po",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "Les nouveaux Chevaux squelettes vert, sombre et violet de Forever et le {npc:265653} (niveau 60) n'ont pas encore de source connue.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "L'écurie de {npc:4773} et {npc:4731} se trouve à {area:159}, dans les {zone:1420}. Au niveau 60, {npc:4773} enseigne {skill:762} (Compagnon) (1,000 po selon les concepteurs de Blizzard) ; selon Blizzard, apprendre la monte donne une monture. Le client Forever vend chaque cheval de guerre squelette 200 po au niveau 60.",
}
