-- German (deDE): the guide forever/40-50/shendralas (forever/40-50/shendralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1444} Feralas
	["About a dozen quests on a short trip into Forever's new zone (about 45-46 for the Alliance, 47 for the Horde), then on to {zone:1444}."] = "Etwa ein Dutzend Quests auf einem kurzen Abstecher in Forevers neues Gebiet (etwa 45-46 für die Allianz, 47 für die Horde), dann weiter nach {zone:1444}.",

	-- Step 1: North into Desolace
	-- {area:405} Desolace
	["North into {area:405}"] = "Nach Norden nach {area:405}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:1099} Camp Mojache · {area:2577} Dire Maul
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. From {area:1099} ride north-west on the road past {area:2577} and on north into {area:405}: the road comes out on {area:405}'s southern edge."] = "Neu in Forever: Dieser Guide folgt dem, was Spieler in {zone:2652} gemacht haben. Wenn ein Schritt falsch ist, sag uns auf Polestars Discord oder GitHub Bescheid und nenne den Schritt.\n{zone:2652} liegt südlich von {area:405}, durch {area:2657}, und hat keine eigene Flugroute. Reite von {area:1099} auf der Straße nach Nordwesten an {area:2577} vorbei und weiter nach Norden nach {area:405}: Die Straße kommt am Südrand von {area:405} heraus.",
	-- {area:405} Desolace · {zone:1444} Feralas
	["{area:405}, where the road from {zone:1444} comes in"] = "{area:405}, wo die Straße aus {zone:1444} ankommt",

	-- Step 2: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Flieg nach {area:2408}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the zeppelin to {zone:1454} first (from {object:3202} or the {zone:1458})."] = "Neu in Forever: Dieser Guide folgt dem, was Spieler in {zone:2652} gemacht haben. Wenn ein Schritt falsch ist, sag uns auf Polestars Discord oder GitHub Bescheid und nenne den Schritt.\n{zone:2652} liegt südlich von {area:405}, durch {area:2657}, und hat keine eigene Flugroute. Die Quests sind für Stufe 41-45. Kommst du aus den Östlichen Königreichen, nimm zuerst den Zeppelin nach {zone:1454} (von {object:3202} oder {zone:1458}).",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 3: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "Flieg nach {area:608}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:150} Menethil Harbor
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the boat from {area:150} to Theramore first."] = "Neu in Forever: Dieser Guide folgt dem, was Spieler in {zone:2652} gemacht haben. Wenn ein Schritt falsch ist, sag uns auf Polestars Discord oder GitHub Bescheid und nenne den Schritt.\n{zone:2652} liegt südlich von {area:405}, durch {area:2657}, und hat keine eigene Flugroute. Die Quests sind für Stufe 41-45. Kommst du aus den Östlichen Königreichen, nimm zuerst das Boot von {area:150} nach Theramore.",

	-- Step 4: Into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Into the {area:2657}"] = "Ins {area:2657}",
	-- {area:405} Desolace · {area:2408} Shadowprey Village · {area:606} Gelkis Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride east along {area:405}'s southern edge (from {area:2408}: past {area:606}): the {area:2657} opens there into {area:16651}."] = "Reite am Südrand von {area:405} entlang nach Osten (von {area:2408}: an {area:606} vorbei): Dort öffnet sich {area:2657} nach {area:16651}.",

	-- Step 5: Into the Valley of Bones
	-- {area:608} Nijel's Point · {area:405} Desolace · {area:604} Magram Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride south from {area:608} down the road through eastern {area:405} to {area:604}: just past its western edge the path climbs into the {area:2657} and {area:16651}."] = "Reite von {area:608} nach Süden die Straße durch das östliche {area:405} hinunter nach {area:604}: Gleich hinter dessen Westrand steigt der Pfad hinauf in {area:2657} und nach {area:16651}.",

	-- Step 6: The Valley of Bones: a Tattered Journal
	-- {area:2657} Valley of Bones · {quest:93644} Tattered Journal
	["The {area:2657}: a {quest:93644}"] = "{area:2657}: {quest:93644}",
	-- {quest:93644} Tattered Journal · {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	-- plural, as words: Outcast Necromancers = {npc:11559} Outcast Necromancer · Magram Necromancers = {npc:253272} Magram Necromancer · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Neu in Forever: Wenn ein Schritt falsch ist, sag uns auf Polestars Discord oder GitHub Bescheid und nenne den Schritt.\nDie Ausgestoßenen Totenbeschwörer und die Totenbeschwörer der Magram im Tal droppen {quest:93644}, dessen Verfasser in {zone:2652} lebt: Spieler bekamen es nach wenigen Kills. Die Magram-Zentauren lassen dich in Ruhe, bis du angreifst; die Nekrokhane der Magram darunter (Stufe 45) sind Elite: Lass sie in Ruhe.\nDie Gelkis- und Magram-Zentauren haben eigene Questreihen in {area:2657}, etwa 20.000 bis 30.000 Erfahrung mehr wert, aber jede Reihe verlangt Wohlwollend beim jeweiligen Clan. Die beiden Clans sind Rivalen, also arbeite für einen davon: Der Guide zum Ruf bei den Gelkis- und Magram-Zentauren unter Ruf zeigt, wie.",

	-- Step 7: The western pylon
	["The western pylon"] = "Die westliche Pylone",
	-- {quest:92914} Strange Pylons
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector
	["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here."] = "Nach Osten durch das Tal zum seltsamen Kristall auf seinem Sockel: Ein Klick darauf startet {quest:92914}. Die Verfallenen Pylonenbeschützer (Stufe 42-43) darum herum sind die Manaelementare, die ihn bewachen. Leichenfresser (Stufe 45, Elite) streifen östlich davon durchs Tal.",

	-- Step 8: Bristleback Retreat: the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: the eastern pylon"] = "{area:16677}: die östliche Pylone",
	-- {area:16677} Bristleback Retreat · {npc:253527} Kog'thug the Brave
	["East along the valley road to the quilboar of {area:16677}: the second pylon stands at the eastern end of their camp. A Corpsefeeder (level 45, elite) walks this road: let it pass. The Bristlebacks (levels 42-43) attack on sight; {npc:253527} (level 43, elite) and his bodyguards hold the south side of the camp."] = "Nach Osten die Talstraße entlang zu den Stachelebern von {area:16677}: Die zweite Pylone steht am Ostende ihres Lagers. Ein Leichenfresser (Stufe 45, Elite) läuft diese Straße ab: Lass ihn vorbei. Die Borstennacken (Stufe 42-43) greifen sofort an; {npc:253527} (Stufe 43, Elite) und seine Leibwächter halten die Südseite des Lagers.",
	["the eastern pylon"] = "die östliche Pylone",

	-- Step 9: The temple of Shen'dralas: the third pylon
	-- {zone:2652} Shen'dralas
	["The temple of {zone:2652}: the third pylon"] = "Der Tempel von {zone:2652}: die dritte Pylone",
	["South to the Shen'dralar temple at the zone's heart, keeping west of Kog'thug's bodyguards: the third pylon stands inside. The temple's guards are neutral: leave them be."] = "Nach Süden zum Tempel der Shen'dralar im Herzen des Gebiets, halte dich westlich von Kog'thugs Leibwächtern: Die dritte Pylone steht darin. Die Tempelwachen sind neutral: Lass sie in Ruhe.",

	-- Step 10: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93644} Tattered Journal
	["North-west from the temple to {npc:253471}'s camp on the overlook, beside the spirit healer: the {quest:93644} is his, and he wants to hear about the pylons."] = "Vom Tempel nach Nordwesten zum Lager von {npc:253471} auf dem Aussichtspunkt, neben dem Geistheiler: {quest:93644} gehört ihm, und er will von den Pylonen hören.",

	-- Step 11: North into Desolace
	-- {npc:253471} Mordent Evenshade · {area:405} Desolace · {area:604} Magram Village
	["{npc:253471} wants a fragment and a shard of the pylons back from {area:405}'s two centaur villages: {area:604} lies just beyond the valley's northern way out.\nCareful: if you have killed Magram or Gelkis centaurs, that clan's guards may attack you when you walk into its village."] = "{npc:253471} will ein Fragment und einen Splitter der Pylonen aus den beiden Zentaurendörfern von {area:405} zurück: {area:604} liegt gleich hinter dem nördlichen Ausgang des Tals.\nVorsicht: Wenn du Zentauren der Magram oder Gelkis getötet hast, greifen dich die Wachen dieses Klans eventuell an, wenn du ihr Dorf betrittst.",

	-- Step 12: Magram Village
	-- {item:255656} Pylon Fragment
	-- plural, as words: Magram Guardians = {npc:255560} Magram Guardian
	["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it."] = "Das {item:255656} liegt am westlichen Rand des Dorfes; Wächter der Magram (Stufe 39-41) bewachen es.",

	-- Step 13: Gelkis Village
	-- {area:405} Desolace · {area:606} Gelkis Village · {item:255657} Pylon Shard
	-- plural, as words: Gelkis Guardians = {npc:255561} Gelkis Guardian
	["West along {area:405}'s southern edge to {area:606}: the {item:255657} lies at its southern end, watched by Gelkis Guardians (levels 39-41)."] = "Nach Westen am Südrand von {area:405} entlang nach {area:606}: Der {item:255657} liegt an dessen Südende, bewacht von Wächtern der Gelkis (Stufe 39-41).",

	-- Step 14: Back into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Back into the {area:2657}"] = "Zurück ins {area:2657}",
	-- {area:405} Desolace · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["East again along {area:405}'s southern edge: the {area:2657} opens into {area:16651}."] = "Wieder nach Osten am Südrand von {area:405} entlang: Das {area:2657} öffnet sich nach {area:16651}.",

	-- Step 16: The temple: the Mana Sieve
	-- {item:255662} Mana Sieve
	["The temple: the {item:255662}"] = "Der Tempel: das {item:255662}",
	-- {npc:253471} Mordent Evenshade · {item:255662} Mana Sieve · {npc:255486} Historian Biraxas · {quest:96018} Powering the Pylons
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{npc:253471} sends you for the {item:255662}, kept inside the temple beside {npc:255486}. {quest:96018} asks you to gather mana with the Sieve before you repair the pylons: with it in your bags you can handle the Unstable Mana Rifts, the floating sparks of mana all along the road north."] = "{npc:253471} schickt dich nach dem {item:255662}, das im Tempel neben {npc:255486} aufbewahrt wird. {quest:96018} verlangt, dass du mit dem Sieb Mana sammelst, bevor du die Pylonen reparierst: Mit ihm in der Tasche kannst du die Instabilen Manarisse nutzen, die schwebenden Manafunken entlang der Straße nach Norden.",

	-- Step 17: The western pylon: repair it
	["The western pylon: repair it"] = "Der westliche Pylon: reparieren",
	-- {spell:1289727} Repair and Recharge Pylon · {area:2657} Valley of Bones
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector · Magram Necrokhans = {npc:253274} Magram Necrokhan · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Decrepit Pylon Protectors guard it: kill one beside the pylon, then use {spell:1289727} on it, as players did to repair it.\nCareful: the pylon stands at the edge of the {area:2657}, where Magram Necrokhans and Corpsefeeders (elites, level 45) walk, and Nascent Pylon Protectors (elites, 43) wander the road. Pull the Decrepit Pylon Protectors away from them before you repair it."] = "Die Straße nach Norden zum ersten Pylon, unterwegs Mana aus den Instabilen Manarissen sammeln. Verfallene Pylonenbeschützer bewachen ihn: Töte einen neben dem Pylon und wende dann {spell:1289727} auf ihn an, wie es Spieler zur Reparatur getan haben.\nVorsicht: Der Pylon steht am Rand des {area:2657}, wo Nekrokhane der Magram und Leichenfresser (Elite, Stufe 45) umherlaufen, und Entstehende Pylonenbeschützer (Elite, 43) wandern die Straße entlang. Zieh die Verfallenen Pylonenbeschützer von ihnen weg, bevor du ihn reparierst.",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	["{npc:252711}, then {spell:1289727} on it"] = "{npc:252711}, dann {spell:1289727} auf ihn",

	-- Step 18: Bristleback Retreat: repair the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: repair the eastern pylon"] = "{area:16677}: den östlichen Pylon reparieren",
	-- {npc:252711} Decrepit Pylon Protector · {npc:253527} Kog'thug the Brave
	["East along the valley road to the eastern pylon and repair it the same way, a {npc:252711} first, coming in from the west: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "Nach Osten die Talstraße entlang zum östlichen Pylon und repariere ihn genauso, zuerst einen {npc:252711}, von Westen kommend: {npc:253527} (Stufe 43, Elite) und seine Leibwächter halten die Südseite des Stacheleberlagers, und ein Leichenfresser (Stufe 45, Elite) läuft die Straße entlang.",

	-- Step 19: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93016} A Brief History Lesson
	["Back west along the valley road and south to {npc:253471}. {quest:93016} asks you to hear him out: talk to him once more, then hand it in."] = "Zurück nach Westen die Talstraße entlang und nach Süden zu {npc:253471}. {quest:93016} verlangt, dass du ihn anhörst: Sprich noch einmal mit ihm und gib die Quest dann ab.",
	-- {npc:253471} Mordent Evenshade
	["{npc:253471}: hear him out"] = "{npc:253471}: anhören",

	-- Step 20: Liranne
	-- {quest:93568} Partially Digested Collar · {npc:255385} Liranne
	["A Prowler gave up a {quest:93568}: {npc:255385}, north of the temple, knows whose it was."] = "Ein Pirscher hat ein {quest:93568} hergegeben: {npc:255385}, nördlich des Tempels, weiß, wem es gehörte.",

	-- Step 21: The temple: Magister Kirandis
	-- {npc:254656} Magister Kirandis
	["The temple: {npc:254656}"] = "Der Tempel: {npc:254656}",
	-- {npc:254656} Magister Kirandis · {npc:254578} Mithera · {quest:93341} Forlorn Gardens
	["{npc:254656} waits inside the temple. Then {npc:254578}, on the temple's eastern side, has work in the {quest:93341}."] = "{npc:254656} wartet im Tempel. Danach hat {npc:254578} auf der Ostseite des Tempels Arbeit in den {quest:93341}.",

	-- Step 22: The Forlorn Gardens: the pedestal
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}: the pedestal"] = "Die {quest:93341}: der Sockel",
	-- {quest:93341} Forlorn Gardens
	["East of the temple the {quest:93341} have run wild, and their plants attack on sight. Examine the pedestal at the gardens' southern end."] = "Östlich des Tempels sind die {quest:93341} verwildert, und ihre Pflanzen greifen sofort an. Untersuche den Sockel am Südende der Gärten.",

	-- Step 24: The Forlorn Gardens
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}"] = "Die {quest:93341}",
	-- {npc:254674} Woodwyrd · {area:2100} Maraudon
	-- plural, as words: Rowdy Roses = {npc:254566} Rowdy Rose · Terrible Tulips = {npc:254567} Terrible Tulip · Malevolent Marigolds = {npc:254572} Malevolent Marigold · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Rowdy Roses and Terrible Tulips grow all over the gardens; the Malevolent Marigolds keep to the northern part. {npc:254674}, the treant in the middle of the gardens, has a request of his own that needs water from {area:2100}, a dungeon: this guide leaves it.\nThe Shen'dralar who wander the gardens are neutral, like the temple's guards: leave them be and pull the flowers away from them. Careful: Nascent Pylon Protectors (elites, 43) wander the zone's middle, the gardens too: keep clear of them."] = "Ungestüme Rosen und Schreckliche Tulpen wachsen überall in den Gärten; die Bösartigen Ringelblumen halten sich im nördlichen Teil. {npc:254674}, der Treant in der Mitte der Gärten, hat ein eigenes Anliegen, das Wasser aus {area:2100} braucht, einem Dungeon: Dieser Guide lässt es aus.\nDie Shen'dralar, die durch die Gärten wandern, sind neutral, wie die Wachen des Tempels: Lass sie in Ruhe und zieh die Blumen von ihnen weg. Vorsicht: Entstehende Pylonenbeschützer (Elite, 43) wandern durch die Mitte des Gebiets, auch durch die Gärten: Halte dich von ihnen fern.",

	-- Step 25: Mithera
	-- {npc:255486} Historian Biraxas · {npc:254656} Magister Kirandis · {npc:252711} Decrepit Pylon Protector
	["{npc:255486}, inside the temple, has a task for you now that you have met {npc:254656}: the heart of a {npc:252711} (42-43, not elite), a short ride back up the road north."] = "{npc:255486} im Tempel hat nun, da du {npc:254656} getroffen hast, eine Aufgabe für dich: das Herz eines {npc:252711} (42-43, kein Elite), ein kurzer Ritt die Straße zurück nach Norden.",

	-- Step 26: A Heart of Crystal
	-- {npc:253471} Mordent Evenshade
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector
	["The nearest Decrepit Pylon Protectors stand by the road north, from the middle of the zone up to the western pylon, and around {npc:253471}'s overlook: one of them carries the heart Biraxas wants."] = "Die nächsten Verfallenen Pylonenbeschützer stehen an der Straße nach Norden, von der Mitte des Gebiets bis zum westlichen Pylon, und rund um den Aussichtspunkt von {npc:253471}: Einer von ihnen trägt das Herz, das Biraxas will.",

	-- Step 27: Historian Biraxas
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	["{zone:2652} is done: ride back north through the {area:2657}; the next step says where your route goes on from there."] = "{zone:2652} ist erledigt: Reite zurück nach Norden durch das {area:2657}; der nächste Schritt sagt dir, wie deine Route von dort weitergeht.",

	-- Step 28: Shadowprey Village
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:2408} Shadowprey Village · {area:1637} Orgrimmar · {zone:1444} Feralas · {area:1099} Camp Mojache
	["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408}: the next guide picks up in {area:1637}, with the {zone:1444} guide's hand-ins. Your hearthstone is bound at {area:1099}: if it is ready, hearth there and fly to {area:1637} from {area:1099} instead."] = "{zone:2652} ist erledigt. Reite zurück nach Norden durch das {area:2657} und am Südrand von {area:405} entlang nach Westen bis {area:2408}: Der nächste Guide setzt in {area:1637} an, mit den Abgaben aus dem {zone:1444}-Guide. Dein Ruhestein ist an {area:1099} gebunden: Wenn er bereit ist, kehr dorthin zurück und flieg stattdessen von {area:1099} nach {area:1637}.",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Flugmeister: {area:2408}",

	-- Step 29: Back to your route
	["Back to your route"] = "Zurück zu deiner Route",
	-- {zone:2652} Shen'dralas · {zone:1444} Feralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["{zone:2652} is done. Your {zone:1444} guide picks up from here: ride back north through the {area:2657}, west along {area:405}'s southern edge and south into {zone:1444}, to the dock on the {area:1108} where the boat crosses to {area:1116}."] = "{zone:2652} ist erledigt. Dein {zone:1444}-Guide macht von hier aus weiter: Reite zurück nach Norden durch das {area:2657}, am Südrand von {area:405} entlang nach Westen und nach Süden nach {zone:1444}, zum Steg an der {area:1108}, wo das Boot nach {area:1116} übersetzt.",
}
