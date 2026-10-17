-- Korean (koKR): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50레벨에 {zone:1447}과(와) {area:1417}에서 경험치와 골드를 얻습니다. Forever에서는 클래식의 아이템 선택이 제거되었습니다.",
	["Experience and gold"] = "경험치와 골드",

	-- Step 1: Cenarion Aid (Alliance)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Alliance)"] = "{quest:8254}(얼라이언스)",
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "50레벨에 {zone:1453} 빛의 대성당의 {npc:5489} 또는 {zone:1455} {object:32386}의 {npc:11406}이(가) 줍니다.",

	-- Step 2: Cenarion Aid (Horde)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Horde)"] = "{quest:8254}(호드)",
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits
	["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "50레벨에 {zone:1454} {object:172961}의 {npc:6018}이(가) 줍니다.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}은(는) {area:1221} 북동쪽 절벽 위에 삽니다. 얼라이언스: {area:3137}(으)로 날아가십시오. 호드: {area:1237}(으)로 날아가십시오.",

	-- Step 4: Of Coursers We Know
	-- {zone:1447} Azshara · {item:20027} Healthy Courser Gland
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "덩치큰 이끼발굽순록이 {zone:1447} 전역에서 풀을 뜯습니다. 셋 중 하나 정도가 {item:20027}을(를) 떨어뜨립니다.",

	-- Step 6: The Ichor of Undeath
	-- {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {area:3137} Talrendis Point
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "모든 언데드가 떨어뜨릴 수 있습니다. {npc:8405}의 절벽 아래 {area:1221}의 {npc:7864}이(가) 가장 가깝습니다. 명가의 유령과 명가의 망령은 {area:3137} 근처 폐허에 출몰합니다.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}의 몰파즈",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "몰파즈는 50레벨 던전인 {area:1417} 안의 정예 용 우두머리입니다. 5인 파티를 꾸리십시오. 사원은 {area:74} 한가운데에 있으며, 헤엄쳐 내려가면 입구에 닿습니다. 호드: {area:75}(으)로 날아가십시오. 얼라이언스: {area:42} 또는 {area:1438}(으)로 날아간 뒤 달려가십시오.",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}: {area:1417} 입구",

	-- Step 9: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922}은(는) {zone:1448} 남쪽의 {area:2479}에 있습니다.",
}
