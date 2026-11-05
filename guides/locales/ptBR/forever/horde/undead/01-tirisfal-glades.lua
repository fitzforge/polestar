-- Portuguese (Brazil) (ptBR): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "Você se levanta na cripta no extremo sul de {area:154}. {npc:1568} espera logo do lado de fora.",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "Siga a trilha para o norte até {area:154}; Sarvis fica em frente à igreja.",
	["Inside"] = "",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Zumbis Desmiolados",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Os zumbis se arrastam pelo cemitério e pelas casas logo a leste da igreja.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: o pergaminho para {npc:244808}",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}, o instrutor de ladino",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}, o instrutor de sacerdote, na igreja",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}, a instrutora de mago, na igreja",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}, o instrutor de bruxo",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "Os instrutores de {area:154} ficam em volta da igreja",

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "",

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
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Esqueletos Range-ossos vagam pelas casas em ruínas na metade norte de {area:154}. Carniceiros Jovens e Quiropúsculos vagam por toda a vila; os Carniceiros Rotos e os Quiropúsculos Sarnentos ficam no lado leste.",

	-- Step 8: Back to the church
	["Back to the church"] = "De volta à igreja",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, na igreja",

	-- Step 9: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "As {object:164662} ficam ao lado das casas em ruínas no norte de {area:154}.",

	-- Step 10: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "De volta a {area:154}",

	-- Step 11: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "O {npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Ofereça ajuda ao {npc:246143}",

	-- Step 12: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "",
	["Below ground"] = "",
	["attack the cocoons inside the cave to free them; below ground"] = "",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "A fazenda Escarlate",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Os Neófitos e Iniciados Escarlates ocupam a fazenda a leste de {area:154}. {npc:1919} anda entre as casas da fazenda: os restos dele são para {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, de {npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "O {object:178090} fica no cemitério de {area:154}, ao lado da igreja.",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Saia de {area:154} pela estrada a nordeste. {npc:6784} fica perto da casa da {area:156}.",

	-- Step 20: Gordo on the road to Brill
	-- {npc:10666} Gordo · {area:159} Brill
	["{npc:10666} on the road to {area:159}"] = "",
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {quest:5481} Gordo's Task · {item:12737} Gloom Weed
	["{npc:10666} walks the road between {area:166} and {area:159}: take {quest:5481} when you pass him and pick the {item:12737} along the road."] = "",

	-- Step 21: Brill
	-- {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["The {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, na prefeitura",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Use o {item:286176} em cinco Necroguardas ociosos pela cidade",

	-- Step 23: Brill
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742} stands by Dillinger a few minutes, then walks up to the graveyard north of town and back"] = "",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Peça o relatório a {npc:1496}",

	-- Step 24: Dry Branches
	["Dry Branches"] = "Galhos Secos",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Os Galhos Secos ficam no chão em volta da borda sudoeste de {area:159}.",

	-- Step 25: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleonora acampa logo a sudoeste da cidade.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "",

	-- Step 26: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} e Cadáveres Assolados se arrastam pelos campos logo a oeste de {area:159}; Cães das Trevas vagam um pouco mais a oeste, rumo a {npc:10666}.",

	-- Step 27: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Peça o relatório a {npc:10666}",

	-- Step 28: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "",

	-- Step 29: Calvin Montague
	-- {npc:1519} Deathguard Simmer · {area:156} Solliden Farmstead
	["{npc:1519} stands by the road at the {area:156}."] = "",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Vença {npc:6784} no duelo",

	-- Step 30: Hearth to Gallows' End Tavern
	-- {area:2119} Gallows' End Tavern
	["Hearth to {area:2119}"] = "",

	-- Step 31: Brill
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, a instrutora de Paladino",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "Os instrutores de {area:159} ficam dentro e em volta da estalagem",

	-- Step 32: Brill
	["The Wanted poster by the inn"] = "O cartaz de procura-se perto da estalagem",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} de {npc:2118}, para Gretchen",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, na estalagem",
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
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Siga a estrada para sudeste a partir de {area:159}, passando as torres de zepelim. Lina, Kristof e {npc:3549} acampam junto à estrada.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Peça o relatório a {npc:251001}",

	-- Step 36: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "Volte pela estrada até {area:159}.",

	-- Step 37: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, item raro",
	["Only if the letter dropped"] = "Só se a carta tiver caído",

	-- Step 38: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Abóboras de Tirisfal",
	["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "",

	-- Step 39: Crusader's Outpost
	["Crusader's Outpost"] = "Posto avançado dos Cruzados",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Escolte {npc:275954} para fora do posto avançado",

	-- Step 40: Vile Fin shore
	["Vile Fin shore"] = "Margem dos Pinavil",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "Mais murlocs Pinavil andam pela margem logo ao norte do posto avançado.",

	-- Step 41: Brill
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "O {npc:1931}, no porão da prefeitura",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} em {zone:1458} a recebe",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, inside"] = "",
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, na estalagem",

	-- Step 42: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} fica em {area:159}. {npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e lute com ele.",

	-- Step 43: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Ande para o sul de {area:159} até as {area:153} e desça até {zone:1458}. {npc:5675} fica no {object:36082}. O acampamento Escarlate fica logo a oeste das ruínas.",

	-- Step 44: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Ande para o sul de {area:159} até as {area:153} e desça até {zone:1458}. {npc:4568} fica no {object:36082}. O acampamento Escarlate fica logo a oeste das ruínas.",

	-- Step 45: Back to Tirisfal Glades
	-- {area:85} Tirisfal Glades
	["Back to {area:85}"] = "",

	-- Step 46: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Siga a estrada para sudoeste a partir de {area:159} até o acampamento da Cruzada Escarlate. {npc:1662} fica no extremo sul; todo Escarlate de lá pode deixar cair um anel.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "",

	-- Step 47: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "O {object:37098} fica ao lado de {npc:1662}, no extremo sul do acampamento.",

	-- Step 49: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} fica no acampamento de {npc:1495}.",

	-- Step 50: Decrepit Darkhound on the way
	-- {npc:1547} Decrepit Darkhound
	["{npc:1547} on the way"] = "",

	-- Step 51: Tirisfal Glades: kill these as you meet them
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Duskbats = {npc:1512} Duskbat · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way.\n{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "",

	-- Step 52: On the way
	-- {npc:1529} Bleeding Horror · {npc:1495} Deathguard Linnea
	["{npc:1529} along the way to {npc:1495}'s camp"] = "",
	-- {npc:1532} Wandering Spirit · {npc:1495} Deathguard Linnea
	["{npc:1532} along the way to {npc:1495}'s camp"] = "",

	-- Step 53: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, na horta da fazenda",

	-- Step 55: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Acampamento de {npc:1495}",

	-- Step 56: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "O {npc:2211}, no porão da prefeitura",

	-- Step 57: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Paladins take both quests; anyone else takes them if they are offered, and walks on if not. Both send you into the cellar under {area:16881}, the next stop."] = "",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Ouça Leonid e {npc:246378}, depois fale com ele de novo",

	-- Step 58: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "",

	-- Step 59: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "",

	-- Step 60: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "",
	["the basement under the ruined house"] = "",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "",

	-- Step 61: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "",

	-- Step 62: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "",

	-- Step 64: The Undercity
	-- {object:1661} The Undercity (no name in this language: may be words) · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words) · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter (no name in this language: may be words) · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} fica embaixo das {area:153}, ao lado das torres de zepelim. {npc:5675} fica no {object:36082}: use as {item:6284} no círculo de evocação ao lado dele e derrote o emissário do caos. {npc:4606} fica no {object:36070}. {npc:4568} também fica no {object:36082}.",

	-- Step 66: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "",

	-- Step 67: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "",

	-- Step 69: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/sit by her campfire until you get {spell:1229451}"] = "Use /sit junto à fogueira dela até receber {spell:1229451}",
	-- ["Back to {area:159}."] = "De volta a {area:159}.",
	-- ["Balnir graves"] = "Túmulos dos Balnir",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Quiropúsculos e Cães das Trevas vagam por toda a estrada de volta para oeste; termine as asas e os pelegos no caminho.",
	-- ["Fields west of {area:159}"] = "Campos a oeste de {area:159}",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Siga a estrada para leste até {area:159}. {npc:10665} fica na borda noroeste da cidade; a {area:2119} é a grande estalagem no meio, com {npc:1515} em frente.",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Siga a estrada para leste. Horrores Sangrentos e Espíritos Errantes assombram os túmulos no lado leste da fazenda, onde cresce a {quest:99142}.",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Siga a estrada para nordeste a partir de {area:159}, passando o {area:162}. {npc:1665} e seus dois Guarda-costas Escarlates ocupam a torre de vigia Escarlate na costa nordeste, ao norte do {area:459}: atraia primeiro os guarda-costas.",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Siga a estrada para noroeste até a {area:157}. {npc:1657} anda pelo cemitério ao sul dos moinhos; Nissa, Gregor e {npc:1656} assombram os próprios moinhos. Soldados Range-ossos e do Crânio Partido deixam cair as costelas, Osteurgos Olhonegro os crânios, e qualquer um deles pode deixar cair {item:2839}. Daqui em diante, mate os Quiropúsculos e Cães das Trevas que encontrar: {npc:3549} quer as asas e os pelegos deles.",
	-- ["Follow the road south back to {area:159}."] = "Siga a estrada para o sul de volta a {area:159}.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Siga a estrada para oeste passando a {area:157} até a {area:16616}. Leonid fica logo ao norte do acampamento de {npc:246389}.",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "Liberte seis vítimas enredadas dentro da caverna para {npc:244808}",
	-- ["Greater Duskbats"] = "Grandes Quiropúsculos",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Grandes Quiropúsculos voam sobre os campos em volta de {area:159} e ao longo da estrada ao norte.",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Siga para oeste até a {area:16616}; {npc:246389} e {npc:259190} acampam na borda dela.",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Siga para oeste até a caverna. As Trevateias Jovens ficam do lado de fora; as Trevateias e as vítimas enredadas ficam lá dentro.",
	-- ["Hearth to {area:159}"] = "Regressar para {area:159}",
	-- ["Paladin: {area:16616}"] = "Paladino: {area:16616}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladinos: {quest:90902} se completa quando você curar cinco {npc:259377} em volta da igreja com {spell:635}.",
	-- ["Rattlecage skulls"] = "Crânios de Range-ossos",
	-- ["Rattlecages, scavengers and duskbats"] = "Range-ossos, carniceiros e quiropúsculos",
	-- ["Rot Hide graveyards"] = "Cemitérios dos Putricouro",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Guerreiros Escarlates guardam o posto avançado logo a oeste dos campos de abóbora. {npc:275954} está preso lá dentro: fale com ele e fique com ele até ele sair.",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Pegue a estrada para sudeste saindo de {area:159}; Terêncio fica nela antes das torres de zepelim.",
	-- ["Talk to {npc:265944}"] = "Fale com {npc:265944}",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Os Esqueletos Range-ossos nas casas em ruínas deixam cair os crânios.",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Os Roubacovas Putricouro cavam pelos cemitérios ao norte de {area:159}; todos os Putricouro deixam cair a linfa.",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Os Mestiços Putricouro ocupam as colinas mais ao norte. {npc:1753} (nível 11) fica no acampamento deles na colina ao sul da margem: elimine primeiro os gnolls em volta dele.",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Os Frades Escarlates acampam logo a nordeste dos túmulos; {npc:1664} fica entre eles.",
	-- ["The Scarlet camp"] = "O acampamento Escarlate",
	-- ["The Vile Fin murlocs line the north shore."] = "Os murlocs Pinavil ocupam a margem norte.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "As abóboras crescem nos campos ocupados pelos Escarlates a noroeste de Solliden.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "As aranhas espreitam na mata no extremo leste das clareiras.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "As aranhas espreitam na mata no extremo leste das clareiras. {npc:276020}, uma abominação desgarrada, vaga logo a noroeste delas. {npc:276020} é elite: é recomendado formar grupo.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "O zepelim pousa na torre logo a nordeste do portão principal de {zone:1454}. Siga a estrada para o sul até {zone:1411}, atravesse a ponte do {area:815} abaixo do {area:379} e siga a estrada para oeste até a {area:380}.",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "A {quest:5482} cresce nos campos do cemitério logo ao norte de {area:159}.",
	-- ["Vicious Night Web Spiders"] = "Trevateias Malévolas",
	-- ["Vile Fin murlocs"] = "Murlocs Pinavil",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "Siga para oeste até a {area:156}. {npc:1519} fica na fazenda; {npc:6784}, junto à casa da fazenda, quer um duelo: fale com ele.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Siga a pé para oeste até {npc:6784} e fale com ele: ele quer um duelo.",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Ande para sudeste de {area:159} até as torres de zepelim do lado de fora das {area:153} e embarque no zepelim para {zone:1454} (o outro vai para {object:3202}).",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Ande para sudoeste a partir dos moinhos: as abóboras crescem nos campos ocupados pelos Escarlates a noroeste de Solliden.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Ande para sudoeste até a {area:156}; Simério fica na fazenda.",
	-- ["Webbed Victims"] = "Vítimas enredadas",
	-- ["Zeppelin to {zone:1411}"] = "Zepelim para {zone:1411}",
	-- ["Zeppelin tower"] = "Torre de zepelim",
	-- ["in the inn: ask him about cooking"] = "na estalagem: pergunte a ele sobre culinária",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} é a depressão na borda oeste das clareiras. Os Saltadores e Místicos do Vale das Sombras deixam cair os ossos; as garrafas ficam no chão entre eles, e o {item:286269} fica no extremo sul.",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}, de {npc:276020}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, a grande abominação, anda pela estrada um pouco mais a leste. A {item:12737} cresce ao longo da estrada em volta dele.",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, uma abominação de elite no leste",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}, ao lado da igreja",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} fica no extremo sul da fazenda Escarlate.",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}, o instrutor de guerreiro",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}, ao lado de Joaquino",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808} e {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} e {npc:5667} ficam ao lado da igreja.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre de mantícoras",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: o {npc:246143} fugiu para as colinas logo a oeste da igreja.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} ocupa a fazenda logo a sudeste do acampamento. Os Fragmentos de Cristal Necrótico ficam no chão entre os sectários, e os sectários também levam alguns.",
}
