-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "韁繩需要60級和中級{skill:762}（Forever 用戶端）。向你種族的騎術訓練師學習；請見60級坐騎指南。",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "55傳承點數",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "傳承點數為帳號共用：每項傳承挑戰（職業達到25、45和60級、專業、PvP、探索）值1點。進度軌道在15點給{item:281060}，25點給{npc:268840}，40點給{item:277717}，55點給韁繩。獎勵的發放方式尚不清楚（可能透過郵件）；韁繩進入背包後此目標即勾選。",
}
