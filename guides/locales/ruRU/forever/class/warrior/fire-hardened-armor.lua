-- Russian (ruRU): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "Закаленный огнем доспех",
	["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "Кольчуга на 28-м уровне, капюшон, поножи или рукавицы в зависимости от расы и щит по пути.",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "На 20-м уровне {npc:5479} ({object:2100}, рядом с таверной «Свинья и Свисток») отправляет вас к NPC {quest:1698} в Красногорье.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "На 20-м уровне {npc:5113}, учитель воинов ({zone:1455}), отправляет вас к NPC {quest:1698} в Красногорье.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "На 20-м уровне {npc:7315}, учитель воинов ({zone:1457}), отправляет вас к NPC {quest:1698} в Красногорье.",

	-- Step 4: The Rethban Gauntlet
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698} — в таверне, локация: {area:69}. Испытание на время: бегите на северо-запад в {area:98}, доберитесь до первой развилки и вернитесь к нему, пока не истек таймер. Не умирайте и не отпускайте дух.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "Войдите сюда и вернитесь: {area:98}",

	-- Step 5: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail
	["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413} работает в Квартале дворфов Штормграда. У него хранится {item:6843}, и он дает вам щит: {item:6970}. {quest:1701} – задание 28-го уровня.",

	-- Step 6: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "Опаленные паучьи клыки",
	-- {zone:1437} Wetlands · {item:6838} Scorched Spider Fang
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "Ловцы-кровопийцы и пещерные ловцы ползают около 46,61 в центре зоны {zone:1437}; с них падает {item:6838}.",

	-- Step 7: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "Обугленные и гальванизированные рога",
	-- {npc:6167} Chimaera Matriarch · {item:6839} Charred Horn · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "Химеры-слетки и молодые химеры бродят на юго-западе Когтистых гор, и с ними {npc:6167}: с молодых падает {item:6839}, с матриарха — {item:6840}.",
	-- {item:6839} Charred Horn
	["{item:6839} from the young chimaeras"] = "{item:6839} — с молодых химер",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} — {npc:6167}",

	-- Step 8: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Ругуг — {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Ругуг — элитный свинобраз внутри подземелья {area:1717} на южном краю зоны {zone:1413}; с него падает {item:6841}. {area:1717} — подземелье: лучше собрать группу.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841} — с Ругуга",

	-- Step 9: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "Вернитесь: {npc:5413} ({object:28027}). Он отправит вас к кузнецу вашей расы.",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {npc:5413} Furen Longbeard
	["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416} — в городе {zone:1453}, недалеко от {npc:5413}.",

	-- Step 11: Burning Blood
	-- {zone:1431} Duskwood · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock
	["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "С воргенов Ночной Погибели в зоне {zone:1431} падает {quest:1705}. {npc:6170} бродит на крайнем юго-востоке зоны {zone:1431} и несет {item:6845}.",
	-- {quest:1705} Burning Blood
	["{quest:1705} from the Nightbane worgen"] = "{quest:1705} — с воргенов Ночной Погибели",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845} from {npc:6170}"] = "{item:6845} — {npc:6170}",

	-- Step 13: Mathiel
	-- {quest:1703} Mathiel · {zone:1457} Darnassus
	["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703} — кузнец в городе {zone:1457}.",

	-- Step 14: Sunscorched Shells
	-- {quest:1710} Sunscorched Shells · {zone:1441} Thousand Needles
	["The {quest:1710} lie along the western edge of {zone:1441}."] = "{quest:1710} лежат вдоль западного края зоны {zone:1441}.",

	-- Step 16: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge
	["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "Поезжайте на поезде ({area:2257}) из города {zone:1453} в {zone:1455}.",

	-- Step 17: Iron Coral
	-- {quest:1708} Iron Coral · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "{quest:1708} растет вдоль западного побережья зоны {zone:1437}, к югу от места {area:150}.",
}
