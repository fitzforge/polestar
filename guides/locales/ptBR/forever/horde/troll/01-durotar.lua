-- Portuguese (Brazil) (ptBR): the guide forever/horde/troll/01-durotar (forever/horde/troll/01-durotar.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} espera dentro d'O Covil, a construção logo a oeste de {npc:10176}.",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, onde você começa",
	["Inside"] = "",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "Armas de treino e javalis",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "As armas ficam em volta d'O Covil e do campo de treino; os Mosquetuscos vagam por todo o fundo do vale.",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} fica logo na entrada da caverna; {npc:3159}, no fundo da caverna, atrás dele.",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, o instrutor de sacerdote n'O Covil",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, junto à fogueira de cozinhar",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} está ferido no sopé das colinas a noroeste d'O Covil.",

	-- Step 5: Valley of Trials: kill these as you meet them
	["Valley of Trials: kill these as you meet them"] = "",
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {quest:792} Vile Familiars
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the Burning Blade Coven, the cave on the valley's north side."] = "",

	-- Step 6: Back to the Den
	["Back to the Den"] = "De volta ao Covil",

	-- Step 7: Class trainer
	["Class trainer"] = "",

	-- Step 8: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff
	["{npc:246344} in {zone:1456}; Valley of Trials has no paladin trainer"] = "",

	-- Step 9: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore
	["{npc:3034} in {zone:1412}; Valley of Trials has no druid trainer"] = "",

	-- Step 10: Back to the Den
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "",

	-- Step 11: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Acorde os {quest:5441} com o {item:16114}",

	-- Step 13: Burning Blade Coven
	["Burning Blade Coven"] = "",

	-- Step 14: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Dentro da caverna, siga reto na primeira bifurcação, depois à direita, e acompanhe o riacho à sua esquerda até a cachoeira: a picareta brilha junto à água, atrás de uma coluna de pedra.",

	-- Step 15: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Dentro da caverna, mantenha-se rente à parede da direita a volta toda, passando o riacho: {npc:3183} espera no fim.",
	["Below ground"] = "",

	-- Step 16: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Cascos de {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Os Espreitadores Vis vagam pela encosta abaixo da caverna, no lado norte do vale.",

	-- Step 17: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "o {object:654925} no chão ao lado dela",

	-- Step 18: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. Spirit Rock is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "",
	-- {npc:5891} Minor Manifestation of Earth
	["{npc:5891}, on Spirit Rock"] = "",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} e o seu {item:5175}",

	-- Step 19: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} fica na estrada, na saída leste do vale.",

	-- Step 20: Sen'jin Village
	-- {object:3276} Sen'jin Village (no name in this language: may be words)
	["Follow the road east out of the valley to {object:3276} on the coast."] = "",
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: só encantadores, o resíduo vem do desencantamento de Pingentes Bagateados",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "",

	-- Step 21: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "A fogueira de {npc:265809}",
	-- {npc:265809} Brakk · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:265809} camps just south of {object:3224}. Sit by his campfire (/sit) until the Boosted Rest buff appears."] = "",

	-- Step 22: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "",

	-- Step 23: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, na torre de vigia",

	-- Step 24: Prickly pears
	["Prickly pears"] = "Figos-da-índia",
	["The prickly pears grow among the quilboar huts just west of town."] = "Os figos-da-índia crescem entre as cabanas dos javatuscos logo a oeste da cidade.",

	-- Step 26: Tiragarde Keep
	["Tiragarde Keep"] = "",
	-- {object:3224} Razor Hill (no name in this language: may be words) · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {object:3224}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "",
	["Upstairs"] = "",

	-- Step 27: Razor Hill
	-- {object:3224} Razor Hill (no name in this language: may be words) · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {object:3224}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "",

	-- Step 28: Scuttle Coast: kill these as you meet them
	["Scuttle Coast: kill these as you meet them"] = "",
	-- {object:3224} Razor Hill (no name in this language: may be words)
	["Makrura and surf crawlers line the beaches north-east of Sen'jin; the Taillasher eggs sit in nests along the beach.\nThe gnomish toolboxes lie in the wreckage along the shore east and south-east of {object:3224}. Follow the shore south to Sen'jin."] = "",
	["Underwater"] = "",

	-- Step 29: Bloodtalon Matriarch
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there; Durotar Tigers roam the isle and the shore south of Sen'jin."] = "",

	-- Step 30: Echo Isles: kill these as you meet them
	["Echo Isles: kill these as you meet them"] = "",
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle.\nWade back west to the shore south of Sen'jin when the isles are done."] = "",

	-- Step 32: Kolkar Crag
	["Kolkar Crag"] = "",
	-- {npc:275811} Pal'juh
	["Kolkar Crag lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Liberte {npc:275811} e leve-a em segurança para fora do penedo",

	-- Step 35: Level 10
	["Level 10"] = "",
	-- {quest:840} Conscript of the Horde · {object:3224} Razor Hill (no name in this language: may be words)
	["Top up here to level 10: {quest:840}, at {object:3224}, needs level 10."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "",

	-- Step 36: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, junto à estalagem",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, para {npc:6018} em {zone:1454}: guarde-a",

	-- Step 37: Far Watch Post
	["Far Watch Post"] = "",
	-- {npc:3337} Kargal Battlescar · {npc:5907} Kranal Fiss
	["West over the Southfury River bridge: {npc:3337} stands at Far Watch Post above it, on your way to {npc:5907}."] = "",

	-- Step 42: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["West over the Southfury River bridge, past Far Watch Post and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "",

	-- Step 43: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "",

	-- Step 44: Razormane Grounds
	["Razormane Grounds"] = "",
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Javatuscos e batedores ocupam as cabanas a oeste da cidade; levanta-poeiras e guardas de batalha ocupam os acampamentos mais a oeste.",

	-- Step 45: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "",

	-- Step 46: Drygulch Ravine
	["Drygulch Ravine"] = "",
	-- {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in Drygulch Ravine, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by Dustwind Cave, at the ravine's south end, drop the {item:6652}."] = "",

	-- Step 47: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 49: Thunder Ridge: kill these as you meet them
	["Thunder Ridge: kill these as you meet them"] = "",
	-- {npc:3293} Rezlak · {object:3224} Razor Hill (no name in this language: may be words) · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on Thunder Ridge, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on Thunder Ridge, north-west of {object:3224}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly."] = "",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestique-o com a {item:15908}",
	-- {npc:3099} Dire Mottled Boar
	["Tame {npc:3099}"] = "",

	-- Step 50: Misha Tor'kren
	-- {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the Southfury River to the west carry {item:4891}."] = "",

	-- Step 52: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:275657} stands on the shore east of {object:3224}. The trident, banner and dagger lie on the beach around him."] = "",

	-- Step 54: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:246344} in {zone:1456}; {object:3224} has no paladin trainer"] = "",

	-- Step 55: Mage trainer
	["Mage trainer"] = "",
	-- {npc:5884} Mai'ah · {zone:1411} Durotar · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:5884} in {zone:1411}; {object:3224} has no mage trainer"] = "",

	-- Step 56: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:3034} in {zone:1412}; {object:3224} has no druid trainer"] = "",

	-- Step 57: Razor Hill
	-- {object:3224} Razor Hill (no name in this language: may be words)
	["Back south to {object:3224}."] = "",

	-- Step 58: Spitelash naga
	["Spitelash naga"] = "Nagas Iralisca",
	-- {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below Drygulch Ravine. Hunters: tame a {npc:3107} on the beach."] = "",
	-- {npc:3107} Surf Crawler
	["Tame {npc:3107}"] = "",

	-- Step 59: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} acampa na colina a oeste da praia dos nagas, ao sul da {quest:827}.",

	-- Step 61: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {quest:827} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s main gate is just west of {quest:827}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "",

	-- Step 62: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 63: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "",

	-- Step 64: Skull Rock's mouth
	-- {quest:827} Skull Rock
	["{quest:827}'s mouth"] = "",

	-- Step 65: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Sectários de Lâmina Ardente ocupam as cavernas de {quest:827}; qualquer um deles deixa cair um {item:4871}. {npc:3204}, um bruxo de nível 14, fica no fundo e deixa cair o {item:4903}.",

	-- Step 66: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {quest:827} Skull Rock
	["The {object:58595} stands in {quest:827}, among the cultists you just fought."] = "",

	-- Step 67: Into Orgrimmar
	-- {zone:1454} Orgrimmar
	["Into {zone:1454}"] = "",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Volte até {npc:5875} na {object:172960}. Use os {item:7464} no círculo de evocação de lá e derrote o emissário do caos para prendê-lo.",
	-- {npc:5875} Gan'rul Bloodeye
	["{npc:5875}: Summon Voidwalker"] = "",

	-- Step 72: Razor Hill
	-- {object:3224} Razor Hill (no name in this language: may be words)
	["Back to {object:3224}."] = "",

	-- Step 73: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, um gigante do mar elite",

	-- Step 74: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "",
	-- {npc:3142} Orgnil Soulscar · {object:3224} Razor Hill (no name in this language: may be words)
	["{npc:3142}, back in {object:3224}"] = "",

	-- Step 75: Armored Scorpid
	-- {object:3224} Razor Hill (no name in this language: may be words) · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {object:3224}. Tame one, then return to {npc:3171}."] = "",
	-- {npc:3126} Armored Scorpid
	["Tame {npc:3126}"] = "",
	-- {npc:3171} Thotar
	["{npc:3171}: Tame Beast"] = "",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar
	["{npc:3171}: {npc:3352} in {zone:1454} teaches Beast Training"] = "",

	-- Step 76: Far Watch Post
	-- {object:3224} Razor Hill (no name in this language: may be words) · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {object:3224} over the Southfury River bridge: {npc:3337} and {npc:5810} stand together at Far Watch Post above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "",

	-- Step 77: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "",
	-- {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on Thunder Ridge, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes Far Watch Post."] = "",

	-- Step 79: Ormak Grimshot
	-- {zone:1454} Orgrimmar · {quest:827} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor (no name in this language: may be words)
	["Follow the road north from Far Watch Post to {zone:1454}'s main gate, just west of {quest:827}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "",
	-- {npc:3352} Ormak Grimshot
	["{npc:3352}: Beast Training"] = "",

	-- Step 80: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 81: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "",
	-- {zone:1454} Orgrimmar · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Follow the road north from Far Watch Post to {zone:1454}'s main gate. The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "Volte para leste até a praia ao norte de {npc:275657}. Batedores Iralisca e Serviçais Iralisca ocupam a praia abaixo da {area:370}. Caçadores: domestiquem um {npc:3107} na praia.",
	-- ["Back south to {area:362}."] = "Volte para o sul até {area:362}.",
	-- ["Back to {area:362}."] = "De volta a {area:362}.",
	-- ["Follow the road east out of the valley to {area:367} on the coast."] = "Siga a estrada para leste saindo do vale até a {area:367}, na costa.",
	-- ["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "A cabana de Misha fica ao sul dos lagartos. Os crocoliscos ao longo do {area:814}, a oeste, carregam o {item:4891}.",
	-- ["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "A fortaleza fica na costa a sudeste de {area:362}. O machado, o arco e o escudo dos saqueadores estão nos arredores dela. Marinheiros e fuzileiros derrubam os {item:4870}. {npc:3192} espera no alto da fortaleza; a chave dele abre o baú ao seu lado, que guarda o {item:4881}.",
	-- ["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "O {object:58595} fica na {area:817}, entre os sectários que você acabou de enfrentar.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam no {area:369}, do outro lado da ponte; qualquer um deles pode derrubar uma {item:6486}.",
	-- ["Thunder lizards across the river"] = "Lagartos trovejantes do outro lado do rio",
	-- ["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Atravesse a água até a ilha mais ao norte das Ilhas do Eco. A Matriarca ronda entre os raptores de lá.",
	-- ["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "O {area:366} fica a oeste de Sen'jin. Os três planos de ataque estão no chão entre as tendas dos centauros. {npc:275811} também está presa no penedo.",
	-- ["{area:817}'s mouth"] = "Entrada da {area:817}",
	-- ["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} fica na praia a leste de {area:362}. O tridente, o estandarte e a adaga estão na areia em volta dele.",
	-- ["{npc:3142}, back in {area:362}"] = "{npc:3142}, de volta em {area:362}",
	-- ["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} fica do lado de fora d'O Covil. {area:639} é a colina logo ao sul: beba a {item:6635} lá para ver a {npc:5891}, depois leve o {item:6656} de volta para {npc:5887}.",
	-- ["{npc:5891}, on {area:639}"] = "{npc:5891}, na {area:639}",
	-- ["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "O portão principal de {zone:1454} fica logo a oeste da {area:817}. {npc:5875} fica na {object:172960}, o cânion abaixo do {object:172982}.",
}
