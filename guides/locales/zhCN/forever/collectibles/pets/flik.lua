-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "暗月马戏团青蛙",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "暗月马戏团的{npc:14860}",
	-- {npc:14860} Flik · {area:87} Goldshire · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {item:11027} Wood Frog Box
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town; Forever has not shown the Faire yet. In Classic it sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. {npc:14860} runs all over the Faire grounds, so look around for him. He carries only one {item:11027} at a time and restocks it about every 30 minutes: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "暗月马戏团来到当地时，{npc:14860} 会出售两种青蛙（每种 1 金币）；无限目前尚未出现马戏团。在经典旧世中，马戏团一个月在 {zone:1429} 的 {area:87} 南侧，次月则在 {zone:1412} 的 {zone:1456} 附近；去当前开放的那一处。{npc:14860} 会在马戏团场地内四处跑动，需要找一找。他一次只有一个 {item:11027}，约每 30 分钟补货：没货就说明刚被人买走。使用每个宠物物品后即可学会召唤对应的小伙伴；之后目标仍会保持勾选。",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}，1金",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}，1金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "暗月马戏团在场时，{npc:14860}出售两种青蛙（各1金）。在经典旧世中，马戏团一个月驻扎在{zone:1429}的{area:87}南边，下个月则在{zone:1412}的{zone:1456}附近；去正在开放的那一处。使用每件宠物物品即可学会对应的小伙伴；之后目标仍保持勾选。",
}
