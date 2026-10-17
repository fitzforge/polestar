-- Chinese (simplified) (zhCN): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "战歌峡谷声望",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890}刷到友善",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890}是守卫{zone:1460}的暗夜精灵。他们的声望来自战场：你的队伍每夺取一面敌方旗帜都会给全队声望。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733}收取战歌峡谷荣誉奖章，用于“击败入侵者！”，每个等级段一次（数据）；请在游戏中确认。",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890}刷到尊敬",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "继续打{zone:1460}并夺旗。在{zone:1460}战斗召集周末，主城里的{npc:15351}收取三枚战歌峡谷荣誉奖章以给予额外声望。",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753}按等级发放一个哨兵护理包",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890}刷到崇敬",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "继续在{zone:1460}夺旗。",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890}刷到崇拜",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "{faction:890}达到崇拜可获得1点传承点数。",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889}刷到友善",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889}是在{zone:1440}伐木的兽人。他们的声望来自战场：你的队伍每夺取一面敌方旗帜都会给全队声望。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781}收取战歌峡谷荣誉奖章，用于“镇压银翼部队”，每个等级段一次（数据）；请在游戏中确认。",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889}刷到尊敬",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "继续打{zone:1460}并夺旗。在{zone:1460}战斗召集周末，主城里的{npc:15350}收取三枚战歌峡谷荣誉奖章以给予额外声望。",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754}按等级发放一个斥候护理包",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889}刷到崇敬",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889}刷到崇拜",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "{faction:889}达到崇拜可获得1点传承点数。",
}
