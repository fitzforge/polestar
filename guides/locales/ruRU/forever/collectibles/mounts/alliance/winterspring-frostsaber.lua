-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring
	["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{npc:10618} ({area:2241}, север зоны {zone:1452}) выдает повторяемые задания «Накормить ледопардов», «Вторжение племени Зимней Спячки» и «Истребление великанов» (уровень 58); это единственный путь к превознесению, так что сдавать их придется неделями.",

	-- Step 2: Reins of the Winterspring Frostsaber
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Клиент Forever указывает цену 200 з и 60-й уровень и не требует навыка верховой езды.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200 з",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1452} Frostsaber"] = "Ледопард: {zone:1452}",
}
