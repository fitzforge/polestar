-- German (deDE): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "Ruf: Ironforge",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {area:133} Gnomeregan · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay {area:133} too; {zone:1459} adds more."] = "Stoff, die Quests der {zone:1428} und die Hubs von {zone:1426}, die auch {area:133} bezahlen; {zone:1459} bringt mehr.",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "Ehrfürchtig bei {faction:47}: In Classic dürfen andere Rassen die Widder kaufen",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "Etwa 600 Ruf bei {faction:47} aus Quests der Stufen 52-59 in der {zone:1428} und in {zone:1452}; die Quests von {zone:1459} zahlen ebenfalls {faction:47}",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh · {area:133} Gnomeregan
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too"] = "Etwa 2.900 Ruf bei {faction:47} aus Quests niedriger Stufe in {zone:1426}, das meiste davon zahlt auch {area:133}",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "{npc:14723}, die Stoff-Rüstmeisterin",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge (no name in this language: may be words) · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {area:132} Coldridge Valley · {area:131} Kharanos · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: {area:132} (about 37 a minute at full value), {area:131} (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14723} nimmt Stoff für {faction:47} an; sie steht vor dem Schneider auf der Nordseite der {object:32372}, zwischen den Schneidern. Jede erste Spende von 60 Wollstoff, Seide, Magiestoff und {item:14047} bringt einmalig 150 Ruf; nach der {item:14047}-Spende zahlt {quest:7806} 50 für je 20 {item:14047}, beliebig oft. Das Auktionshaus in den Commons ist die schnellste Quelle für Stoff. In Classic zahlen Quests vollen Ruf, solange sie höchstens 5 Stufen unter dir liegen, mache also {zone:1426} (Stufe 1-12), {zone:1432} (10-20) und die {zone:1437} (20-30), während du durch sie levelst. Nach den Spenden kommen die Quests der Stufen 52-59 in der {zone:1428} und in {zone:1452} (etwa 600), dann die optionalen Hubs von {zone:1426}, beste Rate zuerst: {area:132} (etwa 37 pro Minute bei vollem Wert), {area:131} (26), der Steinbruch (17). Jeder Ruf-Gewinn bei {faction:47} gibt außerdem ein Viertel davon an {zone:1453}, {zone:1457} und die Gnomeregan-Exilanten, außer bei Quests in den Startgebieten der Stufen 1-10. Das Vermächtnis „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu.",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}: Troggs, Gnolle und Kobolde in {zone:1432} und der {zone:1437}",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: das Start-Tal der Zwerge und Gnome südwestlich von {area:131}, etwa 1.100 Ruf in 30 Minuten auf 60. {npc:658} und {npc:713} stehen bei {area:77}. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

	-- Step 3: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "Coldridge: Wölfe, Troggs und die Sachen von {npc:8416}",
	-- {area:77} Anvilmar · {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of {area:77}; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "Die Wölfe streifen über den Talboden; die Troggs graben in den Lagern östlich von {area:77}; die Kiste, die Truhe und der Eimer von {npc:8416} liegen in den Trogg-Lagern.",

	-- Step 4: Coldridge: Anvilmar and Talin Keeneye
	-- {area:77} Anvilmar · {npc:714} Talin Keeneye
	["Coldridge: {area:77} and {npc:714}"] = "Coldridge: {area:77} und {npc:714}",

	-- Step 5: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "Coldridge: {npc:786} und die Trollhöhle",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786} lagert südlich von {area:77}, am Eingang der Trollhöhle; das Tagebuch liegt im hinteren Teil der Höhle.",

	-- Step 6: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "Coldridge: der heiße Mornbrew",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at {area:77}."] = "Der Scalding Mornbrew kühlt in fünf Minuten ab: Lauf direkt zu {npc:836} bei {area:77}.",

	-- Step 7: Coldridge: on to Kharanos
	-- {area:131} Kharanos
	["Coldridge: on to {area:131}"] = "Coldridge: weiter nach {area:131}",
	-- {npc:1252} Senir Whitebeard · {area:131} Kharanos
	["{npc:1252}, in {area:131}"] = "{npc:1252}, in {area:131}",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "{npc:6806}, im Gasthaus",

	-- Step 8: Kharanos
	-- {area:131} Kharanos · {area:133} Gnomeregan · {area:2102} Thunderbrew Distillery · {area:189} Steelgrill's Depot
	["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: {area:131} und die Straßen nach Brewnall und {area:133} drumherum, etwa 1.300 Ruf in 50 Minuten auf 60. Die meisten Questgeber stehen in und um {area:2102} und bei {area:189} östlich davon. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

	-- Step 9: Kharanos: the hills and the depot
	-- {area:131} Kharanos
	["{area:131}: the hills and the depot"] = "{area:131}: die Hügel und das Depot",
	-- {area:131} Kharanos · {area:136} Grizzled Den · {area:133} Gnomeregan
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "Die Eber und Bären streifen um {area:131}; die Wendigos leben in der {area:136} südwestlich der Stadt; die Leprakranken Gnome an der Straße nach {area:133} tragen die Zahnräder und Getriebe; Rumbleshots Munition liegt in seinem Lager westlich der Stadt.",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131}: zurück in der Stadt",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131}: Brewnall und {quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374} steht bei {area:137} am See nordwestlich von {area:131}; {quest:287} ist die Trollhöhle westlich davon.",
	["walk to the back of the cave"] = "geh bis ans Ende der Höhle",

	-- Step 12: Kharanos: last hand-in
	-- {area:131} Kharanos
	["{area:131}: last hand-in"] = "{area:131}: letzte Abgabe",

	-- Step 13: The quarry and Amberstill Ranch
	-- {area:803} Amberstill Ranch
	["The quarry and {area:803}"] = "Der Steinbruch und {area:803}",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {area:134} Gol'Bolar Quarry · {area:803} Amberstill Ranch
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation in 30 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: das östliche {zone:1426}, vom Lager von {npc:264936} bis zum {area:134} und {area:803}, etwa 500 Ruf in 30 Minuten auf 60. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

	-- Step 14: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "Der Steinbruch: Troggs, Spione und {npc:1388}",
	-- {area:134} Gol'Bolar Quarry · {npc:1388} Vagash · {area:803} Amberstill Ranch
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {area:134}; {npc:1388}, a big snow leopard, prowls the hills above {area:803}."] = "Die Dark Iron Spies lauern um Farsens Lager; die Troggs graben im {area:134}; {npc:1388}, ein großer Schneeleopard, streift durch die Hügel oberhalb von {area:803}.",

	-- Step 15: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "{npc:1274}, im Thronsaal",

	-- Step 16: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "{item:4306} fällt von Humanoiden der Stufen 23 bis 40: den Dragonmaw der {zone:1437}, dem Syndikat von Alterac und Arathi, den Trollen von Stranglethorn.",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "{item:4338} fällt von Humanoiden der Stufen 35 bis 50: den Zwergen der Shadowforge und der {object:147516} in der {zone:1418} und der {zone:1427}, den Dunemaul-Ogern von {zone:1446}, den Hatecrest-Naga von {zone:1444}.",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "{item:14047} fällt von Humanoiden ab Stufe 50: den Kultisten der Geißel und dem Scharlachroten Kreuzzug im Pestland, den Deadwood-Furbolgs von {zone:1448} und den Winterquell-Furbolgs von {zone:1452}. Behalte jedes {item:14047} nach den ersten 60 für {quest:7806}.",

	-- Step 19: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat · {zone:1428} Burning Steppes
	["These quests are level 52 to 59, so they pay in full at 60: about 600 {faction:47} reputation. {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "Diese Quests sind Stufe 52 bis 59, zahlen also auf 60 voll: etwa 600 Ruf bei {faction:47}. {npc:8879} steht neben König Magni in der {object:171709}; er schickt dich zu den Ruinen von Thaurissan in der {zone:1428}.",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "Hör {npc:8879} an",

	-- Step 20: Morgan's Vigil: Oralius
	-- {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {npc:9177} Oralius · {area:249} Dreadmaul Rock
	["{area:2418} sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of {area:249}, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "{area:2418} liegt im Südosten der {zone:1428}, oben am Pass von Redridge. {npc:9177} will, dass die Firegut-Oger von {area:249}, nördlich der Wache, ausgedünnt werden; die Brutes bleiben an der Ostseite des Felsens.",

	-- Step 21: Thaurissan and Blackrock Stronghold
	-- {area:252} Blackrock Stronghold
	["Thaurissan and {area:252}"] = "Thaurissan und {area:252}",
	-- {area:251} Flame Crest · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around {area:251}, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of {area:254}, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "Die Thaurissan-Relikte sind die geschnitzten Steine in den Ruinen um {area:251}, die Straße weiter westlich: Klicke zwölf davon an. {npc:9176} und die Orcs und Worge der Schwarzfelsen halten die Lager am Fuß von {area:254}, weiter westlich; jeder kann ein {item:11467} fallen lassen (etwa jeder dritte Kill), und {npc:9177} will fünfzig. Die Orcs sind Stufe 50 und höher, lassen also auch {item:14047} fallen: Behalte es für {quest:7806}.",

	-- Step 22: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}: abgeben",
	-- {npc:9176} Gor'tesh · {area:249} Dreadmaul Rock
	["Plant {npc:9176}'s head on the soft dirt mound at the top of {area:249}."] = "Pflanze den Kopf von {npc:9176} in den weichen Erdhügel oben auf {area:249}.",

	-- Step 23: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "{faction:47}: noch einmal Archesonus",
	-- {area:1584} Blackrock Depths · {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, {area:1584} pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "Mit einer Gruppe zahlt {area:1584} mehr: Die Kette von Archesonus geht mit {npc:9021} (100) und The Fate of the Kingdom (Kaiser Thaurissan, 150) weiter, und {npc:9177} nimmt 20 Dark Iron Fanny Packs von den Zwergen darin (The Good Stuff, 100). {zone:1459} zahlt ab Stufe 51 ebenfalls {faction:47}: seine einmaligen Quests etwa 1.900, während dein Stormpike-Ruf wächst (der Guide zu {zone:1459} führt dich hindurch), und im Kampf selbst 25 für je 10 Irondeep oder {item:17542} und 50 für 5 Storm Crystals, beliebig oft.",

	-- Step 24: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village · {area:2245} Mazthoril · {faction:47} Ironforge
	["{npc:11755} in {area:2255} sends you west to {npc:10301} at {area:2253}. {npc:10301}'s damaged crate and wrecked wagon lie at {area:2245}, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "{npc:11755} in {area:2255} schickt dich westlich zu {npc:10301} bei {area:2253}. {npc:10301}s beschädigte Kiste und der zerstörte Wagen liegen bei {area:2245}, das Tal hinunter nach Südosten; seine Vorräte liegen um den Wagen herum, und die Eulenbiester in der Nähe tragen sein Amulett. Die letzte Quest ist Stufe 59: 100 {faction:47} in voller Höhe.",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806} bis Wohlwollend",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {area:144} Thelsamar · {zone:1432} Loch Modan · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7806}: 50 Ruf für 20 {item:14047}, beliebig oft. Nach den vier ersten Spenden steht ein Mensch, Nachtelf oder Gnom bei Freundlich 700 von 6.000, Wohlwollend ist also 5.300 entfernt: 106 Abgaben, 2.120 {item:14047} (Zwerge beginnen 900 höher: 88 Abgaben; Himmelsgeborene beginnen bei Neutral 2.000, also 6.400 entfernt: 128, zwei weniger nach Exploring the Alliance). Die Quests der Stufen 52-59 oben nehmen 12 Abgaben ab; jeder Hub von {zone:1426}, den du gemacht hast, nimmt 10 bis 26 weitere ab. Weitere Hubs zahlen {faction:47}, voll, solange sie höchstens 5 Stufen unter dir liegen: {area:144} in {zone:1432} (insgesamt etwa 3.500) und {area:150} in der {zone:1437} (etwa 2.500). Ab Stufe 51 fügen die einmaligen Quests von {zone:1459} etwa 1.900 hinzu. Jeder Stadt-Gewinn gibt außerdem ein Viertel davon an die anderen drei Allianzstädte (hier nicht mitgezählt). Gib alle deine {item:14047} auf einmal ab.",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806} bis Respektvoll",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Wohlwollend: In Classic geben dir die Händler von Ironforge 10% Rabatt, auch auf die Widder von {npc:1261} (20g, die schnellen 200g); Forever hat das noch nicht festgelegt, und Guide-Seiten berichten 5% bei Freundlich, steigend auf 20% bei Ehrfürchtig. Von Wohlwollend bis Respektvoll sind es 12.000 Ruf: 240 Abgaben, 4.800 {item:14047}.",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806} bis Ehrfürchtig",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {area:803} Amberstill Ranch · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at {area:803} in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000 Ruf: 420 Abgaben, 8.400 {item:14047}. Bei Ehrfürchtig verkauft {npc:1261} bei {area:803} im Osten von {zone:1426} in Classic seine Widder an andere Rassen; die Guides zu Widder und Schnellem Widder behandeln sie.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder Geißel-Kill hier zählt auch für die {object:92525} (siehe den Guide dazu). Das Auktionshaus geht auch.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7806} ab, bis {faction:47} Ehrfürchtig ist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) im Gebiet {zone:1423} oder das Auktionshaus.",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7806} ab, jeweils 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) im Gebiet {zone:1423} oder das Auktionshaus.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Banditen und Zuchtmeister der Flusspfoten (Stufe 16-18) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Söldner des Syndikats bei Burg Stromgarde (Stufe 31-32) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723} nimmt Stoff für {faction:47} an, in {faction:47}. Die ersten Spenden von Woll-, Seiden-, Magie- und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach wiederholt sich {quest:7806} bis Ehrfürchtig. Ehrfürchtig bei der Hauptstadt eines anderen Volkes erlaubt dir, dessen Reittiere zu kaufen. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723}: {item:14047} abgegeben",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806} nimmt 20 {item:14047} pro Abgabe und lässt sich beliebig oft wiederholen. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) im Gebiet {zone:1423} oder das Auktionshaus.",
}
