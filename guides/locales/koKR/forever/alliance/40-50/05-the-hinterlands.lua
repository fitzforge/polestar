-- Korean (koKR): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "남동쪽으로 {zone:1425} 남쪽에 있는 썩은가지부족의 계단식 신전 {area:355}(으)로 가서 꼭대기까지 올라가십시오. 문지기 퀴아가와 {npc:8636}(정예, 50)이(가) 그곳에 있습니다: 꼭대기에 닿으면 곧바로 내려오십시오.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "북쪽으로 {zone:1425} 한가운데의 {area:351}까지 가세요. 초록 진흙괴물과 비취 수액괴물이 그 주변 곳곳을 기어다닙니다.",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "귀환석으로 {area:348}에 가십시오.",
	["Hearthstone on cooldown? Ride back north-west."] = "귀환석이 재사용 대기 중이라면 북서쪽으로 돌아가십시오.",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "나중에 {area:1438}의 {quest:2990}에게",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "{area:348}에서 {area:42}(으)로 날아가십시오.",

	-- Step 6: The bloodmages
	["The bloodmages"] = "혈법사",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "동쪽으로 {zone:1430}을(를) 지나 {zone:1435}(으)로 간 다음, 길을 따라 남쪽 {zone:1419}(으)로 내려가십시오. 혈법사들의 야영지가 길가 첫 번째 장소입니다.",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "먼저 길을 따라 동쪽 요새로 가십시오: {item:6091}은(는) {area:42}에서 받은 지 1시간 후에 사라지는데, 혈법사들의 야수 사냥은 그보다 오래 걸립니다.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, 요새 꼭대기",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}의 다음 임무인 {item:9471}은(는) {area:978} 퀘스트입니다: 건너뛰십시오.",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "멧돼지와 바실리스크",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "잿빛갈기멧돼지와 붉은바위 바실리스크가 요새 남서쪽 비탈에 함께 있습니다. 더 남쪽의 지옥멧돼지는 52레벨이니 피하십시오.",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "스콜포크와 칼송곳니하이에나",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "서쪽으로 가십시오: 굶주린 칼송곳니하이에나가 혈법사 야영지 바로 남쪽의 메마른 언덕을 돌아다니고, 스콜포크 독침전갈(50레벨)이 북쪽 한가운데를 기어다닙니다. {npc:5982} 독수리가 그 위를 맴돕니다. 하나씩 끌어내십시오.",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "혈법사들의 두 번째 단계는 같은 재료에 경험치 없이 강화 아이템만 줍니다: 건너뛰십시오.",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "동쪽 {area:1438}(으)로 돌아가 {area:144}(으)로 날아가십시오.",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "호수 남쪽 기슭을 따라 동쪽 아이언밴드의 발굴현장으로 가십시오.",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "{area:1517} 발굴지",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "고개를 지나 남쪽 {zone:1418} 북쪽 끝으로 가십시오: 그곳 {area:1517} 밖에서 바위동굴 트로그가 땅을 파고 있습니다. 돌조각 단지와 자홍버섯은 던전 밖, 트로그의 동굴과 굴에 있습니다.",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "북쪽 아이언밴드의 발굴현장으로 돌아가십시오.",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "{area:144}에서 {area:150}(으)로 날아가, 배를 타고 {area:442}(으)로 간 다음 {area:702}(으)로 날아가십시오.",
	["the book on her table"] = "그녀의 탁자 위 책",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}의 다음 심부름은 {zone:1446}(으)로 갑니다: 건너뛰십시오.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: 간직하십시오. 깃털은 {zone:1428} 가이드 끝에서 구합니다",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "달의 신전",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "차원문을 지나 {zone:1457}(으)로 들어가십시오. 달의 신전은 도시 남쪽에 있습니다.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, 그녀의 옆",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, 나무 꼭대기",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "흙은 나중에 {zone:1449}에서 구합니다",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "드루이드 상급자는 세나리온 자치령에 있습니다. {zone:1455}에는 없습니다",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "{area:144}(으)로 돌아가기",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "귀환석으로 {area:144}에 가십시오. {zone:1427} 가이드는 {area:1446}에서 시작합니다: 여기서 남쪽 {zone:1418}(으)로 가서, 서쪽으로 호드 마을 {area:340}을(를) 지나 오솔길을 따라 협곡으로 올라가십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "북쪽으로 {zone:1425} 한가운데의 {area:351}까지 가세요. {npc:2655}와(과) {npc:2656}이(가) 그 주변 곳곳을 기어다닙니다.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "남동쪽으로 {zone:1425} 남쪽에 있는 썩은가지부족의 계단식 신전 {area:355}(으)로 가서 꼭대기까지 올라가십시오. 문지기 퀴아가와 {npc:8636}(정예, 50)이(가) 그곳에 있습니다: 꼭대기에 닿으면 곧바로 내려오십시오.",
}
