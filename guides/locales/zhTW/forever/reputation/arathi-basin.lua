-- Chinese (traditional) (zhTW): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "阿拉希盆地聲望",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "你的隊伍每收集200資源就會給予聲望；達到崇拜可獲得1點傳承點數、史詩護肩和戰袍。",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "阿拉希盆地大師：達到崇拜獲得1點傳承點數",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1461}是15對15、圍繞五座基地的戰場，20級起可進：佔領基地以採集資源，先到2000點的一方獲勝。可在任意主城的戰場軍官處排隊，或用戰場介面排隊。原版中你的隊伍每採集200點資源，全隊每人得10聲望，所以一場勝利給100，惜敗也差不多；一場勝利還給3枚阿拉希盆地榮譽徽記，失敗給1枚。這裡的三個任務合計給500聲望（200、200和100），僅一次。Forever的傳承專長“外交家”會使本攻略中的所有數值最多增加10%。",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "{npc:14983}：突襲四座基地，200",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "{npc:14984}：一枚徽記，200",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "{npc:15351}：三枚徽記，100",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "突襲基地就是點選它的旗幟直到旗幟變色：你不需要守在那裡。總共四枚徽記：一枚交給{npc:14984}，三枚交給准將。Forever的PvP裝備除了榮譽還要花榮譽徽記：交之前先想好想要什麼。你最多隻能攜帶30枚{zone:1461}徽記：在達到上限前交掉或用掉。",
	["Assault the Mine banner"] = "突襲礦洞旗幟",
	-- {area:3422} Lumber Mill
	["Assault the {area:3422} banner"] = "突襲{area:3422}旗幟",
	["Assault the Blacksmith banner"] = "突襲鐵匠鋪旗幟",
	["Assault the Farm banner"] = "突襲農場旗幟",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "一個{item:20559}",
	["three more marks"] = "再交三枚徽記",

	-- Step 3: Back to Refuge Pointe
	-- {area:320} Refuge Pointe
	["Back to {area:320}"] = "回到{area:320}",
	["hand in the three marks first"] = "先交三枚徽記",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "阿拉索聯軍到友好",
	-- {quest:8374} Claiming Arathi Basin · {area:320} Refuge Pointe
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "中立到友善需要3000聲望。原版中一場勝利給100，3枚徽記在准將處（{quest:8374}，可反覆交）再換50：每場約150，約20場。Forever沒有公佈戰場聲望速率，所以把場次當作粗略參考。50級以下時，{area:320}的任務會提供適合你等級段的版本（20級起）：突襲各基地200，交一枚徽記200，之後在准將處每3枚徽記得100和50。",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "{npc:15351}：再次交{quest:8374}，3枚徽記換50聲望",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "60級且友善時，{npc:14983}要求你的隊伍同時佔領四座基地：200聲望，僅一次。它會解鎖崇拜階段的{quest:8115}。",
	["four bases held at once"] = "同時佔領四座基地",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "阿拉索聯軍到尊敬",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "友善到尊敬需要6000聲望，按原版速率約需40場勝利。友善會在{npc:14983}旁的{npc:15127}處開放首批獎勵：適用於28、38、48和58級的{item:20071}飾品（72銀到4金12銀），以及在{zone:1461}中可用的食物和繃帶（10銀到20銀）。他還會在友善時給一個阿拉索補給包（按你的等級挑選）：10聲望和一袋戰場食物與繃帶。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "{npc:15127}：友善獎勵",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "{npc:15351}：3枚徽記換50聲望",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "阿拉索聯軍到崇敬",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "尊敬到崇敬需要12000聲望，約需80場勝利。尊敬會開放高地人腰帶，包括板甲、鱗甲、鎖甲、鍊甲、皮甲、蜥蜴皮和布甲，適用於28到58級（72銀到8金84銀）。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "{npc:15127}：尊敬獎勵",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "阿拉索聯軍到崇拜",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "崇敬到崇拜需要21000聲望，約需140場勝利，佔整個爬升的一半。崇敬會開放高地人長靴和護脛，適用於28到58級（1金7銀到13金65銀），也就是帶移動速度加成的那幾件。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "{npc:15127}：崇敬獎勵",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "崇拜會給予傳承點數“阿拉希盆地大師”，並開放史詩獎勵：各甲種的60級高地人護肩（12金33銀到18金50銀）、{item:20073}（12金14銀）、{item:20069}（55金10銀）和賢者之爪（44金24銀），後兩件從55級起可買。",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "{npc:15127}：崇拜獎勵",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "崇拜時，{npc:14983}要求你的隊伍同時佔領全部五座基地。獎勵200聲望和{item:20132}，這是獲得它的唯一途徑。",
	["all five bases held at once"] = "同時佔領全部五座基地",

	-- Step 11: Hammerfall
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "{npc:15021}：突襲四座基地，200",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "{npc:15022}：一枚徽記，200",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "{npc:15350}：三枚徽記，100",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "突襲基地就是點選它的旗幟直到旗幟變色：你不需要守在那裡。總共四枚徽記：一枚交給{npc:15022}，三枚交給戰爭使者。Forever的PvP裝備除了榮譽還要花榮譽徽記：交之前先想好想要什麼。你最多隻能攜帶30枚{zone:1461}徽記：在達到上限前交掉或用掉。",
	["Assault the Stables banner"] = "突襲獸欄旗幟",

	-- Step 13: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "返回{area:321}",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510}到友好",
	-- {quest:8370} Conquering Arathi Basin · {area:321} Hammerfall
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "中立到友善需要3000聲望。原版中一場勝利給100，3枚徽記在戰爭使者處（{quest:8370}，可反覆交）再換50：每場約150，約20場。Forever沒有公佈戰場聲望速率，所以把場次當作粗略參考。50級以下時，{area:321}的任務會提供適合你等級段的版本（20級起）：突襲各基地200，交一枚徽記200，之後在戰爭使者處每3枚徽記得100和50。",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "{npc:15350}：再次交{quest:8370}，3枚徽記換50聲望",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "60級且友善時，{npc:15021}要求你的隊伍同時佔領四座基地：200聲望，僅一次。它會解鎖崇拜階段的{quest:8122}。",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510}到尊敬",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "友善到尊敬需要6000聲望，按原版速率約需40場勝利。友善會在{npc:15021}旁的{npc:15126}處開放首批獎勵：適用於28、38、48和58級的{item:20072}飾品（72銀到4金12銀），以及在{zone:1461}中可用的食物和繃帶（10銀到20銀）。他還會在友善時給一個汙染者補給包（按你的等級挑選）：10聲望和一袋戰場食物與繃帶。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "{npc:15126}：友善獎勵",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "{npc:15350}：3枚徽記換50聲望",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510}到崇敬",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "尊敬到崇敬需要12000聲望，約需80場勝利。尊敬會開放汙染者腰帶，包括板甲、鱗甲、鎖甲、鍊甲、皮甲、蜥蜴皮和布甲，適用於28到58級（75銀到8金78銀）。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "{npc:15126}：尊敬獎勵",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510}到崇拜",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "崇敬到崇拜需要21000聲望，約需140場勝利，佔整個爬升的一半。崇敬會開放汙染者長靴和護脛，適用於28到58級（1金12銀到13金41銀），也就是帶移動速度加成的那幾件。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "{npc:15126}：崇敬獎勵",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "崇拜會給予傳承點數“阿拉希盆地大師”，並開放史詩獎勵：各甲種的60級汙染者護肩（12金75銀到20金）、{item:20068}（13金18銀）、{item:20069}（50金46銀）和心靈之牙（42金83銀），後兩件從55級起可買。",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "{npc:15126}：崇拜獎勵",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "崇拜時，{npc:15021}要求你的隊伍同時佔領全部五座基地。獎勵200聲望和{item:20131}，這是獲得它的唯一途徑。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "與阿拉索聯軍達到崇拜可獲得1點傳承點數。",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "與{faction:510}達到崇拜可獲得1點傳承點數。",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "繼續打{zone:1461}。在「作戰召集：{zone:1461}」週末，各主城的{npc:15350}會收取三枚阿拉希盆地榮譽獎章，換取額外聲望。",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "繼續打{zone:1461}。在「作戰召集：{zone:1461}」週末，各主城的{npc:15351}會收取三枚阿拉希盆地榮譽獎章，換取額外聲望。",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "繼續打{zone:1461}；佔領很多基地的勝利給的聲望最多。",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509}從{area:320}為{zone:1461}而戰。他們的聲望來自戰場：你的隊伍收集的資源會給每個人聲望，所以佔領越多基地、越久，聲望就越多。在任何戰場軍官處排隊。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510}從{area:321}為{zone:1461}而戰。他們的聲望來自戰場：你的隊伍收集的資源會給每個人聲望，所以佔領越多基地、越久，聲望就越多。在任何戰場軍官處排隊。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "{npc:14983}的「{zone:1461}之戰！」（突襲每座基地）以及「控制四座基地」/「控制五座基地」是一次性任務；他旁邊的{npc:14984}收取阿拉希資源箱。",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "{npc:15021}的「{zone:1461}之戰！」（突襲每座基地）以及「奪取四座基地」/「奪取五座基地」是一次性任務；他旁邊的{npc:15022}收取阿拉希資源箱。",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126}依等級發放一個汙染者醫療包",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127}依等級發放一個阿拉索醫療包",
}
