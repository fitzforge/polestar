-- German (deDE): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 2: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: Behalte sie für {zone:1451}",

	-- Step 3: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010} arbeitet in der Gasse.",

	-- Step 4: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1423} Eastern Plaguelands
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "Nur falls {quest:4494} noch nicht erledigt ist: {npc:7010} arbeitet in der Gasse. Pestlezugg nimmt sie in {area:976} auf dem Weg nach Un'Goro im Guide für {zone:1423} entgegen.",

	-- Step 5: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 6: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "Livs Werkstatt ist am Nordende der Docks von {area:392}; {object:149036} steht darin.",
	["Inside"] = "Drinnen",

	-- Step 7: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} lagert am Ufer gleich nördlich von {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "Das gereinigte Wasser geht zum {area:2479} im {zone:1448}: Behalte es für später.",

	-- Step 8: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "Kisten von {npc:256386}",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "Reite die Straße nach Norden zum Wegekreuz; dort steht {npc:256386}. Öffne jede Kiste, die sie dir gibt, und bring zurück, was darin ist. Flieg vom Wegekreuz weiter nach {area:1237}.",

	-- Step 9: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Flieg nach {area:1237}",
	["Crossroads flight master"] = "Flugmeister des Wegekreuzes",

	-- Step 10: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, ein Zauberstab von den Arkanisten der Blutelfen",

	-- Step 11: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: töte diese, wenn du sie triffst",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Reite nach Osten zu den Ruinen an der Küste. Die vier Tafeln liegen zwischen den Ruinen, bewacht von Naga der Grollflossen (52-55): Zieh sie einzeln.",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Reite nach Osten zu den Ruinen an der Küste. Füll Cuelys vier Phiolen an den Gezeitentümpeln am Ufer; Naga der Grollflossen patrouillieren dazwischen.",

	-- Step 13: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Makrinni-Wühler",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Die Makrinni-Wühler (50-51) graben im Sand gleich östlich der Ruinen, auf dem Weg nach Nordosten; sie und die vergrabenen Verstecke dort liefern die Fragmente eines Hochgeborenenschatzes.",

	-- Step 14: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Weiter nach Nordosten durch die Mitte von {zone:1447}: {npc:235903} lagert an der Straße.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, die Satyrn nördlich des Blutelfenlagers",

	-- Step 15: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Reite nach Nordosten zum Lager des Goblins auf den Klippen über der {area:1227}, gleich nördlich der Blutelfen.",

	-- Step 16: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Die Blutelfen lagern auf den Klippen im Nordosten, an der {area:1227}. Die vier Ausrüstungsteile von {npc:8420} liegen in den Kisten rund ums Lager; die Arkanisten der Blutelfen tragen den Zauberstab für {npc:247473}.\nVorsicht: Am Westrand des Lagers steht {npc:250023}, ein Elite der Stufe 55-57: Arbeite dich von der Ostseite an die Blutelfen heran.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, von den Arkanisten der Blutelfen",

	-- Step 17: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Lager von {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "Rimtoris Lager ist am Ostende des Stützpunkts. Lies dort {object:151286}: Auf Forever verlangt der Sin'dorei-Foliant daneben dann die Siegel der drei Offiziere des Lagers.",

	-- Step 18: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Jeder der drei Offiziere des Lagers (53) trägt ein Siegel: {npc:247006} in der Mitte des Lagers, {npc:247013} an seinem Ostende und {npc:246991}, der die Westhälfte abläuft: Greif ihn auf der Ostseite seines Wegs an, wo der Pfeil hinzeigt.\nVorsicht: {npc:250023}, ein Elite der Stufe 55-57, steht am Westrand des Lagers, nahe dem anderen Ende von Hawkhelms Weg: Warte, bis Hawkhelm wieder nach Osten kommt.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, von {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, von {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, von {npc:247013}",

	-- Step 19: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Zurück zum Sin'dorei-Folianten: Gib die Siegel ab und benutze ihn dann, um {npc:8578} zu rufen.\nVorsicht: Welcher Kristall mit Rimtori verbunden ist, ist zufällig. Jeder der beiden anderen beschwört stattdessen eine feindliche Höllenbestie.",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: für {npc:8587} in {area:1237}",

	-- Step 20: The Legashi satyrs
	["The Legashi satyrs"] = "Die Satyrn der Legashi",
	-- {npc:235903} Ekkal
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Die Satyrn der Legashi (51-52) halten die Hügel nördlich des Lagers der Blutelfen: {npc:235903} will fünf von jeder Art.",

	-- Step 21: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Zurück nach Nordwesten zu {npc:8420}.",

	-- Step 22: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Reite nach Süden zum Nordrand von {area:1221}. Die Sirenen und Myrmidonen der Grollflossen (50-52) dort tragen die Rune von {npc:8420}; sie droppt selten, also arbeite dich am Rand entlang, bis sie fällt.",

	-- Step 23: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Mit der Rune zurück nach Norden zu {npc:8420}, dann die Straße nach Südwesten.",

	-- Step 24: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "Die Straße nach Südwesten: {npc:235903} nimmt die Satyrn.",

	-- Step 25: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Reite zurück nach Westen nach {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, für {npc:4485} in {zone:1454}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: Der Foliant geht an {npc:3326} in {zone:1454}",
	-- {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1456} Thunder Bluff
	["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "Behalte die Lieferungen für {npc:8659}, {npc:6522}, {npc:4485} und {npc:3326}: Als Nächstes kommst du durch {zone:1454} und {zone:1458}. Die für Magatha in {zone:1456} liegt nicht auf dieser Route: Lass sie liegen.",

	-- Step 26: Archmage Xylem
	-- {area:1237} Valormok · {npc:8395} Sanath Lim-yo
	["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "Xylems Turm steht auf der Klippe direkt nördlich von {area:1237}: {npc:8395} in {area:1237} teleportiert dich kostenlos hinauf (sprich ihn an); sonst windet sich der Pfad an der Nordseite hinauf.",
	["Upstairs"] = "Oben",

	-- Step 28: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Flugmeister in {area:1237}",

	-- Step 29: Paladin trainer
	["Paladin trainer"] = "Paladinlehrer",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} in {zone:1456}; in {zone:1454} gibt es keinen Paladin-Lehrer",

	-- Step 30: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "Flieg nach {zone:1454} und lerne bei den Lehrern.",

	-- Step 31: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "Flieg nach {zone:1454}; {npc:4485} ist im {object:172958}, {npc:3326} und {npc:8659} in {object:172960}.",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",

	-- Step 32: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "Nach {zone:1411}",

	-- Step 33: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 34: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390} und {npc:8393} arbeiten im Apothecarium.",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, neben ihm",

	-- Step 35: Andron Gant
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522} stands in the {object:36073}."] = "{npc:6522} steht im {object:36073}.",

	-- Step 36: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "Fürstin Sylvanas ist im {object:36126}.",

	-- Step 39: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, in der Nähe",

	-- Step 40: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} geht zurück zu {npc:10778} in den {zone:1422}: Behalte sie.",

	-- Step 41: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Nur mit {quest:79095} aus dem Alchemieladen von {area:159} in deinen Taschen (der Guide Bibliotheksbücher)",

	-- Step 43: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "Reite von {zone:1458} die Straße nach Osten; {area:152} bewacht den Weg nach {zone:1422}.",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}: Die Termiten sind in {area:2627}, im nächsten Guide",

	-- Step 45: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "Die Farm von {npc:10778} ist die erste östlich von {area:152}. Jabbering Ghouls auf der Farm tragen die andere Hälfte ihres Amuletts; {npc:11075} bewacht den Kessel auf dem Feld.\nVorsicht: Ein oder zwei Untote kämpfen meist an seiner Seite, und nachdem du den Kessel benutzt hast, können weitere Cauldron Lords angreifen.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Beide Spenden von {item:14047} gibst du später auf der Route ab: Fang an, {item:14047} zu sammeln.",
	-- ["Fly to the {area:380}"] = "Flieg nach {area:380}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Flieg nach {zone:1454}; {npc:4485} ist im {object:172958}.",
	-- ["In the {object:172958}."] = "Im {object:172958}.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "Im {object:172961}. Hab Wolle, Seide und Magiestoff in deinen Taschen.",
	-- ["Open {object:149036} for the {item:10556}"] = "Öffne {object:149036} für {item:10556}",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "Rimtoris Lager ist am Ostende des Stützpunkts. Lies dort {object:151286} und töte dann den Magus.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Rimtoris Lager liegt am Ostende des Basislagers. Lies dort {object:151286} und töte dann den Magus.\nVorsicht: Welcher Kristall mit Rimtori verbunden ist, ist zufällig. Jeder der anderen beiden beschwört stattdessen eine feindliche Höllenbestie.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Die Blutelfen lagern auf den Klippen im Nordosten, an der {area:1227}.\nVorsicht: Am Westrand des Lagers steht {npc:250023}, ein Elite der Stufe 55-57: Arbeite dich von der Ostseite an die Blutelfen heran.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "Der Zeppelinturm steht gleich nordöstlich des Haupttors von {zone:1454}; nimm den Zeppelin nach {zone:1458}.",
	-- ["Zeppelin to the {zone:1458}"] = "Zeppelin nach {zone:1458}",
	-- ["Zeppelin tower"] = "Zeppelinturm",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, im Apothekarium",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} steht in {area:380}. Öffne jede Kiste, die sie dir gibt, und bring zurück, was darin ist.",
	-- ["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "{npc:4485}, {object:172958}: vom ersten Besuch in {zone:1447} mitgebracht, sonst nimm sie hier an, für {npc:8576} in {area:1237}",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} geht zurück zu {npc:10778} in den {area:28}: Behalte sie.",
}
