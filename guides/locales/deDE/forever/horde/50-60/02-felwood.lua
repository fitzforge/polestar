-- German (deDE): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Er lagert beim {area:202}, südöstlich von {area:200}.",
	["Inside"] = "Drinnen",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "Kranke Wölfe",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between {area:200} and the {area:202}, all the way west to Felstone Farm. Careful: the biggest are 54: pull them one at a time.\nAt 52, take the level 53 wolves; leave the 54s alone."] = "",

	-- Step 3: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "Seine nächste Jagd, die kranken Grizzlys (55-56), wartet auf den Besuch in den Pestländern mit etwa 58.",

	-- Step 5: High Executor Derrington
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.\nNimm einen {object:176092} aus der Kiste neben Derrington für {quest:5096}.",

	-- Step 6: Scarlet forward camp
	["Scarlet forward camp"] = "Vorgeschobenes Lager des Scharlachroten Kreuzzugs",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Folge vom {area:152} aus der Straße nach Osten in die {zone:1422}. Die Zelte des Scharlachroten Kreuzzugs stehen gleich hinter dem Hof der Felsteins, zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf. Vorsicht: Die Scharlachroten um die Zelte sind bis Stufe 54 und die Beschwörer wirken Zauber: Komm von der Seite, die dem Kommandozelt am nächsten ist, und lass die anderen in Ruhe.",

	-- Step 7: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Reite nach Südwesten am Teufelssteinhof vorbei und folge der Straße nach Westen zurück zum {area:152}.",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "Derringtons Wachtürme und Vandis' Kessel erledigst du bei einem späteren Besuch: Behalte sie.",

	-- Step 9: Paladin trainer
	["Paladin trainer"] = "Paladinlehrer",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152} in {zone:1420}; in {zone:1454} gibt es keinen Paladin-Lehrer",

	-- Step 10: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 11: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "Die Mitte von {zone:1454}",

	-- Step 12: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659} nimmt die Ravasaurusklauen aus Un'Goro an; er steht in {object:172960}, ein kurzer Weg von der Stadtmitte.",
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 13: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 14: Druid trainer
	["Druid trainer"] = "Druidenlehrer",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} in {zone:1412}; {zone:1454} hat keinen Druidenlehrer",

	-- Step 15: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Flieg nach {area:1237}",
	-- {zone:1447} Azshara · {zone:1448} Felwood
	["{zone:1447}'s camps are 46-53, right at your level now: fly over before {zone:1448}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 16: Valormok
	-- {npc:3621} Kurll · {zone:1447} Azshara
	["{npc:3621}: Mosshoof hides on the way through {zone:1447}"] = "",
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, ein Zauberstab von den Arkanisten der Blutelfen",

	-- Step 17: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: töte diese, wenn du sie triffst",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (46-52): pull them one at a time."] = "",

	-- Step 18: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Reite nach Osten zu den Ruinen an der Küste. Füll Cuelys vier Phiolen an den Gezeitentümpeln am Ufer; Naga der Grollflossen patrouillieren dazwischen.",

	-- Step 19: Mosshoof hides
	["Mosshoof hides"] = "",
	-- {area:1237} Valormok · {npc:3621} Kurll
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Look for Mosshoof Runners, Stags and Coursers between {area:1237} and the coast. They drop the hides for {npc:3621}."] = "",

	-- Step 20: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Makrinni-Wühler",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Die Makrinni-Wühler (50-51) graben im Sand gleich östlich der Ruinen, auf dem Weg nach Nordosten; sie und die vergrabenen Verstecke dort liefern die Fragmente eines Hochgeborenenschatzes.",

	-- Step 21: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Weiter nach Nordosten durch die Mitte von {zone:1447}: {npc:235903} lagert an der Straße.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, die Satyrn nördlich des Blutelfenlagers",

	-- Step 22: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Reite nach Nordosten zum Lager des Goblins auf den Klippen über der {area:1227}, gleich nördlich der Blutelfen.",

	-- Step 23: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Die Blutelfen lagern auf den Klippen im Nordosten, an der {area:1227}. Die vier Ausrüstungsteile von {npc:8420} liegen in den Kisten rund ums Lager; die Arkanisten der Blutelfen tragen den Zauberstab für {npc:247473}.\nVorsicht: Am Westrand des Lagers steht {npc:250023}, ein Elite der Stufe 55-57: Arbeite dich von der Ostseite an die Blutelfen heran.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, von den Arkanisten der Blutelfen",

	-- Step 24: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Lager von {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Rimtoris Lager ist am Ostende des Stützpunkts. Lies dort {object:151286}: Auf Forever verlangt der Sin'dorei-Foliant daneben dann die Siegel der drei Offiziere des Lagers.",

	-- Step 25: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Jeder der drei Offiziere des Lagers (53) trägt ein Siegel: {npc:247006} in der Mitte des Lagers, {npc:247013} an seinem Ostende und {npc:246991}, der die Westhälfte abläuft: Greif ihn auf der Ostseite seines Wegs an, wo der Pfeil hinzeigt.\nVorsicht: {npc:250023}, ein Elite der Stufe 55-57, steht am Westrand des Lagers, nahe dem anderen Ende von Hawkhelms Weg: Warte, bis Hawkhelm wieder nach Osten kommt.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, von {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, von {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, von {npc:247013}",

	-- Step 26: The Legashi satyrs
	["The Legashi satyrs"] = "Die Satyrn der Legashi",
	-- {npc:235903} Ekkal
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Die Satyrn der Legashi (51-52) halten die Hügel nördlich des Lagers der Blutelfen: {npc:235903} will fünf von jeder Art.",

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

	-- Step 31: Valormok
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Reite zurück nach Westen nach {area:1237}.",
	-- {zone:1456} Thunder Bluff
	["Magatha is at the next {zone:1456} stop"] = "",
	-- {npc:5770} Nara Wildmane
	["{npc:5770} is there too"] = "",
	-- {zone:1452} Winterspring · {npc:8578} Magus Rimtori
	["Keep the seals for the tome. Return after {zone:1452} for {npc:8578} (55)."] = "",

	-- Step 32: Archmage Xylem
	-- {area:1237} Valormok · {npc:8395} Sanath Lim-yo
	["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "Xylems Turm steht auf der Klippe direkt nördlich von {area:1237}: {npc:8395} in {area:1237} teleportiert dich kostenlos hinauf (sprich ihn an); sonst windet sich der Pfad an der Nordseite hinauf.",
	-- was: ["Upstairs"] = "Oben"
	["Upstairs"] = "",

	-- Step 34: Fly back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly back to {area:1637}"] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Flugmeister in {area:1237}",

	-- Step 35: Jes'rimon
	-- {area:1237} Valormok
	["Keep the payment for the return to {area:1237}"] = "",

	-- Step 36: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Flieg nach {area:431}",

	-- Step 38: Emerald Sanctuary
	["The druids' camp is just past the border."] = "Das Lager der Druiden liegt gleich hinter der Grenze.",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}, neben {npc:10921}: {quest:86577}, die Organe der Bären und Wölfe in {zone:1448}",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, am Südrand des Lagers",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}, auf der Westseite des Lagers",

	-- Step 39: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Das Furbolgdorf der Totenwaldfelle liegt gleich südlich des Refugiums. Jeder getötete Totenwaldfell erhöht auch deinen Ruf bei der {area:1769}; behalte die Kopfputzfedern.",

	-- Step 40: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Südliches {area:1763}",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Folge der Straße nach Nordwesten. Den Süden von {area:1763}, um seinen verderbten Mondbrunnen, halten Kultisten, Adepten, Wachen und Hunde des Schattenrats.",

	-- Step 42: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "Der Mondbrunnen von {area:1763}",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "Zurück nach Norden nach {area:1763}. Füll Gretas Feldflasche am verderbten Mondbrunnen mitten im südlichen Lager.",

	-- Step 43: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "Das Hordelager gleich nördlich von {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: Die Eulenbestien sind in {zone:1452}",

	-- Step 44: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "Östlich vom Blutgiftposten liegt das kraterübersäte Tal, wo die Entropischen Bestien und Schrecken umherstreifen. Töte je zwei davon und geh dann zu jedem der drei Krater mit Teufelswasser.",
	["Southern crater"] = "Südlicher Krater",
	["Western crater"] = "Westlicher Krater",
	["Northern crater"] = "Nördlicher Krater",

	-- Step 45: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	-- was: ["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "Die Statue von Malorne ({object:661778}) steht gleich südlich des Tals an der Straße nach Norden: Ihr Schmuckstück startet eine Quest für {npc:9996} am {area:1997}."
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996}, handed in on the last ride north past {area:1997}."] = "",

	-- Step 46: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {npc:10920} Kelek Skykeeper
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	-- was: ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Folge der Straße nach Nordosten zum {area:1767}. Die Wucherborkenschinder und -schredder auf der Ostseite des Waldes tragen je einen {item:11503}; Wutklauengrizzlys und Teufelspfotenverheerer streifen für Talo durch denselben Wald."
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}, von den Zornklauenbären",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}, von den Teufelspfotenwölfen",

	-- Step 47: Irontree Woods
	["Below ground"] = "Unter der Erde",

	-- Step 48: The Jadefire moonwell
	["The Jadefire moonwell"] = "Der Mondbrunnen der Jadefeuersatyrn",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	-- was: ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Reite zurück nach Süden an {area:1763} vorbei zum verderbten Mondbrunnen der Jadefeuersatyrn und füll dort {npc:9996}s Fläschchen."
	["On the return from Irontree, ride south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 49: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "Ror steht am äußersten Südende von {area:1761}.",

	-- Step 50: Emerald Sanctuary
	["Stop at the Sanctuary on the ride north from Ror."] = "",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, auf der Westseite des Refugiums",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Behalte {quest:5158}: {npc:5901} ist im {zone:1413}.",

	-- Step 51: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Ride north up the road to {area:1997}, on the way to the tunnel."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",

	-- Step 52: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}s Kätzchen",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Bring das Kätzchen zum selben Mondbrunnen und lass es dort mit {item:12565} frei; sobald es sich in {npc:10042} verwandelt hat, bring es zurück zu {npc:9996} und klick es an, um es zu übergeben.",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, am Mondbrunnen der Jadefeuersatyrn",

	-- Step 54: Level 54
	["Level 54"] = "",
	-- {area:16620} Alcaz Prison · {area:1584} Blackrock Depths
	["On the ride north, finish any of Talo's grizzlies and ravagers still needed. Stay with the grizzlies (51-52) until 54 before Felpaw's level 55 Avengers. Or, with a group, run the {area:16620} dungeon or the {area:1584} dungeon instead."] = "",

	-- Step 55: Nafien
	-- {area:1762} Felpaw Village · {npc:15395} Nafien
	["Follow the road north past {area:1762} to {npc:15395} at the tunnel entrance."] = "",

	-- Step 56: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh · {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	-- was: ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "Vorsicht: Höhlenbehüter sind Stufe 53-54 und die Rächer der Totenwaldfelle 54-55; sie rufen nahe Verbündete im Umkreis von 25 yd zu Hilfe, sobald sie unter 50% Gesundheit sind, und rennen unter 15% los, um Hilfe zu holen.\nTöte sie weiter, bis einer ein {quest:8470} fallen lässt, ungefähr bei jedem dreißigsten Kill, und klick es dann rechts an: {npc:11558} in {area:1769} nimmt es, sobald die Holzschlundfeste dir gegenüber Neutral ist, jetzt, wenn sie es schon ist, oder wenn der letzte Guide mit 59 wieder an der Höhle vorbeikommt."
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village.\nCareful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}: Behalte 30 {quest:6031} für ihn; er handelt nur bei Neutral mit den Timbermaw; unterirdisch",

	-- Step 57: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Behalte {quest:8465} für {zone:1452}.",

	-- Step 58: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside."] = "Betritt die Höhle: {npc:11558} steht gleich hinter dem Eingang.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}: Die Timbermaw sprechen nur ab Neutral mit dir; läuft hier umher: Schau in den Kreis auf der Karte",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "Ein {item:13140} ist gefallen: Benutze ihn, um die Quest zu starten, und befreie dann {npc:11018} aus ihrem Käfig in {area:1770}, der Höhle am Nordende von {area:1763}.",
	-- ["Back at the {area:2479}."] = "Zurück bei {area:2479}.",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "Zurück in {area:1762}: Die Furbolgs der Totenwaldfelle (53-54) sind nah am Tunnel, und jeder Kill erhöht deinen Ruf bei der Holzschlundfeste.",
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
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "Flieg vom Flugmeister der {area:2268} nach {area:1497}.",
	-- ["Jadefire moonwell"] = "Mondbrunnen der Jadefeuersatyrn",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Behalte Klein-Pamela: Pamela ist in {area:2262}, das du später noch einmal besuchst.",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "Behalte den Zweig: {npc:5770} ist in {zone:1456}.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Behalte das Paket: {npc:10781} ist in {area:1497}.",
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
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Reite an den östlichen Hügeln entlang nach Norden; {npc:1855} lebt in einem kleinen Haus am {area:2619}, an der Grenze zu den {zone:1423}.",
	-- ["Ride north up the road again."] = "Reite die Straße wieder nach Norden hinauf.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Reite nach Nordwesten nach Andorhal. {npc:10667} wartet im zerstörten Gasthaus auf der Westseite der Stadt; die Skelette drinnen sind 54-57, also bleib am Rand.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Reite nach Süden am {area:202} vorbei zum {area:197}; {npc:10927}s Haus steht an der Straße, und das Denkmal von {npc:10936} ist auf dem Friedhof dahinter. Töte unterwegs die Kranken Wölfe auf den Feldern.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Reite die Straße nach Süden durch den {area:361} zum Refugium.",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "Reite die Straße nach Süden durch den {zone:1448} zum Refugium.",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Reite nach Westen zum {area:192}; {npc:11610} versteckt sich auf dem Hügel nordöstlich davon.",
	-- ["Scarlet Crusade"] = "Scharlachroter Kreuzzug",
	-- ["Scarlet forward camp"] = "Vorgeschobenes Lager des Scharlachroten Kreuzzugs",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Bring das Kätzchen zum selben Mondbrunnen und lass es dort frei; sobald es sich in {npc:10042} verwandelt hat, bring es zurück zu {npc:9996} und klick es an, um es zu übergeben.",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Die Annalen liegen zwischen den Modrigen Folianten im Rathaus von Andorhal; öffne sie, bis du den richtigen findest.",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "Das Furbolgdorf der Totenwaldfelle gleich westlich des Tunnels. {npc:9462} (56) steht zwischen ihnen. {npc:11557}, ein freundlicher Furbolg, sitzt am Nordende des Dorfs.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Das Furbolgdorf der Totenwaldfelle liegt gleich südlich des Refugiums. Jeder getötete Totenwaldfell erhöht auch deinen Ruf bei der {area:1769}; behalte die Kopfputzfedern.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Das Furbolg-Dorf der Deadwood liegt direkt südlich des Sanctuary. Jeder Kill bei den Deadwood erhöht auch deinen Ruf bei {area:1769}; behalte die Kopfschmuck-Federn. Töte sie weiter bis Stufe 53,92: Die nächsten Abgaben im Sanctuary und bei {area:1763} brauchen sie. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Die Zelte des Scharlachroten Kreuzzugs stehen zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Die Bären streifen durch die Hügel nördlich und östlich vom {area:202}.",
	-- ["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "Die Bären streifen durch die Hügel nördlich und östlich von {area:202}. Solange du unter Stufe 53,02 bist, jage sie nach dem achten weiter: Die Abgaben bei {area:202} bringen dich auf Stufe 54. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:1584}.",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Das Buch liegt im zerstörten Gasthaus von {area:2627}; die Untoten in der Stadt sind 54-56, also zieh sie einzeln.\nDie Großen Termitenhügel stehen überall auf den Hügeln östlich von {area:2627}. Benutze {item:15042} an jedem Hügel, an dem du vorbeikommst.",
	-- ["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "Das Tagebuch liegt im Bauernhaus, der Schrank steht drinnen und der Abort dahinter. Ein {npc:10816} trägt den Schlüssel zum Abort; {npc:10836} kommt heraus, wenn du den Abort öffnest, und trägt den Schlüssel zum Schrank.",
	-- ["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "Die Straße endet bei {npc:15395}, vor dem Tunnel der {area:1769} im äußersten Nordosten.",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Die Sukkubus {npc:9518} wartet in der Mitte von {area:1763}, neben {npc:11020}.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Die Wölfe streifen über die Felder zwischen Andorhal, {area:200} und {area:202}. Erledige sie auf dem Rückritt nach Osten.",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "Die Wölfe streifen über die Felder zwischen Andorhal, {area:200} und {area:202}. Erledige sie auf dem Rückritt nach Osten. Vorsicht: Die größten sind Stufe 54: Zieh sie einzeln.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "Die Statue von Malorne ({object:661778}) steht gleich südlich des Tals an der Straße nach Norden: Ihr Schmuckstück startet eine Quest für {npc:9996} am {area:1997}.",
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
	-- ["{area:200} farmhouse"] = "Bauernhaus von {area:200}",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: Töte diese, wenn du ihnen begegnest",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, am Südende des Friedhofs",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, unterirdisch",
	-- ["{npc:11018}, below ground"] = "{npc:11018}, unterirdisch",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, unterirdisch",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: Behalte 30 {quest:6031} für ihn; er handelt erst ab neutralem Ruf bei der Holzschlundfeste",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, am Tunneleingang",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}s letzte Aufgabe erfordert Stufe 53. Die Scharlachroten Ritter und Magier (54-55) im Holzfällerlager gleich südwestlich von ihr sind das nächste Lager.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} steht östlich des Holzfällerlagers; {npc:11611} bewacht die Straße nordöstlich von {npc:11610}, Richtung {area:190}.",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}s Jagden sind in den {zone:1423}: Behalte sie für später.",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}, gleich westlich des Lagers",
	-- ["{object:175894}, beside the house"] = "{object:175894}, neben dem Haus",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} führt zur {area:2268}: Behalte sie für später.",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}: Die Untoten in {area:2627} lassen sie fallen, während du {item:12846} trägst",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}, eine seltene Beute",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "Die Quests in {zone:1452} sind Stufe 55-58. Nach den Abgaben bei {npc:9996} noch unter 55? Die Furbolgs der Totenwaldfelle (53-55) in {area:1762} haben deine Stufe und liegen auf deinem Weg nach Norden zum Tunnel von {area:1769}: Töte sie bis Stufe 55. Jeder Kill erhöht auch deinen Ruf bei der Holzschlundfeste. Vorsicht: Die Höhlenbehüter und Rächer rufen unter halber Gesundheit Verbündete in der Nähe und fliehen kurz vor dem Tod, um Hilfe zu holen: Zieh sie einzeln vom Dorfrand. Das ist ein langes Auffüllen für jemanden, der nur dieser Route folgt. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1584} oder den Dungeon {area:1417}.",
}
