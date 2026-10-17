-- Korean (koKR): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water · {area:2577} Dire Maul
	["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "{area:2577} 도서관에서 얻는 레벨 60 {spell:10140}: 자신과 파티원을 위한 음료.",
	["Shen'dralar reputation"] = "셴드랄라 평판",

	-- Step 1: Lorekeeper Lydros
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "페더문 요새(얼라이언스) 또는 {area:1099}(호드)(으)로 비행한 뒤 {zone:1444} 중앙의 {area:2577}(으)로 달려가십시오. {npc:14368}은(는) 서쪽 구역(또는 {item:18249}이(가) 있으면 북쪽 구역)을 지나 도착하는 도서관에서 기다립니다.",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "히드로스폰",
	["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "물의 정령 히드로스폰은 굽이나무 지구(혈투의 전장 동쪽)에 있습니다. 임프 푸실린이 돌아서서 싸울 때까지 쫓은 뒤, 사티로스 방을 정리하고 나선형 경사로를 따라 웅덩이로 내려가세요.",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}: 히드로스폰",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "리드로스에게 돌아가기",
}
