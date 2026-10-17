-- Korean (koKR): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "50레벨에 얻는 라벤홀트 암살단 평판과 경험치. Forever에서는 클래식의 아이템 선택 보상이 없어졌습니다.",
	["Ravenholdt reputation"] = "라벤홀트 암살단 평판",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (얼라이언스)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "50레벨에 {zone:1453} {object:2100}의 {npc:918}이(가) 줍니다. {zone:1457}의 시우르나, {zone:1455}의 {npc:5165}와(과) 펜스윅도 줍니다.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (호드)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "50레벨에 {object:172960}의 {npc:3328}이(가) 줍니다. {zone:1458} {object:36073}의 {npc:4583}도 줍니다.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore
	["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486}은(는) {area:272} 동쪽 언덕, {zone:1416}(으)로 올라가는 길 위에 숨어 있습니다. 호드는 {area:272}, 얼라이언스는 {area:271}(으)로 비행하십시오.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "얼라이언스는 {area:3137}, 호드는 {area:1237}(으)로 비행하십시오. {zone:1447} 북쪽 언덕의 나무구렁일족 주술사가 약 30분의 1 확률로 자루를 떨어뜨립니다.",

	-- Step 6: Encoded Fragments
	-- {zone:1447} Azshara
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["The Forest Oozes of southern {zone:1447} drop the fragments."] = "{zone:1447} 남부의 숲수액괴물이 페이지를 떨어뜨립니다.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "실렘에게 돌아가기",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}의 몰파즈",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep
	["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "녹색 비룡 몰파즈는 레벨 50 던전인 {area:1417} 깊은 곳의 정예 우두머리입니다: 5인 파티를 꾸리십시오. 신전은 {area:74}에 있으니 입구까지 헤엄쳐 내려가십시오. 호드는 {area:75}(으)로, 얼라이언스는 {area:1438}(으)로 비행한 뒤 달려가십시오.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: 신전 안의 몰파즈",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "라벤홀트 경",
	-- {npc:6768} Lord Jorach Ravenholdt
	["{npc:6768}: no item choices in Forever"] = "{npc:6768}: Forever에서는 아이템 선택 없음",
}
