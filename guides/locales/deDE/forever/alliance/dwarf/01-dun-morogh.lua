-- German (deDE): the guide forever/alliance/dwarf/01-dun-morogh (forever/alliance/dwarf/01-dun-morogh.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {area:77} Anvilmar · {npc:658} Sten Stoutarm
	["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "Du beginnst vor {area:77}, der Steinhalle am Nordende des Tals. {npc:658} wartet vor der Tür.",

	-- Step 2: Young wolves
	["Young wolves"] = "Junge Wölfe",
	-- {area:77} Anvilmar
	["Ragged Young Wolves roam the snow just south of {area:77}."] = "Struppige junge Wölfe streifen durch den Schnee gleich südlich von {area:77}.",

	-- Step 3: Anvilmar
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}: eine Rune für {npc:895}",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}: Lies {quest:98581}",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, neben {npc:658}",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer; inside"] = "{npc:912}, der Kriegerlehrer; drinnen",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}, der Paladinlehrer",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}, der Jägerlehrer",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, der Schurkenlehrer",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, der Priesterlehrer",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}, in {area:77}",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "In {area:77}",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, in {area:77}",

	-- Step 4: The troggs
	["The troggs"] = "Die Troggs",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "Troggs der Felsenkiefer und Bullige Troggs der Felsenkiefer graben überall auf dem Talboden südlich von {area:77}.",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "Zurück nach {area:77}",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}; inside"] = "{npc:8416}, an der Tür von {area:77}; drinnen",

	-- Step 6: Talin Keeneye
	-- {npc:714} Talin Keeneye · {item:10438} Felix's Box
	["{npc:714}'s camp is at the west end of the valley. {item:10438} lies in the snow south of it, his Chest by the troll cave and his Bucket of Bolts east of the cave: grab them as you pass."] = "{npc:714}s Lager liegt am Westende des Tals. {item:10438} liegt im Schnee südlich davon, Felix' Truhe bei der Trollhöhle und Felix' Bolzeneimer östlich der Höhle: Schnapp sie dir im Vorbeigehen.",

	-- Step 7: The boars
	["The boars"] = "Die Eber",
	-- {npc:714} Talin Keeneye
	-- plural, as words: Small Crag Boars = {npc:708} Small Crag Boar
	["Small Crag Boars graze around {npc:714}'s camp and along the west side of the valley."] = "Kleine Klippeneber grasen um {npc:714}s Lager und entlang der Westseite des Tals.",

	-- Step 9: Grelin Whitebeard
	-- {npc:786} Grelin Whitebeard · {npc:12738} Nori Pridedrift
	["{npc:786} and {npc:12738} camp at the south-west edge of the valley, below the troll cave."] = "{npc:786} und {npc:12738} lagern am Südwestrand des Tals, unterhalb der Trollhöhle.",

	-- Step 10: Coldridge Valley: kill these as you meet them
	-- {area:132} Coldridge Valley
	["{area:132}: kill these as you meet them"] = "{area:132}: Töte sie, wenn du ihnen begegnest",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "Trollwelpen der Frostmane füllen die Hänge südlich und östlich von {npc:786}s Lager.",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "Federglücksbringer, von den Novizen der Frostmane",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}: zeitlich begrenzt, fünf Minuten, um {npc:836} in {area:77} zu erreichen",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "Das kochend heiße Morgengebräu hält fünf Minuten: Geh direkt nach Norden zu {npc:836} in {area:77}.",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:836}, inside {area:77}; below ground"] = "{npc:836}, in {area:77}; unterirdisch",
	["Level 4 spells, before Gozwin's camp"] = "Zauber der Stufe 4, vor Gozwins Lager",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "{npc:8416}, an der Tür auf dem Weg nach draußen; drinnen",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} steht bei {npc:8416} an der Tür von {area:77}. Gozwins Lager liegt in den Hügeln gleich nordwestlich; {npc:269075} schleicht darum herum.",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "{npc:2756}, drinnen",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, im Lager",
	["The troll cave"] = "Die Trollhöhle",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} ist in der Trollhöhle östlich von {npc:786}s Lager, nicht auf dem Hügel darüber: Geh am Eingang hinein und folge dem Tunnel bis ganz nach hinten.",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "{item:2004}; unterirdisch",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, neben ihm",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "Eiskrallenbärenanhänger, von den Trollwelpen der Frostmane an den Hängen über dem Lager",

	-- Step 16: Branstock Khalder
	-- {area:77} Anvilmar · {npc:786} Grelin Whitebeard · {npc:837} Branstock Khalder · {npc:1226} Maxan Anvol · {area:131} Kharanos
	["{area:77} is on the way north from {npc:786}'s camp to the tunnel: {npc:837}, the priest trainer inside, sends priests of level 5 to {npc:1226} in {area:131}."] = "{area:77} liegt auf dem Weg von {npc:786}s Lager nach Norden zum Tunnel: {npc:837}, der Priesterlehrer drinnen, schickt Priester der Stufe 5 zu {npc:1226} in {area:131}.",
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar
	["{npc:837}, inside {area:77}"] = "{npc:837}, in {area:77}",

	-- Step 17: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "Zurück zu {npc:257446} in {area:77}. Er gibt dir {item:6635}: Nimm den mit Geröll markierten Pfad, der im Süden des Tals nach Westen zum Geisterstein auf dem Grat hinaufführt, trink das Sapta daneben und sprich mit {npc:5891}, dann bring {item:6656} zurück zu Teo.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, neben dem Geisterstein",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}: {npc:5873} und dein {item:5175}",

	-- Step 18: The tunnel
	["The tunnel"] = "Der Tunnel",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965} bewacht den Tunnel aus dem Tal, östlich von {area:77}; {npc:6782} steht neben ihm am Eingang.",

	-- Step 19: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery
	["Follow the road through the tunnel and north-east to {area:131}. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}."] = "Folge der Straße durch den Tunnel und nach Nordosten bis {area:131}. Beginn draußen: {npc:1252} und Erics Lagerfeuer sind vor der {area:2102}.",

	-- Step 20: The Great Outdoors
	-- {npc:1241} Tognus Flintfire · {skill:129} First Aid · {npc:2326} Thamner Pol · {area:131} Kharanos · {area:189} Steelgrill's Depot
	["Sit by Eric's campfire (type /sit) and wait for the buff. With a profession learned, Eric also offers its Camping 101, which its trainer takes: blacksmithing with {npc:1241} and {skill:129} with {npc:2326} in {area:131}, mining and engineering at {area:189}."] = "Setz dich an Erics Lagerfeuer (tippe /sit) und warte auf den Segen. Hast du einen Beruf erlernt, bietet Eric auch dessen Camping 101 an, das der jeweilige Lehrer annimmt: Schmiedekunst bei {npc:1241} und {skill:129} bei {npc:2326} in {area:131}, Bergbau und Ingenieurskunst bei {area:189}.",

	-- Step 21: Camping 101: Blacksmithing
	-- {npc:1241} Tognus Flintfire · {skill:164} Blacksmithing
	["{npc:1241} takes it once your {skill:164} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:1241} nimmt sie entgegen, sobald deine Fertigkeit in {skill:164} 20 beträgt: Sammle oder stelle bis dahin her, der Guide geht inzwischen weiter.",
	-- {npc:265813} Eric Brighthammer · {npc:1241} Tognus Flintfire
	["{npc:265813}: for {npc:1241}, in the cellar west of the distillery"] = "{npc:265813}: für {npc:1241}, im Keller westlich der Brauerei",

	-- Step 22: Camping 101: First Aid
	-- {npc:2326} Thamner Pol · {skill:129} First Aid
	["{npc:2326} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:2326} nimmt sie entgegen, sobald deine Fertigkeit in {skill:129} 20 beträgt: Sammle oder stelle bis dahin her, der Guide geht inzwischen weiter.",
	-- {npc:265813} Eric Brighthammer · {npc:2326} Thamner Pol · {area:2102} Thunderbrew Distillery
	["{npc:265813}: for {npc:2326} in the {area:2102}"] = "{npc:265813}: für {npc:2326} in {area:2102}",

	-- Step 23: Camping 101: Mining
	-- {npc:5392} Yarr Hammerstone · {skill:186} Mining
	["{npc:5392} takes it once your {skill:186} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:5392} nimmt sie entgegen, sobald deine Fertigkeit in {skill:186} 20 beträgt: Sammle oder stelle bis dahin her, der Guide geht inzwischen weiter.",
	-- {npc:265813} Eric Brighthammer · {npc:5392} Yarr Hammerstone · {area:189} Steelgrill's Depot
	["{npc:265813}: for {npc:5392} at {area:189}"] = "{npc:265813}: für {npc:5392} bei {area:189}",

	-- Step 24: Camping 101: Engineering
	-- {npc:1702} Bronk Guzzlegear · {skill:202} Engineering
	["{npc:1702} takes it once your {skill:202} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:1702} nimmt sie entgegen, sobald deine Fertigkeit in {skill:202} 20 beträgt: Sammle oder stelle bis dahin her, der Guide geht inzwischen weiter.",
	-- {npc:265813} Eric Brighthammer · {npc:1702} Bronk Guzzlegear · {area:189} Steelgrill's Depot
	["{npc:265813}: for {npc:1702} at {area:189}"] = "{npc:265813}: für {npc:1702} bei {area:189}",

	-- Step 25: Tognus Flintfire
	["talk to the trainer"] = "Sprich mit dem Lehrer",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "{npc:1241}, unterirdisch",

	-- Step 26: Kharanos
	-- {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "{npc:1872} arbeitet an der Schmiede westlich der Brennerei.\nGeh dann hinein: {npc:6806}, der Gastwirt, {npc:1226} und {npc:1267}. Die Lektion in {skill:185} bei {npc:1699} wartet auf die Rückkehr mit den Rippchen, wenn das Kupfer dafür da ist.",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "{npc:6806}, drinnen",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "{npc:1226}, oben",
	-- {npc:1226} Maxan Anvol · {npc:12427} Mountaineer Dolf · {area:131} Kharanos
	["{npc:1226}: heal {npc:12427} south of {area:131}"] = "{npc:1226}: Heile {npc:12427} südlich von {area:131}",
	["Last: some classes' trainers stand outside"] = "Zuletzt: Die Lehrer einiger Klassen stehen draußen",

	-- Step 27: Thamner Pol
	-- {npc:2326} Thamner Pol
	["{npc:2326}, inside the distillery"] = "{npc:2326}, in der Brauerei",

	-- Step 28: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Folge der Straße von {area:131} nach Nordosten zum Depot unterhalb der Straße nach {zone:1455}.",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "{npc:1694}, neben ihm",

	-- Step 29: Yarr Hammerstone
	-- {npc:5392} Yarr Hammerstone
	["{npc:5392}, at the depot"] = "{npc:5392}, am Depot",

	-- Step 30: Bronk Guzzlegear
	-- {npc:1702} Bronk Guzzlegear · {npc:5392} Yarr Hammerstone
	["{npc:1702}, beside {npc:5392}"] = "{npc:1702}, neben {npc:5392}",

	-- Step 31: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "Gretchen lagert direkt vor dem {area:136}, der Wendigohöhle südwestlich von {area:131}.",

	-- Step 32: The Grizzled Den
	-- {npc:278166} Mountaineer Cornelius
	["Flintfire's shipments lie on the cave floor, and {npc:278166} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "Flintfires Lieferungen liegen auf dem Höhlenboden, und {npc:278166} ist irgendwo drinnen verschwunden.\nVorsicht: Wendigos stehen in der Höhle dicht beieinander, sodass bei Kämpfen leicht mehrere auf einmal gepullt werden; sie einzeln mit Fernangriffen von draußen herauszulocken vermeidet das.",

	-- Step 33: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}."] = "{object:176785} steht neben {npc:271546}, südlich vom {area:136}.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}: {object:176785}",

	-- Step 35: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "{npc:1243} lagert südwestlich davon, an der Straße nach Coldridge.",

	-- Step 36: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "{zone:1426}: Töte sie, wenn du ihnen begegnest",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "Crag Boars und Young Black Bears streifen über die Felder von Rumbleshots Lager nach Nordosten bis {area:131} und zum Depot: Töte sie auf dem Rückweg.",

	-- Step 37: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels wounded on the ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer, on the walk back from Rumbleshot's camp. Cast {spell:613} (Rank 2) on him, then {spell:1243}: Rank 1 of {spell:613} does not count."] = "{npc:12427} kniet verwundet auf dem Grat zwischen zwei niedrigen Mauern gleich südlich von {area:131}, gegenüber dem Tierlehrer für Jäger auf der anderen Straßenseite, auf dem Rückweg von Rumbleshots Lager. Wirke {spell:613} (Rang 2) auf ihn, dann {spell:1243}: Rang 1 von {spell:613} zählt nicht.",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "Heile und stärke {npc:12427}",

	-- Step 38: Kharanos
	-- {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1241} Tognus Flintfire
	["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it."] = "{npc:1252} steht an Erics Lagerfeuer vor der {area:2102}; {npc:1241} ist im Keller westlich davon.",

	-- Step 39: Thunderbrew Distillery
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "Töte die Crag Boars auf dem Weg: Ihre Rippchen fallen, noch bevor du die Quest von {npc:1267} hast, und zählen dafür. Zurück in der Brennerei: {npc:1699} bringt dir {skill:185} bei, dann gehen die Rippchen an {npc:1267}.",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "{item:2894}, von {npc:1247}; oben",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "{npc:1699}: Camping 101 verlangt, dass du es lernst; unterirdisch",
	-- {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["{npc:1226}, upstairs: {item:16605}"] = "{npc:1226}, im Obergeschoss: {item:16605}",
	["Upstairs"] = "Oben",

	-- Step 40: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131} und das Depot",
	-- {npc:1269} Razzle Sprysprocket · {area:131} Kharanos
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "Die Piloten stehen am Depot; {npc:1269} ist auf der Straße zurück nach Westen, nördlich von {area:131}.",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "{npc:1377}, neben ihm",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "{npc:1269}, auf dem Rückweg; unterirdisch",

	-- Step 41: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "{area:137} liegt am See westlich von {area:131}. Der Steg von {npc:8508} ist die erste Station; {npc:1374} und {npc:1375} sind im Dorf dahinter.",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "{npc:8508}, am Steg",
	-- {npc:1196} Ice Claw Bear
	["{npc:1196}, on the way to the Hold"] = "{npc:1196}, auf dem Weg zur Feste",
	-- {npc:1127} Elder Crag Boar
	["{npc:1127}, on the way"] = "{npc:1127}, auf dem Weg",
	-- {npc:1201} Snow Leopard
	["{npc:1201}, on the way"] = "{npc:1201}, auf dem Weg",

	-- Step 42: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Frostmane Hideskinners = {npc:1122} Frostmane Hideskinner
	["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end.\nCareful: the Frostmane Hideskinners inside the Hold are level 9-10 and stand in pairs: pull them one at a time back to the mouth."] = "{area:135} ist die Trollhöhle in den Hügeln südwestlich von {area:137}. Eisklauenbären, Alte Klippeneber und Schneeleoparden, die du auf dem Weg tötest, zählen für {npc:1374}. Töte Kopfjäger an ihrem Eingang und geh bis zu ihrem hinteren Ende durch.\nVorsicht: Die Fellhäuter der Frostmähnen in der Feste sind Stufe 9-10 und stehen paarweise: Zieh sie einzeln zurück zum Eingang.",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "{npc:1123}, unterirdisch",

	-- Step 43: Gnomeregan: kill these as you meet them
	-- {area:133} Gnomeregan
	["{area:133}: kill these as you meet them"] = "{area:133}: Töte sie, wenn du ihnen begegnest",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "Lepragnome um Brewnall und an der Straße nach {area:133} tragen die Zahnräder und Getriebe. Eisklauenbären, Alte Klippeneber und Schneeleoparden streifen durch die Hügel um den See.",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}: Lepragnome",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}: Lepragnome",

	-- Step 46: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373} bewacht die {item:2686}-Fässer im Keller der Brennerei. Kaufe ein {item:2686} bei {npc:1247}, klicke das bewachte Fass an und gib dann das Bier im Questfenster an {npc:1373} ab (es gibt keine Quest zum Annehmen); danach nimmt das unbewachte Fass das {spell:8553}.",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "{npc:1252}: {npc:1274} in {zone:1455} nimmt sie an",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "{item:2686}, von {npc:1247} in der Brennerei; oben",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "{object:269} im Keller",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "{npc:1373}, neben dem Fass; unterirdisch",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "{object:270} in der Brennerei; unterirdisch",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "{npc:1269}, unterirdisch",

	-- Step 47: Shimmerweed
	-- {item:2676} Shimmerweed · {area:802} Shimmer Ridge · {area:131} Kharanos
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on {area:802}, the snowy slope north of the road between {area:131} and Brewnall: climb from the road west of {area:131}. The Frostmane Seers camped on the ridge drop it too."] = "{item:2676} wächst in Körben auf {area:802}, dem verschneiten Hang nördlich der Straße zwischen {area:131} und Brewnall: Klettere von der Straße westlich von {area:131} hinauf. Die Frostmane Seers auf dem Kamm lassen es auch fallen.",

	-- Step 49: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {area:131} Kharanos · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of the road back east from Brewnall to {area:131}. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "{npc:1266} lagert in {area:801}, südlich der Straße von Brewnall zurück nach Osten zu {area:131}. Seine Fleischvorräte liegen im Spind in der Höhle von {npc:1271}, östlich seines Lagers. {npc:1271} ist ein Elite-Yeti: Warte außer Sicht, bis er auf seine Patrouille davonzieht, nimm dann das Fleisch und verschwinde, bevor er zurückkommt. Du musst nicht gegen ihn kämpfen.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "{item:2667}: der Fleischspind; unterirdisch",

	-- Step 50: Kharanos
	-- {area:131} Kharanos
	["Back east through {area:131}: the class quests here wait for level 10."] = "Zurück nach Osten durch {area:131}: Die Klassenquests hier warten auf Stufe 10.",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}, bei der Schmiede",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: {npc:257597} beim Südtor nimmt sie an",
	-- {npc:1226} Maxan Anvol · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:1226}: {npc:11406} in {zone:1455} takes it"] = "{npc:1226}: {npc:11406} in {zone:1455} nimmt es an",

	-- Step 51: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1426} Dun Morogh
	["Follow the road north-east from {area:131} to the depot: the whole east of {zone:1426} is one sweep from here."] = "Folge der Straße von {area:131} nach Nordosten zum Depot: Der ganze Osten von {zone:1426} ist von hier aus ein einziger Streifzug.",

	-- Step 52: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "Folge der Straße nach Osten am Depot vorbei nach {area:138}.",

	-- Step 53: Firewood
	["Firewood"] = "Feuerholz",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "Das Feuerholz liegt im Schnee um den gefrorenen See bei der Zuflucht.",

	-- Step 55: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "{npc:276003} auf dem Weg",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "{npc:276003} auf dem Weg zu {npc:1253}",

	-- Step 56: Misty Pine Refuge: kill these as you meet them
	-- {area:138} Misty Pine Refuge
	["{area:138}: kill these as you meet them"] = "{area:138}: Töte sie, wenn du ihnen begegnest",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "Die drei Gewehre liegen im Schnee um den gefrorenen See beim Zufluchtsort. Minor Ice Elementals treiben um den See und entlang des Weges: Töte sie im Vorbeigehen für {quest:99160}.\nBeende die Minor Ice Elementals am kleinen See gleich westlich des Zufluchtsorts, falls dir noch welche fehlen.",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "{npc:276003}, rund um den kleinen See",

	-- Step 58: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325} ist am gefrorenen See, zwischen den Eiselementaren.",

	-- Step 61: Taming the Beast
	-- {item:15908} Taming Rod · {area:131} Kharanos
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "Jede Quest von Grif Wildheart gibt dir {item:15908}: Benutze sie an dem Tier, das er nennt, und bring die Rute dann zu ihm zur Schmiede in {area:131} zurück. Große Klippeneber, Schneeleoparden und Eisklauenbären streifen alle über die Felder gleich südlich und östlich von {area:131}.",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}: Zähme ihn mit {item:15908}",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}: Zähme ihn mit {item:15908}",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}: Zähme ihn mit {item:15908}",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "{npc:10090} in {zone:1455} nimmt sie an",

	-- Step 64: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen lagert auf dem Grat, der von Westen auf {area:134} blickt. Sprich mit ihm für seine Fernsicht.",

	-- Step 67: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "Der Steinbruch liegt gleich östlich von Farsens Kamm.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, im Steinbruch",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: nur für Schmiede",

	-- Step 68: The quarry troggs
	["The quarry troggs"] = "Die Troggs im Steinbruch",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "Rockjaw Skullthumpers, Bonesnappers und Ambushers teilen sich den Steinbruch und die Hänge nördlich davon; die Ambushers lassen {item:268548} fallen.",

	-- Step 71: Helm's Bed Lake
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "Rockjaw Ambushers bei {area:212}, nördlich des Steinbruchs, und Rockjaw Backbreakers weiter östlich lassen {quest:95214} fallen. Dark Iron Spies schleichen am Seeufer östlich des Steinbruchs umher; einer von ihnen lässt {item:274268} fallen.",

	-- Step 72: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Schneeleoparden und Eber streifen durch den Schnee zwischen der Ranch und dem Steinbruch. Schmiede: Kupferbarren bekommst du durch Verhütten von {item:2770} oder bei den Handwerkshändlern.",

	-- Step 76: Protecting the Herd
	-- {npc:1388} Vagash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: most classes solo it at level 14, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Sich zusammenzutun wird empfohlen, such dir Leute dafür. {npc:1388} ist ein Elite der Stufe 12: Die meisten Klassen schaffen ihn auf Stufe 14 allein, aber vielleicht brauchst du Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die EP wieder hereingrinden.",
	["Below ground"] = "Unter der Erde",

	-- Step 77: Amberstill Ranch
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "Auf der Straße zurück nach Westen nach {zone:1455}.",

	-- Step 79: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "Folge der Straße ganz nach Osten zum {area:806} am Tunnel nach {zone:1432}.",

	-- Step 80: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} wartet in einer Höhle über dem Hof nordwestlich von {area:806}; der Pfad hinauf beginnt hinter dem Hof.",

	-- Step 82: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "Geh durch den Tunnel nach {zone:1432}. Gleich dahinter führt ein mit Steinen markierter Pfad die Hügel rechts der Straße nach Norden hinauf zum Lager von {npc:257808}.",

	-- Step 83: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026} und {item:6652}",
	-- {area:923} Stonesplinter Valley · {npc:257808} Braldir Ashmantle · {area:149} Silver Stream Mine
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "Seher der Splittersteintroggs (Stufe 13) stehen zwischen den Troggs im Süden von {area:923}, südlich von {npc:257808}; Geomanten der Tunnelratten (Stufe 12) arbeiten in {area:149} am Nordende des Sees. Die Troggs kommen in Gruppen, und einige werfen aus der Ferne: Lock einzeln.",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}: Seher der Splittersteintroggs",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}: Geomanten der Tunnelratten",

	-- Step 84: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "Der Geisterstein des Feuers",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} gibt dir {item:6636}. Klettere auf den Gipfel über seinem Lager, trink das Sapta neben dem Geisterstein und besiege {npc:5893}, dann leg {item:6655} in {object:61934} oben auf dem Schrein der Ewigen Flamme.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, neben dem Geisterstein",

	-- Step 85: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "Zurück zu {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Zurück durch den Tunnel zu {npc:257597}' Höhle über dem Hof.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, dein {item:5176} und {item:263412}",

	-- Step 86: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960} wartet am {area:808}, nördlich vom Südtor; die Zwergenleiche liegt den Pass westlich von ihm hinauf.",

	-- Step 87: The tunnel post
	["The tunnel post"] = "Der Tunnelposten",
	-- {zone:1432} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "Östlich durch den Tunnel am Südtor nach {zone:1432}. {npc:1089} und {npc:1092} stehen am Zwergenposten gleich dahinter.",

	-- Step 88: Stonesplinter troggs
	["Stonesplinter troggs"] = "Stonesplinter-Troggs",
	-- {area:923} Stonesplinter Valley
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth.\nCareful: Headsplitter, a level 15 trogg, walks {area:923} among the 11-12 troggs: work the camps at its north edge, near the post, and keep clear of him."] = "Nördlich des Postens, westlich der Straße: Die Stonesplinter-Troggs und -Späher lagern in den Hügeln. Beide lassen die Trogg Stone Teeth fallen.\nVorsicht: Headsplitter, ein Trogg der Stufe 15, läuft durch {area:923} zwischen den Troggs der Stufe 11-12: Arbeite an den Lagern am Nordrand, nahe dem Posten, und halte dich von ihm fern.",

	-- Step 89: Back to the tunnel post
	["Back to the tunnel post"] = "Zurück zum Tunnelposten",

	-- Step 90: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {area:2101} Stoutlager Inn · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to {area:144}. {npc:1340} walks the road through town, {npc:1963} stands outside the {area:2101}, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "Nördlich die Straße hinauf nach {area:144}. {npc:1340} läuft die Straße durch die Stadt, {npc:1963} steht vor der {area:2101}, {npc:1681} auf der Ostseite der Stadt; {npc:1572} hält die Greifen.",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "{npc:1572}, der Greifenmeister",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "{npc:1572}: für {npc:4256} in {zone:1455}",

	-- Step 91: The west hills and the Algaz Station
	-- {area:925} Algaz Station
	["The west hills and the {area:925}"] = "Die westlichen Hügel und der {area:925}",
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the {area:925}. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "Nördlich durch die Hügel westlich der Straße zu {npc:1343} am {area:925}. Die Tunnel Rat-Kobolde graben unterwegs in den Hügeln; Elder Black Bears, Mountain Boars und Forest Lurkers streifen durch dasselbe Gelände.",
	-- {item:3110} Tunnel Rat Ear
	["{item:3110}: Tunnel Rat kobolds"] = "{item:3110}: Tunnel Rat-Kobolde",
	-- {item:3172} Boar Intestines
	-- plural, as words: Mountain Boars = {npc:1190} Mountain Boar
	["{item:3172}: Mountain Boars"] = "{item:3172}: Mountain Boars",
	-- {item:3173} Bear Meat
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear
	["{item:3173}: Elder Black Bears"] = "{item:3173}: Elder Black Bears",
	-- {item:3174} Spider Ichor
	-- plural, as words: Forest Lurkers = {npc:1195} Forest Lurker
	["{item:3174}: Forest Lurkers"] = "{item:3174}: Forest Lurkers",
	-- {npc:5413} Furen Longbeard · {zone:1453} Stormwind
	["{npc:5413} in {zone:1453} takes it"] = "{npc:5413} in {zone:1453} nimmt es an",

	-- Step 92: Silver Stream Mine
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats."] = "Östlich entlang der Hügel zur Mine am Nordende des Sees: Die Kisten der Miners' League stehen in ihren Tunneln, zwischen weiteren Tunnel Rats.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "{item:2640}, aus den Kisten",

	-- Step 93: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "Zurück zur {area:925}",

	-- Step 94: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell
	["South down the road to {area:144}, finishing the ears, meat and ichor on the way. {npc:1340} walks the road through town."] = "Auf der Straße nach Süden nach {area:144}; erledige unterwegs die Ohren, das Fleisch und das Sekret. {npc:1340} läuft die Straße durch den Ort ab.",

	-- Step 95: Golnir Bouldertoe
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:4256} Golnir Bouldertoe · {npc:1573} Gryth Thurden
	["The gryphons land in the {object:32372}: {npc:4256} works at its north end, and {npc:1573} keeps the gryphons where you landed."] = "Die Greifen landen in der {object:32372}: {npc:4256} arbeitet an ihrem Nordende, und {npc:1573} hält die Greifen dort, wo du gelandet bist.",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:4256}, in the {object:32372}"] = "{npc:4256}, in der Großen Schmiede",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "{npc:1573}, der Greifenmeister, wo du gelandet bist",

	-- Step 96: Tinker Town
	-- {object:32372} Great Forge (no name in this language: may be words) · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {object:171709} High Seat · {object:32359} Military Ward (no name in this language: may be words)
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "Östlich von der {object:32372} in die {object:171524}: Die {object:660964} liegen an ihrem Briefkasten. Von hier aus geht der Guide einmal um die Stadt: nach Norden zur {object:32383}, nach Westen zum {object:32362}, nach Süden durch die Commons zum {object:171709}, nach Osten durch den {object:32359} und zurück zur {object:171524} für die Tram.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, beim Briefkasten in {object:171524}",

	-- Step 97: Forlorn Cavern
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "Nördlich der {object:32372}: {npc:258098}, der Schamanenlehrer, steht am Südende der {object:32383}, die Schurken- und Hexenmeisterlehrer und {npc:6120} gleich nördlich von ihm.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {npc:6122} in {zone:1453} nimmt sie an",

	-- Step 98: The Tome of Divinity
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, {npc:6179} and {npc:6178} on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "Westlich von der {object:32383} in den {object:32362}: {npc:5149}, {npc:6179} und {npc:6178} sind in der {object:32386}, {npc:6179} und {npc:6178} auf der oberen Etage: Die Treppe nach oben beginnt gleich nordöstlich von {npc:5149}. {npc:6175}, ein Bettler, streift durch die Stadt. Er bittet um zehn {item:2589}: Die Troggs und Trolle in {zone:1426} lassen es fallen, und das Auktionshaus verkauft es.",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "Aus {quest:2997}, den sie dir gibt",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "Benutze {item:6866} an {npc:6177}",

	-- Step 99: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "Verlass {zone:1455} wieder und geh die Straße nach Osten zu {area:212}. {npc:6177} liegt tot an seinem Ufer: Benutze {item:6866} an ihm. Die Dark Iron Spies, die um den See schleichen, tragen die Schrift.",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Spione der Dunkeleisenzwerge",

	-- Step 101: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}: Erlösung",

	-- Step 102: Mystic Ward
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "Die Paladin-, Priester- und Magierlehrer sind in der {object:32386}, im {object:32362}.",

	-- Step 103: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "Südlich durch die Commons: {npc:1274} steht im {object:171709} bei König Magni.",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "{npc:1274}, im {object:171709} bei König Magni",

	-- Step 104: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "Wenn du schon hier bist: Lerne {spell:197} bei {npc:11865} ({object:32359}, 10 Silber); Zweihandwaffen leveln einen Paladin am schnellsten.",

	-- Step 105: Military Ward
	-- {object:32359} Military Ward (no name in this language: may be words) · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms (no name in this language: may be words)
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "Östlich zum {object:32359}: Die Kriegerlehrer und {npc:11865} in der {object:32390}, die Jägerlehrer daneben.",

	-- Step 106: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne {spell:197} bei {npc:11865} ({object:32359}, 10 Silber); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 107: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne {spell:199} bei {npc:11865} ({object:32359}, 10 Silber); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 108: Druid trainer
	["Druid trainer"] = "Druidenlehrer",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "{npc:5505} in {zone:1453}; {zone:1426} hat keinen Druidenlehrer",

	-- Step 109: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {object:171524} Tinker Town · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["East back into {object:171524}: the {area:2257} leaves from its east end. Ride it to {zone:1453}."] = "Östlich zurück in die {object:171524}: Die {area:2257} fährt an ihrem Ostende ab. Fahr damit nach {zone:1453}.",

	-- Step 110: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tiefenbahn nach {zone:1453}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "Auf dem Bahnsteig von {zone:1455} an der {area:2257} bittet {npc:12997} um Hilfe mit den Ratten: Benutze seine {item:17117} an den Deeprun Rats rund um den Bahnsteig, gib sie ab und bring dann seinen Brief zu seinem Bruder {npc:13018} am Ende in {zone:1453}.",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "{npc:12997}, auf dem Bahnsteig von {zone:1455}",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "{npc:13016}: Benutze {item:17117}",
	-- {npc:13016} Deeprun Rat
	["Catch {npc:13016}"] = "Fang {npc:13016}",

	-- Step 111: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "Fahr mit der Tram nach {zone:1453}: {npc:13018} wartet auf dem Bahnsteig von {zone:1453}. {npc:5413} steht im {object:28027}, direkt vor der Tram.",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "{npc:13018}, auf dem Bahnsteig von {zone:1453}",

	-- Step 112: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "Vom {object:28027} nach Südwesten zum {object:2098}: Der Kompass von {npc:1646} liegt in seinem alten Haus in {zone:1436}, auf dem Weg. Der Flugmeister und das {object:2096} sind südlich des Platzes.",

	-- Step 113: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 114: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Wenn du schon hier bist: Lerne {spell:202} bei {npc:11867} ({object:2096}, 10 Silber); Zweihandwaffen leveln einen Paladin am schnellsten.",

	-- Step 115: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Wenn du schon hier bist: Lerne Stäbe bei {npc:11867} ({object:2096}, 10 Silber); die Nahkampfwaffe eines Jägers besteht vor allem aus ihren Werten, und Zweihandwaffen haben davon am meisten.",

	-- Step 116: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Wenn du schon hier bist: Lerne Schwerter bei {npc:11867} ({object:2096}, 10 Silber); ein Schwert in der Haupthand levelt einen Schurken zuverlässig.",

	-- Step 117: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["{npc:5480} trains warriors in {object:2100}, near Osric's shop; the tram from {zone:1455} arrives in the {object:28027}, north of it. {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "{npc:5480} bildet Krieger in {object:2100} aus, nahe Osrics Laden; die Bahn aus {zone:1455} kommt in {object:28027} an, nördlich davon. {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug. Bietet {npc:5480} {quest:1638} nicht an, geh direkt zu {npc:6089}: Er gibt dir {quest:1639} auch ohne.",

	-- Step 118: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne {spell:202} bei {npc:11867} ({object:2096}, 10 Silber); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 119: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Wenn du schon hier bist: Lerne Stäbe bei {npc:11867} ({object:2096}, 10 Silber); ein Stab hat beim Leveln mehr Zauberwerte als eine Einhandwaffe.",

	-- Step 120: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} wartet im Keller von {object:2164} in {object:2101}.",
	-- {quest:1688} Surena Caledon · {zone:1436} Westfall
	["{quest:1688}: her choker and The Binding are on {zone:1436}'s east-Elwynn loop"] = "{quest:1688}: Ihr Halsband und The Binding gehören zur Runde durchs östliche Elwynn im Guide für {zone:1436}",

	-- Step 122: Goldshire
	-- {zone:1453} Stormwind · {area:87} Goldshire · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to {area:87}: east Elwynn comes before {zone:1436}."] = "Verlass {zone:1453} durch das Haupttor und folge der Straße nach Süden bis {area:87}: Das östliche Elwynn kommt vor {zone:1436}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {area:87} and east Elwynn are next, then {zone:1436}."] = "Zurück zu {npc:6122}. Benutze {item:6928} am Beschwörungskreis im Keller des {object:2164} und besiege den Leerwandler, den er ruft. {area:87} und das östliche Elwynn kommen als Nächstes, dann {zone:1436}.",
	-- ["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Klippeneber und Junge Schwarzbären streifen über die Felder um {area:131} und das Depot.",
	-- ["Defensive Stance"] = "Verteidigungshaltung",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Folge der Straße hinauf nach {zone:1455} und trainiere bei deinem Klassenlehrer. {area:2257} fährt von {object:171524} im Osten der Stadt ab. Fahr damit nach {zone:1453}.",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Verlass {zone:1453} durchs Haupttor, geh nach Süden nach {area:87} und auf der Straße nach Osten zu {area:62}. {npc:881} (Stufe 9) steht bei dessen Bauernhaus.",
	-- ["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Schädelhauer der Felsenkiefer füllen den Steinbruch; Wegelagerer der Felsenkiefer bei {area:212} lassen {item:268548} fallen.",
	-- ["Sit by Eric's campfire (type /sit) and wait for the buff."] = "Setz dich an Erics Lagerfeuer (tippe /sit) und warte auf den Segen.",
	-- ["Subdue the voidwalker"] = "Bezwinge den Leerwandler",
	-- ["Summon Voidwalker"] = "Leerwandler beschwören",
	-- ["Tame Beast"] = "Wildtier zähmen",
	-- ["Tame {npc:1126}"] = "Zähme {npc:1126}",
	-- ["Tame {npc:1196}"] = "Zähme {npc:1196}",
	-- ["Tame {npc:1201}"] = "Zähme {npc:1201}",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Die Bahn kommt in {object:28027} an. {npc:5480} bildet Krieger in {object:2100} aus; {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",
	-- ["{npc:10090}: Beast Training"] = "{npc:10090}: Wildtierausbildung",
	-- ["{npc:1127}, on the way"] = "{npc:1127}, auf dem Weg",
	-- ["{npc:1201}, on the way"] = "{npc:1201}, auf dem Weg",
	-- ["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}: {npc:376} in {zone:1453} nimmt sie an",
	-- ["{npc:1241}, below ground: Camping 101, blacksmiths"] = "{npc:1241}, unter der Erde: Camping 101, Schmiede",
	-- ["{npc:12427} kneels wounded on the ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer, on the walk back from Rumbleshot's camp. Cast Lesser Heal (Rank 2) on him, then Power Word: Fortitude: Rank 1 of Lesser Heal does not count."] = "{npc:12427} kniet verwundet auf dem Kamm zwischen zwei niedrigen Mauern gleich südlich von {area:131}, gegenüber dem Tierlehrer der Jäger auf der anderen Straßenseite, auf dem Rückweg von Rumbleshots Lager. Wirke Geringes Heilen (Rang 2) auf ihn, dann Machtwort: Seelenstärke: Rang 1 von Geringes Heilen zählt nicht.",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}, am Depot",
	-- ["{npc:1702}, beside him: Camping 101, engineers"] = "{npc:1702}, neben ihm: Camping 101, Ingenieure",
	-- ["{npc:2326}, inside: Camping 101, {skill:129}"] = "{npc:2326}, drinnen: Camping 101, {skill:129}",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, der Schamanenlehrer, nördlich von {object:32372}",
	-- ["{npc:265813}, blacksmiths: for {npc:1241}"] = "{npc:265813}, Schmiede: für {npc:1241}",
	-- ["{npc:265813}, engineers: for {npc:1702}"] = "{npc:265813}, Ingenieure: für {npc:1702}",
	-- ["{npc:265813}, miners: for {npc:5392}"] = "{npc:265813}, Bergleute: für {npc:5392}",
	-- ["{npc:265813}, {skill:129}: for {npc:2326}"] = "{npc:265813}, {skill:129}: für {npc:2326}",
	-- ["{npc:460}: Summon Imp"] = "{npc:460}: Wichtel beschwören",
	-- ["{npc:5392}: Camping 101, miners"] = "{npc:5392}: Camping 101, Bergleute",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}: Verteidigungshaltung",
	-- ["{zone:1455} class quests"] = "Klassenquests in {zone:1455}",
}
