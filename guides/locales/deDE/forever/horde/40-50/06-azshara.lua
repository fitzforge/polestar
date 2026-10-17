-- German (deDE): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- {area:3317} Revantusk Village · {area:1497} Undercity
	["From {area:3317}'s flight master, fly to the {area:1497}."] = "Flieg vom Flugmeister in {area:3317} nach {area:1497}.",

	-- Step 2: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} steht im {object:36082}.",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:431} Splintertree Post
	["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "Nimm den Zeppelin nach {zone:1454} am Turm vor {zone:1458} und flieg dann zum {area:431}.",

	-- Step 4: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "Reite nach {zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "Reite auf der Straße vom Splintertreeposten aus nach Osten. {npc:11548} wartet am {area:1235} gleich neben der Straße, ein paar Schritte westlich der {area:3137} der Allianz: Komm von Westen und halte dich von den Azshara-Schildwachen und Jarrodenus (Elite) fern.",

	-- Step 5: Highborne and Haldarr satyrs
	["Highborne and Haldarr satyrs"] = "Hochgeborene und Satyrn der Haldarr",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "Die Geister der Hochgeborenen spuken in den Ruinen gleich nördlich des Schreins; die Satyrn der Haldarr lagern etwas weiter nördlich.",

	-- Step 6: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "Zurück zu {npc:11548} am Schrein; bleib westlich der Wachen an der {area:3137}.",

	-- Step 7: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "Folge der Straße nach Norden nach {area:1237}, dem Lager der Horde.",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}, am Ostrand des Lagers: keine Erfahrung, nur ein Teleport zum Azsharaturm",

	-- Step 8: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "Unbeschädigte Hippogryphenfedern",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "Die Donnerkopfhippogryphen fliegen über die Hügel gleich südlich von {area:1237}.",

	-- Step 10: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "Reite nach Nordosten zum Lager des Goblins auf den Klippen über dem Gebiet {area:1227}.",

	-- Step 11: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "Das Lager der Blutelfen liegt gleich südlich von {npc:8420}. Seine vier Ausrüstungsteile liegen in den Kisten im Lager.",

	-- Step 13: Ruins of Eldarath
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "Reite nach Südwesten zu den Ruinen. Die vier Tafeln liegen in den Ruinen, bewacht von Naga der Grollflossen; jede Sirene oder Myrmidone kann die Rune von {npc:8420} tragen.",

	-- Step 14: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "Zurück nach Nordosten zu {npc:8420}.",

	-- Step 15: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "Reite nach Westen zurück nach {area:1237}.",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "Behalte die Lieferungen für {npc:4046}, {npc:8659} und {npc:6522}: Du kommst später durch {zone:1456}, {zone:1454} und {zone:1458}.",

	-- Step 16: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "Der Turm von Xylem steht auf der Klippe gleich nördlich von {area:1237}; der Pfad windet sich an seiner Nordseite hinauf.",

	-- Step 18: To Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["To {object:3202}"] = "Nach {object:3202}",
	-- {area:1237} Valormok · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "Flieg von {area:1237} nach {zone:1454}, geh durch das Haupttor hinaus zu den Zeppelintürmen und nimm den Zeppelin nach {object:3202}.",

	-- Step 19: Grom'gol Base Camp
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay
	["The {object:2076} beside {npc:2519}"] = "Der {object:2076} neben {npc:2519}",

	-- Step 20: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Eisenkieferbasilisken",
	["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Folge der Straße nach Süden; die Basilisken sonnen sich mitten im Dschungel auf den Felsen östlich davon. Ihre Splitter fallen oft.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "Reite weiter nach Süden nach {area:35}. {npc:7406} hat seine Werkstatt auf dem oberen Ring der Bucht.",
	["Only once all three robots are home"] = "Erst wenn alle drei Roboter zu Hause sind",

	-- Step 22: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Zurück nach {object:3202}",

	-- Step 23: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Take the zeppelin back to {zone:1454}."] = "Nimm den Zeppelin zurück nach {zone:1454}.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, die Gasse",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "Behalte die Bezahlung von {npc:8659} und Ag'tors {quest:3504}: Sie gehen bei einem späteren Besuch zurück nach {area:1237}.",

	-- Step 24: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {area:1638}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "Flieg nach {area:1638}; es liegt auf dem Weg nach {area:1099}. Noch keine Flugroute dort? Flieg nach {area:378} und reite nach Westen durch {zone:1412}. Hamuul und {npc:4046} sind im Gebiet {area:1639}; Druiden und Paladine trainieren hier ({npc:3033}, {npc:246344}).",
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761} wird im nächsten Guide gesammelt; {npc:4046}s Bezahlung geht später zurück an {npc:8587}.",

	-- Step 25: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: Die Bären sind im {zone:1448}",
	-- {area:1417} Sunken Temple · {npc:7771} Marvon Rivetseeker · {zone:1446} Tanaris
	["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "Behalte {area:1417} für {npc:7771} in {zone:1446}.",

	-- Step 26: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "Fransenfederhippogryphen",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "Die Hippogryphen nisten auf den Hügeln südwestlich des Lagers. Töte einen und benutze dann das Muisekgefäß an seiner Leiche.",

	-- Step 28: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "Grimmlingflitzer",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "Die Feendrachen schwirren durch den Wald gleich westlich des Lagers. Benutze das Gefäß an jedem, den du tötest.",

	-- Step 30: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "Wandernde Waldgänger",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "Die Treants wandern auf den Waldwegen zwischen dem Lager und der Mitte von {zone:1444}; es gibt nur wenige, also such entlang der Pfade.",

	-- Step 32: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Reite nach Nordwesten zum Ort {area:1108}; {npc:14637} wartet am Steg.",

	-- Step 33: Zapped giants
	["Zapped giants"] = "Geschrumpfte Riesen",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "Die Landgänger und Klippenriesen streifen durch die Hügel nördlich des Stegs. Schrumpfe jeden zuerst mit {item:18904}: Geschrumpft sind sie keine Elite mehr. Jeder geschrumpfte Riese hinterlässt Rückstände; benutze auch das Muisekgefäß an seiner Leiche.",

	-- Step 34: Sea elementals
	["Sea elementals"] = "Meereselementare",
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "Die Meereselementare und Meeresschauer treiben an der Küste rund um den Steg.",

	-- Step 36: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "Zurück nach {area:1099}",

	-- Step 37: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, neben dem Windreitermeister",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "Der Teer für {npc:7876} und Pestlezuggs Proben stammen aus {zone:1449}.",

	-- Step 38: Broken Pillar
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "Reite auf der Straße nach Süden zur {area:1938}; {npc:7771} lagert daneben. Von hier führt die Straße nach Westen hinab in {zone:1449}, wo der nächste Guide beginnt.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "Behalte {quest:3444}: {npc:7771}s Truhe wird bei einem späteren Besuch geöffnet.",
}
