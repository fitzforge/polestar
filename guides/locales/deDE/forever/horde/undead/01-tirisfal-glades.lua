-- German (deDE): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "Du erwachst in der Gruft am Südende von {area:154}. {npc:1568} wartet direkt draußen.",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "Folge dem Pfad nach Norden nach {area:154}; Sarvis steht vor der Kirche.",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Hirnlose Zombies",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Die Zombies schlurfen über den Friedhof und um die Häuser direkt östlich der Kirche.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "{npc:1661}, neben der Kirche",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "{npc:2119}, der Kriegerlehrer",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}, der Schurkenlehrer",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}, der Priesterlehrer in der Kirche",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}, die Magierlehrerin, in der Kirche",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}, der Hexenmeisterlehrer",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "Die Lehrer von {area:154} stehen rund um die Kirche",

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808} und {npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} und {npc:5667} stehen neben der Kirche.",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: die Schriftrolle für {npc:244808}",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "Klappernde Skelette, Aasfresser und Nachtsauger",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Klappernde Skelette streifen durch die zerstörten Häuser in der Nordhälfte von {area:154}. Junge Aasfresser und Nachtsauger streifen überall im Dorf umher; die Struppigen Aasfresser und Räudigen Nachtsauger sind auf seiner Ostseite.",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "Schädel klappernder Skelette",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Die Klappernden Skelette in den zerstörten Häusern lassen die Schädel fallen.",

	-- Step 8: Back to the church
	["Back to the church"] = "Zurück zur Kirche",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, in der Kirche",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladine: {quest:90902} ist erledigt, sobald du fünf {npc:259377} rund um die Kirche mit {spell:635} geheilt hast.",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "Die {object:164662} liegen neben den zerstörten Häusern im Norden von {area:154}.",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Geh nach Westen zur Höhle. Die Jungen Nachtweber sitzen draußen; die Nachtweber und die eingesponnenen Opfer sind drinnen.",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "Befreie sechs eingesponnene Opfer in der Höhle für {npc:244808}",
	["Webbed Victims"] = "Eingesponnene Opfer",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "Zurück nach {area:154}",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "Der {npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: Der {npc:246143} ist in die Hügel direkt westlich der Kirche geflohen.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Biete dem {npc:246143} Hilfe an",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "Der scharlachrote Bauernhof",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Die Scharlachroten Konvertiten und Initianden halten den Bauernhof östlich von {area:154}. {npc:1919} wandert zwischen den Bauernhäusern umher: Seine Überreste sind für {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, von {npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} liegt auf dem Friedhof von {area:154}, neben der Kirche.",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} steht am Südende des scharlachroten Bauernhofs.",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Verlass {area:154} über die Straße nach Nordosten. {npc:6784} steht beim Bauernhaus auf {area:156}.",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, die große Monstrosität, geht ein Stück weiter östlich die Straße entlang. Das {item:12737} wächst entlang der Straße um ihn herum.",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Folge der Straße nach Osten nach {area:159}. {npc:10665} steht am Nordwestrand des Ortes; {area:2119} ist das große Gasthaus in der Mitte, mit {npc:1515} davor.",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, die Paladinlehrerin",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Bitte {npc:1496} um seinen Bericht",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "Die Lehrer von {area:159} sind im Gasthaus und drumherum",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Benutze den {item:286176} an fünf untätigen Todeswachen im Ort",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} wächst auf den Friedhofsfeldern direkt nördlich von {area:159}.",

	-- Step 25: Dry Branches
	["Dry Branches"] = "Trockene Äste",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Die Trockenen Äste liegen am Boden rund um den Südwestrand von {area:159}.",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleanor lagert direkt südwestlich des Ortes.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "/sit an ihrem Lagerfeuer, bis du {spell:1229451} bekommst",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "Felder westlich von {area:159}",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} und Verheerte Kadaver schlurfen über die Felder direkt westlich von {area:159}; Schattenhunde streifen etwas weiter westlich umher, Richtung {npc:10666}.",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Bitte {npc:10666} um seinen Bericht",

	-- Step 29: Calvin Montague
	-- {npc:6784} Calvin Montague
	["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Geh weiter nach Westen zu {npc:6784} und sprich mit ihm: Er will ein Duell.",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Besiege {npc:6784} im Duell",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "Ruhestein nach {area:159}",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "{npc:2132}, neben Johaan",
	["in the inn: ask him about cooking"] = "im Gasthaus: Frag ihn nach dem Kochen",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "Sprich mit {npc:265944}",
	["The Wanted poster by the inn"] = "Der Steckbrief beim Gasthaus",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, im Rathaus",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, im Gasthaus",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} von {npc:2118}, für Gretchen",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "Große Nachtsauger",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Große Nachtsauger fliegen über die Felder um {area:159} und entlang der Straße nach Norden.",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "Friedhöfe der Moderfelle",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Die Grabräuber der Moderfelle graben auf den Friedhöfen nördlich von {area:159}; alle Moderfelle lassen das Sekret fallen.",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Die Bastarde der Moderfelle halten die Hügel weiter nördlich. {npc:1753} (Stufe 11) steht in ihrem Lager auf dem Hügel südlich des Ufers: Räum zuerst die Gnolle um ihn herum weg.",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "Murlocs der Finsterflossen",
	["The Vile Fin murlocs line the north shore."] = "Die Murlocs der Finsterflossen säumen das Nordufer.",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "Folge der Straße nach Süden zurück nach {area:159}.",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Folge der Straße von {area:159} nach Südosten an den Zeppelintürmen vorbei. Linnea, Kristof und {npc:3549} lagern an der Straße.",
	-- {npc:1495} Deathguard Linnea · {npc:276020} Riptear
	["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, eine Elite-Monstrosität im Osten",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Bitte {npc:251001} um seinen Bericht",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "Die Straße hinauf zurück nach {area:159}.",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Folge der Straße nach Nordwesten zu {area:157}. {npc:1657} geht über den Friedhof südlich der Mühlen; Nissa, Gregor und {npc:1656} spuken in den Mühlen selbst. Klappernde Skelettsoldaten und Trümmerschädelsoldaten lassen die Rippen fallen, Dunkle Skelettmagier die Schädel, und jeder von ihnen kann {item:2839} fallen lassen. Töte ab hier die Nachtsauger und Schattenhunde, an denen du vorbeikommst: {npc:3549} will ihre Flügel und Felle.",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, ein seltener Drop",
	["Only if the letter dropped"] = "Nur wenn der Brief gedroppt ist",

	-- Step 40: Deathguard Simmer
	-- {area:156} Solliden Farmstead
	["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Geh nach Südwesten zu {area:156}; Simmer steht beim Hof.",

	-- Step 41: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Tirisfalkürbisse",
	["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Die Kürbisse wachsen auf den von den Scharlachroten gehaltenen Feldern nordwestlich von Sollidens Bauernhof.",

	-- Step 42: Crusader's Outpost
	["Crusader's Outpost"] = "Außenposten der Kreuzzügler",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Scharlachrote Krieger bewachen den Außenposten direkt westlich der Kürbisfelder. {npc:275954} wird drinnen festgehalten: Sprich mit ihm und bleib bei ihm, bis er draußen ist.",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Eskortiere {npc:275954} aus dem Außenposten",

	-- Step 43: Vile Fin shore
	["Vile Fin shore"] = "Ufer der Finsterflossen",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "Weitere Murlocs der Finsterflossen laufen am Ufer direkt nördlich des Außenpostens.",

	-- Step 44: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "Paladin: {area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Geh nach Westen in {area:16616}; {npc:246389} und {npc:259190} lagern an seinem Rand.",

	-- Step 45: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} ist die Senke am Westrand von Tirisfal. Die Schattentalschlinger und Schattentalmystiker lassen die Knochen fallen; die Flaschen liegen zwischen ihnen am Boden, und {item:286269} ist am Südende.",

	-- Step 48: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, im Gasthaus",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "Der {npc:1931}, im Keller des Rathauses",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} in {zone:1458} nimmt es an",

	-- Step 49: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} steht in {area:159}. {npc:6390} wartet im Mausoleum auf dem Hügel direkt nördlich des Ortes: Öffne das Tor und kämpfe gegen ihn.",

	-- Step 50: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Geh von {area:159} nach Süden zu {area:153} und hinab nach {zone:1458}. {npc:5675} steht im {object:36082}. Das scharlachrote Lager liegt direkt westlich der Ruinen.",

	-- Step 51: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Geh von {area:159} nach Süden zu {area:153} und hinab nach {zone:1458}. {npc:4568} steht im {object:36082}. Das scharlachrote Lager liegt direkt westlich der Ruinen.",

	-- Step 52: The Scarlet camp
	["The Scarlet camp"] = "Das scharlachrote Lager",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Folge der Straße von {area:159} nach Südwesten zum Lager des Scharlachroten Kreuzzugs. {npc:1662} steht an seinem Südende; jeder Scharlachrote dort kann einen Ring fallen lassen.",

	-- Step 53: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} steht neben {npc:1662} am Südende des Lagers.",

	-- Step 55: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Nimm die Straße von {area:159} nach Südosten; Terrence steht darauf, kurz vor den Zeppelintürmen.",

	-- Step 56: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} steht im Lager von {npc:1495}.",

	-- Step 57: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} hält den Hof direkt südöstlich des Lagers. Die Nekrotischen Kristallfragmente liegen zwischen den Kultisten am Boden, und die Kultisten tragen auch einige bei sich.",

	-- Step 58: Balnir graves
	["Balnir graves"] = "Gräber von Balnirs Bauernhof",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Folge der Straße nach Osten. Blutende Schrecken und Wandernde Geister spuken bei den Gräbern auf der Ostseite des Hofs, wo {quest:99142} wächst.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, im Garten des Hofs",

	-- Step 59: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Die Scharlachroten Ordensmitglieder lagern direkt nordöstlich der Gräber; {npc:1664} steht zwischen ihnen.",

	-- Step 60: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "Heimtückische Nachtweber",
	-- {npc:276020} Riptear
	["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Die Spinnen lauern in den Wäldern am äußersten Ostende von Tirisfal. {npc:276020}, eine abtrünnige Monstrosität, streift direkt nordwestlich von ihnen umher. {npc:276020} ist Elite: Eine Gruppe wird empfohlen.",
	-- {item:286326} Riptear's Heart · {npc:276020} Riptear
	["{item:286326}, from {npc:276020}"] = "{item:286326}, von {npc:276020}",

	-- Step 61: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Nachtsauger und Schattenhunde streifen überall entlang der Straße zurück nach Westen umher; sammle unterwegs die restlichen Flügel und Felle.",

	-- Step 62: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Lager von {npc:1495}",

	-- Step 63: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "Der {npc:2211}, im Keller des Rathauses",

	-- Step 64: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Folge der Straße von {area:159} nach Nordosten an {area:162} vorbei. {npc:1665} und seine zwei Scharlachroten Leibwachen halten den scharlachroten Wachturm an der Nordostküste, nördlich von {area:459}: Zieh zuerst die Leibwachen.",

	-- Step 65: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "Zurück nach {area:159}.",

	-- Step 66: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Folge der Straße nach Westen an {area:157} vorbei zu {area:16616}. Leonid steht direkt nördlich von {npc:246389}s Lager.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Hör Leonid und {npc:246378} zu, dann sprich erneut mit ihm",

	-- Step 68: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} liegt unter {area:153}, neben den Zeppelintürmen. {npc:5675} ist im {object:36082}: Benutze die {item:6284} am Beschwörungskreis neben ihm und besiege den Leerwandler. {npc:4606} ist im {object:36070}. {npc:4568} ist ebenfalls im {object:36082}.",

	-- Step 69: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "Zeppelin nach {zone:1411}",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Geh von {area:159} nach Südosten zu den Zeppelintürmen vor {area:153} und steig in den Zeppelin nach {zone:1454} (der andere fliegt nach {object:3202}).",
	["Zeppelin tower"] = "Zeppelinturm",

	-- Step 70: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Der Zeppelin landet am Turm direkt nordöstlich des Haupttors von {zone:1454}. Folge der Straße nach Süden nach {zone:1411}, überquere die Brücke über {area:815} unterhalb von {area:379} und folge der Straße nach Westen nach {area:380}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, der Windreitermeister",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Der Zeppelin landet am Turm direkt nordöstlich des Haupttors von {zone:1454}. Folge der Straße nach Süden nach {zone:1411}, überquere die Brücke über {area:815} unterhalb von {area:379} und folge der Straße nach Westen zu {area:380}.",
}
