-- Korean (koKR): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "아라시 분지 평판",
	["Every 200 resources your team gathers pays it; Exalted gives a Legacy Point, epic shoulders and the tabard."] = "",
	["Master of Arathi Basin: a Legacy Point at Exalted"] = "",

	-- Step 1: Refuge Pointe
	-- {zone:1461} Arathi Basin
	["{zone:1461} is a 15 against 15 battle over five bases, from level 20: hold bases to gather resources, and the first team to 2000 wins. Queue at any battlemaster in the capitals or from the battleground screen. In Classic every 200 resources your team gathers pay everyone 10 reputation, so a win pays 100 and a close loss nearly as much; a game also pays 3 Arathi Basin Marks of Honor for a win, 1 for a loss. The three quests here pay 500 reputation together (200, 200 and 100), once. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "",
	-- {npc:14983} Field Marshal Oslight
	["{npc:14983}: assault four bases, 200"] = "",
	-- {npc:14984} Sergeant Maclear
	["{npc:14984}: one mark, 200"] = "",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: three marks, 100"] = "",

	-- Step 2: Arathi Basin
	-- {npc:14984} Sergeant Maclear · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:14984}, three for the Brigadier General. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "",
	["Assault the Mine banner"] = "",
	-- {area:3422} Lumber Mill
	["Assault the {area:3422} banner"] = "",
	["Assault the Blacksmith banner"] = "",
	["Assault the Farm banner"] = "",
	-- {item:20559} Arathi Basin Mark of Honor
	["one {item:20559}"] = "",
	["three more marks"] = "",

	-- Step 3: Back to Refuge Pointe
	-- {area:320} Refuge Pointe
	["Back to {area:320}"] = "",
	["hand in the three marks first"] = "",

	-- Step 4: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "아라소르 연맹: 약간 우호적까지",
	-- {quest:8374} Claiming Arathi Basin · {area:320} Refuge Pointe
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Brigadier General ({quest:8374}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:320} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Brigadier General."] = "",
	-- {npc:15351} Alliance Brigadier General · {quest:8374} Claiming Arathi Basin
	["{npc:15351}: {quest:8374} again, 50 reputation for 3 marks"] = "",

	-- Step 5: Control Four Bases
	-- {npc:14983} Field Marshal Oslight · {quest:8115} Control Five Bases
	["At level 60 and Friendly, {npc:14983} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8115} for Exalted."] = "",
	["four bases held at once"] = "",

	-- Step 6: League of Arathor to Honored
	["League of Arathor to Honored"] = "아라소르 연맹: 우호적까지",
	-- {npc:15127} Samuel Hawke · {npc:14983} Field Marshal Oslight · {item:20071} Talisman of Arathor · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15127} beside {npc:14983}: the {item:20071} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Arathor care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Friendly rewards"] = "",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 50 reputation for 3 marks"] = "",

	-- Step 7: League of Arathor to Revered
	["League of Arathor to Revered"] = "아라소르 연맹: 매우 우호적까지",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Highlander's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (72s to 8g84s)."] = "",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Honored rewards"] = "",

	-- Step 8: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "아라소르 연맹: 확고한 동맹까지",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Highlander's boots and greaves for levels 28 to 58 (1g7s to 13g65s), the ones with the run-speed bonus."] = "",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Revered rewards"] = "",

	-- Step 9: Samuel Hawke
	-- {item:20073} Cloak of the Honor Guard · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Highlander's shoulders in every armor type (12g33s to 18g50s), {item:20073} (12g14s), {item:20069} (55g10s) and Sageclaw (44g24s), both from level 55."] = "",
	-- {npc:15127} Samuel Hawke
	["{npc:15127}: Exalted rewards"] = "",

	-- Step 10: Control Five Bases
	-- {npc:14983} Field Marshal Oslight · {item:20132} Arathor Battle Tabard
	["At Exalted, {npc:14983} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20132}, the only way to get it."] = "",
	["all five bases held at once"] = "",

	-- Step 11: Hammerfall
	-- {npc:15021} Deathmaster Dwire
	["{npc:15021}: assault four bases, 200"] = "",
	-- {npc:15022} Deathstalker Mortis
	["{npc:15022}: one mark, 200"] = "",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: three marks, 100"] = "",

	-- Step 12: Arathi Basin
	-- {npc:15022} Deathstalker Mortis · {zone:1461} Arathi Basin
	["Assaulting a base means clicking its banner until it turns: you need not hold it. Four marks in all: one for {npc:15022}, three for the Warbringer. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1461} marks: hand in or spend them before you reach that."] = "",
	["Assault the Stables banner"] = "",

	-- Step 13: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "{area:321}(으)로 돌아가기",

	-- Step 14: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510}: 약간 우호적까지",
	-- {quest:8370} Conquering Arathi Basin · {area:321} Hammerfall
	["Neutral to Friendly is 3000 reputation. In Classic a win paid 100 and its 3 marks bring 50 more at the Warbringer ({quest:8370}, again and again): about 150 a win, some 20 wins. Forever has not published its battleground rates, so count the games as a rough guide. Below level 50 the quests at {area:321} come in a version for your bracket (from level 20): 200 for assaulting the bases, 200 for one mark, then 100 and 50 per 3 marks at the Warbringer."] = "",
	-- {npc:15350} Horde Warbringer · {quest:8370} Conquering Arathi Basin
	["{npc:15350}: {quest:8370} again, 50 reputation for 3 marks"] = "",

	-- Step 15: Take Four Bases
	-- {npc:15021} Deathmaster Dwire · {quest:8122} Take Five Bases
	["At level 60 and Friendly, {npc:15021} asks your team to hold four bases at the same time: 200 reputation, once. It opens {quest:8122} for Exalted."] = "",

	-- Step 16: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510}: 우호적까지",
	-- {npc:15126} Rutherford Twing · {npc:15021} Deathmaster Dwire · {item:20072} Defiler's Talisman · {zone:1461} Arathi Basin
	["Friendly to Honored is 6000 reputation, about 40 wins at the Classic rate. Friendly opens the first rewards at {npc:15126} beside {npc:15021}: the {item:20072} trinket for levels 28, 38, 48 and 58 (72s to 4g12s), and food and bandages that work in {zone:1461} (10s to 20s). He also gives one Defiler's care package at Friendly (pick the one for your level): 10 reputation and a bag of battleground food and bandages."] = "",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Friendly rewards"] = "",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 50 reputation for 3 marks"] = "",

	-- Step 17: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510}: 매우 우호적까지",
	["Honored to Revered is 12000 reputation, about 80 wins. Honored opens the Defiler's belts in plate, lamellar, chain, mail, leather, lizardhide and cloth for levels 28 to 58 (75s to 8g78s)."] = "",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Honored rewards"] = "",

	-- Step 18: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510}: 확고한 동맹까지",
	["Revered to Exalted is 21000 reputation, about 140 wins: half of the whole climb. Revered opens the Defiler's boots and greaves for levels 28 to 58 (1g12s to 13g41s), the ones with the run-speed bonus."] = "",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Revered rewards"] = "",

	-- Step 19: Rutherford Twing
	-- {item:20068} Deathguard's Cloak · {item:20069} Ironbark Staff
	["Exalted gives the Legacy Point \"Master of Arathi Basin\" and opens the epics: the level 60 Defiler's shoulders in every armor type (12g75s to 20g), {item:20068} (13g18s), {item:20069} (50g46s) and Mindfang (42g83s), both from level 55."] = "",
	-- {npc:15126} Rutherford Twing
	["{npc:15126}: Exalted rewards"] = "",

	-- Step 20: Take Five Bases
	-- {npc:15021} Deathmaster Dwire · {item:20131} Battle Tabard of the Defilers
	["At Exalted, {npc:15021} asks your team to hold all five bases at the same time. It pays 200 reputation and the {item:20131}, the only way to get it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the League of Arathor earns a Legacy Point."] = "아라소르 연맹과 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",
	-- ["Exalted with {faction:510} earns a Legacy Point."] = "{faction:510}와(과) 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "{zone:1461}을(를) 계속 플레이하세요. 전장 이벤트: {zone:1461} 주말에는 수도의 {npc:15350}이(가) 아라시 분지 명예 훈장 3개를 받고 추가 평판을 줍니다.",
	-- ["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "{zone:1461}을(를) 계속 플레이하세요. 전장 이벤트: {zone:1461} 주말에는 수도의 {npc:15351}이(가) 아라시 분지 명예 훈장 3개를 받고 추가 평판을 줍니다.",
	-- ["Keep playing {zone:1461}; wins with many bases held pay the most."] = "{zone:1461}을(를) 계속 플레이하십시오. 많은 거점을 지키며 승리할수록 가장 많은 평판을 얻습니다.",
	-- ["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509}은(는) {area:320}에서 {zone:1461}을(를) 두고 싸웁니다. 평판은 전장에서 얻습니다. 팀이 모은 자원만큼 모두에게 평판이 주어지므로, 더 많은 거점을 더 오래 지킬수록 더 많이 얻습니다. 아무 전투 관리인에게서나 대기열에 참가하십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510}은(는) {area:321}에서 {zone:1461}을(를) 두고 싸웁니다. 평판은 전장에서 얻습니다. 팀이 모은 자원만큼 모두에게 평판이 주어지므로, 더 많은 거점을 더 오래 지킬수록 더 많이 얻습니다. 아무 전투 관리인에게서나 대기열에 참가하십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "{npc:14983}의 {zone:1461}의 전투(모든 거점 공격)와 거점 네 곳 점령 / 거점 다섯 곳 점령은 한 번만 할 수 있는 퀘스트입니다. 그 옆의 {npc:14984}은(는) 아라시 보급품 상자를 받습니다.",
	-- ["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "{npc:15021}의 {zone:1461}의 전투(모든 거점 공격)와 거점 네 곳 점령 / 거점 다섯 곳 점령은 한 번만 할 수 있는 퀘스트입니다. 그 옆의 {npc:15022}은(는) 아라시 보급품 상자를 받습니다.",
	-- ["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126}이(가) 레벨에 따라 파멸단 구급품 하나를 줍니다",
	-- ["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127}이(가) 레벨에 따라 아라소르 구급품 하나를 줍니다",
}
