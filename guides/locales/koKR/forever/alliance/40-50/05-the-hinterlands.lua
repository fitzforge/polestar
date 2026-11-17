-- Korean (koKR): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "남동쪽으로 {zone:1425} 남쪽에 있는 썩은가지부족의 계단식 신전 {area:355}(으)로 가서 꼭대기까지 올라가십시오. 퀴아가와 {npc:8636}(정예, 50)이(가) 그곳에 있습니다: 꼭대기에 닿으면 곧바로 내려오십시오.\n주의: {npc:7996}와(과) {npc:8636}을(를) 포함한 정예 트롤과 썩은가지부족 점술가 여럿이 꼭대기 단을 지킵니다. 점술가는 주문을 시전하며 무리의 나머지와 연결되어 있습니다.",

	-- Step 2: Vilebranch Soothsayers
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Vilebranch Soothsayers"] = "썩은가지부족 예언자",
	-- {area:355} Altar of Zul · {npc:7996} Qiaga the Keeper · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "썩은가지부족 예언자(46-47)는 {area:355} 기슭 주변을 돌아다닙니다. 이들의 토템은 마렛 파이어텐드에게 가져갑니다. 주의: {npc:7996}와(과) {npc:8636}(50, 정예)이(가) 제단 남동쪽에 서 있습니다. 이들을 피해 제단 서쪽의 예언자를 잡고, 제단 위로는 올라가지 마십시오.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "북쪽으로 {zone:1425} 한가운데의 {area:351}까지 가세요. 초록 진흙괴물과 비취 수액괴물이 그 주변 곳곳을 기어다닙니다.\n주의: 표범이 은신한 채 이 지역을 돌아다닙니다.",

	-- Step 4: Wildkin feathers
	["Wildkin feathers"] = "숲올빼미 깃털",
	-- {npc:7916} Erelas Ambersky · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {area:351} Skulk Rock
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["{npc:7916}'s Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam: pick them up as you ride between the altar and {area:351}."] = "{npc:7916}의 숲올빼미 깃털은 {zone:1425} 곳곳, 올빼미야수가 돌아다니는 {area:348} 남쪽과 동쪽 땅 위에 있습니다. 제단과 {area:351} 사이를 오가며 주우십시오.",

	-- Step 5: Lost Gryphon Eggs
	-- plural, as words: Lost Gryphon Eggs = {item:279229} Lost Gryphon Egg
	["Lost Gryphon Eggs"] = "잃어버린 그리핀 알",
	-- {area:348} Aerie Peak
	["On the way back to {area:348}: the lost gryphon eggs lie in the hills just east of the aviary."] = "{area:348}(으)로 돌아가는 길에: 잃어버린 그리핀 알은 그리핀 둥지 바로 동쪽 언덕에 있습니다.",

	-- Step 6: Aerie Peak
	["Inside"] = "",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "나중에 {area:1438}의 {quest:2990}에게",
	-- {npc:270263} Farseer Maret Firetend
	["{npc:270263}, just east of the aviary"] = "{npc:270263}, 그리핀 둥지 바로 동쪽",

	-- Step 7: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "{area:1537}(으)로 날아가기",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 8: Class trainer
	["Class trainer"] = "직업 전문가",

	-- Step 9: Ironforge inn
	-- {area:1537} Ironforge
	["{area:1537} inn"] = "{area:1537} 여관",
	-- {object:26486} Stonefire Tavern (no name in this language: may be words) · {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth at the {object:26486}: the {zone:1427} guide starts with the hearth back here and the gryphon to {area:144}."] = "",

	-- Step 10: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "지하철을 타고 {zone:1453}(으)로",

	-- Step 12: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "{area:42}(으)로 날아가기",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 15: The bloodmages
	["The bloodmages"] = "혈법사",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "",
	-- {npc:7505} Bloodmage Drazial · {zone:1419} Blasted Lands
	["{npc:7505}: keep the five, their beasts (48-53) wait for the level-52 {zone:1419} stop"] = "{npc:7505}: 5개 퀘스트는 보관하십시오. 야수(48-53)는 레벨 52 {zone:1419} 단계에서 처리합니다",

	-- Step 16: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}."] = "먼저 길을 따라 동쪽 요새로 가십시오: {item:6091}은(는) {area:42}에서 받은 지 1시간 후에 사라집니다.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, 요새 꼭대기",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}의 다음 임무인 {item:9471}은(는) {area:978} 퀘스트입니다: 건너뛰십시오.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "",

	-- Step 17: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "{area:35}(으)로 날아가기",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "",

	-- Step 18: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	["\"Sea Wolf\" MacKinley, if the Stranglethorn guide didn't give it"] = "\"바다늑대\" 맥킨리, 가시덤불 골짜기 가이드에서 받지 않았다면",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor, if the Stranglethorn guide didn't give it"] = "{npc:2487}, 꼭대기 층, 가시덤불 골짜기 가이드에서 받지 않았다면",
	-- {npc:2494} Privateer Bloads
	["{npc:2494}, if the Stranglethorn guide didn't give it"] = "{npc:2494}, 가시덤불 골짜기 가이드에서 받지 않았다면",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, if the Stranglethorn guide didn't give it"] = "{npc:2498}, 안쪽, 가시덤불 골짜기 가이드에서 받지 않았다면",

	-- Step 19: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "",
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["The charts and orders lie in the pirate camp on the {area:43}, just south of {area:35}; its Swashbucklers walk the shore. The Warlocks and Swashbucklers (41-43) are under you now."] = "해도와 명령서는 {area:35} 바로 남쪽 {area:43}의 해적 야영지에 있습니다. 해적 검객들이 해안을 돌아다닙니다. 흑마법사와 검객(41-43)은 이제 레벨이 낮습니다.",

	-- Step 20: Booty Bay
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, 꼭대기 층",

	-- Step 21: The Bloodsail captains
	["The Bloodsail captains"] = "붉은해적단 선장들",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "",

	-- Step 23: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "{npc:1907}",
	["Leave town by the tunnel and ride north along the coast past the Bloodsail camp: the naga comb the beaches beyond it and drop the reeds."] = "터널로 마을을 나와 붉은해적단 야영지를 지나 해안을 따라 북쪽으로 가십시오. 그 너머 해변을 뒤지는 나가가 갈대를 떨어뜨립니다.",

	-- Step 24: Zanzil's village
	["Zanzil's village"] = "잔질의 마을",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Ride on north along the coast to Zanzil's village. Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "해안을 따라 북쪽 잔질의 마을로 계속 가십시오. 모든 잔질 추종자가 혼합물을 떨어뜨릴 수 있습니다. {npc:2537}은(는) 야영지 남쪽을 돌아다닙니다.",

	-- Step 25: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535}와(과) {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536} stand together in the hills just north of Zanzil's village."] = "{npc:2535}와(과) {npc:2536}은(는) 잔질의 마을 바로 북쪽 언덕에 함께 서 있습니다.",

	-- Step 26: Gorilla hills
	["Gorilla hills"] = "고릴라 언덕",
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Gorilla Fangs = {item:2799} Gorilla Fang · Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride back south-east to the Mistvale gorilla hills above {area:35}. {npc:1449} sits among the gorillas: take ten Gorilla Fangs from the Elder Mistvale Gorillas first."] = "남동쪽으로 돌아가 {area:35} 위쪽 안개계곡고릴라 언덕으로 가십시오. {npc:1449}은(는) 고릴라들 사이에 있습니다. 먼저 덩치큰 안개계곡고릴라에게서 고릴라 송곳니 10개를 모으십시오.",

	-- Step 27: Unbagwa's ritual
	["Unbagwa's ritual"] = "운바그와의 의식",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "송곳니를 건네고 그 자리에 머무르십시오. 고릴라가 세 차례 몰려오고, 마지막에 {npc:1514}이(가) 나옵니다.\n주의: 고릴라 세 무리가 쉴 틈 없이 연달아 몰려온 뒤 {npc:1514}이(가) 나타납니다. 생명력과 마나를 가득 채우고 시작하고, 운바그와 근처에 머무르십시오. 일부 직업은 혼자 하기 어렵습니다. 친구와 함께하면 쉽습니다.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "",

	-- Step 29: Booty Bay
	["Ride back down to town."] = "다시 마을로 내려가십시오.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it, the Un'Goro guide lands there"] = "테라모어의 {npc:2616}에게: 간직하십시오. 운고로 가이드가 그곳에서 끝납니다",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}의 다음 잔질 심부름은 {zone:1441}에서 시작합니다. 건너뛰세요.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	["MacKinley's next task sends you after elite ogres: skip it."] = "맥킨리의 다음 임무는 정예 오우거를 잡으러 보냅니다. 건너뛰세요.",

	-- Step 30: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 34: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "잿빛갈기멧돼지와 붉은바위 바실리스크가 요새 남서쪽 비탈에 함께 있습니다. 더 남쪽의 지옥멧돼지는 52레벨이니 피하십시오.",
	-- ["Back to {area:144}"] = "{area:144}(으)로 돌아가기",
	-- ["Boars and basilisks"] = "멧돼지와 바실리스크",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "{area:144}에서 {area:150}(으)로 날아가, 배를 타고 {area:442}(으)로 간 다음 {area:702}(으)로 날아가십시오.",
	-- ["Fly from {area:348} to {area:42}."] = "{area:348}에서 {area:42}(으)로 날아가십시오.",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "귀환석으로 {area:144}에 가십시오. {zone:1427} 가이드는 {area:1446}에서 시작합니다: 여기서 남쪽 {zone:1418}(으)로 가서, 서쪽으로 호드 마을 {area:340}을(를) 지나 오솔길을 따라 협곡으로 올라가십시오.",
	-- ["Hearth to {area:348}."] = "귀환석으로 {area:348}에 가십시오.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "귀환석이 재사용 대기 중이라면 북서쪽으로 돌아가십시오.",
	-- ["Portal to {zone:1438}"] = "{zone:1438}행 차원문",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "동쪽 {area:1438}(으)로 돌아가 {area:144}(으)로 날아가십시오.",
	-- ["Ride back north to Ironband's camp."] = "북쪽 아이언밴드의 발굴현장으로 돌아가십시오.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "호수 남쪽 기슭을 따라 동쪽 아이언밴드의 발굴현장으로 가십시오.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "동쪽으로 {zone:1430}을(를) 지나 {zone:1435}(으)로 간 다음, 길을 따라 남쪽 {zone:1419}(으)로 내려가십시오. 혈법사들의 야영지가 길가 첫 번째 장소입니다.",
	-- ["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "먼저 길을 따라 동쪽 요새로 가십시오: {item:6091}은(는) {area:42}에서 받은 지 1시간 후에 사라지는데, 혈법사들의 야수 사냥은 그보다 오래 걸립니다.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "고개를 지나 남쪽 {area:3} 북쪽 끝으로 가십시오: 그곳 {area:1517} 밖에서 바위동굴 트로그가 땅을 파고 있습니다. 돌조각 단지와 자홍버섯은 던전 밖, 트로그의 동굴과 굴에 있습니다.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "서쪽으로 가십시오: 굶주린 칼송곳니하이에나가 혈법사 야영지 바로 남쪽의 메마른 언덕을 돌아다니고, 스콜포크 독침전갈(50레벨)이 북쪽 한가운데를 기어다닙니다. {npc:5982} 독수리가 그 위를 맴돕니다. 하나씩 끌어내십시오.",
	-- ["Scorpoks and snickerfangs"] = "스콜포크와 칼송곳니하이에나",
	-- ["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "차원문을 지나 {zone:1457}(으)로 들어가십시오. 달의 신전은 도시 남쪽에 있습니다.",
	-- ["Temple of the Moon"] = "달의 신전",
	-- ["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "혈법사들의 두 번째 단계는 같은 재료에 경험치 없이 강화 아이템만 줍니다: 건너뛰십시오.",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "드루이드 상급자는 세나리온 자치령에 있습니다. {zone:1455}에는 없습니다",
	-- ["The {area:1517} dig"] = "{area:1517} 발굴지",
	-- ["the book on her table"] = "그녀의 탁자 위 책",
	-- ["the soil comes from {zone:1449}, later"] = "흙은 나중에 {zone:1449}에서 구합니다",
	-- ["{area:144} flight master"] = "{area:144} 비행 조련사",
	-- ["{npc:3516}, at the top of the tree"] = "{npc:3516}, 나무 꼭대기",
	-- ["{npc:7740}, beside her"] = "{npc:7740}, 그녀의 옆",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}의 다음 심부름은 {zone:1446}(으)로 갑니다: 건너뛰십시오.",
	-- ["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: 간직하십시오. 깃털은 {zone:1428} 가이드 끝에서 구합니다",
}
