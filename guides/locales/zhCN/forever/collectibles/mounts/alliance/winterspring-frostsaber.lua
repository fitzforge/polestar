-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers
	["{npc:10618} stands on top of {area:2241} in the far north of {zone:1452}. Only the Alliance can earn the {faction:589}' favour, from level 58: three repeatable quests worth 50 each, about 840 turn-ins from Neutral to Exalted. Frostsaber Provisions is open from the start, Winterfall Intrusion from halfway through Neutral and Rampaging Giants from Honored. The Wintersaber Trainers Reputation guide takes you through it."] = "{npc:10618} 站在 {zone:1452} 最北端的 {area:2241} 顶上。只有联盟能从 58 级起提升 {faction:589} 声望：三个可重复任务，每次奖励 50 点，从中立到崇拜大约要交还 840 次。“霜刃豹的食物”一开始就能接，“冬泉熊怪的侵扰”在中立进度过半后开放，“狂暴的巨人”在尊敬后开放。“冬刃豹训练师声望”指南会带你完成。",

	-- Step 2: Reins of the Winterspring Frostsaber
	-- {faction:589} Wintersaber Trainers
	["The Forever client lists it at 200g and level 60. It runs at full speed yet needs no riding training at all, only Honored with the {faction:589}, so you can skip the 1,000g Journeyman Riding if this is your fast mount."] = "无限客户端列出的售价为 200 金币，要求 60 级。它的速度达到最高档，却完全不需要学习骑术，只需 {faction:589} 声望尊敬；如果把它作为高速坐骑，就可以省下 1,000 金币的中级骑术费用。",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever 客户端中售价200金，需要60级，不要求骑术等级。",
	-- ["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{zone:1452}北部{area:2241}的{npc:10618}提供可重复任务“霜刃豹的食物”、“冬泉熊怪的侵扰”和“狂暴的巨人”（58级）；它们就是通往崇拜的全部途径，所以要做好交好几周任务的准备。",
}
