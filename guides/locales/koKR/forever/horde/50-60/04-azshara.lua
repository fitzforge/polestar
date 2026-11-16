-- Korean (koKR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{object:172960}의 {npc:8659}",

	-- Step 2: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{object:172957}의 {npc:15188}: {zone:1451}을(를) 위해 보관하세요",

	-- Step 3: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010}은(는) 시장 거리에 있습니다.",

	-- Step 4: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1423} Eastern Plaguelands
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "{quest:4494}을(를) 아직 완료하지 않은 경우에만: {npc:7010}은(는) 시장 거리에 있습니다. 페슬주그는 {zone:1423} 가이드에서 운고로로 가는 길에 {area:976}에서 이 퀘스트를 받습니다.",

	-- Step 5: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "{area:392}(으)로 날아가기",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 6: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "리브의 작업장은 {area:392} 부두 북쪽 끝에 있으며, {object:149036}은(는) 그 안에 있습니다.",
	["Inside"] = "",

	-- Step 7: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901}은(는) {area:392} 바로 북쪽 해안에 야영하고 있습니다.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "정화된 물은 {zone:1448}의 {area:2479}(으)로 갑니다. 나중을 위해 보관하세요.",

	-- Step 8: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "{npc:256386}의 상자",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "길을 따라 북쪽 크로스로드로 가세요. {npc:256386}이(가) 그곳에 서 있습니다. 그녀가 건네는 상자를 하나씩 열어 안에 든 것을 가져가세요. 크로스로드에서 {area:1237}(으)로 날아가세요.",

	-- Step 9: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "{area:1237}(으)로 날아가기",
	["Crossroads flight master"] = "크로스로드 비행 조련사",

	-- Step 10: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, 블러드 엘프 비전술사의 마법봉",

	-- Step 11: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "동쪽 해안의 폐허로 가세요. 석판 네 개가 폐허 곳곳에 있으며, 원한의꼬리일족 나가(52-55)가 지키고 있습니다. 한 번에 한 마리씩 끌어오세요.",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "동쪽 해안의 폐허로 가세요. 해안을 따라 있는 조수 웅덩이에서 큘리의 약병 네 개를 채우세요. 원한의꼬리일족 나가가 그 사이를 순찰합니다.",

	-- Step 13: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "마크리니 굴파기",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "마크리니 굴파기(50-51)는 폐허 바로 동쪽, 북동쪽으로 가는 길의 모래밭을 파고 있습니다. 이들과 그곳에 묻힌 은닉물에서 명가 보물 조각을 얻습니다.",

	-- Step 14: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "{zone:1447} 중앙을 가로질러 북동쪽으로 계속 가세요. {npc:235903}은(는) 길가에 야영하고 있습니다.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, 블러드 엘프 야영지 북쪽의 사티로스",

	-- Step 15: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "블러드 엘프 바로 북쪽, {area:1227} 위 절벽에 있는 고블린 야영지로 북동쪽으로 가세요.",

	-- Step 16: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "블러드 엘프는 북동쪽 {area:1227} 옆 절벽에 야영하고 있습니다. {npc:8420}의 장비 네 개는 야영지 주변 상자에 있고, 블러드 엘프 비전술사가 {npc:247473}의 마법봉을 지니고 있습니다.\n주의: 야영지 서쪽 끝에 55-57레벨 정예인 {npc:250023}이(가) 서 있습니다. 블러드 엘프는 야영지 동쪽부터 처치하세요.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "블러드 엘프 비전술사에게서 얻는 {item:246680}",

	-- Step 17: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}의 야영지",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "림토리의 야영지는 주둔지 동쪽 끝에 있습니다. 그곳의 {object:151286}을(를) 읽으세요. Forever에서는 그 옆의 신도레이 고서가 야영지 장교 세 명의 인장을 요구합니다.",

	-- Step 18: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "야영지의 장교 세 명(53)이 각각 인장을 지니고 있습니다. {npc:247006}은(는) 야영지 중앙에, {npc:247013}은(는) 동쪽 끝에 있으며, {npc:246991}은(는) 서쪽 절반을 돌아다닙니다. 화살표가 가리키는 순찰 경로의 동쪽에서 처치하세요.\n주의: 55-57레벨 정예인 {npc:250023}이(가) 야영지 서쪽 가장자리, 호크헬름 순찰 경로의 반대쪽 끝 근처에 서 있습니다. 호크헬름이 다시 동쪽으로 올 때까지 기다리세요.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{npc:247006}에게서 얻는 {item:246725}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{npc:246991}에게서 얻는 {item:246721}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{npc:247013}에게서 얻는 {item:246722}",

	-- Step 19: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "신도레이 고서로 돌아가 인장을 넣은 뒤, 고서를 사용해 {npc:8578}을(를) 불러내세요.\n주의: 어느 수정이 림토리와 연결되어 있는지는 무작위입니다. 나머지 두 수정은 각각 적대적인 지옥불정령을 소환합니다.",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: {area:1237}의 {npc:8587}에게",

	-- Step 20: The Legashi satyrs
	["The Legashi satyrs"] = "레가시 사티로스",
	-- {npc:235903} Ekkal
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "레가시 사티로스(51-52)가 블러드 엘프 야영지 북쪽 언덕을 차지하고 있습니다. {npc:235903}은(는) 종류별로 다섯 마리씩 원합니다.",

	-- Step 21: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "북서쪽의 {npc:8420}에게 돌아가세요.",

	-- Step 22: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "남쪽 {area:1221}의 북쪽 가장자리로 가세요. 그곳의 원한의꼬리일족 세이렌과 미르미돈(50-52)이 {npc:8420}의 룬을 지니고 있습니다. 잘 나오지 않으니 나올 때까지 가장자리를 따라 처치하세요.",

	-- Step 23: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "룬을 가지고 북쪽의 {npc:8420}에게 돌아간 뒤, 길을 따라 남서쪽으로 가세요.",

	-- Step 24: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "길을 따라 남서쪽으로: {npc:235903}에게 사티로스를 제출하세요.",

	-- Step 25: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "서쪽의 {area:1237}(으)로 돌아가세요.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, {zone:1454}의 {npc:4485}에게",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: 고서는 {zone:1454}의 {npc:3326}에게 갑니다",
	-- {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1456} Thunder Bluff
	["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "{npc:8659}, {npc:6522}, {npc:4485}, {npc:3326}에게 전달할 것은 보관하세요. 다음에 {zone:1454}와(과) {zone:1458}을(를) 지나갑니다. {zone:1456}의 마가사에게 가는 것은 이 경로에서 벗어나니 그냥 두세요.",

	-- Step 26: Archmage Xylem
	-- {area:1237} Valormok · {npc:8395} Sanath Lim-yo
	["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "자일렘의 탑은 {area:1237} 바로 북쪽 절벽 위에 있습니다. {area:1237}의 {npc:8395}에게 말을 걸면 무료로 순간이동시켜 줍니다. 아니면 북쪽 면의 구불구불한 길로 올라가세요.",
	["Upstairs"] = "위층",

	-- Step 28: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 29: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 30: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "",

	-- Step 31: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "{zone:1454}(으)로 날아가세요. {npc:4485}은(는) {object:172958}에, {npc:3326}와(과) {npc:8659}은(는) {object:172960}에 있습니다.",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{object:172960}의 {npc:3326}",

	-- Step 32: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "",

	-- Step 33: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "{zone:1458}행 비행선",

	-- Step 34: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "그 옆의 {npc:8393}",

	-- Step 35: Andron Gant
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522} stands in the {object:36073}."] = "{npc:6522}은(는) {object:36073}에 서 있습니다.",

	-- Step 36: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "실바나스 여왕은 {object:36126}에 있습니다.",

	-- Step 39: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "근처의 {npc:8403}",

	-- Step 40: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050}은(는) {zone:1422}의 {npc:10778}에게 돌아갑니다. 보관하세요.",

	-- Step 41: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "",

	-- Step 43: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}: 흰개미는 다음 가이드의 {area:2627}에 있습니다",

	-- Step 45: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "{item:14047} 기부 두 개는 나중에 경로 중 완료합니다. {item:14047}을(를) 모으기 시작하세요.",
	-- ["Fly to the {area:380}"] = "{area:380}(으)로 날아가기",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "{zone:1454}(으)로 날아가세요. {npc:4485}은(는) {object:172958}에 있습니다.",
	-- ["In the {object:172958}."] = "{object:172958}에 있습니다.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "{object:172961}에 있습니다. 양모 옷감, 비단 옷감, 마법 옷감을 가방에 넣어 두세요.",
	-- ["Open {object:149036} for the {item:10556}"] = "{object:149036}을(를) 열어 {item:10556} 얻기",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "림토리의 야영지는 주 야영지 동쪽 끝에 있습니다. 그곳에서 {object:151286}을(를) 읽은 뒤 마법사를 처치하세요.\n주의: 어느 수정이 림토리와 연결되어 있는지는 무작위입니다. 나머지 두 수정은 각각 적대적인 지옥불정령을 소환합니다.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "블러드 엘프는 북동쪽 {area:1227} 옆 절벽에 야영하고 있습니다.\n주의: 야영지 서쪽 끝에 55-57레벨 정예인 {npc:250023}이(가) 서 있습니다. 블러드 엘프는 야영지 동쪽부터 처치하세요.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "비행선 탑은 {zone:1454} 정문 바로 북동쪽에 있습니다. {zone:1458}행 비행선을 타세요.",
	-- ["Zeppelin tower"] = "비행선 탑",
	-- ["{npc:11044}, in the Apothecarium"] = "연금술 실험실의 {npc:11044}",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050}은(는) {area:28}의 {npc:10778}에게 돌아갑니다. 보관하세요.",
}
