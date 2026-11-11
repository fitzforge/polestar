-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/stormpike-battle-charger (forever/collectibles/mounts/alliance/stormpike-battle-charger.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormpike Guard
	-- {area:2839} Alterac Valley · {faction:730} Stormpike Guard · {npc:13217} Thanthaldis Snowgleam · {zone:1416} Alterac Mountains · {area:287} Hillsbrad · {npc:13216} Gaelden Hammersmith
	["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839}（51级及以上）能提高{faction:730}声望：赢得战斗、占领塔楼和墓地，并交还战场收集任务；最快的方法见奥特兰克山谷声望指南。{npc:13217}在战场外、{area:287}以北的{zone:1416}边界等候；{area:2839}内的{npc:13216}也出售相同坐骑。",

	-- Step 2: Stormpike Battle Charger
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Alliance race can ride it."] = "无限客户端标价为 200 金币，要求 60 级。它以全速奔跑，因此骑乘需要中级 {skill:762}；所有联盟种族都能骑乘。",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}, 200g"] = "{npc:13217}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever客户端标价200金，需要60级，不要求骑术等级。",
	-- ["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839}（51级以上）可提升{faction:730}声望：获胜、占领哨塔和墓地，并交还战场中的物品。{npc:13217}在战场外、{area:287}上方的{zone:1416}边界处等候；{area:2839}内的{npc:13216}也出售同一坐骑。",
}
