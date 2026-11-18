-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "聖騎士戰馬（被遺忘者）",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "40級的第一隻坐騎，可隨時召喚：被遺忘者聖騎士不需要買馬，也不用付錢給騎術訓練師。",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "40級時，{zone:1458}的聖騎士訓練師{npc:260093}會讓你去{area:16602}找{npc:246378}。順便在他那裡學習新技能。已經在{area:16602}了？跳過這一步：沒有這個任務，{npc:246378}也會給你坐騎任務。",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}：40級技能",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602}位於提里斯法西部的懸崖上，{area:156}西北方：離開{zone:1458}，沿著道路向西經過{area:159}。{npc:246378}在城堡內的樓上。",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "{area:16602}南門",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{area:16602}樓上的{npc:246378}在40級時提供{quest:94971}：接受後立刻交回。它會同時教你{spell:1279399}和騎術，所以你不需要馬，也不需要騎術訓練師。",
}
