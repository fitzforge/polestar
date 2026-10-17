-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/jeremiah-payson (forever/collectibles/pets/jeremiah-payson.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}'s Cockroaches"] = "Baratas de {npc:8403}",

	-- Step 1: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson · {zone:1458} Undercity
	["{npc:8403} sells three cockroaches in the {zone:1458} (50s each); the Plagued and Undercity Cockroaches are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8403} vende três baratas em {zone:1458} (50s cada); a Barata Pestilenta e a Barata da Cidade Baixa são novas no Forever. Cada item de mascote ensina seu companheiro quando usado; os objetivos continuam marcados depois.",
	-- {item:10393} Cockroach
	["{item:10393}, 50s"] = "{item:10393}, 50s",
	["50s"] = "50s",
}
