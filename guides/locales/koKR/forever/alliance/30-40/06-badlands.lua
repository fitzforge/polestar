-- Korean (koKR): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "서쪽 길로 돌아가 남쪽으로 따라가 고개를 지나 {zone:1432}에서 {zone:1418}(으)로 가십시오. {npc:2910}와(과) {npc:2860}은(는) 발굴 현장에 나란히 야영하고 있습니다.",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "어둠괴철로단 드워프들이 발굴 현장 바로 북쪽에 야영하고 있으며, 구겨진 지도는 천막 사이에 있습니다. 어둠괴철로단 채굴꾼과 어둠괴철로단 흑마술사가 라이돌의 행운의 곡괭이를 가지고 있습니다. 바위산코요테가 주변 비탈을 돌아다닙니다.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "발굴 상자",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "북동쪽 버려진 발굴 현장으로 가십시오. 보급품 상자는 먼지목도리 오우거들 사이에 있습니다.",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "라이돌의 다음 심부름은 {area:1517}(으)로 가니 건너뛰십시오.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618}와(과) {npc:2817}은(는) {zone:1418} 한가운데 {area:1877}에 함께 야영하고 있습니다.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "조개는 다음 가이드의 가시덤불 골짜기 북서 해안에 있습니다. 보관하십시오",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "부서진 해골은 오우거 바로 동쪽, 바위동굴일족 트로그 야영지 가장자리에 있습니다. 주변의 바위동굴일족 뼈다귀싸움꾼과 바위동굴일족 주술사가 조각을 떨어뜨립니다. 실성한 텔두린은 더 남쪽의 폐허가 된 야영지 옆에 앉아 있습니다.",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "",

	-- Step 10: Theldurin the Lost
	-- {area:1517} Uldaman
	["Theldurin sits by the ruined camp south of the trogg camp. His tablet lies just inside {area:1517}'s cave mouth, beside level 38 elites: a quest for a group."] = "텔두린은 트로그 야영지 남쪽의 폐허가 된 야영지 옆에 앉아 있습니다. 그의 석판은 {area:1517} 동굴 입구 바로 안쪽, 38레벨 정예 옆에 있습니다. 파티용 퀘스트입니다.",

	-- Step 11: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "서쪽 {area:1878}(으)로 가십시오. {npc:2921}은(는) 그 한가운데 기계 옆에서 일합니다.",

	-- Step 12: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "하급 바위 정령",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "하급 바위 정령이 {npc:2921} 서쪽 {area:1878}을(를) 돌아다닙니다. 모든 바위 정령이 {npc:1470}의 바위 정령 파편을 떨어뜨릴 수 있습니다.",

	-- Step 14: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {area:1517} Uldaman · {zone:1418} Badlands · {npc:2932} Magregan Deepshadow
	-- plural, as words: Obsidian Golems = {npc:4872} Obsidian Golem · Shadowforge Diggers = {npc:4846} Shadowforge Digger
	["Head north to {area:1517}'s entrance, in the north of the {zone:1418}: the chest lies just inside the cave mouth. {npc:2932} and the Obsidian Golems (38) stand beside it and Shadowforge Diggers (35-36) work the tunnel, all elite: keep your group together."] = "{zone:1418} 북부의 {area:1517} 입구로 북쪽으로 가십시오. 상자는 동굴 입구 바로 안쪽에 있습니다. {npc:2932}와(과) 흑요석 골렘(38)이 그 옆에 서 있고 어둠괴철로단 굴착꾼(35-36)이 터널에서 일하며, 모두 정예입니다. 파티와 함께 움직이십시오.",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "",

	-- Step 15: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:1517} Uldaman · {area:345} Agmond's End
	["{npc:4618} and {npc:2817} camp in the {area:1877}, on the road between {area:1517} and {area:345}."] = "{npc:4618}와(과) {npc:2817}은(는) {area:1517}와(과) {area:345} 사이 길 위의 {area:1877}에 야영하고 있습니다.",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "{area:2240}의 {npc:4454}에게: {zone:1446} 가이드가 45레벨에 그를 지나갑니다. 보관하십시오",

	-- Step 16: Sigrun Ironhew
	-- {area:1877} Valley of Fangs · {area:346} Hammertoe's Digsite · {npc:2860} Sigrun Ironhew
	["East from the {area:1877} to {area:346}: {npc:2860} takes the scrap metal."] = "{area:1877}에서 동쪽 {area:346}(으)로 가십시오. {npc:2860}이(가) 고철을 받습니다.",

	-- Step 17: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "남쪽 {area:345}(으)로 가십시오.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "{zone:1455}의 {npc:2786}에게: 보관하십시오",

	-- Step 18: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "바위 정령",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "{npc:92}은(는) {npc:2921}의 남동쪽을 돌아다니고, {npc:2831}와(과) {npc:2729}은(는) 그 서쪽 평원에 함께 있습니다.",

	-- Step 19: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "",

	-- Step 20: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 22: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, {npc:2921} 옆",

	-- Step 23: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "{area:2101}(으)로",

	-- Step 24: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "{npc:217590}이(가) {area:596} 주변을 기어다닙니다. {npc:217412}의 곤충학 입문 도구에 든 도구로 하나 잡으세요.",
	-- ["Fly to Theramore"] = "테라모어 섬으로 비행",
	-- ["Follow the road north to {area:608}."] = "길을 따라 북쪽 {area:608}(으)로 가십시오.",
	-- ["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "길을 따라 북쪽 {area:608}(으)로 가십시오. {npc:5396}은(는) 남쪽 끝에, {npc:5638}은(는) 가운데에, {npc:1182}은(는) 북쪽에 있습니다.",
	-- ["Follow the road south to {area:2407}."] = "길을 따라 남쪽 {area:2407}(으)로 가십시오.",
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "길을 따라 {zone:1443} 북부를 가로질러 서쪽 {area:2405} 폐허로 가십시오. 난파선으로 가는 길에, 그곳 언덕 위에 {npc:11863}의 탑이 있습니다.",
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "길을 따라 {zone:1443} 북부를 가로질러 서쪽 {area:2405} 폐허로 가십시오. 난파선의 궤짝은 그 바로 서쪽 해안에 있습니다.",
	-- ["Greater Rock Elementals"] = "상급 바위 정령",
	-- ["Lesser Rock Elementals"] = "하급 바위 정령",
	-- ["Maraudine centaurs"] = "마라우돈일족 켄타우로스",
	-- ["Ogres and buzzards"] = "오우거와 대머리수리",
	-- ["Rackmore's chest lies just south-east of the {object:177673}."] = "랙모어의 궤짝은 {object:177673} 바로 남동쪽에 있습니다.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "북동쪽 {zone:1418} 북부의 드워프 폐허로 가십시오. 궤짝은 어둠괴철로단 드워프들 사이에 있습니다. 근처의 {npc:2745}은(는) 정예이니 거리를 두십시오.",
	-- ["Shadowforge camp"] = "어둠괴철로단 야영지",
	-- ["Take the boat to Theramore from the far pier."] = "가장 먼 부두에서 테라모어 섬행 배를 타십시오.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "먼지목도리 오우거가 골짜기 바로 남쪽에 야영하며, 누구든 고철을 떨어뜨립니다. 대머리수리는 동쪽 평원을 맴돕니다.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "상급 바위 정령(42레벨)은 {area:342} 아래 남서쪽 끝을 걷습니다. 하나씩 끌어오십시오. {area:342}의 먼지목도리일족 고룡사냥꾼과 먼지목도리일족 싸움꾼도 고철을 떨어뜨립니다.",
	-- ["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "마라우돈일족 켄타우로스가 무덤 서쪽 {area:607}을(를) 차지하고 있으며, 모든 종류가 토템을 떨어뜨립니다.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "슬리더블레이드 나가가 {npc:11863}의 탑 북쪽, 북서 해안을 차지하고 있습니다. 카르니톨의 가방은 그 앞바다 해저에 있으며, 어떤 나가든 랙모어의 금 열쇠를 떨어뜨릴 수 있습니다. 최북단 끝 앞바다의 {area:2406}까지 헤엄쳐 가서 {object:177673}에 {item:15766}을(를) 사용하세요. {npc:12369}(38)이(가) 나타나면 처치하여 {quest:6027}을(를) 얻으세요.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "슬리더블레이드 나가가 {npc:11863}의 탑 북쪽, 북서 해안을 차지하고 있습니다. 카르니톨의 가방은 그 앞바다 해저에 있습니다. 최북단 끝 앞바다의 {area:2406}까지 헤엄쳐 가서 {object:177673}에 {item:15766}을(를) 사용하세요. {npc:12369}(38)이(가) 나타나면 처치하여 {quest:6027}을(를) 얻으세요.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "부서진 해골은 오우거 바로 동쪽, 바위동굴일족 트로그 야영지 가장자리에 있습니다. 주변의 바위동굴일족 뼈다귀싸움꾼과 바위동굴일족 주술사가 조각을 떨어뜨립니다. 실성한 텔두린은 더 남쪽의 폐허가 된 야영지 옆에 앉아 있습니다.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "악마들은 {zone:1443} 남부의 {area:602}에 모여 있습니다: 구덩이 주변의 지옥사냥개(마나먹는 지옥사냥개, 마법사 사냥개, 평원의 지옥사냥개), 황천의 요녀와 황천의 마녀, 파멸의경비대 부대장.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "비행 조련사는 {area:514} 성문 옆에 있으며, {npc:5083}와(과) {npc:4964}은(는) 성채 안에 있습니다.",
	-- ["The next guide starts in Theramore."] = "다음 가이드는 테라모어 섬에서 시작합니다.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "해골의 다음 임무인 멀달록은 43레벨의 이후 {zone:1418} 가이드까지 미룹니다.",
	-- ["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "난파선의 궤짝은 {npc:11863}의 탑 바로 남서쪽에 있습니다.",
	-- ["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "난파선의 궤짝은 {npc:11863}의 탑 바로 서쪽 해안에 있습니다.",
	-- ["The {area:2657}"] = "{area:2657}",
	-- ["Theramore"] = "테라모어 섬",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "언데드 약탈자가 소굴 동쪽, 마그람 마을 남쪽의 뼈 들판을 돌아다닙니다. 남동쪽 끝에서 {item:15848}을(를) 사용해 마그람일족 유령을 불러내십시오.",
	-- ["escort {npc:12277} back toward the graveyard"] = "{npc:12277}을(를) 무덤 쪽으로 호위",
	-- ["for the Dustwallow loop in the next guide"] = "다음 가이드의 먼지진흙 습지대 경로용",
	-- ["for {npc:3980} in {area:271}: keep it"] = "{area:271}의 {npc:3980}에게: 보관하십시오",
	-- ["for {npc:5637} in {zone:1455}: keep it"] = "{zone:1455}의 {npc:5637}에게: 보관하십시오",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "{item:2868}(대장기술 제작품)을 가지고 있을 때만",
	-- ["{area:144} flight master"] = "{area:144} 비행 조련사",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}, {object:177673}에 사용",
	-- ["{item:15881}, from the Slitherblade naga"] = "{item:15881}, 슬리더블레이드 나가에게서",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "{npc:11626}의 대상단은 {area:606} 동쪽 길에 멈춥니다. 퀘스트를 수락하고 코도와 함께 {area:602}을(를) 지나며 덤벼드는 악마를 처치하십시오. 그다음 {area:596} 동쪽 야영지의 {npc:11596}와(과) 대화하십시오.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "{npc:11863}의 탑은 난파선 동쪽 언덕에 있습니다.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277}은(는) 무덤 서쪽 켄타우로스 야영지에 갇혀 있습니다. 풀어 주고 나가는 동안 살려 두십시오. 무덤 옆에서 멈춥니다.",
	-- ["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "켄타우로스 족장 {npc:12369}은(는) {npc:11863}의 탑 북쪽, 북서 해안에 야영하고 있습니다.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, 여관 안",
	-- ["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: 잡으십시오, My Little Friends용",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "{npc:2921}의 다음 실험에는 제작 장비가 필요하니 건너뛰십시오.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "{npc:5638}의 다음 임무인 {item:6245}은(는) 먼 해안에서 떨어지는 아이템이니 건너뛰십시오.",
	-- ["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}: 30-40/02에서 받지 않았다면 수락하십시오. 난파선은 {npc:11863}의 탑 아래에 있습니다",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019}은(는) {area:2407} 남서쪽 {area:596} 가장자리에 있습니다. {object:176751}은(는) 해골들 사이에 있습니다.",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019}은(는) {area:2407} 남서쪽 {area:596} 가장자리에 있습니다. {object:176751}은(는) 해골들 사이에 있습니다. {npc:217590}이(가) 무덤 주변을 기어다니니 Entomology Starter Kit로 잡은 뒤 체크하십시오.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787}은(는) {object:35251} 옆에 있습니다. 그의 은 열쇠는 난파선 주변의 마른집게 게가 떨어뜨리고, 금 열쇠는 다음으로 갈 북서 해안의 슬리더블레이드 나가가 떨어뜨립니다.",
}
