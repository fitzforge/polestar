-- Korean (koKR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, \"늪지눈알\" 자를에게 줄 것",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "{area:378}(으)로 날아가기",
	["Crossroads flight master"] = "크로스로드 비행 조련사",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "{area:378}에서 길을 따라 동쪽으로 늪지대에 들어가세요. 불타 버린 {area:403}은(는) 경계를 막 지난 길가에 있습니다. 방패, 휘장, 발굽 자국은 폐허 안과 옆에 있습니다.",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "갈림길에서 북쪽 길로 가서 오우거 마을인 담쟁이 마을로 가세요.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "길이 들어오는 마을 남쪽 끝의 {npc:4503}",

	-- Step 11: Stinky Ignatz
	["Stinky Ignatz"] = "말썽꾼 이그나츠",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "북쪽의 {area:502}(으)로 가세요. 이그나츠는 언덕 기슭에 서 있습니다. 그 바로 남쪽에서 진흙콩 잎을 모으는 동안 그를 호위하세요.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "진흙아가미멀록",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "진흙아가미멀록은 {area:502} 동쪽과 북동쪽 해안에 몰려 있습니다. 모든 종류가 머리를 떨어뜨립니다.",

	-- Step 13: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "늪지눈알 자를",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "자를은 {area:502} 남동쪽의 {area:497}에 삽니다.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "저택 옆의 {object:20985}",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 14: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Lurkers = {npc:4411} Darkfang Lurker · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Lurkers (36-37) and Venomspitters (37-38) on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes. Work its outer edge, where the Spiders and Recluses (35-37) stand: the Lurkers and Silkspinners (37-39) deeper in are two or three over you.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "늪지대를 가로질러 서쪽으로 돌아가세요. 담쟁이 마을 북쪽 능선의 검은송곳니 늑대거미(36-37)와 독침거미(37-38)가 독주머니를 떨어뜨립니다. 같은 숲에 테라모어 첩보원(35-36)이 숨어 다니니 잘 살펴보세요.\n담쟁이 마을 북서쪽 동굴 입구에 암흑안개 거미가 득실거립니다. 모든 종류가 눈을 떨어뜨립니다. 거미와 은둔거미(35-37)가 있는 바깥쪽에서 잡으세요. 안쪽의 늑대거미와 비단거미(37-39)는 나보다 2-3레벨 높습니다.\n주의: 검은송곳니 늑대거미(36-37 레벨)는 비전투 중 은신하고 전투가 시작되면 독을 사용합니다.\n주의: 같은 지역의 은신한 거미는 보는 즉시 공격합니다.\n주의: 암흑안개 늑대거미는 은신한 채 돌아다니며 전투 중 독을 사용합니다. 거미들이 가까이 붙어 있어 추가로 끌려오기 쉬우니, 바깥쪽에서 한 마리씩 끌어오세요.",
	-- plural, as words: Giant Darkfang Spiders = {npc:4415} Giant Darkfang Spider
	["Every Darkfang spider drops them: Lurkers, Spiders, Venomspitters and the Giant Darkfang Spiders"] = "",

	-- Step 16: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire · {npc:5045} Private Hallan
	-- plural, as words: Theramore Skirmishers = {npc:5044} Theramore Skirmisher
	["On the way east, {npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out: {npc:5045} and Theramore Skirmishers (36) join it."] = "동쪽으로 가는 길에 {npc:4983}이(가) 마을 동쪽 {area:2302}에서 기다립니다. 그를 따라 리테에게 가서, 벌어지는 싸움에서 그를 살려 두세요. {npc:5045}와(과) 테라모어 척후병(36)이 싸움에 끼어듭니다.",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["On east to the {area:497}."] = "계속 동쪽의 {area:497}(으)로 가세요.",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{npc:4791}이(가) 보고서를 읽은 뒤의 {object:20985}",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "{item:3853}을(를) 가지고 있을 때만({skill:164} 또는 경매장)",

	-- Step 18: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	-- plural, as words: Young Murk Threshers = {npc:4388} Young Murk Thresher
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer. Young Murk Threshers (40-41) circle in the water around the docks: grab the footlocker and swim straight out."] = "저택에서 남동쪽으로 {area:513}까지 가세요. {object:20925}은(는) 섬 동쪽 부두 앞바다 해저에 있습니다. 헤엄쳐 들어갔다 나오고 부두와 마을은 피하세요. 테라모어 경비병은 53-57 레벨이며, 여기서 죽으면 영혼의 치유사에게서 먼 길을 달려와야 합니다. 새끼 늪지트레샤돈(40-41)이 부두 주변 물속을 돌고 있으니 사물함을 챙기고 곧장 헤엄쳐 나오세요.",
	["Underwater"] = "물속",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike · {npc:4926} Krog
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} and {npc:4926} in the village."] = "머리를 가지고 서쪽 담쟁이 마을로 돌아가세요. {npc:4503}은(는) 길이 들어오는 마을 남쪽 가장자리에, {npc:4791}와(과) {npc:4926}은(는) 마을 안에 있습니다.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 20: Level 36
	["Level 36"] = "",
	-- {zone:1443} Desolace
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "{zone:1443}의 마지막 퀘스트는 36-39 레벨입니다. 담쟁이 마을에서 퀘스트를 제출하고도 36 레벨이 안 되나요? 마을 동쪽 강가의 늪지악어(35-36)가 가장 가까운 적정 레벨 몹입니다. 36 레벨까지 처치하세요.",
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["Drywallow Crocolisks"] = "늪지악어",
	-- {npc:4341} Drywallow Crocolisk
	["grind on {npc:4341}"] = "{npc:4341} 사냥",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 22: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446}은(는) 비행 조련사 옆 가즐로의 집 아래, 부두 쪽에 서 있습니다.",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",

	-- Step 24: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",
	-- {area:392} Ratchet
	["Back north along the coast to {area:392}'s flight master."] = "해안을 따라 북쪽으로 {area:392}의 비행 조련사에게 돌아가세요.",

	-- Step 25: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["Fly to {area:2408} from the flight master you are next to: {area:392}'s, or Brackenwall's if you had no errand in {area:392}."] = "지금 옆에 있는 비행 조련사에게서 {area:2408}(으)로 날아가기. {area:392}의 비행 조련사, {area:392}에 볼일이 없었다면 담쟁이 마을의 비행 조련사입니다.",

	-- Step 26: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {npc:12340} Drulzegar Skraghook
	["{npc:11624} and {npc:12340} stand in the village."] = "{npc:11624}와(과) {npc:12340}은(는) 마을 안에 있습니다.",
	-- {npc:11624} Taiga Wisemane · {quest:5381} Hand of Iruxos · {area:599} Thunder Axe Fortress
	["{npc:11624}: the {quest:5381}, at {area:599} later on this visit"] = "{npc:11624}: {quest:5381}, 이번 방문 중 나중에 {area:599}에서",
	-- {npc:12340} Drulzegar Skraghook · {area:599} Thunder Axe Fortress
	["{npc:12340}: the Slitherblade of Sar'theris Strand, on the way back from {area:599}"] = "{npc:12340}: 살테리스 해안의 미끈비늘, {area:599}에서 돌아오는 길에",

	-- Step 27: Ghost Walker Post
	-- {area:597} Ghost Walker Post · {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["East along the road to {area:597}; {npc:5412} stands beside {npc:5395}."] = "길을 따라 동쪽의 {area:597}(으)로 가세요. {npc:5412}은(는) {npc:5395} 옆에 서 있습니다.",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine as Gurda's totems"] = "{npc:5395}: 구르다의 토템과 같은 마라우딘에게서 얻는 그의 {quest:1366}",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty · {npc:5402} Khan Hratha
	-- plural, as words: Rock Worms = {npc:11788} Rock Worm
	["West of the post, the Maraudine centaurs hold the {area:607}; every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Scouts and Wranglers (36-38) at the valley's eastern edge; the Maulers and Windchasers (38-39) a little further in are up to two over you at 37: pull them one at a time.\nCareful: {npc:5402} and the Rock Worms (41-42, elite) hold the valley's north-western end with the Khan Guards and Marauders (39-40), and the Magram's village in the south-east has Necromancers (42-43): keep east of the arrow."] = "초소 서쪽의 {area:607}은(는) 마라우딘 켄타우로스가 차지하고 있습니다. 모든 마라우딘이 {item:254432}와(과) {npc:5395}의 {quest:1366}에 쓸 귀를 떨어뜨릴 수 있습니다. 골짜기 동쪽 가장자리의 정찰병과 조련사(36-38)만 상대하세요. 조금 더 안쪽의 난폭꾼과 바람추적자(38-39)는 37레벨인 당신보다 최대 2레벨 높습니다. 한 번에 한 마리씩 끌어오세요.\n주의: {npc:5402}와(과) 바위미늘벌레(41-42, 정예)가 칸 경비병, 약탈자(39-40)와 함께 골짜기 북서쪽 끝을 차지하고 있으며, 남동쪽의 마그람 마을에는 강령술사(42-43)가 있습니다. 화살표 동쪽에 머무르세요.",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}은(는) {area:596} 서쪽의 고블린 야영지에서 기다립니다.",
	-- {npc:6019} Hornizz Brimbuzzle · {area:602} Mannoroc Coven
	["{npc:6019}: the ghost-o-plasm, after {area:602} at the end of this visit"] = "{npc:6019}: 이번 방문 마지막에 {area:602}을(를) 마친 뒤 유령 원형질",

	-- Step 32: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["North up the road to {area:599}. Clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}. The Burning Blade around it are well under you now."] = "길을 따라 북쪽의 {area:599}(으)로 가세요. 가장 큰 건물 가운데를 정리한 뒤, 그곳의 붉은 {object:176581}에 {item:14523}을(를) 사용하세요. {npc:11876}(37)이(가) 나타납니다. 처치하고 {item:13542}을(를) 얻으세요. 주변의 불타는 칼날단은 이제 당신보다 훨씬 낮습니다.",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal
	["{item:14523}, on the {object:176581}"] = "",

	-- Step 33: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "요새에서 서쪽으로 {area:598} 해안으로 가세요. 뱀갈퀴일족 미르미돈, 나가, 여마법사가 해변을 차지하고 있습니다. 한 번에 한 마리씩 끌어오세요. 바다 마녀와 예언자(34-36)는 원거리에서 주문을 겁니다.",

	-- Step 34: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {area:602} Mannoroc Coven · {npc:12340} Drulzegar Skraghook
	["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "해안을 따라 남쪽의 그림자약탈 마을로 가세요. {npc:11624}이(가) 상자를 받고 그것을 들고 {area:602}(으)로 보냅니다. {npc:12340}은(는) 나가 퀘스트를 받습니다.",

	-- Step 35: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 36: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {zone:1443} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "집회장 남동쪽, {zone:1443} 남쪽 끝에 언데드 약탈자가 배회하는 {area:2657}의 뼈 들판이 있습니다. 가는 길에 마그람 마을 남쪽으로 지나가세요. 화살표 지점에서 {item:15848}을(를) 사용해 마그라미 망령(38-39)을 끌어내세요. 여러 마리가 몰려오니 골짜기 가장자리를 등지고 싸우세요. 망령이 유령 원형질을 떨어뜨립니다.\n주의: 마그람 강령칸과 시체먹이(45, 정예)가 화살표 바로 서쪽 뼈 들판을 돌아다니며, 당신보다 훨씬 강합니다. 골짜기 동쪽의 화살표 지점에서 상자를 사용하고 망령을 그들에게서 떨어진 곳으로 끌어오세요.",

	-- Step 37: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard · {area:602} Mannoroc Coven
	["North-west to the goblin camp on the west side of the {area:596}, back past {area:602}: keep west of the Magram's village."] = "{area:602}을(를) 다시 지나 북서쪽으로 {area:596} 서쪽의 고블린 야영지로 가세요. 마그람 마을 서쪽으로 지나가세요.",

	-- Step 38: Shadowprey
	["Shadowprey"] = "",
	["Hearth to Shadowprey: your hearthstone is still bound there."] = "그림자약탈 마을로 귀환석을 사용하세요. 귀환석은 아직 그곳에 설정되어 있습니다.",

	-- Step 39: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 40: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408} 비행 조련사",

	-- Step 41: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 42: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",

	-- Step 43: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "",

	-- Step 44: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "검은송곳니 거미",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "다음 가이드에서 {object:3202}의 {npc:2519}에게",
	-- ["Head east back to the {area:497}."] = "동쪽의 {area:497}(으)로 돌아가세요.",
	-- ["Hearth to {area:392}"] = "귀환석으로 {area:392}에 가기",
	-- ["Kodo bones and ghosts"] = "코도 뼈와 유령",
	-- ["Maraudine totems"] = "마라우돈일족 토템",
	-- ["North to the goblin camp on the west side of the {area:596}."] = "북쪽으로 {area:596} 서쪽의 고블린 야영지로 가세요.",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "묘지 곳곳에 흩어진 코도 뼈를 줍고, 뼈 사이에서 {item:15848}을(를) 사용하세요. 끌려온 유령이 유령 원형질을 떨어뜨립니다.",
	-- ["Ride back west to Brackenwall with the head."] = "머리를 가지고 서쪽의 담쟁이 마을로 돌아가세요.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "동쪽의 {area:602}(으)로 가세요. 악마 차원문마다 추방의 막대를 사용해 여섯 개를 닫으세요.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "소굴에서 북쪽으로 {area:597}의 {npc:5412}에게 가세요.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "길을 따라 북쪽으로 묘지 북쪽 길가의 오두막으로 가세요.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "북동쪽의 {area:607}(으)로 가세요. {npc:12277}은(는) 마라우돈일족 켄타우로스 야영지에 붙잡혀 있습니다. 풀어 주고 골짜기 동쪽 밖까지 호위하세요.",
	-- ["Ride on south-west to Shadowprey."] = "계속 남서쪽의 그늘수렵 마을로 가세요.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "{area:2405}에서 남쪽의 {area:607}(으)로 가세요. 마라우돈일족 척후병, 사냥꾼, 투사, 바람전사, 약탈자(36-39)가 {quest:93225}을(를) 떨어뜨립니다.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "서쪽으로 늪지대를 가로질러 돌아가세요. 담쟁이 마을 북쪽 능선의 검은송곳니 독거미가 독주머니를 떨어뜨립니다. 테라모어 첩보원(35-36)이 같은 숲에 숨어 다닙니다. 은신 중이니 잘 살피세요.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "서쪽으로 북서쪽 해안 {area:2405}에 있는 {npc:11863}의 탑으로 가세요.",
	-- ["Slitherblade coast"] = "뱀갈퀴일족 해안",
	-- ["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "저택에서 남동쪽으로 {area:513}까지 가세요. {object:20925}은(는) 섬 동쪽 부두 앞바다 해저에 있습니다. 헤엄쳐 들어갔다 나오고 부두와 마을은 피하세요. 테라모어 경비병은 53-57 레벨이며, 여기서 죽으면 영혼의 치유사에게서 먼 길을 달려와야 합니다.",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "불타는 칼날단이(가) {area:2407} 북서쪽 요새를 차지하고 있습니다. 요새 안의 {npc:11876}에게 {item:14523}을(를) 사용해 {item:13542}을(를) 얻으세요.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "암흑안개 거미는 담쟁이 마을 북서쪽 동굴 입구에 몰려 있습니다. 모든 종류가 눈알을 떨어뜨립니다.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "뱀갈퀴일족 나가는 {area:2405} 북쪽부터 {area:598}까지 해안을 차지하고 있습니다. {npc:12369}이(가) 북쪽 맨 끝에서 {quest:6027}을(를) 지키고 있습니다.",
	-- ["The next guide takes you back to {zone:1434}."] = "다음 가이드는 다시 {zone:1434}(으)로 안내합니다.",
	-- ["West to Shadowprey."] = "서쪽 그늘수렵 마을로",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}의 대상단은 {area:602} 가장자리 길에 멈춰 있습니다. 동쪽으로 소굴을 지날 때까지 호위하세요. 악마가 두 번 습격합니다.",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391}: 40-50 가이드에서 처음 {area:35}에 들를 때 {area:35}의 {npc:4631}에게",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}은(는) 마을 동쪽 {area:2302}에서 기다립니다. 그를 따라 리테에게 가서, 벌어지는 싸움에서 그를 살려 두세요.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}와(과) {npc:5412}은(는) {npc:11596} 야영지 바로 서쪽의 주둔지에 서 있습니다.",
	-- ["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395}: 같은 마라우딘에게서 얻는 그의 {quest:1366}",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
}
