-- Chinese (simplified) (zhCN): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369}是银松森林南部{area:204}附近的一个箱子，就在{area:236}南边。阅读C的字条。",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}是一个对双方阵营都友好的地精，站在石爪山脉东部{area:461}的风险投资公司人员中间。部落飞往{area:460}；联盟飞往{area:467}。他要一份{item:210187}才肯交出炸药：他周围的{npc:3989}身上带着。",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge
	["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "独自进去。{item:210186}能让你通过庭院大门；数据没有说明号角在要塞的哪个位置。",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}，在{area:236}里",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "回到秘密投递点",
	-- {object:410369} Dead Drop · {item:210183} Horn of Xelthos
	["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "把号角放进焚木村附近的{object:410369}。C的报酬是同一个箱子的第二个{item:210183}任务。",
}
