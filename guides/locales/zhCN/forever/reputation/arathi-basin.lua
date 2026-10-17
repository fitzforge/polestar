-- Chinese (simplified) (zhCN): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "阿拉希盆地声望",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "阿拉索联军刷到友善",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509}从{area:320}出发争夺{zone:1461}。他们的声望来自战场：你的队伍收集的资源会给每个人声望，所以占领更多基地、坚守更久就给得更多。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "{npc:14983}的“{zone:1461}之战！”（突袭每座基地）以及“控制四座基地”/“控制五座基地”是一次性任务；他旁边的{npc:14984}收取{item:19725}。",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "阿拉索联军刷到尊敬",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "继续打{zone:1461}。在{zone:1461}战斗召集周末，主城里的{npc:15351}收取三枚阿拉希盆地荣誉奖章以给予额外声望。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127}按等级发放一个阿拉索补给包",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "阿拉索联军刷到崇敬",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "继续打{zone:1461}；占领许多基地的胜利给得最多。",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "阿拉索联军刷到崇拜",
	["Exalted with the League of Arathor earns a Legacy Point."] = "阿拉索联军达到崇拜可获得1点传承点数。",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510}刷到友善",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510}从{area:321}出发争夺{zone:1461}。他们的声望来自战场：你的队伍收集的资源会给每个人声望，所以占领更多基地、坚守更久就给得更多。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "{npc:15021}的“{zone:1461}之战！”（突袭每座基地）以及“夺取四座基地”/“夺取五座基地”是一次性任务；他旁边的{npc:15022}收取{item:19725}。",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510}刷到尊敬",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "继续打{zone:1461}。在{zone:1461}战斗召集周末，主城里的{npc:15350}收取三枚阿拉希盆地荣誉奖章以给予额外声望。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126}按等级发放一个污染者补给包",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510}刷到崇敬",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510}刷到崇拜",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "{faction:510}达到崇拜可获得1点传承点数。",
}
