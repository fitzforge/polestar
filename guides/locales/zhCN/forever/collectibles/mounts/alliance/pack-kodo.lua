-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/pack-kodo (forever/collectibles/mounts/alliance/pack-kodo.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Azeroth Commerce Authority
	-- {area:1002} Three Corners · {zone:1433} Redridge Mountains · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256736} Huey Sunnydale · {npc:10636} Pack Kodo · {faction:2586} Azeroth Commerce Authority · {item:280179} Shipping Label
	["The camp is at {area:1002} in western {zone:1433}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet. {npc:256736} sells the {npc:10636} only once you are Exalted with the {faction:2586}, and it costs 6,000 Merchant's Favor. Crates pay only Favor (about 15 a crate return); the reputation comes from Craftsman's Writs and the one-time {item:280179}, so follow the Supply Factions Reputation guide and keep 6,000 Favor aside."] = "营地在{zone:1433}西部的{area:1002}，也就是从{zone:1429}、{zone:1431}和{area:69}过来的道路交汇处。只有{faction:2586}声望达到崇拜后，才能向{npc:256736}购买{npc:10636}，售价6,000点商人青睐。交箱子只给商人青睐（每次约15点）；声望来自工匠文书和一次性的{item:280179}，因此请按“补给阵营声望”指南推进，并预留6,000点商人青睐。",
	-- {faction:2586} Azeroth Commerce Authority
	["{faction:2586} camp"] = "{faction:2586} 营地",

	-- Step 2: Pack Kodo
	["The reins need level 60 and Journeyman Riding to ride (Forever client); you can buy them earlier."] = "缰绳需要60级和中级骑术才能骑乘（无限 客户端）；可以提前购买。",
	["6,000 Merchant's Favor"] = "6,000 商人青睐",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azeroth Commerce Authority"] = "艾泽拉斯贸易局",
	-- ["The camp is at {area:1002} in western {zone:1433}, between {zone:1429} and {area:69}. Loot supply crates in the world, fill them, and hand them in at the camp for Merchant's Favor (5-20 a crate); the {npc:10636} costs 6,000. Craftsman's Writs may help from level 10."] = "营地位于{zone:1433}西部的{area:1002}，在{zone:1429}和{area:69}之间。在野外拾取补给箱，装满后在营地上交换取Merchant's Favor（每箱5-20）；{npc:10636}售价6,000。从10级起工匠文书也可能有帮助。",
}
