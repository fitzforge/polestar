-- Russian (ruRU): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "Кодо",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Научитесь верховой езде",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:3690} и кодо ({npc:3685}) – здесь: {area:222}, {zone:1412}. На 40-м уровне {npc:3690} обучает навыку {skill:762} (100 з по словам разработчиков Blizzard), и при обучении вы получите транспорт. Клиент Forever позволяет ездить на них всем расам Орды.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690} – учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите окрас",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685} продает другие окрасы (по 20 з в клиенте Forever). Купите любые или ни одного, если вам нравится полученный транспорт.",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}, 20 з",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}, 20 з",
	-- {item:275993} White Kodo · {item:277960} Lavender Kodo
	["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993} и {item:277960} – новые кодо Forever (40-й уровень, 20 з в клиенте), источник которых пока неизвестен.",
}
