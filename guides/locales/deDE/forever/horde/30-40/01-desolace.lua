-- German (deDE): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "Flieg vom {area:484} nach {area:1637}.",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} wartet in der Gasse; {npc:5640} steht im {object:172961} auf der Westseite der Stadt. Himmelsgeborene: {npc:4949} wartet in der Feste Grommash im {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Grommash Hold, falls du sie dabeihast",

	-- Step 3: Train
	["Train"] = "Trainieren",
	["Train your new spells."] = "Lerne deine neuen Zauber.",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Dein Lehrer ist in {area:1638}, einen Flug entfernt: {npc:3033} (Druiden) auf der Anhöhe ({area:1639}), {npc:246344} (Paladine). Flieg von dort weiter nach {area:460}.",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Klassenquests in {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} steht im {object:172957}.",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short walk south of the town."] = "Flieg nach {area:392}. {npc:5901} lagert an der Küste, einen kurzen Fußweg südlich der Stadt.",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Flieg zum {area:484}. {npc:5905} versteckt sich in einer kleinen Höhle in der Schluchtwand nordöstlich des Postens.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: dein {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} startet auch Elementare Hilfe ({area:1717}), die Kette (33-40) zu The Tempest's Weapons: forever/class/shaman/call-of-air-horde.",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Flieg nach {area:460}",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "Karawane der Gizeltons",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, head on."] = "Folge der Straße nach Südwesten aus Sonnenfels hinaus nach {zone:1443} und weiter nach Süden an {area:608} vorbei. Die Kodokarawane von {npc:11625} wartet an der Straße nördlich von {area:609}; ist sie schon weg, geh weiter.",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "Die Karawane zieht nach Süden an {area:609} vorbei. Kolkar überfallen sie in Wellen: Töte sie, bevor sie {npc:11625} erreichen. Sie hält bei {area:2617}, östlich vom {area:597}.",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} steht im Posten; {npc:5641} und {npc:4498} warten auf der Anhöhe westlich davon, über dem Friedhof ({area:596}).",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Benutze {npc:11596}s {item:13892} an einem Gealterten, Sterbenden oder {npc:4702} auf dem Friedhof und führe den gezähmten Kodo zurück zu {npc:11596}. Fünf Kodos, einer nach dem anderen.",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Head north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Geh nach Nordosten zum {area:609}. {quest:1365} (35) geht auf der Ostseite zwischen den Zelten mit ein oder zwei Schlachtfürsten (32-33) umher: Räume um ihn herum auf und zieh ihn dann allein bei voller Gesundheit.",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "Nördlich entlang der östlichen Hügel halten die Satyrn die Ruinen von {area:603}. Die Schattenpirscher sind unsichtbar; die vier Arten, die du brauchst, nicht.",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Head west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Geh nach Westen zur {area:599}. Prügle einen Kultisten der Brennenden Klinge nieder und benutze dann {item:6436} an ihm, bevor er stirbt, um einen {item:6435} zu füllen. Sie lassen auch ab und zu {item:20310} fallen (1-5 %); fällt einer, lies ihn.",

	-- Step 17: Ghost Walker Post
	["Head back south to the post."] = "Geh zurück nach Süden zum Posten.",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "{npc:5641}s nächste Quest {quest:1431} schickt dich umsonst zurück nach {zone:1454}: Lass sie aus.",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "Kolkarohren",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "Zurück in {area:609} kann jeder Kolkar ein Ohr fallen lassen.",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "Skalp eines Schattenpirschers",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Die Schattenpirscher der Zornsäer in {area:603} sind unsichtbar, bis sie zuschlagen; etwa jeder dritte trägt einen Skalp.",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Head south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Geh nach Südwesten zum Trolldorf an der Küste und halte dich dabei vom {area:606} fern.",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}: für {npc:715} im Schlingendorntal",

	-- Step 22: Clam beds
	["Clam beds"] = "Muschelbänke",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Geh die Küste nach Norden hinauf. Riesen-Weichpanzermuscheln liegen im Flachwasser, und die Wütenden Riffkriecher laufen am Strand; öffne jede Muschel in deinen Taschen für ihr Fleisch.",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Orakel der Zackenkämme",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Weiter nach Norden zum {area:598}. Die Orakel stehen zwischen den anderen Naga an seinem Nordende; pull sie einzeln.",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} wartet im verfallenen Turm von {area:2405}, landeinwärts im Südosten.",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "Der Seher steht auf der Südseite der {area:599}, östlich von {area:2405}. Räum zuerst die Kultisten um ihn herum weg.",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "Sein nächster Auftrag ist nicht auf dieser Route.",

	-- Step 27: Ghost Walker Post
	["Head south-east to the post."] = "Geh nach Südosten zum Posten.",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}s nächster Auftrag schickt dich zu einem Dämonenfürsten mit Elitewache: Überspring ihn.",

	-- Step 28: Gelkis Village
	["Head south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Geh nach Südwesten Richtung Schattenbeute. Die Zentauren der Gelkis (32-35) rund um ihr Dorf sind ein gutes Lager; kämpfe gegen sie bis Stufe 32.",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "Stampfer und Windhetzer der Gelkis grinden: {area:606}, {zone:1443}",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Flieg von Shadowprey nach {area:1638}, trainiere bei {npc:3033} auf der Anhöhe ({area:1639}) und flieg dann weiter nach {zone:1454}.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Flugmeister: {area:2408}",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "Zeppelin nach {area:1497}",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Verlass {zone:1454} durch das Haupttor; der Zeppelinturm steht gleich nordöstlich davon. Nimm den Zeppelin nach {area:1497}.",
	["Zeppelin tower"] = "Zeppelinturm",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} bildet in {area:1497} Paladine aus.",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Erledige zuerst deine Einkäufe in {area:1497} und flieg dann zum {area:228}. {object:113791} steht auf dem Hügel gleich südwestlich davon: Besiege die Verderbte schwache Wassermanifestation daneben, leg ihre Armschienen in die Kohlenpfanne, sprich mit {npc:5895} und behalte {item:7813} für {npc:5901}. Flieg vom {area:228} weiter nach {area:272}.",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "für {npc:5901}: aus dem Schlingendorntal, nächster Guide",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} braucht einen {item:3388}, einen Gegenstand aus {skill:171}: Kauf einen hier im Auktionshaus, wenn du kannst (oder frag einen Alchemisten). Kein Trank: Überspring die Elixier-Schritte in {area:287}.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: Auktionshaus oder ein Alchemist, für {quest:515}.",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}, der Fledermausführer",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, für {npc:2333}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}: für {area:321} im Arathihochland, später auf der Route",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}: fürs {zone:1413}, später auf der Route",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "Naga der Säbelflossen",
	-- {area:271} Southshore
	["Head south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Geh nach Süden, östlich von {area:271}, hinunter zur Küste. Die Dolchrückennaga säumen das Ufer südöstlich der Stadt.",
	["Daggerspine shore"] = "Ufer der Säbelflossen",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs der Fetzenflossen",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Folge dem Ufer nach Westen an der Bucht von {area:271} vorbei; die Murlocs der Fetzenflossen lagern an den Stränden dahinter.",
	["Torn Fin beach"] = "Strand der Fetzenflossen",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Head back north to {area:272}, keeping west of {area:271}."] = "Geh zurück nach Norden zu {area:272} und halte dich westlich von {area:271}.",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "Fässchen Shindigger-Starkbier",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Das Fässchen steht mit einigen anderen im Lager des Syndikats an der Südostküste von {area:287}.",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Zurück nach {area:272}",
	["Hearth back (or head north if it is on cooldown)."] = "Kehr per Ruhestein zurück (oder geh nach Norden, wenn er auf Abklingzeit ist).",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "Stell das {object:1729} auf den {object:1728} neben dem Gasthaus",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Folge der Straße nach Norden aus {area:272} hinaus in die Ausläufer des Alteracgebirges. {quest:535} wartet beim Lager des Syndikats; gib ihm das Starkbier.",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "Schreiben des Syndikats",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Die Schleicher und Diebe des Syndikats (32-33) um die Lager westlich der Straße tragen die Schreiben; etwa jeder dritte lässt eins fallen.",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "Im Südwesten füllen Höhlenyetis und Wilde Yetis (30-31) die Höhlen in den Hügeln westlich von {area:272}; etwa jeder sechzehnte trägt die Rute.",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Die Verräter von {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Geh am Fuß der Berge entlang nach Westen zur violetten Kuppel von {area:279}. {npc:2411}, {npc:2412} und {npc:2413} (33-34) stehen zusammen innerhalb des östlichen Kraterrands, {npc:2414} (35) etwas westlich von ihnen; jeder trägt ein Blutsteinstück. Die Schildwachen und Theurgiker (31-32) um sie herum lassen die Abgenutzten Steinmarken fallen.",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "Geh zurück nach Osten zu {area:272}.",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "Thaivands nächste Aufgabe endet auf dem Friedhof von {area:271}, und der Magus bietet einen Dungeonauftrag an: Lass beide aus.",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Geh nach Norden am Lager von {quest:535} vorbei zu {area:280}, dem vom Syndikat gehaltenen Dorf (35-37). {npc:2431} trägt {item:3704}; {quest:503} sitzt in einem Käfig im Haus auf der Nordseite.",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back south to {area:272}."] = "Geh zurück nach Süden zu {area:272}.",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- {area:1497} Undercity · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "Der nächste Guide beginnt in {area:1497}, am Zeppelin nach {object:3202}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Flieg nach {area:392}. {npc:5901} lagert an der Küste, ein kurzer Ritt südlich der Stadt.",
	-- ["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Folge der Straße nach Südwesten aus Sonnenfels hinaus nach {zone:1443} und weiter nach Süden an der Nijelspitze ({area:608}) vorbei. Die Kodokarawane von {npc:11625} wartet an der Straße nördlich von {area:609}; ist sie schon abgefahren, reite weiter.",
	-- ["Hearth back (or ride north if it is on cooldown)."] = "Nimm den Ruhestein zurück (oder reite nach Norden, wenn er Abklingzeit hat).",
	-- ["Ride back east to {area:272}."] = "Reite zurück nach Osten nach {area:272}.",
	-- ["Ride back north to {area:272}, keeping west of {area:271}."] = "Reite zurück nach Norden nach {area:272} und halte dich westlich von {area:271}.",
	-- ["Ride back south to the post."] = "Reite zurück nach Süden zum Posten.",
	-- ["Ride back south to {area:272}."] = "Reite zurück nach Süden nach {area:272}.",
	-- ["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Reite nach Norden am Lager von {quest:535} vorbei nach {area:280}, dem vom Syndikat besetzten Dorf (35-37). {npc:2431} trägt den {item:3704}; {quest:503} sitzt in einem Käfig im Haus auf der Nordseite.",
	-- ["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Reite die Küste hinauf nach Norden. Riesenweichpanzermuscheln liegen im seichten Wasser und Wütende Riffkriecher laufen am Strand; öffne jede Muschel in deinen Taschen für ihr Fleisch.",
	-- ["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Reite nach Nordosten nach {area:609}. {quest:1365} (35) läuft mit ein oder zwei Kampflords der Kolkar (32-33) zwischen den Zelten auf der Ostseite: Räum um ihn herum auf und pull ihn dann allein mit voller Gesundheit.",
	-- ["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Reite nach Süden, östlich an {area:271} vorbei, hinunter zur Küste. Die Naga der Säbelflossen säumen das Ufer südöstlich des Orts.",
	-- ["Ride south-east to the post."] = "Reite nach Südosten zum Posten.",
	-- ["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Reite nach Südwesten zum Trolldorf an der Küste und halte dich unterwegs von {area:606} fern.",
	-- ["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Reite nach Südwesten Richtung Shadowprey. Die Zentauren der Gelkis (32-35) um ihr Dorf sind ein guter Platz; kämpfe dort bis Stufe 32.",
	-- ["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Reite nach Westen zur {area:599}. Prügle einen Kultisten der Burning Blade runter und benutze dann {item:6436} an ihm, bevor er stirbt, um einen {item:6435} zu füllen. Sie lassen ab und zu auch {item:20310} fallen (1-5%); falls eine fällt, lies sie.",
}
