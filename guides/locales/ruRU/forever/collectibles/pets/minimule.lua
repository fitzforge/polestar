-- Russian (ruRU): the guide forever/collectibles/pets/minimule (forever/collectibles/pets/minimule.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Minimule"] = "Минимул",

	-- Step 1: Azeroth Commerce Authority
	["Azeroth Commerce Authority"] = "Азеротское торговое управление",
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {npc:214101} Marcy Baker
	["The Alliance camp is at {area:1002} in western {zone:1433}. Loot supply crates in the world, fill them and hand them in to {npc:214101} for Merchant's Favor (5-20 a crate); the treat costs 1,500."] = "Лагерь Альянса – здесь: {area:1002}, запад зоны {zone:1433}. Собирайте ящики с припасами по миру, заполняйте их и сдавайте персонажу {npc:214101} за Merchant's Favor (5–20 за ящик); лакомство стоит 1500.",
	["1,500 Merchant's Favor"] = "1500 Merchant's Favor",

	-- Step 2: Durotar Supply and Logistics
	["Durotar Supply and Logistics"] = "Дуротарские снабжение и логистика",
	-- {area:380} Crossroads · {npc:256384} Gishah · {zone:1458} Undercity
	["The Horde camp is just outside the {area:380}. Loot supply crates in the world, fill them and hand them in at the camp for Merchant's Favor; the treat costs 1,500. (Another {npc:256384} stands in the {zone:1458}; this is the one at the camp.)"] = "Лагерь Орды – сразу у места {area:380}. Собирайте ящики с припасами по миру, заполняйте их и сдавайте в лагере за Merchant's Favor; лакомство стоит 1500. (Еще один {npc:256384} стоит здесь: {zone:1458}; нужен тот, что в лагере.)",
}
