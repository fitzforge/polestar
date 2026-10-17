-- Korean (koKR): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50레벨에 {zone:1447}와(과) {area:1417}을(를) 통한 경험치. Forever에서는 클래식의 아이템 선택이 사라졌습니다.",
	["Experience"] = "경험치",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (얼라이언스)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "50레벨이 되면 얼라이언스 사냥꾼 상급자 누구나 이 퀘스트를 줍니다: {zone:1453} {object:28027}의 {npc:5516}, {zone:1455} {object:32390}의 {npc:5116}, {zone:1457} 세나리온 자치령의 도리온.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (호드)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "50레벨이 되면 호드 사냥꾼 상급자 누구나 이 퀘스트를 줍니다. {zone:1454} {object:172958}의 {npc:3352}, {zone:1456} {area:1641}의 {npc:3039}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}은(는) {area:1221} 북동쪽 절벽 꼭대기에 삽니다. 얼라이언스는 {area:3137}(으)로, 호드는 {area:1237}(으)로 날아가세요.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser · Perfect Courser Antlers = {item:20017} Perfect Courser Antler
	["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "{npc:8761}은(는) {zone:1447} 곳곳에서 풀을 뜯습니다. 열두 마리 중 하나꼴로 {item:20017} 한 쌍을 떨어뜨립니다.",

	-- Step 6: Wavethrashing
	-- {zone:1447} Azshara
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "폭풍히드라는 {zone:1447} 해안을 따라 기어다닙니다. 북동쪽 해안의 어린 폭풍히드라와 동쪽 해안의 폭풍히드라는 남쪽 해안의 거대한 폭풍히드라보다 비늘을 약 두 배 자주 떨어뜨립니다.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}의 몰파즈",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "몰파즈는 5인 던전인 {area:1417} 안의 정예 용 우두머리입니다. 파티를 데려가세요. 사원은 {area:74} 한가운데에 있으며, 물속으로 헤엄쳐 내려가면 입구가 나옵니다. 호드는 {area:75}(으)로, 얼라이언스는 {area:42}나 {area:1438}(으)로 날아간 뒤 말을 타고 가세요.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, {area:1417} 안",
}
