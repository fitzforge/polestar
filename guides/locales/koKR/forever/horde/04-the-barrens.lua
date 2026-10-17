-- Korean (koKR): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "{area:392}(으)로 비행",
	-- {object:172982} Valley of Strength
	["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "와이번 조련사 도라스는 {object:172982}의 탑 위에 있습니다.",

	-- Step 2: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, 와이번 조련사 옆. 보관하십시오: {quest:1483}은(는) 나중에 돌발톱 산맥에서 합니다",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "{object:3972} 게시판",
	-- {npc:3453} Wharfmaster Dizzywig
	["{npc:3453}, on the dock"] = "{npc:3453}, 부두",

	-- Step 3: Bruuz
	-- {npc:209797} Bruuz · {area:392} Ratchet
	["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797}은(는) {area:392} 부두 바로 앞 항구에서 헤엄칩니다. {npc:209797}은(는) 정예이므로 파티를 권장합니다.",

	-- Step 4: Baron Longshore
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "해적들은 {area:392} 남쪽 해변에 야영하며, {npc:3467}은(는) 남쪽 끝에 있습니다.",

	-- Step 5: Northwatch Hold
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "더 남쪽 해안의 {area:385}입니다. 테라모어 해병과 테라모어 치료사(15-16)가 훈장을 떨어뜨립니다. {npc:3393}(20)와(과) 포수 둘(19)이 요새 안과 성벽 위에 있어 지금까지 미뤘습니다.",

	-- Step 6: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465}은(는) 요새 안에 사슬로 묶여 있습니다. 대화해 호위를 시작하고 가까이 있으십시오. 나가는 길에 테라모어 병사가 공격합니다. 그가 {area:392}까지 함께 걸어갑니다.",

	-- Step 8: Raptor Horns
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "갈퀴발톱 열대초원랩터가 {area:380} 남쪽, {area:1697} 주변 평원에서 사냥하며 뿔을 떨어뜨립니다. 다음에 {area:392}을(를) 지날 때 제출하십시오.",

	-- Step 9: Crossroads
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. 보관하십시오: 다음 가이드의 {area:1703}에 있는 카드라크",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: 알은 나중에 {area:390}에서",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, 탑 꼭대기",

	-- Step 10: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "{area:380}에서 북쪽 {area:384}(으)로 가서 {object:19464}에서 {item:15842}을(를) 채운 뒤, {area:380}의 {npc:3448}에게 돌아가십시오. {skill:182}이(가) 없다면 옆의 {npc:3490}이(가) {item:2449}을(를) 판매합니다. 재입고될 때까지 한 번에 세 개입니다.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{npc:3490}에게서 {item:2449}. 약초채집가는 평원에서 채집하십시오",

	-- Step 11: Level 20
	["Level 20"] = "20레벨",
	-- {zone:1454} Orgrimmar · {npc:3354} Sorek · {npc:5892} Searn Firewarder · {area:380} Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "{zone:1454}의 20레벨 직업 퀘스트({npc:3354}, {npc:5892}, 흑마법사와 도적 상급자)는 20레벨부터만 제공되니 비행하기 전에 여기서 레벨을 마치십시오. {area:380} 남서쪽 평원의 새끼 천둥매(18)와 {area:388}의 콜카르일족(14-15)이 가장 가까운 사냥감입니다. 필요한 경험치는 한 레벨보다 훨씬 적습니다.",
	-- {area:380} Crossroads
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "{area:380} 남서쪽에서 새끼 천둥매 사냥",

	-- Step 12: Orgrimmar
	-- {area:1637} Orgrimmar · {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "{area:1637}(으)로 비행해 20레벨 기술을 수련하십시오. {npc:3354}은(는) {object:172958}에, {npc:5892}은(는) {object:172957}에 있습니다.",

	-- Step 13: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960}은(는) {object:172982} 아래 협곡입니다.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, 몇 걸음 떨어진 곳",

	-- Step 14: Shenthul
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {quest:2460} The Shattered Salute
	["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401}은(는) {object:172960}에 있습니다. 그를 대상으로 지정하고 /salute를 입력해 {quest:2460}을(를) 완료하십시오.",
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {area:382} 옆의 {npc:7233}",

	-- Step 15: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018}은(는) 도시 서쪽 {object:172961}에 있습니다.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: 두 가이드 뒤 {zone:1458}의 {npc:4606}",

	-- Step 16: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "{area:1638}(으)로 비행해 20레벨 기술을 수련하십시오. {npc:3033}은(는) {area:1639}에 있습니다.",

	-- Step 17: Back to the Crossroads
	-- {area:380} Crossroads
	["Back to the {area:380}"] = "{area:380}(으)로 돌아가기",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}은(는) {area:380} 바로 서쪽의 콜카르일족 감시 초소에 있습니다.",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394}은(는) {npc:3389} 북서쪽 콜카르일족 야영지에 있습니다.",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: 콜카르일족 야영지 주변 평원의 길잃은 황무지 코도",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449}: 약초채집가는 여기서 채집하십시오",

	-- Step 21: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197}은(는) {npc:3389}에서 서쪽으로 가는 길 끝, 돌발톱 산맥 입구의 트롤 마을 {area:2539}에 삽니다.",

	-- Step 22: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "북쪽 {area:383}(으)로 가십시오. {npc:3682}은(는) 언덕 아래에 야영하고 있으며, 그 뒤 능선의 은둔자 {npc:261366}은(는) {npc:3682}이 올려 보낸 뒤에만 일을 줍니다.",

	-- Step 23: Dry Hills
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "우두머리 사바나 사자가 언덕 동쪽 평원을 돌아다니며, 용수철 덫은 그들 사이에 있습니다. {quest:876}이(가) 서쪽 언덕의 칼날바람하피를 이끕니다.",

	-- Step 26: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119}와(과) 해병들이 {npc:261366} 남쪽의 부서진 대상단을 차지하고 있습니다.",

	-- Step 27: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "{npc:261366} 돕기: {npc:261367}와(과) {area:21} 해병이 능선을 올라오면 그의 곁에 있으세요",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792}은(는) {area:382} 북쪽 가장자리, 투자개발회사 탑 옆에 있습니다. {quest:30}용 {item:15883}이(가) 들어 있습니다.",

	-- Step 29: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "동쪽 {area:382}(으)로 가십시오. {npc:3439}은(는) 투자개발회사 야영지 안에 있으며, {npc:3445}이(가) 열쇠를 가지고 있습니다.",

	-- Step 30: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "위즐크랭크가 벌목기를 몰고 야영지를 빠져나갑니다. 함께 있으면서 공격하는 적을 처치하십시오. {area:392}의 {npc:3442}이(가) 받습니다.",

	-- Step 31: Taskmaster Fizzule
	-- {area:382} Sludge Fen
	["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "피줄은 {area:382} 동쪽 끝의 투자개발회사 야영지를 운영합니다. 낯선 이를 공격하니 먼저 대상으로 지정하고 /salute를 하십시오.",

	-- Step 32: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "은신을 유지하십시오. {npc:7287}이(가) 탑 열쇠를 가지고 있으며, 갤리윅스와 금고는 꼭대기에 있습니다. 갤리윅스는 정예이므로 파티를 권장합니다.",
	["Venture Co. tower"] = "투자개발회사 탑",

	-- Step 33: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "지역 북동쪽 구석 광산의 투자개발회사 감독과 투자개발회사 집행자가 {item:5097}을(를) 떨어뜨립니다.",

	-- Step 34: Hearth to the Crossroads
	-- {area:380} Crossroads
	["Hearth to the {area:380}"] = "{area:380}(으)로 귀환",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "그가 {item:15826}을(를) 줍니다",

	-- Step 35: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395}은(는) {area:380} 남동쪽 {area:388}의 콜카르일족 사이를 걷습니다.",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: {item:15826}을(를) 사용하십시오. {area:380} 주변 평원 곳곳을 돌아다닙니다",

	-- Step 36: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "{area:458}을(를) 따라 남쪽 {area:378}(으)로 가십시오.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, 우리 안",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, 야영지 북쪽 가장자리",

	-- Step 37: Bristleback camps
	["Bristleback camps"] = "뾰족털일족 야영지",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {item:5075} Blood Shard · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "뾰족털일족 가시멧돼지 야영지가 {area:378} 북쪽 평원, {area:458} 양쪽에 퍼져 있습니다. 모든 뾰족털일족이 엄니를 떨어뜨리며, {npc:3432}의 아내는 북쪽 가장자리에 쓰러져 있습니다. {item:5075} 하나를 보관하십시오. 회색 코도 {quest:883}이(가) 가끔 이곳을 돌아다니며, 그 발굽으로 퀘스트가 시작됩니다.",

	-- Step 38: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "도그란은 길 서쪽 가시멧돼지 야영지에 사슬로 묶여 있습니다.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "보관하십시오: 이 가이드 마지막에 {zone:1454}의 {npc:5875}",

	-- Step 40: Stolen Silver
	-- {area:385} Northwatch Hold
	["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "동쪽 평원을 가로질러 해안 쪽으로 가십시오. 도둑맞은 은은 {area:385} 북서쪽 랩터 둥지에 있습니다.",

	-- Step 41: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901}은(는) 북쪽으로 가는 길, {area:392} 남쪽 언덕에서 기다립니다.",

	-- Step 43: Ishamuhale
	-- {quest:882} Ishamuhale · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "큰 열대초원랩터 {quest:882}이(가) {area:392}에서 {area:380}(으)로 가는 길 북쪽 평원에서 사냥합니다.",

	-- Step 44: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{quest:4921}을(를) 제출하면 {npc:3432}이(가) {quest:95774}을(를) 줍니다",

	-- Step 46: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396}은(는) {npc:3389} 남쪽, {area:387} 서쪽 기슭의 콜카르일족을 이끕니다. 마지막으로 {area:380}에 들를 때 머리를 {npc:3389}에게 건네십시오.",

	-- Step 47: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "{area:458}을(를) 따라 {area:378}(으)로 내려가는 길에: 야영지 북쪽 길 양쪽 뾰족털일족 야영지 사이의 서슬갈기 침략자가 {item:277277}을(를) 가지고 있습니다. 마지막으로 {area:380}에 들를 때 {npc:3432}에게 건네십시오.",

	-- Step 48: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "{area:458}을(를) 따라 다시 {area:378}(으)로 내려가십시오.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "보관하십시오: 다음 가이드의 {zone:1440}에 있는 {npc:12696}",

	-- Step 49: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "천둥꼬리도마뱀이 {area:378} 바로 남쪽 평원에서 풀을 뜯습니다. 파란 천둥꼬리도마뱀 {quest:884}이(가) 그 사이를 돌아다니며, 그 꼬리가시로 퀘스트가 시작됩니다.",

	-- Step 51: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "비단천둥매가 야영지 남쪽 같은 평원 위를 맴돕니다.",

	-- Step 53: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "타우라조 야영지 남쪽 {area:390}에 실리시드 흙더미가 흩어져 있습니다. 알은 그 안에 있으며, 우두머리 실리시드가 나와 지킵니다. 여왕 실리시드는 드무니 보이면 처치해 머리를 얻으십시오.",

	-- Step 54: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341}은(는) 더 남쪽, {area:359}(으)로 가는 길가의 작은 야영지에서 기다립니다.",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, {npc:3341} 바로 동쪽 나무 위",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, {npc:3341} 바로 서쪽",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "가시멧돼지 물웅덩이에서 {item:7766} 채우기",
	-- {object:107045} Spring Well · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "보관하십시오: {object:107045}은(는) {area:272} 옆에 있습니다",

	-- Step 55: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "갠 서쪽의 {area:1701}은(는) 서슬갈기일족이 차지하고 있습니다. {npc:3436}은(는) 동쪽에, {npc:3434}은(는) 남쪽에, {npc:3435}은(는) 서쪽 끝에 있습니다. 로크(25)와 서슬갈기일족 광전사(24-25)는 몇 레벨 높습니다. 희귀 정예 {npc:5859}이(가) 가끔 능선을 걸으니 피하십시오. 서슬갈기일족 길잡이와 정찰꾼이 기습용 단검을, 점쟁이가 마법봉을, 광전사가 전투용 방패를 떨어뜨립니다. {npc:3238} 도마뱀과 긴발톱 빗송곳니하이에나가 {npc:3341}와(과) 능선 사이 평원을 돌아다닙니다. 희귀한 붉은 바람뱀 {quest:885}이(가) 능선 위를 날며, 그 깃털로 퀘스트가 시작됩니다.",
	-- {npc:3238} Stormhide · {npc:3341} Gann Stonespire
	["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, {npc:3341}와(과) 능선 사이 평원",

	-- Step 56: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "갠 남쪽 {area:359}에서 바엘던 드워프들이 발굴하고 있습니다. 바엘던 발굴인부와 현장감독이 구덩이에서 일하며, {npc:3392}(26)이(가) 일지를 가지고 있으니 그만 따로 끌어오십시오.",

	-- Step 58: Bael'dun fortress
	["Bael'dun fortress"] = "바엘던 요새",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "바엘던 병사, 소총병, 장교가 발굴 현장 동쪽의 요새를 지킵니다. 세 아이템 모두 그들이 떨어뜨립니다.",

	-- Step 60: The flying machine
	["The flying machine"] = "비행 기계",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "드워프의 비행 기계는 발굴 현장 안 발판 위에 있습니다.",

	-- Step 62: Twitching Antennae
	["Twitching Antennae"] = "꿈틀거리는 더듬이",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "더듬이는 떨어진 지 15분 후에 사라지니 북쪽으로 돌아가는 길에 지금 모으십시오. {area:390} 흙더미의 우두머리 실리시드와 독침 실리시드를 다섯 개가 될 때까지 처치한 뒤 곧바로 {area:378}(으)로 귀환하십시오.",
	["Twitching Antennae from the silithid"] = "실리시드에게서 꿈틀거리는 더듬이",

	-- Step 66: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878}은(는) {area:380} 동쪽 길가에 야영하고 있습니다.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "다음으로 {quest:1838}(1838, 30레벨)을(를) 줍니다. {area:1717}이(가) 필요하며 칼림도어와 동부 왕국 곳곳을 돌아다니게 합니다. 전사 직업 가이드 {quest:1838}에서 다룹니다.",

	-- Step 67: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "{area:1637}(으)로 비행해 수련하십시오.",

	-- Step 68: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344}은(는) {area:1638}에서 성기사를 가르칩니다. 아직 그곳 비행 경로가 없으니 {area:378}(으)로 비행한 뒤 서쪽으로 {zone:1412}을(를) 지나 승강기를 타고 올라가, 중앙 언덕의 {npc:2995}에게서 비행 경로를 얻으십시오.",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}은(는) {object:172960}에 있습니다. 그곳 소환진에서 {item:6626}을(를) 사용하고 서큐버스를 쓰러뜨려 속박하십시오.",

	-- Step 70: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}의 {npc:2391}이(가) 독 조제를 가르칩니다: 보관하세요",

	-- Step 71: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "{area:1638}(으)로 비행해 수련하십시오. {npc:3033}은(는) {area:1639}에 있습니다.",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "{spell:18960}을(를) 시전하세요. 타우렌: {area:2361}의 {npc:11802}을(를) 만나기 전에 호수 북서쪽 기슭 {area:2362}에서 펜던트 두 조각을 합치세요.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: {area:2362}에서 조각을 사용하십시오",
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: {npc:3033}이(가) 보낸 환영 인사",

	-- Step 73: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "타우렌: {npc:11957}은(는) 다리 위 남쪽 언덕에서 기다립니다. 스카이본: {npc:272054}은(는) 쌍둥이 다리 남쪽에 있습니다. 그다음 호수 동쪽 굴로 가십시오. 변신을 풀고, 입구의 석상을 클릭해 5분간 은신하고, 안의 혼령을 피해 유물을 하나씩 가져가십시오. {item:280680}은(는) 흰 살쾡이 석상 아래에 있습니다.",

	-- Step 75: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{area:2361}의 {npc:11798}이(가) 드루이드를 그곳으로 태워 줍니다",

	-- Step 76: Back to the Crossroads
	-- {area:380} Crossroads · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "{area:380}(으)로 비행해 돌아가십시오. 다음 가이드는 여기서 시작해 북쪽 길로 {area:1703}와(과) {zone:1440}(으)로 갑니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bruuz"] = "브루즈",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790}은(는) {area:382} 북쪽 가장자리, 투자개발회사 탑 옆에 있습니다. {quest:30}용 {item:15883}이(가) 들어 있습니다.",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{area:272}의 {npc:2391}이(가) {spell:2842}을(를) 가르칩니다: 보관하세요",
}
