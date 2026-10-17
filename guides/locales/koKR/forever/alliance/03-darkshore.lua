-- Korean (koKR): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "배는 마을 서쪽에 정박합니다. 비행 조련사는 여관 남쪽 언덕에 있고, 퀘스트 제공자들은 큰길을 따라 흩어져 있습니다.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666}, 여관 옆",
	["The WANTED poster outside the inn"] = "여관 밖의 현상수배 포스터",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, 부두 위",
	-- {npc:10216} Gubber Blump · {skill:356} Fishing
	["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}, 부두 위: {skill:356} 기술이 있을 때만",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, 마을 북쪽 끝",

	-- Step 2: The beach
	["The beach"] = "해변",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "왕바닷게는 마을 아래 해안을 따라 기어다니고, {quest:983}은(는) 부두 바로 남쪽 해변에 서 있습니다. 어둠의해안 트레샤돈은 얕은 물에서 헤엄칩니다. {object:175207}은(는) 마을 바로 남쪽 해안에 놓여 있습니다.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "집게다리",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes"] = "트레샤돈의 눈",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}: 부두에서 낚시",

	-- Step 4: The skeletal turtle
	["The skeletal turtle"] = "거북 해골",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks"] = "{item:12289}, 부두 서쪽 해변",

	-- Step 5: Plagued bears
	["Plagued bears"] = "병든 곰",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "광포한 엉겅퀴곰이 {area:442} 바로 동쪽 언덕을 돌아다닙니다. 한 마리에게 {quest:2139}을(를) 사용하고 그에게 데려가십시오.",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "곰과 검은나무일족 야영지",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "{area:442} 동쪽 언덕에서 광포한 엉겅퀴곰을 처치한 다음, 그 남동쪽의 펄볼그 야영지로 걸어가십시오. 아직 처치할 것은 없습니다.",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639}은(는) 폐허 북쪽 끝에 서 있습니다. 저주받은 명가의 원혼, 고뇌하는 명가의 원혼, {npc:2178}이(가) 폐허를 떠돕니다. {npc:3667}의 유령이 그 사이를 거닐고, 올빼미 {npc:270196}이(가) 폐허 동쪽을 맴돕니다. 두 석판은 폐허 안에 있고, {quest:4722}은(는) 폐허 서쪽 해안에 있습니다.",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "{object:17188}을(를) 읽으십시오",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "{object:17189}을(를) 읽으십시오",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "명가의 유물",

	-- Step 8: The red crystal
	["The red crystal"] = "붉은 수정",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "{area:447} 동쪽의 산을 오르십시오. {object:175524}은(는) 바위 턱 위에 있습니다.",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "언덕을 따라 북쪽으로 가십시오. {npc:3650}은(는) {quest:954} 폐허에서 기다립니다. 폐허에는 광기어린 그렐과 비열한 마귀가 가득하고, 동쪽 끝에는 데스릴 사티로스가 있습니다. {quest:1001}은(는) 폐허 서쪽 길가에 서 있고, 그에게 가는 길의 해안에 {quest:4723}이(가) 놓여 있습니다.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "그렐족 귀걸이",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: 데스릴 사티로스",

	-- Step 10: The Tower of Althalaxx
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "달표범이 {quest:954}와(과) 탑 사이의 언덕을 배회합니다. {quest:1002}은(는) 탑 서쪽 언덕에 서 있습니다.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "달표범 송곳니",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "귀환석으로 {area:442}에 가십시오",
	["Fill the tube at the moonwell in the village"] = "마을의 달샘에서 시험관을 채우십시오",

	-- Step 12: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "{area:442}에서 {area:702}(으)로 날아간 다음, 차원문을 타고 {area:1658}의 {npc:4217}에게 올라가십시오.",

	-- Step 13: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {item:15877}은(는) {area:2361} 아래 {area:656} 바닥의 용기 속에 있습니다. 하나를 북서쪽의 {area:2362}(으)로 가져가 그곳에서 사용하고 {npc:11799}와(과) 대화하세요. 그런 다음 {area:2361}에서 {area:442}(으)로 날아 돌아오세요.",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}: {area:445}에서 채집기를 채우십시오",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, 호수 안의 {object:177785}에서",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "{area:2362}에서",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "반쪽 펜던트는 {zone:1439}와(과) {zone:1436}에 있습니다: 경로 후반에",

	-- Step 14: Blackwood furbolgs
	["Blackwood furbolgs"] = "검은나무일족 펄볼그",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "검은나무일족 길잡이와 검은나무일족 풍수사가 {area:442} 남동쪽 야영지를 지키고 있습니다.",

	-- Step 15: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "불꽃은 {area:447} 남쪽에서 타오르고 있습니다.",

	-- Step 16: The southern beaches
	["The southern beaches"] = "남쪽 해변",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "해안을 따라 {area:447}을(를) 지나 남쪽으로 가십시오. {quest:4728} 하나는 고대정령의 숲 서쪽 해안에, 또 하나는 더 남쪽 {area:450} 근처에 있습니다. 더 남서쪽의 잿빛안개멀록 점술사와 잿빛안개멀록 바다사냥꾼(18-20) 사이에 사체가 세 개 더 있습니다. 가이드는 레벨이 더 가까워지는 마지막 순환 때 이들을 처리합니다.",

	-- Step 17: The Grove of the Ancients
	-- {area:448} Grove of the Ancients
	["The {area:448}"] = "{area:448}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "엉겅퀴불곰이 숲 주변 언덕을 돌아다닙니다. {quest:1003}은(는) 그 서쪽, 곰들 사이에 서 있습니다.",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "불곰 가죽",

	-- Step 18: The red crystal
	["Back north-east into the mountains to the crystal."] = "북동쪽 산으로 돌아가 수정에게 가십시오.",

	-- Step 19: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Two more beached remains lie on the north shore: near the {area:443} and north of {quest:954}."] = "언덕을 따라 북쪽의 {area:456}까지 간 다음 폭포로 올라가십시오. 북쪽 해안에 떠밀려 온 사체가 두 개 더 있습니다: {area:443} 근처, {quest:954} 북쪽.",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, 폭포에서",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}: 폭포 옆 동굴 입구에서",

	-- Step 21: Auberdine
	["The WANTED poster"] = "현상수배 포스터",

	-- Step 22: The bay wrecks
	["The bay wrecks"] = "만의 난파선",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "{area:442} 북쪽 만의 바다 밑에 난파선 두 척이 있고, 각각 금고가 하나씩 있습니다. 이 해안에는 모래톱게와 등껍질 왕바닷게가 늘어서 있습니다.",

	-- Step 23: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}은(는) 폐허 앞바다의 작은 섬에 숨어 있습니다. 열쇠 조각은 거대한 숲타조(윗부분), 잿빛안개멀록(가운데), 사나운 모래톱게(아랫부분)에게서 떨어집니다.",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: 폐허 서쪽, 북쪽 해안 앞바다 물속의 {object:177792}",

	-- Step 24: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661}은(는) 탑 아래 암흑이교도 광신자들 사이에 숨어 있습니다. 그의 편지는 {zone:1440}의 수호자 델그렌에게 줄 수 있게 간직하십시오.",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}: 암흑이교도 광신자",

	-- Step 25: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "동굴과 {npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother · {object:177624} Xabraxxis' Demon Bag
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "동굴은 폭포 남쪽에 있습니다. {item:5271}은(는) 동굴 곳곳에 자라고, {item:5270}은(는) 맨 안쪽에 있습니다. {npc:6788}은(는) 폭포 남쪽 언덕에 둥지를 틀고 있고, {object:177624}은(는) 그 북쪽 사티로스 야영지에 놓여 있습니다.",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks"] = "껄껄이그물버섯",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}, {object:177624} 안에",

	-- Step 27: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}와(과) {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "달버섯은 {area:442} 바로 동쪽 언덕의 달빛야수 동굴에서 자랍니다. 그곳의 달빛야수는 성미가 사납습니다. {item:2449}에는 {skill:182}이(가) 필요합니다: 약초 채집가는 {zone:1439} 곳곳에서 캘 수 있고, 그 외에는 {zone:1453}({npc:1313})이나 경매장에서 구해 오십시오.",

	-- Step 28: The Grove of the Ancients
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "길을 따라 남쪽으로 가십시오. {quest:948}은(는) 고대정령의 숲에 있는 고대정령입니다. {npc:270269}와(과) {npc:11218}이(가) 그 곁에서 잠들어 있습니다.",
	-- {npc:11218} Kerlonian Evershade · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}: {area:413}까지의 호위는 {zone:1440} 구간에서 합니다",

	-- Step 29: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "덩치큰 달표범이 글레이브 주변 숲을 배회합니다. {object:10076}와(과) {object:12666}은(는) 구덩이 바닥에 있고, {npc:3584}은(는) 구덩이 북쪽에 서 있습니다.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "고급 달표범 모피",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: 황혼의망치단 신도와 황혼의망치단 암살단원",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "신도나 암살단원이 {item:5352}을(를) 떨어뜨렸을 때만: 오른쪽 클릭하십시오",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "그녀를 글레이브 밖으로 호위하십시오. 제출은 {zone:1440}의 테리실에게 합니다",

	-- Step 30: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "{npc:10323}의 해변",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches west and south-west of {area:450}."] = "{npc:10323}은(는) 글레이브 서쪽 해변에 진을 칩니다. 모닥불 옆의 멀록을 처치하면 세 번째 무리에서 사냥개와 함께 나타납니다. {area:450} 서쪽과 남서쪽 해변에 떠밀려 온 사체가 세 개 있습니다.",

	-- Step 31: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450}은(는) {npc:10323}의 해변 남쪽 해안에 있습니다. 탐사가가 화석을 찾는 동안 그를 보호하십시오.",

	-- Step 33: Auberdine
	["Follow the road north."] = "길을 따라 북쪽으로 가십시오.",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}: 떠밀려 온 사체 아홉 개를 모두 반납하면 {npc:10219}이(가) 줍니다",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "그녀가 {item:15826}을(를) 줍니다",

	-- Step 34: The naga
	["The naga"] = "나가",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "해안을 따라 북동쪽의 {area:443}(으)로 가십시오. {quest:951}은(는) 폐허 곳곳에 있고, 폭풍비늘일족 미르미돈, 폭풍비늘일족 여마법사, 폭풍비늘일족 전사가 지키고 있으며, 폭풍비늘 야수조련사가 해안을 거닙니다.",

	-- Step 35: Back south
	["Back south"] = "다시 남쪽으로",
	["Hearthstone on cooldown? Follow the coast road back south."] = "귀환석이 재사용 대기 중이라면 해안 길을 따라 남쪽으로 돌아가십시오.",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}, 고대정령의 숲에서",

	-- Step 36: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692}은(는) {area:449} 동쪽 언덕에 숨어 있습니다. 그가 길로 돌아가도록 도우십시오. 나가는 길에 그도 싸웁니다.",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: {item:15826}을(를) 사용하십시오. {zone:1439} 전역을 돌아다닙니다",

	-- Step 37: Auberdine
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}: 나중의 {zone:1440} 구간에서 {area:415}의 {npc:3691}에게",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}: {zone:1453}의 {npc:1646}에게",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "배를 타고 {zone:1453}(으)로 가십시오",

	-- Step 38: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "나이트 엘프는 {area:442}에서 {area:702}(으)로 날아가십시오. 스카이본은 {area:442} 부두에서 배를 타고 가서 그곳의 루테란 비행 경로를 익히십시오. 차원문을 타고 {area:1658}의 {npc:4217}에게 올라가십시오.",

	-- Step 39: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. 비행 경로가 없다면 그곳에서 배우세요.",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}: 셸드라스 문트리의 환영 인사",

	-- Step 40: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "지하굴의 유물",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}(나이트 엘프)와(과) {npc:272054}(스카이본)이(가) {area:493} 남쪽에서 기다립니다. 세 유물은 그 동쪽의 {area:2363}에 있습니다. 첫 몇 주의 제보에 따르면 다른 플레이어가 유물을 획득하는 중에는 아무것도 나오지 않습니다: 잠시 기다렸다가 다시 시도하십시오.",

	-- Step 41: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "{npc:11802}에게 돌아가기",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village · {area:442} Auberdine
	["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "{area:2361}의 {npc:11802}에게 돌아간 다음, ({area:442}을(를) 거쳐) {area:702}(으)로 날아가십시오.",

	-- Step 42: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1453} Stormwind
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "차원문을 타고 {npc:4217}에게 올라간 다음, {area:442}(으)로 날아가 {zone:1453}행 배를 타십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "해안을 따라 북동쪽의 {area:443}(으)로 가십시오. {quest:951}은(는) 폐허 곳곳에 있고, 폭풍비늘일족 미르미돈, 폭풍비늘일족 여마법사, 폭풍비늘일족 전사가 지키고 있습니다.",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "해안을 따라 {area:447}을(를) 지나 남쪽으로 가십시오. {quest:4728} 하나는 고대정령의 숲 서쪽 해안에, 또 하나는 더 남쪽 {area:450} 근처에 있습니다.",
	-- ["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "언덕을 따라 북쪽의 {area:456}까지 간 다음 폭포로 올라가십시오. 북쪽 해안에 떠밀려 온 사체가 세 개 더 있습니다: {area:443} 근처, {quest:954} 북쪽, {quest:954} 서쪽.",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "언덕을 따라 북쪽으로 가십시오. {npc:3650}은(는) {quest:954} 폐허에서 기다립니다. 폐허에는 광기어린 그렐과 비열한 마귀가 가득하고, 동쪽 끝에는 데스릴 사티로스가 있습니다. {quest:1001}은(는) 폐허 서쪽 길가에 서 있습니다.",
	-- ["Read both tablets"] = "두 석판을 모두 읽으십시오",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "{npc:2232}은(는) 마을 아래 해안을 따라 기어다니고, {quest:983}은(는) 부두 바로 남쪽 해변에 서 있습니다. {npc:2185}은(는) 얕은 물에서 헤엄칩니다. {quest:4723}은(는) 마을 바로 남쪽 해안에 놓여 있습니다.",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883}: 폐허 서쪽, 북쪽 해안 앞바다 물속의 {object:177790}",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323}은(는) 글레이브 서쪽 해변에 진을 칩니다. 모닥불 옆의 멀록을 처치하면 세 번째 무리에서 사냥개와 함께 나타납니다. {area:450} 남쪽 해변에 떠밀려 온 사체가 세 개 있습니다.",
	-- ["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}은(는) 폐허 앞바다의 작은 섬에 숨어 있고, 폭풍비늘 야수조련사가 해안을 거닙니다. 열쇠 조각은 거대한 숲타조(윗부분), 잿빛안개멀록(가운데), 사나운 모래톱게(아랫부분)에게서 떨어집니다.",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003}은(는) 고대정령의 숲 서쪽에 서 있습니다.",
}
