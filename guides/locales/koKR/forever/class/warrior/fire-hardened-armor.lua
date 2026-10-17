-- Korean (koKR): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "불에 달궈 만든 갑옷",
	["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "28레벨에 사슬 갑옷, 종족에 따라 사슬 두건, 다리보호구 또는 건틀릿, 그리고 도중에 방패.",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "20레벨에 돼지와 휘파람 선술집 옆 {object:2100}의 {npc:5479}이(가) 붉은마루 산맥의 {quest:1698}에게 보냅니다.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "20레벨에 {zone:1455}의 전사 상급자 {npc:5113}이(가) 붉은마루 산맥의 {quest:1698}에게 보냅니다.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "20레벨에 {zone:1457}의 전사 상급자 {npc:7315}이(가) 붉은마루 산맥의 {quest:1698}에게 보냅니다.",

	-- Step 4: The Rethban Gauntlet
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698}은(는) {area:69} 여관에 있습니다. 그의 시험에는 시간 제한이 있습니다. 북서쪽 {area:98}(으)로 달려가 첫 갈림길에 닿은 뒤 시간이 다 되기 전에 그에게 돌아오십시오. 죽어서 영혼을 해방하면 안 됩니다.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "{area:98}에 들어갔다가 돌아오기",

	-- Step 5: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail
	["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413}은(는) 스톰윈드 드워프 지구에서 일합니다. 그가 {item:6843}을(를) 가지고 있으며 방패인 {item:6970}을(를) 줍니다. {quest:1701}은(는) 28레벨 퀘스트입니다.",

	-- Step 6: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "그을린 거미 송곳니",
	-- {zone:1437} Wetlands · {item:6838} Scorched Spider Fang
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "긴다리흡혈거미와 긴다리동굴거미가 {zone:1437} 중앙 46,61 주변을 기어 다닙니다. 이들이 {item:6838}을(를) 떨어뜨립니다.",

	-- Step 7: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "까맣게 탄 뿔과 번개 뿔",
	-- {npc:6167} Chimaera Matriarch · {item:6839} Charred Horn · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "어린 키메라와 새끼 키메라가 {npc:6167}과(와) 함께 돌발톱 산맥 남서쪽을 돌아다닙니다. 새끼들은 {item:6839}을(를), 우두머리는 {item:6840}을(를) 떨어뜨립니다.",
	-- {item:6839} Charred Horn
	["{item:6839} from the young chimaeras"] = "{item:6839}, 새끼 키메라에게서",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840}, {npc:6167}에게서",

	-- Step 8: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}의 루구그",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "루구그는 {zone:1413} 남쪽 끝 던전인 {area:1717} 안의 정예 가시멧돼지입니다. {item:6841}을(를) 떨어뜨립니다. {area:1717}은(는) 던전입니다. 파티를 권장합니다.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, 루구그에게서",

	-- Step 9: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "{object:28027}의 {npc:5413}에게 돌아가십시오. 그가 당신 종족의 대장장이에게 보냅니다.",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {npc:5413} Furen Longbeard
	["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416}은(는) {zone:1453}에 있으며, {npc:5413}에게서 조금만 걸어가면 됩니다.",

	-- Step 11: Burning Blood
	-- {zone:1431} Duskwood · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock
	["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "{zone:1431}의 파멸의어둠일족 늑대인간이 {quest:1705}을(를) 떨어뜨립니다. {npc:6170}은(는) {zone:1431} 남동쪽 끝을 돌아다니며 {item:6845}을(를) 가지고 있습니다.",
	-- {quest:1705} Burning Blood
	["{quest:1705} from the Nightbane worgen"] = "{quest:1705}, 파멸의어둠일족 늑대인간에게서",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845} from {npc:6170}"] = "{item:6845}, {npc:6170}에게서",

	-- Step 13: Mathiel
	-- {quest:1703} Mathiel · {zone:1457} Darnassus
	["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703}은(는) {zone:1457}의 대장장이입니다.",

	-- Step 14: Sunscorched Shells
	-- {quest:1710} Sunscorched Shells · {zone:1441} Thousand Needles
	["The {quest:1710} lie along the western edge of {zone:1441}."] = "{quest:1710}은(는) {zone:1441} 서쪽 가장자리를 따라 있습니다.",

	-- Step 16: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge
	["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "{zone:1453}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가십시오.",

	-- Step 17: Iron Coral
	-- {quest:1708} Iron Coral · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "{quest:1708}은(는) {area:150} 남쪽, {zone:1437} 서쪽 해안을 따라 자랍니다.",
}
