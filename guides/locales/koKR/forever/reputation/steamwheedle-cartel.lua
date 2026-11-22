-- Korean (koKR): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "스팀휘들 카르텔 평판",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "고블린 마을 다섯 곳을 한꺼번에: {npc:14637}의 전기 맞은 거인과 {npc:14338}의 수갑, 그다음 새 병참장교 다섯과 그들의 모자.",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Forever의 고블린 병참장교: 약간 우호적과 우호적에서 20~50레벨 장비",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "고블린 마을 다섯 곳이 한 평판 가족, 스팀휘들 카르텔을 공유합니다: {faction:470}, {faction:21}, {faction:369}, {faction:577}, 그리고 {zone:2548}에 있는 Forever의 새로운 {faction:2827}. 모두 각각 중립(그 안에 500)으로 시작합니다. 한 마을에서의 획득은 다른 마을에 절반을 주고, {npc:14637}의 것처럼 카르텔 자체를 위한 퀘스트는 모든 마을에 정액을 줍니다. 손실도 같은 방식으로 퍼집니다: {npc:4624}나 마을의 고블린 하나가 125를 깎고(다른 마을에서는 절반), 블러드세일 해적단 평판은 그것으로만 얻습니다. {npc:14637}은(는) 중앙 {zone:1444}를 관통하는 도로에 야영하고 고블린들이 싫어하는 플레이어에게도 일합니다. 그의 첫 두 퀘스트는 48레벨이며 반복 퀘스트(55레벨)를 엽니다. Forever는 그 모든 것을 어떤 레벨에서도 정액으로 줍니다.",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}: 모든 마을에 150",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}: 모든 마을에 150",

	-- Step 2: Zapped giants
	["Zapped giants"] = "축소된 거인",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "살아 있는 거인({npc:5357}, {npc:5358}, 또는 해안, 심해, {npc:5361}, 47~50레벨)에게 {item:18904}을(를) 사용하면 전기 맞은 버전으로 줄어듭니다. 그것을 잡아 {item:18956}을(를) 얻으세요. 매번 하나씩입니다. 북서쪽 언덕의 육지 보행자와 절벽 거인이 가장 많고, 파도 보행자는 해안과 여울을 거닙니다. 축소기는 두 시간 지속됩니다. 떨어지면 퀘스트를 포기하고 다시 받으세요.",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}, 살아 있는 거인에게",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}, 전기 맞은 거인에게서",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "바다 정령과 바다 물보라 정령",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "바다 정령과 바다 물보라 정령(47~49레벨)이 {area:1108}을(를) 따라 떠다니고 거인 아래 여울에 있습니다. 약 절반이 {item:18958}을(를) 떨어뜨립니다.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}: 바다 정령과 바다 물보라 정령",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "{npc:14637}에게 돌아가기",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "이제 {npc:14637}이(가) {quest:7725}(잔류물 10)와 {quest:7726}(핵 6)을(를) 반복해서 줍니다: 매번 모든 마을에 평판 25.",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}, 56 미만",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "동부 {zone:1446} 해안의 {area:1336}(44~45레벨) 남쪽바다 해적이 {faction:369}에 우호적 끝까지 하나에 5를 주고 다른 마을에 절반을 줍니다. {area:977}의 퀘스트 둘이 {faction:369}에 각각 100을 줍니다: {quest:8366}(해적 각각 10)과 {quest:8365}(남쪽바다 해적 모자 20개, 해적 열 명 중 한 명). 56레벨부터 해적은 회색이 되고 적게 줍니다. 그때는 이 단계를 건너뛰세요.",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{zone:1428} 북부 {area:251}의 고블린 {npc:10267}에게 모든 마을에 150, {faction:577}에 150을 더 주는 사슬이 있습니다. 새끼용에게 그녀의 {item:12284}을(를) 사용하고 장치가 붙잡는 동안 죽인 뒤 남기는 {quest:4726}을(를) 주우세요. 장치는 서쪽의 화염비늘 새끼용이 아니라 검은 새끼용과 어린 화염비늘 새끼용만 붙잡습니다. 어린 화염비늘 새끼용(53~54레벨)은 {area:251} 바로 서쪽과 동쪽을 떠돌고, 검은 새끼용(51~52)은 지역 북동쪽 귀퉁이에서 가장 많이 무리 지어 있습니다. 수가 적고 퍼져 있으니 길이 둘 모두를 지나 검은 새끼용 사이에서 끝납니다.",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "{area:251} 서쪽의 어린 화염비늘 새끼용",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "{area:251} 동쪽의 어린 화염비늘 새끼용",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "북동쪽의 검은 새끼용",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}, 검은 새끼용이나 {npc:7048}에게",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}, 새끼용이 남긴 것",
	["100 to every town"] = "모든 마을에 100",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808}은(는) {faction:577}에 있습니다. {faction:577} 남서쪽의 서리바람 키메라(55~57레벨)가 다섯 번에 한 번 꼴로 뿔을 떨어뜨립니다.",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}: 서리바람 키메라",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "{npc:10267}에게 돌아가기",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810}이(가) 모든 마을에 50을 줍니다. 그녀의 후속 퀘스트, 달걀 동결(모든 마을에 150)과 달걀 수집(200)은 검은바위 첨탑 상부의 번식장, 10인 던전에서 합니다. 파티와 함께 받으세요.",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "다이어 마울 북부: {npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338}은(는) 고르독 오우거 날개인 다이어 마울 북부(57레벨부터 5인 던전: 파티를 모으세요)에 수갑을 채운 채 앉아 있습니다. {item:18250} 하나가 그를 한 번 풀어 주고 모든 마을에 150을 주며, 다음 공격대에서는 다시 수갑을 채웁니다. 고르독 오우거가 열다섯 분의 일 꼴로({npc:14321}은(는) 일곱 분의 일) 열쇠를 떨어뜨리니 날개를 한 바퀴면 보통 하나는 나옵니다. 그의 {item:18258}은(는) 처음에 100, 이후에는 50을 주는데 룬천 볼트 4개, {item:8170} 8개, {item:14341} 2개, 그리고 날개의 바구니에 있는 {item:18240}이(가) 필요합니다. 여기 도착했을 때 57 미만이라면 이 단계는 나중에 건너뛰세요.",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}, 고르독 오우거",
	-- {quest:5525} Free Knot! · {npc:14338} Knot Thimblejack
	["{quest:5525}: 150 to every town, handed in from {npc:14338}'s window"] = "{quest:5525}: 모든 마을에 150, {npc:14338}의 대화창에서 바로 제출",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}, 이후 모든 공격대에서 다시: 150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "모든 마을을 약간 우호적으로",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "중립 500에서 약간 우호적은 각 마을에 2,500입니다. 위의 퀘스트가 각 마을에 최대 700을 주고({npc:14637}의 둘 300, {npc:10267}의 150, 첫 노트 해방 150, 첫 오우거 슈트 100), {npc:14637}의 반복 퀘스트가 나머지를 채웁니다. 매번 모든 마을에 25: 잔류물 10개(거인 열)나 핵 6개(정령 열둘 정도). 마을 자체의 퀘스트도 인정되고 다른 마을에 절반을 줍니다: {faction:470}의 것은 {zone:1413}(10~25레벨, 약 4,300: 사모플랑지 사슬 625, {npc:3446}의 잔업, 위즐크랭크와 길타레스 호위 각 150), {faction:21}의 것은 가시덤불 골짜기, 아라시, {zone:1418}(30~50, 약 6,500: OOX 로봇 구출 셋 각 250, 나만의 OOX 200, 가시덤불 골짜기 열병 200, 네골라쉬와 대면 200, {area:327}의 가라앉은 보물 사슬), {faction:369}의 것은 {zone:1446}(43~55, 약 3,000: {item:8548} 200, 황무지 정의 100, 현상수배 전단), {faction:577}의 것은 {zone:1452}(52~60, 약 1,450: {npc:9298}의 겨울서리 사슬, 우미의 예티 퀘스트). Forever가 저레벨 몇 개를 더 줍니다: {zone:1411}의 끓어오르는 폭풍과 폭풍의 잠재력, 현상수배: 부루즈({faction:470} 각 100), {zone:1455}의 중요한 가보({faction:369} 100). Forever는 어떤 레벨에서도 정액을 줍니다. 회색이 아닌 동안 처치가 하나에 5를 도와 줍니다: {zone:1413}의 남쪽바다 해적은 {faction:470}에, {zone:1446}의 것은 {faction:369}에, 가시덤불 골짜기의 투자개발회사 야영지는 {faction:21}에 우호적 끝까지. 황무지 약탈자({faction:369})와 블러드세일 해적({faction:21})은 중립 끝까지입니다. 약간 우호적이면 각 병참장교의 첫 장비가 열립니다.",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}: 잔류물 10",
	["25 to every town"] = "모든 마을에 25",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}: 핵 6",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "모든 마을을 우호적으로",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "약간 우호적에서 우호적은 6,000: {npc:14637}의 반납 240번, 노트 해방 40회, 또는 섞어서. 모아둘 수 없습니다: 잔류물과 핵은 퀘스트가 일지에 있는 동안만 떨어지고 {item:18250}은(는) 한 번에 하나만 지닐 수 있으니 다음 공격대 전에 각각 반납하세요. 우호적이면 각 병참장교의 파란 아이템이 열립니다.",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "모든 마을을 매우 우호적으로",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "우호적에서 매우 우호적은 12,000을 더: {npc:14637}의 반납 480번(잔류물 4,800) 또는 노트 해방 80회. 매우 우호적이면 장식용 모자 다섯이 열리는데, 대부분의 플레이어가 이것을 하는 이유입니다. 유산 특성 외교관이 최대 10%를 더합니다.",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}, {faction:470}의 병참장교로 부두에 있습니다. 약간 우호적, 20레벨 장비: {item:274740} 41실(체력, 민첩), {item:274741} 54실(체력, 주문 위력), {item:274742} 34실(지능, 민첩). 우호적: {item:274743}, 보조장비, 66실(지능, 정신); {item:274744}, 한손 둔기, 1골 65실(체력, 힘). 매우 우호적: {item:274021}, 장식용 모자, 2골.",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}, 약간 우호적",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}, 약간 우호적",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}, 약간 우호적",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}, 우호적",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}, 우호적",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}, 매우 우호적",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}, {faction:21}의 병참장교. 약간 우호적, 30레벨 장비: {item:274745} 1골 10실(힘, 민첩), {item:274746} 1골 48실(치유와 주문 피해), {item:274747} 1골 3실(지능, 정신). 우호적: {item:274748}, 총, 3골 11실(공격력, 체력); {item:274749}, 목걸이, 1골 66실(생명력 재생, 체력). 매우 우호적: {item:274022}, 5골.",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}, 약간 우호적",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}, 약간 우호적",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}, 약간 우호적",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}, 우호적",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "{item:274749}, 우호적",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}, 매우 우호적",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}, {faction:369}의 병참장교. 약간 우호적, 40레벨 장비: {item:274750} 2골 74실(지능, 치유, 주문 피해), {item:274751} 2골 94실(민첩, 공격력), {item:274752}, 망토, 2골 36실(정신, 주문 위력). 우호적: {item:274753}, 한손 무기, 9골 46실(힘, 민첩); {item:274754}, 반지, 3골 80실(힘, 체력). 매우 우호적: {item:274023}, 10골.",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}, 약간 우호적",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}, 약간 우호적",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}, 약간 우호적",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}, 우호적",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}, 우호적",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}, 매우 우호적",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}, {faction:577}의 병참장교. 약간 우호적, 50레벨 장비: {item:274755} 3골 10실(정신, 지능), {item:274756} 5골 84실(민첩, 체력, 냉기 저항), {item:274757} 4골 68실(민첩, 공격력), {item:274758}, 가슴보호구, 10골 96실(힘, 체력). 우호적, 세 장신구를 약 7골 55실에: {item:274759}(자연 저항), {item:274760}(냉기 저항), {item:274761}(암흑 저항), 마지막 둘은 사용 효과가 있습니다. 매우 우호적: {item:274024}, 25골.",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}, 약간 우호적",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}, 약간 우호적",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}, 약간 우호적",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}, 약간 우호적",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}, 우호적",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}, 우호적",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}, 우호적",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}, 매우 우호적",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897}이(가) {zone:2548} 동부 해안의 {area:16727}에서 일반 물품과 함께 {faction:2827}의 보상을 팝니다. 약간 우호적, 40레벨 장비: {item:276200} 2골 74실(체력, 공격력), {item:276201} 2골 94실(지능, 정신), {item:276202} 2골 36실(민첩, 정신). 우호적: {item:276203}, 양손 무기, 9골 46실(체력, 힘, 민첩); {item:276204}, 방패, 3골 80실(체력, 주문 피해, 치유). 매우 우호적: {item:276199}, 10골.",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}, 약간 우호적",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}, 약간 우호적",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}, 약간 우호적",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}, 우호적",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}, 우호적",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}, 매우 우호적",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "모든 마을을 확고한 동맹으로",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "매우 우호적에서 확고한 동맹은 각 마을에 21,000을 더: {npc:14637}의 반납 840번이나 노트 해방 140회. 확고한 동맹을 위해 파는 병참장교는 없습니다: 이것은 칭호 표시줄용입니다.",
}
