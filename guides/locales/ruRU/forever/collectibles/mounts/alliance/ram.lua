-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "Баран",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Научитесь верховой езде",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803} находится к востоку от места {area:131}, на дороге в зону {zone:1432}; {npc:4772} стоит рядом с баранами NPC {npc:1261}. На 40-м уровне {npc:4772} обучает навыку {skill:762} (100 з. по замыслу разработчиков Blizzard), и вместе с навыком вы получаете средство передвижения. Клиент Forever позволяет ездить на них всем расам Альянса.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите цвет",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} продает другие цвета (по 20 з. в клиенте Forever). Купите какие хотите или ни одного, если выданный вам баран вам нравится.",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}, 20 з.",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}, 20 з.",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}, 20 з.",
}
