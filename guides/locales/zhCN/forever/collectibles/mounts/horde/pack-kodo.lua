-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/pack-kodo (forever/collectibles/mounts/horde/pack-kodo.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Durotar Supply and Logistics
	-- {zone:1413} Barrens · {npc:256400} Okamache · {npc:10636} Pack Kodo · {faction:2587} Durotar Supply and Logistics · {item:280179} Shipping Label
	["The camp stands just outside the west gate of the Crossroads in the {zone:1413}. {npc:256400} sells the {npc:10636} only once you are Exalted with {faction:2587}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "营地就在 {zone:1413} 的十字路口西门外。只有 {faction:2587} 声望达到崇拜后，{npc:256400} 才出售 {npc:10636}，售价为 6,000 商人青睐。交箱子只奖励商人青睐（每箱约 15）；声望来自工匠文书和一次性的 {item:280179}，因此请按补给阵营声望指南进行，并预留 6,000 商人青睐。",
	-- {faction:2587} Durotar Supply and Logistics
	["{faction:2587} camp"] = "{faction:2587} 营地",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "缰绳需要60级和中级骑术才能骑乘（无限 客户端）；可以提前购买。",
	["6,000 Merchant's Favor"] = "6,000 商人青睐",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Durotar Supply and Logistics"] = "杜隆塔尔补给后勤部",
	-- ["The camp is just outside the {area:380} in the {zone:1413}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "营地就在{zone:1413}的{area:380}外。在野外拾取补给箱，装满后在营地上交换取Merchant's Favor（每箱5-20）；{npc:10636}售价6,000。从10级起工匠文书也可能有帮助。",
}
