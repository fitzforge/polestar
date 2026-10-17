-- Korean (koKR): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "{area:188}의 거대한 나무 {area:256} 아래에서 시작합니다.",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "길가의 {npc:2077}",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "나무 남쪽의 {npc:1992}",

	-- Step 2: The Balance of Nature
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Grells = {npc:1988} Grell · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "새끼 흑호와 새끼 엉겅퀴멧돼지가 {area:256} 주변을 돌아다닙니다. 나무 서쪽 숲의 그렐이 {item:3297}을(를) 지니고 있으며, 그곳에 나무옹이일족 토템이 서 있습니다.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "{area:256}(으)로 돌아가기",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: {npc:3596}에게 줄 문장",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "나무 경사로의 {npc:2082}",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp"] = "",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: {spell:1259799}와(과) 그림자 숨기를 시전한 뒤 {npc:3595}에게 완료하세요",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "나무 동쪽의 {npc:8583}",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "북쪽 {area:257}(으)로",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {npc:1994} Githyiss the Vile
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "병든 흑호와 엉겅퀴멧돼지가 동굴로 가는 길인 {area:256} 북쪽에 돌아다닙니다. {npc:8584}은(는) 동굴 입구 서쪽 나무 사이에서 기다리고, {npc:1994}은(는) 동굴 깊숙이 있습니다.",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders"] = "나무그물거미",

	-- Step 5: Aldrassil
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer"] = "전사 상급자 {npc:3593}",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "사냥꾼 상급자 {npc:3596}",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "도적 상급자 {npc:3594}",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{area:256}의 드루이드 상급자 {npc:3597}",

	-- Step 7: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917}와(과) 해독제",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406}은(는) {area:257} 안쪽에 있습니다. 가운데 길로 가다가 갈림길에서 왼쪽으로 높은 바위턱까지 오르세요. {item:10639}은(는) 그렐이 떨어뜨리고, 달봉우리 백합은 {area:256} 북쪽 연못가에 자랍니다.",

	-- Step 8: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "나무 꼭대기의 {npc:3514}",

	-- Step 9: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "달샘과 {npc:8584}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {quest:3522} Iverron's Antidote
	["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "달샘은 {area:256} 북쪽에 있고, {npc:8584}은(는) 조금 더 북서쪽에 있습니다. {quest:3522}은(는) 5분 동안만 유지되니 약병을 채우고 곧장 그에게 가세요.",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "달샘에서 {item:5185}을(를) 사용하세요",

	-- Step 10: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "{area:256} 꼭대기로 돌아가세요. {object:654846}은(는) 그 옆에 있습니다.",

	-- Step 11: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "{area:256} 남동쪽 길로 {area:188}을(를) 떠나세요. {area:186}(으)로 가는 길로 내려가는 곳에 {npc:6780}이(가) 서 있습니다.",

	-- Step 12: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "{area:188}에서 남서쪽 길을 따라가세요. {npc:2150}은(는) {area:186} 바로 동쪽 길가에 앉아 있습니다.",

	-- Step 13: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "모닥불 옆의 {npc:265811}",
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "여관 남쪽의 {npc:3515}",

	-- Step 14: Zenn's Bidding and the Starbreeze moonwell
	-- {quest:488} Zenn's Bidding
	["{quest:488} and the Starbreeze moonwell"] = "{quest:488}와(과) 별바람 마을 달샘",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "흑호, 스트리기드 올빼미, 나무그물 늑대거미가 {area:186} 주변과 동쪽 길을 따라 돌아다닙니다. 달샘은 {area:260} 서쪽 끝에 있습니다.",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "달샘에서 {item:5619}을(를) 사용하세요",
	-- {npc:2150} Zenn Foulhoof
	["{npc:2150}, on the way back"] = "돌아오는 길의 {npc:2150}",

	-- Step 15: Dolanaar quests
	-- {area:186} Dolanaar
	["{area:186} quests"] = "{area:186} 퀘스트",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "{spell:1229451}을(를) 얻을 때까지 {npc:265811}의 모닥불 옆에서 /앉기 하세요",
	-- {npc:6286} Zarrin
	["Speak with {npc:6286}, south of the inn"] = "여관 남쪽의 {npc:6286}와(과) 대화하세요",

	-- Step 17: East to Starbreeze Village
	-- {area:260} Starbreeze Village
	["East to {area:260}"] = "동쪽 {area:260}(으)로",
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {object:126158} Tallonkai's Dresser
	-- plural, as words: Fel Cones = {object:1673} Fel Cone · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "악의 열매는 {area:186}와(과) {npc:2150} 주변 나무 아래 곳곳에 있습니다. 흑호와 나무그물 늑대거미는 여전히 동쪽 길을 돌아다닙니다. {object:126158}은(는) 마을 동쪽 끝 언덕 위의 집에 있습니다.",
	["Nightsabers"] = "흑호",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "나무그물 늑대거미",

	-- Step 19: Lake Al'Ameth
	-- {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "젠 파울후프 남쪽입니다. {npc:2080}은(는) 물가에서 묘목을 돌보고 있습니다. 덩굴손 묘목과 나무괴물이 그 주변을 돌아다니고, 그 사이에 {quest:919}이(가) 자랍니다.",

	-- Step 20: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151}은(는) 마을 서쪽 길을 순찰합니다. 화살표 위치에 없으면 만날 때까지 길을 따라가세요.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "마을 서쪽 길의 {npc:2151}",

	-- Step 21: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "{area:258} 입구",

	-- Step 22: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038}은(는) 동굴 안 바닥이나 바위턱 위에서 기다립니다. 오른쪽으로 계속 가세요.",

	-- Step 23: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "{zone:1457}(으)로 가는 길",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "나무옹이일족 복병이 {area:258} 서쪽 길을 따라 숨어 있습니다.",

	-- Step 24: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "지하굴은 길 남쪽에 있습니다. {npc:275744}이(가) 안에 갇혀 있고, {npc:7317}은(는) 가장 깊은 곳에서 잠들어 있으며, 유물 상자 4개는 아래층 방에 있습니다.",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "나무옹이일족 주술사",
	-- {npc:7318} Rageclaw
	["{npc:7318}, in the den"] = "굴 안의 {npc:7318}",

	-- Step 25: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "{npc:275744}을(를) 지하굴 밖으로 호위하세요. 보고는 {area:186}의 {npc:2081}에게 하세요.",
	["Walk Lynessa out and keep her alive"] = "리네사를 데리고 나오며 살려 두세요",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "지하굴 밖의 {area:736}",

	-- Step 26: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "지하굴 남서쪽입니다. 달샘은 웅덩이 옆에 있습니다.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "달샘에서 {item:5621}을(를) 사용하세요",

	-- Step 27: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold."] = "웅덩이 남쪽입니다. {object:6751}은(는) 나무옹이 요새 옆에 자랍니다.",

	-- Step 28: Hearth to Dolanaar
	-- {area:186} Dolanaar
	["Hearth to {area:186}"] = "귀환석으로 {area:186}에 가기",

	-- Step 29: Ferocitas the Dream Eater
	-- {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "나무옹이일족 비술사와 꿈을 먹어치우는 페로시타스가 {area:260} 북동쪽에서 야영합니다. 페로시타스가 {item:8049}을(를) 떨어뜨리니 열어서 보석을 꺼내세요.",
	-- {npc:3567} Tallonkai Swiftroot · {area:186} Dolanaar
	["{npc:3567}, back in {area:186}"] = "{area:186}(으)로 돌아가 {npc:3567}",

	-- Step 30: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {area:264} Oracle Glade
	["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "{area:186}에서 북서쪽 길을 따라 {area:264}(으)로 가세요. 그녀가 다친 채 길가에 누워 있습니다.",

	-- Step 31: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "달샘은 숲 한가운데에 있습니다. {object:6752}은(는) 북쪽 끝에 자랍니다.",
	-- {item:5623} Amethyst Phial
	["Use the {item:5623} at the moonwell"] = "달샘에서 {item:5623}을(를) 사용하세요",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "달샘 옆의 {npc:3519}",

	-- Step 32: Bloodfeather harpies
	["Bloodfeather harpies"] = "붉은깃털일족 하피",
	["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "붉은깃털일족 하피는 숲 서쪽과 북쪽 비탈에 둥지를 틀고 있습니다.",

	-- Step 33: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "달샘으로 돌아가세요.",

	-- Step 34: The named harpies
	["The named harpies"] = "이름 있는 하피",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034}와(과) {npc:272044}은(는) 달샘 바로 서쪽에, {npc:272046}은(는) 더 북쪽에 날아다닙니다.",

	-- Step 35: Sentinel Arynia again
	["Sentinel Arynia again"] = "다시 파수꾼 아리니아 클라우드브레이크",
	-- {object:673378} Oracle Tree Bark
	["{object:673378}, just west of the moonwell"] = "달샘 바로 서쪽의 {object:673378}",

	-- Step 36: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "섬 서쪽을 따라 남쪽으로 가세요. 투사 우르살은 {area:478} 아래, 남쪽 끝을 배회합니다.",

	-- Step 37: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "우르살의 굴에서 북동쪽으로 {area:186}에 돌아가세요.",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{npc:6094} 옆의 {npc:3614}에게서 {item:3371}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}: {zone:1457}의 {npc:11401}에게 가져가세요",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{npc:6094}에게 줄 {item:159}, {npc:6736}에게서 구입",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "{zone:1457}의 판드랄 스테그헬름에게 가져가세요",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}: {zone:1457}의 {npc:4217}에게 가져가세요",

	-- Step 38: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "돌라나르 남동쪽의 {npc:2080}에게 가세요. 덩굴손 묘목이 물가에서 그 주변을 돌아다닙니다.",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: {zone:1457}의 {quest:922}에게 가져가세요",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "그 옆의 {object:7510}",

	-- Step 39: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "다시 {area:186}",

	-- Step 40: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "다잘라의 퀘스트마다 {item:15908}을(를) 줍니다. 그가 말한 야수에게 사용한 뒤 {area:186}의 그에게 막대를 가져가세요. 나무그물 늑대거미는 마을 주변을 기어 다니고, 긴발톱 흑호와 비명소리 스트리기드 올빼미는 마을 남쪽 숲을 돌아다닙니다.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}: {item:15908}(으)로 길들이세요",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}: {item:15908}(으)로 길들이세요",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}: {item:15908}(으)로 길들이세요",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "{zone:1457}의 {npc:4146}에게 가져가세요",

	-- Step 41: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "다시 {area:186}에서 북서쪽 길로 가세요. 그녀는 아직 {zone:1457}(으)로 가는 길가에 누워 있습니다.",

	-- Step 42: Darnassus
	-- {zone:1457} Darnassus · {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7316} Sister Aquinne
	["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "길을 따라 서쪽 {zone:1457}(으)로 가세요. {npc:4241}은(는) 도시 입구 바로 안쪽 {area:1659}에 있습니다. {npc:3516}은(는) 도시 북쪽 끝 {area:1658}에, {quest:922}은(는) 그 바로 남쪽에 있으며, {npc:4092}와(과) {npc:7999}은(는) 남쪽 끝 달의 신전에 있습니다. {npc:7316}은(는) 도시 서쪽, 루테란 마을로 내려가는 분홍색 차원문 가는 길에 있습니다.",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{area:1658}의 {npc:3516}",
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{area:1658}의 {npc:4146}: {spell:5149}",
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{area:1658}의 {npc:4217}",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "달의 신전의 {npc:4092}",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:4092} 위층의 {npc:7999}",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "달의 신전의 {npc:11401}: 별조각",

	-- Step 43: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "차원문을 타고 {area:702}(으)로 내려가세요. {npc:10118}은(는) 부두에, {npc:3838}은(는) 히포그리프 옆에 있습니다.",

	-- Step 45: Moonglade
	-- {area:442} Auberdine · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village
	["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "여관 남쪽 언덕에서 {area:442} 비행 경로를 배운 뒤 {spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있고, {quest:5929}은(는) 북서쪽 숲에 있습니다. {area:2361}에서 {area:493} 비행 경로를 배우고 ({area:442}을(를) 거쳐) {area:702}(으)로 날아가세요.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "{quest:5929}와(과) 대화하세요",

	-- Step 46: Back to Darnassus
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "{area:702}에서 차원문을 타고 올라가 {area:1658}의 {npc:4217}에게 가세요.",

	-- Step 47: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{area:702}(으)로 다시 내려가 {area:442}(으)로 날아가세요. {object:177525}은(는) 마을 바로 동쪽 언덕에 있습니다. 그곳에서 {item:15208}을(를) 사용하고, 초승달발톱을 물리친 뒤 {npc:12144}와(과) 대화하세요.",

	-- Step 48: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "한 번 더 {area:702}(으)로 날아가 차원문을 타고 {npc:4217}에게 간 뒤, 배를 타러 {area:442}(으)로 날아가세요.",

	-- Step 49: Auberdine
	-- {npc:4200} Laird · {zone:1453} Stormwind
	["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "{npc:4200}의 생선 가판대는 부두 옆에 있습니다. 그다음 배를 타고 {zone:1453}(으)로 가세요.",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "배를 타고 {zone:1453}(으)로 가십시오",
	-- {area:17203} Stormwind Harbor · {zone:1429} Elwynn Forest · {zone:1436} Westfall
	["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "{area:17203}에서 도시 성문을 지나 {zone:1429}(으)로 간 뒤 서쪽 길을 따라 {zone:1436}(으)로 가세요.",

	-- Step 50: Defensive Stance
	-- {object:2100} Old Town · {npc:5480} Ilsa Corbin · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "항구에서 {object:2100}(으)로 걸어가세요. {npc:5480}이(가) 그곳에서 전사를 가르칩니다. {npc:6089}와(과) {npc:6090}은(는) {object:2152} 옆에 함께 서 있습니다. {npc:6090}은(는) 자기 머그잔을 걸고 당신과 싸웁니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "{npc:3601}의 퀘스트마다 {item:15908}을(를) 줍니다. 그가 말한 야수에게 사용한 뒤 {area:186}의 그에게 막대를 가져가세요. 나무그물 늑대거미는 마을 주변을 기어 다니고, 긴발톱 흑호와 {npc:1996}은(는) 마을 남쪽 숲을 돌아다닙니다.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "{area:188}에서 남서쪽 길을 따라 {area:186}(으)로 가세요.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "흑호, 스트리기드 올빼미, 나무그물 늑대거미가 동쪽 길을 따라 삽니다. 달샘은 {area:260} 서쪽 끝에 있습니다.",
	-- ["The {area:264}"] = "{area:264}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "달의 신전의 {npc:11401}: {spell:10797}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150}은(는) {area:260}(으)로 가는 길, {area:186} 바로 동쪽 길가에 앉아 있습니다.",
	-- ["{npc:3595}, inside the tree"] = "나무 안의 {npc:3595}",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "나무 안의 사제 상급자 {npc:3595}",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}: {spell:1259799}와(과) {spell:20580}을(를) 시전한 뒤 {npc:3595}에게 완료하세요",
}
