-- French (frFR): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "Kodo",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Apprendre à monter",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Les kodos de {npc:3690} et {npc:3685} se trouvent à {area:222}, {zone:1412}. Au niveau 40, {npc:3690} enseigne {skill:762} (100 po selon les concepteurs de Blizzard), et l'apprendre vous donne une monture. Le client Forever permet à toutes les races de la Horde de les monter.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, maître de monte",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} vend les autres couleurs (20 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}, 20 po",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}, 20 po",
	-- {item:275993} White Kodo · {item:277960} Lavender Kodo
	["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993} et {item:277960} sont de nouveaux kodos de Forever (niveau 40, 20 po dans le client) dont la source n'est pas encore connue.",
}
