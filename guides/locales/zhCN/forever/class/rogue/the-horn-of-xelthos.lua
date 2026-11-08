-- Chinese (simplified) (zhCN): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "{item:277210}，是C为一次{area:236}单人任务支付的报酬。",

	-- Step 1: C's dead drop
	["C's dead drop"] = "C的秘密投递点",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest in a house just outside {area:204} in southern Silverpine, south of {area:236}. Open it and read C's note: the job has to be done alone, out of any group."] = "",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order · {spell:921} Pick Pocket
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon, a short way north-east of {area:460}. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers (level 18) working around him carry them in their pockets. Stealth up behind one and {spell:921} it; killing them does not give it."] = "{npc:4086}是一个对双方阵营都友好的地精，站在石爪山脉东部{area:461}的风险投资公司人员中间，位于{area:460}东北方不远处。部落飞往{area:460}；联盟飞往{area:467}。他要一份{item:210187}才肯交出炸药：在他周围干活的风险投资公司伐木工（18级）口袋里带着。潜行到其中一个身后，对其使用{spell:921}；杀死他们不会掉落。",
	-- {spell:921} Pick Pocket · {npc:3989} Venture Co. Logger · {item:210187} Venture Co. Work Order
	["{spell:921} a {npc:3989} for a {item:210187}"] = "对{npc:3989}使用{spell:921}，取得{item:210187}",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge · {item:5140} Flash Powder · {item:210213} Sister's Half-Key · {item:210212} Brother's Half-Key
	["Go in alone and use the {item:210186} at the courtyard gate. Players also report a freed prisoner opening the courtyard door for you: if you die while he is opening it, stay dead until it is open; it stays open once you release. If you know Vanish, bring {item:5140} and check its cooldown before entering; keep it ready for a failed approach. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212} (a level 20 rogue without Vanish may need ranks in Master of Deception to reach the second one unseen). Combine them somewhere safe: this breaks stealth. Free a bag slot first: opening the chest with full bags can use up the key without giving the horn. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}，在{area:236}里",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "回到秘密投递点",
	-- {object:410369} Dead Drop
	["Place the horn in the {object:410369} near Pyrewood. The payment may not appear immediately: check a capital mailbox for C's follow-up letter on your next planned city visit, then return to this chest for the reward quest. Do not repeat the dungeon just because the payment is not yet offered."] = "把号角放进焚木村附近的{object:410369}。报酬可能不会立刻出现：下次计划中回主城时，检查邮箱里C的后续来信，再回这个箱子领取报酬任务。暂时没有报酬任务，不代表需要重新潜入副本。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Go in alone and use the {item:210186} at the courtyard gate. If you know Vanish, bring {item:5140} and check its cooldown before entering; keep it ready for a failed approach. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212}. Combine them somewhere safe: this breaks stealth. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "独自进入，用{item:210186}打开庭院大门。如果已学会消失，进去前备好{item:5140}并检查技能冷却，留作潜入失败时的退路。从餐厅里的姐妹身上偷取{item:210213}，再上楼梯右转，到房间里从兄弟身上偷取{item:210212}。先找安全处再合并两半钥匙：合并会解除潜行。回到庭院马厩，用合成的钥匙开箱取得号角。留意附近精英；最低接取等级不代表能够安全潜入。",
	-- ["Go in alone and use the {item:210186} at the courtyard gate. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212}. Combine them somewhere safe: this breaks stealth. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "独自进入，用{item:210186}打开庭院大门。从餐厅里的姐妹身上偷取{item:210213}，再上楼梯右转，到房间里从兄弟身上偷取{item:210212}。先找安全处再合并两半钥匙：合并会解除潜行。回到庭院马厩，用合成的钥匙开箱取得号角。留意附近精英；最低接取等级不代表能够安全潜入。",
	-- ["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "独自进去。{item:210186}能让你通过庭院大门；数据没有说明号角在要塞的哪个位置。",
	-- ["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "把号角放进焚木村附近的{object:410369}。C的报酬是同一个箱子的第二个{item:210183}任务。",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369}是银松森林南部{area:204}附近的一个箱子，就在{area:236}南边。阅读C的字条。",
	-- ["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}是一个对双方阵营都友好的地精，站在石爪山脉东部{area:461}的风险投资公司人员中间。部落飞往{area:460}；联盟飞往{area:467}。他要一份{item:210187}才肯交出炸药：他周围的{npc:3989}身上带着。",
}
