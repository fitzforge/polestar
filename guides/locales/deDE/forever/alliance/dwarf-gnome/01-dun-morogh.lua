-- German (deDE): the guide forever/alliance/dwarf-gnome/01-dun-morogh (forever/alliance/dwarf-gnome/01-dun-morogh.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["{npc:912}, the warrior trainer"] = "{npc:912}, der Kriegerlehrer",
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
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, der Magierlehrer, in {area:77}",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, in {area:77}",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "In {area:77}",

	-- Step 4: The troggs
	["The troggs"] = "Die Troggs",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "Troggs der Felsenkiefer und Bullige Troggs der Felsenkiefer graben überall auf dem Talboden südlich von {area:77}.",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "Zurück nach {area:77}",
	["A few more troggs outside if you are short"] = "Draußen noch ein paar Troggs, falls dir welche fehlen",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}"] = "{npc:8416}, an der Tür von {area:77}",

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
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["A few Frostmane Troll Whelps if you are short"] = "Ein paar Trollwelpen der Frostmane, falls dir welche fehlen",

	-- Step 10: The troll cave
	["The troll cave"] = "Die Trollhöhle",
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
	["{npc:836}, inside {area:77}"] = "{npc:836}, in {area:77}",
	["Level 4 spells, before Gozwin's camp"] = "Zauber der Stufe 4, vor Gozwins Lager",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out"] = "",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} steht bei {npc:8416} an der Tür von {area:77}. Gozwins Lager liegt in den Hügeln gleich nordwestlich; {npc:269075} schleicht darum herum.",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, im Lager",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} ist in der Trollhöhle östlich von {npc:786}s Lager, nicht auf dem Hügel darüber: Geh am Eingang hinein und folge dem Tunnel bis ganz nach hinten.",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, neben ihm",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "Eiskrallenbärenanhänger, von den Trollwelpen der Frostmane an den Hängen über dem Lager",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "Zurück zu {npc:257446} in {area:77}. Er gibt dir {item:6635}: Nimm den mit Geröll markierten Pfad, der im Süden des Tals nach Westen zum Geisterstein auf dem Grat hinaufführt, trink das Sapta daneben und sprich mit {npc:5891}, dann bring {item:6656} zurück zu Teo.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, neben dem Geisterstein",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}: {npc:5873} und dein {item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "Der Tunnel",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965} bewacht den Tunnel aus dem Tal, östlich von {area:77}; {npc:6782} steht neben ihm am Eingang.",

	-- Step 18: Kharanos
	-- {area:131} Kharanos · {npc:1267} Ragnar Thunderbrew · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}."] = "",

	-- Step 19: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "",

	-- Step 20: Tharek Blackstone
	-- {npc:1872} Tharek Blackstone
	["{npc:1872} works the forge west of the distillery."] = "",

	-- Step 21: Thunderbrew Distillery
	-- {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Then go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}"] = "{item:2894}, von {npc:1247}",
	["Last: some classes' trainers stand outside"] = "",

	-- Step 22: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Folge der Straße von {area:131} nach Nordosten zum Depot unterhalb der Straße nach {zone:1455}.",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "",

	-- Step 23: Boars and bears
	["Boars and bears"] = "Eber und Bären",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Klippeneber und Junge Schwarzbären streifen über die Felder um {area:131} und das Depot.",

	-- Step 24: Kharanos
	-- {npc:1699} Gremlock Pilsnor · {skill:185} Cooking · {npc:1267} Ragnar Thunderbrew
	["Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it"] = "",
	-- {npc:1699} Gremlock Pilsnor
	["Speak with {npc:1699}"] = "Sprich mit {npc:1699}",

	-- Step 26: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "",

	-- Step 27: The Grizzled Den
	-- {object:460004} Mountaineer Cornelius (no name in this language: may be words)
	["Flintfire's shipments lie on the cave floor, and {object:460004} is missing somewhere inside."] = "",

	-- Step 29: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den · {npc:1243} Hegnar Rumbleshot
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}; {npc:1243} camps south-west of it, by the road to Coldridge."] = "{object:176785} steht neben {npc:271546}, südlich von {area:136}; {npc:1243} lagert südwestlich davon, an der Straße nach Coldridge.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}: {object:176785}",

	-- Step 30: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131} und das Depot",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, at the depot"] = "{npc:1377}, am Depot",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, by the depot"] = "{npc:1269}, beim Depot",

	-- Step 31: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "",

	-- Step 32: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "",

	-- Step 33: Gnomes, bears and leopards
	["Gnomes, bears and leopards"] = "Gnome, Bären und Leoparden",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "Lepragnome um Brewnall und an der Straße nach {area:133} tragen die Zahnräder und Getriebe. Eisklauenbären, Alte Klippeneber und Schneeleoparden streifen durch die Hügel um den See.",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}: Lepragnome",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}: Lepragnome",

	-- Step 36: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373} bewacht die Fässer mit {item:2686} im Keller der Brauerei. Kauf {item:2686} bei {npc:1247}, klick das bewachte Fass an und gib das Ale dann über sein Questfenster an {npc:1373} (es gibt keine Quest anzunehmen); danach nimmt das unbewachte Fass {spell:8553} auf.",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery"] = "{item:2686}, von {npc:1247} in der Brauerei",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "{object:269} im Keller",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel"] = "{npc:1373}, neben dem Fass",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery"] = "{object:270} in der Brauerei",

	-- Step 38: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "Folge der Straße nach Osten am Depot vorbei nach {area:138}.",

	-- Step 39: Firewood
	["Firewood"] = "Feuerholz",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "Das Feuerholz liegt im Schnee um den gefrorenen See bei der Zuflucht.",

	-- Step 41: The cold
	["The cold"] = "Die Kälte",
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["Minor Ice Elementals drift around the frozen lake by the refuge. The three rifles are in the snow around it."] = "Kleine Eiselementare treiben um den gefrorenen See bei der Zuflucht. Die drei Gewehre liegen im Schnee drumherum.",

	-- Step 43: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325} ist am gefrorenen See, zwischen den Eiselementaren.",

	-- Step 46: Gol'Bolar Quarry
	["The quarry lies south-east of the ranch."] = "Der Steinbruch liegt südöstlich der Ranch.",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: nur für Schmiede",

	-- Step 47: The quarry troggs
	["The quarry troggs"] = "Die Troggs im Steinbruch",
	-- {area:212} Helm's Bed Lake · {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper · Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher
	["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Schädelhauer der Felsenkiefer füllen den Steinbruch; Wegelagerer der Felsenkiefer bei {area:212} lassen {item:268548} fallen.",

	-- Step 48: Foreman Stonebrow and Quarrymaster Thesten
	-- {npc:1254} Foreman Stonebrow · {npc:1256} Quarrymaster Thesten
	["{npc:1254} and {npc:1256}"] = "{npc:1254} und {npc:1256}",

	-- Step 49: Stolen Blasting Powder
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}."] = "Wegelagerer der Felsenkiefer bei {area:212}, nördlich des Steinbruchs, und Kreuzbrecher der Felsenkiefer weiter östlich lassen {quest:95214} fallen.",

	-- Step 50: Leopards and boars
	["Leopards and boars"] = "Leoparden und Eber",
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Blacksmiths = {area:3421} Blacksmith · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Schneeleoparden und Eber streifen durch den Schnee zwischen der Ranch und dem Steinbruch. Schmiede: Kupferbarren bekommst du durch Verhütten von {item:2770} oder bei den Handwerkshändlern.",

	-- Step 53: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960} wartet bei {area:808}; die Zwergenleiche liegt weiter oben am Pass westlich von ihm.",

	-- Step 54: Hearth to Kharanos
	-- {area:131} Kharanos
	["Hearth to {area:131}"] = "Ruhestein nach {area:131}",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}, bei der Schmiede",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: {npc:257597} beim Südtor nimmt sie an",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}: {npc:376} in {zone:1453} nimmt sie an",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}: {npc:258785} in {zone:1455} nimmt sie an",

	-- Step 55: Taming the Beast
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

	-- Step 56: Shimmerweed
	-- {item:2676} Shimmerweed · {area:137} Brewnall Village
	["{item:2676} bushes grow on the hills around {area:137}."] = "Büsche mit {item:2676} wachsen auf den Hügeln um {area:137}.",

	-- Step 59: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "Folge der Straße ganz nach Osten zu {area:806} am Tunnel nach {zone:1432}.",

	-- Step 60: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} wartet in einer Höhle über dem Hof nordwestlich von {area:806}; der Pfad hinauf beginnt hinter dem Hof.",

	-- Step 61: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "Geh durch den Tunnel nach {zone:1432}. Gleich dahinter führt rechts der Straße ein mit Steinen markierter Pfad nach Norden die Hügel hinauf zu {npc:257808}s Lager.",

	-- Step 62: Fire Tar and the Reagent Pouch
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

	-- Step 63: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "Der Geisterstein des Feuers",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} gibt dir {item:6636}. Klettere auf den Gipfel über seinem Lager, trink das Sapta neben dem Geisterstein und besiege {npc:5893}, dann leg {item:6655} in {object:61934} oben auf dem Schrein der Ewigen Flamme.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, neben dem Geisterstein",

	-- Step 64: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "Zurück zu {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Zurück durch den Tunnel zu {npc:257597}' Höhle über dem Hof.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, dein {item:5176} und {item:263412}",

	-- Step 65: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen lagert auf dem Grat, der von Westen auf {area:134} blickt. Sprich mit ihm für seine Fernsicht.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, im Steinbruch",

	-- Step 66: Spies and Bonesnappers
	["Spies and Bonesnappers"] = "Spione und Knochenknacker",
	-- {area:212} Helm's Bed Lake · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Bonesnappers = {npc:1117} Rockjaw Bonesnapper
	["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "Knochenknacker der Felsenkiefer streifen durch den Steinbruch und um {area:212}; Spione der Dunkeleisenzwerge schleichen am Seeufer umher. Ein Spion lässt {item:274268} fallen.",

	-- Step 69: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave to the north-east of his camp: grab them and leave quickly."] = "{npc:1266} lagert in {area:801}, südlich von Brewnall. Sein Fleisch liegt im Spind in der Höhle von {npc:1271} nordöstlich seines Lagers: Schnapp es dir und verschwinde schnell.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker"] = "{item:2667}: der Fleischspind",

	-- Step 70: The Tome of Divinity
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "Folge der Straße hinauf nach {zone:1455} und nimm {object:32362}: {npc:5149}, {npc:6179} und {npc:6178} sind in {object:32386}. {npc:6175}, ein Bettler, wandert durch die Stadt. Er will zehn {item:2589}: Die Troggs und Trolle in {zone:1426} lassen es fallen, und das Auktionshaus verkauft es.",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "Aus {quest:2997}, den sie dir gibt",

	-- Step 71: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "Reite zurück aus {zone:1455} hinaus und auf der Straße nach Osten zu {area:212}. {npc:6177} liegt tot an dessen Ufer: Benutze {item:6866} an ihm. Die Spione der Dunkeleisenzwerge, die um den See schleichen, tragen die Schrift.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "Benutze {item:6866} an {npc:6177}",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Spione der Dunkeleisenzwerge",

	-- Step 72: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}: Erlösung",

	-- Step 73: Ironforge class quests
	-- {zone:1455} Ironforge
	["{zone:1455} class quests"] = "Klassenquests in {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern
	["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090} ist in {object:32390}, {npc:258785} in {object:32386}, {npc:6120} in {object:32383}.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {npc:6122} in {zone:1453} nimmt sie an",

	-- Step 74: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Folge der Straße hinauf nach {zone:1455} und trainiere bei deinem Klassenlehrer. {area:2257} fährt von {object:171524} im Osten der Stadt ab. Fahr damit nach {zone:1453}.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, beim Briefkasten in {object:171524}",
	-- {npc:258098} Eldrun Stormbreaker · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, der Schamanenlehrer, nördlich von {object:32372}",

	-- Step 75: Defensive Stance
	-- {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Die Bahn kommt in {object:28027} an. {npc:5480} bildet Krieger in {object:2100} aus; {npc:6089} und {npc:6090} stehen dort zusammen bei {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",

	-- Step 76: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376} ist in der Kathedrale des Lichts.",

	-- Step 77: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} wartet im Keller von {object:2164} in {object:2101}.",

	-- Step 78: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Verlass {zone:1453} durchs Haupttor, geh nach Süden nach {area:87} und auf der Straße nach Osten zu {area:62}. {npc:881} (Stufe 9) steht bei dessen Bauernhaus.",

	-- Step 79: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall · {area:87} Goldshire
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "Zurück zu {npc:6122}. Benutze {item:6928} am Beschwörungskreis im Keller von {object:2164} und besiege den herbeigerufenen Leerwandler. Als Nächstes {zone:1436}, westlich von {area:87}.",
	["Subdue the voidwalker"] = "Bezwinge den Leerwandler",

	-- Step 80: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} steht im Wizard's Sanctum, dem Turm in {object:2101}; sie gibt dir eine Flasche für den Wasserfall von {quest:1861}.",

	-- Step 81: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Verlass {zone:1453} durchs Haupttor. Der Wasserfall von {quest:1861} liegt südwestlich der Tore, auf dem Weg nach Westen nach {zone:1436}: Füll {item:7207} an seinem Fuß.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Braldir gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of {object:148418}."] = "Braldir gibt dir {item:6636}. Klettere auf den Gipfel über seinem Lager, trink das Sapta neben dem Geisterstein und besiege {npc:5893}, dann leg {item:6655} in {object:61934} oben auf dem Schrein von {object:148418}.",
	-- ["Cornelius is missing in the {area:136}: find him inside, then go back to Gretchen."] = "Cornelius wird in {area:136} vermisst: Finde ihn drinnen und geh dann zurück zu Gretchen.",
	-- ["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. {npc:1252}, Eric and his campfire are outside the {area:2102}. {npc:6806}, {npc:1226} and {npc:1267} are inside. {npc:1872} works the forge."] = "Folge der Straße durch den Tunnel und nach Nordosten nach {area:131}. Töte unterwegs die Klippeneber: Ihre Rippchen fallen schon, bevor du {npc:1267}s Quest hast, und zählen dafür. {npc:1252}, Eric und sein Lagerfeuer sind vor {area:2102}. {npc:6806}, {npc:1226} und {npc:1267} sind drinnen. {npc:1872} arbeitet an der Schmiede.",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "Verlass {zone:1453} durchs Haupttor, geh nach Süden nach {area:87} und auf der Straße nach Osten zu {area:62}. {quest:1688} (Stufe 9) steht bei dessen Bauernhaus.",
	-- ["Sit by Eric's campfire (type /sit) and wait for the buff, then {npc:1699} in the distillery teaches you cooking."] = "Setz dich an Erics Lagerfeuer (gib /sit ein) und warte auf den Buff, dann bringt dir {npc:1699} in der Brauerei Kochen bei.",
	-- ["The ammo crate sits in the Frostmane camp on {area:802}; {npc:1243} camps south of it, by the road to Coldridge."] = "Die Munitionskiste steht im Lager der Frostmane auf {area:802}; {npc:1243} lagert südlich davon, an der Straße ins Coldridgetal.",
	-- ["{area:135} is the troll cave in the hills west of {area:137}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135} ist die Trollhöhle in den Hügeln westlich von {area:137}. Töte Kopfjäger der Frostmane an ihrem Eingang und geh bis zu ihrem hinteren Ende durch.",
	-- ["{area:137} sits on the lake north-west of {area:135}."] = "{area:137} liegt am See nordwestlich von {area:135}.",
	-- ["{npc:1226}, next to {npc:6806}"] = "{npc:1226}, neben {npc:6806}",
	-- ["{npc:6806}, in the distillery"] = "{npc:6806}, in der Brauerei",
	-- ["{quest:313} is the wendigo cave south-west of {area:131}. Flintfire's shipments lie on the cave floor."] = "{quest:313} ist die Wendigohöhle südwestlich von {area:131}. Flintfires Lieferungen liegen auf dem Höhlenboden.",
}
