-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/horse (forever/collectibles/mounts/alliance/horse.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Horse"] = "Конь",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Научитесь ездить верхом",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 40 {npc:4732} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{npc:4732} и загон для лошадей (хозяйка: {npc:384}) – здесь: {area:88}, восток зоны {zone:1429}. На 40-м уровне {npc:4732} обучает навыку {skill:762} (100з, по словам дизайнеров Blizzard), и вместе с ним вы получаете транспорт. В клиенте Forever на них может ездить любая раса Альянса.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите окраску",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} продает другие окраски (по 20з в клиенте Forever). Купите любые или ни одной, если вам нравится полученный транспорт.",
	-- {item:2414} Pinto Bridle
	["{item:2414}, 20g"] = "{item:2414}, 20з",
	-- {item:5655} Chestnut Mare Bridle
	["{item:5655}, 20g"] = "{item:5655}, 20з",
	-- {item:5656} Brown Horse Bridle
	["{item:5656}, 20g"] = "{item:5656}, 20з",
	-- {item:2411} Black Stallion Bridle
	["{item:2411} is in the client, but no vendor is confirmed to sell it in Forever."] = "{item:2411} есть в клиенте, но торговец, продающий его в Forever, не подтвержден.",
}
