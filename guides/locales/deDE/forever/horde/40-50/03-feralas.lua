-- German (deDE): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 2: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, auf dem Rückweg zu Zinge",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "{item:8523} von diesen Aufträgen: behalte es, Tanaris Field Sampling gibt es in {area:976} zurück",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; wenn du es lernst, bekommst du ein Reittier. Jede Rasse lernt es bei ihrem eigenen Rassenlehrer: deine ist {npc:4773} in {area:159}, ein kurzes Stück nördlich der Zeppelintürme, mit den Skelettpferden von {npc:4731} (je 20 Gold) neben ihr. Reite zurück zu den Türmen für den Zeppelin nach {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrer",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Skelettpferde: {npc:4731}, neben {npc:4773} in {area:159}.",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Flugmeister von {object:3202}",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "Wenn du aus Stranglethorn kommst, hast du diese schon. Ab hier: {npc:5591} steht in der großen Halle von {area:75} und {npc:1443} im obersten Stock.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, drinnen",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, im obersten Stock",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Reite auf der Straße nach Westen; die Schriftrolle liegt am Wasser im äußersten Westen des Sumpfs.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "für {object:2555} in {zone:1445}, später in diesem Guide",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Sägezahnkrokilisken",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Die Krokolisken suhlen sich in den Tümpeln rund um Galens altes Lager, direkt nördlich von {area:75}, auf dem Rückweg nach Osten; etwa jede vierte lässt eine Flanke fallen.",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Zurück nach Osten an {area:75} vorbei: Die Artefakte der Atal'ai liegen im Wasser und an den Ufern des {quest:1424}.",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "Folge der Straße nach Südosten zum kleinen Posten der Horde am Ufer. {npc:5592} nimmt die Krokoliskenflanken vom letzten Sumpfbesuch.",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}: töte diese, wenn du sie triffst",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "Die Snapper säumen den Strand südlich des Postens.\nDie Monstrous Crawlers laufen an den Stränden der Ostküste, nur vereinzelt: Töte jeden, den du siehst, auch die auf dem Ritt hinab vom Teich.",
	["Underwater"] = "Unter Wasser",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Murlocs am Nebelschilf",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Die Marschenmurlocs leben am Strand südlich des Postens; die Marschentintenspucker sind am Ufer östlich davon und die Marschenfleischfresser weiter westlich, um die Hütten am Westufer.",
	["Below ground"] = "Unter der Erde",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "Dieselbe Murloc-Küste noch einmal: Inkspewers östlich des Postens, Flesheaters rund um die westlichen Hütten und die Oracles unter beiden.",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "für {npc:5598} im {zone:1425}, etwa ab Stufe 48",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "Nach {area:1099}",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "für die Eulenbestien im {zone:1425}, etwa ab Stufe 48",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Flieg nach {area:496}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Flugmeister in {area:1099}",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "{npc:4500}, {npc:4502} und {npc:4501} (unterirdisch) sind im Dorf; ihre Quests sind für {area:511} bei diesem Besuch.",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, unterirdisch",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "{object:2555}",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "Reite nach Südwesten zu {object:2555}.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "In {area:498}",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}: töte diese, wenn du sie triffst",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Weiter östlich durch {area:511}: Die Firemane-Späher und Aschenschwänze streifen mit den Searing-Jungtieren und Welpen am Nordrand umher; die Scalebane bewachen die Drachenhöhlen weiter südöstlich. Mok'Morokks Schnupftabak, Grog und Truhe liegen in den Lagern der Drachkin.",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329} läuft um {area:510} herum: schau in den Kreis auf der Karte",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "Reite zurück nach Norden nach Brackenwall.",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "Onyxias Eier",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Die Eier von Onyxia liegen in den Drachenhöhlen im Südosten von {area:511}, bewacht von den Bannschuppen; zerschlag fünf.",
	["Dragon caves"] = "Drachenhöhlen",

	-- Step 28: Level 45.37
	["Level 45.37"] = "Stufe 45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak · {area:1517} Uldaman
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "Die Herausforderung von {npc:4500}, zurück in Brackenwall, braucht eine Dreiergruppe. Allein grindest du hier am Nordrand von {area:511} die Späher der Feuermähnen bis Stufe 45.37, bevor du zurück nach Norden reitest, damit du dafür nicht noch einmal herunterkommen musst. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:978} oder den Dungeon {area:1517}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "grinde {npc:4329}",

	-- Step 30: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "Das sind Elite-Mobs: Sich zu gruppieren ist empfohlen, such dir Leute dafür. {quest:1173} braucht eine Gruppe von 3. Überspring sie, wenn du allein bist: Die Route lässt dich die EP wieder erarbeiten.\n{npc:4500} ist Elite: Gruppe empfohlen. Prügle ihn nieder, bis er aufgibt, und melde dich dann bei {npc:4501}.",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "Flugmeister von {area:496}",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Grimmlingflitzer und Waldgänger",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Die Grimmlingflitzer schwirren über dem Hain gleich westlich des Lagers und tragen {item:9589}; die Wandernden Waldgänger, etwas weiter westlich, tragen die Abgesplitterten Baumstämme.",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Fransenfederhippogryphen",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Südlich des Tals nisten die Fransenfederhippogryphen an den Hängen; fast jeder lässt Sehnen und metallische Fragmente fallen.",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Reite nach Nordwesten zur {area:1108}; {npc:14637} wartet am Steg.",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "Kreischer",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Rogue Vale beginnt direkt nördlich von {npc:14637}s Dock. Töte einen {npc:5308}, benutze {item:10699} an seinem Körper und töte den Geist, der sich erhebt.",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: Töte diese, sobald sie dir begegnen",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Meereselementare und Meeresschauer spülen um den Steg am Ufer entlang. Schrumpfe die Riesen zuerst mit {item:18904}: Geschrumpft verlieren sie ihre Elitestärke. Uferschreiter waten im Wasser; die Landgänger und Klippenriesen streifen weiter nördlich durch die Hügel.",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "Harpyien der Nordschwingen",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Die Harpyien der Nordschwingen nisten auf den Kämmen im äußersten Nordwesten. Sie sind 48-50, ein paar Stufen über dir: Die Windruferinnen heilen, also töte sie zuerst und zieh einzeln.",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "Wutschrammyetis",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Auf dem Rückweg nach Südosten von den Harpyien leben die Rage Scar Yetis bei den Höhlen in den Hügeln an der Straße. Jeder von ihnen kann auch {quest:7738} fallen lassen, das eine eigene Quest startet.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, eine seltene Beute",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, drinnen",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- ["Forest walkers"] = "Waldgänger",
	-- ["Monstrous Crawlers"] = "Monströse Kriecher",
	-- ["Murlocs of the Misty Reed"] = "Murlocs am Nebelschilf",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "Nordwestlich an der Straße leben die Wutschrammyetis um die Höhlen in den Hügeln. Jeder kann auch {quest:7738} fallen lassen, der eine eigene Quest startet.",
	-- ["Northspring harpies"] = "Harpyien der Nordschwingen",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Reite zurück nach Osten zum Lager. Bleib hier: Der nächste Guide beginnt mit dem Flug nach {area:976}.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Reite nach Südwesten zu {object:2555}, dann nach Osten durch {area:511}. Die Späher und Aschenschweife der Feuermähnen streifen mit den Sengenden Jungtieren und Welpen über seinen Nordrand; die Bannschuppen bewachen die Drachenhöhlen weiter südöstlich. Mok'Morokks Schnupftabak, Grog und Geldkassette liegen in den Lagern der Drachkin.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Im Südwesten hausen die Yetis in {area:1105}; jeder Yeti dort kann einen dicken Balg fallen lassen.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Die Marschenmurlocs leben am Strand südlich des Postens; die Marschentintenspucker sind am Ufer östlich davon und die Marschenfleischfresser weiter westlich, um die Hütten am Westufer.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Die Monströsen Kriecher laufen über die Strände der Ostküste, nur vereinzelt: Töte jeden, den du auf dem Weg nach Süden siehst.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Die Harpyien der Nordschwingen nisten auf den Kämmen im äußersten Nordwesten. Sie sind 48-50, ein paar Stufen über dir: Die Windruferinnen heilen, also töte sie zuerst und zieh einzeln.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Wieder dieselben Murlocs, dazu die Orakel, die nahe den Hütten am Westufer bleiben.",
	-- ["The small Horde post on the southern shore."] = "Der kleine Hordeposten am Südufer.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Der Zeppelin nach {zone:1454} startet vom Turm neben {object:3202}; er landet gleich nordöstlich des Haupttors von {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Du beginnst in {area:75}. Binde dich hier: Nach der Küste kehrst du mit dem Ruhestein zurück.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Dein Lehrer ist in {area:1638}: Flieg dorthin (noch keine Flugroute dort? Flieg zum {area:378} und reite nach Westen durch {zone:1412}), dann weiter nach {area:496}.",
	-- ["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- ["Zeppelin tower"] = "Zeppelinturm",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "für {object:2555} in {area:15}, später in diesem Guide",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} ist Elite: Such dir am besten eine Gruppe. Prügle ihn runter, bis er aufgibt, und melde dich dann bei {npc:4501}.",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: für {npc:7010} in {zone:1454}, etwa ab Stufe 50",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, dann {object:172960} und {object:172961}.",
}
