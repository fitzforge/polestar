-- Korean (koKR): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.\n배는 마을 서쪽에 정박합니다. 비행 조련사는 여관 남쪽 언덕에 있고, 퀘스트 제공자들은 큰길을 따라 흩어져 있습니다.",
	["The WANTED poster outside the inn"] = "여관 밖의 현상수배 포스터",

	-- Step 2: The beach
	["The beach"] = "해변",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "왕바닷게는 마을 아래 해안을 따라 기어다니고, {quest:983}은(는) 부두 바로 남쪽 해변에 서 있습니다. 어둠의해안 트레샤돈은 얕은 물에서 헤엄칩니다. {object:175207}은(는) 마을 바로 남쪽 해안에 놓여 있습니다.",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, 마을 북쪽 끝",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}, 여관 위층",

	-- Step 6: The skeletal turtle
	["The skeletal turtle"] = "거북 해골",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, 부두 서쪽 해변, 물속",

	-- Step 7: Buzzbox 827
	-- {quest:983} Buzzbox 827
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler
	["Only if you still carry {quest:983}'s quest: the Tide Crawlers scuttle along the shore below the village, and {quest:983} stands on the beach just south of the docks."] = "{quest:983}의 퀘스트를 아직 가지고 있을 때만: 왕바닷게는 마을 아래 해안을 따라 기어다니고, {quest:983}은(는) 부두 바로 남쪽 해변에 서 있습니다.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "게 다리: 왕바닷게",

	-- Step 8: Darkshore Threshers
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Darkshore Threshers"] = "",
	-- {quest:983} Buzzbox 827 · {area:452} Mist's Edge · {quest:1001} Buzzbox 411 · {quest:954} Bashal'Aran
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["{quest:983} stands on the beach just south of the docks: once his crawler legs are in, he asks for Thresher Eyes. The Darkshore Threshers (12-14) swim in the shallows off the docks and up the shore to {area:452}; {quest:1001}, who takes the eyes, stands north of {quest:954} at the end of the first loop."] = "",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes; underwater"] = "",

	-- Step 9: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "곰과 검은나무일족 야영지",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {quest:2139} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "",

	-- Step 10: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639}은(는) 폐허 북쪽 끝에 서 있습니다. 저주받은 명가의 원혼, 고뇌하는 명가의 원혼, {npc:2178}이(가) 폐허를 떠돕니다. {npc:3667}의 유령이 그 사이를 거닐고, 올빼미 {npc:270196}이(가) 폐허 동쪽을 맴돕니다. 두 석판은 폐허 안에 있고, {quest:4722}은(는) 폐허 서쪽 해안에 있습니다.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "명가의 유물",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "{object:17188}을(를) 읽으십시오",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "{object:17189}을(를) 읽으십시오",

	-- Step 11: The red crystal
	["The red crystal"] = "붉은 수정",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "{area:447} 동쪽의 산을 오르십시오. {object:175524}은(는) 바위 턱 위에 있습니다.",

	-- Step 12: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road north-north-west of {npc:3650}; a {quest:4723} lies on the shore on the way to him."] = "",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "그렐족 귀걸이",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: 데스릴 사티로스",

	-- Step 13: Buzzbox 411
	-- {quest:4723} Beached Sea Creature · {quest:1001} Buzzbox 411 · {area:442} Auberdine
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["North-north-west of Asterion by the road, past the {quest:4723}: {quest:1001} wants Moonstalker Fangs next, from the second loop's hills. Then south-west down to {area:442}."] = "",

	-- Step 14: Auberdine
	-- {npc:3693} Terenthis · {npc:3649} Thundris Windweaver
	["{npc:3693}: for {npc:3649}, at the north end of the village"] = "",
	-- {npc:6301} Gorbold Steelhand · {zone:1439} Darkshore
	["{npc:6301}, on the way north: the bay wrecks, on your next {zone:1439} visit"] = "",

	-- Step 15: Auberdine
	-- {npc:3701} Tharnariun Treetender
	["{npc:3701}: the bears are on the loop ahead"] = "",
	-- {npc:3649} Thundris Windweaver · {area:445} Cliffspring Falls
	["{npc:3649}: his sample comes from the {area:445}, at the end of the next loop"] = "",
	["Fill the tube at the moonwell in the village"] = "마을의 달샘에서 시험관을 채우십시오",

	-- Step 16: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw · {npc:3667} Anaya Dawnrunner · {area:447} Ameth'Aran · {zone:1439} Darkshore
	["{npc:3644} waits where the pier meets the shore. {npc:3667} (16), whose pendant he wants, walks {area:447} on the loop ahead: from level 14.5 you take it there, else on your next {zone:1439} visit."] = "",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, 부두 위",

	-- Step 17: Rabid Thistle Bear on the way
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164} on the way"] = "",

	-- Step 18: Moonstalkers on the way
	["Moonstalkers on the way"] = "",
	-- {area:442} Auberdine · {area:456} Cliffspring River
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The Moonstalkers (14-15) roam the hills of the loop ahead, south of {area:442} and around the {area:456} at its end: any of them drops the fangs. Leave the Moonstalker Sires (17-18) and Matriarchs (19-20) south of the Grove."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "달표범 송곳니",

	-- Step 19: Blackwood furbolgs
	["Blackwood furbolgs"] = "검은나무일족 펄볼그",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder · Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	-- was: ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "검은나무일족 길잡이와 바람술사가 {area:442} 남동쪽 야영지를 차지하고 있습니다.\n주의: 바람술사(13-14)는 원거리에서 주문을 쓰고 펄볼그가 둘씩 서 있습니다. 한 마리씩 끌어오세요."
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}; Rabid Thistle Bears roam the hills around it.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "",

	-- Step 20: The southern beaches
	["The southern beaches"] = "남쪽 해변",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "해안을 따라 {area:447}을(를) 지나 남쪽으로 가십시오. {quest:4728} 하나는 고대정령의 숲 서쪽 해안에, 또 하나는 더 남쪽 {area:450} 근처에 있습니다. 더 남서쪽의 잿빛안개멀록 점술사와 잿빛안개멀록 바다사냥꾼(18-20) 사이에 사체가 세 개 더 있습니다. 가이드는 레벨이 더 가까워지는 마지막 순환 때 이들을 처리합니다.",

	-- Step 21: Onu
	-- {quest:952} Grove of the Ancients · {npc:3616} Onu · {npc:11218} Kerlonian Evershade
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["From the beached creature, head east to the {quest:952}. Watch for level 16 bears and level 17 Moonstalker Sires between the beach and the grove; go around them. {npc:3616} stands beside Arbal and the sleeping {npc:11218}."] = "",

	-- Step 22: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "",

	-- Step 23: Anaya's Pendant
	-- {npc:3667} Anaya Dawnrunner · {npc:2184} Lady Moongazer
	["Careful: {npc:3667} (16) is over you: pull her on her own at full health. {npc:2184}, a rare (17), also walks the ruins: leave her be."] = "",
	-- {item:5382} Anaya's Pendant · {npc:3667} Anaya Dawnrunner
	["{item:5382}: {npc:3667}'s ghost walks the ruins"] = "",

	-- Step 24: The red crystal
	["Back north-east into the mountains to the crystal."] = "북동쪽 산으로 돌아가 수정에게 가십시오.",

	-- Step 26: Bashal'Aran
	-- {npc:3650} Asterion · {area:456} Cliffspring River
	["North along the hills to {npc:3650}, then on north-east to the {area:456}."] = "",

	-- Step 27: Cliffspring Falls
	-- {area:456} Cliffspring River · {npc:6788} Den Mother
	-- plural, as words: Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["North-east up the {area:456} to the falls: fill the sampler at the water there. Moonstalkers (14-15) roam the hills around the river.\nCareful: Encrusted Tide Crawlers (17-20) line the shore below the falls and the {npc:6788}'s bears (18-19) lair in the hills south of them: keep to the river."] = "",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, 폭포에서",

	-- Step 28: Buzzbox 323
	-- {quest:1002} Buzzbox 323 · {object:17185} Buzzbox 525 · {zone:1439} Darkshore
	["{quest:1002} stands on the hill above the falls. He offers {object:17185} next: its bears are far south, for your next {zone:1439} visit."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs: the Moonstalkers around the river"] = "",

	-- Step 29: Beached Sea Turtle
	-- {quest:4725} Beached Sea Turtle · {quest:954} Bashal'Aran · {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Greymist Warriors = {npc:2205} Greymist Warrior
	["West along the north shore: the {quest:4725} lies on the beach north of {quest:954}, among Reef Crawlers and Greymist Warriors (15). Then south-west down to {area:442}."] = "",

	-- Step 30: Auberdine
	-- {npc:3657} Sentinel Elissa Starbreeze · {npc:3693} Terenthis · {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3657}, beside {npc:3693}: for Balthule at the {area:444}, on your next {zone:1439} visit"] = "",
	-- {npc:3701} Tharnariun Treetender · {npc:6788} Den Mother · {zone:1439} Darkshore
	["{npc:3701}: the {npc:6788}, on your next {zone:1439} visit"] = "",
	-- {npc:3583} Barithras Moonshade · {area:445} Cliffspring Falls · {zone:1439} Darkshore
	["{npc:3583}: the cave by the {area:445}, on your next {zone:1439} visit"] = "",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}, on the walk from the boat"] = "",

	-- Step 31: Elisa Steelhand
	["talk to the trainer"] = "",

	-- Step 32: Kurdram Stonehammer
	-- {npc:6297} Kurdram Stonehammer · {npc:6300} Elisa Steelhand · {quest:97948} Camping 101: Mining
	["{npc:6297}, beside {npc:6300}: {quest:97948}"] = "{npc:6297}, {npc:6300} 옆: {quest:97948}",

	-- Step 33: Jenna Lemkenilli
	-- {npc:11037} Jenna Lemkenilli · {npc:6300} Elisa Steelhand · {quest:97941} Camping 101: Engineering
	["{npc:11037}, beside {npc:6300}: {quest:97941}"] = "{npc:11037}, {npc:6300} 옆: {quest:97941}",

	-- Step 34: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {quest:4763} The Blackwood Corrupted · {zone:1439} Darkshore
	["From level 15 {npc:3649} also has {quest:4763}: its samples come from the northern Blackwood camp on your next {zone:1439} visit. Fill its bowl at the moonwell in the middle of the village now."] = "",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "",

	-- Step 35: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw
	-- was: ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, 배로 가는 길, 부두가 해안과 만나는 곳"
	["{npc:3644} waits where the pier meets the shore, on the way to the boat."] = "",

	-- Step 36: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "배를 타고 {area:17203}(으)로",

	-- Step 37: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "",

	-- Step 38: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453} 비행 조련사",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "",

	-- Step 39: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way. His reply to {npc:3649} goes back to {area:442} with you."] = "",
	-- {npc:1646} Baros Alexston · {npc:3649} Thundris Windweaver
	["{npc:1646}: {npc:3649}'s letter"] = "",
	-- {npc:1646} Baros Alexston · {quest:97926} Making Do · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["{npc:1646}: {quest:97926}, for {npc:3649} on your next {zone:1439} visit"] = "",

	-- Step 40: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "여기 있을 때: {npc:11867}에게 {spell:202}을(를) 배우세요({object:2096}, 은화 10개); 양손 무기가 전사를 가장 빨리 키웁니다.",

	-- Step 41: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "여기 있을 때: {npc:11867}에게 검을 배우세요({object:2096}, 은화 10개); 주무기에 검이면 도적이 꾸준히 성장합니다.",

	-- Step 42: Druid trainer
	["Druid trainer"] = "드루이드 상급자",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "",

	-- Step 44: Class trainer
	["Class trainer"] = "직업 전문가",

	-- Step 45: Shaman trainer
	["Shaman trainer"] = "주술사 교관",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "검은나무일족 길잡이와 검은나무일족 풍수사가 {area:442} 남동쪽 야영지를 지키고 있습니다.",
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "검은나무일족 길잡이와 바람술사가 {area:442} 남동쪽 야영지를 차지하고 있습니다.\n주의: 바람술사(13-14)는 원거리에서 주문을 쓰고 펄볼그가 둘씩 서 있습니다. 한 마리씩 끌어오세요.",
	-- ["Into {area:148}"] = "{area:148}(으)로",
	-- ["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "배는 마을 서쪽에 정박합니다. 비행 조련사는 여관 남쪽 언덕에 있고, 퀘스트 제공자들은 큰길을 따라 흩어져 있습니다.",
	-- ["{item:5382}: {npc:3667}, level 16; pull her away from the Highborne"] = "{item:5382}: 16레벨 {npc:3667}. 높은태생에게서 떨어뜨려 끌어오십시오",
	-- ["{npc:3644}, on the pier"] = "{npc:3644}, 부두 위",
	-- ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, 배로 가는 길, 부두가 해안과 만나는 곳",
}
