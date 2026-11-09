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
	["Inside"] = "Lá dentro",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Zumbis Desmiolados",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Os zumbis se arrastam pelo cemitério e pelas casas logo a leste da igreja.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: o pergaminho para {npc:244808}",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "{npc:1661}, ao lado da igreja; lá dentro",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "{npc:2119}, o instrutor de guerreiro; lá dentro",
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
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "{quest:90902}: os {npc:259377} estão caídos em volta da igreja. Cure cinco deles com {spell:635}.",

	-- Step 6: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "{area:154}: vá matando estes pelo caminho",
	-- {area:154} Deathknell · {npc:1661} Novice Elreth
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side. {npc:1661} wants their paws and wings: kill them as you meet them while you clear the skeletons."] = "Esqueletos Range-ossos vagam pelas casas em ruínas na metade norte de {area:154}. Carniceiros Jovens e Quiropúsculos rondam toda a vila; os Carniceiros Rotos e Quiropúsculos Sarnentos ficam no lado leste. {npc:1661} quer as patas e as asas deles: mate-os conforme os encontrar enquanto limpa os esqueletos.",

	-- Step 7: Back to the church
	["Back to the church"] = "De volta à igreja",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "{npc:1661}, lá dentro",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "{npc:244808}: {spell:635}, depois de curar cinco {npc:259377}",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "{npc:1569}, lá dentro",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "{npc:244808}, lá dentro",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, na igreja",

	-- Step 8: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "As {object:164662} ficam ao lado das casas em ruínas no norte de {area:154}.",

	-- Step 9: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "De volta a {area:154}",

	-- Step 10: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "O {npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "{quest:91208}: a {npc:246143} fugiu para as colinas a oeste da igreja, no caminho para {area:155}.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Ofereça ajuda ao {npc:246143}",

	-- Step 11: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "Siga para oeste até a caverna. As Trevateias Jovens ficam do lado de fora; as Trevateias e os {npc:271961} presos em casulos estão lá dentro.\nCuidado: personagem de nível baixo morre rapidinho se puxar várias Trevateias de uma vez na caverna.",
	["Below ground"] = "No subterrâneo",
	["attack the cocoons inside the cave to free them; below ground"] = "ataque os casulos dentro da caverna para soltá-los; no subterrâneo",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "Liberte os {npc:271961}",

	-- Step 13: The Scarlet farm
	["The Scarlet farm"] = "A fazenda Escarlate",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Os Neófitos e Iniciados Escarlates ocupam a fazenda a leste de {area:154}. {npc:1919} anda entre as casas da fazenda: os restos dele são para {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, de {npc:1919}",

	-- Step 14: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "O {object:178090} fica no cemitério de {area:154}, ao lado da igreja.",

	-- Step 16: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "{npc:1667} fica na ponta sul da fazenda Escarlate.\nCuidado: ele tem dois guardas Escarlates do lado, um neófito e um iniciado, que podem entrar na briga.",

	-- Step 18: Solliden Farmstead
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}; {npc:1519} stands by the road just past it."] = "Saia de {area:154} pela estrada a nordeste. {npc:6784} fica junto à casa de fazenda em {area:156}; {npc:1519} fica junto à estrada, logo depois dela.",

	-- Step 19: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Abóboras de Tirisfal",
	["The pumpkins grow in the Scarlet-held fields just north-west of the farmhouse.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "As abóboras crescem nos campos tomados pelos Escarlates, logo a noroeste da casa da fazenda.\nCuidado: os fazendeiros ficam colados nas abóboras, então dá para puxar mais de um de uma vez. Os monstros Escarlates ficam nas bordas da fazenda e um pouco a noroeste.",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "{npc:10666}, a abominação grandona, anda pela estrada daqui para leste, passando por {area:166} quase até {area:159}, ida e volta: se ele não estiver na seta, siga a estrada para leste até achar o grandalhão. {item:12737} cresce ao longo da estrada em volta dele.",

	-- Step 21: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {npc:1742} Deathguard Bartholomew · {area:159} Brill
	["{npc:1496} and {npc:1742} stand at the west end of {area:159}, where the road from Solliden comes in."] = "{npc:1496} e {npc:1742} ficam na ponta oeste de {area:159}, onde chega a estrada vinda de Solliden.",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742}, beside Dillinger"] = "{npc:1742}, ao lado de Dinis",

	-- Step 22: Junior Apothecary Holland
	-- {area:159} Brill
	["Holland walks around the north side of {area:159}, a few steps from Dillinger."] = "Holland anda pelo lado norte de {area:159}, a poucos passos de Dillinger.",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "{npc:10665} anda por {area:159}: procure dentro do círculo no mapa",

	-- Step 23: Dry Branches
	["Dry Branches"] = "Galhos Secos",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Os Galhos Secos ficam no chão em volta da borda sudoeste de {area:159}.",

	-- Step 24: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Eleonora acampa logo a sudoeste da cidade.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "Use /sit junto à fogueira dela até receber {spell:1229451}",

	-- Step 25: Brill
	-- {npc:1518} Apothecary Johaan · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren
	["{npc:1518} is in the apothecary's house on the west side of the square, {npc:1515} in front of the inn with the Wanted poster beside him, {npc:1499} in the town hall on the square's north side. The inn comes last, in one go."] = "{npc:1518} fica na casa do boticário, no lado oeste da praça; {npc:1515} fica em frente à estalagem, com o cartaz PROCURA-SE ao lado dele; {npc:1499} fica na prefeitura, no lado norte da praça. A estalagem fica por último, de uma vez só.",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "{npc:1518}, lá dentro",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, a instrutora de Paladino",
	-- {npc:1515} Executor Zygand
	["{npc:1515}, in front of the inn"] = "{npc:1515}, em frente à estalagem",
	["The Wanted poster by the inn"] = "O cartaz de procura-se perto da estalagem",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, na prefeitura",

	-- Step 26: Carolai Anise
	-- {npc:2132} Carolai Anise · {area:159} Brill
	["From level 7 {npc:2132}, beside Johaan in the apothecary's house, offers her elixir quest; below 7 it waits for the next {area:159} visit."] = "A partir do nível 7, {npc:2132}, ao lado de Johaan na casa do boticário, oferece a missão do elixir dela; abaixo do 7, ela espera pela próxima visita a {area:159}.",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "{npc:2132}, ao lado de Joaquino; lá dentro",

	-- Step 27: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Use o {item:286176} em cinco Necroguardas ociosos pela cidade",

	-- Step 29: Gallows' End Tavern
	-- {npc:5688} Innkeeper Renee · {npc:265944} William Pickman · {npc:1931} Captured Scarlet Zealot · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Everything here is inside the inn, through its door on the south side: {npc:5688} at the bar, {npc:265944} at the north end of the ground floor, the {npc:1931} in the cellar under that end, and {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) upstairs: take the stairs inside, the arrow cannot tell the floors apart."] = "Tudo aqui fica dentro da estalagem, pela porta do lado sul: {npc:5688} no balcão, {npc:265944} na ponta norte do térreo, o {npc:1931} no porão sob essa ponta, e {npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (bruxos) e {npc:2130} (ladinos) no andar de cima: suba a escada por dentro, a seta não distingue os andares.",
	-- {npc:265944} William Pickman
	["{npc:265944}, at the inn's north end: Camping 101 asks you to learn it"] = "{npc:265944}, na ponta norte da estalagem: Introdução ao acampamento pede que você aprenda isto",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the inn's cellar"] = "O {npc:1931}, no porão da estalagem",
	-- {area:159} Brill · {npc:2131} Austil de Mon · {npc:246152} Shari Stilwell
	["The {area:159} trainers are in the inn ({npc:2131} downstairs, the rest upstairs); {npc:246152}, the Paladin trainer, by the square"] = "Os instrutores de {area:159} ficam na estalagem ({npc:2131} no andar de baixo, os demais no andar de cima); {npc:246152}, a instrutora de Paladino, junto à praça",

	-- Step 30: Coleman Farthing and Gretchen Dedmar
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar
	["{npc:1500} and {npc:1521}"] = "{npc:1500} e {npc:1521}",
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar · {area:159} Brill
	["Still in the inn: from level 7 {npc:1500} on the ground floor and {npc:1521} upstairs offer their quests; below 7 they wait for the next {area:159} visit."] = "Ainda na estalagem: a partir do nível 7, {npc:1500} no térreo e {npc:1521} no andar de cima oferecem suas missões; abaixo do 7, as missões esperam pela próxima visita a {area:159}.",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, na estalagem",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "{npc:1521}, no andar de cima",

	-- Step 31: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Acampamento de {npc:1495}",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Siga a estrada para sudeste a partir de {area:159}, passando as torres de zepelim. Lina, Kristof e {npc:3549} acampam junto à estrada.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Peça o relatório a {npc:251001}",

	-- Step 32: Deathguard Dillinger
	-- {area:159} Brill
	["Back up the road and through {area:159} to its west end."] = "Volte pela estrada e atravesse {area:159} até a ponta oeste dela.",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Peça o relatório a {npc:1496}",

	-- Step 33: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "{area:166}: vá matando estes pelo caminho",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo · {npc:3549} Shelene Rhobart
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse · Decrepit Darkhounds = {npc:1547} Decrepit Darkhound
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Decrepit Darkhounds roam there and on west along the road toward {npc:10666}. Johaan wants their blood, {npc:3549} their hides."] = "{npc:1525} e Cadáveres Assolados cambaleiam pelos campos logo a oeste de {area:159}; Cães das Trevas Decrépitos vagam por ali e mais a oeste, pela estrada rumo a {npc:10666}. Johaan quer o sangue deles, {npc:3549} as peles.",

	-- Step 34: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "{npc:10666} faz o estradão a oeste de {area:159}, passando por {area:166}, ida e volta: a seta segue a estrada dele para oeste até vocês se encontrarem.",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Peça o relatório a {npc:10666}",

	-- Step 35: Calvin Montague
	-- {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["{npc:6784} stands by the farmhouse at the {area:156}, on the way to the Crusader's Outpost."] = "{npc:6784} fica junto à casa de fazenda em {area:156}, no caminho para a Guarita dos Cruzados.",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "{npc:6784}, junto à casa da fazenda: fale com ele para o duelo; ele só desafia depois que {npc:5688} recebe a carta dele",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Vença {npc:6784} no duelo",

	-- Step 36: Crusader's Outpost
	["Crusader's Outpost"] = "Posto avançado dos Cruzados",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost north-west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "Os Guerreiros Escarlates guardam o posto avançado a noroeste dos campos de abóbora. {npc:275954} está preso lá dentro: fale com ele e fique junto até ele sair.\nCuidado: os Guerreiros Escarlates são nível 6-7 e não são elite. Com 15% de vida eles saem correndo para chamar reforço, então mais deles podem entrar na briga.",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "{npc:275954}, no último andar",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Escolte {npc:275954} para fora do posto avançado",

	-- Step 37: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back east along the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "De volta a leste pela estrada até {area:159}. {npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (bruxos) e {npc:2130} (ladinos) ficam no andar de cima da estalagem: suba a escada por dentro, a seta não distingue os andares.",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} de {npc:2118}, para Gretchen",

	-- Step 38: Tirisfal Glades: kill these as you meet them
	-- {zone:1420} Tirisfal Glades
	["{zone:1420}: kill these as you meet them"] = "{zone:1420}: vá matando estes pelo caminho",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart · {quest:5482} Doom Weed · {npc:1753} Maggot Eye
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north: Gretchen wants their pelts, {npc:3549} their wings.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}, where the Rot Hide Graverobbers dig; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone.\nThe Vile Fin murlocs line the north shore: they all drop the scales, and the Minor Oracles and Muckdwellers the skins for {npc:3549}."] = "Grandes Quiropúsculos voam sobre os campos em volta de {area:159} e ao longo da estrada ao norte: Gretchen quer as peles deles, {npc:3549} as asas.\n{quest:5482} cresce nos campos do cemitério logo ao norte de {area:159}, onde os Roubacovas Putricouro cavam; todos os Putricouro deixam cair o icor.\nOs Mestiços Putricouro dominam as colinas mais ao norte. {npc:1753} (nível 11) fica no acampamento deles, no morro ao sul da costa: limpe os gnolls em volta dele primeiro.\nCuidado: guardas gnoll ficam do lado de fora da cabana e podem entrar na briga. Se você passar por eles sem ser visto e lutar com ele lá dentro, ele luta sozinho.\nOs murlocs Pinavil ocupam a costa norte: todos deixam cair as escamas, e os Oráculos Menores e Moralodos deixam cair os couros para {npc:3549}.",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "{npc:1675} anda por {area:164}: procure dentro do círculo no mapa",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "{item:3635}; lá dentro",

	-- Step 39: Brill
	-- {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["{npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (bruxos) e {npc:2130} (ladinos) ficam no andar de cima da estalagem: suba a escada por dentro, a seta não distingue os andares.",
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "{npc:246152}, a instrutora de Paladino: {quest:91282}, rumo a {quest:96899}",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "{npc:1499}, lá dentro",

	-- Step 40: Deathguard Terrence
	-- {npc:1738} Deathguard Terrence · {quest:96895} The Argent Emissary · {npc:267009} Hadric Harlson · {area:159} Brill · {area:157} Agamand Mills
	["From level 10 {npc:1738} offers {quest:96895}: {npc:267009} waits at Linnea's camp, the next stop. Below 10 it waits for the {area:159} visit after {area:157}."] = "A partir do nível 10, {npc:1738} oferece {quest:96895}: {npc:267009} espera no acampamento de Linnea, a próxima parada. Abaixo do 10, a missão espera pela visita a {area:159} depois de {area:157}.",

	-- Step 41: Deathguard Linnea's camp
	-- {area:159} Brill
	["Follow the road south-east from {area:159} past the zeppelin towers."] = "Siga a estrada para sudeste saindo de {area:159}, passando pelas torres dos zepelins.",

	-- Step 42: Hadric Harlson
	-- {npc:267009} Hadric Harlson
	["{npc:267009} stands at the camp beside Linnea."] = "{npc:267009} fica no acampamento, ao lado de Lina.",

	-- Step 43: Magistrate Sevren
	-- {area:159} Brill · {area:157} Agamand Mills
	["Back up the road to {area:159}, on the way north-west to {area:157}."] = "Volte pela estrada até {area:159}, a caminho de {area:157}, para o noroeste.",

	-- Step 44: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "Siga a estrada para noroeste até {area:157}. {npc:1657} anda pelo cemitério ao sul dos moinhos; Nissa, Gregor e {npc:1656} assombram os próprios moinhos. Esqueletos Range-ossos e Soldados do Crânio Partido deixam cair as costelas, Osteurgos Olhonegro os crânios, e qualquer um deles pode deixar cair {item:2839}.\nCuidado: mortos-vivos em decomposição e Osteurgos Olhonegro perto dos Agamand podem entrar na briga como reforços.",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "{npc:1655}; no andar de cima",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, item raro",
	["Only if the letter dropped"] = "Só se a carta tiver caído",

	-- Step 45: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, na estalagem",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: {npc:4568} em {zone:1458} a recebe",
	-- {npc:1738} Deathguard Terrence · {area:159} Brill
	["{npc:1738}, if you were below 10 on the last {area:159} visit"] = "{npc:1738}, se você estava abaixo do 10 na última visita a {area:159}",

	-- Step 46: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e lute com ele.",

	-- Step 47: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Ande para o sul de {area:159} até as {area:153} e desça até {zone:1458}. {npc:5675} fica no {object:36082}. O acampamento Escarlate fica logo a oeste das ruínas.",

	-- Step 48: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter (no name in this language: may be words)
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Ande para o sul de {area:159} até as {area:153} e desça até {zone:1458}. {npc:4568} fica no {object:36082}. O acampamento Escarlate fica logo a oeste das ruínas.",

	-- Step 49: Back to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Back to {zone:1420}"] = "De volta a {zone:1420}",
	["The Scarlet camp"] = "O acampamento Escarlate",

	-- Step 50: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Siga a estrada para sudoeste a partir de {area:159} até o acampamento da Cruzada Escarlate. {npc:1662} fica no extremo sul; todo Escarlate de lá pode deixar cair um anel.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "{npc:1537} anda por aqui: procure dentro do círculo no mapa",

	-- Step 51: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "O {object:37098} fica ao lado de {npc:1662}, no extremo sul do acampamento.",

	-- Step 53: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp, on the road to the cult's farm."] = "{npc:267009} fica no acampamento de {npc:1495}, na estrada para a fazenda do culto.",

	-- Step 54: Tirisfal Glades: kill these as you meet them
	-- {npc:1495} Deathguard Linnea
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Follow the road south-east past {npc:1495}'s camp: the Cult of the Damned holds the farm just south-east of it. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "Siga a estrada para o sudeste, passando pelo acampamento de {npc:1495}: a Seita dos Malditos domina a fazenda logo a sudeste dele. Os Fragmentos de Cristal Necrótico estão no chão entre os sectários, e os sectários também carregam alguns.",

	-- Step 55: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "{area:165}: vá matando estes pelo caminho",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows: Linnea wants eight of each.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "Siga a estrada para o leste. Os Horrores Sangrentos e os Espíritos Errantes assombram os túmulos no lado leste da fazenda, onde cresce {quest:99142}: Lina quer oito de cada.\nOs Frades Escarlates acampam logo a nordeste dos túmulos; {npc:1664} fica no meio deles.\nAs aranhas espreitam na mata do extremo leste da clareira.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, na horta da fazenda",

	-- Step 57: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back up the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Suba de volta pela estrada até {area:159}. {npc:2128} (magos), {npc:2129} (sacerdotes), {npc:2127} (bruxos) e {npc:2130} (ladinos) ficam no andar de cima da estalagem: suba a escada por dentro, a seta não distingue os andares.",
	-- {npc:1518} Apothecary Johaan · {area:228} Sepulcher
	["{npc:1518}: for Renferrel at the {area:228}"] = "{npc:1518}: para Renferrel em {area:228}",
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the inn's cellar"] = "O {npc:2211}, no porão da estalagem",

	-- Step 58: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10). They send you into the cellar under {area:16881}, the next stop."] = "Siga a estrada para oeste, passando por {area:157}, até {area:16616}. Leonid fica logo ao norte do acampamento de {npc:246389}.\n{npc:246389} e {npc:259190} acampam na beira da floresta, logo ao sul de Leonid. Toda classe pode pegar as duas missões depois que {quest:96896} é entregue (nível 10). Elas mandam você ao porão sob {area:16881}, a próxima parada.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Ouça Leonid e {npc:246378}, depois fale com ele de novo",

	-- Step 59: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "Paladino: {quest:96899}",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "{npc:246349} espera no portão da bastilha, ao lado de Leonid.",

	-- Step 60: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "Paladino: {quest:91285}",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "Os murlocs Pinavil espreitam nos penhascos logo a leste da bastilha e nos acampamentos em volta do lago a sudoeste, no caminho de descida para {area:16881}.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Atacantes Pinavil",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Videntes Pinavil",

	-- Step 61: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "{area:16881} é a baixada na borda oeste da clareira, a sudoeste de {area:16616}. Desça até o porão grande embaixo da casa em ruínas (sobrou só o piso e umas colunas; não é o sobrado): as garrafas estão no chão, no meio dos Saltadores e Místicos do Vale das Sombras.",
	["the basement under the ruined house"] = "o porão embaixo da casa em ruínas",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "{item:286269}, na ponta sul do porão",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "os Saltadores e Místicos do Vale das Sombras deixam cair os ossos; no subterrâneo",

	-- Step 62: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "{npc:246389} e {npc:259190}",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "Suba de volta até a beira da floresta, ao sul do portão da bastilha: {npc:246389} e {npc:259190} ficam com os ossos e o cristal.",

	-- Step 63: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "{npc:259190} e {npc:246389} na beira da floresta, {npc:246349} no portão, {npc:246393} e {npc:246394} ali perto, {npc:246378} lá dentro.",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "{npc:246378}, dentro da bastilha",

	-- Step 64: The Undercity
	-- {object:1661} The Undercity (no name in this language: may be words) · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words) · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter (no name in this language: may be words) · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} fica embaixo das {area:153}, ao lado das torres de zepelim. {npc:5675} fica no {object:36082}: use as {item:6284} no círculo de evocação ao lado dele e derrote o emissário do caos. {npc:4606} fica no {object:36070}. {npc:4568} também fica no {object:36082}.",

	-- Step 66: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "{npc:2132}, lá dentro",
	-- {area:159} Brill · {zone:1421} Silverpine Forest
	["The next guide walks south from {area:159} into {zone:1421}."] = "O próximo guia segue para o sul, saindo de {area:159}, para dentro de {zone:1421}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:159}."] = "De volta a {area:159}.",
	-- ["Back up the road to {area:159}."] = "Volte pela estrada até {area:159}.",
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
	-- ["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Saia de {area:154} pela estrada a nordeste. {npc:6784} fica perto da casa da {area:156}.",
	-- ["More Vile Fin murlocs walk the shore just north of the outpost."] = "Mais murlocs Pinavil andam pela margem logo ao norte do posto avançado.",
	-- ["Paladin: {area:16616}"] = "Paladino: {area:16616}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Paladinos: {quest:90902} se completa quando você curar cinco {npc:259377} em volta da igreja com {spell:635}.",
	-- ["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Esqueletos Range-ossos vagam pelas casas em ruínas na metade norte de {area:154}. Carniceiros Jovens e Quiropúsculos vagam por toda a vila; os Carniceiros Rotos e os Quiropúsculos Sarnentos ficam no lado leste.",
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
	-- ["The Vile Fin murlocs line the north shore."] = "Os murlocs Pinavil ocupam a margem norte.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "As abóboras crescem nos campos ocupados pelos Escarlates a noroeste de Solliden.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "As aranhas espreitam na mata no extremo leste das clareiras.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "As aranhas espreitam na mata no extremo leste das clareiras. {npc:276020}, uma abominação desgarrada, vaga logo a noroeste delas. {npc:276020} é elite: é recomendado formar grupo.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "O zepelim pousa na torre logo a nordeste do portão principal de {zone:1454}. Siga a estrada para o sul até {zone:1411}, atravesse a ponte do {area:815} abaixo do {area:379} e siga a estrada para oeste até a {area:380}.",
	-- ["The {area:159} trainers are in and around the inn"] = "Os instrutores de {area:159} ficam dentro e em volta da estalagem",
	-- ["The {npc:1931}, in the town hall basement"] = "O {npc:1931}, no porão da prefeitura",
	-- ["The {npc:2211}, in the town hall basement"] = "O {npc:2211}, no porão da prefeitura",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "A {quest:5482} cresce nos campos do cemitério logo ao norte de {area:159}.",
	-- ["Vicious Night Web Spiders"] = "Trevateias Malévolas",
	-- ["Vile Fin murlocs"] = "Murlocs Pinavil",
	-- ["Vile Fin shore"] = "Margem dos Pinavil",
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
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} fica em {area:159}. {npc:6390} espera no mausoléu na colina logo ao norte da cidade: abra o portão e lute com ele.",
	-- ["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} e Cadáveres Assolados se arrastam pelos campos logo a oeste de {area:159}; Cães das Trevas vagam um pouco mais a oeste, rumo a {npc:10666}.",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}, ao lado da igreja",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} fica no extremo sul da fazenda Escarlate.",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}, o instrutor de guerreiro",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}, ao lado de Joaquino",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808} e {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} e {npc:5667} ficam ao lado da igreja.",
	-- ["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} fica no acampamento de {npc:1495}.",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre de mantícoras",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: o {npc:246143} fugiu para as colinas logo a oeste da igreja.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} ocupa a fazenda logo a sudeste do acampamento. Os Fragmentos de Cristal Necrótico ficam no chão entre os sectários, e os sectários também levam alguns.",
}
