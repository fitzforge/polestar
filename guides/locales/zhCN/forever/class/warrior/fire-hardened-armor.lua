-- Chinese (simplified) (zhCN): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "淬火护甲",
	["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "28级的锁甲，按种族还有罩帽、护腿或护手，途中还有一面盾牌。",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "20级时，{object:2100}酒馆旁的{npc:5479}会让你去赤脊山找{quest:1698}。",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "20级时，{zone:1455}的战士训练师{npc:5113}会让你去赤脊山找{quest:1698}。",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "20级时，{zone:1457}的战士训练师{npc:7315}会让你去赤脊山找{quest:1698}。",

	-- Step 4: The Rethban Gauntlet
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698}在{area:69}的旅店里。他的测试有时间限制：向西北跑进{area:98}，到达第一个岔路口后在时间用完前回到他身边。不要死亡并释放灵魂。",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "进入{area:98}后返回",

	-- Step 5: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail
	["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413}在暴风城的矮人区工作。他保管着{item:6843}，并给你一面盾牌{item:6970}；{quest:1701}是28级任务。",

	-- Step 6: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "{item:6838}",
	-- {zone:1437} Wetlands · {item:6838} Scorched Spider Fang
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "{npc:1111}和{npc:4040}在{zone:1437}中部46,61附近爬行；它们掉落{item:6838}。",

	-- Step 7: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "烧焦的奇美拉角和{item:6840}",
	-- {npc:6167} Chimaera Matriarch · {item:6839} Charred Horn · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "奇美拉雏兽和{npc:4032}在石爪山脉西南部游荡，{npc:6167}也在其中：幼年奇美拉掉落{item:6839}，奇美拉主母掉落{item:6840}。",
	-- {item:6839} Charred Horn
	["{item:6839} from the young chimaeras"] = "{item:6839}，来自幼年奇美拉",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840}，来自{npc:6167}",

	-- Step 8: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}中的鲁古格",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "鲁古格是{area:1717}里的精英野猪人，这个地下城位于{zone:1413}南端；他掉落{item:6841}。{area:1717}是地下城：建议组队。",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}，来自鲁古格",

	-- Step 9: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "回到{object:28027}找{npc:5413}。他会让你去找你自己种族的铁匠。",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {npc:5413} Furen Longbeard
	["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416}在{zone:1453}，离{npc:5413}不远。",

	-- Step 11: Burning Blood
	-- {zone:1431} Duskwood · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock
	["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "{zone:1431}的夜行狼人掉落{quest:1705}。{npc:6170}在{zone:1431}的最东南端游荡，身上带着{item:6845}。",
	-- {quest:1705} Burning Blood
	["{quest:1705} from the Nightbane worgen"] = "{quest:1705}，来自夜行狼人",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845} from {npc:6170}"] = "{item:6845}，来自{npc:6170}",

	-- Step 13: Mathiel
	-- {quest:1703} Mathiel · {zone:1457} Darnassus
	["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703}是{zone:1457}的一名铁匠。",

	-- Step 14: Sunscorched Shells
	-- {quest:1710} Sunscorched Shells · {zone:1441} Thousand Needles
	["The {quest:1710} lie along the western edge of {zone:1441}."] = "{quest:1710}散布在{zone:1441}的西部边缘。",

	-- Step 16: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge
	["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "从{zone:1453}乘{area:2257}前往{zone:1455}。",

	-- Step 17: Iron Coral
	-- {quest:1708} Iron Coral · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "{quest:1708}生长在{zone:1437}西海岸、{area:150}南边。",
}
