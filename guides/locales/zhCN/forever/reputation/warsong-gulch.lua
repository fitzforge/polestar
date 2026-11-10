-- Chinese (simplified) (zhCN): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "战歌峡谷声望",
	["Flag captures and Marks of Honor raise it; Exalted gives a Legacy Point and epic bracers and legs."] = "夺旗和荣誉奖章可提升声望；崇拜可获得1点传承点数以及史诗护腕和腿甲。",
	["Master of Warsong Gulch: a Legacy Point at Exalted"] = "战歌峡谷大师：崇拜时获得1点传承点数",

	-- Step 1: Sentinel Farsong
	-- {zone:1460} Warsong Gulch · {npc:14733} Sentinel Farsong
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14733} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1460} 是 10 对 10 的夺旗战场，10 级起可参加。在主城任意战场军官处，或从战场界面排队。经典怀旧服中，队伍每夺得一面旗，所有队员都获得 35 点声望（{zone:1460} 战场节日周末为 45 点）；每场获胜奖励 3 枚战歌峡谷荣誉奖章，失败奖励 1 枚。{npc:14733} 会收取一枚奖章，奖励 200 点声望，每个角色仅一次：这是你能交出的最划算的一枚奖章。无限的传承天赋“外交家”使本指南的每项数值最多额外提高 10%。",
	-- {item:20558} Warsong Gulch Mark of Honor
	["one {item:20558}: play a game"] = "一枚 {item:20558}：打一场战场。",

	-- Step 2: Alliance Brigadier General
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch · {area:3319} Silverwing Grove · {npc:14733} Sentinel Farsong · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1460} Warsong Gulch
	["The {npc:15351} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8372}). One stands right here at {area:3319} beside {npc:14733}; others in {zone:1453}, {zone:1455} and {zone:1457}, at {area:320} in the {zone:1417} and at both gates of {zone:1459}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "{npc:15351} 首次接受 3 枚战歌峡谷荣誉奖章时，会提供 100 点声望，之后每 3 枚提供 50 点（{quest:8372}）。这里 {area:3319} 的 {npc:14733} 旁就有一位；其他人在 {zone:1453}、{zone:1455} 和 {zone:1457}，以及 {zone:1417} 的 {area:320} 和 {zone:1459} 两侧大门处。无限的 PvP 装备除了荣誉外也需要荣誉奖章：交还前先决定想换什么。你最多只能携带 30 枚 {zone:1460} 奖章：达到上限前就要交还或花掉。",
	["three Warsong Gulch Marks of Honor"] = "三枚战歌峡谷荣誉奖章",

	-- Step 3: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890}刷到友善",
	-- {npc:14733} Sentinel Farsong · {quest:8372} Fight for Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Brigadier General: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14733}'s one-mark quest and the Brigadier General's {quest:8372} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "中立到友善需要3000声望。经典旧世中，以夺旗3次获胜奖励105，其3枚奖章在准将处还能换50：每胜约155，因此约需20胜。即使失败，小队每夺取一面旗帜仍奖励35。无限未公布战场声望倍率，因此场次数量仅供粗略参考。50级以下，{npc:14733}的单枚奖章任务和准将的{quest:8372}会提供对应等级段版本（分别从20级和10级起）：一次性200，之后每3枚奖章分别奖励100和50。",
	-- {npc:15351} Alliance Brigadier General · {quest:8372} Fight for Warsong Gulch
	["{npc:15351}: {quest:8372} again, 50 reputation for 3 marks"] = "{npc:15351}：再次交还 {quest:8372}，3 枚奖章换 50 点声望",

	-- Step 4: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890}刷到尊敬",
	-- {npc:14753} Illiyana Moonblaze · {npc:14733} Sentinel Farsong · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14753} beside {npc:14733}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). She also gives one Sentinel care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "友善到尊敬需要6000声望，按经典版速率约赢39场。友善时，{npc:14733}旁的{npc:14753}开放首批奖励：饰品{item:21567}和{item:21565}（20级版2金币，40级版4金币），以及战场内可用的食物、绷带和饮剂（5银到20银）。友善时她还会给一个哨兵补给包（选适合自身等级的）：奖励10声望，以及一袋战场食物和绷带。",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Friendly rewards"] = "{npc:14753}：友善奖励",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}：3枚徽章换50声望",

	-- Step 5: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890}刷到崇敬",
	-- {item:19530} Caretaker's Cape · {item:19538} Sentinel's Medallion · {item:19522} Lorekeeper's Ring · {item:19514} Protector's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19530} (cloak), {item:19538} (neck), {item:19522} and {item:19514}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 8g55s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "从尊敬到崇敬需要12000声望，大约78场胜利。尊敬后可购买 {item:19530}（披风）、{item:19538}（项链）、{item:19522} 和 {item:19514}，每件都有18、28、38、48和58级版本（披风36银50铜至8金币55银币，其余2金币至7金币50银币），以及特效治疗药膏和特效法力药膏（10银币）。",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Honored rewards"] = "{npc:14753}：尊敬奖励",

	-- Step 6: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890}刷到崇拜",
	-- {item:19546} Sentinel's Blade · {item:19554} Protector's Sword · {item:19562} Outrunner's Bow · {item:19570} Lorekeeper's Staff
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19546} (dagger), {item:19554}, {item:19562} and {item:19570} (91s to 35g61s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Sentinel Nightsaber mount (level 25, 10g) with no standing listed."] = "崇敬到崇拜需要21000声望，约赢136场：占整个过程的一半。崇敬时开放18到58级的武器：{item:19546}（匕首）、{item:19554}、{item:19562}和{item:19570}（91银到35金61银）。无限服军需官还出售这四种武器的25级版本、20级头部装备（坚韧的布质头带、坚韧的皮甲面具或坚韧的锁甲头盔，各2金50银），以及新手的哨兵夜刃豹坐骑（25级，10金币），未列出声望要求。",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753}: Revered rewards"] = "{npc:14753}：崇敬奖励",

	-- Step 7: Illiyana Moonblaze
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19506} Silverwing Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Sentinel's legs in plate, lamellar, chain, leather, lizardhide and silk (16g63s to 24g22s). The {item:19506} is 5g."] = "崇拜可获得传承点数“战歌峡谷主宰”，并解锁史诗装备：40、50和60级的{item:19578}（板甲）、{item:19582}（锁甲）、{item:19587}（皮甲）和{item:19595}（布甲）（2金47银到12金11银），以及60级哨兵腿甲，分为板甲、层叠板甲、链甲、皮甲、蜥蜴皮和丝质款式（16金63银到24金22银）。{item:19506}售价5金币。",
	-- {item:19506} Silverwing Battle Tabard
	["{item:19506}, 5g"] = "{item:19506}，5金币",

	-- Step 8: Captain Shatterskull
	-- {zone:1460} Warsong Gulch · {area:1599} Mor'shan Base Camp · {npc:14781} Captain Shatterskull
	["{zone:1460} is a 10 against 10 capture-the-flag battle, from level 10. Queue at any battlemaster in the capitals or from the battleground screen; the Horde gate is here at {area:1599}. In Classic every flag your team captures pays everyone 35 reputation (45 on the {zone:1460} holiday weekend), and a game pays 3 Warsong Gulch Marks of Honor for a win, 1 for a loss. {npc:14781} pays 200 reputation for one mark, once per character: the best mark you will ever turn in. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1460} 是 10 对 10 的夺旗战场，10 级起即可参加。可向主城内任意战场军官报名，或从战场界面排队；部落入口就在这里的 {area:1599}。经典旧世中，己方每夺取一面旗帜，全队每人获得 35 点声望（{zone:1460} 节日周末为 45 点），每场胜利奖励 3 枚战歌峡谷荣誉奖章，失败奖励 1 枚。{npc:14781} 每个角色可用一枚奖章一次性换取 200 点声望：这是最划算的一次交还。无限的传承天赋“外交家” 特权可让本指南中每个数值最多提高 10%。",

	-- Step 9: Horde Warbringer
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {area:321} Hammerfall · {zone:1417} Arathi Highlands · {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {zone:1460} Warsong Gulch
	["The {npc:15350} pays 100 reputation for 3 Warsong Gulch Marks of Honor the first time, then 50 for every 3 more ({quest:8368}). One stands right here at Mor'shan; others in {zone:1454}, {zone:1456} (and on the plain below it) and the {zone:1458}, at {area:321} in the {zone:1417} and at the {zone:1459} gate in the {zone:1416}. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1460} marks: hand in or spend them before you reach that."] = "向{npc:15350}首次交还3枚战歌峡谷荣誉奖章可获100声望，之后每3枚奖励50声望（{quest:8368}）。莫尔杉这里就有一位；其他位于{zone:1454}、{zone:1456}（及其下方平原）、{zone:1458}、{zone:1417}的{area:321}，以及{zone:1416}的{zone:1459}大门旁。无限服PvP装备除荣誉外也消耗荣誉奖章：交还前先决定要买什么。{zone:1460}奖章最多携带30枚：达到上限前及时交还或花掉。",

	-- Step 10: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889}刷到友善",
	-- {npc:14781} Captain Shatterskull · {quest:8368} Battle of Warsong Gulch
	["Neutral to Friendly is 3000 reputation. In Classic a 3-capture win paid 105, and its 3 marks bring 50 more at the Warbringer: about 155 a win, so some 20 wins. Losses still pay 35 for each flag your team captured. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50, {npc:14781}'s one-mark quest and the Warbringer's {quest:8368} come in a version for your bracket (from 20 and from 10): 200 once, then 100 and 50 per 3 marks."] = "从中立到友善需要3000点声望。经典版中，夺旗3次获胜可得105点，3枚奖章交给战争使者还能获得50点：每次胜利约155点，因此约需20胜。失败时，己方每次成功夺旗仍可获得35点。无限服尚未公布战场声望倍率，因此场次只能作为粗略参考。50级以下时，{npc:14781} 的单枚奖章任务和战争使者的 {quest:8368} 会提供适合你等级段的版本（分别从20级和10级开始）：首次200点，之后每3枚奖章首次100点、后续每次50点。",
	-- {npc:15350} Horde Warbringer · {quest:8368} Battle of Warsong Gulch
	["{npc:15350}: {quest:8368} again, 50 reputation for 3 marks"] = "{npc:15350}：再次交还 {quest:8368}，3 枚奖章换 50 点声望",

	-- Step 11: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889}刷到尊敬",
	-- {npc:14754} Kelm Hargunth · {npc:14781} Captain Shatterskull · {item:21567} Rune of Duty · {item:21565} Rune of Perfection
	["Friendly to Honored is 6000 reputation, about 39 wins at the Classic rate. Friendly opens the first rewards at {npc:14754} beside {npc:14781}: the {item:21567} and {item:21565} trinkets (2g at level 20, 4g at level 40) and food, bandages and draughts that work in the battleground (5s to 20s). He also gives one Outrider care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "友善到尊敬需要 6000 点声望，按经典怀旧服的获取速度约需获胜 39 次。友善后可在 {npc:14781} 身边的 {npc:14754} 处购买首批奖励：饰品 {item:21567} 和 {item:21565}（20 级 2 金币，40 级 4 金币），以及战场内可用的食物、绷带和药剂（5 至 20 银币）。友善时，他还会给予一份战歌侍从补给包（选适合自己等级的）：奖励 10 点声望，以及一袋战场食物和绷带。",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Friendly rewards"] = "{npc:14754}：友善奖励",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}：3枚徽章换50声望",

	-- Step 12: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889}刷到崇敬",
	-- {item:19526} Battle Healer's Cloak · {item:19534} Scout's Medallion · {item:19518} Advisor's Ring · {item:19510} Legionnaire's Band
	["Honored to Revered is 12000 reputation, about 78 wins. Honored opens the {item:19526}, {item:19534} (neck), {item:19518} and {item:19510}, each sold for levels 18, 28, 38, 48 and 58 (cloak 36s50c to 9g6s, the rest 2g to 7g50s), and the Major Healing and Mana Draughts (10s)."] = "从尊敬到崇敬需要12000点声望，约78次胜利。尊敬可解锁 {item:19526}、{item:19534}（项链）、{item:19518} 和 {item:19510}，每种均有18、28、38、48及58级版本出售（披风36银币50铜币至9金币6银币，其余2金币至7金币50银币），以及特效治疗和法力药膏（10银币）。",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Honored rewards"] = "{npc:14754}：尊敬奖励",

	-- Step 13: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889}刷到崇拜",
	-- {item:19542} Scout's Blade · {item:19550} Legionnaire's Sword · {item:19558} Outrider's Bow · {item:19566} Advisor's Gnarled Staff
	["Revered to Exalted is 21000 reputation, about 136 wins: half of the whole climb. Revered opens the weapons for levels 18 to 58: {item:19542} (dagger), {item:19550}, {item:19558} and {item:19566} (91s to 35g9s). Forever's quartermaster also sells level-25 versions of the four weapons, Resilient helms for level 20 (2g50s) and the Trainee's Outrider Wolf mount (level 25, 10g) with no standing listed."] = "崇敬到崇拜需要21000声望，约136场胜利：占整个提升过程的一半。崇敬后解锁18至58级武器：{item:19542}（匕首）、{item:19550}、{item:19558}和{item:19566}（91银至35金9银）。无限的军需官还出售这4种武器的25级版本、20级头部装备（坚韧的布质头带、坚韧的皮甲面具或坚韧的锁甲头盔，各2金50银）及 新手的护卫之狼 坐骑（25级，10金币），未列出声望等级要求。",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754}: Revered rewards"] = "{npc:14754}：崇敬奖励",

	-- Step 14: Kelm Hargunth
	-- {item:19578} Berserker Bracers · {item:19582} Windtalker's Wristguards · {item:19587} Forest Stalker's Bracers · {item:19595} Dryad's Wrist Bindings · {item:19505} Warsong Battle Tabard
	["Exalted gives the Legacy Point \"Master of Warsong Gulch\" and opens the epics: {item:19578} (plate), {item:19582} (mail), {item:19587} (leather) and {item:19595} (cloth) for levels 40, 50 and 60 (2g47s to 12g11s), and the level 60 Outrider's legs in plate, chain, mail, leather, lizardhide and silk (16g57s to 25g33s). The {item:19505} is 5g."] = "崇拜后可获得传承点数“战歌峡谷主宰”，并解锁史诗装备：适用于 40、50 和 60 级的 {item:19578}（板甲）、{item:19582}（锁甲）、{item:19587}（皮甲）和 {item:19595}（布甲）（2 金 47 银至 12 金 11 银），以及 60 级的侦察骑兵护腿，分为板甲、链甲、锁甲、皮甲、蜥蜴皮和丝质（16 金 57 银至 25 金 33 银）。{item:19505} 售价 5 金。",
	-- {item:19505} Warsong Battle Tabard
	["{item:19505}, 5g"] = "{item:19505}，5金币",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:889} earns a Legacy Point."] = "{faction:889}达到崇拜可获得1点传承点数。",
	-- ["Exalted with the {faction:890} earns a Legacy Point."] = "{faction:890}达到崇拜可获得1点传承点数。",
	-- ["Keep capturing flags in {zone:1460}."] = "继续在{zone:1460}夺旗。",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "继续打{zone:1460}并夺旗。在{zone:1460}战斗召集周末，主城里的{npc:15350}收取三枚战歌峡谷荣誉奖章以给予额外声望。",
	-- ["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "继续打{zone:1460}并夺旗。在{zone:1460}战斗召集周末，主城里的{npc:15351}收取三枚战歌峡谷荣誉奖章以给予额外声望。",
	-- ["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889}是在{zone:1440}伐木的兽人。他们的声望来自战场：你的队伍每夺取一面敌方旗帜都会给全队声望。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- ["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890}是守卫{zone:1460}的暗夜精灵。他们的声望来自战场：你的队伍每夺取一面敌方旗帜都会给全队声望。在任何战场军官处排队。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733}收取战歌峡谷荣誉奖章，用于“击败入侵者！”，每个等级段一次（数据）；请在游戏中确认。",
	-- ["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753}按等级发放一个哨兵护理包",
	-- ["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754}按等级发放一个斥候护理包",
	-- ["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781}收取战歌峡谷荣誉奖章，用于“镇压银翼部队”，每个等级段一次（数据）；请在游戏中确认。",
}
