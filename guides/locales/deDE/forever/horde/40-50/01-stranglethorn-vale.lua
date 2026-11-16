-- German (deDE): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Dein Training für Stufe 40 ist in {area:1497}: Flieg von {area:340} dorthin, trainiere und nimm an den Türmen vor der Stadt den Zeppelin nach {object:3202}.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Flugmeister in {area:340}",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "Lehrer in {area:1497}",

	-- Step 3: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen bekommst du ein Reittier. Jedes Volk lernt es beim Lehrer des eigenen Volkes: Bei dir ist es {npc:4773} in {area:159}, ein kurzer Ritt nördlich der Zeppelintürme, mit den Skelettpferden von {npc:4731} (je 20 Gold) neben ihr. Reite zurück zu den Türmen für den Zeppelin nach {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrerin",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Skelettpferde: {npc:4731}, neben {npc:4773} in {area:159}.",

	-- Step 4: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",

	-- Step 5: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",

	-- Step 6: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519}: die Legende liegt in Zul'Kunda, wohin dieser Guide für {npc:1061} geht",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Dschungelpirscher",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "Die Dschungelpirscher (40-41) jagen an der Küste südlich von {object:3202}. Sie liegen weit über dir: Zieh sie einzeln und ruh dich zwischen den Kämpfen aus.\nVorsicht: {npc:730}, ein Elite-Raptor der Stufe 43, streift zwischen den Pirschern umher: Lass ihn für den Gruppenschritt von {quest:195} liegen.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Flugmeister von {object:3202}",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, der Flugmeister, wartet auf dem Oberdeck von {area:35}. Die Questgeber stehen auf den Stegen rund um den Hafen und im Gasthaus.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}: die zuvor gesammelten Snapjaw-Häute; drinnen",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: {npc:2635} sonnt sich an der Küste zwischen Zul'Kunda und {object:3202}, später auf dieser Runde",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, an den Docks: Gazlowes Brief, falls du ihn dabeihast",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631}: {quest:97332}, nach Zimmix' Rettung; das Paket geht an {npc:259961} in {area:16727}, im Guide für {zone:2548}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, auf dem Balkon neben MacKinley",
	["Inside"] = "Drinnen",

	-- Step 11: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "{npc:737}, oben, hat jetzt seinen nächsten Auftrag: Die Skullsplitter-Hauer stammen von den Trollen in Zul'Mamwe, später auf dieser Runde.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, oben",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Verlass den Ort durch den Tunnel; die Notiz liegt in der Piratenbucht gleich nördlich von {area:35}.",

	-- Step 14: Mistvale gorillas
	["Mistvale gorillas"] = "Nebeltalgorillas",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Die Gorillas streifen durch das Tal um Unbagwa. Die Alten lassen die Innereien fallen; jeder von ihnen kann einen Reißzahn fallen lassen: Behalte zehn für Unbagwa, dessen Mokk (44) auf deinen Stranglethorn-Besuch mit etwa 45 wartet.\nVorsicht: Die Alten Nebeltalgorillas (40-41) stehen im Tal dicht beieinander: Zieh sie einzeln.",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "Mine der Venture Co.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Weiter nördlich graben die Goblins der Venture Co. in der Mine östlich der Straße; Minenarbeiter, Vorarbeiter, Landvermesser und Tüftler lassen alle die Kristalle fallen.\nVorsicht: Getarnte Shadowmaw Panthers und Stranglethorn Tigresses streifen um das Lager.",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "Lager von Nesingwary",
	["Head north up the road; the hunters camp on the hill above the river."] = "Geh die Straße nach Norden hinauf; die Jäger lagern auf dem Hügel über dem Fluss.",

	-- Step 19: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729}, der Tiger, auf den dich {npc:717} bei deinem letzten Besuch angesetzt hat, streift über die Hügelkuppe direkt südwestlich des Lagers.",

	-- Step 22: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} sammelt die Seiten von {quest:338}: Die Trolle des Tals lassen sie ab und zu fallen. Nimm seine Quest an; jedes Kapitel nimmt er entgegen, sobald du alle seine Seiten hast.",

	-- Step 23: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: Alle Seiten von Kapitel I sind in deinen Taschen",

	-- Step 24: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: Alle Seiten von Kapitel II sind in deinen Taschen",

	-- Step 25: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: Alle Seiten von Kapitel III sind in deinen Taschen",

	-- Step 26: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: Alle Seiten von Kapitel IV sind in deinen Taschen",

	-- Step 27: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: die vier Kapitel",

	-- Step 28: Zul'Kunda
	["Zul'Kunda"] = "Ruinen von Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Westlich der Expedition stehen die Häuptlinge der Bloodscalp, {npc:1061} und {npc:1062}, zusammen in den Ruinen von Zul'Kunda. Räum zuerst ihre Wachen weg und zieh dann die beiden.\nAn der Küste zwischen Zul'Kunda und {object:3202} teilt sich ein {npc:2635} (Stufe 38, Elite) die Spawnpunkte mit den gewöhnlichen Krokilisken: Töte ihn, wenn er da ist, und nimm seine Haut für {npc:2495} mit.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "vom {object:52}, in den Ruinen",

	-- Step 29: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, neben {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: für {zone:1425}, ungefähr auf Stufe 48",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: die Trophäenschädel stehen in den Ruinen der Skullsplitters, später auf dieser Runde",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: der Höhleneingang unter dem {area:104}, westlich des Lagers",

	-- Step 30: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen bekommst du ein Reittier, und {zone:2548} nach Stranglethorn sind ohne eins ein langer Fußmarsch. Nimm den Zeppelin vom Turm bei {object:3202} nach {zone:1454}: {npc:4752} lehrt Orcs im {object:172958}, beim Zwinger von {npc:3362} (Wölfe je 20 Gold). Dann mit dem Zeppelin zurück nach {object:3202}. Zu wenig Gold? Überspringe diesen Schritt: Der Guide für {zone:1444} kommt mit etwa 45 wieder durch {zone:1454}.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, Reitlehrer",

	-- Step 31: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen bekommst du ein Reittier, und {zone:2548} nach Stranglethorn sind ohne eins ein langer Fußmarsch. Nimm den Zeppelin vom Turm bei {object:3202} nach {zone:1454} und geh die Straße durch {zone:1411} nach Süden bis {area:367}: {npc:7953} lehrt dort Trolle, bei Zjolnirs Raptoren (je 20 Gold). Dann zurück zum Zeppelin nach {object:3202}. Zu wenig Gold? Überspringe diesen Schritt: Der Guide für {zone:1444} kommt mit etwa 45 wieder durch {zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",

	-- Step 32: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen bekommst du ein Reittier, und {zone:2548} nach Stranglethorn sind ohne eins ein langer Fußmarsch. Nimm den Zeppelin vom Turm bei {object:3202} nach {zone:1454}, flieg nach {zone:1456} und reite hinunter nach {area:222}: {npc:3690} lehrt dort Tauren, bei den Kodos von {npc:3685} (je 20 Gold). Dann flieg zurück nach {zone:1454} zum Zeppelin nach {object:3202}. Zu wenig Gold? Überspringe diesen Schritt: Der Guide für {zone:1444} kommt mit etwa 45 wieder durch {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, Reitlehrer",

	-- Step 33: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen bekommst du einen Sturmschreiter, und {zone:2548} nach Stranglethorn sind ohne einen ein langer Fußmarsch. Nimm den Zeppelin vom Turm bei {object:3202} nach {zone:1454} und flieg nach {zone:1456}: Das Himmelsboot nach {zone:2521} legt etwa alle fünf Minuten an den Klippen südlich von {area:17045} ab, nördlich von {zone:1456}, und {npc:265756} lehrt Himmelsgeborene in {area:17684} in {area:16638}. Dann zurück nach {zone:1454} zum Zeppelin nach {object:3202}. Zu wenig Gold? Überspringe diesen Schritt: Der Guide für {zone:1444} kommt mit etwa 45 wieder durch {zone:1454}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}, Reitlehrer, in {area:17684} in {area:16638}",

	-- Step 34: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {area:1497} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1435} Swamp of Sorrows
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen bekommst du ein Reittier, und ohne eines ist der Weg durch {zone:2548} nach dem Schlingendorntal lang. Nimm den Zeppelin vom Turm in {object:3202} zu den Türmen von {area:1497}: {npc:4773} lehrt die Verlassenen in {area:159}, einen kurzen Ritt nördlich, mit den Skelettpferden von {npc:4731} (je 20 Gold). Dann mit dem Zeppelin zurück nach {object:3202}. Zu wenig Gold? Überspring diesen Schritt: Der Guide für {zone:1435} führt dich mit etwa 47 erneut durch {area:1497}.",

	-- Step 35: Your mount at 40
	["Your mount at 40"] = "Dein Reittier mit 40",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "Hexenmeister kaufen kein Reiten: Dein Reittier ist das Teufelsross aus deiner Klassenquest. Zevrost in {zone:1454}, {object:172960}, startet sie und {npc:6251} in {area:392} lehrt es, beides beim Halt in {zone:1454} im Guide für {zone:1444} mit etwa 45.",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "Teufelsross: Zevrost in {zone:1454}, dann {npc:6251} in {area:392}, beim Halt in {zone:1454} im Guide für {zone:1444}.",

	-- Step 36: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol (no name in this language: may be words) · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: Schwimm westlich von {object:3202} hinaus über das {area:104} und tauch zum Höhleneingang im Riff; die Quest wird abgeschlossen, sobald du ihn findest. Lass die Höhle vorerst links liegen: Die Dschungelpirscher sind südlich an der Küste.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "der Eingang von {area:16550}, unter Wasser",

	-- Step 37: Jungle stalkers
	["Jungle stalkers"] = "Dschungelpirscher",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "Die Pirscher-Raptoren jagen im Dschungel südlich von {object:3202}, hinaus Richtung Westküste.\nVorsicht: Die Dschungelpirscher (40-41) stehen hier dicht: Zieh sie einzeln und ruh dich zwischen den Kämpfen aus.",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "Die Naga-Forscher an der Küste südlich von hier (43-44) sind für Bloads und Mok'thardin: Behalte beide Quests für deinen Halt im Schlingendorntal mit etwa 45.",

	-- Step 38: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Geh nach Süden nach {area:35}. Shaky Phillipe wartet an den Docks.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, im Gasthaus: Seine Flaschen werden an der Küste von {zone:1425} angespült, ungefähr auf Stufe 48",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever · {zone:1444} Feralas · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}: {quest:348} (ab 40 verfügbar), Unbagwas Teil beim Halt in {object:3202} im Guide für {zone:1444}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}, oben: Die Stoßzähne stammen von den Skullsplitters, später auf dieser Runde",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "MacKinley, im obersten Stock: für Stoley in {zone:1446}",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "MacKinley: Behalte sie, die Geisterpiraten (43-44) warten auf deinen Halt im Schlingendorntal mit etwa 45",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, drinnen: {item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493}: Behalte sie für {area:43} mit etwa 45",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487}: Behalte sie für {area:43} mit etwa 45",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}, im obersten Stock: Behalte sie für {area:43} mit etwa 45",

	-- Step 39: The Bloodsail ships
	["The Bloodsail ships"] = "Die Schiffe der Blutsegelbukaniere",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Die Schriftrolle, {quest:624}, liegt auf den Decks der drei Schiffe vor {area:43}, bemannt von Piraten der Stufen 42-45, die paarweise auftreten, mit Kapitänen der Stufen 45-48: Mach das in einer Gruppe. Ihre Questreihe führt weiter durch {zone:1435}, {zone:1445} und {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "für einen späteren Halt in den {zone:1435}",

	-- Step 40: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "Flieg zurück nach {object:3202}: Die Schädelspalter von Zul'Mamwe sind gleich östlich davon.",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 41: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinen von Zul'Mamwe",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:1059} Ana'thek the Cruel · {npc:1061} Gan'zulah
	["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "Geh von {object:3202} nach Osten zu den Ruinen der Schädelspalter östlich der Mine der Venture Co.; zieh die Kopfjäger und Berserker einzeln. Ein Haufen Trophäenschädel steht auf der Nordseite der Ruinen. Jeder Schädelspalter kann einen Hauer oder eine Halskette fallen lassen: Die Halsketten dauern am längsten, also töte weiter im Kriegerlager nördlich der Ruinen, bis du alle hast. Vorsicht: {npc:1059} (45) läuft mit zwei Wachen durch die südwestlichen Ruinen; das letzte Teil von {npc:1061}, seine zerbrochene Rüstung, wartet auf deinen Halt im Schlingendorntal mit etwa 45.",
	["Skullsplitter warriors"] = "Krieger der Skullsplitter",

	-- Step 42: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127}: töte diese, wenn du sie triffst",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Die nächsten Trophäenschädel stehen in den kleinen Ruinen direkt nördlich des Kriegerlagers.\nDie letzten Schädel liegen in den Ruinen ein kurzes Stück weiter westlich, auf dem Rückweg nach {object:3202}.",

	-- Step 43: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Geh nach Westen nach {object:3202}.",
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464}: für {npc:256418} in {area:16743}, dem Hordefort in {zone:2548}, im nächsten Guide",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "Behalte {quest:571}, {quest:621} und die Hauer für {npc:737}: Der Häuptling der Schädelspalter, Zanzils Lager, die Naga-Küste und {area:35} kommen bei deinem Halt im Schlingendorntal mit etwa 45, nach {zone:2548}.",

	-- Step 45: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Geh die Straße nach Norden hinauf zum Lager der Jäger.",

	-- Step 47: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:730} ist ein Elite der Stufe 43: Die meisten Klassen schaffen ihn allein auf Stufe 45, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist.",

	-- Step 48: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:728} ist ein Elite der Stufe 40: Die meisten Klassen schaffen ihn allein auf Stufe 42, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist.",

	-- Step 52: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:731} ist ein Elite der Stufe 43: Die meisten Klassen schaffen ihn allein auf Stufe 45, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist.\nVorsicht: Tiger und getarnte Schattenschlundpanther streifen in seiner Nähe umher. Räum sie, bevor du ihn ziehst. Wenn er gezogen wird, ruft {npc:731} Kreaturen im Umkreis von 20 Metern zu Hilfe.",

	-- Step 57: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "In die {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Folge der Straße von {zone:1431} durch {zone:1430} nach Osten in den Sumpf. {npc:1776} wartet bei {area:657}, dem Draenei-Lager direkt an der Straße, dort wo sie aus {zone:1430} kommt.",

	-- Step 58: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Geh nach Osten nach {area:75}, im Schilf südlich der Straße.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, drinnen",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, oben",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, im obersten Stock",

	-- Step 59: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Sägezahnkrokilisken",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Die Krokilisken suhlen sich in den Tümpeln um {npc:5391}s Lager und südlich Richtung {area:75}; etwa jeder vierte lässt eine Flanke fallen.",

	-- Step 60: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru wandert über die Lichtung südwestlich vom {area:76}; sein Knüppel startet eine Quest.",

	-- Step 61: Draenethyst crystals
	["Draenethyst crystals"] = "Draenethystkristalle",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Geh nach Nordosten zum {area:76}. Die Kristalle stehen am Weg hinauf zum Käfig von {npc:5391}.",

	-- Step 62: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} wird im {area:76} im Nordosten des Sumpfs gefangen gehalten. Befrei ihn und folge ihm hinaus; wehr die Sumpfkreaturen ab, die ihn verfolgen.",

	-- Step 63: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Seine Truhe steht in seinem alten Lager nördlich von {area:75}, auf dem Rückweg nach Westen.",

	-- Step 64: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Geh die Straße nach Westen zum Draenei-Lager bei {area:657}, nahe dem Zugang von {zone:1430}. {quest:698} geht beim nächsten Sumpfbesuch an {npc:5592} bei {area:1978}: Behalte die Flanken.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "Unter der Erde",
	-- ["Boat to {area:35}"] = "Schiff nach {area:35}",
	-- ["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Folge der Küste nach Süden. Die Forscher der Naga waten am Ufer entlang und tragen die Schilfbündel; {object:759} sprudelt in den Hügeln gleich östlich davon.",
	-- ["From {area:2408} fly to {area:392}."] = "Flieg von {area:2408} nach {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Weiter nördlich graben die Goblins der Venture Co. in der Mine östlich der Straße; Minenarbeiter, Großknechte, Feldmesser und Tüftler lassen alle die Kristalle fallen.",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Gib Unbagwa die Fangzähne und bleib bei ihm: Er ruft drei Wellen Gorillas, dann {npc:1514}. Kämpf einzeln gegen sie.",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Geh nach Norden zu den Ruinen der Skullsplitters östlich der Mine der Venture Co.; zieh die Kopfjäger und Berserker einzeln. {npc:1059} bewacht die südwestlichen Ruinen, und ein Haufen Trophäenschädel steht auf der Nordseite der Ruinen. Jeder Skullsplitter kann einen Stoßzahn oder eine Halskette fallen lassen: Die Halsketten brauchen am längsten, also töte weiter im Kriegerlager nördlich der Ruinen, bis du alle hast.",
	-- ["Hearth to {area:35}"] = "Ruhestein nach {area:35}",
	-- ["Hearth to {object:3202}"] = "Ruhestein nach {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "Seine Geldkassette wartet in seinem alten Lager nördlich von {area:75}.",
	-- ["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "Wenn du {quest:192} oder {quest:195} übersprungen hast, grinde hier bis Stufe 42,68, um im Plan der Route zu bleiben.",
	-- ["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "Wenn du {quest:208} übersprungen hast, grinde hier bis Stufe 42,74, um im Plan der Route zu bleiben.",
	-- ["Inside {area:1742}"] = "In {area:1742}",
	-- ["Into the {area:8}"] = "In die {area:8}",
	-- ["Ironjaw Basilisks"] = "Eisenkieferbasilisken",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Reite weiter nach Norden in den {zone:1431}, dann auf der Straße nach Osten durch den {zone:1430} in den Sumpf. {npc:1776} wartet bei {area:657}, dem Draeneilager nahe dem Weg vom {zone:1430} herein.",
	-- ["Level 42.68"] = "Stufe 42,68",
	-- ["Level 42.74"] = "Stufe 42,74",
	-- ["Naga shore and the {object:759}"] = "Nagaufer und {object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Nordöstlich des Nebeltals lagern Zanzils Anhänger im Dschungel; jeder von ihnen kann die Mixtur tragen.",
	-- ["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Optional und bei Stufe 42 hart: Die Schriftrolle, {quest:624}, liegt auf den Decks der drei Schiffe vor {area:43}, bemannt von Piraten der Stufen 42-45, die paarweise auftreten. Nimm sie nur mit, wenn du die Besatzung einzeln an die Reling ziehen kannst oder mit einem Freund; ihre Questreihe führt weiter durch {zone:1435}, {zone:1445} und {zone:1425}.",
	-- ["Pirate ghosts"] = "Piratengeister",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Reite zurück nach Osten an {area:75} vorbei und folge der Straße nach Südosten zum kleinen Hordeposten am Ufer.",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "Reite nach Osten nach {area:75}, im Schilf südlich der Straße.",
	-- ["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Reite von {area:35} die Straße nach Norden; die Basilisken sonnen sich auf den Felsen östlich davon mitten im Dschungel, auf dem Rückweg nach {object:3202}. Ihre Splitter fallen oft.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Reite nach Norden zu den Ruinen der Skullsplitter östlich der Mine der Venture Co.; zieh die Kopfjäger und Berserker einzeln. {npc:1059} bewacht die südwestlichen Ruinen, und ein Haufen Trophäenschädel steht auf der Nordseite der Ruinen. Jeder Skullsplitter kann einen Hauer oder eine Halskette fallen lassen: Die Halsketten dauern am längsten, also töte im Kriegerlager nördlich der Ruinen weiter, bis du alle hast.",
	-- ["Ride north up the road to the hunters' camp."] = "Reite die Straße nach Norden hinauf zum Lager der Jäger.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Reite die Straße nach Norden hinauf; die Jäger lagern auf dem Hügel über dem Fluss.",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Reite nach Nordosten zum {area:76}. Die Kristalle stehen am Weg hinauf zum Käfig von {npc:5391}.",
	-- ["Ride north-west to {object:3202}."] = "Reite nach Nordwesten nach {object:3202}.",
	-- ["Ride on north to {object:3202}."] = "Reite weiter nach Norden nach {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Reite nach Süden nach {area:35}. Der zittrige Phillipe wartet an den Docks.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Reite auf der Straße nach Westen zum Draeneilager bei {area:657}, nahe dem Weg vom {zone:1430} herein.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Reite die Straße nach Westen zum Draenei-Lager bei {area:657}, nahe dem Zugang von {zone:1430}. {quest:698} geht beim nächsten Sumpfbesuch an {npc:5592} bei {area:1978}: Behalte die Flanken.",
	-- ["Ride west to {object:3202}."] = "Reite nach Westen nach {object:3202}.",
	-- ["Sawtooth snappers"] = "Sägezahnschnapper",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Südlich von Booty Bay lagern die Schwadroneure der Blutsegelbukaniere an der {area:43}; die Karten und Befehle liegen in ihren Zelten und im Ruderboot neben dem größeren Lager. Jeder Blutsegelbukanier kann Schnupftabak und {npc:2493}s Auge tragen, also töte weiter, bis du beides hast.",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Nimm die Straße nach Norden aus {area:35}; Unbagwa sitzt auf einem Hügel in {area:1737}, östlich der Straße.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Die Dschungelpirscher (40-41) jagen an der Küste südlich von {object:3202}. Sie liegen weit über dir: Zieh sie einzeln und ruh dich zwischen den Kämpfen aus.",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Das Schiff legt im Hafen von {area:35} an. Die Questgeber stehen auf den Stegen rund um den Hafen und im Gasthaus.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Das Schiff nach {area:35} legt am Ende des Piers von {area:392} an.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Die Gorillas streifen durch das Tal um Unbagwa. Die Alten lassen die Innereien fallen; jeder kann einen Fangzahn fallen lassen.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Die letzten Schädel sind in den Ruinen ein kurzes Stück westlich, auf dem Rückweg nach {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Der nächste Guide beginnt hier und bringt dich nach {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Die nächsten Trophäenschädel stehen in den kleinen Ruinen gleich nördlich des Kriegerlagers.",
	-- ["The snappers line the strand south of the post."] = "Die Schnapper säumen den Strand südlich des Postens.",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Die Pirscher-Raptoren jagen im Dschungel südlich von {object:3202}, hinaus Richtung Westküste.",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Die drei geisterhaften Piraten spuken im Dschungel nördlich von {area:35}, nahe Zanzils Lagern: {npc:2535} und {npc:2536} stehen zusammen, {npc:2537} weiter östlich.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Die drei Schiffe liegen vor der {area:43}. Die Besatzungen sind 42-45, Stillwasser 45, Kielhol 46 und {npc:2546} 48: Mit 41 ist das ein Kampf für eine Gruppe oder für das Ende des Guides. Wenn du hingehst, schwimm hinaus und zieh die Besatzung einzeln an die Reling. Eine Schriftrolle, {quest:624}, liegt auf den Decks der Schiffe: Nimm sie mit.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:728} ist ein Elite der Stufe 40: Die meisten Klassen schaffen ihn allein auf Stufe 42, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:730} ist ein Elite der Stufe 43: Die meisten Klassen schaffen ihn allein auf Stufe 45, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:731} ist ein Elite der Stufe 43: Die meisten Klassen schaffen ihn allein auf Stufe 45, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.\nVorsicht: Tiger und getarnte Shadowmaw Panthers streifen in seiner Nähe umher. Räum sie, bevor du ihn ziehst. Wenn er gezogen wird, ruft {npc:731} Kreaturen im Umkreis von 20 Metern zu Hilfe.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "Westlich der Expedition stehen die Häuptlinge der Bloodscalp, {npc:1061} und {npc:1062}, zusammen in den Ruinen von Zul'Kunda. Räum zuerst ihre Wachen weg und zieh dann die beiden.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "Westlich der Expedition stehen die Häuptlinge der Bloodscalp, {npc:1061} und {npc:1062}, zusammen in den Ruinen von Zul'Kunda. Räum zuerst ihre Wachen weg und zieh dann die beiden. Bleib hier bis Stufe 41 bei den Bloodscalp: {quest:586}, als Nächstes am Kessel, schickt dich zu Skullsplittern der Stufe 41-43.\nAn der Küste zwischen Zul'Kunda und {object:3202} teilt sich ein {npc:2635} (Stufe 38, Elite) die Spawnpunkte mit den gewöhnlichen Krokilisken: Töte es, wenn es da ist, und nimm seine Haut für {npc:2495} mit.",
	-- ["Zanzil's camps"] = "Lager von Zanzil",
	-- ["for Stoley in {zone:1446}"] = "für Stoley in {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "für einen späteren Halt in den {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "für später: das {zone:1425}, etwa ab Stufe 48",
	-- ["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "grinde hier an den Bloodscalps: {quest:586} am Kessel danach schickt dich zu den Skullsplitters der Stufen 41-43",
	-- ["grind on {npc:667}"] = "Grinde an {npc:667}",
	-- ["the {area:16550}'s entrance, underwater"] = "der Eingang von {area:16550}, unter Wasser",
	-- ["the {object:2076}"] = "{object:2076}",
	-- ["the {object:2076} again: Yenniku's fate"] = "noch einmal {object:2076}: Yennikus Schicksal",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, neben {npc:2497}",
	-- ["{area:1577}: kill these as you meet them"] = "{area:1577}: töte diese, wenn du sie triffst",
	-- ["{area:392} pier"] = "Pier von {area:392}",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, im obersten Stockwerk",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496} auf dem Balkon neben MacKinley hat noch einen Auftrag: Die Baupläne für den Treibstoffregler aus Cozzles Fußspind gehen an Pozzik an der {area:2240}, auf dem Weg nach {zone:1446} bei etwa Stufe 43.",
	-- ["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	-- ["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519}: Die Basilisken weiden neben der Straße zurück von {area:35}",
	-- ["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} läuft hier herum: schau in den Kreis auf der Karte",
	-- ["{npc:6807}, upstairs"] = "{npc:6807}, oben",
	-- ["{npc:6930}, upstairs"] = "{npc:6930}, oben",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, oben: für {quest:2864} in {area:976}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: für {quest:2864} in {area:976}",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} und {zone:1435} mit 40-43: {object:3202}, die Piraten von {area:35}, Nesingwarys Jagden und {area:75}.",
}
