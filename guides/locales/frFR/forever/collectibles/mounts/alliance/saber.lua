-- French (frFR): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Saber"] = "Sabre",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Apprendre à monter",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "Les sabres de {npc:4753} et {npc:4730} se trouvent dans l'enclos de monte de {area:1658}, à {zone:1457}. Au niveau 40, {npc:4753} enseigne {skill:762} (100 po selon les concepteurs de Blizzard), et l'apprendre vous donne une monture. Le client Forever permet à toutes les races de l'Alliance de les monter.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, maître de monte",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} vend les autres couleurs (20 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}, 20 po",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}, 20 po",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}, 20 po",
	-- {item:274706} Reins of the Striped Dawnsaber
	["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706} est un nouveau sabre de Forever (niveau 40, 20 po dans le client) dont la source n'est pas encore connue.",
}
