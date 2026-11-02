-- French (frFR): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "Vous vous relevez dans la crypte au sud de {area:154}. {npc:1568} attend juste devant.",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "Suivez le chemin vers le nord jusqu'à {area:154} ; Sarvis se tient devant l'église.",
	["Inside"] = "",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569} : le parchemin pour {npc:244808}",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Zombies lunatiques",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Les zombies errent autour du cimetière et des maisons juste à l'est de l'église.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}, maître des voleurs",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}, maître des prêtres, dans l'église",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}, maître des mages, dans l'église",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}, maître des démonistes",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "Les maîtres de {area:154} se tiennent autour de l'église",

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with Holy Light."] = "",

	-- Step 6: On the way
	["On the way"] = "",
	-- {item:3265} Scavenger Paw
	["{item:3265} along the way to Back to the church"] = "",
	-- {item:3264} Duskbat Wing
	["{item:3264} along the way to Back to the church"] = "",

	-- Step 7: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Les Squelettes Cliquethorax errent dans les maisons en ruine de la moitié nord de {area:154}. Les Jeunes charognards et les Chauves-souris du crépuscule rôdent tout autour du village ; les Charognards pouilleux et les Chauves-souris du crépuscule galeuses sont du côté est.",

	-- Step 8: Back to the church
	["Back to the church"] = "Retour à l'église",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard
	["{npc:244808}: Holy Light, once five {npc:259377} are healed"] = "",
	-- {npc:5667} Venya Marthand
	["{npc:5667}: Summon Imp"] = "",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, dans l'église",

	-- Step 9: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "Les {object:164662} se trouvent à côté des maisons en ruine au nord de {area:154}.",

	-- Step 10: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "Retour à {area:154}",

	-- Step 11: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Proposez votre aide : {npc:246143}",

	-- Step 12: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "",
	["Below ground"] = "",
	["attack the cocoons inside the cave to free them; below ground"] = "",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "La ferme écarlate",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Les Convertis écarlates et les Initiés écarlates tiennent la ferme à l'est de {area:154}. {npc:1919} erre entre les bâtiments : sa dépouille sert pour {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, sur {npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} est dans le cimetière de {area:154}, à côté de l'église.",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Quittez {area:154} par la route du nord-est. {npc:6784} se tient près de la ferme : {area:156}.",

	-- Step 20: Deathskip to Brill
	-- {area:159} Brill
	["Deathskip to {area:159}"] = "",
	-- {npc:1547} Decrepit Darkhound · {npc:6491} Spirit Healer
	["Die to the mobs at 44.8,54.4 ({npc:1547}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 21: Brill
	-- {area:159} Brill · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. The {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "Les maîtres de {area:159} sont dans l'auberge et autour",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, dans l'hôtel de ville",
	["The Wanted poster by the inn"] = "L'avis de recherche près de l'auberge",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Utilisez {item:286176} sur cinq gardes noirs oisifs dans le village",

	-- Step 23: Brill
	-- {npc:10665} Junior Apothecary Holland
	["{npc:10665} stands at the north-west edge of town."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742} stands by Dillinger a few minutes, then walks up to the graveyard north of town and back"] = "",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, maître des paladins",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Demandez son rapport à {npc:1496}",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "",

	-- Step 24: Putrid Claw on the way
	-- {item:2855} Putrid Claw
	["{item:2855} on the way"] = "",

	-- Step 25: Dry Branches
	["Dry Branches"] = "Dry Branches",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Les Dry Branches sont au sol autour de la lisière sud-ouest de {area:159}.",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleanor campe juste au sud-ouest du village.",
	["/sit by her campfire until you get Boosted Rest"] = "",

	-- Step 27: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} et les Cadavres décomposés errent dans les champs juste à l'ouest de {area:159} ; les sombredogues rôdent un peu plus à l'ouest, vers {npc:10666}.",

	-- Step 28: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Demandez son rapport à {npc:10666}",

	-- Step 29: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "",

	-- Step 30: Calvin Montague
	-- {npc:1519} Deathguard Simmer · {area:156} Solliden Farmstead
	["{npc:1519} stands by the road at the {area:156}."] = "",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Battez {npc:6784} en duel",

	-- Step 31: Hearth to Gallows' End Tavern
	-- {area:2119} Gallows' End Tavern
	["Hearth to {area:2119}"] = "",

	-- Step 32: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} auprès de {npc:2118}, pour Gretchen",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, dans l'auberge",
	-- {npc:265944} William Pickman
	["{npc:265944}, in the inn: Camping 101 asks you to learn it; upstairs"] = "",

	-- Step 33: Tirisfal Glades: kill these as you meet them
	-- {area:85} Tirisfal Glades
	["{area:85}: kill these as you meet them"] = "",
	-- {area:159} Brill · {npc:1753} Maggot Eye · {quest:5482} Doom Weed
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north.\nThe Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nThe Vile Fin murlocs line the north shore.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone."] = "",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "",

	-- Step 34: Brill
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "",

	-- Step 35: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Suivez la route au sud-est de {area:159} au-delà des tours des zeppelins. Linnea, Kristof et {npc:3549} campent au bord de la route.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Demandez son rapport à {npc:251001}",

	-- Step 36: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "Remontez la route jusqu'à {area:159}.",

	-- Step 37: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, butin rare",
	["Only if the letter dropped"] = "Seulement si vous avez obtenu la lettre",

	-- Step 38: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Potirons de Tirisfal",
	["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "",

	-- Step 39: Crusader's Outpost
	["Crusader's Outpost"] = "Avant-poste des Croisés",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Escortez {npc:275954} hors de l'avant-poste",

	-- Step 40: Vile Fin shore
	["Vile Fin shore"] = "Rivage des Aileron noir",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "D'autres murlocs Aileron noir arpentent le rivage juste au nord de l'avant-poste.",

	-- Step 41: Brill
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "{npc:1931}, au sous-sol de l'hôtel de ville",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128} : {npc:4568}, à {zone:1458}, s'en charge",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, inside"] = "",
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, dans l'auberge",

	-- Step 42: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} se tient à {area:159}. {npc:6390} attend dans le mausolée sur la colline juste au nord du village : ouvrez la grille et combattez-le.",
	-- {npc:1496} Deathguard Dillinger
	["{npc:1496}: Defensive Stance"] = "",

	-- Step 43: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Marchez vers le sud depuis {area:159} jusqu'aux {area:153} et descendez à {zone:1458}. {npc:5675} se tient dans le {object:36082}. Le camp écarlate est juste à l'ouest des ruines.",

	-- Step 44: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Marchez vers le sud depuis {area:159} jusqu'aux {area:153} et descendez à {zone:1458}. {npc:4568} se tient dans le {object:36082}. Le camp écarlate est juste à l'ouest des ruines.",

	-- Step 45: Back to Tirisfal Glades
	-- {area:85} Tirisfal Glades
	["Back to {area:85}"] = "",

	-- Step 46: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Suivez la route au sud-ouest de {area:159} jusqu'au camp de la Croisade écarlate. {npc:1662} se tient à son extrémité sud ; chaque membre de la Croisade écarlate peut y lâcher un anneau.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "",

	-- Step 47: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} se trouve à côté de {npc:1662}, à l'extrémité sud du camp.",

	-- Step 49: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} se tient au camp de {npc:1495}.",

	-- Step 50: Tirisfal Glades: kill these as you meet them
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Duskbats = {npc:1512} Duskbat · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way.\n{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "",

	-- Step 51: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, dans le jardin de la ferme",

	-- Step 52: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Camp de {npc:1495}",

	-- Step 53: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "{npc:2211}, au sous-sol de l'hôtel de ville",

	-- Step 54: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Paladins take both quests; anyone else takes them if they are offered, and walks on if not. Both send you into the cellar under {area:16881}, the next stop."] = "",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Écoutez Leonid et {npc:246378}, puis reparlez-lui",

	-- Step 55: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "",

	-- Step 56: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "",

	-- Step 57: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "",
	["the basement under the ruined house"] = "",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "",

	-- Step 58: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "",

	-- Step 59: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "",

	-- Step 61: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} est sous les {area:153}, à côté des tours des zeppelins. {npc:5675} est dans le {object:36082} : utilisez les {item:6284} sur le cercle d'invocation à côté de lui et battez le marcheur du Vide. {npc:4606} est dans le {object:36070}. {npc:4568} est aussi dans le {object:36082}.",
	-- {npc:5675} Carendin Halgar
	["{npc:5675}: Summon Voidwalker"] = "",

	-- Step 63: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "",

	-- Step 64: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "",

	-- Step 66: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/sit by her campfire until you get {spell:1229451}"] = "/sit près de son feu de camp jusqu'à obtenir {spell:1229451}",
	-- ["Back to {area:159}."] = "Retour à {area:159}.",
	-- ["Balnir graves"] = "Tombes des Balnir",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Les chauves-souris du crépuscule et les sombredogues rôdent tout le long de la route vers l'ouest ; finissez les ailes et les peaux en chemin.",
	-- ["Fields west of {area:159}"] = "Champs à l'ouest de {area:159}",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Suivez la route vers l'est jusqu'à {area:159}. {npc:10665} se tient à la lisière nord-ouest du village ; {area:2119} est la grande auberge au centre, avec {npc:1515} devant.",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Suivez la route vers l'est. Les Horreurs sanguinolentes et les Esprits vagabonds hantent les tombes à l'est de la ferme, là où poussent les {quest:99142}.",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Suivez la route au nord-est de {area:159} au-delà de {area:162}. {npc:1665} et ses deux Gardes du corps écarlates tiennent la tour de guet écarlate sur la côte nord-est, au nord de {area:459} : attirez d'abord les gardes du corps.",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Suivez la route au nord-ouest jusqu'à {area:157}. {npc:1657} arpente le cimetière au sud des moulins ; Nissa, Gregor et {npc:1656} hantent les moulins eux-mêmes. Les Soldats Cliquethorax et les Soldats Squelettes lâchent les côtes, les Ossomanciens Sombroeil les crânes, et chacun d'eux peut lâcher {item:2839}. Dès maintenant, tuez les chauves-souris du crépuscule et les sombredogues sur votre chemin : {npc:3549} veut leurs ailes et leurs peaux.",
	-- ["Follow the road south back to {area:159}."] = "Suivez la route vers le sud pour revenir à {area:159}.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Suivez la route vers l'ouest au-delà de {area:157} jusqu'à {area:16616}. Leonid se tient juste au nord du camp de {npc:246389}.",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "Libérez six Webbed Victims dans la grotte pour {npc:244808}",
	-- ["Greater Duskbats"] = "Grandes chauves-souris du crépuscule",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Les Grandes chauves-souris du crépuscule volent au-dessus des champs autour de {area:159} et le long de la route du nord.",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Allez à l'ouest jusqu'à {area:16616} ; {npc:246389} et {npc:259190} campent à sa lisière.",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Allez à l'ouest jusqu'à la grotte. Les Jeunes Tisse-nuit sont dehors ; les Araignées Tisse-nuit et les Webbed Victims sont à l'intérieur.",
	-- ["Hearth to {area:159}"] = "Pierre de foyer vers {area:159}",
	-- ["Paladin: {area:16616}"] = "Paladin : {area:16616}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladins : {quest:90902} est terminée une fois que vous avez soigné cinq {npc:259377} autour de l'église avec {spell:635}.",
	-- ["Rattlecage skulls"] = "Crânes de Cliquethorax",
	-- ["Rattlecages, scavengers and duskbats"] = "Cliquethorax, charognards et chauves-souris du crépuscule",
	-- ["Rot Hide graveyards"] = "Cimetières des Poil-Putride",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Les Guerriers écarlates gardent l'avant-poste juste à l'ouest des champs de potirons. {npc:275954} est retenu à l'intérieur : parlez-lui et restez avec lui jusqu'à ce qu'il soit sorti.",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Prenez la route du sud-est en quittant {area:159} ; Terrence s'y tient, avant les tours des zeppelins.",
	-- ["Talk to {npc:265944}"] = "Parlez à {npc:265944}",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Les Squelettes Cliquethorax des maisons en ruine lâchent les crânes.",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Les Profanateurs Poil-Putride ({npc:1941}) fouillent les cimetières au nord de {area:159} ; tous les Poil-Putride lâchent l'ichor.",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Les Bâtards Poil-Putride ({npc:1675}) tiennent les collines plus au nord. {npc:1753} (niveau 11) se tient dans leur camp sur la colline au sud du rivage : éliminez d'abord les gnolls autour de lui.",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Les Frères écarlates campent juste au nord-est des tombes ; {npc:1664} se tient parmi eux.",
	-- ["The Scarlet camp"] = "Le camp écarlate",
	-- ["The Vile Fin murlocs line the north shore."] = "Les murlocs Aileron noir bordent le rivage nord.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Les potirons poussent dans les champs tenus par la Croisade écarlate au nord-ouest de la ferme des Solliden.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "Les araignées rôdent dans les bois à l'extrémité est des clairières.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Les araignées rôdent dans les bois à l'extrémité est des clairières. {npc:276020}, une abomination renégate, erre juste au nord-ouest. {npc:276020} est élite : mieux vaut former un groupe.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Le zeppelin arrive à la tour juste au nord-est de la porte principale d'{zone:1454}. Suivez la route vers le sud jusqu'en {zone:1411}, franchissez le pont sur le {area:815} sous {area:379} et suivez la route vers l'ouest jusqu'à la {area:380}.",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} : elles poussent dans les champs du cimetière juste au nord de {area:159}.",
	-- ["Vicious Night Web Spiders"] = "Tisse-nuit vicieuses",
	-- ["Vile Fin murlocs"] = "Murlocs Aileron noir",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "Continuez vers l'ouest jusqu'à {area:156}. {npc:1519} se tient à la ferme ; {npc:6784}, près de la maison, veut un duel : parlez-lui.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Continuez vers l'ouest jusqu'à {npc:6784} et parlez-lui : il veut un duel.",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Marchez vers le sud-est depuis {area:159} jusqu'aux tours des zeppelins devant les {area:153} et montez dans le zeppelin pour {zone:1454} (l'autre va à {object:3202}).",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Marchez vers le sud-ouest depuis les moulins : les potirons poussent dans les champs tenus par la Croisade écarlate au nord-ouest de la ferme des Solliden.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Marchez vers le sud-ouest jusqu'à {area:156} ; Simmer se tient à la ferme.",
	-- ["Webbed Victims"] = "Webbed Victims",
	-- ["Zeppelin to {zone:1411}"] = "Zeppelin pour {zone:1411}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["in the inn: ask him about cooking"] = "dans l'auberge : interrogez-le sur la cuisine",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} est le creux à la lisière ouest des clairières. Les Titubeurs ({npc:260428}) et Mystiques d'Ombreval lâchent les os ; les bouteilles sont au sol parmi eux, et {item:286269} est à l'extrémité sud.",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}, sur {npc:276020}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, la grosse abomination, arpente la route un peu plus à l'est. L'{item:12737} pousse le long de la route autour de lui.",
	-- ["{npc:14235} Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Les Bâtards Poil-Putride ({npc:14235}) tiennent les collines plus au nord. {npc:1753} (niveau 11) se tient dans leur camp sur la colline au sud du rivage : éliminez d'abord les gnolls autour de lui.",
	-- ["{npc:14235} Hide graveyards"] = "Cimetières des Poil-Putride ({npc:14235})",
	-- ["{npc:14235} Hide {quest:358} dig through the graveyards north of {area:159}; all the {npc:14235} Hides drop the ichor."] = "{quest:358} : les Profanateurs Poil-Putride fouillent les cimetières au nord de {area:159} ; tous les Poil-Putride lâchent l'ichor ({npc:14235} / {npc:14235}).",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495} : {npc:276020}, une abomination élite à l'est",
	-- ["{npc:1496}: Defensive Stance"] = "{npc:1496} : Posture défensive",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}, à côté de l'église",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} se tient au sud de la ferme écarlate.",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}, maître des guerriers",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}, à côté de Johaan",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808} et {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} et {npc:5667} se tiennent à côté de l'église.",
	-- ["{npc:244808}: Holy Light"] = "{npc:244808} : Lumière sacrée",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, maître des coursiers du vent",
	-- ["{npc:5667}: Summon Imp"] = "{npc:5667} : Invocation d'un diablotin",
	-- ["{npc:5675}: Summon Voidwalker"] = "{npc:5675} : Invocation d'un marcheur du Vide",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208} : {npc:246143} s'est enfui dans les collines juste à l'ouest de l'église.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} tient la ferme juste au sud-est du camp. Les Fragments de cristal nécrotique sont au sol parmi les cultistes, et les cultistes en portent aussi.",
}
