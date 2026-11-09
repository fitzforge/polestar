-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/frostwolf-howler (forever/collectibles/mounts/horde/frostwolf-howler.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Frostwolf Clan
	-- {area:2839} Alterac Valley · {faction:729} Frostwolf Clan · {npc:13219} Jekyll Flandring · {zone:1416} Alterac Mountains · {npc:13218} Grunnda Wolfheart
	["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839}（51级及以上）能提高{faction:729}声望：赢得战斗、占领塔楼和墓地，并交还战场收集任务；最快的方法见奥特兰克山谷声望指南。{npc:13219}在战场外、{zone:1416}的部落一端等候；{area:2839}内的{npc:13218}也出售相同坐骑。",

	-- Step 2: Horn of the Frostwolf Howler
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Horde race can ride it."] = "无限服客户端列出的价格为200金币，要求60级。它以最高速度奔跑，因此骑乘需要中级{skill:762}；所有部落种族都能骑。",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}, 200g"] = "{npc:13219}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever 客户端中售价200金，需要60级，不要求骑术等级。",
	-- ["{area:2839} (level 51+) raises {faction:729}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13219} waits at the Horde end of {zone:1416} outside the battleground; {npc:13218} inside {area:2839} sells the same mount."] = "{area:2839}（51级以上）提升{faction:729}声望：获胜、占领哨塔和墓地，并上交战场的物品任务。{npc:13219}在战场外{zone:1416}的部落一端等候；{area:2839}内的{npc:13218}出售同样的坐骑。",
}
