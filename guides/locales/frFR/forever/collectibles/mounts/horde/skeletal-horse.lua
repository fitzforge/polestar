-- French (frFR): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "Apprendre la monte",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding · {faction:68} Undercity
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} to Undead for 100g (10% less at Honored with {faction:68}), and it comes with a skeletal horse. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:4773} et l'écurie de {npc:4731} sont à {area:159}, dans les {zone:1420}. Au niveau 40, {npc:4773} enseigne la {skill:762} aux Morts-vivants pour 100 po (10 % de moins à Honoré auprès de {faction:68}), avec un cheval squelette. Les autres races apprennent la {skill:762}, avec leur propre première monture, auprès du maître de monte de leur race.",
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
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} vend les autres couleurs (20 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}, 20 po",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}, 20 po",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}, 20 po",
	["new in Forever, 20g; beta players found it here"] = "nouveau dans Forever, 20 po ; les joueurs de la bêta l'ont trouvé ici",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354} est un nouveau cheval de Forever (niveau 40) dont l'origine n'est pas encore connue.",
	-- ["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4773} et l'écurie de {npc:4731} sont à {area:159}, dans {zone:1420}. Au niveau 40, {npc:4773} enseigne la {skill:762} (100 po selon les concepteurs de Blizzard), et l'apprendre vous donne une monture. Le client Forever permet à toutes les races de la Horde de les monter.",
}
