-- Korean (koKR): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144} 비행 조련사",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "테라모어 섬 비행 조련사",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "배에서 내려 부두를 따라 {area:514} 성문 옆의 비행 조련사 발드럭에게 올라가십시오.",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}: 30-40/02에서 받지 않았다면. 난파선은 {npc:11863}의 탑 아래에 있습니다",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "길을 따라 남쪽 {area:2407}(으)로 가십시오.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019}은(는) {area:2407} 남서쪽, {area:596} 가장자리에 서 있습니다. {object:176751}은(는) 해골들 사이에 있습니다.",

	-- Step 7: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "{npc:217590}이(가) {area:596}을(를) 기어다닙니다. {npc:217412}의 {item:213565}에 든 도구로 한 마리를 잡으십시오.",

	-- Step 8: Maraudine centaurs
	["Maraudine centaurs"] = "마라우돈일족 켄타우로스",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "마라우돈일족 켄타우로스가 묘지 서쪽 {area:607}을(를) 차지하고 있으며, 모든 종류가 토템을 떨어뜨립니다.",

	-- Step 9: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277}은(는) 묘지 서쪽 켄타우로스 야영지에 갇혀 있습니다. 풀어 주고 나가는 동안 살려 두십시오. 그녀는 묘지 옆에서 멈춥니다.\n주의: 스크립트로 등장하는 무리는 서로 연결되어 있고 호위 중에만 나타나므로, 미리 처치하거나 하나씩 끌어올 수 없습니다. 시작하기 전에 길의 일반 켄타우로스를 처치해 두면 도움이 됩니다.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "{npc:12277}을(를) 묘지 쪽으로 호위",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "악마들은 {zone:1443} 남부의 {area:602}에 모여 있습니다. 지옥사냥개(마나 포식자, 마법사 사냥개, 지맥 사냥개), 황천의 처녀와 황천의 자매, 그리고 구덩이 주변의 파멸의 수호대장입니다.\n주의: 이곳 몹 대부분은 순찰 경로를 걸으므로 몹을 더 끌어오기 쉽습니다.",

	-- Step 11: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "언데드 약탈자가 마그람일족 마을 남쪽, 마녀단 동쪽의 뼈 들판을 돌아다닙니다. 화살표는 들판 서쪽 가장자리로 안내합니다. 그런 다음 들판 동쪽의 화살표 위치에서 {item:15848}을(를) 사용해 마그람 유령을 끌어내십시오. 주의: 마그람일족 강령왕과 시체먹이(45, 정예)가 마그람일족 강령술사(42)와 함께 두 화살표 사이 뼈 들판을 돌아다닙니다. 약탈자와 유령을 그들에게서 멀리 끌어내십시오.",

	-- Step 14: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "길을 따라 서쪽으로 {zone:1443} 북부를 가로질러 {area:2405} 폐허로 가십시오. 난파선으로 가는 길, 그곳 언덕 위에 {npc:11863}의 탑이 서 있습니다.",

	-- Step 15: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "난파선의 상자는 {npc:11863}의 탑 바로 남서쪽에 있습니다.",

	-- Step 16: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest
	["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787}은(는) {object:35251} 옆에 있습니다. 그의 은 열쇠는 난파선 주변의 마른집게 게가 떨어뜨리고, 황금 열쇠는 다음에 갈 북서쪽 해안의 칼날비늘 나가에게서 얻습니다.",
	["Underwater"] = "물속",

	-- Step 17: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: 만나는 대로 처치하십시오",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "칼날비늘 나가가 {npc:11863}의 탑 북쪽, 북서쪽 해안을 차지하고 있습니다. 카니톨의 가방은 그 앞바다 해저에 있으며, 어느 나가든 랙모어의 황금 열쇠를 떨어뜨릴 수 있습니다. 맨 북쪽 끝 앞바다의 {area:2406}까지 헤엄쳐 가서 {object:177673}에 {item:15766}을(를) 사용하십시오. {npc:12369}(38)이(가) 솟아오르니 처치해서 {quest:6027}을(를) 얻으십시오.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, 칼날비늘 나가에게서 획득",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "{item:15766}, {object:177673}에 사용",

	-- Step 18: Rackmore's Chest
	-- {object:177673} Serpent Statue (no name in this language: may be words)
	["Rackmore's chest lies just south-east of the {object:177673}."] = "랙모어의 상자는 {object:177673} 바로 남동쪽에 있습니다.",

	-- Step 21: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "길을 따라 북쪽 {area:608}(으)로 가십시오. {npc:5396}은(는) 남쪽 끝에, {npc:5638}은(는) 한가운데에, {npc:1182}은(는) 북쪽에 서 있습니다.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "{zone:1455}의 {npc:5637}에게: 보관하십시오",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "{area:271}의 {npc:3980}에게: 보관하십시오",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "테라모어 섬으로 비행",
	["The next guide starts in Theramore."] = "다음 가이드는 테라모어 섬에서 시작합니다.",
}
