-- German (deDE): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1448} Felwood · {area:2255} Everlook · {zone:1457} Darnassus · {zone:1444} Feralas
	["{zone:1448} and a stop in {area:2255}, then {zone:1457} and {zone:1444}."] = "{zone:1448} und ein Halt in {area:2255}, dann {zone:1457} und {zone:1444}.",

	-- Step 1: Felwood
	-- {area:3137} Talrendis Point · {area:2358} Forest Song · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride west along the road past {area:2358}, then north-west into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "Fahre von {area:3137} nach Westen entlang der Straße vorbei an {area:2358}, dann nordwestlich in {zone:1448}: das {area:2479} ist das Druidentorps am Straßenrand direkt vor der {zone:1440}-Grenze.",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["The {area:2479} is the druids' camp by the road in southern {zone:1448}."] = "Das {area:2479} ist das Druidentorps am Straßenrand im Süden von {zone:1448}.",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}, in den Ruinen gleich östlich von {npc:11554}",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, drinnen",
	-- {npc:10920} Kelek Skykeeper · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}: {quest:86577}, from the bears and wolves you meet in {zone:1448}"] = "{npc:10920}: {quest:86577}, von den Bären und Wölfen, die dir in {zone:1448} begegnen",

	-- Step 3: Grazle
	-- {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["{npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "{npc:11554} der Furbolg steht an der Straße, gleich südlich vom {area:2479}.",

	-- Step 4: Deadwood Village
	-- {npc:11554} Grazle · {npc:15395} Nafien
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop: {npc:11554} and {npc:15395} each take five."] = "Die Deadwood-Fuchskolben leben im Dorf direkt südwestlich von {npc:11554}; halte die Deadwood-Krone-Federn, die sie fallen lassen: {npc:11554} und {npc:15395} nehmen je fünf.",

	-- Step 5: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} wartet am Nordende des {zone:1448}",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras · {spell:7992} Slowing Poison
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker · Cursed Oozes = {npc:7086} Cursed Ooze
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back.\nCareful: Jadefire Shadowstalkers (level 51-52) use Sneak and {spell:7992} and are stealthed, so they often join fights uninvited.\nCursed Oozes slide about the glen's streams: kill them and use Laris's Empty Ooze Jar on their remains."] = "Die Satyrn von Jadefire halten das Tal westlich der Straße, mit {npc:9454} an dessen Ende.\nVorsicht: Jadefire Shadowstalkers (Stufe 51-52) nutzen Sneak und {spell:7992} und sind getarnt, sodass sie oft ungebeten in Kämpfe geraten.\nCursed Oozes gleiten durch die Bäche des Tals: Töte sie und benutze Laris's Empty Ooze Jar an ihren Überresten.",

	-- Step 7: Ruins of Constellas
	-- {npc:9454} Xavathras · {area:2481} Ruins of Constellas
	["Careful: {npc:9454} (54) stands at the back of the {area:2481}, at about 32.2,67.1, with Shadowstalkers around him: clear them one at a time, then pull him alone at full health."] = "Vorsicht: {npc:9454} (54) steht hinten in den {area:2481}, bei etwa 32.2,67.1, mit Schattenpirschern um sich: Räum sie einzeln weg und zieh ihn dann allein mit voller Gesundheit.",

	-- Step 8: Jaedenar
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge · {item:11948} Empty Tainted Ooze Jar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{area:1763} is the ruined temple north of the glen.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: work the south-east, where the arrow points, and pull the cultists and hounds away from him.\nTainted Oozes slide about {area:1763}'s fel pools: kill them and use the {item:11948} on their remains."] = "{area:1763} ist der zerstörte Tempel nördlich der Schlucht.\nVorsicht: Der {npc:11141} (53, Elite) spukt am Westende von {area:1763}, etwa 35,60: arbeite im Südosten, wo der Pfeil zeigt, und zieh die Kultisten und Hunde von ihm weg.\nBesudelte Brühschlammer gleiten durch die Teufelsseen von {area:1763}: Töte sie und benutze den {item:11948} auf ihre Überreste.",
	-- {item:11949} Filled Tainted Ooze Jar · {area:1763} Jaedenar
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{item:11949}: Tainted Oozes slide about {area:1763}'s fel pools"] = "{item:11949}: Tainted Oozes gleiten durch die Teufelsteiche von {area:1763}",

	-- Step 9: Putrescent organs: kill these as you meet them
	["Putrescent organs: kill these as you meet them"] = "Faulige Organe: Töte diese, sobald sie dir begegnen",
	-- {zone:1448} Felwood · {npc:10920} Kelek Skykeeper · {area:1763} Jaedenar
	["{zone:1448}'s Angerclaw bears and Felpaw wolves carry the putrescent organs {npc:10920} wants: the Bears and Wolves (47-48) of the south and the Maulers and Scavengers (49-50) along the road north of {area:1763}. Kill them as you ride between the stops."] = "Die Zornklauenbären und Teufelspfotenwölfe von {zone:1448} tragen die fauligen Organe, die {npc:10920} will: die Bären und Wölfe (47-48) im Süden und die Zerfleischer und Aasfresser (49-50) an der Straße nördlich von {area:1763}. Töte sie, während du zwischen den Stationen reitest.",

	-- Step 11: Shatter Scar Vale
	-- {npc:7136} Infernal Sentry
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them.\nCareful: an {npc:7136} (53, elite) stands among the craters: walk round it."] = "Folge der Straße nach Norden ins Kratertal und geh zu jedem Krater; töte dabei die Entropischen Bestien und Schrecken dazwischen.\nVorsicht: Ein {npc:7136} (53, Elite) steht zwischen den Kratern: Geh um ihn herum.",
	["First crater"] = "Erster Krater",
	["Second crater"] = "Zweiter Krater",
	["Third crater"] = "Dritter Krater",

	-- Step 12: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "Die Wucherborkentreants im {area:1767}, östlich der {area:2618}, tragen die {item:11503}.",
	["Below ground"] = "Unter der Erde",

	-- Step 13: Jadefire Run: kill these as you meet them
	-- {area:2618} Jadefire Run
	["{area:2618}: kill these as you meet them"] = "{area:2618}: Töte sie, wenn du ihnen begegnest",
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}.\nCareful: {npc:10648} (55) stands at the valley's far end with Hellcallers (53-54) around him: clear them one at a time before you pull him."] = "{area:2618} ist das Satyrtal im Nordwesten, mit {npc:10648} an seinem hinteren Ende. Er lässt {quest:939} fallen; jeder Jadefeuersatyr kann {item:11674} fallen lassen.\nVorsicht: {npc:10648} (55) steht am hinteren Ende des Tals mit Höllenrufern (53-54) um sich: Räum sie einzeln weg, bevor du ihn ziehst.",

	-- Step 14: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "Wieder {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}."] = "Benutze {item:12922} am verderbten Mondbrunnen mitten in {area:1763}.",

	-- Step 15: The Emerald Sanctuary
	-- {area:1763} Jaedenar · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Ride south-east from {area:1763} to the {area:2479}, the druids' camp by the road in southern {zone:1448}."] = "Reite von {area:1763} nach Südosten zum {area:2479}, dem Lager der Druiden an der Straße im Süden von {zone:1448}.",

	-- Step 16: The Emerald Sanctuary
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}, later in this guide: keep it; inside"] = "Das Elektroskop wird in {zone:1457} gefüllt, später in diesem Guide: behalte es; innerhalb",
	-- {area:392} Ratchet
	["Ends in {area:392}, on the next guide: keep it"] = "Endet in {area:392}, im nächsten Guide: behalte es",

	-- Step 17: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Ride north up the road from the Sanctuary, all the way to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Reite vom Heiligtum die Straße nach Norden hinauf, ganz bis zum Höhleneingang der {area:1769}; {npc:15395} bewacht ihn.",

	-- Step 18: Felpaw Village
	-- {area:1762} Felpaw Village
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Die Deadwood-Furbolgs von {area:1762} füllen die Hügel westlich der Höhle.\nVorsicht: Den Watchers sind Stufe 53-54 und die Avengers 54-55; sie rufen Verbündete in 25 Yard herbei, sobald sie unter 50% Gesundheit sind, und laufen unter 15% los, Hilfe zu holen.",

	-- Step 19: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only if the Timbermaw are already Neutral to you: the Deadwood furbolgs drop a {quest:8470} about one kill in thirty, and {npc:11558} just inside {area:1769} takes it. Below Neutral the quest is refused: it needs Neutral with the Timbermaw; the reputation guide gets you there."] = "Nur falls die Timbermaw dir schon Neutral sind: die Deadwood-Fuchskolben fallen ein {quest:8470} über eines von dreißig Tötungen, und {npc:11558} direkt bei {area:1769} erfüllt es. Unter Neutral wird die Quest abgelehnt: sie benötigt Neutral zu den Timbermaw; der Ruf-Guide bringt dich dahin.",

	-- Step 20: Nafien
	-- {npc:11556} Salfa · {zone:1452} Winterspring
	["{npc:11556} stands at the {zone:1452} end of the tunnel"] = "{npc:11556} steht am {zone:1452}-Ende des Tunnel",

	-- Step 22: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She needs Neutral with the Timbermaw; the reputation guide gets you there."] = "Trete in die Höhle: {npc:11558} steht direkt drin. Sie benötigt Neutral zu den Timbermaw; der Ruf-Guide bringt dich dahin.",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: läuft hier umher: Schau in den Kreis auf der Karte",

	-- Step 23: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Nach {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Walk through {area:1769}'s tunnel to its {zone:1452} end."] = "Geh durch den Tunnel von {area:1769} bis zum {zone:1452}-Ende.",

	-- Step 24: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} steht direkt am Ausgang des Tunnels von {area:1769} nach {zone:1452}, wo du herauskommst.",

	-- Step 25: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride south to {npc:9298}'s camp beside the hot springs."] = "Fahre südlich zu {npc:9298}'s Lager am heißen Quell.",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["Keep it: {npc:7775} in {zone:1444}, later in this guide, brews the elixir"] = "Behalte es: {npc:7775} in {zone:1444}, später in diesem Guide, braut das Elixier",

	-- Step 26: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Reite auf der Straße nach Osten nach {area:2255}.",
	-- {zone:1452} Winterspring
	["The Chillwind horns come on the next guide's {zone:1452} loop: keep it"] = "Die Chillwind-Hörner kommen auf dem {zone:1452}-Loop des nächsten Guides: behalte es",

	-- Step 27: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Flieg nach {area:702}",
	-- {npc:11138} Maethrya
	["{npc:11138}, the Alliance flight master"] = "{npc:11138}, der Allianz-Flugmeister",

	-- Step 28: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {quest:3661} Favored of Elune? · {zone:1425} Hinterlands
	["{npc:7916}: {quest:3661}, the feathers from the {zone:1425}"] = "{npc:7916}: {quest:3661}, die Federn von {zone:1425}",

	-- Step 29: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {zone:1452} Winterspring
	["{npc:7916}: the wildkin feathers lie along {zone:1452}'s road, on the next guide; {npc:7916} takes them on the Plaguelands guide's way through: keep it"] = "{npc:7916}: die Wildkin-Federn liegen entlang von {zone:1452}'s Straße, im nächsten Guide; {npc:7916} nimmt sie auf dem Weg des Plaguelands-Guides durch: behalte es",

	-- Step 30: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} steht oben, über {npc:7916}: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 33: The Temple Gardens
	-- {item:11682} Eridan's Vial
	["Fill {item:11682} at the moonwell inside the Temple of the Moon."] = "Fülle {item:11682} am Mondbrunnen im Tempel der Sonne.",

	-- Step 34: Astarii Starseeker
	-- {npc:4090} Astarii Starseeker · {quest:3378} Prayer to Elune · {zone:1427} Searing Gorge
	["{npc:4090}, in the Temple of the Moon: {quest:3378}, from the {zone:1427}"] = "{npc:4090}, im Tempel der Sonne: {quest:3378}, von {zone:1427}",

	-- Step 35: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon."] = "{npc:7740} steht neben Tyrande im Tempel der Sonne.",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}: {quest:162}, aus {area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1452} Winterspring
	["For {npc:5594} in {area:976}, on the {zone:1446} and {zone:1452} guide: keep it"] = "Für {npc:5594} in {area:976}, auf dem {zone:1446}- und {zone:1452}-Guide: behalte es",

	-- Step 36: Jenal
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047} waits in the {area:1658}, west of the druids' building."] = "{npc:9047} wartet im {area:1658}, westlich des Druidentorps.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil
	["{npc:9047}, in the {area:1658}: {quest:3764}"] = "{npc:9047}, im {area:1658}: {quest:3764}",

	-- Step 38: Arch Druid Fandral Staghelm
	-- {npc:4217} Mathrengyl Bearwalker
	["Fandral stands at the top of the druids' building; {npc:4217}, next, is lower down inside it."] = "Fandral steht auf dem Dach des Druidentorps; {npc:4217}, darunter, ist weiter unten im Inneren.",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, upstairs"] = "{npc:3516}, oben",

	-- Step 40: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}, oben",
	-- {npc:4217} Mathrengyl Bearwalker · {item:11040} Morrowgrain
	["{npc:4217}'s next task grows ten {item:11040} from a pouch over several hours: skip it."] = "Der nächste Auftrag von {npc:4217} wächst aus einer Tasche über mehrere Stunden zehn {item:11040}: überspringe es.",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455} hat keinen Druidenlehrer",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal nach {zone:1438}",

	-- Step 42: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Flugmeister von {area:702}",

	-- Step 43: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Flieg von {area:702} zur {area:1116}.",

	-- Step 45: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Boot nach {area:1108}",

	-- Step 46: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Take the boat to the mainland: {npc:14637} waits on the dock where it lands."] = "Nimm das Boot zur Festland: {npc:14637} wartet am Dock, wo es anhält.",

	-- Step 47: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: Töte diese, sobald sie dir begegnen",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-47) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (47) do. The Wave and Deep Striders (47) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "Die Meeresschauer (46-47) spülen entlang des Ufers direkt südlich des Stegs: sie lassen die Wasserelementar-Kerne genauso fallen wie die Meereselementare (47). Die Wave- und Deep-Strider (47) waten im Wasser vor demselben Strand: schockiere sie zuerst mit {item:18904}, und geschrumpft verlieren sie ihre Elite-Stärke.\nDer Ultra-Shrinker hält zwei Stunden: gib beide Quests bei {npc:14637} ab, bevor du die Küste verlässt.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, von den Meeresschauern",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, auf die Wellen- und Tiefenschreiter im Wasser",

	-- Step 48: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637} on the dock."] = "Zurück zu {npc:14637} am Steg.",

	-- Step 49: Gregan Brewspewer
	-- {area:1119} Twin Colossals · {npc:7775} Gregan Brewspewer · {item:11243} Videre Elixir · {item:11242} Evoroot
	["Ride north-east from the dock past the {area:1119} to {npc:7775}'s camp. He brews the {item:11243} from an {item:11242}: take his errand for one."] = "Fahre nordöstlich vom Dock vorbei an {area:1119} zu {npc:7775}'s Lager. Er braut das {item:11243} aus einem {item:11242}: übernehmen Sie seinen Auftrag für einen.",

	-- Step 50: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "Der Riese {npc:7765} sitzt gleich nordwestlich vom Lager von {npc:7775}.",

	-- Step 51: Evoroot
	-- {item:11242} Evoroot · {npc:7765} Rockbiter · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "Die {item:11242} wächst in einem verfallenen Gebäude nördlich von {npc:7765}: Klettere von dem Felsvorsprung daneben durch das Loch in der Wand.\nOder durch die Vordertür: {npc:9467} bewacht sie, und der Köder, den Gregan verkauft, lockt ihn weg, wenn du ihn neben ihm benutzt. Die Hälfte der Spieler in unseren Aufzeichnungen ging so, die andere Hälfte durch die Wand.",

	-- Step 52: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride west into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Reite nach Westen in die Ruinen von Rabenwind: {npc:7774} versteckt sich im kleinen runden Gebäude ganz hinten. Öffne die Truhe neben ihr für {item:9189}: Es hält 15 Minuten, genau wie die Quest.",

	-- Step 53: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Führ {npc:7774} im Schritttempo zurück zu {npc:7765}: Sie läuft immer wieder davon, also läute die Glocke, um sie zurückzurufen (nicht im Kampf), und räume die Harpyien auf dem Weg, bevor sie sie erreicht.",

	-- Step 54: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {npc:7765} Rockbiter · {item:11242} Evoroot · {npc:9298} Donova Snowden · {area:976} Gadgetzan
	-- plural, as words: Videre Elixirs = {item:11243} Videre Elixir
	["Back to {npc:7775}'s camp, just south-east of {npc:7765}: the {item:11242} buys three Videre Elixirs. Keep them: {npc:9298} takes one at the start of the next guide, and Gaeriyan in {area:976} shows himself only to someone who has drunk one."] = "Zurück zu {npc:7775}'s Lager, direkt südlich von {npc:7765}: das {item:11242} kauft drei Videre-Elixiere. Behalten Sie sie: {npc:9298} nimmt eins am Anfang des nächsten Guides, und Gaeriyan in {area:976} zeigt sich nur einem, der eins getrunken hat.",

	-- Step 55: Feralas
	-- {area:489} Thalanaar · {zone:1441} Thousand Needles
	["Ride east along the road to {area:489}, on the {zone:1441} border: the next guide flies from there."] = "Fahre östlich entlang der Straße zu {area:489}, am {zone:1441}-Rand: vom dort fliegt der nächste Guide.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ends in the {zone:1413}: keep it"] = "Endet im {zone:1413}: Behalte es",
	-- ["Five feathers buy a little Timbermaw reputation"] = "Fünf Federn bringen ein wenig Ruf bei der Holzschlundfeste",
	-- ["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Flieg von {area:1998} zum Ende der Straße beim Refugium oder reite sie nach Süden entlang.",
	-- ["Fly to {area:415}"] = "Flieg nach {area:415}",
	-- ["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Folge der Straße nach Norden ins Kratertal und geh zu jedem Krater; töte dabei die Entropischen Bestien und Schrecken dazwischen.",
	-- ["If you skipped The Horn of the Beast or The {item:9328}, grind here to level 52.58 to stay on the route's plan."] = "Wenn du The Horn of the Beast oder The {item:9328} übersprungen hast, grinde hier bis Stufe 52,58, um im Plan der Route zu bleiben.",
	-- ["Keep her alive until she is out of the cave"] = "Halte sie am Leben, bis sie aus der Höhle ist",
	-- ["Level 52.58"] = "Stufe 52,58",
	-- ["Level 52.69"] = "Stufe 52,69",
	-- ["Level 52.9"] = "Stufe 52,9",
	-- ["Oozes"] = "Schlammbestien",
	-- ["Ride east to the night elf camp at {area:1998}."] = "Reite nach Osten zum Nachtelfenlager in {area:1998}.",
	-- ["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Reite von {area:415} nach Norden hinaus nach {zone:1448} zum {area:2479}, dem Lager der Druiden an der Straße.",
	-- ["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Reite nach Norden aus {area:415} hinaus in den {zone:1448}. {npc:11554}, der Furbolg, steht an der Straße gleich südlich des {area:2479}.",
	-- ["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Reite nach Norden zur {area:1769} (oder flieg erst zurück nach {area:1998}) und durch den Tunnel nach {zone:1452}; folge der Straße nach Osten zur Goblinstadt {area:2255}.",
	-- ["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Salfa steht am Ende des Tunnels in {zone:1452}: Behalte es",
	-- ["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Betritt die Höhle: {npc:11558} und {npc:11557} stehen gleich hinter dem Eingang.",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Betritt die Höhle: {npc:11558} steht gleich hinter dem Eingang.",
	-- ["Still short of level 52.9 after the {area:2479}'s hand-ins? Top up on the Entropic Beasts in {area:1766}, the next stop north."] = "Nach den Abgaben im {area:2479} noch unter Stufe 52,9? Hol dir den Rest an den Entropic Beasts in {area:1766}, dem nächsten Halt im Norden.",
	-- ["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Nimm das Boot von {area:702} nach {area:442} und flieg nach {area:415}.",
	-- ["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Die Verfluchten und Besudelten Brühschlammer gleiten durch die Bäche und Teufelstümpel um {area:1763} und {area:1765}: Töte sie und benutze Laris' leere Schlammgefäße an ihren Überresten.",
	-- ["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Die Furbolgs der Totenwaldfelle leben im Dorf gleich südwestlich von {npc:11554}; behalte die Kopfputzfedern der Totenwaldfelle, die sie fallen lassen.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54 and the Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Die Furbolgs der Totenwaldfelle von {area:1762} bevölkern die Hügel westlich der Höhle. Töte sie weiter, bis einer ein {quest:8470} fallen lässt, etwa bei jedem dreißigsten Kill, und klicke es dann mit Rechtsklick an: {npc:11558} in {area:1769} nimmt es an, sobald die Holzschlundfeste dir gegenüber Neutral ist, jetzt, falls sie es schon ist, oder wenn dich der letzte Guide wieder an der Höhle vorbeiführt, bei 58.\nVorsicht: Die Höhlenwächter sind Stufe 53-54 und die Rächer 54-55; sie rufen nahe Verbündete in 25 yd Umkreis, sobald sie unter 50 % Gesundheit sind, und laufen unter 15 % davon, um Hilfe zu holen.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. Keep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 58.\nCareful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "Die Deadwood-Furbolgs von {area:1762} bevölkern die Hügel westlich der Höhle. Töte sie weiter, bis einer ein {quest:8470} fallen lässt, etwa bei jedem dreißigsten Kill, und klicke es dann mit Rechtsklick an: {npc:11558} in {area:1769} nimmt es an, sobald die Timbermaw dir gegenüber Neutral sind, jetzt, falls sie es schon sind, oder wenn dich der letzte Guide wieder an der Höhle vorbeiführt, bei 58.\nVorsicht: Die Den Watchers sind Stufe 53-54; sie rufen nahe Verbündete in 25 yd Umkreis, sobald sie unter 50 % Gesundheit sind, und laufen unter 15 % davon, um Hilfe zu holen.",
	-- ["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Die Furbolgs der Totenwaldfelle im {area:1762} füllen die Hügel westlich der Höhle. Die Rächer können ein {quest:8470} fallen lassen.",
	-- ["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Die Jadefeuersatyrn halten das Tal westlich der Straße, mit {npc:9454} im hinteren Teil.",
	-- ["The vial is filled in {zone:1457}: keep it"] = "Die Phiole wird in {zone:1457} gefüllt: Behalte es",
	-- ["The vial is filled in {zone:1457}: keep it; inside"] = "Die Phiole wird in {zone:1457} gefüllt: Behalte sie; drinnen",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7765}: climb in through the break in its wall from the ledge beside it."] = "Die {item:11242} wächst in einem zerfallenen Gebäude nördlich von {npc:7765}: Kletter vom Felsvorsprung daneben durch das Loch in der Wand hinein.",
	-- ["Top up here to level 52.69 before the hand-ins at {area:1763}: they take you to level 53."] = "Grinde hier bis Stufe 52,69, bevor du bei {area:1763} abgibst: Das bringt dich auf Stufe 53.",
	-- ["Top up here to level 52.9 before the hand-ins at {area:2479}: they take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Grinde hier bis Stufe 52,9, bevor du bei {area:2479} abgibst: Das bringt dich auf Stufe 53. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417} oder den Dungeon {area:2100}.",
	-- ["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Benutze die {item:12922} am verderbten Mondbrunnen mitten in {area:1763}. Hast du {npc:11018} befreit, geh zurück in {area:1770} zum Sukkubus {npc:9518}; die Überreste von Trey Lightforge liegen neben ihr.",
	-- ["grind on {npc:7109}"] = "Grinde an {npc:7109}",
	-- ["grind on {npc:7153}"] = "Grinde an {npc:7153}",
	-- ["grind on {npc:7155}"] = "Grinde an {npc:7155}",
	-- ["grind on {npc:9878}"] = "Grinde an {npc:9878}",
	-- ["{area:1763} is the ruined temple north of the glen."] = "{area:1763} ist der zerstörte Tempel nördlich des Tals.",
	-- ["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} ist der verfallene Tempel nördlich des Tals. Manche seiner Kultisten lassen einen {item:13140} fallen, etwa einer von dreißig: Er öffnet die Zelle von {npc:11018} in {area:1770}, der Höhle im hinteren Teil. Fällt er, säubere den Weg nach draußen, bevor du sie befreist; sonst überspring ihre Quests.",
	-- ["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} ist das Satyrtal im Nordwesten, mit {npc:10648} an seinem hinteren Ende. Er lässt {quest:939} fallen; jeder Jadefeuersatyr kann {item:11674} fallen lassen.",
	-- ["{item:13140}, a rare drop"] = "{item:13140}, seltene Beute",
	-- ["{npc:10924}: for {npc:11079} in {zone:1452}, keep it"] = "{npc:10924}: für {npc:11079} in {zone:1452}, behalte es",
	-- ["{npc:11016}, in {area:1770}"] = "{npc:11016}, in {area:1770}",
	-- ["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: dreißig {quest:6031}, abgegeben, wenn du mit 57 wieder durchkommst",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: Die Holzschlundfeste spricht erst ab Neutral mit dir",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: Die Timbermaw sprechen nur ab Neutral mit dir; läuft hier umher: Schau in den Kreis auf der Karte",
	-- ["{npc:15395} waits at the north end of {area:361}"] = "{npc:15395} wartet am Nordende des {area:361}",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, seltene Beute",
}
