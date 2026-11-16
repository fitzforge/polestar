-- Korean (koKR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "{zone:1447}(으)로",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "{area:415}에서 길을 따라 동쪽으로 {area:2358}을(를) 지나 {zone:1447}(으)로 가세요: {area:1235}은(는) 경계 바로 너머, {zone:1447} 남서쪽 구석에 있습니다.",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "길을 따라 동쪽 {area:1235}(으)로",

	-- Step 2: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "섀도송 제단은 {area:3137} 남쪽, {zone:1447} 남서쪽 구석에 있습니다.",

	-- Step 3: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "제단 바로 북동쪽: {npc:239822}와(과) {npc:240482}이(가) {area:3137}의 얼라이언스 야영지를 지키고 있습니다.",

	-- Step 4: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "작은 이끼발굽순록",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "작은 이끼발굽순록(45-47)은 사티로스에게 가는 길목인 {area:3137} 북쪽 언덕에서 풀을 뜯습니다.",

	-- Step 5: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "명가 유령들이 제단 주변 폐허를 떠돌고, 할다르 사티로스가 그 바로 북쪽 야영지를 차지하고 있습니다. {npc:222478}은(는) 사티로스 야영지에 붙잡혀 있습니다: 풀어 주고 밖까지 호위하세요.",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}, 야영지 안",
	["Help her escape the camp"] = "야영지 탈출 돕기",

	-- Step 6: The western shore
	["The western shore"] = "서쪽 해안",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "원한의꼬리일족 전사(46-47)와 절규자(47-48)가 사티로스 북동쪽의 서쪽 해안을 차지하고 있습니다.",

	-- Step 7: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "남서쪽 {area:3137}(으)로 돌아가세요.",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}: {quest:88809}, 유물은 앞으로 잡을 나가에게서 나옵니다",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}: {quest:92345}, {zone:1457}의 {npc:4217}용, 보관하세요",

	-- Step 10: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "제단에서 북동쪽으로 가세요. {npc:8405}은(는) 길 위 언덕의 {area:1224}에 진을 치고 있습니다.",

	-- Step 11: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 12: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "{area:1221}의 원한의꼬리일족 나가가 {item:13815}을(를) 가지고 있습니다. {npc:8507}의 룬은 폐허 사이에 서 있습니다. 각각에 그의 {item:10445}을(를) 사용하세요. 이곳의 나가는 아래 레벨 보충 단계에서 요구하는 몹이므로, 여기서 처치한 수도 포함됩니다.",

	-- Step 14: Level 51.3 on the way north
	["Level 51.3 on the way north"] = "북쪽으로 가는 길에 51.3레벨까지",
	-- {npc:8395} Sanath Lim-yo · {npc:8420} Kim'jael · {area:1417} Sunken Temple
	-- plural, as words: Spitelash Myrmidons = {npc:6196} Spitelash Myrmidon
	["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "{npc:8395}의 야영지와 북쪽 사이 폐허의 원한의꼬리일족 미르미돈(50-51)을 사냥해 51.3레벨까지 올리세요. {npc:8420}의 야영지에 있는 블러드 엘프는 51-53레벨입니다. 또는 파티가 있다면 대신 {area:1417} 던전을 도세요.",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "",

	-- Step 15: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "이 폐허의 원한의꼬리일족 나가는 레벨 보충 여부와 상관없이 트루송의 엘다라스 유물을 떨어뜨립니다. {npc:239939}(52)은(는) 미르미돈 남서쪽의 엘다라스 폐허에 서 있습니다. 그만 따로 끌어오세요.",

	-- Step 16: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903}은(는) {npc:8420}에게 가는 북쪽 길가에 진을 치고 있습니다. 그의 사티로스는 {npc:8420}의 야영지에 있습니다.",

	-- Step 17: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "{npc:8761}",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "가장 가까운 덩치큰 이끼발굽순록은 {area:1224} 북동쪽, {area:1219} 쪽 언덕에서 풀을 뜯고, 더 큰 무리는 남쪽 평지를 돌아다닙니다.\n주의: 덩치큰 이끼발굽순록은 52-53레벨로 여기서는 당신보다 한두 레벨 높습니다. 무리 가장자리에서 하나씩 끌어오세요.",

	-- Step 20: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420}은(는) 북쪽의 {area:1219}에 진을 치고 있으며, 그의 장비는 바로 남동쪽의 {area:1220} 곳곳에 흩어져 있습니다.\n주의: 블러드 엘프 감정관은 51-52레벨, 회수자는 52-53레벨이며, 그 사이에 {npc:6647}(53)이(가) 있습니다. 야영지 가장자리에서 장비를 챙기고 엘프는 하나씩 끌어오세요.\n{npc:235903}의 사티로스, 도적, 지옥소환사(51-53)는 {npc:8420}의 야영지 주변에 있는 레가쉬 일족입니다. 더 동쪽의 레가쉬 영혼강탈자, 지옥지기, 흑기사(53)는 해당되지 않으니 그 서쪽에 머무르세요.",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",

	-- Step 23: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "남쪽으로 돌아가는 길에 {npc:235903}에게 사티로스 퀘스트를 제출하세요.",

	-- Step 24: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, 약 10%",

	-- Step 25: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 27: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 28: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 30: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "{zone:1447} 남쪽 끝 앞바다의 작은 섬까지 헤엄쳐 가세요. {npc:8392}이(가) 없다면 {item:10444}을(를) 쏘아 신호를 보낸 뒤 착륙할 때까지 기다리세요.",

	-- Step 31: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back to Truesong at {area:3137} before you hearth."] = "귀환석을 쓰기 전에 {area:3137}의 트루송에게 돌아가세요.",

	-- Step 32: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "{zone:1455}(으)로",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "귀환석이 {zone:1455}에 설정되어 있습니다({zone:1425} 가이드에서 그곳으로 정합니다). 귀환석으로 여관에 돌아가십시오.",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "{zone:1455} 여관",

	-- Step 34: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "아케소누스는 {object:171709}에서 국왕 마그니 브론즈비어드 옆에 서 있습니다.",

	-- Step 35: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701}은(는) 이 레벨에서는 파티 퀘스트입니다. 유물은 53-55레벨의 전투절단기와 타우릿산 조사단원 사이에 있고 근처에 {npc:8978}(57)도 있어 당신보다 2~5레벨 높으며, 경로상 이후에 {zone:1428}을(를) 다시 방문하지 않습니다. 파티를 맺는 것을 권장하니 함께할 사람을 찾아보세요. 혼자라면 건너뛰세요.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "유물은 {zone:1428}에 있습니다: 보관하세요",

	-- Step 36: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",

	-- Step 37: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",

	-- Step 38: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "정예 몹입니다. 파티를 맺는 것을 권장하니 함께할 사람을 찾아보세요. {npc:7977}(48레벨 정예)은(는) 2인 파티가 필요합니다. 혼자라면 건너뛰세요. 경로에서 사냥으로 경험치를 보충하게 됩니다.\n{npc:7977}은(는) {area:307} 아래 {zone:1425} 해안을 따라 화살표 지점에서 남쪽으로 약 75,66까지, 북쪽으로 약 82,52까지 돌아다닙니다. 화살표 지점에 없다면 해안을 따라가세요.",

	-- Step 39: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 40: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "{area:271}에서 북쪽으로 알터랙에 들어가 서쪽으로 {area:279}의 성벽까지 가세요. {npc:34365}은(는) 성벽 밖에 서 있습니다. 그녀의 퀘스트는 이 가이드가 나중에 날아가는 {area:1438}의 {npc:266524}에게 제출합니다.",

	-- Step 41: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "",

	-- Step 42: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "",

	-- Step 43: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 44: Chillwind Camp
	["Ride back south to the camp."] = "남쪽 야영지로 돌아가세요.",
	-- {area:199} Felstone Field · {zone:1452} Winterspring
	["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "보관하세요: {area:199}의 가마솥은 약 55레벨, {zone:1452} 가이드의 서리바람 야영지 방문 때 진행합니다",

	-- Step 45: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}의 유령은 {area:200} 서쪽, {area:199}의 농가 근처를 떠돕니다. 소포는 농가 안에 있습니다.",
	["Upstairs"] = "위층",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "{zone:1453}용: 보관하세요",

	-- Step 46: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 47: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "{area:69}(으)로 비행",

	-- Step 48: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "{area:69}에서 동쪽으로 나가 고개를 넘어 {zone:1428}(으)로 가십시오. {area:2418}은(는) 꼭대기에 있습니다.",

	-- Step 49: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "",

	-- Step 50: Level 52 at Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Level 52 at {area:249}"] = "{area:249}에서 52레벨까지",
	-- {area:249} Dreadmaul Rock · {area:1417} Sunken Temple
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre
	["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "먼저 감시초소 북쪽, {area:249} 가까운 쪽의 불자루 오우거(50-51)를 사냥해 52레벨까지 올리세요. 동쪽의 투사는 52-53레벨입니다. 또는 파티가 있다면 대신 {area:1417} 던전을 도세요.",
	-- {npc:7033} Firegut Ogre
	["grind on {npc:7033}"] = "{npc:7033} 사냥",

	-- Step 51: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "불자루 오우거가 감시초소 북쪽의 큰 바위를 차지하고 있고, 불자루일족 투사는 그 동쪽에 있습니다.\n주의: 탈출한 화산 사냥개(60레벨)가 초원을 돌아다니며, 일부는 {area:249} 서쪽과 남쪽 비탈에 있습니다. 바위 위에서 오우거를 끌어오고, 끌어오기 전마다 주위를 살피세요.",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "",

	-- Step 52: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "{npc:9177}의 다음 임무({npc:9176}, 그리고 검은바위부족 메달 50개)는 {area:254} 기슭의 55-58레벨 검은바위부족 오크 사이로 보냅니다. 건너뛰세요.",

	-- Step 53: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "길을 따라 서쪽으로 간 뒤 북쪽으로 올라가 {area:251}의 고블린 야영지로 가세요.",

	-- Step 54: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "{area:251} 동쪽 비탈의 {npc:7047}이(가) 죽기 직전에 {item:12284}을(를) 사용한 뒤, 남긴 정수를 획득하세요.\n주의: {npc:8981}(56레벨, 희귀)이(가) 새끼용 근처 비탈을 돌아다니며, 주변의 {npc:7040}과(와) 용족은 정예입니다. 가장자리의 새끼용에게 속박장치를 사용하고, 끌어오기 전마다 주위를 살피세요.",

	-- Step 55: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "유물은 {area:251} 주변 {area:250} 곳곳에 흩어진 조각된 돌입니다. 정보를 복원할 때까지 클릭하세요. {area:251}에 가장 가까운 폐허 남쪽 가장자리의 것을 챙기세요.\n주의: 폐허의 전투절단기와 타우릿산 조사단원은 53-55레벨이며, {npc:8978}(57)이(가) {area:251} 남서쪽의 {object:147516} 야영지를 지키고 있습니다. 폐허 가장자리의 유물을 챙기고, 하나씩 끌어오며, 야영지에는 가까이 가지 마세요.",

	-- Step 56: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "{zone:1452} {area:2255}의 {quest:4808}에게서 끝납니다: 보관하세요",

	-- Step 57: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "{zone:1427}에서 얻은 {item:10569}을(를) 열어 {item:10575}을(를) 꺼낸 뒤, {npc:9459}에게 업적의 증거를 가져왔다고 말하세요. 비룡과 싸울 필요는 없습니다.",
	["Below ground"] = "지하",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, 보물에서",

	-- Step 59: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 61: Level 52.08
	["Level 52.08"] = "",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "",

	-- Step 62: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "길을 따라 동쪽으로 감시초소에 돌아가세요.",

	-- Step 63: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "{area:1438}(으)로 날아가기",

	-- Step 64: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "아달란은 {area:1438} 안에 있습니다.",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}: {quest:87295}, 비늘은 앞쪽의 바실리스크에게서 얻습니다",

	-- Step 65: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "{zone:1419}에서 북쪽으로 {zone:1435}에 들어가세요. {npc:10996}은(는) {zone:1419}에서 이어지는 길가에 서 있습니다. 북동쪽의 호드 마을인 {area:75}에는 가까이 가지 마세요.",

	-- Step 66: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "그의 이야기를 들은 뒤 남쪽으로 쿰이샤에게 돌아가세요.",

	-- Step 67: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "{zone:1419}(으)로 돌아가기",
	["Bloodmages' camp"] = "혈법사 야영지",

	-- Step 68: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "혈법사들이 원하는 짐승을 잡으러 남쪽 {zone:1419}(으)로 돌아가세요. 굶주린 칼송곳니하이에나는 혈법사 야영지 남쪽의 메마른 언덕을 돌아다니고, 스콜포크 독침전갈은 북쪽 중앙을 기어다니며, {npc:5982}은(는) 그 위 전역을 맴돕니다. 잿빛갈기멧돼지와 붉은바위 바실리스크는 요새 남서쪽 비탈에 함께 있습니다.\n주의: 이곳에는 정예 둘이 돌아다닙니다. {npc:221740}(50)은(는) 지역 중앙 44,34 부근에, {npc:247015}(55)은(는) 39,32 부근 능선에 있습니다. 보이면 다른 곳에서 사냥하세요.",

	-- Step 70: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "쿰이샤는 요새 남서쪽 언덕인 {area:2517}에서 기다립니다. 가는 길의 {zone:1419} 몹이 불완전한 드레니시스트 조각을 떨어뜨립니다. 가진 만큼 가져다주세요. 요새에서 길을 따라 곧장 언덕으로 가고, 같은 길로 돌아오세요.\n주의: 펠큘라, {npc:7664}, 일리파는 모두 60레벨 정예입니다. 라젤리크는 {spell:2691}, {spell:8255}, 대학살을 시전하며, 생명력이 줄어들수록 {object:141891}, {spell:10854}을(를) 더하고 15%에서 격노합니다.\n주의: 55레벨 정예인 {npc:247015}이(가) 쿰이샤의 언덕 옆(약 50,35)과 서쪽(약 39,32)에 있고, 주변의 공포망치 및 어둠맹세 야영지는 53-55레벨입니다. 조각은 그의 옆이 아니라 요새에서 오는 길의 몹에게서 얻으세요.",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "",

	-- Step 71: The bloodmages
	["The bloodmages"] = "",
	-- {zone:1419} Blasted Lands
	["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "북쪽으로 {zone:1419}(으)로 이어지는 길가의 혈법사 야영지로 가세요.",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "혈법사들의 두 번째 단계는 같은 재료에 경험치 없이 강화 아이템만 줍니다: 건너뛰십시오.",

	-- Step 72: Bernie Heisten
	-- {npc:3546} Bernie Heisten · {area:1438} Nethergarde Keep
	["Back to {npc:3546} in {area:1438} before you hearth."] = "귀환석을 쓰기 전에 {area:1438}의 {npc:3546}에게 돌아가세요.",

	-- Step 73: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "귀환석으로 {zone:1455} 여관에 돌아가십시오.",

	-- Step 74: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "{area:144}(으)로 비행",

	-- Step 77: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144} 비행 조련사",

	-- Step 80: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "아케소누스는 {object:171709}에서 국왕 마그니 브론즈비어드 옆에 서 있습니다. 불타는 평원에서 읽은 유물은 그의 것입니다.",

	-- Step 81: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",

	-- Step 83: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 84: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "올빼미야수는 {zone:1452}에 있습니다: 보관하세요",

	-- Step 87: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "{area:702}의 차원문은 {zone:1457}(으)로 올라갑니다. {npc:9047}은(는) 도시 북쪽의 {area:1658}에서 기다립니다.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, {area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455}에는 드루이드 상급자가 없습니다",

	-- Step 88: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217}은(는) {area:1658}의 드루이드 건물 위층에 있습니다. 남쪽 문으로 들어가세요.",
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, 위층",

	-- Step 89: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740}은(는) 도시 남쪽 달의 신전에서 티란데 옆에 서 있습니다.",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {area:976}에서 받은 {quest:162}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1422} Western Plaguelands
	["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "{zone:1422} 가이드에서 {area:976}의 {npc:5594}에게 줄 것: 보관하세요",

	-- Step 90: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "{zone:1438}행 차원문",

	-- Step 91: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}은(는) {npc:7916} 위층에 서 있습니다. 건물 안에서 올라가십시오. 화살표는 층을 구분하지 못합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Class trainer"] = "직업 전문가",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "폐허 위 {area:1224}의 {npc:8405}에게 다시 올라가세요.",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "{area:249} 꼭대기에 올라가 부드러운 흙더미에 머리를 꽂으세요.",
	-- ["Druid training"] = "드루이드 수련",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "{zone:1455}에서 {area:150}(으)로 날아가 배를 타고 {area:442}(으)로 가세요.",
	-- ["Fly from {zone:1455} to {area:69}."] = "{zone:1455}에서 {area:69}(으)로 날아가세요.",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "{area:150}(으)로 날아가 배를 타고 {area:442}(으)로 간 뒤, 다시 배를 타고 {area:702}(으)로 가세요.",
	-- ["From the {area:442} dock, fly to {area:415}."] = "{area:442} 부두에서 {area:415}(으)로 날아가세요.",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "선택: {npc:8395}이(가) 야영지 주변 히포그리프에게서 얻는 {item:10450} 2개를 원합니다. 데이터에는 경험치가 나와 있지 않습니다.",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "선택: {npc:8888}의 유령은 {area:254} 안 거대한 사슬 위 그의 무덤에 서 있으며, 죽은 자만 그를 볼 수 있습니다. 어차피 산 근처에서 죽었다면 부활하기 전에 영혼 상태로 그에게 달려가세요.",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "사제와 마법사는 운고로 가이드 끝에서 이곳에서 수련했습니다",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "{area:251} 남서쪽 폐허 사이의 {object:147516} 야영지에서 석판을 읽고 내용을 베끼세요.",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "{area:1438}(으)로 돌아가 {area:348}(으)로 날아가세요. {item:10819}은(는) {area:348} 남쪽과 동쪽, 올빼미야수가 돌아다니는 {zone:1425} 곳곳의 땅바닥에 있습니다. 이곳 몹은 이제 당신보다 한참 낮습니다.",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "길을 따라 동쪽으로 {zone:1440}을(를) 벗어나 {zone:1447}에 들어가 {area:3137}의 파수꾼 야영지로 가세요.",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "{zone:1419}에서 북쪽으로 {zone:1435}에 들어가세요. {npc:10996}은(는) {zone:1419}에서 이어지는 길가에 서 있습니다. 북동쪽의 호드 마을인 {area:75}에는 가까이 가지 마세요. 그의 이야기를 들은 뒤 남쪽으로 쿰이샤에게 돌아가세요.",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "{area:69}에서 북쪽으로 고개를 넘어 {zone:1428}에 들어가세요. {area:2418}은(는) 고개 꼭대기, 초원 남동쪽에 있습니다.",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "{area:16} 남쪽 끝 앞바다의 작은 섬까지 헤엄쳐 가세요. {npc:8392}이(가) 기념비 옆에서 기다립니다.",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "{zone:1447} 남쪽 끝 앞바다의 작은 섬까지 헤엄쳐 가세요. {npc:8392}이(가) 기념비 옆에서 기다립니다.",
	-- ["Thaurissan Relics"] = "{object:153556}",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "명가 유령들이 제단 주변 폐허를 떠돌고, 할다르 사티로스가 그 바로 북쪽 야영지를 차지하고 있습니다.",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}의 원한의꼬리일족 나가가 {item:13815}을(를) 가지고 있습니다. {npc:8507}의 룬 네 개는 폐허 사이에 서 있습니다. 각각에 그의 {item:10445}을(를) 사용하세요.",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "가장 가까운 {npc:8761}은(는) {area:1224} 북동쪽, {area:1219} 쪽 언덕에서 풀을 뜯고, 더 큰 무리는 남쪽 평지를 돌아다닙니다.",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "유물은 {area:251} 주변 {area:250}에 흩어진 조각된 돌입니다. 정보가 복구될 때까지 클릭하세요.",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "섀도송 제단은 {area:3137} 남쪽, {area:16} 남서쪽 구석에 있습니다.",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "{area:251} 동쪽 비탈의 {npc:7047}이(가) 죽기 직전에 {item:12284}을(를) 사용한 뒤, 남긴 정수를 획득하세요.",
	-- ["Wildkin feathers"] = "올빼미야수 깃털",
	-- ["{area:199} cauldron"] = "{area:199} 가마솥",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}이(가) 안돌할 서쪽 {area:199}의 가마솥을 지킵니다.",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}은(는) 요새 남서쪽 언덕인 {area:2517}에서 기다립니다. 가는 길의 {zone:1419} 몹이 {item:10593}을(를) 떨어뜨립니다. 가진 만큼 가져가세요.",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395}은(는) 야영지 주변의 천둥머리 히포그리프, 즉 이곳에서 사냥하며 경험치를 채우는 히포그리프에게서 손상되지 않은 히포그리프 깃털 2개를 원합니다. 약 3마리 중 1마리가 깃털을 가지고 있습니다.",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}은(는) 북쪽 {area:1219}에 진을 치고 있으며, 그의 장비는 바로 남동쪽 {area:1220} 곳곳에 흩어져 있습니다.",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176}와(과) 검은바위부족 오크가 {area:251} 서쪽, {area:254} 기슭의 야영지와 요새를 차지하고 있습니다. 하나씩 끌어오세요. 오크와 늑대 모두 메달을 떨어뜨릴 수 있으니 50개가 될 때까지 처치하세요.\n주의: {npc:9176}에게는 연결된 경비병이 있어 함께 싸우며, 또 다른 병사가 가까이에서 순찰합니다. 끌어오기 전에 순찰병을 처치하세요.\n주의: 60레벨 불의 정령인 불의 맹약자가 초원을 돌아다니며, 일부는 검은바위부족 야영지 사이에 있습니다. 끌어오기 전마다 살피고 지나가게 두세요.",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: 검은바위부족 오크가 메달을 떨어뜨립니다. 불타는 평원 내내 열어 두세요",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}에는 드루이드 상급자가 없습니다. 차원문을 타고 {zone:1457}(으)로 올라가 {area:1658}에서 수련한 뒤 {area:702}(으)로 내려오세요.",
}
