-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/narkk (forever/collectibles/pets/narkk.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:2663} Narkk
	["{npc:2663}'s Parrots"] = "{npc:2663}的鹦鹉",

	-- Step 1: Narkk
	-- {npc:2663} Narkk · {area:35} Booty Bay · {area:392} Ratchet
	["{npc:2663}, the pirate supplier in {area:35}, sells two parrots (40s each). {area:35} is neutral: the boat from {area:392} and the Stranglethorn road both arrive there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{area:35}的海盗供应商{npc:2663}出售两种鹦鹉（每只40银）。{area:35}是中立城镇：从{area:392}来的船和荆棘谷的道路都能到达。每件宠物物品使用后会教会你对应的小伙伴；之后目标会保持勾选。",
	-- {item:8495} Parrot Cage (Senegal)
	["{item:8495}, 40s"] = "{item:8495}，40银",
	-- {item:8496} Parrot Cage (Cockatiel)
	["{item:8496}, 40s"] = "{item:8496}，40银",
}
