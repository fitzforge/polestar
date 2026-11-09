-- German (deDE): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: To Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["To {object:3202}"] = "Nach {object:3202}",
	-- {area:75} Stonard · {area:117} Grom'gol Base Camp
	["The flight from {area:75} lands at {area:117}."] = "",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Reite weiter nach Süden nach {area:35}. {npc:7406} hat seine Werkstatt auf dem oberen Ring der Bucht.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "",
	["Only once all three robots are home"] = "Erst wenn alle drei Roboter zu Hause sind",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "",

	-- Step 7: The Bloodsail ships
	["The Bloodsail ships"] = "Die Schiffe der Blutsegelbukaniere",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "",

	-- Step 9: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 15: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Zurück nach {object:3202}",

	-- Step 16: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "",
	["Below ground"] = "",

	-- Step 20: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Reite nach {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Reite auf der Straße vom Splintertreeposten aus nach Osten. {npc:11548} wartet am {area:1235} gleich neben der Straße, ein paar Schritte westlich der {area:3137} der Allianz: Komm von Westen und halte dich von den Azshara-Schildwachen und Jarrodenus (Elite) fern.",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Die Geister der Hochgeborenen spuken in den Ruinen gleich nördlich des Schreins; die Satyrn der Haldarr lagern etwas weiter nördlich.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "",

	-- Step 24: Level 50
	["Level 50"] = "",
	-- {quest:4493} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar · {zone:1447} Azshara · {area:2100} Maraudon · {area:1417} Sunken Temple
	["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it. Or, with a group, run the {area:2100} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:6125} Haldarr Satyr
	["grind on {npc:6125}"] = "",

	-- Step 25: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Zurück zu {npc:11548} am Schrein; bleib westlich der Wachen an der {area:3137}.",

	-- Step 26: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Folge der Straße nach Norden nach {area:1237}, dem Lager der Horde.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, am Ostrand des Lagers: keine Erfahrung, nur ein Teleport zum Azsharaturm",

	-- Step 28: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Unbeschädigte Hippogryphenfedern",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Die Donnerkopfhippogryphen fliegen über die Hügel gleich südlich von {area:1237}.",

	-- Step 30: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Reite nach Nordosten zum Lager des Goblins auf den Klippen über dem Gebiet {area:1227}.",

	-- Step 31: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Das Lager der Blutelfen liegt gleich südlich von {npc:8420}. Seine vier Ausrüstungsteile liegen in den Kisten im Lager.",

	-- Step 33: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "",
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Reite nach Südwesten zu den Ruinen. Die vier Tafeln liegen in den Ruinen, bewacht von Naga der Grollflossen; jede Sirene oder Myrmidone kann die Rune von {npc:8420} tragen.",

	-- Step 34: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Zurück nach Nordosten zu {npc:8420}.",

	-- Step 35: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Reite nach Westen zurück nach {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Behalte die Lieferungen für {npc:4046}, {npc:8659} und {npc:6522}: Du kommst später durch {zone:1456}, {zone:1454} und {zone:1458}.",

	-- Step 36: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "Der Turm von Xylem steht auf der Klippe gleich nördlich von {area:1237}; der Pfad windet sich an seiner Nordseite hinauf.",
	["Upstairs"] = "",

	-- Step 38: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 39: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, die Gasse",

	-- Step 40: Orgrimmar
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Behalte die Bezahlung von {npc:8659} und Ag'tors {quest:3504}: Sie gehen bei einem späteren Besuch zurück nach {area:1237}.",

	-- Step 41: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 42: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 43: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Flieg nach {zone:1456}; es liegt auf dem Weg nach {area:1099}. Noch keine Flugroute dort? Flieg nach {area:378} und reite nach Westen durch {zone:1412}. Hamuul und {npc:4046} sind im Gebiet {area:1639}; Druiden und Paladine trainieren hier ({npc:3033}, {npc:246344}).",

	-- Step 44: Class trainer
	["Class trainer"] = "",

	-- Step 45: Thunder Bluff
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} wird im nächsten Guide gesammelt; {npc:4046}s Bezahlung geht später zurück an {npc:8587}.",

	-- Step 46: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 47: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: Die Bären sind im {zone:1448}",

	-- Step 48: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Fransenfederhippogryphen",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Die Hippogryphen nisten auf den Hügeln südwestlich des Lagers. Töte einen und benutze dann das Muisekgefäß an seiner Leiche.",

	-- Step 50: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Grimmlingflitzer",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Die Feendrachen schwirren durch den Wald gleich westlich des Lagers. Benutze das Gefäß an jedem, den du tötest.",

	-- Step 52: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Wandernde Waldgänger",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Die Treants wandern auf den Waldwegen zwischen dem Lager und der Mitte von {zone:1444}; es gibt nur wenige, also such entlang der Pfade.",

	-- Step 55: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "",

	-- Step 57: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Zurück nach {area:1099}",

	-- Step 58: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 59: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, neben dem Windreitermeister",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Der Teer für {npc:7876} und Pestlezuggs Proben stammen aus {zone:1449}.",

	-- Step 60: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Reite auf der Straße nach Süden zur {area:1938}; {npc:7771} lagert daneben. Von hier führt die Straße nach Westen hinab in {zone:1449}, wo der nächste Guide beginnt.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Behalte {quest:3444}: {npc:7771}s Truhe wird bei einem späteren Besuch geöffnet.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Flieg von {area:1237} nach {zone:1454}, geh durch das Haupttor hinaus zu den Zeppelintürmen und nimm den Zeppelin nach {object:3202}.",
	-- ["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Folge der Straße nach Süden; die Basilisken sonnen sich mitten im Dschungel auf den Felsen östlich davon. Ihre Splitter fallen oft.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "Flieg vom Flugmeister in {area:3317} nach {area:1497}.",
	-- ["Highborne and Haldarr satyrs"] = "Hochgeborene und Satyrn der Haldarr",
	-- ["Ironjaw Basilisks"] = "Eisenkieferbasilisken",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Behalte {area:1417} für {npc:7771} in {zone:1446}.",
	-- ["Ride into {area:16}"] = "Reite nach {area:16}",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Reite nach Nordwesten zum Ort {area:1108}; {npc:14637} wartet am Steg.",
	-- ["Sea elementals"] = "Meereselementare",
	-- ["Take the zeppelin back to {zone:1454}."] = "Nimm den Zeppelin zurück nach {zone:1454}.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Nimm den Zeppelin nach {zone:1454} am Turm vor {zone:1458} und flieg dann zum {area:431}.",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Die Landgänger und Klippenriesen streifen durch die Hügel nördlich des Stegs. Schrumpfe jeden zuerst mit {item:18904}: Geschrumpft sind sie keine Elite mehr. Jeder geschrumpfte Riese hinterlässt Rückstände; benutze auch das Muisekgefäß an seiner Leiche.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Die Meereselementare und Meeresschauer treiben an der Küste rund um den Steg.",
	-- ["The {object:2076} beside {npc:2519}"] = "Der {object:2076} neben {npc:2519}",
	-- ["Zapped giants"] = "Geschrumpfte Riesen",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: Die Bären sind im {zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825} steht im {object:36082}.",
}
