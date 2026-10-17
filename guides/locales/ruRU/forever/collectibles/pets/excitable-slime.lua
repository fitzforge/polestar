-- Russian (ruRU): the guide forever/collectibles/pets/excitable-slime (forever/collectibles/pets/excitable-slime.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: WRIGGLE.
	-- {npc:269452} Excitable Slime · {zone:1458} Undercity · {item:278265} Nutritious Slime Sludge
	["Find the {npc:269452}, a critter in the {zone:1458} canals, and /dance with it until it offers WRIGGLE. Buy {item:278265} from a vendor in the canals and bring it back; if the slime seems tired, dance with it again."] = "Найдите зверька в каналах ({zone:1458}) – это {npc:269452} – и танцуйте с ним (/dance), пока он не предложит задание. Купите {item:278265} у торговца в каналах и принесите обратно; если слизень выглядит уставшим, станцуйте с ним снова.",
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle
	["{item:278265}: {npc:4612}, in the canals beside the slime"] = "{item:278265}: {npc:4612}, в каналах рядом со слизнем",
}
