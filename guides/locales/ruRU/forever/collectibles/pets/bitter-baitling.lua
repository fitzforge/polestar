-- Russian (ruRU): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Extravagant Extravaganza Coin
	-- {item:276275} Bitter Baitling · {npc:15078} Jang · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay
	["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "{item:276275} — награда за рыбалку: {npc:15078} обменивает его на одну монету ({item:274026}), награду за рыболовное состязание, которое {npc:15078} проводит здесь: {area:35}. Точный источник монеты пока не опубликован.",

	-- Step 2: Jang
	-- {npc:15078} Jang · {area:35} Booty Bay
	["{npc:15078} stands on the {area:35} docks."] = "{npc:15078} стоит на пристани. Локация: {area:35}.",
}
