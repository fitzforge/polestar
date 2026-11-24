-- Korean (koKR): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "50레벨에 {zone:1447}와(과) {area:1417}을(를) 통한 경험치. Forever에서는 클래식의 아이템 선택이 사라졌을 수 있습니다.",
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
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {zone:1447} Azshara · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the {area:1221}, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to {area:3137}; Horde: fly to {area:1237}, a short ride west of him."] = "{npc:8405}은(는) {area:1221} 북동부 가장자리 절벽의 높다란 지점, {zone:1447} 서중부에 있습니다. 폐허 주변 높은 능선을 따라가세요. 아래 구덩이에서는 그에게 오를 수 없습니다. 얼라이언스는 {area:3137}로, 호드는 {area:1237}로 날아가세요. 그의 서쪽으로 조금만 말을 타면 됩니다.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara · {area:1220} Thalassian Base Camp · {area:1237} Valormok · {area:1234} Lake Mennar
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the {area:1220} in the north, and the hills north-east and south-east of {area:1237}; the {area:1234} area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "완벽한 달리기사슴 뿔 두 개가 필요합니다. 이끼발굽 달리기사슴(52-53레벨, 사슴)은 {zone:1447} 전역에서 풀을 뜯으며 열두 번에 한 번 꼴로 뿔을 떨어뜨리니 스무 번쯤 잡으면 됩니다. 좋은 무리는 북쪽 {area:1220}의 북쪽과 {area:1237}의 동북·동남쪽 언덕입니다. {area:1234} 지역에는 정예 거인과 용군단도 있습니다. 체력 30%에서 분노합니다. 달리기사슴은 천둥머리 히포그리프와 같은 지점에서 나오니 주변에 없으면 히포그리프를 처치하면 달리기사슴이 나타날 수 있습니다. 리스폰은 약 5분 30초입니다.",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "{item:20017}, 이끼발굽 달리기사슴에게서",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara · {area:1229} Tower of Eldara · {spell:1494} Track Beasts
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the {area:1229} about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. {spell:1494} does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "{item:20087} 여섯 개가 필요합니다. 물채찍질괴물(머리 셋인 바다 짐승)은 {zone:1447} 해안을 따라 살며 대부분 물속에 있습니다. 동북쪽 해안의 새끼 물채찍질괴물(51-52레벨)은 세 번에 한 번꼴로 비늘을 떨어뜨리고, {area:1229} 옆 동쪽 해안의 물채찍질괴물(52-53레벨)도 비슷합니다(일부는 해변을 걷습니다). 동남쪽 해안의 큰 물채찍질괴물(53-54레벨)은 일곱 번에 한 번꼴입니다. {spell:1494}은(는) 이들을 표시하지 않습니다. 숨을 쉴 수 있는 곳에서 싸우고, 물 호흡 아이템을 준비하세요. 깊은 물에는 정예 상어가 헤엄칩니다.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}의 몰파즈",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {area:75} Stonard · {area:1438} Nethergarde Keep · {area:42} Darkshire · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["Morphaz is an elite green drake (level 52) inside the {area:1417}, a five-player dungeon: needs a group of five. The temple stands in the {area:74} in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} or {area:42} and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses {spell:12533} and {spell:11019}. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "모르파즈는 {area:1417} 안의 52레벨 정예 녹색 용이며 5인 던전이므로 다섯 명이 필요합니다. 사원은 동부 {zone:1435}의 {area:74}에 있습니다. 바깥 계단을 올라 물에 잠긴 홀로 뛰어든 뒤 계단을 따라 내려가 입구로 가세요. 호드는 {area:75}로, 얼라이언스는 {area:1438}이나 {area:42}로 날아가 말을 타고 가세요. 도착할 때 그는 없습니다. 먼저 상층 고리 주변 발판의 트롤 여섯 명을 처치하면 {npc:5710}이(가) 있는 희생의 구덩이로 내려갈 수 있습니다. 잠말란이 죽으면 직조자와 꿈낫 두 마리가 나오니 하나씩 끌어오세요. 둘 다 죽으면 모르파즈와 하자스가 함께 나타나며 떼어낼 수 없습니다. 구덩이 주변 용군단을 먼저 정리하세요. 도움을 부르기 때문입니다. 모르파즈는 {spell:12533}과(와) {spell:11019}을(를) 사용합니다. 이빨은 반드시 떨어집니다. 파티의 전사들은 발코니 트롤의 부두 깃털을 위해 같은 판을 원할 수 있습니다.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, {area:1417} 안",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "클래식에서 오그틴크는 여기서 {item:19991}, {item:19992} 또는 {item:20083}을(를) 선택하게 했습니다. Forever 변경 사항에는 선택이 사라졌다고 적혀 있지만 퀘스트 페이지에는 이름 없는 보상 세 가지가 여전히 올라와 있으니, 제출하기 전에 보상 창을 확인하세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "몰파즈는 5인 던전인 {area:1417} 안의 정예 용 우두머리입니다. 파티를 데려가세요. 사원은 {area:74} 한가운데에 있으며, 물속으로 헤엄쳐 내려가면 입구가 나옵니다. 호드는 {area:75}(으)로, 얼라이언스는 {area:42}나 {area:1438}(으)로 날아간 뒤 말을 타고 가세요.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "{npc:8761}은(는) {zone:1447} 곳곳에서 풀을 뜯습니다. 열두 마리 중 하나꼴로 {item:20017} 한 쌍을 떨어뜨립니다.",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "폭풍히드라는 {zone:1447} 해안을 따라 기어다닙니다. 북동쪽 해안의 어린 폭풍히드라와 동쪽 해안의 폭풍히드라는 남쪽 해안의 거대한 폭풍히드라보다 비늘을 약 두 배 자주 떨어뜨립니다.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}은(는) {area:1221} 북동쪽 절벽 꼭대기에 삽니다. 얼라이언스는 {area:3137}(으)로, 호드는 {area:1237}(으)로 날아가세요.",
}
