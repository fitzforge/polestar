-- Korean (koKR): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "{area:221}의 고원에서 시작합니다. {npc:2980}와(과) 족장은 한가운데 큰 천막 옆에 서 있습니다.",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "초원타조는 야영지 주변 풀밭 곳곳을 돌아다닙니다.",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "전사 상급자 {npc:3059}",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "사냥꾼 상급자 {npc:3061}",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "야영지의 주술사 상급자 {npc:3062}",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "그 옆의 드루이드 상급자 {npc:3060}",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {item:4755} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991}은(는) 야영지 동쪽 가장자리 천막 옆에 앉아 있으며, {item:4755}은(는) 그 옆에 있습니다.",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775}은(는) 야영지 서쪽 끝, 산지퓨마가 돌아다니는 언덕의 북서쪽 모퉁이에 서 있습니다. 그의 퀘스트를 받고, 거기서부터 남쪽과 동쪽으로 퓨마를 사냥한 뒤 {npc:2980}에게 돌아오세요.",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:2980} 옆의 {npc:3209}",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "길을 따라 야영지에서 남쪽으로 나가 언덕 기슭의 예언자 천막으로 가세요.",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "안셰와 무샤의 제단",
	-- {object:660739} Ritual Fire (no name in this language: may be words)
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "향은 10분 안에 다 탑니다. 남쪽 언덕을 따라 곧장 동쪽의 {object:660739}(으)로 달려가세요.",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "전투멧돼지는 제단 북쪽에서 풀을 뜯고, 뾰족털 가시멧돼지는 북동쪽 협곡을 차지하고 있습니다. {npc:8554}은(는) 협곡 동쪽 끝에 서 있고, {object:3076}은(는) 야영지 바닥에 있습니다.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "서쪽의 야영지로 돌아가세요.",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888}은(는) {area:221}에 서 있습니다. {quest:1516}에는 4레벨이 필요하며, 여기서 퀘스트를 완료하면 도달합니다.",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "동쪽의 {area:358}(으)로 돌아가세요. 뾰족털일족 주술사는 그곳 가시멧돼지 사이에 있습니다.",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "야영지의 {npc:5888}에게 돌아가세요. {npc:5891}은(는) 야영지 동쪽 고원에서 기다립니다. 그곳에서 {item:6635}을(를) 마시면 보입니다. {item:6656}을(를) 예언자에게 가져가세요.",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}: {npc:5873}, {item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "길을 따라 {area:220}에서 북쪽으로 나가세요. {npc:265810}은(는) {area:222} 바로 남쪽 길에서 기다립니다. {spell:1229451}을(를) 얻을 때까지 그녀의 모닥불 옆에서 /앉기 하세요.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "{spell:1229451}을(를) 얻을 때까지 카가의 모닥불 옆에서 /앉기",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "{npc:3067}와(과) 대화하기",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "초원늑대와 다자란 초원타조가 마을 주변 평원을 돌아다닙니다.",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "우물은 마을 남동쪽에 있습니다.",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130}와(과) {quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "외로운 늑대 {quest:96130}은(는) 마을 서쪽 평원을 돌아다닙니다. 긴발톱 초원늑대와 평원퓨마는 그 북쪽과 서쪽 평원을 돌아다닙니다.",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "블러드후프 마을로 돌아가기",
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{zone:1456}의 {npc:3057}에게 갈 {npc:2993}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{zone:1456}의 하물에게 갈 {npc:2948}",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "{npc:3063}의 퀘스트: 그 옆에서 풋내기 전사 세 명(또는 결투로 플레이어)을 이기세요.",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182}은(는) 마을 북쪽 가장자리에 서 있습니다. 카일은 초원타조에게서 얻는 {item:287505}을(를) 원합니다.",

	-- Step 26: Thunderhorn Water Well
	-- {item:4809} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {item:4808} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "우물은 마을 북쪽에 있습니다. 우물돌은 우물 주변에, {item:4809}은(는) 근처 나무 아래에 있습니다. 가는 길에 {quest:766}와(과) {quest:761}을(를) 위해 늑대, 퓨마, 초원타조, 검독수리를 처치하세요.",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "마을 북쪽 끝의 {npc:277182}",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "검독수리는 블러드후프 마을 주변 평원 곳곳을 활공합니다.",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988}은(는) 블러드후프 마을 남동쪽의 {area:396} 옆에 야영하고 있습니다.",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789}은(는) 우물 조금 동쪽의 {area:821}에 서 있습니다.",

	-- Step 31: Galak centaurs and Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Galak centaurs and Prairie Wolf Alphas"] = "갈라크일족 켄타우로스와 우두머리 초원늑대",
	-- {area:821} Rolling Plains
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "갈라크일족 켄타우로스는 {area:821} 북쪽 평원에 야영하고 있으며, 헤라크가 그들을 이끕니다. 우두머리 초원늑대는 늑대들 사이를 돌아다닙니다.",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "부서진 대상단은 켄타우로스 북서쪽, {zone:1456}(으)로 가는 길 동쪽에 있습니다.",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "마을 주변 평원에서 늑대 심장, 퓨마 대퇴골, 초원타조 비늘, 검독수리 모래주머니를 마저 모으세요.",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "남동쪽의 {area:396}(으)로 돌아가세요.",

	-- Step 37: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "고블린들은 우물 북동쪽 언덕의 광산에서 일합니다. {quest:765}은(는) 광산 안쪽에 서 있습니다. 그의 {item:281031}이(가) {quest:98424}을(를) 시작하며, 나머지 쪽은 광산 안에 있습니다.",

	-- Step 38: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "북서쪽으로 {zone:1456}을(를) 지나 {zone:1412} 맨 북쪽의 {area:398}(으)로 가세요.",

	-- Step 39: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "성난바람하피는 우물 북쪽과 서쪽의 {area:819}을(를) 차지하고 있습니다.",

	-- Step 40: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984}은(는) 우물 남쪽, {area:404} 가장자리에 서 있습니다.",

	-- Step 41: Dwarven Digging
	-- {area:404} Bael'dun Digsite · {area:222} Bloodhoof Village
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "{area:404}의 드워프들이 발굴조사단장의 곡괭이를 지니고 있습니다. {area:222}의 대장간에서 부수세요.",

	-- Step 42: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "회색갈기일족 놀은 발굴지 남쪽, 블러드후프 마을 서쪽의 {area:818}을(를) 차지하고 있습니다. {npc:272203}은(는) 그들의 야영지에 붙잡혀 있습니다. 밖으로 데리고 나오세요.",

	-- Step 45: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "북쪽으로 {zone:1456} 동쪽의 {area:225}(으)로 가세요. {npc:3233}은(는) 바위 기슭에 서 있습니다. 뾰족털일족 약탈자는 매장지를 파헤치고 있고, {npc:2994}은(는) 꼭대기에서 기다립니다.",
	-- {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["Flatland Prowlers roam the plains around {area:225}"] = "굶주린 평원퓨마는 {area:225} 주변 평원을 돌아다닙니다",

	-- Step 46: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "승강기를 타고 고원으로 올라가세요. {npc:2995}은(는) 중앙 고지에서 윈드라이더를 돌보고, {npc:3057}은(는) 그곳 큰 천막에 서 있습니다.",

	-- Step 47: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068}은(는) 타우렌 향을 원합{npc:3014}. 약초 상인 니다, 마법부여 재료 상인 {npc:3012}, 가죽세공 재료 상인 {npc:3005}, 요리 재료 상인 {npc:3027}에게서 재료 네 가지를 사서 {item:278078}(으)로 합치세요.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{npc:3014}에게서 사는 {item:278079}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{npc:3012}에게서 사는 {item:278080}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{npc:3005}에게서 사는 {item:278081}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{npc:3027}에게서 사는 {item:278083}",

	-- Step 48: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "{area:1641}의 남쪽 절벽에 있는 의식용 깔개와 향로에서 {item:278078}을(를) 사용하세요.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "{area:1641}에서 {item:278078} 뿌리기",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}: {area:380}의 {quest:860}에게",

	-- Step 50: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}: {area:380}의 {npc:3448}에게",

	-- Step 52: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "중앙 고지의 {npc:6746}이(가) {area:1639}의 {npc:3033}에게 보냅니다.",

	-- Step 53: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있고, {quest:5930}은(는) 북서쪽 숲에 있습니다.",

	-- Step 54: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "귀환석으로 {area:222}에 간 뒤 북쪽의 {area:1639}(으)로 가세요.",

	-- Step 55: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "{area:222}(으)로 내려가 {item:15908}(으)로 길들이세요: 평원의 {npc:2956}, 마을 북쪽의 {npc:2959}, 북서쪽의 검독수리.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "{item:15908}(으)로 길들이기",

	-- Step 56: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "돌은 동쪽으로 가는 길에 있는 {zone:1412} 출구 고갯길에 있습니다. 그곳에서 {item:15710}을(를) 사용하고 초승달발톱을 물리치세요.",

	-- Step 57: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "남동쪽 고갯길로 {zone:1412}을(를) 나가 길을 따라 {area:380}(으)로 가세요. {quest:860}은(는) 여관 옆에, {npc:3448}은(는) 남문에 서 있습니다. {zone:1413} 가이드는 여기서 시작합니다.",

	-- Step 58: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "{area:1638}에서 직업 퀘스트 완료",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "전투멧돼지는 제단 북쪽에서 풀을 뜯고, 뾰족털 가시멧돼지는 북동쪽 협곡을 차지하고 있습니다. {npc:8554}은(는) 협곡 동쪽 끝에 서 있고, {item:4851}은(는) 야영지 바닥에 있습니다.",
	-- ["The {area:380}"] = "{area:380}",
}
