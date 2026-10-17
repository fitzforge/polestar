-- Russian (ruRU): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "Совы — {npc:8665}",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665} продает трех сов (по 50 с), локация: {zone:1457}. {item:280803} — новинка Forever. Каждый предмет питомца при использовании дает спутника; цели после этого остаются отмеченными.",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}, 50 с",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}, 50 с",
	["50s"] = "50 с",
}
