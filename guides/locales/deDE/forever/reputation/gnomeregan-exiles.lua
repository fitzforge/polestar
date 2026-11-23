-- German (deDE): the guide forever/reputation/gnomeregan-exiles (forever/reputation/gnomeregan-exiles.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gnomeregan Exiles Reputation"] = "Ruf: Gnomeregangnome",
	-- {npc:9616} Laris Geardawdle · {zone:1426} Dun Morogh · {zone:1455} Ironforge
	["Cloth, {npc:9616}'s ooze quests and the {zone:1426} hubs, which pay {zone:1455} too: best done while leveling."] = "Stoff, die Schleim-Quests von {npc:9616} und die Hubs von {zone:1426}, die auch {zone:1455} bezahlen: am besten beim Leveln erledigt.",
	-- {faction:54} Gnomeregan Exiles
	["Exalted with {faction:54}: in Classic, other races may buy the mechanostriders"] = "Ehrfürchtig bei {faction:54}: In Classic dürfen andere Rassen die Mechanostrider kaufen",
	-- {area:133} Gnomeregan · {npc:9616} Laris Geardawdle · {quest:4262} Overmaster Pyron
	["400 {area:133} reputation from {npc:9616}'s ooze jars and {quest:4262} (level 52-54)"] = "400 Ruf bei {area:133} aus den Schleimgläsern von {npc:9616} und {quest:4262} (Stufe 52-54)",
	-- {area:133} Gnomeregan · {zone:1426} Dun Morogh · {zone:1455} Ironforge
	["About 3,000 {area:133} reputation from low-level quests in {zone:1426}, paid to {zone:1455} too"] = "Etwa 3.000 Ruf bei {area:133} aus Quests niedriger Stufe in {zone:1426}, auch an {zone:1455} gezahlt",

	-- Step 1: Bubulo Acerbus, the cloth quartermaster
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, the cloth quartermaster"] = "{npc:14724}, der Stoff-Rüstmeister",
	-- {npc:14724} Bubulo Acerbus · {faction:54} Gnomeregan Exiles · {object:171524} Tinker Town · {zone:1455} Ironforge · {item:14047} Runecloth · {quest:7812} Additional Runecloth · {zone:1426} Dun Morogh · {npc:4077} Gaxim Rustfizzle · {npc:9616} Laris Geardawdle · {quest:4262} Overmaster Pyron · {area:132} Coldridge Valley · {area:131} Kharanos · {area:133} Gnomeregan · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14724} takes cloth for the {faction:54}; he stands in {object:171524} in {zone:1455}, by the tram. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7812} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12) and {npc:4077}'s quests in Stonetalon (20-25) while you level. After the donations come {npc:9616}'s ooze quests and {quest:4262} (400), then the optional {zone:1426} hubs, best rate first: {area:132} (about 38 a minute at full value), {area:131} (26), the quarry (17). Every {area:133} gain also gives a quarter as much to {zone:1453}, {zone:1455} and {zone:1457}, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14724} nimmt Stoff für die {faction:54} an; er steht in {object:171524} in {zone:1455}, bei der Tram. Jede erste Spende von 60 Wollstoff, Seide, Magiestoff und {item:14047} bringt einmalig 150 Ruf; nach der {item:14047}-Spende zahlt {quest:7812} 50 für je 20 {item:14047}, beliebig oft. Das Auktionshaus in den Commons ist die schnellste Quelle für Stoff. In Classic zahlen Quests vollen Ruf, solange sie höchstens 5 Stufen unter dir liegen, mache also {zone:1426} (Stufe 1-12) und die Quests von {npc:4077} im Steinkrallengebirge (20-25), während du levelst. Nach den Spenden kommen die Schleim-Quests von {npc:9616} und {quest:4262} (400), dann die optionalen Hubs von {zone:1426}, beste Rate zuerst: {area:132} (etwa 38 pro Minute bei vollem Wert), {area:131} (26), der Steinbruch (17). Jeder Ruf-Gewinn bei {area:133} gibt außerdem ein Viertel davon an {zone:1453}, {zone:1455} und {zone:1457}, außer bei Quests in den Startgebieten der Stufen 1-10. Das Vermächtnis „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu.",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}: Troggs, Gnolle und Kobolde in {zone:1432} und der {zone:1437}",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,150 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: das Start-Tal der Zwerge und Gnome südwestlich von {area:131}, etwa 1.150 Ruf in 30 Minuten auf 60. {npc:658} und {npc:713} stehen bei {area:77}. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

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
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7812} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7812}."] = "{item:14047} fällt von Humanoiden ab Stufe 50: den Kultisten der Geißel und dem Scharlachroten Kreuzzug im Pestland, den Deadwood-Furbolgs von {zone:1448}, den Winterquell-Furbolgs von {zone:1452}. Behalte jedes {item:14047} nach den ersten 60 für {quest:7812}.",

	-- Step 19: Tinker Town: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle · {object:171524} Tinker Town · {area:133} Gnomeregan
	["{npc:9616} in {object:171524} wants ooze samples for her research: 150 {area:133} reputation for each of her two quests (level 52 and 54: in Classic 60 and 120 of it at 60). She hands you the empty jars."] = "{npc:9616} in {object:171524} will Schleimproben für ihre Forschung: 150 Ruf bei {area:133} für jede ihrer zwei Quests (Stufe 52 und 54: in Classic davon 60 und 120 auf 60). Sie gibt dir die leeren Gläser.",

	-- Step 20: Felwood: Cursed and Tainted Oozes
	-- {zone:1448} Felwood
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{zone:1448}: Cursed and Tainted Oozes"] = "{zone:1448}: Cursed und Tainted Oozes",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill one and use an empty jar on its remains."] = "Die Cursed und Tainted Oozes gleiten durch die Bäche und Teufelspfützen um {area:1763} und {area:1765}: Töte eines und benutze ein leeres Glas an seinen Überresten.",

	-- Step 21: Tinker Town: the second jars
	-- {object:171524} Tinker Town
	["{object:171524}: the second jars"] = "{object:171524}: die zweiten Gläser",

	-- Step 22: Un'Goro Crater: Primal Oozes
	-- {zone:1449} Un'Goro Crater
	-- plural, as words: Primal Oozes = {npc:6557} Primal Ooze
	["{zone:1449}: Primal Oozes"] = "{zone:1449}: Primal Oozes",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Primal Oozes = {npc:6557} Primal Ooze · Glutinous Oozes = {npc:6559} Glutinous Ooze
	["The Primal Oozes live in the pools around {area:537} in the middle of the crater; the Muculent and Glutinous Oozes fill the jars too. Kill one and use a jar on its remains."] = "Die Primal Oozes leben in den Teichen um {area:537} in der Mitte des Kraters; auch die Muculent und Glutinous Oozes füllen die Gläser. Töte eines und benutze ein Glas an seinen Überresten.",

	-- Step 23: Tinker Town: hand in
	-- {object:171524} Tinker Town
	["{object:171524}: hand in"] = "{object:171524}: abgeben",

	-- Step 24: Morgan's Vigil: Jalinda Sprig
	-- {npc:9561} Jalinda Sprig · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4262} Overmaster Pyron · {area:133} Gnomeregan · {area:1584} Blackrock Depths
	["{npc:9561} at {area:2418}, in the south-east of the {zone:1428}, wants {quest:4262} dead: 100 {area:133} reputation (level 52: in Classic 40 at 60). Her next quest, Incendius!, needs a {area:1584} group: 100 more, in full."] = "{npc:9561} bei {area:2418}, im Südosten der {zone:1428}, will {quest:4262} tot sehen: 100 Ruf bei {area:133} (Stufe 52: in Classic 40 auf 60). Ihre nächste Quest, Incendius!, braucht eine Gruppe für {area:1584}: 100 mehr, in voller Höhe.",

	-- Step 25: Blackrock Mountain: Overmaster Pyron
	-- {area:254} Blackrock Mountain · {zone:1428} Burning Steppes · {quest:4262} Overmaster Pyron · {area:1584} Blackrock Depths
	["{area:254} stands in the west of the {zone:1428}. {quest:4262}, a fire elemental, walks the lava paths inside it, near the door of {area:1584} but outside the dungeon: at 60 you take him alone."] = "{area:254} liegt im Westen der {zone:1428}. {quest:4262}, ein Feuerelementar, geht auf den Lavapfaden darin umher, nahe der Tür von {area:1584}, aber außerhalb des Dungeons: Auf 60 nimmst du ihn allein.",

	-- Step 26: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}: abgeben",

	-- Step 27: Additional Runecloth to Honored
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Honored"] = "{quest:7812} bis Wohlwollend",
	-- {quest:7812} Additional Runecloth · {item:14047} Runecloth · {npc:9616} Laris Geardawdle · {npc:9561} Jalinda Sprig · {zone:1426} Dun Morogh · {npc:4077} Gaxim Rustfizzle · {object:171524} Tinker Town · {area:133} Gnomeregan
	["{quest:7812}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Night Elf stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Gnomes start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). {npc:9616}'s and {npc:9561}'s quests above take 8 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. Outside Dun Morogh Gnomeregan pays little: {npc:4077}'s quests in Stonetalon (about 500) and {object:171524}'s {area:133} dungeon quests. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7812}: 50 Ruf für 20 {item:14047}, beliebig oft. Nach den vier ersten Spenden steht ein Mensch, Zwerg oder Nachtelf bei Freundlich 700 von 6.000, Wohlwollend ist also 5.300 entfernt: 106 Abgaben, 2.120 {item:14047} (Gnome beginnen 900 höher: 88 Abgaben; Himmelsgeborene beginnen bei Neutral 2.000, also 6.400 entfernt: 128, zwei weniger nach Exploring the Alliance). Die Quests von {npc:9616} und {npc:9561} oben nehmen 8 Abgaben ab; jeder Hub von {zone:1426}, den du gemacht hast, nimmt 10 bis 26 weitere ab. Außerhalb von Dun Morogh zahlt Gnomeregan wenig: die Quests von {npc:4077} im Steinkrallengebirge (etwa 500) und die Dungeon-Quests von {object:171524} bei {area:133}. Jeder Stadt-Gewinn gibt außerdem ein Viertel davon an die anderen drei Allianzstädte (hier nicht mitgezählt). Gib alle deine {item:14047} auf einmal ab.",

	-- Step 28: Additional Runecloth to Revered
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Revered"] = "{quest:7812} bis Respektvoll",
	-- {faction:54} Gnomeregan Exiles · {npc:7955} Milli Featherwhistle · {item:14047} Runecloth
	["Honored: in Classic the {faction:54}' vendors take 10% off for you, {npc:7955}'s mechanostriders (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Wohlwollend: In Classic geben dir die Händler der {faction:54} 10% Rabatt, auch auf die Mechanostrider von {npc:7955} (20g, die schnellen 200g); Forever hat das noch nicht festgelegt, und Guide-Seiten berichten 5% bei Freundlich, steigend auf 20% bei Ehrfürchtig. Von Wohlwollend bis Respektvoll sind es 12.000 Ruf: 240 Abgaben, 4.800 {item:14047}.",

	-- Step 29: Additional Runecloth to Exalted
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Exalted"] = "{quest:7812} bis Ehrfürchtig",
	-- {item:14047} Runecloth · {npc:7955} Milli Featherwhistle · {area:189} Steelgrill's Depot · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:7955} at {area:189} in {zone:1426} sells her mechanostriders to other races in Classic; the Mechanostrider and Swift Mechanostrider guides cover them."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000 Ruf: 420 Abgaben, 8.400 {item:14047}. Bei Ehrfürchtig verkauft {npc:7955} bei {area:189} in {zone:1426} in Classic ihre Mechanostrider an andere Rassen; die Guides zu Mechanostrider und Schnellem Mechanostrider behandeln sie.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder Kill der Geißel hier zählt auch für die {object:92525} (siehe diesen Guide). Das Auktionshaus geht auch.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Keep handing in {quest:7812} until {faction:54} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7812} ab, bis {faction:54} auf Ehrfürchtig ist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
	-- ["Keep handing in {quest:7812}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7812} ab, je 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Bandits und Zuchtmeister der Flusspfoten (Stufe 16-18) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Söldner des Syndikats bei Burg Stromgarde (Stufe 31-32) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:14724} takes cloth for {faction:54} in {object:171524}, {zone:1455}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7812} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14724} nimmt in {object:171524}, {zone:1455}, Stoff für {faction:54} an. Die ersten Spenden von Wollstoff, Seidenstoff, Magiestoff und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach ist {quest:7812} bis Ehrfürchtig wiederholbar. Ehrfürchtig bei der Stadt eines anderen Volkes erlaubt dir, dessen Reittiere zu kaufen. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{npc:14724}: {item:14047} delivered"] = "{npc:14724}: {item:14047} abgeliefert",
	-- ["{quest:7812} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7812} nimmt 20 {item:14047} pro Abgabe und ist beliebig oft wiederholbar. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
}
