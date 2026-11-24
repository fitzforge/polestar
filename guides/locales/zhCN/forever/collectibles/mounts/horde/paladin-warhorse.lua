-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "圣骑士战马（被遗忘者）",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "40级获得的第一匹坐骑，可随时召唤：被遗忘者圣骑士无需买马，也无需向骑术训练师付费。",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "40级时，{zone:1458}的圣骑士训练师{npc:260093}会派你去{area:16602}找{npc:246378}。顺便在他那里学习新技能。已经在{area:16602}了？跳过此步：没有这个任务，{npc:246378}也会给你坐骑任务。",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}：40级技能",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602}位于提瑞斯法西部的悬崖上，{area:156}西北方：离开{zone:1458}，沿道路向西经过{area:159}。{npc:246378}在城堡内的楼上。",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "{area:16602}南门",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{area:16602}楼上的{npc:246378}在40级时提供{quest:94971}：接受后立即交还。它会同时教你{spell:1279399}和骑术，所以你不需要买马，也不需要骑术训练师。",
}
