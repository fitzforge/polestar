-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "缰绳需要60级和中级{skill:762}（Forever客户端）。在你种族的骑术训练师处学习；参见60级坐骑指南。",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "55点传承点数",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "传承点数是账号通用的：每项传承挑战（一个职业达到25、45和60级、专业、PvP、探索）计1点。进度轨道在15点给予{item:281060}，25点给予{npc:268840}，40点给予{item:277717}，55点给予缰绳。奖励如何发放尚不清楚（可能通过邮件）；缰绳进入背包后此目标即完成。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Spectral Bear"] = "鬼灵熊",
}
