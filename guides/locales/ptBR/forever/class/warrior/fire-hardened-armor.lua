-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "Armadura Endurecida pelo Fogo",
	["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "Uma cota no nível 28, uma coifa, perneiras ou manoplas conforme a raça, e um escudo no caminho.",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:5479}, em {object:2100}, ao lado da Porco e Apito, envia você a {quest:1698} nas Montanhas Cristarrubra.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:5113}, o instrutor de guerreiros de {zone:1455}, envia você a {quest:1698} nas Montanhas Cristarrubra.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "No nível 20, {npc:7315}, o instrutor de guerreiros de {zone:1457}, envia você a {quest:1698} nas Montanhas Cristarrubra.",

	-- Step 4: The Rethban Gauntlet
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698} está em {area:69}, na estalagem. O teste dele tem tempo: corra para noroeste até {area:98}, chegue à primeira bifurcação e volte a ele antes que o tempo acabe. Não morra nem libere o espírito.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "Entre em {area:98} e volte",

	-- Step 5: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail
	["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413} trabalha no Distrito dos Anões de Ventobravo. Ele fica com o {item:6843} e dá a você {item:6970}, um escudo; {quest:1701} é uma missão de nível 28.",

	-- Step 6: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "Presas de Aranha Calcinadas",
	-- {zone:1437} Wetlands · {item:6838} Scorched Spider Fang
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "As Espreitadoras Sanguessugas e Espreitadoras da Caverna rastejam por volta de 46,61, no meio de {zone:1437}; elas deixam cair a {item:6838}.",

	-- Step 7: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "Chifres Calcinados e Galvanizados",
	-- {npc:6167} Chimaera Matriarch · {item:6839} Charred Horn · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "As Quimeras Filhotes e Quimeras Jovens vagam pelo sudoeste da Cordilheira das Torres de Pedra, com a {npc:6167} entre elas: as jovens deixam cair o {item:6839}; a Matriarca, o {item:6840}.",
	-- {item:6839} Charred Horn
	["{item:6839} from the young chimaeras"] = "{item:6839} das quimeras jovens",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} da {npc:6167}",

	-- Step 8: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Rugug em {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Rugug é um javaliano de Elite dentro de {area:1717}, a Masmorra no extremo sul de {zone:1413}; ele deixa cair o {item:6841}. {area:1717} é uma Masmorra: recomenda-se formar um grupo.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, de Rugug",

	-- Step 9: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "Volte a {npc:5413} no {object:28027}. Ele envia você a um ferreiro da sua raça.",

	-- Step 10: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind · {npc:5413} Furen Longbeard
	["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416} está em {zone:1453}, a pouca distância de {npc:5413}.",

	-- Step 11: Burning Blood
	-- {zone:1431} Duskwood · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock
	["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "Os worgens Nocturno de {zone:1431} deixam cair o {quest:1705}. {npc:6170} anda no extremo sudeste de {zone:1431} e carrega a {item:6845}.",
	-- {quest:1705} Burning Blood
	["{quest:1705} from the Nightbane worgen"] = "{quest:1705} dos worgens Nocturno",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845} from {npc:6170}"] = "{item:6845} de {npc:6170}",

	-- Step 13: Mathiel
	-- {quest:1703} Mathiel · {zone:1457} Darnassus
	["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703} é ferreira em {zone:1457}.",

	-- Step 14: Sunscorched Shells
	-- {quest:1710} Sunscorched Shells · {zone:1441} Thousand Needles
	["The {quest:1710} lie along the western edge of {zone:1441}."] = "As {quest:1710} ficam ao longo da borda oeste de {zone:1441}.",

	-- Step 16: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge
	["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "Pegue o {area:2257} de {zone:1453} para {zone:1455}.",

	-- Step 17: Iron Coral
	-- {quest:1708} Iron Coral · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "O {quest:1708} cresce ao longo da costa oeste de {zone:1437}, ao sul de {area:150}.",
}
