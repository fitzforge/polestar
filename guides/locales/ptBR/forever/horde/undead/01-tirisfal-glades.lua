-- Portuguese (Brazil) (ptBR): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Zumbis Desmiolados",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Os zumbis se arrastam pelo cemitério e pelas casas logo a leste da igreja.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "{npc:1661}, ao lado da igreja",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "{npc:2119}, o instrutor de guerreiro",
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

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808} e {npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} e {npc:5667} ficam ao lado da igreja.",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: o pergaminho para {npc:244808}",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "Range-ossos, carniceiros e quiropúsculos",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Esqueletos Range-ossos vagam pelas casas em ruínas na metade norte de {area:154}. Carniceiros Jovens e Quiropúsculos vagam por toda a vila; os Carniceiros Rotos e os Quiropúsculos Sarnentos ficam no lado leste.",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "Crânios de Range-ossos",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Os Esqueletos Range-ossos nas casas em ruínas deixam cair os crânios.",

	-- Step 8: Back to the church
	["Back to the church"] = "De volta à igreja",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, na igreja",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladinos: {quest:90902} se completa quando você curar cinco {npc:259377} em volta da igreja com {spell:635}.",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "As {object:164662} ficam ao lado das casas em ruínas no norte de {area:154}.",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Siga para oeste até a caverna. As Trevateias Jovens ficam do lado de fora; as Trevateias e as vítimas enredadas ficam lá dentro.",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "Liberte seis vítimas enredadas dentro da caverna para {npc:244808}",
	["Webbed Victims"] = "Vítimas enredadas",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "De volta a {area:154}",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "O {npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: o {npc:246143} fugiu para as colinas logo a oeste da igreja.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Ofereça ajuda ao {npc:246143}",

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
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} fica no extremo sul da fazenda Escarlate.",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Saia de {area:154} pela estrada a nordeste. {npc:6784} fica perto da casa da {area:156}.",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, a grande abominação, anda pela estrada um pouco mais a leste. A {item:12737} cresce ao longo da estrada em volta dele.",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Siga a estrada para leste até {area:159}. {npc:10665} fica na borda noroeste da cidade; a {area:2119} é a grande estalagem no meio, com {npc:1515} em frente.",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, a instrutora de Paladino",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Peça o relatório a {npc:1496}",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "Os instrutores de {area:159} ficam dentro e em volta da estalagem",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Use o {item:286176} em cinco Necroguardas ociosos pela cidade",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "A {quest:5482} cresce nos campos do cemitério logo ao norte de {area:159}.",

	-- Step 25: Dry Branches
	["Dry Branches"] = "Galhos Secos",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Os Galhos Secos ficam no chão em volta da borda sudoeste de {area:159}.",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleonora acampa logo a sudoeste da cidade.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "Use /sit junto à fogueira dela até receber {spell:1229451}",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "Campos a oeste de {area:159}",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} e Cadáveres Assolados se arrastam pelos campos logo a oeste de {area:159}; Cães das Trevas vagam um pouco mais a oeste, rumo a {npc:10666}.",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Peça o relatório a {npc:10666}",

	-- Step 29: Calvin Montague
	-- {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer · {npc:6784} Calvin Montague
	["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "Siga para oeste até a {area:156}. {npc:1519} fica na fazenda; {npc:6784}, junto à casa da fazenda, quer um duelo: fale com ele.",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Vença {npc:6784} no duelo",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "Regressar para {area:159}",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "{npc:2132}, ao lado de Joaquino",
	["in the inn: ask him about cooking"] = "na estalagem: pergunte a ele sobre culinária",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "Fale com {npc:265944}",
	["The Wanted poster by the inn"] = "O cartaz de procura-se perto da estalagem",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, na prefeitura",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, na estalagem",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} de {npc:2118}, para Gretchen",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "Grandes Quiropúsculos",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Grandes Quiropúsculos voam sobre os campos em volta de {area:159} e ao longo da estrada ao norte.",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "Cemitérios dos Putricouro",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Os Roubacovas Putricouro cavam pelos cemitérios ao norte de {area:159}; todos os Putricouro deixam cair a linfa.",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Os Mestiços Putricouro ocupam as colinas mais ao norte. {npc:1753} (nível 11) fica no acampamento deles na colina ao sul da margem: elimine primeiro os gnolls em volta dele.",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "Murlocs Pinavil",
	["The Vile Fin murlocs line the north shore."] = "Os murlocs Pinavil ocupam a margem norte.",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "Siga a estrada para o sul de volta a {area:159}.",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Siga a estrada para sudeste a partir de {area:159}, passando as torres de zepelim. Lina, Kristof e {npc:3549} acampam junto à estrada.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Peça o relatório a {npc:251001}",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "Volte pela estrada até {area:159}.",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Siga a estrada para noroeste até a {area:157}. {npc:1657} anda pelo cemitério ao sul dos moinhos; Nissa, Gregor e {npc:1656} assombram os próprios moinhos. Soldados Range-ossos e do Crânio Partido deixam cair as costelas, Osteurgos Olhonegro os crânios, e qualquer um deles pode deixar cair {item:2839}. Daqui em diante, mate os Quiropúsculos e Cães das Trevas que encontrar: {npc:3549} quer as asas e os pelegos deles.",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, item raro",
	["Only if the letter dropped"] = "Só se a carta tiver caído",

	-- Step 40: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Abóboras de Tirisfal",
	["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Ande para sudoeste a partir dos moinhos: as abóboras crescem nos campos ocupados pelos Escarlates a noroeste de Solliden.",

	-- Step 41: Crusader's Outpost
	["Crusader's Outpost"] = "Posto avançado dos Cruzados",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Guerreiros Escarlates guardam o posto avançado logo a oeste dos campos de abóbora. {npc:275954} está preso lá dentro: fale com ele e fique com ele até ele sair.",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Escolte {npc:275954} para fora do posto avançado",

	-- Step 42: Vile Fin shore
	["Vile Fin shore"] = "Margem dos Pinavil",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "Mais murlocs Pinavil andam pela margem logo ao norte do posto avançado.",

	-- Step 43: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "Paladino: {area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Siga para oeste até a {area:16616}; {npc:246389} e {npc:259190} acampam na borda dela.",

	-- Step 44: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} é a depressão na borda oeste das clareiras. Os Saltadores e Místicos do Vale das Sombras deixam cair os ossos; as garrafas ficam no chão entre eles, e o {item:286269} fica no extremo sul.",

	-- Step 47: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, na estalagem",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "O {npc:1931}, no porão da prefeitura",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} em {zone:1458} a recebe",

	-- Step 48: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} fica em {area:159}. {npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e lute com ele.",

	-- Step 49: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Ande para o sul de {area:159} até as {area:153} e desça até {zone:1458}. {npc:5675} fica no {object:36082}. O acampamento Escarlate fica logo a oeste das ruínas.",

	-- Step 50: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Ande para o sul de {area:159} até as {area:153} e desça até {zone:1458}. {npc:4568} fica no {object:36082}. O acampamento Escarlate fica logo a oeste das ruínas.",

	-- Step 51: The Scarlet camp
	["The Scarlet camp"] = "O acampamento Escarlate",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Siga a estrada para sudoeste a partir de {area:159} até o acampamento da Cruzada Escarlate. {npc:1662} fica no extremo sul; todo Escarlate de lá pode deixar cair um anel.",

	-- Step 52: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "O {object:37098} fica ao lado de {npc:1662}, no extremo sul do acampamento.",

	-- Step 54: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Pegue a estrada para sudeste saindo de {area:159}; Terêncio fica nela antes das torres de zepelim.",

	-- Step 55: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} fica no acampamento de {npc:1495}.",

	-- Step 56: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} ocupa a fazenda logo a sudeste do acampamento. Os Fragmentos de Cristal Necrótico ficam no chão entre os sectários, e os sectários também levam alguns.",

	-- Step 57: Balnir graves
	["Balnir graves"] = "Túmulos dos Balnir",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Siga a estrada para leste. Horrores Sangrentos e Espíritos Errantes assombram os túmulos no lado leste da fazenda, onde cresce a {quest:99142}.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, na horta da fazenda",

	-- Step 58: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Os Frades Escarlates acampam logo a nordeste dos túmulos; {npc:1664} fica entre eles.",

	-- Step 59: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "Trevateias Malévolas",
	["The spiders lurk in the woods at the far east end of the glades."] = "As aranhas espreitam na mata no extremo leste das clareiras.",

	-- Step 60: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Quiropúsculos e Cães das Trevas vagam por toda a estrada de volta para oeste; termine as asas e os pelegos no caminho.",

	-- Step 61: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Acampamento de {npc:1495}",

	-- Step 62: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "O {npc:2211}, no porão da prefeitura",

	-- Step 63: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Siga a estrada para nordeste a partir de {area:159}, passando o {area:162}. {npc:1665} e seus dois Guarda-costas Escarlates ocupam a torre de vigia Escarlate na costa nordeste, ao norte do {area:459}: atraia primeiro os guarda-costas.",

	-- Step 64: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "De volta a {area:159}.",

	-- Step 65: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Siga a estrada para oeste passando a {area:157} até a {area:16616}. Leonid fica logo ao norte do acampamento de {npc:246389}.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Ouça Leonid e {npc:246378}, depois fale com ele de novo",

	-- Step 67: The Undercity
	-- {object:1661} The Undercity (no name in this language: may be words) · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words) · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter (no name in this language: may be words) · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} fica embaixo das {area:153}, ao lado das torres de zepelim. {npc:5675} fica no {object:36082}: use as {item:6284} no círculo de evocação ao lado dele e derrote o emissário do caos. {npc:4606} fica no {object:36070}. {npc:4568} também fica no {object:36082}.",

	-- Step 68: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "Zepelim para {zone:1411}",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Ande para sudeste de {area:159} até as torres de zepelim do lado de fora das {area:153} e embarque no zepelim para {zone:1454} (o outro vai para {object:3202}).",
	["Zeppelin tower"] = "Torre de zepelim",

	-- Step 69: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "O zepelim pousa na torre logo a nordeste do portão principal de {zone:1454}. Siga a estrada para o sul até {zone:1411}, atravesse a ponte do {area:815} abaixo do {area:379} e siga a estrada para oeste até a {area:380}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre de mantícoras",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "As abóboras crescem nos campos ocupados pelos Escarlates a noroeste de Solliden.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "As aranhas espreitam na mata no extremo leste das clareiras. {npc:276020}, uma abominação desgarrada, vaga logo a noroeste delas. {npc:276020} é elite: é recomendado formar grupo.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Siga a pé para oeste até {npc:6784} e fale com ele: ele quer um duelo.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Ande para sudoeste até a {area:156}; Simério fica na fazenda.",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}, de {npc:276020}",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, uma abominação de elite no leste",
}
