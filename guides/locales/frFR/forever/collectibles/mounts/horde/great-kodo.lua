-- French (frFR): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "Grand kodo",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} compagnon",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "Les kodos de {npc:3690} et {npc:3685} se trouvent à {area:222}, {zone:1412}. Au niveau 60, {npc:3690} enseigne {skill:762} compagnon (1 000 po selon les concepteurs de Blizzard) ; selon Blizzard, apprendre la monte donne une monture. Le client Forever vend chaque grand kodo 200 po au niveau 60.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, maître de monte",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Choisir une couleur",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} vend les autres couleurs (200 po chacune dans le client Forever). Achetez celles que vous voulez, ou aucune si la monture reçue vous plaît.",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}, 200 po",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}, 200 po",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}, 200 po",
}
