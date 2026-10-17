-- French (frFR): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "Chouettes de {npc:8665}",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665} vend trois chouettes à {zone:1457} (50 pa chacune) ; le {item:280803} est nouveau dans Forever. Chaque objet de mascotte apprend sa mascotte quand vous l'utilisez ; les objectifs restent cochés ensuite.",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}, 50 pa",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}, 50 pa",
	["50s"] = "50 pa",
}
