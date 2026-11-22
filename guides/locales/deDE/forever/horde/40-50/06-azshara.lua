-- German (deDE): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "Flugmeister in {area:75}",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "Der Flug von {area:75} landet auf dem Oberdeck von {area:35}. {npc:7406} hat seine Werkstatt auf dem oberen Ring der Bucht.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, drinnen",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, im Gasthaus",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley, on the top floor: Stoley's shipment from {zone:1446}"] = "„Sea Wolf“ MacKinley, im obersten Stock: Stoleys Lieferung aus {zone:1446}",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}, auf dem Balkon desselben Gebäudes",

	-- Step 4: The Bloodsail ships
	["The Bloodsail ships"] = "Die Schiffe der Blutsegelbukaniere",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "Südlich von Booty Bay liegen drei Schiffe der Bloodsail vor {area:43}: {npc:2550}, {npc:2548} und {npc:2546} stehen jeweils mit ihrer Besatzung auf einem Deck. Schwimm hinaus und arbeite dich von Schiff zu Schiff.",

	-- Step 6: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {quest:8552} braucht eine Gruppe von 2. Überspring sie, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 12: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "Der Flug landet bei {area:117}; {npc:2497} steht bei {object:2076}.",

	-- Step 13: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Zurück nach {object:3202}",

	-- Step 14: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "Das sind Elite-Mobs: Sich zu gruppieren ist empfohlen, such dir Leute dafür. {npc:818} (Elite, Stufe 47) braucht eine Gruppe von 2. Überspring ihn, wenn du allein bist: Die Route lässt dich die EP wieder erarbeiten.\nVorsicht: Zwei Elite-Zauberwirker-Wachen, ungefähr Stufe 45, stehen bei {npc:818} und greifen gemeinsam mit ihm in den Kampf ein.",
	["Below ground"] = "Unter der Erde",

	-- Step 18: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 19: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}."] = "Geh auf dem Weg durch {zone:1454} zum Flugmeister in die Gasse: {npc:7010} nimmt den Insektenbericht aus {zone:1446} an.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, die Gasse",

	-- Step 20: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1447} Azshara · {area:1237} Valormok
	["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, it waits: if you reach 50 in {zone:1447}, this guide brings you back for it from {area:1237}; else the {zone:1447} guide at 55 offers it again."] = "",

	-- Step 21: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "Der Laden der Droffers ist ein paar Schritte weiter in der Gasse.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, die Gasse",

	-- Step 22: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow · {quest:4300} Bone-Bladed Weapons · {zone:1447} Azshara
	["{npc:8659}, in the {object:172960}, has {quest:4300} for later; then your class trainer before you leave for {zone:1447}."] = "",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 23: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {object:172957} Valley of Wisdom · {npc:4791} Nazeer Bloodpike · {zone:1445} Dustwallow Marsh
	["{npc:4047} stands in the {object:172957}: {npc:4791}'s report from {zone:1445}."] = "",

	-- Step 25: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Reite nach {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Reite auf der Straße vom Splintertreeposten aus nach Osten. {npc:11548} wartet am {area:1235} gleich neben der Straße, ein paar Schritte westlich der {area:3137} der Allianz: Komm von Westen und halte dich von den Azshara-Schildwachen und Jarrodenus (Elite) fern.",

	-- Step 26: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}: töte diese, wenn du sie triffst",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Die Geister der Hochgeborenen spuken in den Ruinen gleich nördlich des Schreins; die Satyrn der Haldarr lagern etwas weiter nördlich.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117} läuft um {area:1235} herum: schau in den Kreis auf der Karte",

	-- Step 27: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Zurück zu {npc:11548} am Schrein; bleib westlich der Wachen an der {area:3137}.",

	-- Step 28: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Folge der Straße nach Norden nach {area:1237}, dem Lager der Horde.",

	-- Step 29: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {zone:1447} Azshara · {area:1637} Orgrimmar · {quest:4493} March of the Silithid · {zone:1456} Thunder Bluff
	["You reached 50 in {zone:1447}: fly back to {area:1637} for {quest:4493} and your level 50 training, then on to {zone:1456}."] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Flugmeister in {area:1237}",

	-- Step 30: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} is in the Drag; your class trainer next."] = "",

	-- Step 31: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 33: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and Magatha are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Flieg nach {zone:1456}; es liegt auf dem Weg nach {area:1099}. Noch keine Flugroute dort? Flieg nach {area:378} und reite nach Westen durch {zone:1412}. Hamuul und Magatha sind im Gebiet {area:1639}; Druiden und Paladine trainieren hier ({npc:3033}, {npc:246344}).",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "{npc:6746}, im Gasthaus: für Hamuul",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}, auf der {area:1639}",

	-- Step 34: Thunder Bluff
	-- {quest:3761} Un'Goro Soil
	["{quest:3761} is gathered in the next guide."] = "{quest:3761} wird im nächsten Guide gesammelt.",

	-- Step 35: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 36: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i
	["{npc:8115}, if you don't carry it yet: the materials come on this loop"] = "",
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: Die Bären sind im {zone:1448}",
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}: the Northspring harpies, at the far end of this loop"] = "",

	-- Step 37: Talo Thornhoof
	-- {quest:3062} Dark Heart · {npc:8075} Edana Hatetalon
	["{quest:3062}: {npc:8075} (level 50, elite) roosts above the Northspring harpies this loop ends at. Grouping up is advised: skip it if you are alone."] = "",

	-- Step 38: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Fransenfederhippogryphen",
	-- {quest:3128} Natural Materials
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body. Nearly every one also drops the sinew and metallic fragments for {quest:3128}."] = "",

	-- Step 39: Hippogryph nests
	["Hippogryph nests"] = "Hippogryphennester",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "Die Hippogryphennester liegen auf den Hügeln im Süden, rund um {area:2522}; jedes enthält ein Ei für den {object:142071}.",

	-- Step 41: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Grimmlingflitzer",
	-- {item:9589} Encrusted Minerals
	-- was: ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Die Feendrachen schwirren durch den Wald gleich westlich des Lagers. Benutze das Gefäß an jedem, den du tötest."
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill; they carry the {item:9589} too."] = "",

	-- Step 43: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Wandernde Waldgänger",
	-- {zone:1444} Feralas · {npc:272401} Vale Screamer
	-- plural, as words: Splintered Logs = {item:9590} Splintered Log
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths. They carry the Splintered Logs too.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "",

	-- Step 45: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	-- was: ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Reite nach Nordwesten zum Ort {area:1108}; {npc:14637} wartet am Steg."
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "",

	-- Step 46: Forgotten Coast: the water and the shore
	-- {area:1108} Forgotten Coast
	["{area:1108}: the water and the shore"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-48) wash along the shore just south of the dock and drop the Water Elemental Cores, as the Sea Elementals (47-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: {npc:14637} has a second round once these are done."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, von den Meeresschauern",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, auf die Wellen- und Tiefenschreiter im Wasser",

	-- Step 48: Forgotten Coast: the giants' hills
	-- {area:1108} Forgotten Coast
	["{area:1108}: the giants' hills"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	-- was: ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Die Sea Elementals und Sea Sprays werden rund um das Dock an den Strand gespült.\nDie Land Walkers und Cliff Giants streifen durch die Hügel nördlich des Docks. Zappe jeden zuerst mit {item:18904}: Geschrumpft sind sie keine Elite mehr. Jeder gezappte Riese lässt Rückstände fallen; benutze das Muisek Vessel auch an seinem Körper."
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too.\nThe Sea Elementals and Sea Sprays along the shore have the last cores."] = "",

	-- Step 50: Northspring harpies
	["Northspring harpies"] = "Harpyien der Nordschwingen",
	["The Northspring harpies nest on the ridges in the far north-west, past the giants' hills. The Windcallers heal, so kill them first and pull one at a time."] = "Die Harpyien der Northspring nisten auf den Graten ganz im Nordwesten, hinter den Hügeln der Riesen. Die Windrufer heilen, also töte sie zuerst und zieh sie einzeln.",

	-- Step 51: Edana Hatetalon
	-- {npc:8075} Edana Hatetalon
	["{npc:8075} (level 50, elite) roosts on the cliff just north of the harpies' nests. Clear the harpies around her first."] = "",

	-- Step 52: Rage Scar yetis
	["Rage Scar yetis"] = "Wutschrammyetis",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east towards the camp, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, eine seltene Beute",

	-- Step 53: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Zurück nach {area:1099}",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, drinnen",

	-- Step 55: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Flugmeister in {area:1099}",

	-- Step 56: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, drinnen",

	-- Step 58: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, neben dem Windreitermeister",

	-- Step 59: The Egg-O-Matic
	-- {object:142071} Egg-O-Matic
	["The {object:142071}"] = "Der {object:142071}",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "Der {object:142071}, mitten im Ort",

	-- Step 60: Marin Noggenfogger
	-- {zone:1449} Un'Goro Crater
	["Pestlezugg's samples come from {zone:1449}."] = "Pestlezuggs Proben stammen aus {zone:1449}.",

	-- Step 61: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Reite auf der Straße nach Süden zur {area:1938}; {npc:7771} lagert daneben. Von hier führt die Straße nach Westen hinab in {zone:1449}, wo der nächste Guide beginnt.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Behalte {quest:3444}: {npc:7771}s Truhe wird bei einem späteren Besuch geöffnet.",

	-- Step 62: The Dunemaul Compound
	-- {area:1938} Broken Pillar · {npc:12046} Gor'marok the Ravager · {npc:11758} Andi Lynn · {zone:1446} Tanaris
	["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, if you still carry it from {zone:1446}."] = "",

	-- Step 63: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley · {npc:7876} Tran'rek · {zone:1446} Tanaris · {area:976} Gadgetzan
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	-- was: ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "Westlich des Lagers, auf dem Weg zur Rampe nach Un'Goro: Die Knorrigen Distelwandler und Wurzelformer (48-50) für {quest:3362} gehören zu {npc:7876}, mitgebracht von deinem ersten Besuch in {zone:1446}. Sie wandern viel umher: Zieh sie einzeln. {npc:7876} nimmt sie beim Halt in {area:976} im nächsten Guide entgegen, zusammen mit der von {npc:11758}."
	["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (49-50) are {npc:7876}'s, carried from your second {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",
	-- ["Back north-east to {npc:8420}."] = "Zurück nach Nordosten zu {npc:8420}.",
	-- ["Class trainer"] = "Klassenlehrer",
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Flieg von {area:1237} nach {zone:1454}, geh durch das Haupttor hinaus zu den Zeppelintürmen und nimm den Zeppelin nach {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- ["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Flieg nach {zone:1456}; es liegt auf dem Weg nach {area:1099}. Noch keine Flugroute dort? Flieg nach {area:378} und reite nach Westen durch {zone:1412}. Hamuul und {npc:4046} sind im Gebiet {area:1639}; Druiden und Paladine trainieren hier ({npc:3033}, {npc:246344}).",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Folge der Straße nach Süden; die Basilisken sonnen sich mitten im Dschungel auf den Felsen östlich davon. Ihre Splitter fallen oft.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "Flieg vom Flugmeister in {area:3317} nach {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Hochgeborene und Satyrn der Haldarr",
	-- ["Ironjaw Basilisks"] = "Eisenkieferbasilisken",
	-- ["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Behalte die Lieferungen für {npc:4046}, {npc:8659} und {npc:6522}: Du kommst später durch {zone:1456}, {zone:1454} und {zone:1458}.",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Behalte {area:1417} für {npc:7771} in {zone:1446}.",
	-- ["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Behalte die Bezahlung von {npc:8659} und Ag'tors {quest:3504}: Sie gehen bei einem späteren Besuch zurück nach {area:1237}.",
	-- ["Level 50"] = "Stufe 50",
	-- ["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "Geh auf dem Weg durch {zone:1454} zum Flugmeister in die Gasse: {npc:7010} nimmt den Insektenbericht aus {zone:1446} an, und dessen Erfahrung verkürzt das Auffüllen auf 50 in {zone:1447}.",
	-- ["Only once all three robots are home"] = "Erst wenn alle drei Roboter zu Hause sind",
	-- ["Paladin trainer"] = "Paladinlehrer",
	-- ["Ride into {area:16}"] = "Reite nach {area:16}",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Reite nach Nordosten zum Lager des Goblins auf den Klippen über dem Gebiet {area:1227}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Reite nach Nordwesten zum Ort {area:1108}; {npc:14637} wartet am Steg.",
	-- ["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Reite nach Südwesten zu den Ruinen. Die vier Tafeln liegen in den Ruinen, bewacht von Naga der Grollflossen; jede Sirene oder Myrmidone kann die Rune von {npc:8420} tragen.",
	-- ["Ride west back to {area:1237}."] = "Reite nach Westen zurück nach {area:1237}.",
	-- ["Sea elementals"] = "Meereselementare",
	-- ["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, carried from your first {zone:1446} visit."] = "Südlich der {area:1938} haben die Oger der Dunemaul ihr Lager, mit {npc:12046} am östlichen Ende: die Quest von {npc:11758}, mitgebracht von deinem ersten Besuch in {zone:1446}.",
	-- ["Take the zeppelin back to {zone:1454}."] = "Nimm den Zeppelin zurück nach {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Nimm den Zeppelin nach {zone:1454} am Turm vor {zone:1458} und flieg dann zum {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Die Landgänger und Klippenriesen streifen durch die Hügel nördlich des Stegs. Schrumpfe jeden zuerst mit {item:18904}: Geschrumpft sind sie keine Elite mehr. Jeder geschrumpfte Riese hinterlässt Rückstände; benutze auch das Muisekgefäß an seiner Leiche.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Die Meereselementare und Meeresschauer treiben an der Küste rund um den Steg.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Die Sea Elementals und Sea Sprays werden rund um das Dock an den Strand gespült.\nDie Land Walkers und Cliff Giants streifen durch die Hügel nördlich des Docks. Zappe jeden zuerst mit {item:18904}: Geschrumpft sind sie keine Elite mehr. Jeder gezappte Riese lässt Rückstände fallen; benutze das Muisek Vessel auch an seinem Körper.",
	-- ["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Die Donnerkopfhippogryphen fliegen über die Hügel gleich südlich von {area:1237}.",
	-- ["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Das Lager der Blutelfen liegt gleich südlich von {npc:8420}. Seine vier Ausrüstungsteile liegen in den Kisten im Lager.",
	-- ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Die Feendrachen schwirren durch den Wald gleich westlich des Lagers. Benutze das Gefäß an jedem, den du tötest.",
	-- ["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Die Hippogryphen nisten auf den Hügeln südwestlich des Lagers. Töte einen und benutze dann das Muisekgefäß an seiner Leiche.",
	-- ["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Die Treants wandern auf den Waldwegen zwischen dem Lager und der Mitte von {zone:1444}; es gibt nur wenige, also such entlang der Pfade.",
	-- ["The {object:2076} beside {npc:2519}"] = "Der {object:2076} neben {npc:2519}",
	-- ["To {object:3202}"] = "Nach {object:3202}",
	-- ["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it."] = "Hol hier Stufe 50 auf: {quest:4493} von {npc:7010} in {zone:1454} am Ende von {zone:1447} braucht sie.",
	-- ["Undamaged Hippogryph Feathers"] = "Unbeschädigte Hippogryphenfedern",
	-- ["Upstairs"] = "Oben",
	-- ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "Westlich des Lagers, auf dem Weg zur Rampe nach Un'Goro: Die Knorrigen Distelwandler und Wurzelformer (48-50) für {quest:3362} gehören zu {npc:7876}, mitgebracht von deinem ersten Besuch in {zone:1446}. Sie wandern viel umher: Zieh sie einzeln. {npc:7876} nimmt sie beim Halt in {area:976} im nächsten Guide entgegen, zusammen mit der von {npc:11758}.",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "Der Turm von Xylem steht auf der Klippe gleich nördlich von {area:1237}; der Pfad windet sich an seiner Nordseite hinauf.",
	-- ["Zapped giants"] = "Geschrumpfte Riesen",
	-- ["grind on {npc:6125}"] = "grinde {npc:6125}",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: Töte diese, sobald sie dir begegnen",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221}: töte diese, wenn du sie triffst",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} in {zone:1456}; in {zone:1454} gibt es keinen Paladin-Lehrer",
	-- ["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}, die Gasse: falls du ihn noch dabeihast",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: Die Bären sind im {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} steht im {object:36082}.",
	-- ["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Der Teer für {npc:7876} und Pestlezuggs Proben stammen aus {zone:1449}.",
	-- ["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, am Ostrand des Lagers: keine Erfahrung, nur ein Teleport zum Azsharaturm",
	-- ["{object:3202} flight master"] = "Flugmeister von {object:3202}",
	-- ["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} wird im nächsten Guide gesammelt; {npc:4046}s Bezahlung geht später zurück an {npc:8587}.",
	-- ["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, the {zone:1447} guide at 55 offers it again."] = "{quest:4494} erfordert Stufe 50: {npc:7010} in der Gasse gibt sie ab dann. Unter 50 bietet der Guide für {zone:1447} mit 55 sie erneut an.",
}
