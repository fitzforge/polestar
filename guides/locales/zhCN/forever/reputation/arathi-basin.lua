-- Chinese (simplified) (zhCN): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "阿拉希盆地声望",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "你的队伍每收集200资源就会给予声望；达到崇拜可获得1点传承点数、史诗护肩和战袍。",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "阿拉希盆地大师：达到崇拜获得1点传承点数",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1461} 是20级起可参与的15对15战场，围绕五座基地展开：占领基地以收集资源，率先达到2000资源的队伍获胜。可找主城内任意战场军官或通过战场界面排队。经典版中，己方每收集200资源，每人获得10点声望，因此胜利可得100点，比分接近的失败也几乎一样；每局获胜奖励3枚阿拉希盆地荣誉奖章，失败奖励1枚。这里的三个一次性任务合计奖励500点声望（200、200和100）。无限服的传承天赋“外交家” 特长可让本指南中的所有声望数值最多提高10%。",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "{npc:14983}：突袭四处基地，200 点声望。",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "{npc:14984}：一枚奖章，200 点声望",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "{npc:15351}：三枚奖章，100 点声望",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "突袭据点就是点击旗帜直到它转变：无需守住。总共需4枚奖章：1枚交给{npc:14984}，3枚交给准将。无限的 PvP 装备除了荣誉，也需要荣誉奖章：交还前先想好要买什么。最多携带30枚{zone:1461}奖章：达到上限前先交还或花掉。",
	["Assault the Mine banner"] = "突袭矿洞旗帜",
	-- {area:3422} Lumber Mill
	["Assault the {area:3422} banner"] = "突袭 {area:3422} 的旗帜",
	["Assault the Blacksmith banner"] = "突袭铁匠铺旗帜",
	["Assault the Farm banner"] = "突袭农场旗帜",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "一枚 {item:20559}",
	["three more marks"] = "再收集3枚奖章",

	-- Step 3: Back to Refuge Pointe
	-- {area:320} Refuge Pointe
	["Back to {area:320}"] = "返回{area:320}",
	["hand in the three marks first"] = "先交还三枚奖章",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "阿拉索联军刷到友善",
	-- {quest:8374} Claiming Arathi Basin · {area:320} Refuge Pointe
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "从中立到友善需要3000点声望。经典版中，胜利奖励100点，3枚奖章交给准将还能获得50点（{quest:8374}，可反复交还）：每次胜利约150点，约需20胜。无限服尚未公布战场声望倍率，因此场次只能作为粗略参考。50级以下时，{area:320} 的任务会提供适合你等级段的版本（20级起）：突袭基地奖励200点，首枚奖章奖励200点，之后准将每收取3枚奖章，首次奖励100点，后续每次50点。",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "{npc:15351}：再次交还 {quest:8374}，3 枚奖章换 50 点声望",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "60级且声望友善时，{npc:14983}会要求己方同时控制四个据点：一次性奖励200声望。完成后会解锁崇拜任务{quest:8115}。",
	["four bases held at once"] = "同时控制四处基地。",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "阿拉索联军刷到尊敬",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "友善到尊敬需要 6000 点声望，按经典怀旧服的获取速度约需获胜 40 次。友善后可在 {npc:14983} 身边的 {npc:15127} 处购买首批奖励：适合 28、38、48 和 58 级的饰品 {item:20071}（72 银至 4 金 12 银），以及仅在 {zone:1461} 可用的食物和绷带（10 至 20 银币）。友善时，他还会给予一份阿拉索补给包（选适合自己等级的）：奖励 10 点声望，以及一袋战场食物和绷带。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "{npc:15127}：友善奖励",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}：3枚徽章换50声望",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "阿拉索联军刷到崇敬",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "从尊敬到崇敬需要12000点声望，约80次胜利。尊敬可解锁高地人的板甲、板层甲、链甲、锁甲、皮甲、蜥蜴皮和布甲腰带，适用于28到58级（72银币至8金币84银币）。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "{npc:15127}：尊敬奖励",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "阿拉索联军刷到崇拜",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "从崇敬到崇拜需要21000点声望，约140次胜利：相当于整个声望进程的一半。崇敬可解锁适用于28到58级的高地人长靴和胫甲（1金币7银币至13金币65银币），它们附带奔跑速度加成。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "{npc:15127}：崇敬奖励",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "崇拜后可获得传承点数“阿拉希盆地主宰”，并解锁史诗装备：所有护甲类型的 60 级高地肩甲（12 金 33 银至 18 金 50 银）、{item:20073}（12 金 14 银）、{item:20069}（55 金 10 银）和先知之爪（44 金 24 银），后两者均要求 55 级。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "{npc:15127}：崇拜奖励",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "达到崇拜后，{npc:14983} 会要求你的队伍同时占据全部五个基地。奖励200声望和 {item:20132}，这是取得该物品的唯一途径。",
	["all five bases held at once"] = "同时控制全部5处据点",

	-- Step 11: Hammerfall
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "{npc:15021}：突袭四处基地，200 点声望。",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "{npc:15022}：一枚奖章，200 点声望",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "{npc:15350}：三枚奖章，100 点声望",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "突袭据点只需持续点击旗帜，直到旗帜变色，不必守住。总共需要四枚奖章：一枚交给 {npc:15022}，三枚交给战争使者。无限的 PvP 装备除了荣誉，还要消耗荣誉奖章：交还前先想好要买什么。{zone:1461} 的奖章最多只能携带 30 枚：达到上限前及时交还或花掉。",
	["Assault the Stables banner"] = "突袭兽栏旗帜",

	-- Step 13: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "回到{area:321}",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510}刷到友善",
	-- {quest:8370} Conquering Arathi Basin · {area:321} Hammerfall
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "从中立到友善需要 3000 点声望。经典旧世中，获胜提供 100 点，3 枚奖章可在战争使者处再换 50 点（{quest:8370}，可反复完成）：每胜一场约 150 点，大约需要 20 胜。无限尚未公布战场声望倍率，因此场数仅供粗略参考。50 级以下，{area:321} 的任务会提供适合你等级段的版本（20 级起）：突袭基地提供 200 点，一枚奖章提供 200 点，随后在战争使者处每 3 枚奖章先换 100 点、再换 50 点。",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "{npc:15350}：再次交还 {quest:8370}，3 枚奖章换 50 点声望",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "60级且声望友善时，{npc:15021}会要求己方同时控制四个据点：一次性奖励200声望。完成后会解锁崇拜任务{quest:8122}。",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510}刷到尊敬",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "从友善到尊敬需要 6000 点声望，按经典旧世倍率约需 40 胜。友善后，{npc:15021} 旁的 {npc:15126} 会解锁首批奖励：适用于 28、38、48 和 58 级的 {item:20072} 饰品（72 银至 4 金 12 银），以及可在 {zone:1461} 使用的食物和绷带（10 银至 20 银）。友善时他还会给一份污染者的医疗包（选择适合自己等级的一份）：奖励 10 点声望，以及一袋战场食物和绷带。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "{npc:15126}：友善奖励",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}：3枚徽章换50声望",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510}刷到崇敬",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "尊敬到崇敬需要12000声望，约80场胜利。尊敬后可购买28至58级的污染者腰带，有板甲、板层甲、链甲、锁甲、皮甲、蜥蜴皮和布甲（75银至8金78银）。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "{npc:15126}：尊敬奖励",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510}刷到崇拜",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "从崇敬到崇拜需要21000声望，大约140场胜利，占整个冲声望过程的一半。崇敬后可购买28至58级的 污染者的 靴子和护胫（1金币12银币至13金币41银币），就是带移动速度加成的那些。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "{npc:15126}：崇敬奖励",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "崇拜后可获得传承点数“阿拉希盆地主宰”，并解锁史诗装备：所有护甲类型的 60 级污染者肩甲（12 金 75 银至 20 金）、{item:20068}（13 金 18 银）、{item:20069}（50 金 46 银）和心灵之牙（42 金 83 银），后两者均要求 55 级。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "{npc:15126}：崇拜奖励",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "达到崇拜后，{npc:15021} 会要求你的队伍同时占据全部五个基地。奖励200声望和 {item:20131}，这是取得该物品的唯一途径。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "阿拉索联军达到崇拜可获得1点传承点数。",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "{faction:510}达到崇拜可获得1点传承点数。",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "继续打{zone:1461}。在{zone:1461}战斗召集周末，主城里的{npc:15350}收取三枚阿拉希盆地荣誉奖章以给予额外声望。",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "继续打{zone:1461}。在{zone:1461}战斗召集周末，主城里的{npc:15351}收取三枚阿拉希盆地荣誉奖章以给予额外声望。",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "继续打{zone:1461}；占领许多基地的胜利给得最多。",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509}从{area:320}出发争夺{zone:1461}。他们的声望来自战场：你的队伍收集的资源会给每个人声望，所以占领更多基地、坚守更久就给得更多。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510}从{area:321}出发争夺{zone:1461}。他们的声望来自战场：你的队伍收集的资源会给每个人声望，所以占领更多基地、坚守更久就给得更多。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "{npc:14983}的“{zone:1461}之战！”（突袭每座基地）以及“控制四座基地”/“控制五座基地”是一次性任务；他旁边的{npc:14984}收取{item:19725}。",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "{npc:15021}的“{zone:1461}之战！”（突袭每座基地）以及“夺取四座基地”/“夺取五座基地”是一次性任务；他旁边的{npc:15022}收取{item:19725}。",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126}按等级发放一个污染者补给包",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127}按等级发放一个阿拉索补给包",
}
