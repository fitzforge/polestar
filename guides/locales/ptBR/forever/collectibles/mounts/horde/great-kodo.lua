-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "Grande Kodo",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "Os kodos de {npc:3690} e {npc:3685} estão em {area:222}, {zone:1412}. No nível 60, {npc:3690} ensina {skill:762} (Profissional) (1.000g segundo os designers da Blizzard); a Blizzard diz que aprender montaria concede uma montaria. O cliente do Forever vende cada grande kodo por 200g no nível 60.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instrutor de montaria",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Escolha uma cor",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} vende as outras cores (200g cada no cliente do Forever). Compre as que quiser, ou nenhuma se a montaria que você ganhou for a que você gosta.",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}, 200g",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}, 200g",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}, 200g",
}
