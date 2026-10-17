-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/saber (forever/collectibles/mounts/alliance/saber.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Saber"] = "Саблезуб",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Научитесь верховой езде",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 40 {npc:4753} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4753} и саблезубы ({npc:4730}) – на площадке для верховой езды ({area:1658}, {zone:1457}). На 40-м уровне {npc:4753} обучает навыку {skill:762} (100 з по словам разработчиков Blizzard), и при обучении вы получите транспорт. Клиент Forever позволяет ездить на них всем расам Альянса.",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753} – учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите окрас",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} продает другие окрасы (по 20 з в клиенте Forever). Купите любые или ни одного, если вам нравится полученный транспорт.",
	-- {item:8629} Reins of the Striped Nightsaber
	["{item:8629}, 20g"] = "{item:8629}, 20 з",
	-- {item:8631} Reins of the Striped Frostsaber
	["{item:8631}, 20g"] = "{item:8631}, 20 з",
	-- {item:8632} Reins of the Spotted Frostsaber
	["{item:8632}, 20g"] = "{item:8632}, 20 з",
	-- {item:274706} Reins of the Striped Dawnsaber
	["{item:274706} is a new Forever saber (level 40, 20g in the client) whose source is not known yet."] = "{item:274706} – новый саблезуб Forever (40-й уровень, 20 з в клиенте), источник которого пока неизвестен.",
}
