-- French (frFR): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "Apprendre la monte",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4773} et l'écurie de {npc:4731} sont à {area:159}, dans {zone:1420}. Au niveau 40, {npc:4773} enseigne la {skill:762} (100 po selon les concepteurs de Blizzard), et l'apprendre vous donne une monture. Le client Forever permet à toutes les races de la Horde de les monter.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maître de monte",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} vend les autres couleurs (20 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}, 20 po",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}, 20 po",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}, 20 po",
	-- {npc:267354} Black Skeletal Horse
	["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354} est un nouveau cheval de Forever (niveau 40) dont l'origine n'est pas encore connue.",
}
