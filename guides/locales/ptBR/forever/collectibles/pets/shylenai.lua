-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "Corujas de {npc:8665}",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {area:1659} Craftsmen's Terrace · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665}, the owl trainer, stands on the {area:1659} in {zone:1457}, beside the food and general goods vendors. She sells three owls (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665}, a treinadora de corujas, fica em {area:1659}, em {zone:1457}, ao lado dos vendedores de comida e de itens gerais. Ela vende três corujas (50s cada); {item:280803} é novo no Forever. Cada item de mascote ensina o companheiro quando você o usa; as metas continuam marcadas depois.",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}, 50s",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}, 50s",
	["50s"] = "50s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665} vende três corujas em {zone:1457} (50s cada); a {item:280803} é nova no Forever. Cada item de mascote ensina seu companheiro quando usado; os objetivos continuam marcados depois.",
}
