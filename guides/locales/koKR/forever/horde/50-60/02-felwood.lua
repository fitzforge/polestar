-- Korean (koKR): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "그는 {area:200} 남동쪽, {area:202} 옆에 야영하고 있습니다.",
	["Inside"] = "",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "역병에 걸린 늑대",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between {area:200} and the {area:202}, all the way west to Felstone Farm. Careful: the biggest are 54: pull them one at a time.\nAt 52, take the level 53 wolves; leave the 54s alone."] = "",

	-- Step 3: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "그의 다음 사냥감인 병든 회색곰(55-56)은 58레벨쯤 역병지대에 들를 때 처리합니다.",

	-- Step 5: High Executor Derrington
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.\n{quest:5096}을(를) 위해 델링턴 옆 상자에서 {object:176092}을(를) 챙기세요.",

	-- Step 6: Scarlet forward camp
	["Scarlet forward camp"] = "붉은십자군 전진 야영지",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "{area:152}에서 길을 따라 동쪽으로 {zone:1422}(으)로 가세요. 붉은십자군의 천막은 펠스톤 농장을 막 지나 {area:199}와(과) {area:200} 사이에 있습니다. {object:176092}(으)로 지휘 천막을 불태우고 스컬지 깃발을 꽂으세요. 주의: 천막 주변 붉은십자군은 54레벨까지 있고 기원사는 주문을 시전합니다. 지휘 천막에 가장 가까운 쪽으로 접근하고 나머지는 건드리지 마세요.",

	-- Step 7: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "남서쪽으로 펠스톤 농장을 지나 길을 따라 서쪽의 {area:152}(으)로 돌아가세요.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "데링턴의 감시탑과 반디스의 가마솥은 나중에 들를 때 처리합니다. 보관하세요.",

	-- Step 9: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "",

	-- Step 10: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",

	-- Step 11: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 12: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659}이(가) 운고로의 랩터사우루스 발톱을 받습니다. 그는 도시 중앙에서 조금 걸어가면 나오는 {object:172960}에 있습니다.",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{object:172960}의 {npc:8659}",

	-- Step 13: Class trainer
	["Class trainer"] = "직업 전문가",

	-- Step 14: Druid trainer
	["Druid trainer"] = "드루이드 상급자",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 15: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "{area:1237}(으)로 날아가기",
	-- {zone:1447} Azshara · {zone:1448} Felwood
	["{zone:1447}'s camps are 46-53, right at your level now: fly over before {zone:1448}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 16: Valormok
	-- {npc:3621} Kurll · {zone:1447} Azshara
	["{npc:3621}: Mosshoof hides on the way through {zone:1447}"] = "",
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, 블러드 엘프 비전술사의 마법봉",

	-- Step 17: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (46-52): pull them one at a time."] = "",

	-- Step 18: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "동쪽 해안의 폐허로 가세요. 해안을 따라 있는 조수 웅덩이에서 큘리의 약병 네 개를 채우세요. 원한의꼬리일족 나가가 그 사이를 순찰합니다.",

	-- Step 19: Mosshoof hides
	["Mosshoof hides"] = "",
	-- {area:1237} Valormok · {npc:3621} Kurll
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Look for Mosshoof Runners, Stags and Coursers between {area:1237} and the coast. They drop the hides for {npc:3621}."] = "",

	-- Step 20: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "마크리니 굴파기",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "마크리니 굴파기(50-51)는 폐허 바로 동쪽, 북동쪽으로 가는 길의 모래밭을 파고 있습니다. 이들과 그곳에 묻힌 은닉물에서 명가 보물 조각을 얻습니다.",

	-- Step 21: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "{zone:1447} 중앙을 가로질러 북동쪽으로 계속 가세요. {npc:235903}은(는) 길가에 야영하고 있습니다.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, 블러드 엘프 야영지 북쪽의 사티로스",

	-- Step 22: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "블러드 엘프 바로 북쪽, {area:1227} 위 절벽에 있는 고블린 야영지로 북동쪽으로 가세요.",

	-- Step 23: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "블러드 엘프는 북동쪽 {area:1227} 옆 절벽에 야영하고 있습니다. {npc:8420}의 장비 네 개는 야영지 주변 상자에 있고, 블러드 엘프 비전술사가 {npc:247473}의 마법봉을 지니고 있습니다.\n주의: 야영지 서쪽 끝에 55-57레벨 정예인 {npc:250023}이(가) 서 있습니다. 블러드 엘프는 야영지 동쪽부터 처치하세요.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "블러드 엘프 비전술사에게서 얻는 {item:246680}",

	-- Step 24: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}의 야영지",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "림토리의 야영지는 주둔지 동쪽 끝에 있습니다. 그곳의 {object:151286}을(를) 읽으세요. Forever에서는 그 옆의 신도레이 고서가 야영지 장교 세 명의 인장을 요구합니다.",

	-- Step 25: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "야영지의 장교 세 명(53)이 각각 인장을 지니고 있습니다. {npc:247006}은(는) 야영지 중앙에, {npc:247013}은(는) 동쪽 끝에 있으며, {npc:246991}은(는) 서쪽 절반을 돌아다닙니다. 화살표가 가리키는 순찰 경로의 동쪽에서 처치하세요.\n주의: 55-57레벨 정예인 {npc:250023}이(가) 야영지 서쪽 가장자리, 호크헬름 순찰 경로의 반대쪽 끝 근처에 서 있습니다. 호크헬름이 다시 동쪽으로 올 때까지 기다리세요.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{npc:247006}에게서 얻는 {item:246725}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{npc:246991}에게서 얻는 {item:246721}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{npc:247013}에게서 얻는 {item:246722}",

	-- Step 26: The Legashi satyrs
	["The Legashi satyrs"] = "레가시 사티로스",
	-- {npc:235903} Ekkal
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "레가시 사티로스(51-52)가 블러드 엘프 야영지 북쪽 언덕을 차지하고 있습니다. {npc:235903}은(는) 종류별로 다섯 마리씩 원합니다.",

	-- Step 27: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "북서쪽의 {npc:8420}에게 돌아가세요.",

	-- Step 28: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "남쪽 {area:1221}의 북쪽 가장자리로 가세요. 그곳의 원한의꼬리일족 세이렌과 미르미돈(50-52)이 {npc:8420}의 룬을 지니고 있습니다. 잘 나오지 않으니 나올 때까지 가장자리를 따라 처치하세요.",

	-- Step 29: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "룬을 가지고 북쪽의 {npc:8420}에게 돌아간 뒤, 길을 따라 남서쪽으로 가세요.",

	-- Step 30: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "길을 따라 남서쪽으로: {npc:235903}에게 사티로스를 제출하세요.",

	-- Step 31: Valormok
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "서쪽의 {area:1237}(으)로 돌아가세요.",
	-- {zone:1456} Thunder Bluff
	["Magatha is at the next {zone:1456} stop"] = "",
	-- {npc:5770} Nara Wildmane
	["{npc:5770} is there too"] = "",
	-- {zone:1452} Winterspring · {npc:8578} Magus Rimtori
	["Keep the seals for the tome. Return after {zone:1452} for {npc:8578} (55)."] = "",

	-- Step 32: Archmage Xylem
	-- {area:1237} Valormok · {npc:8395} Sanath Lim-yo
	["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "자일렘의 탑은 {area:1237} 바로 북쪽 절벽 위에 있습니다. {area:1237}의 {npc:8395}에게 말을 걸면 무료로 순간이동시켜 줍니다. 아니면 북쪽 면의 구불구불한 길로 올라가세요.",
	-- was: ["Upstairs"] = "위층"
	["Upstairs"] = "위층",

	-- Step 34: Fly back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly back to {area:1637}"] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 35: Jes'rimon
	-- {area:1237} Valormok
	["Keep the payment for the return to {area:1237}"] = "",

	-- Step 36: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",

	-- Step 38: Emerald Sanctuary
	["The druids' camp is just past the border."] = "드루이드 야영지는 경계를 막 지나서 있습니다.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10921} 옆의 {npc:10920}: {quest:86577}, {zone:1448}의 곰과 늑대 장기",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "야영지 남쪽 가장자리의 {npc:11554}",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "야영지 서쪽의 {npc:9529}",

	-- Step 39: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "",

	-- Step 40: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763} 남부",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "길을 따라 북서쪽으로 가세요. {area:1763} 남부, 오염된 달샘 주변은 어둠의 의회 이교도, 숙련사제, 수호병과 사냥개가 차지하고 있습니다.",

	-- Step 42: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763} 달샘",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "북쪽의 {area:1763}(으)로 돌아가세요. 남쪽 야영지 한가운데의 오염된 달샘에서 그레타의 수통을 채우세요.",

	-- Step 43: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763} 바로 북쪽의 호드 야영지입니다.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: 올빼미야수는 {zone:1452}에 있습니다",

	-- Step 44: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "피멍울 초소 동쪽, 혼돈의 불길과 혼돈의 소산물이 돌아다니는 구덩이투성이 골짜기입니다. 각각 두 마리씩 처치한 뒤, 지옥 물 구덩이 세 곳을 모두 걸어서 찾아가세요.",
	["Southern crater"] = "남쪽 구덩이",
	["Western crater"] = "서쪽 구덩이",
	["Northern crater"] = "북쪽 구덩이",

	-- Step 45: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	-- was: ["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "{object:661778}은(는) 골짜기 바로 남쪽, 북쪽으로 가는 길가에 있습니다. 석상의 장신구로 {area:1997}의 {npc:9996}에게 가는 퀘스트가 시작됩니다."
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996}, handed in on the last ride north past {area:1997}."] = "",

	-- Step 46: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {npc:10920} Kelek Skykeeper
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "성난발톱 곰에게서 {item:277958}",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "악령발 늑대에게서 {item:277959}",

	-- Step 47: Irontree Woods
	["Below ground"] = "지하",

	-- Step 48: The Jadefire moonwell
	["The Jadefire moonwell"] = "비취불꽃 달샘",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	-- was: ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "남쪽으로 {area:1763}을(를) 지나 비취불꽃의 사티로스가 있는 오염된 달샘으로 돌아가, 그곳에서 {npc:9996}의 작은 병을 채우세요."
	["On the return from Irontree, ride south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 49: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "로르는 {area:1761} 남쪽 끝에 서 있습니다.",

	-- Step 50: Emerald Sanctuary
	["Stop at the Sanctuary on the ride north from Ror."] = "",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "성소 서쪽의 {npc:9529}",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "{quest:5158}을(를) 보관하세요: {npc:5901}은(는) {zone:1413}에 있습니다.",

	-- Step 51: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Ride north up the road to {area:1997}, on the way to the tunnel."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",

	-- Step 52: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}의 새끼 고양이",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "새끼 고양이를 같은 달샘에 데려가 {item:12565}(으)로 풀어 주세요. {npc:10042}(으)로 변하면 {npc:9996}에게 데려가 클릭해서 건네세요.",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "비취불꽃 달샘에서 {item:12565}",

	-- Step 54: Level 54
	["Level 54"] = "",
	-- {area:16620} Alcaz Prison · {area:1584} Blackrock Depths
	["On the ride north, finish any of Talo's grizzlies and ravagers still needed. Stay with the grizzlies (51-52) until 54 before Felpaw's level 55 Avengers. Or, with a group, run the {area:16620} dungeon or the {area:1584} dungeon instead."] = "",

	-- Step 55: Nafien
	-- {area:1762} Felpaw Village · {npc:15395} Nafien
	["Follow the road north past {area:1762} to {npc:15395} at the tunnel entrance."] = "",

	-- Step 56: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh · {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	-- was: ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "주의: 보초는 53-54레벨, 마른가지일족 복수자는 54-55레벨입니다. 생명력이 50% 미만이 되면 25미터 내의 동료를 부르고, 15% 미만이면 도움을 청하러 달아납니다.\n{quest:8470}이(가) 나올 때까지 계속 처치하세요(약 30마리에 하나). 나오면 우클릭하세요. {area:1769}의 {npc:11558}은(는) 나무구렁 일족이 중립이 되면 받아 줍니다. 이미 중립이라면 지금, 아니면 마지막 가이드에서 59레벨에 동굴을 다시 지날 때 제출하세요."
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village.\nCareful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}: {quest:6031} 30개를 보관하세요. 나무구렁 평판이 중립일 때만 거래합니다. 지하",

	-- Step 57: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "{zone:1452}을(를) 위해 {quest:8465}을(를) 보관하세요.",

	-- Step 58: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside."] = "동굴에 들어가세요. {npc:11558}이(가) 바로 안쪽에 서 있습니다.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: 나무구렁 요새는 중립부터 대화해 줍니다. 이 주변을 돌아다닙니다. 지도의 원 안을 살펴보세요",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "{item:13140}을(를) 얻었다면: 사용해 퀘스트를 시작한 뒤, {area:1763} 북쪽 끝 동굴인 {area:1770}의 우리에서 {npc:11018}을(를) 풀어 주세요.",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "{area:1762}에 돌아오면 마른가지일족 털보숭이(53-54)가 터널 가까이 있고, 처치할 때마다 나무구렁 평판이 오릅니다.",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "주의: 보초는 53-54레벨, 마른가지일족 복수자는 54-55레벨입니다. 생명력이 50% 미만이 되면 25미터 내의 동료를 부르고, 15% 미만이면 도움을 청하러 달아납니다.\n{quest:8470}이(가) 나올 때까지 계속 처치하세요(약 30마리에 하나). 나오면 우클릭하세요. {area:1769}의 {npc:11558}은(는) 나무구렁 일족이 중립이 되면 받아 줍니다. 이미 중립이라면 지금, 아니면 마지막 가이드에서 59레벨에 동굴을 다시 지날 때 제출하세요.",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "강을 건너 동쪽의 {area:2627}(으)로 가세요. {zone:1423} 북서쪽의 폐허가 된 마을입니다. {npc:12384}은(는) 마을 가장자리의 오두막에 앉아 있습니다.",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "데링턴의 감시탑, 반디스의 가마솥, {npc:11615}의 통은 나중에 들를 때 처리합니다. 보관하세요.",
	-- ["Diseased Grizzlies"] = "오염된 불곰",
	-- ["Fly to the {area:1497}"] = "{area:1497}(으)로 날아가기",
	-- ["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "길을 따라 북동쪽의 {area:1767}(으)로 가세요. 숲 동쪽의 굽이나무 이끼늪괴물과 갈퀴늪괴물은 각각 {item:11503}을(를) 지니고 있습니다. 같은 숲에서 탈로를 위해 성난발톱불곰과 갈퀴발톱 악령발늑대를 처치하세요. 이들의 장기는 {npc:10920}에게 필요합니다.\n다음은 {area:1762}의 마른가지일족 보초(53-54)와 복수자(54-55)입니다. 54레벨 미만이라면 54레벨이 될 때까지 이곳에서 불곰과 악령발늑대(51-52)를 계속 사냥하세요. 이어지는 {area:1769}, {area:2479}, {area:1997}에서의 제출로 55레벨 가까이 오릅니다. 또는 파티가 있다면 대신 {area:1417} 던전이나 {area:1584} 던전을 도세요.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "길을 따라 북동쪽의 {area:1767}(으)로 가세요. 숲 동쪽의 굽이나무 이끼늪괴물과 갈퀴늪괴물은 각각 {item:11503}을(를) 지니고 있습니다. 같은 숲에서 탈로를 위해 성난발톱불곰과 갈퀴발톱 악령발늑대를 처치하세요. 54.21레벨 미만이라면 불곰과 악령발늑대를 계속 사냥하세요. {area:1997}와(과) {area:2479}에서 퀘스트를 제출하면 55레벨이 됩니다. 또는 파티가 있다면 대신 {area:1584} 던전이나 {area:1417} 던전을 도세요.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "{area:2268}의 비행 조련사에게서 {area:1497}(으)로 날아가세요.",
	-- ["Jadefire moonwell"] = "비취불꽃 달샘",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "꼬마 파멜라을(를) 보관하세요: 파멜라는 나중에 다시 들르는 {area:2262}에 있습니다.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "가지를 보관하세요: {npc:5770}은(는) {zone:1456}에 있습니다.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "꾸러미를 보관하세요: {npc:10781}은(는) {area:1497}에 있습니다.",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "{quest:6164}을(를) 보관하세요: {zone:1423} 가이드의 {area:2627} 단계에서 {npc:12384}이(가) 돌려받습니다.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "기사와 학자는 {area:192}에서 일하고, 의무병과 사냥꾼은 그 남쪽에 야영하고 있습니다.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "{area:1497}을(를) 나와 길을 따라 동쪽으로 {zone:1420}을(를) 지나 {area:152}을(를) 지나가세요. 펠스톤 농장은 길을 따라 처음 나오는 농장이며, {npc:10778}은(는) 집 안에서 기다립니다.",
	-- ["Level 53"] = "53레벨",
	-- ["Level 55"] = "55레벨",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "마른가지일족 깃털 머리장식 5개가 있을 때만",
	-- ["Radley and Durgen"] = "래들리와 더건",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "남쪽으로 {area:1763}을(를) 지나 비취불꽃의 사티로스가 있는 오염된 달샘으로 돌아가, 그곳에서 {npc:9996}의 작은 병을 채우세요.",
	-- ["Ride back south-east to the Sanctuary."] = "남동쪽의 성소로 돌아가세요.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "{area:1497}(으)로 돌아가 {zone:1454}행 비행선을 타고 {area:431}(으)로 날아가세요. 길을 따라 토막나무 주둔지에서 서쪽으로 나가, 갈림길에서 북쪽 {zone:1448}(으)로 가세요.",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "다시 서쪽으로 강을 건너 {area:192}(으)로 가세요. {npc:11610}은(는) 그 북동쪽 언덕에 숨어 있습니다.",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "동쪽 언덕을 따라 북쪽으로 가세요. {npc:1855}은(는) {zone:1423}와(과)의 경계, {area:2619} 옆의 작은 집에 삽니다.",
	-- ["Ride north up the road again."] = "다시 길을 따라 북쪽으로 가세요.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "북서쪽의 안돌할로 가세요. {npc:10667}은(는) 마을 서쪽의 무너진 여관에서 기다립니다. 안쪽의 해골은 54-57레벨이니 가장자리로만 다니세요.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "남쪽으로 {area:202}을(를) 지나 {area:197}(으)로 가세요. {npc:10927}의 집은 길가에 있고, {npc:10936}의 기념비는 그 뒤 묘지에 있습니다. 가는 길에 들판에서 만나는 역병에 걸린 늑대를 처치하세요.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "길을 따라 남쪽으로 {area:361}을(를) 지나 성소로 가세요.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "길을 따라 남쪽으로 {zone:1448}을(를) 지나 성소로 가세요.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "서쪽의 {area:192}(으)로 가세요. {npc:11610}은(는) 그 북동쪽 언덕에 숨어 있습니다.",
	-- ["Scarlet Crusade"] = "붉은십자군",
	-- ["Scarlet forward camp"] = "붉은십자군 전진 야영지",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "새끼 고양이를 같은 달샘에 데려가 풀어 주세요. {npc:10042}(으)로 변하면 {npc:9996}에게 데려가 클릭해서 건네세요.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "연대기는 안돌할 시청의 곰팡이 슨 고서 사이에 있습니다. 맞는 것을 찾을 때까지 열어 보세요.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "터널 바로 서쪽의 마른가지일족 털보숭이 마을입니다. {npc:9462}(56)이(가) 그들 사이에 서 있습니다. 우호적인 털보숭이 {npc:11557}은(는) 마을 북쪽 끝에 앉아 있습니다.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "마른가지일족 털보숭이 마을은 성소 바로 남쪽에 있습니다. 마른가지일족을 처치할 때마다 {area:1769} 평판도 오릅니다. 깃털 머리장식은 보관하세요. 53.92레벨이 될 때까지 계속 처치하세요. 성소의 다음 제출 퀘스트와 {area:1763}에 그 레벨이 필요합니다. 또는 파티가 있다면 대신 {area:1417} 던전이나 {area:1584} 던전을 도세요.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "붉은십자군의 천막은 {area:199}와(과) {area:200} 사이에 있습니다. {object:176092}(으)로 지휘 천막을 불태우고 스컬지 깃발을 꽂으세요.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "곰은 {area:202} 북쪽과 동쪽 언덕을 돌아다닙니다.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "책은 {area:2627}의 무너진 여관에 있습니다. 마을의 언데드는 54-56레벨이니 한 마리씩 끌어오세요.\n커다란 흰개미 둔덕은 {area:2627} 동쪽 언덕 곳곳에 있습니다. 지나가는 둔덕마다 {item:15042}을(를) 사용하세요.",
	-- ["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "일기는 농가 안에, 장식장은 그 안에, 변소는 그 뒤에 있습니다. {npc:10816}이(가) 변소 열쇠를 지니고 있습니다. 변소를 열면 {npc:10836}이(가) 나오며, 그가 장식장 열쇠를 지니고 있습니다.",
	-- ["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "길은 맨 북동쪽 {area:1769} 터널 밖의 {npc:15395}에서 끝납니다.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "서큐버스 {npc:9518}이(가) {area:1763} 한가운데, {npc:11020} 옆에서 기다립니다.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "늑대는 안돌할, {area:200}, {area:202} 사이의 들판을 돌아다닙니다. 동쪽으로 돌아가는 길에 마저 처치하세요.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "늑대는 안돌할, {area:200}, {area:202} 사이의 들판을 돌아다닙니다. 동쪽으로 돌아가는 길에 마저 처치하세요. 주의: 가장 큰 것은 54레벨이니 한 마리씩 끌어오세요.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "{object:661778}은(는) 골짜기 바로 남쪽, 북쪽으로 가는 길가에 있습니다. 석상의 장신구로 {area:1997}의 {npc:9996}에게 가는 퀘스트가 시작됩니다.",
	-- ["Through {area:1769}"] = "{area:1769} 통과",
	-- ["To {zone:1448}"] = "{zone:1448}(으)로",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "{area:200}에서 퀘스트를 제출하기 전에 이곳에서 52.63레벨까지 올리십시오. 제출하면 53레벨이 됩니다. 붉은십자군 야영지 서쪽의 Carrion Lurkers(52-53)는 레벨이 맞고, 붉은십자군 마법사와 기사(54-56)는 레벨이 더 높습니다. 또는 파티와 함께 대신 {area:1417} 던전이나 {area:2100} 던전을 도십시오.",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "{npc:10739}이(가) 오염된 불곰(55-56)에게 보내기 전에 이곳에서 53레벨까지 올리십시오. {area:200}에서 {area:202}(으)로 가는 길의 Carrion Lurkers(52-53)가 레벨이 맞습니다. 또는 파티와 함께 대신 {area:1417} 던전이나 {area:1584} 던전을 도십시오.",
	-- ["Upstairs"] = "위층",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "{npc:15395} 옆의 {area:1769} 터널로 들어가세요. 안쪽의 나무구렁 털보숭이는 절대 공격하지 마세요. 터널은 {zone:1452}(으)로 이어집니다. 길을 따라 동쪽으로 다음 가이드가 시작되는 고블린 마을 {area:2255}(으)로 가세요.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "{zone:1448} {area:1762}에서 마른가지일족 복수자 사냥",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "{zone:1422} {area:192}에서 붉은십자군 기사 사냥",
	-- ["grind on {npc:7157}"] = "{npc:7157} 사냥",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}의 붉은십자군은 58-60레벨입니다. 지도에 표시된 높은 곳까지 들어가 마을을 살펴본 뒤 빠져나오세요.",
	-- ["{area:200} farmhouse"] = "{area:200} 농가",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: 만나는 대로 처치하세요",
	-- ["{npc:10840}, at the graveyard's south end"] = "묘지 남쪽 끝의 {npc:10840}",
	-- ["{npc:11558}, at the tunnel mouth"] = "터널 입구의 {npc:11558}",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}의 마지막 임무는 53레벨이 필요합니다. 그녀 바로 남서쪽 벌목지에서 일하는 붉은십자군 기사와 학자(54-55)가 가장 가까운 사냥터입니다.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}은(는) 벌목지 동쪽에 서 있고, {npc:11611}은(는) {npc:11610} 북동쪽, {area:190}(으)로 가는 길을 지키고 있습니다.",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}의 사냥은 {zone:1423}에서 합니다. 나중을 위해 보관하세요.",
	-- ["{npc:9529}, just west of the camp"] = "야영지 바로 서쪽의 {npc:9529}",
	-- ["{object:175894}, beside the house"] = "집 옆의 {object:175894}",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}은(는) {area:2268}(으)로 갑니다. 나중을 위해 보관하세요.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}: {item:12846}을(를) 착용하고 있으면 {area:2627}의 언데드가 떨어뜨립니다",
	-- ["{quest:8470}, a rare drop"] = "드물게 떨어지는 {quest:8470}",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "{zone:1452}의 퀘스트는 55-58레벨입니다. {npc:9996}에게 제출한 뒤에도 55레벨 미만인가요? {area:1762}의 마른가지일족 털보숭이(53-55)는 레벨이 맞고 북쪽 {area:1769} 터널로 가는 길에 있습니다. 55레벨이 될 때까지 처치하세요. 처치할 때마다 나무구렁일족 평판도 오릅니다. 주의: 보초와 복수자는 생명력이 절반 아래로 떨어지면 주변 동료를 부르고, 죽기 직전에는 도움을 청하러 도망칩니다. 마을 가장자리에서 한 마리씩 끌어오세요. 이 경로만 따르는 플레이어에게는 오래 걸리는 레벨업입니다. 아니면 파티로 {area:1584} 던전이나 {area:1417} 던전을 도세요.",
}
