-- German (deDE): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: CLUCK!
	-- {npc:233} Farmer Saldean · {quest:3861} CLUCK! · {item:11109} Special Chicken Feed · {item:11110} Chicken Egg
	["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "Such auf dem Hof von {npc:233} ein Huhn und gib /chicken ein, bis es {quest:3861} anbietet. Kauf {item:11109} bei {npc:233}, geh zurück, mach /cheer beim selben Huhn und gib dann das Futter ab. Das Huhn legt ein Ei: Plündere es für dein Haustier {item:11110}.",
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["{item:11109}, from {npc:233}"] = "{item:11109}, von {npc:233}",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "Plündere {object:161513}, das das Huhn legt",
}
