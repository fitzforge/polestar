-- German (deDE): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "Feuergehärtete Rüstung",
	["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "Eine Halsberge mit Stufe 28, je nach Volk eine Kettenhaube, Gamaschen oder Stulpen, und unterwegs ein Schild.",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:5479} in der {object:2100}, neben dem Pig and Whistle, zu {quest:1698} ins Rotkammgebirge.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:5113}, der Kriegerlehrer von {zone:1455}, zu {quest:1698} ins Rotkammgebirge.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:7315}, der Kriegerlehrer von {zone:1457}, zu {quest:1698} ins Rotkammgebirge.",

	-- Step 4: The Rethban Gauntlet
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698} ist in {area:69}, im Gasthaus. Seine Prüfung läuft auf Zeit: Lauf nach Nordwesten in die {area:98}, erreiche die erste Gabelung und komm zurück zu ihm, bevor die Zeit abläuft. Stirb nicht und lass deinen Geist nicht frei.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "Betritt die {area:98} und komm zurück",

	-- Step 5: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail
	["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413} arbeitet im Zwergendistrikt von Sturmwind. Er hat {item:6843} und gibt dir {item:6970}, einen Schild; {quest:1701} ist eine Quest der Stufe 28.",

	-- Step 6: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "Versengte Spinnenfangzähne",
	-- {zone:1437} Wetlands · {item:6838} Scorched Spider Fang
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "Die Egelpirscher und Höhlenpirscher krabbeln bei 46,61 in der Mitte von {zone:1437}; sie lassen den {item:6838} fallen.",

	-- Step 7: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "Verkohlte und Galvanisierte Hörner",
	-- {npc:6167} Chimaera Matriarch · {item:6839} Charred Horn · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "Schimärenjunge und Junge Schimären streifen durch den Südwesten des Steinkrallengebirges, mit der {npc:6167} unter ihnen: Die jungen lassen das {item:6839} fallen, die Matriarchin das {item:6840}.",
	-- {item:6839} Charred Horn
	["{item:6839} from the young chimaeras"] = "{item:6839} von den jungen Schimären",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} von der {npc:6167}",

	-- Step 8: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug im Gebiet {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug ist ein Elite-Stacheleber im Gebiet {area:1717}, dem Dungeon am Südende von {zone:1413}; er lässt die {item:6841} fallen. {area:1717} ist ein Dungeon: Eine Gruppe wird empfohlen.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, von Roogug",

	-- Step 9: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "Zurück zu {npc:5413} im {object:28027}. Er schickt dich weiter zu einem Schmied deines eigenen Volkes.",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {npc:5413} Furen Longbeard
	["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416} ist in {zone:1453}, ein kurzes Stück von {npc:5413} entfernt.",

	-- Step 11: Burning Blood
	-- {zone:1431} Duskwood · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock
	["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "Die Worgen der Nachtheuler in {zone:1431} lassen das {quest:1705} fallen. {npc:6170} streift im äußersten Südosten von {zone:1431} umher und trägt den {item:6845}.",
	-- {quest:1705} Burning Blood
	["{quest:1705} from the Nightbane worgen"] = "{quest:1705} von den Worgen der Nachtheuler",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845} from {npc:6170}"] = "{item:6845} von {npc:6170}",

	-- Step 13: Mathiel
	-- {quest:1703} Mathiel · {zone:1457} Darnassus
	["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703} ist ein Schmied in {zone:1457}.",

	-- Step 14: Sunscorched Shells
	-- {quest:1710} Sunscorched Shells · {zone:1441} Thousand Needles
	["The {quest:1710} lie along the western edge of {zone:1441}."] = "Die {quest:1710} liegen am Westrand von {zone:1441}.",

	-- Step 16: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge
	["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "Fahr mit der Bahn {area:2257} von {zone:1453} nach {zone:1455}.",

	-- Step 17: Iron Coral
	-- {quest:1708} Iron Coral · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "Die {quest:1708} wächst an der Westküste von {zone:1437}, südlich des Gebiets {area:150}.",
}
