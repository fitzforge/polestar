-- German (deDE): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["Inside"] = "",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Hirnlose Zombies",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Die Zombies schlurfen über den Friedhof und um die Häuser direkt östlich der Kirche.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: die Schriftrolle für {npc:244808}",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "",
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

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "{quest:90902}: Die {npc:259377} liegen rund um die Kirche. Heile fünf von ihnen mit {spell:635}.",

	-- Step 6: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "",
	-- {area:154} Deathknell · {npc:1661} Novice Elreth
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side. {npc:1661} wants their paws and wings: kill them as you meet them while you clear the skeletons."] = "",

	-- Step 7: Back to the church
	["Back to the church"] = "Zurück zur Kirche",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, in der Kirche",

	-- Step 8: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "Die {object:164662} liegen neben den zerstörten Häusern im Norden von {area:154}.",

	-- Step 9: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "Zurück nach {area:154}",

	-- Step 10: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "Der {npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Biete dem {npc:246143} Hilfe an",

	-- Step 11: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "",
	["Below ground"] = "",
	["attack the cocoons inside the cave to free them; below ground"] = "",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "",

	-- Step 13: The Scarlet farm
	["The Scarlet farm"] = "Der scharlachrote Bauernhof",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Die Scharlachroten Konvertiten und Initianden halten den Bauernhof östlich von {area:154}. {npc:1919} wandert zwischen den Bauernhäusern umher: Seine Überreste sind für {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, von {npc:1919}",

	-- Step 14: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} liegt auf dem Friedhof von {area:154}, neben der Kirche.",

	-- Step 16: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "",

	-- Step 18: Solliden Farmstead
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}; {npc:1519} stands by the road just past it."] = "",

	-- Step 19: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Tirisfalkürbisse",
	["The pumpkins grow in the Scarlet-held fields just north-west of the farmhouse.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "",

	-- Step 21: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {npc:1742} Deathguard Bartholomew · {area:159} Brill
	["{npc:1496} and {npc:1742} stand at the west end of {area:159}, where the road from Solliden comes in."] = "",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742}, beside Dillinger"] = "",

	-- Step 22: Junior Apothecary Holland
	-- {area:159} Brill
	["Holland walks around the north side of {area:159}, a few steps from Dillinger."] = "",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "",

	-- Step 23: Dry Branches
	["Dry Branches"] = "Trockene Äste",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Die Trockenen Äste liegen am Boden rund um den Südwestrand von {area:159}.",

	-- Step 24: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleanor lagert direkt südwestlich des Ortes.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "/sit an ihrem Lagerfeuer, bis du {spell:1229451} bekommst",

	-- Step 25: Brill
	-- {npc:1518} Apothecary Johaan · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren
	["{npc:1518} is in the apothecary's house on the west side of the square, {npc:1515} in front of the inn with the Wanted poster beside him, {npc:1499} in the town hall on the square's north side. The inn comes last, in one go."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, die Paladinlehrerin",
	-- {npc:1515} Executor Zygand
	["{npc:1515}, in front of the inn"] = "",
	["The Wanted poster by the inn"] = "Der Steckbrief beim Gasthaus",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, im Rathaus",

	-- Step 26: Carolai Anise
	-- {npc:2132} Carolai Anise · {area:159} Brill
	["From level 7 {npc:2132}, beside Johaan in the apothecary's house, offers her elixir quest; below 7 it waits for the next {area:159} visit."] = "",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "",

	-- Step 27: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Benutze den {item:286176} an fünf untätigen Todeswachen im Ort",

	-- Step 29: Gallows' End Tavern
	-- {npc:5688} Innkeeper Renee · {npc:265944} William Pickman · {npc:1931} Captured Scarlet Zealot · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Everything here is inside the inn, through its door on the south side: {npc:5688} at the bar, {npc:265944} at the north end of the ground floor, the {npc:1931} in the cellar under that end, and {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) upstairs: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:265944} William Pickman
	["{npc:265944}, at the inn's north end: Camping 101 asks you to learn it"] = "",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the inn's cellar"] = "",
	-- {area:159} Brill · {npc:2131} Austil de Mon · {npc:246152} Shari Stilwell
	["The {area:159} trainers are in the inn ({npc:2131} downstairs, the rest upstairs); {npc:246152}, the Paladin trainer, by the square"] = "",

	-- Step 30: Coleman Farthing and Gretchen Dedmar
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar
	["{npc:1500} and {npc:1521}"] = "",
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar · {area:159} Brill
	["Still in the inn: from level 7 {npc:1500} on the ground floor and {npc:1521} upstairs offer their quests; below 7 they wait for the next {area:159} visit."] = "",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, im Gasthaus",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "",

	-- Step 31: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Lager von {npc:1495}",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Folge der Straße von {area:159} nach Südosten an den Zeppelintürmen vorbei. Linnea, Kristof und {npc:3549} lagern an der Straße.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Bitte {npc:251001} um seinen Bericht",

	-- Step 32: Deathguard Dillinger
	-- {area:159} Brill
	["Back up the road and through {area:159} to its west end."] = "",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Bitte {npc:1496} um seinen Bericht",

	-- Step 33: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo · {npc:3549} Shelene Rhobart
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse · Decrepit Darkhounds = {npc:1547} Decrepit Darkhound
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Decrepit Darkhounds roam there and on west along the road toward {npc:10666}. Johaan wants their blood, {npc:3549} their hides."] = "",

	-- Step 34: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Bitte {npc:10666} um seinen Bericht",

	-- Step 35: Calvin Montague
	-- {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["{npc:6784} stands by the farmhouse at the {area:156}, on the way to the Crusader's Outpost."] = "",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Besiege {npc:6784} im Duell",

	-- Step 36: Crusader's Outpost
	["Crusader's Outpost"] = "Außenposten der Kreuzzügler",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost north-west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Eskortiere {npc:275954} aus dem Außenposten",

	-- Step 37: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back east along the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} von {npc:2118}, für Gretchen",

	-- Step 38: Tirisfal Glades: kill these as you meet them
	-- {zone:1420} Tirisfal Glades
	["{zone:1420}: kill these as you meet them"] = "",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart · {quest:5482} Doom Weed · {npc:1753} Maggot Eye
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north: Gretchen wants their pelts, {npc:3549} their wings.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}, where the Rot Hide Graverobbers dig; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone.\nThe Vile Fin murlocs line the north shore: they all drop the scales, and the Minor Oracles and Muckdwellers the skins for {npc:3549}."] = "",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "",

	-- Step 39: Brill
	-- {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["{npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "",

	-- Step 40: Deathguard Terrence
	-- {npc:1738} Deathguard Terrence · {quest:96895} The Argent Emissary · {npc:267009} Hadric Harlson · {area:159} Brill · {area:157} Agamand Mills
	["From level 10 {npc:1738} offers {quest:96895}: {npc:267009} waits at Linnea's camp, the next stop. Below 10 it waits for the {area:159} visit after {area:157}."] = "",

	-- Step 41: Deathguard Linnea's camp
	-- {area:159} Brill
	["Follow the road south-east from {area:159} past the zeppelin towers."] = "",

	-- Step 42: Hadric Harlson
	-- {npc:267009} Hadric Harlson
	["{npc:267009} stands at the camp beside Linnea."] = "",

	-- Step 43: Magistrate Sevren
	-- {area:159} Brill · {area:157} Agamand Mills
	["Back up the road to {area:159}, on the way north-west to {area:157}."] = "",

	-- Step 44: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, ein seltener Drop",
	["Only if the letter dropped"] = "Nur wenn der Brief gedroppt ist",

	-- Step 45: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, im Gasthaus",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} in {zone:1458} nimmt es an",
	-- {npc:1738} Deathguard Terrence · {area:159} Brill
	["{npc:1738}, if you were below 10 on the last {area:159} visit"] = "",

	-- Step 46: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "",

	-- Step 47: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Geh von {area:159} nach Süden zu {area:153} und hinab nach {zone:1458}. {npc:5675} steht im {object:36082}. Das scharlachrote Lager liegt direkt westlich der Ruinen.",

	-- Step 48: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Geh von {area:159} nach Süden zu {area:153} und hinab nach {zone:1458}. {npc:4568} steht im {object:36082}. Das scharlachrote Lager liegt direkt westlich der Ruinen.",

	-- Step 49: Back to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Back to {zone:1420}"] = "",
	["The Scarlet camp"] = "Das scharlachrote Lager",

	-- Step 50: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Folge der Straße von {area:159} nach Südwesten zum Lager des Scharlachroten Kreuzzugs. {npc:1662} steht an seinem Südende; jeder Scharlachrote dort kann einen Ring fallen lassen.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "",

	-- Step 51: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} steht neben {npc:1662} am Südende des Lagers.",

	-- Step 53: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp, on the road to the cult's farm."] = "",

	-- Step 54: Tirisfal Glades: kill these as you meet them
	-- {npc:1495} Deathguard Linnea
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Follow the road south-east past {npc:1495}'s camp: the Cult of the Damned holds the farm just south-east of it. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "",

	-- Step 55: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows: Linnea wants eight of each.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, im Garten des Hofs",

	-- Step 57: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back up the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:1518} Apothecary Johaan · {area:228} Sepulcher
	["{npc:1518}: for Renferrel at the {area:228}"] = "",
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the inn's cellar"] = "",

	-- Step 58: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10). They send you into the cellar under {area:16881}, the next stop."] = "",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Hör Leonid und {npc:246378} zu, dann sprich erneut mit ihm",

	-- Step 59: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "",

	-- Step 60: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Angreifer der Finsterflossen",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Seher der Finsterflossen",

	-- Step 61: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "",
	["the basement under the ruined house"] = "der Keller unter dem zerstörten Haus",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "",

	-- Step 62: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "",

	-- Step 63: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "",

	-- Step 64: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} liegt unter {area:153}, neben den Zeppelintürmen. {npc:5675} ist im {object:36082}: Benutze die {item:6284} am Beschwörungskreis neben ihm und besiege den Leerwandler. {npc:4606} ist im {object:36070}. {npc:4568} ist ebenfalls im {object:36082}.",

	-- Step 66: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "",
	-- {area:159} Brill · {zone:1421} Silverpine Forest
	["The next guide walks south from {area:159} into {zone:1421}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:159}."] = "Zurück nach {area:159}.",
	-- ["Back to {area:16881} and down into the basement under the ruined house: the Shadowvale Lurchers and Mystics there drop the bones, and the {item:286269} is at the basement's south end."] = "Zurück nach {area:16881} und hinunter in den Keller unter dem zerstörten Haus: Die Schattentalschlinger und Mystiker dort lassen die Knochen fallen, und {item:286269} liegt am Südende des Kellers.",
	-- ["Back up the road to {area:159}."] = "Die Straße hinauf zurück nach {area:159}.",
	-- ["Balnir graves"] = "Gräber von Balnirs Bauernhof",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Nachtsauger und Schattenhunde streifen überall entlang der Straße zurück nach Westen umher; sammle unterwegs die restlichen Flügel und Felle.",
	-- ["Fields west of {area:159}"] = "Felder westlich von {area:159}",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Folge der Straße nach Osten nach {area:159}. {npc:10665} steht am Nordwestrand des Ortes; {area:2119} ist das große Gasthaus in der Mitte, mit {npc:1515} davor.",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Folge der Straße nach Osten. Blutende Schrecken und Wandernde Geister spuken bei den Gräbern auf der Ostseite des Hofs, wo {quest:99142} wächst.",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Folge der Straße von {area:159} nach Nordosten an {area:162} vorbei. {npc:1665} und seine zwei Scharlachroten Leibwachen halten den scharlachroten Wachturm an der Nordostküste, nördlich von {area:459}: Zieh zuerst die Leibwachen.",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Folge der Straße nach Nordwesten zu {area:157}. {npc:1657} geht über den Friedhof südlich der Mühlen; Nissa, Gregor und {npc:1656} spuken in den Mühlen selbst. Klappernde Skelettsoldaten und Trümmerschädelsoldaten lassen die Rippen fallen, Dunkle Skelettmagier die Schädel, und jeder von ihnen kann {item:2839} fallen lassen. Töte ab hier die Nachtsauger und Schattenhunde, an denen du vorbeikommst: {npc:3549} will ihre Flügel und Felle.",
	-- ["Follow the road south back to {area:159}."] = "Folge der Straße nach Süden zurück nach {area:159}.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Folge der Straße nach Westen an {area:157} vorbei zu {area:16616}. Leonid steht direkt nördlich von {npc:246389}s Lager.",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "Befreie sechs eingesponnene Opfer in der Höhle für {npc:244808}",
	-- ["Greater Duskbats"] = "Große Nachtsauger",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Große Nachtsauger fliegen über die Felder um {area:159} und entlang der Straße nach Norden.",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Geh nach Westen in {area:16616}; {npc:246389} und {npc:259190} lagern an seinem Rand.",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Geh nach Westen zur Höhle. Die Jungen Nachtweber sitzen draußen; die Nachtweber und die eingesponnenen Opfer sind drinnen.",
	-- ["Hearth to {area:159}"] = "Ruhestein nach {area:159}",
	-- ["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Verlass {area:154} über die Straße nach Nordosten. {npc:6784} steht beim Bauernhaus auf {area:156}.",
	-- ["More Vile Fin murlocs walk the shore just north of the outpost."] = "Weitere Murlocs der Finsterflossen laufen am Ufer direkt nördlich des Außenpostens.",
	-- ["Paladin: {area:16616}"] = "Paladin: {area:16616}",
	-- ["Paladin: {area:16881}"] = "Paladin: {area:16881}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladine: {quest:90902} ist erledigt, sobald du fünf {npc:259377} rund um die Kirche mit {spell:635} geheilt hast.",
	-- ["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Klappernde Skelette streifen durch die zerstörten Häuser in der Nordhälfte von {area:154}. Junge Aasfresser und Nachtsauger streifen überall im Dorf umher; die Struppigen Aasfresser und Räudigen Nachtsauger sind auf seiner Ostseite.",
	-- ["Rattlecage skulls"] = "Schädel klappernder Skelette",
	-- ["Rattlecages, scavengers and duskbats"] = "Klappernde Skelette, Aasfresser und Nachtsauger",
	-- ["Rot Hide graveyards"] = "Friedhöfe der Moderfelle",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Scharlachrote Krieger bewachen den Außenposten direkt westlich der Kürbisfelder. {npc:275954} wird drinnen festgehalten: Sprich mit ihm und bleib bei ihm, bis er draußen ist.",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Nimm die Straße von {area:159} nach Südosten; Terrence steht darauf, kurz vor den Zeppelintürmen.",
	-- ["Talk to {npc:265944}"] = "Sprich mit {npc:265944}",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Die Klappernden Skelette in den zerstörten Häusern lassen die Schädel fallen.",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Die Grabräuber der Moderfelle graben auf den Friedhöfen nördlich von {area:159}; alle Moderfelle lassen das Sekret fallen.",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Die Bastarde der Moderfelle halten die Hügel weiter nördlich. {npc:1753} (Stufe 11) steht in ihrem Lager auf dem Hügel südlich des Ufers: Räum zuerst die Gnolle um ihn herum weg.",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Die Scharlachroten Ordensmitglieder lagern direkt nordöstlich der Gräber; {npc:1664} steht zwischen ihnen.",
	-- ["The Vile Fin murlocs line the north shore."] = "Die Murlocs der Finsterflossen säumen das Nordufer.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Die Kürbisse wachsen auf den von den Scharlachroten gehaltenen Feldern nordwestlich von Sollidens Bauernhof.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "Die Spinnen lauern in den Wäldern am äußersten Ostende von Tirisfal.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Die Spinnen lauern in den Wäldern am äußersten Ostende von Tirisfal. {npc:276020}, eine abtrünnige Monstrosität, streift direkt nordwestlich von ihnen umher. {npc:276020} ist Elite: Eine Gruppe wird empfohlen.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Der Zeppelin landet am Turm direkt nordöstlich des Haupttors von {zone:1454}. Folge der Straße nach Süden nach {zone:1411}, überquere die Brücke über {area:815} unterhalb von {area:379} und folge der Straße nach Westen nach {area:380}.",
	-- ["The {area:159} trainers are in and around the inn"] = "Die Lehrer von {area:159} sind im Gasthaus und drumherum",
	-- ["The {npc:1931}, in the town hall basement"] = "Der {npc:1931}, im Keller des Rathauses",
	-- ["The {npc:2211}, in the town hall basement"] = "Der {npc:2211}, im Keller des Rathauses",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} wächst auf den Friedhofsfeldern direkt nördlich von {area:159}.",
	-- ["Vicious Night Web Spiders"] = "Heimtückische Nachtweber",
	-- ["Vile Fin murlocs"] = "Murlocs der Finsterflossen",
	-- ["Vile Fin shore"] = "Ufer der Finsterflossen",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "Geh weiter nach Westen zu {area:156}. {npc:1519} steht beim Hof; {npc:6784}, beim Bauernhaus, will ein Duell: Sprich mit ihm.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Geh weiter nach Westen zu {npc:6784} und sprich mit ihm: Er will ein Duell.",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Geh von {area:159} nach Südosten zu den Zeppelintürmen vor {area:153} und steig in den Zeppelin nach {zone:1454} (der andere fliegt nach {object:3202}).",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Geh von den Mühlen nach Südwesten: Die Kürbisse wachsen auf den von den Scharlachroten gehaltenen Feldern nordwestlich von Sollidens Bauernhof.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Geh nach Südwesten zu {area:156}; Simmer steht beim Hof.",
	-- ["Webbed Victims"] = "Eingesponnene Opfer",
	-- ["Zeppelin to {zone:1411}"] = "Zeppelin nach {zone:1411}",
	-- ["Zeppelin tower"] = "Zeppelinturm",
	-- ["in the inn: ask him about cooking"] = "im Gasthaus: Frag ihn nach dem Kochen",
	-- ["{area:16881} is the hollow at the west edge of the glades. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "{area:16881} ist die Senke am Westrand der Lichtungen. Geh hinunter in den großen Keller unter dem zerstörten Haus (nur ein Boden und ein paar Säulen sind übrig, nicht das zweistöckige Haus): Die Flaschen liegen auf seinem Boden zwischen den Schattentalschlingern und Mystikern.",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} ist die Senke am Westrand von Tirisfal. Die Schattentalschlinger und Schattentalmystiker lassen die Knochen fallen; die Flaschen liegen zwischen ihnen am Boden, und {item:286269} ist am Südende.",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}, von {npc:276020}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, die große Monstrosität, geht ein Stück weiter östlich die Straße entlang. Das {item:12737} wächst entlang der Straße um ihn herum.",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, eine Elite-Monstrosität im Osten",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} steht in {area:159}. {npc:6390} wartet im Mausoleum auf dem Hügel direkt nördlich des Ortes: Öffne das Tor und kämpfe gegen ihn.",
	-- ["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} und Verheerte Kadaver schlurfen über die Felder direkt westlich von {area:159}; Schattenhunde streifen etwas weiter westlich umher, Richtung {npc:10666}.",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}, neben der Kirche",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} steht am Südende des scharlachroten Bauernhofs.",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}, der Kriegerlehrer",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}, neben Johaan",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808} und {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} und {npc:5667} stehen neben der Kirche.",
	-- ["{npc:246389} and {npc:259190} camp at the forest's edge, just south of Leonid. Their quests need level 10."] = "{npc:246389} und {npc:259190} lagern am Waldrand, direkt südlich von Leonid. Ihre Quests brauchen Stufe 10.",
	-- ["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} steht im Lager von {npc:1495}.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, der Windreitermeister",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: Der {npc:246143} ist in die Hügel direkt westlich der Kirche geflohen.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} hält den Hof direkt südöstlich des Lagers. Die Nekrotischen Kristallfragmente liegen zwischen den Kultisten am Boden, und die Kultisten tragen auch einige bei sich.",
}
