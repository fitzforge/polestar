-- Korean (koKR): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "성기사 군마 (포세이큰)",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "40레벨에 얻는 첫 탈것으로, 언제든 소환할 수 있습니다: 포세이큰 성기사는 말을 구매하지 않고 탈것 조련사에게 비용도 내지 않습니다.",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "40레벨이 되면 {zone:1458}의 성기사 훈련사 {npc:260093}이(가) {area:16602}의 {npc:246378}에게 보냅니다. 그곳에 있는 동안 새 주문을 배우세요. 이미 {area:16602}에 있나요? 이 단계를 건너뛰세요: {npc:246378}은(는) 이 퀘스트 없이도 탈것 퀘스트를 줍니다.",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}: 40레벨 주문",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602}은(는) 티리스팔 서쪽 절벽 위, {area:156} 북서쪽에 있습니다: {zone:1458}을(를) 나와 {area:159}을(를) 지나 서쪽 길을 따라가세요. {npc:246378}은(는) 성채 안 위층에 있습니다.",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "{area:16602} 남쪽 문",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{area:16602} 위층의 {npc:246378}이(가) 40레벨에 {quest:94971} 퀘스트를 줍니다: 수락하고 바로 완료하세요. {spell:1279399}와(과) 탈것 타기를 함께 배우므로 말도 탈것 조련사도 필요 없습니다.",
}
