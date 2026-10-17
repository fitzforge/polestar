-- Korean (koKR): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "아라시 분지 평판",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "아라소르 연맹: 약간 우호적까지",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509}은(는) {area:320}에서 {zone:1461}을(를) 두고 싸웁니다. 평판은 전장에서 얻습니다. 팀이 모은 자원만큼 모두에게 평판이 주어지므로, 더 많은 거점을 더 오래 지킬수록 더 많이 얻습니다. 아무 전투 관리인에게서나 대기열에 참가하십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "{npc:14983}의 {zone:1461}의 전투(모든 거점 공격)와 거점 네 곳 점령 / 거점 다섯 곳 점령은 한 번만 할 수 있는 퀘스트입니다. 그 옆의 {npc:14984}은(는) 아라시 보급품 상자를 받습니다.",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "아라소르 연맹: 우호적까지",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "{zone:1461}을(를) 계속 플레이하세요. 전장 이벤트: {zone:1461} 주말에는 수도의 {npc:15351}이(가) 아라시 분지 명예 훈장 3개를 받고 추가 평판을 줍니다.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127}이(가) 레벨에 따라 아라소르 구급품 하나를 줍니다",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "아라소르 연맹: 매우 우호적까지",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "{zone:1461}을(를) 계속 플레이하십시오. 많은 거점을 지키며 승리할수록 가장 많은 평판을 얻습니다.",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "아라소르 연맹: 확고한 동맹까지",
	["Exalted with the League of Arathor earns a Legacy Point."] = "아라소르 연맹과 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510}: 약간 우호적까지",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510}은(는) {area:321}에서 {zone:1461}을(를) 두고 싸웁니다. 평판은 전장에서 얻습니다. 팀이 모은 자원만큼 모두에게 평판이 주어지므로, 더 많은 거점을 더 오래 지킬수록 더 많이 얻습니다. 아무 전투 관리인에게서나 대기열에 참가하십시오. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "{npc:15021}의 {zone:1461}의 전투(모든 거점 공격)와 거점 네 곳 점령 / 거점 다섯 곳 점령은 한 번만 할 수 있는 퀘스트입니다. 그 옆의 {npc:15022}은(는) 아라시 보급품 상자를 받습니다.",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510}: 우호적까지",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "{zone:1461}을(를) 계속 플레이하세요. 전장 이벤트: {zone:1461} 주말에는 수도의 {npc:15350}이(가) 아라시 분지 명예 훈장 3개를 받고 추가 평판을 줍니다.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126}이(가) 레벨에 따라 파멸단 구급품 하나를 줍니다",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510}: 매우 우호적까지",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510}: 확고한 동맹까지",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "{faction:510}와(과) 확고한 동맹이 되면 유산 점수 1점을 얻습니다.",
}
