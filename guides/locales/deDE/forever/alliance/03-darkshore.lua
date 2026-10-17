-- German (deDE): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Das Boot legt westlich des Dorfes an. Der Flugmeister steht auf dem Hügel südlich des Gasthauses; die Questgeber sind entlang der Hauptstraße verteilt.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666}, beim Gasthaus",
	["The WANTED poster outside the inn"] = "Der Steckbrief vor dem Gasthaus",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, auf dem Steg",
	-- {npc:10216} Gubber Blump · {skill:356} Fishing
	["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}, auf dem Steg: nur mit {skill:356}",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, am Nordende des Dorfes",

	-- Step 2: The beach
	["The beach"] = "Der Strand",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Gezeitenkriecher krabbeln unterhalb des Dorfes am Ufer entlang; {quest:983} steht am Strand gleich südlich der Anlegestelle. Dunkelküstendrescher schwimmen im seichten Wasser. {object:175207} liegt gleich südlich des Dorfes am Ufer.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "Kriecherbeine",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes"] = "Drescheraugen",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}: vom Steg aus angeln",

	-- Step 4: The skeletal turtle
	["The skeletal turtle"] = "Die Skelettschildkröte",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks"] = "{item:12289}, am Strand westlich der Anlegestelle",

	-- Step 5: Plagued bears
	["Plagued bears"] = "Verseuchte Bären",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "Tollwütige Distelbären streifen durch die Hügel gleich östlich von {area:442}. Benutze {quest:2139} an einem und führe ihn zu ihm zurück.",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Bären und das Lager der Schwarzfelle",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "Töte Tollwütige Distelbären in den Hügeln östlich von {area:442} und geh dann hinauf zum Furbolglager südöstlich davon: Dort gibt es noch nichts zu töten.",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} steht am Nordrand der Ruinen. Verfluchte und Zuckende Hochgeborene sowie {npc:2178} spuken dort; der Geist von {npc:3667} wandelt zwischen ihnen, die Eule {npc:270196} kreist östlich davon. Die beiden Schrifttafeln liegen in den Ruinen; eine {quest:4722} liegt westlich davon am Ufer.",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Lies {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Lies {object:17189}",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Hochgeborenenrelikte",

	-- Step 8: The red crystal
	["The red crystal"] = "Der rote Kristall",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Klettere östlich von {area:447} in die östlichen Berge; der {object:175524} liegt auf einem Felsvorsprung.",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Nach Norden durch die Hügel. {npc:3650} wartet in den Ruinen von {quest:954}; Wilde Grells und Üble Grimmlinge füllen sie, Satyrn der Deth'ryll den Ostrand. {quest:1001} steht an der Straße westlich der Ruinen; eine {quest:4723} liegt auf dem Weg zu ihm am Ufer.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Grell-Ohrringe",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: Satyrn der Deth'ryll",

	-- Step 10: The Tower of Althalaxx
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "Mondpirscher streifen durch die Hügel zwischen {quest:954} und dem Turm. {quest:1002} steht auf dem Hügel westlich des Turms.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Mondpirscher-Fangzähne",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "Ruhestein nach {area:442}",
	["Fill the tube at the moonwell in the village"] = "Fülle die Phiole am Mondbrunnen im Dorf",

	-- Step 12: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "Flieg von {area:442} nach {area:702} und nimm das Portal hinauf zu {npc:4217} im Gebiet {area:1658}.",

	-- Step 13: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}. Schrein-Schmuckstücke liegen in den Behältern am Grund von {area:656}, unterhalb von {area:2361}: Bring eines zum {area:2362} im Nordwesten, benutze es dort und sprich mit {npc:11799}. Flieg dann von {area:2361} zurück nach {area:442}.",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}: Fülle das Probenfläschchen an den {area:445}",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, aus einem {object:177785} im See",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Am {area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "Die Anhängerhälften liegen in {zone:1439} und {zone:1436}: später auf der Route",

	-- Step 14: Blackwood furbolgs
	["Blackwood furbolgs"] = "Furbolgs der Schwarzfelle",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Pfadfinder und Windsprecher der Schwarzfelle halten das Lager südöstlich von {area:442}.",

	-- Step 15: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "Die {object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "Die Flamme brennt im Süden von {area:447}.",

	-- Step 16: The southern beaches
	["The southern beaches"] = "Die südlichen Strände",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Folge der Küste nach Süden an {area:447} vorbei: Eine {quest:4728} liegt am Ufer westlich des Hains, eine weitere weiter südlich nahe {area:450}. Drei weitere Überreste liegen weiter südwestlich zwischen Orakeln und Gezeitenjägern der Grauflossen (18-20): Der Guide hebt sie für die letzte Runde auf, wenn du näher an ihrer Stufe bist.",

	-- Step 17: The Grove of the Ancients
	-- {area:448} Grove of the Ancients
	["The {area:448}"] = "Zum Ort {area:448}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Ergraute Distelbären streifen durch die Hügel rund um den Hain; {quest:1003} steht westlich davon zwischen ihnen.",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "Ergraute Skalpe",

	-- Step 18: The red crystal
	["Back north-east into the mountains to the crystal."] = "Zurück nach Nordosten in die Berge zum Kristall.",

	-- Step 19: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Two more beached remains lie on the north shore: near the {area:443} and north of {quest:954}."] = "Folge den Hügeln nach Norden zum Fluss {area:456} und hinauf zu den Fällen. Zwei weitere gestrandete Überreste liegen an der Nordküste: nahe dem Gebiet {area:443} und nördlich von {quest:954}.",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, am Wasserfall",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}: am Eingang der Höhle bei den Fällen",

	-- Step 21: Auberdine
	["The WANTED poster"] = "Der Steckbrief",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "",

	-- Step 22: The bay wrecks
	["The bay wrecks"] = "Die Wracks in der Bucht",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "Zwei Wracks liegen auf dem Meeresgrund in der Bucht nördlich von {area:442}; in jedem steckt eine Schließkassette. Riffkriecher und Verkrustete Gezeitenkriecher säumen dieses Ufer.",

	-- Step 23: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "Zum Gebiet {area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} versteckt sich auf der kleinen Insel vor den Ruinen. Die Schlüsselteile droppen Riesige Waldschreiter (oben), Murlocs der Grauflossen (Mitte) und Tobende Riffkriecher (unten).",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: die {object:177792} unter Wasser vor der Nordküste, westlich der Ruinen",

	-- Step 24: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661} versteckt sich am Fuß des Turms zwischen den Fanatikerinnen des dunklen Strangs. Behalte seinen Brief für Delgren in {zone:1440}.",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}: Fanatikerinnen des dunklen Strangs",

	-- Step 25: The northern Blackwood camp
	["The northern Blackwood camp"] = "",
	-- {area:456} Cliffspring River · {item:12347} Filled Cleansing Bowl · {item:12355} Talisman of Corruption
	["The furbolg camp south of the {area:456} keeps its Nut, Fruit and Grain Stores by the bonfires. With a sample of each and the {item:12347} in your bags, use the bowl by the bonfire closest to the river: it summons Xabraxxis, the satyr corruptor, and the {item:12355} lies in his Demon Bag."] = "",
	["By the bonfire closest to the river: summons Xabraxxis"] = "",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}, in {object:177624}",

	-- Step 26: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "Die Höhle und die {npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls."] = "Die Höhle liegt südlich der Fälle: Überall darin wachsen Schorfstängel, {item:5270} ganz hinten. {npc:6788} haust in den Hügeln südlich der Fälle.",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks"] = "Schorfstänglinge",

	-- Step 28: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} und {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Die Lunarfungusblüten wachsen in den Moonkinhöhlen in den Hügeln gleich östlich von {area:442}; die Moonkin dort sind reizbar. {item:2449} erfordert {skill:182}: Kräuterkundige pflücken es überall in {zone:1439}, alle anderen bringen es aus {zone:1453} ({npc:1313}) oder aus dem Auktionshaus mit.",

	-- Step 29: The Grove of the Ancients
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Folge der Straße nach Süden. {quest:948} ist der Uralte am Hain; {npc:270269} und {npc:11218} schlafen neben ihm.",
	-- {npc:11218} Kerlonian Evershade · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}: Seine Eskorte nach {area:413} erledigst du auf dem Abschnitt in {zone:1440}",

	-- Step 30: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Mondpirscherpatriarchen streifen durch die Wälder rund um die Gleve. Die {object:10076} und der {object:12666} stehen am Grund des Kraters; {npc:3584} steht an seiner Nordseite.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "Feine Mondpirscherpelze",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "Die {object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "Der {object:12666}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: Twilight-Jünger und -Rohlinge",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Nur falls ein Jünger oder Rohling {item:5352} gedroppt hat: Rechtsklicke darauf",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Eskortiere sie aus der Gleve; Therysil nimmt die Abgabe in {zone:1440} entgegen",

	-- Step 31: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "Der Strand von {npc:10323}",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches west and south-west of {area:450}."] = "{npc:10323} lagert am Strand westlich der Gleve: Töte die Murlocs am Lagerfeuer; er kommt in der dritten Welle mit seinem Hund. Drei gestrandete Überreste liegen an den Stränden westlich und südwestlich von {area:450}.",

	-- Step 32: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450} liegt an der Küste südlich des Strands von {npc:10323}. Beschütze den Ausgrabungsleiter, während er nach dem Fossil sucht.",

	-- Step 34: Auberdine
	["Follow the road north."] = "Folge der Straße nach Norden.",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}: {npc:10219} bietet sie an, sobald alle neun gestrandeten Überreste abgegeben sind",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "Sie gibt dir die {item:15826}",

	-- Step 35: The naga
	["The naga"] = "Die Naga",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "Folge der Küste nach Nordosten zum Gebiet {area:443}. {quest:951} liegen in den Ruinen; Myrmidonen, Zauberhexerinnen und Krieger der Sturmschuppen halten sie, und Tierbändigerinnen der Sturmschuppen laufen am Ufer entlang.",

	-- Step 36: Back south
	["Back south"] = "Zurück nach Süden",
	["Hearthstone on cooldown? Follow the coast road back south."] = "Ruhestein noch nicht bereit? Folge der Küstenstraße zurück nach Süden.",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}, am Hain",

	-- Step 37: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692} versteckt sich in den Hügeln östlich vom Ort {area:449}. Hilf ihm zurück zur Straße; er kämpft sich hinaus.",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: Benutze die {item:15826} an ihnen; sie streifen durch ganz {zone:1439}",

	-- Step 38: Auberdine
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}: für {npc:3691} in {area:415}, später auf dem Abschnitt in {zone:1440}",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}: für {npc:1646} in {zone:1453}",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "Boot nach {zone:1453}",

	-- Step 39: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Nachtelfen fliegen von {area:442} nach {area:702}; Himmelsgeborene nehmen das Boot von der Anlegestelle in {area:442} und holen sich dort die Flugroute von Rut'theran. Nimm das Portal hinauf zu {npc:4217} im Gebiet {area:1658}.",

	-- Step 40: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}; hol dir dort die Flugroute, falls du sie noch nicht hast.",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}: der Willkommensgruß von Sheldras",

	-- Step 41: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Die Relikte der Grabhügel",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Nachtelfen) und der {npc:272054} (Himmelsgeborene) warten im Süden von {area:493}. Die drei Relikte liegen östlich davon in {area:2363}. Berichten aus den ersten Wochen zufolge gibt ein Relikt keine Beute, während ein anderer Spieler es plündert: Warte einen Moment und versuch es erneut.",

	-- Step 42: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Zurück zu {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village · {area:442} Auberdine
	["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "Zurück zu {npc:11802} in {area:2361}, dann flieg nach {area:702} (über {area:442}).",

	-- Step 43: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1453} Stormwind
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "Nimm das Portal hinauf zu {npc:4217} und flieg dann zurück nach {area:442} zum Boot nach {zone:1453}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "Folge der Küste nach Nordosten zum Gebiet {area:443}. {quest:951} liegen in den Ruinen; Myrmidonen, Zauberhexerinnen und Krieger der Sturmschuppen halten sie.",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "Folge der Küste nach Süden an {area:447} vorbei: Eine {quest:4728} liegt am Ufer westlich des Hains, eine weitere weiter südlich nahe {area:450}.",
	-- ["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "Folge den Hügeln nach Norden zum Fluss {area:456} und hinauf zu den Fällen. Drei weitere gestrandete Überreste liegen an der Nordküste: nahe dem Gebiet {area:443}, nördlich von {quest:954} und westlich von {quest:954}.",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "Nach Norden durch die Hügel. {npc:3650} wartet in den Ruinen von {quest:954}; Wilde Grells und Üble Grimmlinge füllen sie, Satyrn der Deth'ryll den Ostrand. {quest:1001} steht an der Straße westlich der Ruinen.",
	-- ["Read both tablets"] = "Lies beide Schrifttafeln",
	-- ["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "Die Höhle liegt südlich der Fälle: Überall darin wachsen Schorfstängel, {item:5270} ganz hinten. {npc:6788} haust in den Hügeln südlich der Fälle; {object:177624} liegt im Satyrlager nördlich von ihr.",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "Gezeitenkriecher krabbeln unterhalb des Dorfes am Ufer entlang; {quest:983} steht am Strand gleich südlich der Anlegestelle. Drescher der Dunkelküste schwimmen im seichten Wasser. {quest:4723} liegt gleich südlich des Dorfes am Ufer.",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883}: die {object:177790} unter Wasser vor der Nordküste, westlich der Ruinen",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323} lagert am Strand westlich der Gleve: Töte die Murlocs am Lagerfeuer; er kommt in der dritten Welle mit seinem Hund. Drei gestrandete Überreste liegen an den Stränden südlich von {area:450}.",
	-- ["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} versteckt sich auf der kleinen Insel vor den Ruinen; Tierbändigerinnen der Sturmschuppen laufen am Ufer entlang. Die Schlüsselteile droppen Riesige Waldschreiter (oben), Murlocs der Grauflossen (Mitte) und Tobende Riffkriecher (unten).",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003} steht westlich des Hains.",
}
