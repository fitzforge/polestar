-- Korean (koKR): the guide forever/collectibles/mounts/neutral/deathcharger (forever/collectibles/mounts/neutral/deathcharger.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Deathcharger"] = "죽음의 군마",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "수습 {skill:762}",
	-- {item:13335} Deathcharger's Reins · {skill:762} Riding
	["{item:13335} needs level 60 and Journeyman {skill:762} to ride (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "{item:13335}을(를) 타려면 60레벨과 수습 {skill:762}이(가) 필요합니다(Forever 클라이언트). 종족의 탈것 상급자에게서 수련하십시오. 60레벨 탈것 가이드를 참고하십시오.",

	-- Step 2: Stratholme: Baron Rivendare
	-- {area:2279} Stratholme · {object:175461} Service Entrance · {object:175440} Elders' Square · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare
	["{area:2279} is a group of five, level 58-60. The {object:175461} at {object:175440}, in north-western {zone:1423}, leads to the undead side; {npc:10440} waits in the Slaughter House at its end. Our data gives the reins a 0.02% drop chance (pfQuest, Era): one in about five thousand kills. Nothing shows Forever changing it."] = "{area:2279}은(는) 5인 파티용, 58-60레벨입니다. {zone:1423} 북서쪽 {object:175440}의 {object:175461}이(가) 언데드 구역으로 이어지며, {npc:10440}은(는) 그 끝의 도살장에 있습니다. 저희 데이터상 고삐의 획득 확률은 0.02%입니다(pfQuest, Era). 약 5천 번 처치에 한 번입니다. Forever에서 바뀌었다는 정보는 없습니다.",
	-- {object:175461} Service Entrance
	["Stratholme {object:175461}"] = "스트라솔름 {object:175461}",
}
