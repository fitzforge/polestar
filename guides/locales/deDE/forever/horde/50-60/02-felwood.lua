-- German (deDE): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1422} Western Plaguelands · {area:152} Bulwark · {zone:1447} Azshara · {zone:1448} Felwood
	["{zone:1422} and the {area:152} first, then {zone:1447} and {zone:1448}."] = "Zuerst {zone:1422} und {area:152}, dann {zone:1447} und {zone:1448}.",

	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Er lagert beim {area:202}, südöstlich von {area:200}.",
	["Inside"] = "Drinnen",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "Kranke Wölfe",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "Die Wölfe streifen über die Felder zwischen Andorhal, {area:200} und {area:202}. Erledige sie auf dem Rückritt nach Osten. Vorsicht: Die größten sind Stufe 54: Zieh sie einzeln.",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Bauernhaus von {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "Das Tagebuch liegt im Bauernhaus, der Schrank steht drinnen und der Abort dahinter. Ein {npc:10816} trägt den Schlüssel zum Abort; {npc:10836} kommt heraus, wenn du den Abort öffnest, und trägt den Schlüssel zum Schrank.",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "Seine nächste Jagd, die kranken Grizzlys (55-56), wartet auf den Streifzug des Plaguelands-Guides bei etwa Stufe 55.",

	-- Step 6: High Executor Derrington
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092} next to Derrington"] = "{item:12814}, von dem {object:176092} neben Derrington",

	-- Step 7: Box of Incendiaries
	-- {quest:5096} Scarlet Diversions · {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries · {npc:10837} High Executor Derrington
	["{quest:5096} needs a {item:12814} to torch the command tent: take one from the {object:176092} next to {npc:10837}."] = "{quest:5096} benötigt ein {item:12814}, um das Befehlszelt niederzubrennen: nehme eines vom {object:176092} neben {npc:10837}.",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092}"] = "{item:12814}, von dem {object:176092}",

	-- Step 8: Scarlet forward camp
	["Scarlet forward camp"] = "Vorgeschobenes Lager des Scharlachroten Kreuzzugs",
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {item:12814} Flame in a Bottle
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {item:12814} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Vom {area:152} über die Straße nach Osten in die {zone:1422}. Das Zeltdorf der Schwarzen Kreuzzüger liegt direkt hinter Felstone Farm, zwischen {area:199} und {area:200}. Brenne das Befehlszelt mit dem {item:12814} nieder und pflanze das Banner der Scourge. Vorsicht: Die Schwarzen Kreuzzüger um die Zelte erreichen Stufe 54 und invokern: komme von der Seite heran, die dem Befehlszelt am nächsten ist, und lasse die anderen unberührt.",

	-- Step 9: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Reite nach Südwesten am Teufelssteinhof vorbei und folge der Straße nach Westen zurück zum {area:152}.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "Derringtons Wachtürme und Vandis' Kessel erledigst du bei einem späteren Besuch: Behalte sie.",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "Paladinlehrer",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152} in {zone:1420}; in {zone:1454} gibt es keinen Paladin-Lehrer",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 13: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "Die Mitte von {zone:1454}",

	-- Step 14: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659} takes the ravasaur claws from Un'Goro; he is in {object:172959}, upstairs in one of its tallest buildings."] = "{npc:8659} nimmt die Ravasaur-Klauen aus Un'Goro; er ist in {object:172959}, oben in einem der höchsten Gebäude.",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "{npc:8659}, oben in {object:172959}",

	-- Step 15: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Flieg nach {area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "{zone:1447} ist ein kurzer Flug von {zone:1454}: seine Quests sind 51-55, jetzt auf deinem Level.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 16: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, ein Zauberstab von den Arkanisten der Blutelfen",

	-- Step 17: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: töte diese, wenn du sie triffst",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Reite nach Osten zu den Ruinen an der Küste. Die vier Tafeln liegen zwischen den Ruinen, bewacht von Naga der Grollflossen (52-55): Zieh sie einzeln.",

	-- Step 18: Ruins of Eldarath
	-- {item:10695} Box of Empty Vials · {area:1231} Southridge Beach · {npc:8390} Chemist Cuely · {zone:1458} Undercity
	["Open Cuely's {item:10695} in your bags for the four labelled vials. The tide pools cannot be clicked: stand in each pool and use its own vial from your bags, from {area:1231} north up the coast; Spitelash naga patrol between them. No vials? Abandon the quest and take it again from {npc:8390} in the {zone:1458}."] = "Öffne den {item:10695} von Cuely in deinen Taschen und nimm die vier beschrifteten Phiolen. Die Gezeitentümpel lassen sich nicht anklicken: Steh in jedem Tümpel und benutze die eigene Phiole aus deinen Taschen, von {area:1231} nach Norden die Küste entlang; zwischen ihnen patrouillieren Spitelash-Naga. Keine Phiolen? Gib die Quest auf und nimm sie erneut von {npc:8390} in {zone:1458} an.",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "{item:10691}: der Gezeitentümpel auf {area:1231}",
	["#2, north along the shore"] = "#2, nach Norden entlang der Küste",

	-- Step 19: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Makrinni-Wühler",
	-- {npc:247473} Izvi Gildfizz · {item:246683} Treasure Trowel 3000
	-- plural, as words: Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment · Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["{npc:247473}'s {item:246683}, in your bags, digs up the Highborne Treasure Fragments: use it on the sands just east of the ruins, where the Makrinni Burrowers (50-51) dig, on the way north-east. The Burrowers and the buried caches there give fragments too."] = "Mit {npc:247473}s {item:246683} in deinen Taschen gräbst du Fragmente eines Hochgeborenenschatzes aus: Benutze es auf den Sand direkt östlich der Ruinen, wo die Makrinni-Buddler (50-51) graben, auf dem Weg nach Nordosten. Auch die Buddler und die vergrabenen Behälter dort liefern Fragmente.",

	-- Step 20: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Weiter nach Nordosten durch die Mitte von {zone:1447}: {npc:235903} lagert an der Straße.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, die Satyrn nördlich des Blutelfenlagers",

	-- Step 21: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Reite nach Nordosten zum Lager des Goblins auf den Klippen über der {area:1227}, gleich nördlich der Blutelfen.",

	-- Step 22: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Die Blutelfen lagern auf den Klippen im Nordosten, an der {area:1227}. Die vier Ausrüstungsteile von {npc:8420} liegen in den Kisten rund ums Lager; die Arkanisten der Blutelfen tragen den Zauberstab für {npc:247473}.\nVorsicht: Am Westrand des Lagers steht {npc:250023}, ein Elite der Stufe 55-57: Arbeite dich von der Ostseite an die Blutelfen heran.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, von den Arkanisten der Blutelfen",

	-- Step 23: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Lager von {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Rimtoris Lager ist am Ostende des Stützpunkts. Lies dort {object:151286}: Auf Forever verlangt der Sin'dorei-Foliant daneben dann die Siegel der drei Offiziere des Lagers.",

	-- Step 24: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Jeder der drei Offiziere des Lagers (53) trägt ein Siegel: {npc:247006} in der Mitte des Lagers, {npc:247013} an seinem Ostende und {npc:246991}, der die Westhälfte abläuft: Greif ihn auf der Ostseite seines Wegs an, wo der Pfeil hinzeigt.\nVorsicht: {npc:250023}, ein Elite der Stufe 55-57, steht am Westrand des Lagers, nahe dem anderen Ende von Hawkhelms Weg: Warte, bis Hawkhelm wieder nach Osten kommt.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, von {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, von {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, von {npc:247013}",

	-- Step 25: Magus Rimtori
	-- {quest:91500} An Explosive Gambit · {quest:91497} Seals of the Sin'dorei
	["Back to the Sin'dorei Tome: hand in the seals and take {quest:91500}, which gives you the {quest:91497}. Rimtori does not come from the Tome: stand beside one of the camp's tall crystals and use the {quest:91497} from your bags; its crystal explodes and draws her. Which crystal is linked to her is random: each of the other two summons a hostile infernal instead. She is level 55: start at full health."] = "Zurück zum Sin'dorei-Buch: Gib die Siegel ab und nimm {quest:91500}, das dir {quest:91497} gibt. Rimtori kommt nicht aus dem Buch: Stell dich neben einen der hohen Kristalle des Lagers und benutze {quest:91497} aus deinen Taschen; der Kristall explodiert und lockt sie herbei. Welcher Kristall mit ihr verbunden ist, ist zufällig: die beiden anderen beschwören stattdessen einen feindlichen Inferno. Sie ist Stufe 55: Beginne mit voller Gesundheit.",
	-- {quest:91497} Seals of the Sin'dorei · {npc:8578} Magus Rimtori
	["Use the {quest:91497} from your bags beside a crystal: {npc:8578} (55) comes to the explosion and drops her head"] = "Benutze {quest:91497} aus deinen Taschen neben einem Kristall: {npc:8578} (55) kommt zur Explosion und lässt ihren Kopf fallen",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: für {npc:8587} in {area:1237}",

	-- Step 26: The Legashi satyrs
	["The Legashi satyrs"] = "Die Satyrn der Legashi",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "Die Legashi-Satyrn (51-52) halten die Hügel nördlich des Lagers der Blutelfen: {npc:235903} will fünf von jeder Sorte.\nVorsicht: {npc:235892} (55, Elite) steht unter den Satyrn am nordöstlichen Ende ihrer Hügel, um 67,19: nimm die Satyrn näher am Lager und lass ihn in Ruhe.",

	-- Step 27: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Zurück nach Nordwesten zu {npc:8420}.",

	-- Step 28: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Reite nach Süden zum Nordrand von {area:1221}. Die Sirenen und Myrmidonen der Grollflossen (50-52) dort tragen die Rune von {npc:8420}; sie droppt selten, also arbeite dich am Rand entlang, bis sie fällt.",

	-- Step 29: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Mit der Rune zurück nach Norden zu {npc:8420}, dann die Straße nach Südwesten.",

	-- Step 30: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "Die Straße nach Südwesten: {npc:235903} nimmt die Satyrn.",

	-- Step 31: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Reite zurück nach Westen nach {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, für {npc:4485} in {zone:1454}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: Der Foliant geht an {npc:3326} in {zone:1454}",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "Behalte die Lieferungen: {npc:8659}, {npc:4485} und {npc:3326} sind als Nächstes in {zone:1454}, Magatha in {zone:1456} und {npc:6522} im {zone:1458} in den nächsten Führern.",

	-- Step 32: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "Reite von {area:1237} nach Osten bis zu Sanaths Lager am Fuß der Klippe und steig ab: er teleportiert dich hoch zum Turm von {npc:8379}.",

	-- Step 33: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "Der Lehrling oben im Turm schickt dich wieder nach unten.",
	["Upstairs"] = "Oben",

	-- Step 35: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Flugmeister in {area:1237}",

	-- Step 36: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:4485} is in the {object:172958}, {npc:3326} in the {object:172960}, and {npc:8659} in {object:172959}, upstairs in one of its tallest buildings."] = "{npc:4485} ist im {object:172958}, {npc:3326} im {object:172960}, und {npc:8659} in {object:172959}, oben in einem der höchsten Gebäude.",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "{npc:8659}: Seine Bezahlung geht zurück an {npc:8587}, beim Hinflug",

	-- Step 37: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 38: Druid trainer
	["Druid trainer"] = "Druidenlehrer",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} in {zone:1412}; {zone:1454} hat keinen Druidenlehrer",

	-- Step 39: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "{zone:1448} ist als Nächstes: flieg über {area:1237}, wo {npc:8587} {npc:8659}'s Bezahlung annimmt, und dann weiter nach {area:431}.",

	-- Step 41: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Flieg nach {area:431}",

	-- Step 43: Emerald Sanctuary
	["The druids' camp is just past the border."] = "Das Lager der Druiden liegt gleich hinter der Grenze.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}, neben {npc:10921}: {quest:86577}, die Organe der Bären und Wölfe in {zone:1448}",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, am Südrand des Lagers",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}, auf der Westseite des Lagers",

	-- Step 44: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Das Furbolgdorf der Totenwaldfelle liegt gleich südlich des Refugiums. Jeder getötete Totenwaldfell erhöht auch deinen Ruf bei der {area:1769}; behalte die Kopfputzfedern.",

	-- Step 45: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Südliches {area:1763}",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "Folge der Straße nach Nordwesten. Der Süden von {area:1763}, um seinen verdorbenen Mondbrunnen, wird von Kultisten, Adepten, Wachen und ihren Hunden des Shadow Council gehalten.\nVorsicht: Der {npc:11141} (53, Elite) spukt am Westende von {area:1763}, etwa bei 35,60: Ziehe die Kultisten und Hunde von ihm weg.",

	-- Step 47: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "Der Mondbrunnen von {area:1763}",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "Zurück nach Norden nach {area:1763}. Füll Gretas Feldflasche am verderbten Mondbrunnen mitten im südlichen Lager.",

	-- Step 48: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "Das Hordelager gleich nördlich von {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: Die Eulenbestien sind in {zone:1452}",

	-- Step 49: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "Östlich vom Blutgiftposten liegt das kraterübersäte Tal, wo die Entropischen Bestien und Schrecken umherstreifen. Töte je zwei davon und geh dann zu jedem der drei Krater mit Teufelswasser.",
	["Southern crater"] = "Südlicher Krater",
	["Western crater"] = "Westlicher Krater",
	["Northern crater"] = "Nördlicher Krater",

	-- Step 50: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "Die Statue von Malorne ({object:661778}) steht gleich südlich des Tals an der Straße nach Norden: Ihr Schmuckstück startet eine Quest für {npc:9996} am {area:1997}.",

	-- Step 51: Irontree Woods
	-- {area:1767} Irontree Woods · {npc:10920} Kelek Skykeeper · {npc:9529} Maybess Riverbreeze · {item:11503} Blood Amber · {area:1768} Irontree Cavern
	-- plural, as words: Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}: Angerclaw Grizzlies and Felpaw Ravagers roam the woods for Talo, and their organs are {npc:10920}'s. {npc:9529}'s {item:11503} comes from the Warpwood elementals inside {area:1768}, next."] = "Folge der Straße nach Nordosten zu {area:1767}: Wutklauen-Grebber und Teufelspfotenverheerer streifen für Talo durch den Wald, und ihre Organe will {npc:10920}. {npc:9529}s {item:11503} stammt von den Warpwood-Elementaren in {area:1768}, gleich danach.",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}, von den Zornklauenbären",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}, von den Teufelspfotenwölfen",

	-- Step 52: Irontree Woods
	-- {area:1768} Irontree Cavern
	["Below ground: from the Warpwood elementals inside {area:1768}"] = "Unter der Erde: von den Warpwood-Elementaren in {area:1768}",

	-- Step 53: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {quest:6031} Runecloth · {area:1769} Timbermaw Hold
	["Only from Friendly with the Timbermaw: {npc:11557}, in the tunnel near its {zone:1448} mouth, gives {quest:6031} then (the {area:1769} reputation guide gets you there)."] = "Erst ab Freundlich bei der Holzschlundfeste: {npc:11557} im Tunnel nahe ihrem {zone:1448}-Ausgang gibt dir dann {quest:6031} (der Ruf-Guide für {area:1769} bringt dich dorthin).",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; below ground"] = "{npc:11557}: Behalte 30 {quest:6031} für ihn auf; unter der Erde",

	-- Step 54: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "Die Straße endet bei {npc:15395}, vor dem Tunnel der {area:1769} im äußersten Nordosten.",

	-- Step 55: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "Vorsicht: Den Watchers sind Stufe 53-54 und die Rächer der Totenwaldfelle 54-55; sie rufen innerhalb von 25 Yards Verbündete herbei, sobald sie unter 50 % Gesundheit sind, und laufen unter 15 % los, um Hilfe zu holen.\nWenn einer ein {quest:8470} fallen lässt (etwa eine von dreißig Kills), klicke mit der rechten Maustaste darauf; bleib nicht, um eines zu farmen. {npc:11558} in {area:1769} nimmt es erst ab Neutral mit dem Timbermaw an (der {area:1769}-Reputationsguide bringt dich dorthin): jetzt, wenn sie schon neutral sind, oder beim letzten Durchgang des Guides durch die Höhle.",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "{quest:8470}, eine seltene Beute von den Deadwood-Furbolgs",

	-- Step 56: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Behalte {quest:8465} für {zone:1452}.",

	-- Step 57: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "Geh in die Höhle: {npc:11558} steht gleich hinter dem Eingang. Sie spricht mit dir erst ab Neutral bei den Holzschlund.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} läuft hier herum: schau in den Kreis auf der Karte",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "Ein {item:13140} ist gefallen: Benutze ihn, um die Quest zu starten, und befreie dann {npc:11018} aus ihrem Käfig in {area:1770}, der Höhle am Nordende von {area:1763}.",
	-- ["Back at the {area:2479}."] = "Zurück bei {area:2479}.",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "Zurück in {area:1762}: Die Furbolgs der Totenwaldfelle (53-54) sind nah am Tunnel, und jeder Kill erhöht deinen Ruf bei der Holzschlundfeste.",
	-- ["Below ground"] = "Unter der Erde",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Vorsicht: Höhlenbehüter sind Stufe 53-54 und die Rächer der Totenwaldfelle 54-55; sie rufen nahe Verbündete im Umkreis von 25 yd zu Hilfe, sobald sie unter 50% Gesundheit sind, und rennen unter 15% los, um Hilfe zu holen.\nTöte sie weiter, bis einer ein {quest:8470} fallen lässt, ungefähr bei jedem dreißigsten Kill, und klick es dann rechts an: {npc:11558} in {area:1769} nimmt es, sobald die Holzschlundfeste dir gegenüber Neutral ist, jetzt, wenn sie es schon ist, oder wenn der letzte Guide mit 59 wieder an der Höhle vorbeikommt.",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Vorsicht: Den Watchers sind Stufe 53-54; sie rufen nahe Verbündete im Umkreis von 25 yd zu Hilfe, sobald sie unter 50% Gesundheit sind, und rennen unter 15% los, um Hilfe zu holen.\nSolange du unter Stufe 54,54 bist, kämpfe hier nach {npc:15395}s Zählung weiter gegen die Deadwood: Die Abgaben bei {area:1769} und {area:2479} bringen dich auf Stufe 55. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1584} oder den Dungeon {area:1417}.\nTöte sie weiter, bis einer ein {quest:8470} fallen lässt, ungefähr bei jedem dreißigsten Kill, und klick es dann rechts an: {npc:11558} in {area:1769} nimmt es, sobald die Timbermaw dir gegenüber Neutral sind, jetzt, wenn sie es schon sind, oder wenn der letzte Guide mit 59 wieder an der Höhle vorbeikommt.",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "Überquere den Fluss nach Osten nach {area:2627}, der zerstörten Stadt im Nordwesten der {zone:1423}. {npc:12384} sitzt in einer Hütte an ihrem Rand.",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Derringtons Wachtürme, Vandis' Kessel und {npc:11615}s Fass erledigst du bei einem späteren Besuch: Behalte sie.",
	-- ["Diseased Grizzlies"] = "Kranke Grizzlys",
	-- ["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- ["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Folge der Straße nach Nordosten zu {area:1767}. Die Wucherborkenschinder und -zerfetzer an der Ostseite des Waldes tragen jeweils ein {item:11503}; Zornklauengrizzlys und Teufelspfotenverheerer streifen für Talo durch denselben Wald, und ihre Organe sind für {npc:10920}.\nAls Nächstes kommen die Höhlenbehüter der Totenwaldfelle (53-54) und Rächer (54-55) in {area:1762}: Unter Stufe 54 jage hier weiter die Grizzlys und Verheerer (51-52), bis du 54 bist. Die folgenden Abgaben in {area:1769}, im {area:2479} und am {area:1997} bringen dich fast auf 55. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Folge der Straße nach Nordosten zum {area:1767}. Die Wucherborkenschinder und -schredder auf der Ostseite des Waldes tragen je einen {item:11503}; Wutklauengrizzlys und Teufelspfotenverheerer streifen für Talo durch denselben Wald.",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Folge der Straße nach Nordosten zu {area:1767}. Die Warpwood Moss Flayers und Shredders an der Ostseite des Waldes tragen jeweils ein {item:11503}; Angerclaw Grizzlies und Felpaw Ravagers streifen durch denselben Wald für Talo. Solange du unter Stufe 54,21 bist, jage die Grizzlies und Ravagers weiter: Die Abgaben bei {area:1997} und {area:2479} bringen dich auf Stufe 55. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1584} oder den Dungeon {area:1417}.",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Folge der Straße nach Nordwesten. Den Süden von {area:1763}, um seinen verderbten Mondbrunnen, halten Kultisten, Adepten, Wachen und Hunde des Schattenrats.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Folge vom {area:152} aus der Straße nach Osten in die {zone:1422}. Die Zelte des Scharlachroten Kreuzzugs stehen gleich hinter dem Hof der Felsteins, zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf. Vorsicht: Die Scharlachroten um die Zelte sind bis Stufe 54 und die Beschwörer wirken Zauber: Komm von der Seite, die dem Kommandozelt am nächsten ist, und lass die anderen in Ruhe.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "Flieg vom Flugmeister der {area:2268} nach {area:1497}.",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "Seine nächste Jagd, die kranken Grizzlys (55-56), wartet auf den Besuch in den Pestländern mit etwa 58.",
	-- ["Jadefire moonwell"] = "Mondbrunnen der Jadefeuersatyrn",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Behalte Klein-Pamela: Pamela ist in {area:2262}, das du später noch einmal besuchst.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "Behalte den Zweig: {npc:5770} ist in {zone:1456}.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Behalte das Paket: {npc:10781} ist in {area:1497}.",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Behalte {quest:5158}: {npc:5901} ist im {zone:1413}.",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "Behalte {quest:6164}: {npc:12384} nimmt es beim Halt in {area:2627} im Guide für die {zone:1423} zurück.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Ritter und Magier arbeiten im {area:192}; die Sanitäter und Jäger lagern südlich davon.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Verlass {area:1497} und reite auf der Straße nach Osten durch {zone:1420}, am {area:152} vorbei. Der Teufelssteinhof ist der erste Hof an der Straße; {npc:10778} wartet im Haus.",
	-- ["Level 52.63"] = "Stufe 52,63",
	-- ["Level 53"] = "Stufe 53",
	-- ["Level 53.34"] = "Stufe 53,34",
	-- ["Level 54.7"] = "Stufe 54,7",
	-- ["Level 54.87"] = "Stufe 54,87",
	-- ["Level 55"] = "Stufe 55",
	-- ["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "Nur wenn {item:13140} gefallen ist: Benutze ihn, um die Quest zu starten, befrei dann {npc:11018} aus ihrem Käfig in {area:1770}, der Höhle am Nordende von {area:1763}, und eskortiere sie hinaus.",
	-- ["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Nur wenn du {npc:11018} gerettet hast: Die Sukkubus {npc:9518} wartet mitten in {area:1763}, neben {npc:11020}.",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "Nur mit 5 Kopfputzfedern der Totenwaldfelle",
	-- ["Radley and Durgen"] = "Radley und Durgen",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Reite zurück nach Süden an {area:1763} vorbei zum verderbten Mondbrunnen der Jadefeuersatyrn und füll dort {npc:9996}s Fläschchen.",
	-- ["Ride back south-east to the Sanctuary."] = "Reite zurück nach Südosten zum Refugium.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Reite zurück nach {area:1497}, nimm den Zeppelin nach {zone:1454} und flieg zum {area:431}. Folge der Straße vom Splintertreeposten nach Westen und nimm die Abzweigung nach Norden in den {zone:1448}.",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Reite zurück nach Westen über den Fluss und weiter zum {area:192}; {npc:11610} versteckt sich auf dem Hügel nordöstlich davon.",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Reite nach Osten zu den Ruinen an der Küste. Füll Cuelys vier Phiolen an den Gezeitentümpeln am Ufer; Naga der Grollflossen patrouillieren dazwischen.",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Reite an den östlichen Hügeln entlang nach Norden; {npc:1855} lebt in einem kleinen Haus am {area:2619}, an der Grenze zu den {zone:1423}.",
	-- ["Ride north up the road again."] = "Reite die Straße wieder nach Norden hinauf.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Reite nach Nordwesten nach Andorhal. {npc:10667} wartet im zerstörten Gasthaus auf der Westseite der Stadt; die Skelette drinnen sind 54-57, also bleib am Rand.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Reite nach Süden am {area:202} vorbei zum {area:197}; {npc:10927}s Haus steht an der Straße, und das Denkmal von {npc:10936} ist auf dem Friedhof dahinter. Töte unterwegs die Kranken Wölfe auf den Feldern.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Reite die Straße nach Süden durch den {area:361} zum Refugium.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "Reite die Straße nach Süden durch den {zone:1448} zum Refugium.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Reite nach Westen zum {area:192}; {npc:11610} versteckt sich auf dem Hügel nordöstlich davon.",
	-- ["Ror stands at the far south end of {area:1761}."] = "Ror steht am äußersten Südende von {area:1761}.",
	-- ["Scarlet Crusade"] = "Scharlachroter Kreuzzug",
	-- ["Scarlet forward camp"] = "Vorgeschobenes Lager des Scharlachroten Kreuzzugs",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "Betritt die Höhle: {npc:11558} steht gleich hinter dem Eingang.",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Bring das Kätzchen zum selben Mondbrunnen und lass es dort mit {item:12565} frei; sobald es sich in {npc:10042} verwandelt hat, bring es zurück zu {npc:9996} und klick es an, um es zu übergeben.",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Bring das Kätzchen zum selben Mondbrunnen und lass es dort frei; sobald es sich in {npc:10042} verwandelt hat, bring es zurück zu {npc:9996} und klick es an, um es zu übergeben.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Die Annalen liegen zwischen den Modrigen Folianten im Rathaus von Andorhal; öffne sie, bis du den richtigen findest.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "Das Furbolgdorf der Totenwaldfelle gleich westlich des Tunnels. {npc:9462} (56) steht zwischen ihnen. {npc:11557}, ein freundlicher Furbolg, sitzt am Nordende des Dorfs.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Das Furbolgdorf der Totenwaldfelle liegt gleich südlich des Refugiums. Jeder getötete Totenwaldfell erhöht auch deinen Ruf bei der {area:1769}; behalte die Kopfputzfedern.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Das Furbolg-Dorf der Deadwood liegt direkt südlich des Sanctuary. Jeder Kill bei den Deadwood erhöht auch deinen Ruf bei {area:1769}; behalte die Kopfschmuck-Federn. Töte sie weiter bis Stufe 53,92: Die nächsten Abgaben im Sanctuary und bei {area:1763} brauchen sie. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["The Jadefire moonwell"] = "Der Mondbrunnen der Jadefeuersatyrn",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Die Satyrn der Legashi (51-52) halten die Hügel nördlich des Lagers der Blutelfen: {npc:235903} will fünf von jeder Art.",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Die Makrinni-Wühler (50-51) graben im Sand gleich östlich der Ruinen, auf dem Weg nach Nordosten; sie und die vergrabenen Verstecke dort liefern die Fragmente eines Hochgeborenenschatzes.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Die Zelte des Scharlachroten Kreuzzugs stehen zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Die Bären streifen durch die Hügel nördlich und östlich vom {area:202}.",
	-- ["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Die Bären streifen durch die Hügel nördlich und östlich von {area:202}. Solange du unter Stufe 53,02 bist, jage sie nach dem achten weiter: Die Abgaben bei {area:202} bringen dich auf Stufe 54. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Das Buch liegt im zerstörten Gasthaus von {area:2627}; die Untoten in der Stadt sind 54-56, also zieh sie einzeln.\nDie Großen Termitenhügel stehen überall auf den Hügeln östlich von {area:2627}. Benutze {item:15042} an jedem Hügel, an dem du vorbeikommst.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Die Sukkubus {npc:9518} wartet in der Mitte von {area:1763}, neben {npc:11020}.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Die Wölfe streifen über die Felder zwischen Andorhal, {area:200} und {area:202}. Erledige sie auf dem Rückritt nach Osten.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "Durch die {area:1769}",
	-- ["To {zone:1448}"] = "Nach {zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Hol hier Stufe 52,63 auf, bevor du die Quests bei {area:200} abgibst: Sie bringen dich auf Stufe 53. Die Aaslauerer (52-53) westlich des Scharlachroten Lagers haben deine Stufe; die Scarlet Mages und Knights (54-56) sind höher. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:2100}.",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Hol hier Stufe 53 auf, bevor {npc:10739} dich zu den Kranken Grizzlys (55-56) schickt: Die Aaslauerer (52-53) auf dem Weg von {area:200} zu {area:202} haben deine Stufe. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Hol hier Stufe 53,34 auf, bevor du die Quests bei {area:1763} abgibst: Sie bringen dich auf Stufe 54. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Hol hier Stufe 54,7 auf, bevor du die Quests bei {area:1997} abgibst: Sie bringen dich auf Stufe 55. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1584} oder den Dungeon {area:1417}.",
	-- ["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Hol hier Stufe 54,87 auf, bevor du die Quests in {zone:1452} abgibst: Sie bringen dich auf Stufe 55. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1584} oder den Dungeon {area:1417}.",
	-- ["Upstairs"] = "Oben",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Geh neben {npc:15395} in den Tunnel der {area:1769} und greif niemals die Furbolgs der Holzschlundfeste darin an. Der Tunnel öffnet sich nach {zone:1452}; folge der Straße nach Osten nach {area:2255}, der Goblinstadt, in der der nächste Guide beginnt.",
	-- ["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "Führe {npc:11018} aus {area:1770} hinaus und halte sie am Leben, bis sie aus der Höhle heraus ist.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.\nNimm einen {object:176092} aus der Kiste neben Derrington für {quest:5096}.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "grinde Rächer der Totenwaldfelle in {area:1762}, {zone:1448}",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "grinde Scharlachrote Ritter im {area:192}, {zone:1422}",
	-- ["grind on {npc:10605}"] = "grinde {npc:10605}",
	-- ["grind on {npc:1816}"] = "grinde {npc:1816}",
	-- ["grind on {npc:1821}"] = "grinde {npc:1821}",
	-- ["grind on {npc:7101}"] = "grinde {npc:7101}",
	-- ["grind on {npc:7125}"] = "Grinde an {npc:7125}",
	-- ["grind on {npc:7153}"] = "Grinde an {npc:7153}",
	-- ["grind on {npc:7155}"] = "Grinde an {npc:7155}",
	-- ["grind on {npc:7156}"] = "grinde {npc:7156}",
	-- ["grind on {npc:7157}"] = "grinde {npc:7157}",
	-- ["grind on {npc:8957}"] = "grinde {npc:8957}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Die Scharlachroten in {area:190} sind Stufe 58-60. Reite zum auf deiner Karte markierten Aussichtspunkt, sieh dir die Stadt an und verschwinde wieder.",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: Töte diese, wenn du ihnen begegnest",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, am Mondbrunnen der Jadefeuersatyrn",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, am Südende des Friedhofs",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, unterirdisch",
	-- ["{npc:11018}, below ground"] = "{npc:11018}, unterirdisch",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, unterirdisch",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: Behalte 30 {quest:6031} für ihn; er handelt erst ab neutralem Ruf bei der Holzschlundfeste",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}: Behalte 30 {quest:6031} für ihn; er handelt nur bei Neutral mit den Timbermaw; unterirdisch",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, am Tunneleingang",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: Die Timbermaw sprechen nur ab Neutral mit dir; läuft hier umher: Schau in den Kreis auf der Karte",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}s letzte Aufgabe erfordert Stufe 53. Die Scharlachroten Ritter und Magier (54-55) im Holzfällerlager gleich südwestlich von ihr sind das nächste Lager.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} steht östlich des Holzfällerlagers; {npc:11611} bewacht die Straße nordöstlich von {npc:11610}, Richtung {area:190}.",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}s Jagden sind in den {zone:1423}: Behalte sie für später.",
	-- ["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659} nimmt die Ravasaurusklauen aus Un'Goro an; er steht in {object:172960}, ein kurzer Weg von der Stadtmitte.",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}, gleich westlich des Lagers",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, auf der Westseite des Refugiums",
	-- ["{npc:9996}'s kitten"] = "{npc:9996}s Kätzchen",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}, neben dem Haus",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} führt zur {area:2268}: Behalte sie für später.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}: Die Untoten in {area:2627} lassen sie fallen, während du {item:12846} trägst",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, eine seltene Beute",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Die Quests in {zone:1452} sind Stufe 55-58. Nach den Abgaben bei {npc:9996} noch unter 55? Die Furbolgs der Totenwaldfelle (53-55) in {area:1762} haben deine Stufe und liegen auf deinem Weg nach Norden zum Tunnel von {area:1769}: Töte sie bis Stufe 55. Jeder Kill erhöht auch deinen Ruf bei der Holzschlundfeste. Vorsicht: Die Höhlenbehüter und Rächer rufen unter halber Gesundheit Verbündete in der Nähe und fliehen kurz vor dem Tod, um Hilfe zu holen: Zieh sie einzeln vom Dorfrand. Das ist ein langes Auffüllen für jemanden, der nur dieser Route folgt. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1584} oder den Dungeon {area:1417}.",
}
