-- German (deDE): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Ruf: Darnassus",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "Stoff, {item:11040} und die Hubs von {zone:1438} und {zone:1439}: Die Quests zahlen am meisten, während du levelst.",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "Ehrfürchtig bei {faction:69}: In Classic dürfen andere Rassen die Nachtsäbler kaufen",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "{quest:3803}: 50 Ruf für je 10 {item:11040}, beliebig oft",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439}"] = "Etwa 3.700 Ruf bei {faction:69} aus Quests niedriger Stufe in {zone:1438} und {zone:1439}",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "{npc:14725}, der Stoff-Rüstmeister",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {area:1659} Craftsmen's Terrace · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {area:1662} Tradesmen's Terrace · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {area:188} Shadowglen · {area:186} Dolanaar · {area:442} Auberdine · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the {area:1659}, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the {area:1662} is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: {area:188} (about 35 a minute at full value), {area:186} (28), {area:442} (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14725} nimmt Stoff für {faction:69} an; er steht in der {area:1659}, im Nordosten von {faction:69}, bei den Schneidern. Jede erste Spende von 60 Wollstoff, Seide, Magiestoff und {item:14047} bringt einmalig 150 Ruf; nach der {item:14047}-Spende zahlt {quest:7801} 50 für je 20 {item:14047}, beliebig oft. Das Auktionshaus im {area:1662} ist die schnellste Quelle für Stoff. In Classic zahlen Quests vollen Ruf, solange sie höchstens 5 Stufen unter dir liegen, mache also {zone:1438} (Stufe 1-12), {zone:1439} (11-20) und {zone:1440} (18-30), während du durch sie levelst. Nach den Spenden kommen {quest:4183} in der {zone:1428} und {item:11040}, eine zweite wiederholbare Abgabe; dann die optionalen Hubs, beste Rate zuerst: {area:188} (etwa 35 pro Minute bei vollem Wert), {area:186} (28), {area:442} (23). Jeder Ruf-Gewinn bei {faction:69} gibt außerdem ein Viertel davon an {zone:1453}, {zone:1455} und die Gnomeregan-Exilanten, außer bei Quests in den Startgebieten der Stufen 1-10. Das Vermächtnis „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu.",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "{item:2592}: Furbolgs, Satyrn und Naga in {zone:1439} und {zone:1440}",

	-- Step 2: Shadowglen
	-- {zone:1438} Teldrassil · {area:256} Aldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation in 30 minutes at 60. The givers stand around {area:256}, the great tree. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: das Nachtelfen-Startgebiet im Nordosten von {zone:1438}, etwa 1.050 Ruf in 30 Minuten auf 60. Die Questgeber stehen um {area:256}, den großen Baum. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

	-- Step 3: Shadowglen: the glade and the spider den
	-- {area:188} Shadowglen
	["{area:188}: the glade and the spider den"] = "{area:188}: die Lichtung und die Spinnenhöhle",
	-- {area:256} Aldrassil · {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around {area:256} drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "Die Nachtsäbler und Eber streifen über die Lichtung; die Grells um {area:256} lassen den {item:3297} fallen; die Totems stehen im Furbolg-Lager nordwestlich des Baums; die Webwood-Spinnen leben in der Höhle nördlich der Lichtung. {npc:8584} wartet vor dieser Höhle.",

	-- Step 4: Shadowglen: first hand-in
	-- {area:188} Shadowglen
	["{area:188}: first hand-in"] = "{area:188}: erste Abgabe",

	-- Step 5: Shadowglen: the egg and the antidote
	-- {area:188} Shadowglen
	["{area:188}: the egg and the antidote"] = "{area:188}: das Ei und das Gegengift",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "Das {quest:917} liegt im hinteren Teil der Spinnenhöhle; die Pilze wachsen bei den Bäumen, die Lilien an den Teichen, und das {item:10640} fällt von den Webwood Lurkers.",

	-- Step 6: Shadowglen: last hand-in
	-- {area:188} Shadowglen
	["{area:188}: last hand-in"] = "{area:188}: letzte Abgabe",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "{npc:8584}, vor der Spinnenhöhle",

	-- Step 7: Dolanaar
	-- {faction:69} Darnassus
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: das Dorf an der Straße nach {faction:69}, etwa 1.250 Ruf in 45 Minuten auf 60. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

	-- Step 8: Dolanaar: Denalan and the lake
	-- {area:186} Dolanaar · {npc:2080} Denalan
	["{area:186}: {npc:2080} and the lake"] = "{area:186}: {npc:2080} und der See",
	-- {npc:2080} Denalan · {area:259} Lake Al'Ameth · {npc:2107} Gaerolas Talvethren · {area:260} Starbreeze Village · {area:186} Dolanaar
	["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands upstairs in a house in {area:260}, east of {area:186}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2080} pflegt seinen Garten am Südostufer von {area:259}; {npc:2107} steht oben in einem Haus in {area:260}, östlich von {area:186}: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 9: Dolanaar: the woods around the village
	-- {area:186} Dolanaar
	["{area:186}: the woods around the village"] = "{area:186}: die Wälder um das Dorf",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {area:258} Fel Rock · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in {area:258}, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "Die Timberlings am See lassen Samen und Sprossen fallen; die Gnarlpine Ambushers lauern auf der Straße nach Westen Richtung {faction:69}; {npc:2038} wartet tief in {area:258}, nordwestlich des Dorfes; der Traumfänger liegt im Furbolg-Lager östlich des Dorfes, bei {npc:2107}; die Nachtsäbler westlich des Dorfes tragen die Felle.",

	-- Step 10: Dolanaar: first hand-in
	-- {area:186} Dolanaar
	["{area:186}: first hand-in"] = "{area:186}: erste Abgabe",

	-- Step 11: Dolanaar: the Ban'ethil Barrow Den's entrance
	-- {area:186} Dolanaar · {area:262} Ban'ethil Barrow Den
	["{area:186}: the {area:262}'s entrance"] = "{area:186}: der Eingang der {area:262}",

	-- Step 12: Dolanaar: the relics and Ferocitas
	-- {area:186} Dolanaar
	["{area:186}: the relics and Ferocitas"] = "{area:186}: die Relikte und Ferocitas",
	-- {area:262} Ban'ethil Barrow Den · {area:186} Dolanaar
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the {area:262}, south-west of {area:186}; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "Die vier Relikte des Erwachens liegen in der {area:262}, südwestlich von {area:186}; Ferocitas und die Gnarlpine Mystics lagern östlich des Dorfes.",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "{item:8050}, von {quest:2459}",

	-- Step 13: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler · {area:478} Pools of Arlithrien · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the {area:478} in south-west {zone:1438}."] = "{quest:486}, ein großer Bär, streift durch die {area:478} im Südwesten von {zone:1438}.",

	-- Step 14: Auberdine
	-- {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village
	["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation in an hour at 60. The givers stand along the town's street and pier. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Optional: {area:442} in {zone:1439}, eine Bootsfahrt ab {area:702}, etwa 1.400 Ruf in einer Stunde auf 60. Die Questgeber stehen entlang der Straße und des Stegs der Stadt. Forever zahlt diese alten Quests auf jeder Stufe voll. Überspringe diesen Schritt, um den Hub auszulassen.",

	-- Step 15: Auberdine: the coast and the woods
	-- {area:442} Auberdine
	["{area:442}: the coast and the woods"] = "{area:442}: die Küste und die Wälder",
	-- {area:445} Cliffspring Falls
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the {area:445} cave to the north-east."] = "Das Furbolg-Lager südlich der Stadt zählt für How Big a Threat; die Rabid Thistle Bears streifen durch die Wälder südlich der Stadt; die Highborne-Geister der Ruinen von Ameth'Aran, südöstlich der Stadt, tragen die Relikte, und auch Anayas Geist geht dort um; die Knochen liegen am Strand südlich der Stadt; die Pilze wachsen in der Höhle {area:445} im Nordosten.",
	-- {npc:2164} Rabid Thistle Bear · {quest:2139} Tharnariun's Hope · {npc:3701} Tharnariun Treetender
	["{npc:2164}: use {quest:2139} on it and lead it back to {npc:3701}"] = "{npc:2164}: benutze {quest:2139} an ihm und führe ihn zurück zu {npc:3701}",
	-- {npc:2164} Rabid Thistle Bear
	["Capture a {npc:2164}"] = "Fange einen {npc:2164}",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "die blaue Aura in den Ruinen von {quest:954}",

	-- Step 16: Auberdine: first hand-in
	-- {area:442} Auberdine
	["{area:442}: first hand-in"] = "{area:442}: erste Abgabe",

	-- Step 17: Auberdine: the furbolgs, the bears and the grells
	-- {area:442} Auberdine
	["{area:442}: the furbolgs, the bears and the grells"] = "{area:442}: die Furbolgs, die Bären und die Grells",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "Die Blackwood-Furbolgs lagern südlich der Stadt; die Grells von {quest:955}, östlich der Stadt, lassen die Ohrringe fallen; die Überreste der Meeresschildkröten liegen am Strand westlich der Stadt.",

	-- Step 18: Auberdine: second hand-in
	-- {area:442} Auberdine
	["{area:442}: second hand-in"] = "{area:442}: zweite Abgabe",

	-- Step 19: Auberdine: the seal, the Den Mother and the pelts
	-- {area:442} Auberdine · {npc:6788} Den Mother
	["{area:442}: the seal, the {npc:6788} and the pelts"] = "{area:442}: das Siegel, der {npc:6788} und die Felle",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "Der {item:5338} fällt von den Satyrn von {quest:956}; zerstöre das Siegel an der Flamme dort. Der {npc:6788} haust nordöstlich von {quest:956}; die Moonstalker Sires und Matriarchs streifen durch den Süden von {zone:1439}.",
	["the seal at the ancient flame"] = "das Siegel an der uralten Flamme",

	-- Step 20: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "{item:4306} fällt von Humanoiden der Stufen 23 bis 40: den Satyrn und Furbolgs von {zone:1440}, den Lagern der Thistlefur und Foulweald, den Grimmtotem im Steinkrallengebirge.",

	-- Step 21: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "{item:4338} fällt von Humanoiden der Stufen 35 bis 50: den Hatecrest-Naga und Gordunni-Ogern von {zone:1444}, den Dunemaul-Ogern von {zone:1446}.",

	-- Step 22: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "{item:14047} fällt von Humanoiden ab Stufe 50: den Deadwood-Furbolgs von {zone:1448}, den Winterquell-Furbolgs von {zone:1452}, den Kultisten der Geißel im Pestland. Behalte jedes {item:14047} nach den ersten 60 für {quest:7801}.",

	-- Step 23: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562} bei {area:2418}, im Südosten der {zone:1428}, beginnt {quest:4183}: 175 Ruf bei {faction:69} für zwei Quests (Stufe 54: in Classic 140 auf 60), und die Kette geht weiter zu {object:2117} für 175 bei {zone:1453}. Die Black Broodlings und der {npc:7044} leben an den Hängen nördlich der Wache; der {npc:7040} und {npc:7041} westlich davon, in der Mitte der Zone.",

	-- Step 24: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {area:702} Rut'theran Village · {zone:1452} Winterspring · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of {area:69}; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in {area:702} has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the {area:2479}'s chain, {npc:10739} at the {area:202} in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "{npc:344} wartet im Rathaus von {area:69}; seine nächste Quest führt dich zu {object:2117} (der Guide zu {zone:1453} folgt ihr). Weitere Quests bei {faction:69} auf dieser Stufe, falls du vorbeikommst: {npc:7916} in {area:702} hat eine Wildkin-Kette nach {zone:1452} (insgesamt 325, mit Ranshallas Eskorte), Areis Eskorte in {zone:1448} zahlt 150 nach der Kette der {area:2479}, {npc:10739} am {area:202} in {zone:1422} 100 für das {item:12663}, und Put Her Down in der Oberen Schwarzfelsspitze 100 mit einer Gruppe.",

	-- Step 25: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (optional)",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50: 220. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "{quest:3803} nimmt 10 {item:11040} für 50, beliebig oft, und zahlt auf 60 voll. Die Kette davor ist Stufe 50: 220. {npc:6735} schickt dich zu {npc:3516} in der {area:1658}; er will 20 {quest:3764}. (Die Gastwirte von {zone:1453} und {zone:1455} geben denselben Anfang.)",

	-- Step 28: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "Grabe {quest:3764} aus den Erdhügeln im ganzen Krater aus; die meisten Tiere des Kraters und die Gorishi-Silithiden lassen es ebenfalls fallen, etwa bei jedem dritten Kill. Nimm weit mehr als 20: Jede Benutzung des Beutels verbraucht 2, etwa 18 für je 10 {item:11040}.",

	-- Step 29: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the {area:1658}, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "{npc:9047}, neben Fandral in der {area:1658}, nimmt die Erde. {npc:4217} verkauft den {item:11020} und Packets of Tharlendris Seeds. Mit einem Samenpäckchen und 2 {quest:3764} in deinen Taschen benutze den Beutel, um eine {item:11024} wachsen zu lassen, und öffne sie: Etwa jede dritte Hülle enthält {item:11040} (1 bis 5), der Rest andere Kräuter. Der Beutel funktioniert alle 10 Minuten einmal, benutze ihn also, wann immer er bereit ist, während du anderes tust.",

	-- Step 33: Darnassus: Morrowgrain Research
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "{item:11040}: lass es hier wachsen und öffne die Hüllen",

	-- Step 34: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {area:1116} Feathermoon Stronghold · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {area:1116} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "Je 10 {item:11040}: 50 Ruf bei {npc:4217}. Behalte den Beutel und kaufe Samen nach Bedarf. Es ist langsam: etwa 9 Hüllen, 90 Minuten Beutel-Wartezeit, 18 {quest:3764} und 9 Samenpäckchen pro Abgabe, gut 30 Ruf pro Stunde, lass es also neben den {item:14047} laufen. {npc:7879} bei {area:1116} in {zone:1444} nimmt {item:11040} zur selben Rate, 25 für 5, nach seiner eigenen Quest.",

	-- Step 35: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} bis Wohlwollend",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7801}: 50 Ruf für 20 {item:14047}, beliebig oft. Nach den vier ersten Spenden steht ein Mensch, Zwerg oder Gnom bei Freundlich 700 von 6.000, Wohlwollend ist also 5.300 entfernt: 106 Abgaben, 2.120 {item:14047} (Nachtelfen beginnen 900 höher: 88 Abgaben; Himmelsgeborene beginnen bei Neutral 500, also 7.900 entfernt: 158, zwei weniger nach Exploring the Alliance). {quest:4183} und die {item:11040}-Kette oben nehmen 8 Abgaben ab, und je 10 abgegebene {item:11040} zählen als eine weitere; jeder Hub, den du gemacht hast, nimmt 20 bis 28 weitere ab. Weitere Quests zahlen {faction:69}, voll, solange sie höchstens 5 Stufen unter dir liegen: der Rest von {zone:1439} (etwa 3.400 mehr), {area:415} in {zone:1440} (etwa 3.900) und Feathermoon in {zone:1444} (etwa 1.700). Jeder Stadt-Gewinn gibt außerdem ein Viertel davon an die anderen drei Allianzstädte (hier nicht mitgezählt). Gib alle deine {item:14047} auf einmal ab.",

	-- Step 36: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} bis Respektvoll",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Wohlwollend: In Classic geben dir die Händler von Darnassus 10% Rabatt, auch auf Lelanais Nachtsäbler (20g, die schnellen 200g); Forever hat das noch nicht festgelegt, und Guide-Seiten berichten 5% bei Freundlich, steigend auf 20% bei Ehrfürchtig. Von Wohlwollend bis Respektvoll sind es 12.000 Ruf: 240 Abgaben, 4.800 {item:14047}.",

	-- Step 37: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} bis Ehrfürchtig",
	-- {item:14047} Runecloth · {area:1658} Cenarion Enclave · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the {area:1658} in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "Von Respektvoll bis Ehrfürchtig sind es 21.000 Ruf: 420 Abgaben, 8.400 {item:14047}. Bei Ehrfürchtig verkauft Lelanai in der {area:1658} in {faction:69} in Classic ihre Nachtsäbler an andere Rassen; die Guides zu Säbler und Schnellem Säbler behandeln sie.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder getötete Gegner der Geißel hier zählt auch für {object:92525} (siehe den Guide dazu). Das Auktionshaus geht auch.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7801} ab, bis du bei {faction:69} ehrfürchtig bist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7801} ab, jeweils 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Banditen und Zuchtmeister der Flusspfoten (Stufe 16-18) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Söldner des Syndikats bei Burg Stromgarde (Stufe 31-32) lassen ihn hier fallen. Das Auktionshaus geht auch.",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} nimmt in {faction:69} Stoff für {faction:69} an. Die ersten Spenden von Wollstoff, Seidenstoff, Magiestoff und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach wiederholt sich {quest:7801} bis Ehrfürchtig. Bist du bei der Hauptstadt eines anderen Volkes ehrfürchtig, kannst du dessen Reittiere kaufen. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725}: {item:14047} abgeliefert",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} nimmt 20 {item:14047} pro Abgabe und lässt sich beliebig oft wiederholen. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
}
