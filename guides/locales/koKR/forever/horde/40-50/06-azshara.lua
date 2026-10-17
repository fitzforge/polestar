-- Korean (koKR): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "{area:1497}(으)로 비행",
	-- {area:3317} Revantusk Village · {area:1497} Undercity
	["From {area:3317}'s flight master, fly to the {area:1497}."] = "{area:3317}의 비행 조련사에게서 {area:1497}(으)로 날아가세요.",

	-- Step 2: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825}은(는) {object:36082}에 있습니다.",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "비행선 타고 {zone:1454}(으)로",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:431} Splintertree Post
	["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "{zone:1458} 밖의 탑에서 비행선을 타고 {zone:1454}(으)로 간 뒤 {area:431}(으)로 날아가세요.",

	-- Step 4: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "{zone:1447}(으)로 이동",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "토막나무 주둔지에서 길을 따라 동쪽으로 가세요. {npc:11548}은(는) 길에서 조금 벗어난 {area:1235}, 얼라이언스의 {area:3137} 바로 서쪽에서 기다립니다. 서쪽에서 접근하고 아즈샤라 파수꾼과 자로데누스(정예)를 피하세요.",

	-- Step 5: Highborne and Haldarr satyrs
	["Highborne and Haldarr satyrs"] = "명가 유령과 할다르 사티로스",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "명가 유령은 제단 바로 북쪽의 폐허를 떠돌고, 할다르 사티로스는 조금 더 북쪽에 진을 치고 있습니다.",

	-- Step 6: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "제단의 {npc:11548}에게 돌아가세요. {area:3137} 경비병의 서쪽으로 다니세요.",

	-- Step 7: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "길을 따라 북쪽의 호드 야영지 {area:1237}(으)로 가세요.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "야영지 동쪽 끝의 {npc:8395}: 경험치 없음, 아즈샤라 탑으로 순간이동만 가능",

	-- Step 8: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "온전한 히포그리프 깃털",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "천둥뿔 히포그리프가 {area:1237} 바로 남쪽 언덕 위를 날아다닙니다.",

	-- Step 10: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "북동쪽 {area:1227} 위 절벽의 고블린 야영지로 가세요.",

	-- Step 11: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "블러드 엘프 야영지는 {npc:8420} 바로 남쪽에 있습니다. 그의 장비 네 개는 야영지 주변 상자에 있습니다.",

	-- Step 13: Ruins of Eldarath
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "남서쪽 폐허로 가세요. 석판 네 개가 폐허 곳곳에 있고 원한의꼬리일족 나가가 지킵니다. 원한의꼬리일족 세이렌이나 원한의꼬리일족 미르미돈 누구나 {npc:8420}의 룬을 지니고 있을 수 있습니다.",

	-- Step 14: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "북동쪽 {npc:8420}에게 돌아가세요.",

	-- Step 15: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "서쪽 {area:1237}(으)로 돌아가세요.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "{npc:4046}, {npc:8659}, {npc:6522}에게 줄 배달품은 보관하세요. 나중에 {zone:1456}, {zone:1454}, {zone:1458}을(를) 지나갑니다.",

	-- Step 16: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "실렘의 탑은 {area:1237} 바로 북쪽 절벽 위에 있습니다. 길은 북쪽 면을 따라 구불구불 올라갑니다.",

	-- Step 18: To Grom'gol
	-- {object:3202} Grom'gol
	["To {object:3202}"] = "{object:3202}(으)로",
	-- {area:1237} Valormok · {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "{area:1237}에서 {zone:1454}(으)로 날아간 뒤, 정문으로 나가 비행선 탑에서 {object:3202}행 비행선을 타세요.",

	-- Step 19: Grom'gol Base Camp
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay
	["The {object:2076} beside {npc:2519}"] = "{npc:2519} 옆의 {object:2076}",

	-- Step 20: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "무쇠턱 바실리스크",
	["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "길을 따라 남쪽으로 가세요. 바실리스크는 정글 한가운데, 길 동쪽 바위 위에서 햇볕을 쬡니다. 조각은 자주 나옵니다.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "계속 남쪽 {area:35}(으)로 가세요. {npc:7406}의 작업장은 항구 위층 둘레에 있습니다.",
	["Only once all three robots are home"] = "로봇 세 대가 모두 돌아온 뒤에만",

	-- Step 22: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "{object:3202}(으)로 돌아가기",

	-- Step 23: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Take the zeppelin back to {zone:1454}."] = "비행선을 타고 {zone:1454}(으)로 돌아가세요.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "골목길의 {npc:6986}",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{object:172960}의 {npc:8659}",
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "{npc:8659}의 대금과 아그토르의 {quest:3504}은(는) 보관하세요. 나중에 {area:1237}에 다시 갈 때 가져갑니다.",

	-- Step 24: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "{area:1638}(으)로 날아가세요. {area:1099}(으)로 가는 길목입니다. 아직 비행 경로가 없다면 {area:378}(으)로 날아가 {zone:1412}을(를) 지나 서쪽으로 가세요. 하뮬과 {npc:4046}은(는) {area:1639}에 있습니다. 드루이드와 성기사는 여기서 기술을 배웁니다({npc:3033}, {npc:246344}).",
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761}은(는) 다음 가이드에서 모읍니다. {npc:4046}의 대금은 나중에 {npc:8587}에게 가져갑니다.",

	-- Step 25: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: 곰은 {zone:1448}에 있음",
	-- {area:1417} Sunken Temple · {npc:7771} Marvon Rivetseeker · {zone:1446} Tanaris
	["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "{area:1417}은(는) {zone:1446}의 {npc:7771}을(를) 위해 보관하세요.",

	-- Step 26: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "공작날개 히포그리프",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "히포그리프는 야영지 남서쪽 언덕에 둥지를 틉니다. 하나를 처치한 뒤 시체에 뮤세크 단지를 사용하세요.",

	-- Step 28: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "화살요정용",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "요정용은 야영지 바로 서쪽 숲을 날아다닙니다. 처치할 때마다 단지를 사용하세요.",

	-- Step 30: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "떠도는 나무정령",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "나무정령은 야영지와 {zone:1444} 중앙 사이의 숲길을 떠돕니다. 수가 적으니 길을 따라 찾아보세요.",

	-- Step 32: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "북서쪽 {area:1108}(으)로 가세요. {npc:14637}이(가) 부두에서 기다립니다.",

	-- Step 33: Zapped giants
	["Zapped giants"] = "축소된 거인",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "평지거인과 절벽거인이 부두 북쪽 언덕을 돌아다닙니다. 먼저 각각에게 {item:18904}을(를) 쏘세요. 줄어들면 더 이상 정예가 아닙니다. 축소된 거인은 모두 잔여물을 떨어뜨립니다. 시체에 뮤세크 단지도 사용하세요.",

	-- Step 34: Sea elementals
	["Sea elementals"] = "바다 정령",
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "바다 정령과 바다 물보라 정령이 부두 주변 해안을 따라 밀려다닙니다.",

	-- Step 36: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "{area:1099}(으)로 돌아가기",

	-- Step 37: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "와이번 조련사 옆의 {npc:7876}",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "{npc:7876}의 타르와 페슬저그의 표본은 {zone:1449}에서 구합니다.",

	-- Step 38: Broken Pillar
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "길을 따라 남쪽 {area:1938}(으)로 가세요. {npc:7771}이(가) 그 옆에 있습니다. 여기서 서쪽 길을 따라 내려가면 다음 가이드가 시작되는 {zone:1449}입니다.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "{quest:3444}은(는) 보관하세요. {npc:7771}의 상자는 나중에 다시 와서 엽니다.",
}
