-- German (deDE): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1454} Orgrimmar · {area:1099} Camp Mojache · {area:511} Wyrmbog · {area:496} Brackenwall Village
	["{zone:1454}'s hand-ins, {area:1099}'s Muisek vessel, then Dustwallow's {area:511} and {area:496}."] = "",
	["Takes you to level 47"] = "Bringt dich auf Stufe 47",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "Dann weiter nach {zone:1446}",
	["Stays on the main route"] = "Bleibt auf der Hauptroute",
	-- {zone:2652} Shen'dralas · {zone:1446} Tanaris
	["Skips {zone:2652}: about a dozen fewer quests, a third of a level lower into {zone:1446}"] = "",

	-- Step 1: Orgrimmar
	-- {object:172960} Cleft of Shadow · {object:172958} Valley of Honor
	["From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Vom Flugmeister: {object:172960}, dann die Gasse, dann {object:172958}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, die Gasse",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, die Gasse",
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425}, around level 50"] = "für {zone:1425}, etwa ab Stufe 50"
	["for the {zone:1425}, around level 49"] = "",

	-- Step 3: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache
	["Your trainer is in {area:1638}, on the way to {area:1099}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 5: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 6: Fly to Camp Mojache
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {zone:1446} Tanaris
	["Fly to {area:1099} (or hearth there, if your hearthstone is ready: it is still bound there from the {zone:1444} & {zone:1446} guide)."] = "",

	-- Step 7: Camp Mojache
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425} owlbeasts, around level 48"] = "für die Eulenbestien im {zone:1425}, etwa ab Stufe 48"
	["for the {zone:1425} owlbeasts, around level 49"] = "",

	-- Step 8: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Flieg nach {area:496}",
	-- {zone:1444} Feralas · {zone:1446} Tanaris · {area:496} Brackenwall Village
	["No Muisek vessel to bring Uzer'i (you didn't take the {zone:1444} & {zone:1446} guide's chain): fly from here straight to {area:496}."] = "",

	-- Step 9: Fly to Brackenwall Village
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Flugmeister in {area:1099}",

	-- Step 10: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "{npc:4500}, {npc:4502} und {npc:4501} (unterirdisch) sind im Dorf; ihre Quests sind für {area:511} bei diesem Besuch.",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, unterirdisch",

	-- Step 11: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "{object:2555}",

	-- Step 12: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "Reite nach Südwesten zu {object:2555}.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "In {area:498}",

	-- Step 13: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}: töte diese, wenn du sie triffst",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Weiter östlich durch {area:511}: Die Firemane-Späher und Aschenschwänze streifen mit den Searing-Jungtieren und Welpen am Nordrand umher; die Scalebane bewachen die Drachenhöhlen weiter südöstlich. Mok'Morokks Schnupftabak, Grog und Truhe liegen in den Lagern der Drachkin.",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329} läuft um {area:510} herum: schau in den Kreis auf der Karte",
	["Below ground"] = "Unter der Erde",

	-- Step 14: Brackenwall Village
	["Ride back north to Brackenwall."] = "Reite zurück nach Norden nach Brackenwall.",

	-- Step 15: Onyxia's eggs
	["Onyxia's eggs"] = "Onyxias Eier",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Die Eier von Onyxia liegen in den Drachenhöhlen im Südosten von {area:511}, bewacht von den Bannschuppen; zerschlag fünf.",

	-- Step 16: Muckshell crabs
	["Muckshell crabs"] = "",
	-- plural, as words: Muckshell Razorclaws = {npc:4405} Muckshell Razorclaw
	["On the way back north from the dragon caves, the Muckshell Razorclaws and Pincers (41-44) crowd the shallows just north of the caves; about one in twenty carries the Jeweled Pendant Marg Speaks asks for."] = "",

	-- Step 17: Level 45.37
	["Level 45.37"] = "Stufe 45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon instead."] = "Die Herausforderung von {npc:4500}, zurück in Brackenwall, braucht eine Dreiergruppe. Allein grindest du hier am Nordrand von {area:511} die Späher der Feuermähnen bis Stufe 45.37, bevor du zurück nach Norden reitest, damit du dafür nicht noch einmal herunterkommen musst. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:978}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "grinde {npc:4329}",

	-- Step 18: Brackenwall Village
	-- {npc:4791} Nazeer Bloodpike · {item:5942} Jeweled Pendant
	["{npc:4791}: the {item:5942}"] = "",
	-- {npc:4047} Zor Lonetree · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["for {npc:4047} in {zone:1454}, on the {zone:1447} guide's {zone:1454} stop"] = "",
	-- {quest:3128} Natural Materials · {zone:1444} Feralas
	["Keep {quest:3128} and Improved Quality: {zone:1444}' sprites, hippogryphs, Zorbin's coast and the Rage Scar yetis come on your {zone:1444} loop at about 51, with the Muisek chain."] = "",

	-- Step 19: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "Das sind Elite-Mobs: Sich zu gruppieren ist empfohlen, such dir Leute dafür. {quest:1173} braucht eine Gruppe von 3. Überspring sie, wenn du allein bist: Die Route lässt dich die EP wieder erarbeiten.\n{npc:4500} ist Elite: Gruppe empfohlen. Prügle ihn nieder, bis er aufgibt, und melde dich dann bei {npc:4501}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Zurück nach Osten an {area:75} vorbei: Die Artefakte der Atal'ai liegen im Wasser und an den Ufern des {quest:1424}.",
	-- ["Back to {npc:14637} on the dock."] = "Zurück zu {npc:14637} am Steg.",
	-- ["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "Wenn du aus Stranglethorn kommst, hast du diese schon. Ab hier: {npc:5591} steht in der großen Halle von {area:75} und {npc:1443} im obersten Stock.",
	-- ["Dragon caves"] = "Drachenhöhlen",
	-- ["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- ["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- ["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "Folge der Straße nach Südosten zum kleinen Posten der Horde am Ufer. {npc:5592} nimmt die Krokoliskenflanken vom letzten Sumpfbesuch.",
	-- ["Forest walkers"] = "Waldgänger",
	-- ["Frayfeather hippogryphs"] = "Fransenfederhippogryphen",
	-- ["Hearth to {area:1099}: your hearthstone is still bound there from the {zone:1444} & {zone:1446} guide."] = "Benutze deinen Ruhestein nach {area:1099}: Er ist noch vom Guide für {zone:1444} & {zone:1446} dort gebunden.",
	-- ["Monstrous Crawlers"] = "Monströse Kriecher",
	-- ["Murlocs of the Misty Reed"] = "Murlocs am Nebelschilf",
	-- ["No flight path to {area:75} yet (the {zone:2548} skip the {zone:1435}): ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "Noch keine Flugroute nach {area:75} (der Guide für {zone:2548} lässt {zone:1435} aus): Reite von {object:3202} nach Nordosten durch {zone:1431} und {zone:1430} in den Sumpf, dann nach Osten die Straße entlang nach {area:75}, und lerne dort die Flugroute.",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Nordwestlich an der Straße leben die Wutschrammyetis um die Höhlen in den Hügeln. Jeder kann auch {quest:7738} fallen lassen, der eine eigene Quest startet.",
	-- ["Northspring harpies"] = "Harpyien der Nordschwingen",
	-- ["On the way back south-east from the coast, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Auf dem Rückweg nach Südosten von der Küste leben die Wutschrammyetis bei den Höhlen in den Hügeln an der Straße. Jeder von ihnen kann auch {quest:7738} fallen lassen, der eine eigene Quest startet.",
	-- ["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Auf dem Rückweg nach Südosten von den Harpyien leben die Rage Scar Yetis bei den Höhlen in den Hügeln an der Straße. Jeder von ihnen kann auch {quest:7738} fallen lassen, das eine eigene Quest startet.",
	-- ["Rage Scar yetis"] = "Wutschrammyetis",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Reite zurück nach Osten zum Lager. Bleib hier: Der nächste Guide beginnt mit dem Flug nach {area:976}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Reite nach Nordwesten zur {area:1108}; {npc:14637} wartet am Steg.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Reite nach Südwesten zu {object:2555}, dann nach Osten durch {area:511}. Die Späher und Aschenschweife der Feuermähnen streifen mit den Sengenden Jungtieren und Welpen über seinen Nordrand; die Bannschuppen bewachen die Drachenhöhlen weiter südöstlich. Mok'Morokks Schnupftabak, Grog und Geldkassette liegen in den Lagern der Drachkin.",
	-- ["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Reite auf der Straße nach Westen; die Schriftrolle liegt am Wasser im äußersten Westen des Sumpfs.",
	-- ["Riding at 40"] = "Reiten mit 40",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; wenn du es lernst, bekommst du ein Reittier. Jede Rasse lernt es bei ihrem eigenen Rassenlehrer: deine ist {npc:4773} in {area:159}, ein kurzes Stück nördlich der Zeppelintürme, mit den Skelettpferden von {npc:4731} (je 20 Gold) neben ihr. Reite zurück zu den Türmen für den Zeppelin nach {object:3202}.",
	-- ["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all."] = "Rogue Vale beginnt direkt nördlich von {npc:14637}s Dock. Töte einen {npc:5308}, benutze {item:10699} an seinem Körper, bevor du ihn plünderst, und sprich dann mit dem Geist, der sich erhebt: Er ist freundlich. Insgesamt drei Geister.",
	-- ["Rogue Vale screechers"] = "Kreischer",
	-- ["Sawtooth crocolisks"] = "Sägezahnkrokilisken",
	-- ["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Meereselementare und Meeresschauer spülen um den Steg am Ufer entlang. Schrumpfe die Riesen zuerst mit {item:18904}: Geschrumpft verlieren sie ihre Elitestärke. Uferschreiter waten im Wasser; die Landgänger und Klippenriesen streifen weiter nördlich durch die Hügel.",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Skelettpferde: {npc:4731}, neben {npc:4773} in {area:159}.",
	-- ["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Südlich des Tals nisten die Fransenfederhippogryphen an den Hängen; fast jeder lässt Sehnen und metallische Fragmente fallen.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Im Südwesten hausen die Yetis in {area:1105}; jeder Yeti dort kann einen dicken Balg fallen lassen.",
	-- ["Sprite darters and forest walkers"] = "Grimmlingflitzer und Waldgänger",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Die Marschenmurlocs leben am Strand südlich des Postens; die Marschentintenspucker sind am Ufer östlich davon und die Marschenfleischfresser weiter westlich, um die Hütten am Westufer.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Die Monströsen Kriecher laufen über die Strände der Ostküste, nur vereinzelt: Töte jeden, den du auf dem Weg nach Süden siehst.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Die Harpyien der Nordschwingen nisten auf den Kämmen im äußersten Nordwesten. Sie sind 48-50, ein paar Stufen über dir: Die Windruferinnen heilen, also töte sie zuerst und zieh einzeln.",
	-- ["The Sea Sprays (47-48) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (48-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength. Leave the Land Walkers and Cliff Giants (48-50) of the northern hills for your next {zone:1444} visit.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "Die Meeresschauer (47-48) treiben am Ufer direkt südlich des Docks: Sie lassen die Wasserelementarkerne genauso fallen wie die Meereselementare (48-49). Die Wellen- und Tiefenschreiter (47-49) waten im Wasser vor demselben Strand: Triff sie zuerst mit {item:18904}, geschrumpft verlieren sie ihre Elite-Stärke. Lass die Landgänger und Klippenriesen (48-50) der nördlichen Hügel für deinen nächsten Besuch in {zone:1444}.\nDer Ultra-Schrumpfer hält zwei Stunden: Gib beide Quests bei {npc:14637} ab, bevor du die Küste verlässt.",
	-- ["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Die Krokolisken suhlen sich in den Tümpeln rund um Galens altes Lager, direkt nördlich von {area:75}, auf dem Rückweg nach Osten; etwa jede vierte lässt eine Flanke fallen.",
	-- ["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "Dieselbe Murloc-Küste noch einmal: Inkspewers östlich des Postens, Flesheaters rund um die westlichen Hütten und die Oracles unter beiden.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Wieder dieselben Murlocs, dazu die Orakel, die nahe den Hütten am Westufer bleiben.",
	-- ["The small Horde post on the southern shore."] = "Der kleine Hordeposten am Südufer.",
	-- ["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "Die Snapper säumen den Strand südlich des Postens.\nDie Monstrous Crawlers laufen an den Stränden der Ostküste, nur vereinzelt: Töte jeden, den du siehst, auch die auf dem Ritt hinab vom Teich.\nVorsicht: Am südöstlichen Strand läuft {npc:272377} (Stufe 60) umher: Mach einen weiten Bogen darum.",
	-- ["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "Die Grimmlingflitzer schwirren über dem Hain gleich westlich des Lagers und tragen {item:9589}; die Wandernden Waldgänger, etwas weiter westlich, tragen die Abgesplitterten Baumstämme.\nVorsicht: Über dem Wald westlich des Lagers fliegt {npc:272401} (Stufe 60): Halte dich davon fern.",
	-- ["The zeppelin lands at {object:3202}: Stranglethorn's errands are done (40-50/02), so fly straight on to {area:75}."] = "Der Zeppelin landet in {object:3202}: Die Aufträge im Schlingendorntal sind erledigt (40-50/02), also flieg direkt weiter nach {area:75}.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Der Zeppelin nach {zone:1454} startet vom Turm neben {object:3202}; er landet gleich nordöstlich des Haupttors von {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["Three zones, lots of travel"] = "Drei Gebiete, viel Reiserei",
	-- ["To {area:1099}"] = "Nach {area:1099}",
	-- ["To {area:75}"] = "Nach {area:75}",
	-- ["Underwater"] = "Unter Wasser",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Du beginnst in {area:75}. Binde dich hier: Nach der Küste kehrst du mit dem Ruhestein zurück.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Dein Lehrer ist in {area:1638}: Flieg dorthin (noch keine Flugroute dort? Flieg zum {area:378} und reite nach Westen durch {zone:1412}), dann weiter nach {area:496}.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",
	-- ["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- ["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",
	-- ["Zeppelin tower"] = "Zeppelinturm",
	-- ["for the {npc:5598} in the {zone:1425}, around level 48"] = "für {npc:5598} im {zone:1425}, etwa ab Stufe 48",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "für {object:2555} in {area:15}, später in diesem Guide",
	-- ["for the {object:2555} in {zone:1445}, later in this guide"] = "für {object:2555} in {zone:1445}, später in diesem Guide",
	-- ["for the {zone:1425} owlbeasts, around level 48"] = "für die Eulenbestien im {zone:1425}, etwa ab Stufe 48",
	-- ["for the {zone:1425}, around level 50"] = "für {zone:1425}, etwa ab Stufe 50",
	-- ["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "{item:8523} von diesen Aufträgen: behalte es, Tanaris Field Sampling gibt es in {area:976} zurück",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: Töte diese, sobald sie dir begegnen",
	-- ["{area:2403}: kill these as you meet them"] = "{area:2403}: töte diese, wenn du sie triffst",
	-- ["{area:496} flight master"] = "Flugmeister von {area:496}",
	-- ["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, auf die Wellen- und Tiefenschreiter im Wasser",
	-- ["{item:18958}, from the Sea Sprays"] = "{item:18958}, von den Meeresschauern",
	-- ["{npc:1443}, on the top floor"] = "{npc:1443}, im obersten Stock",
	-- ["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, auf dem Rückweg zu Zinge",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} ist Elite: Such dir am besten eine Gruppe. Prügle ihn runter, bis er aufgibt, und melde dich dann bei {npc:4501}.",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrer",
	-- ["{npc:5591}, inside"] = "{npc:5591}, drinnen",
	-- ["{npc:7776}'s Northspring harpies (48-50) wait for your {zone:1444} visit at about 51: keep the quest."] = "Die Nordquellharpyien (48-50) von {npc:7776} warten auf deinen Besuch in {zone:1444} mit etwa 51: Behalte die Quest.",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- ["{npc:7854}, inside"] = "{npc:7854}, drinnen",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: für {npc:7010} in {zone:1454}, etwa ab Stufe 50",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, dann {object:172960} und {object:172961}.",
	-- ["{object:3202} flight master"] = "Flugmeister von {object:3202}",
	-- ["{quest:7738}, a rare drop"] = "{quest:7738}, eine seltene Beute",
	-- ["{zone:1435} and Dustwallow first, then {zone:1444}."] = "Zuerst {zone:1435} und die Düstermarschen, dann {zone:1444}.",
}
