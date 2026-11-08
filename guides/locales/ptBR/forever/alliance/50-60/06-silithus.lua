-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} e as Terras Pestilentas",

	-- Step 1: To Ratchet
	["To Ratchet"] = "",
	["Ratchet"] = "",

	-- Step 2: Fly to Talrendis Point
	["Fly to Talrendis Point"] = "",
	["Ratchet flight master"] = "",

	-- Step 4: The Emerald Sanctuary
	["The Emerald Sanctuary"] = "",
	-- {zone:1448} Felwood · {zone:1440} Ashenvale
	["From Talrendis Point ride into {zone:1448}: the Emerald Sanctuary is the druids' camp on the road just past the {zone:1440} border."] = "",
	["Inside"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Espere um pouco por {npc:9116}",

	-- Step 5: Shadow Hold braziers
	["Shadow Hold braziers"] = "",
	-- {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["Shadow Hold is the cave at the back of Jaedenar, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Angerclaw bears and Felpaw wolves"] = "Ursos Garraivosos e Lobos Patavil",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "",

	-- Step 7: Irontree Woods
	["Irontree Woods"] = "",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to Irontree Woods. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Pisoteadores de Ferrárbol",

	-- Step 8: Arei
	-- {npc:9598} Arei · {quest:5086} Toxic Horrors
	["{npc:9598} waits in Irontree Woods. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "",

	-- Step 9: Felpaw Village
	["Felpaw Village"] = "",
	["Ride north to the Deadwood furbolgs' village by the Timbermaw Hold cave mouth."] = "",
	-- {object:176091} Deadwood Cauldron · {zone:1452} Winterspring
	["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, se você encontrou o Frasco Vazio de Aguardente em {zone:1452}",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} em {zone:1452}, guarde-a",

	-- Step 10: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan
	["Back into Shadow Hold: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "",

	-- Step 11: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Volte para o sul pela estrada até o Santuário.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Guarde o {item:11169}, as garras e o coração que ele devolve",

	-- Step 13: Fly to Gadgetzan
	["Fly to Gadgetzan"] = "",
	["Talrendis Point flight master"] = "",

	-- Step 14: Gadgetzan
	["Gadgetzan"] = "",
	-- {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to Gadgetzan. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 15: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Siga para o leste até as colinas. Use o {item:11169} para invocar {quest:4005} e derrote-o para obter o totem.",

	-- Step 16: Broken Pillar
	["Broken Pillar"] = "",
	-- {npc:7771} Marvon Rivetseeker
	["Ride south-west to {npc:7771}'s camp at the Broken Pillar."] = "",

	-- Step 18: The Slithering Scar
	["The Slithering Scar"] = "",
	-- {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the Slithering Scar, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "",

	-- Step 19: Fire Plume Ridge
	["Fire Plume Ridge"] = "",
	-- {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb Fire Plume Ridge in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "",
	["Use the jars on slain oozes"] = "Use as jarras nas gosmas mortas",

	-- Step 20: Marshal's Refuge
	["Marshal's Refuge"] = "",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to Marshal's Refuge. Use {npc:10980} beside {npc:10977}."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, no fundo do refúgio",

	-- Step 21: Fly to Cenarion Hold
	["Fly to Cenarion Hold"] = "",
	["Marshal's Refuge flight master"] = "",

	-- Step 22: Cenarion Hold
	["Cenarion Hold"] = "",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "",

	-- Step 23: Hive'Ashi: kill these as you meet them
	["Hive'Ashi: kill these as you meet them"] = "",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "A escavação do Martelo do Crepúsculo ocupa o canto noroeste: há fragmentos de tábua no chão, e as Tempestades de Poeira e os Estrondores do Deserto também os carregam. Todo sectário pode deixar cair um {item:20404}: guarde vinte, dez para {npc:15306} e dez para {npc:15194} depois.",
	["Twilight's Hammer cultists"] = "Sectários do Martelo do Crepúsculo",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Fragmentos de Tabuleta do Crepúsculo",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Mais dez para {quest:8323}",

	-- Step 24: Hive'Zora
	["Hive'Zora"] = "",
	-- {npc:17080} Marshal Bluewall
	["{npc:17080} camps outside Hive'Zora, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use Divine Shield, Feign Death or Vanish. Blink and Power Word: Shield do not drop it."] = "",

	-- Step 27: Southwind Village
	["Southwind Village"] = "",
	-- {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of Southwind Village. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "",

	-- Step 28: Hermit Ortell
	["The hermit hides among the rocks south-east of Southwind Village."] = "",
	["Below ground"] = "",

	-- Step 29: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Acampamento Barbabronze",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Siga para o sudoeste até o acampamento dos anões perto das montanhas do sul e interrogue {npc:15171} e {npc:15170}. A Algibeira do {npc:15190} está na areia, logo a sudeste do acampamento.",

	-- Step 30: The Twilight Post
	["The Twilight Post"] = "",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} comanda o acampamento dos sectários no extremo sudoeste.",

	-- Step 31: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Siga para o norte pelo lado oeste até o pequeno acampamento da Tutora do Crepúsculo Mayna.",

	-- Step 32: Twilight Keeper Havunth
	["Havunth's camp sits just west of Cenarion Hold."] = "",

	-- Step 33: Hermit Ortell
	["Ride back south-east to the hermit."] = "Volte para o sudeste até o eremita.",
	["Hand him the ten texts you kept"] = "Entregue a ele os dez textos que você guardou",

	-- Step 34: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 35: Gadgetzan
	["Fly to Gadgetzan."] = "",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} em {zone:1457}: guarde-a",

	-- Step 36: Forest Song
	["Forest Song"] = "",
	-- {zone:1447} Azshara · {zone:1440} Ashenvale
	["Fly to Talrendis Point in {zone:1447} and ride west along the road to Forest Song, just over the {zone:1440} border."] = "",

	-- Step 37: Fly to Everlook
	["Fly to Everlook"] = "",

	-- Step 38: Everlook
	["Everlook"] = "",

	-- Step 40: Starfall Village
	-- {object:177132} Starfall Village (no name in this language: may be words)
	["Ride north-west up the road to {object:177132}."] = "",

	-- Step 42: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Acampamento de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Ride back east past Everlook and south-east down the valley to {npc:10301}'s damaged crate in the snow at Mazthoril, with his wrecked wagon just east of it."] = "",

	-- Step 43: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Suprimentos de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Pegue os suprimentos em volta da carroça e tome de volta o amuleto de {npc:10301} dos corujursos próximos.",

	-- Step 44: Ranshalla
	-- {npc:10300} Ranshalla · {object:177404} Altar of Elune (no name in this language: may be words)
	["{npc:10300} waits at Owl Wing Thicket, south of Everlook.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "",

	-- Step 45: Darkwhisper Gorge
	["Darkwhisper Gorge"] = "",
	-- {npc:9298} Donova Snowden
	["Follow {npc:9298}'s directions to the mouth of Darkwhisper Gorge, past the Frostmaul giants: pass them one at a time."] = "",

	-- Step 46: Starfall Village
	-- {object:177132} Starfall Village (no name in this language: may be words)
	["Ride north up the valley, past Everlook, to {object:177132}."] = "",

	-- Step 48: Dire Maul (optional)
	["Dire Maul (optional)"] = "",
	-- {zone:1444} Feralas
	["Running Dire Maul in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "",
	["Dire Maul fits levels 55 to 60; alone, the Terrordale grind at the end of this guide gets you to 60."] = "",

	-- Step 49: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Continue para o oeste pela estrada até o acampamento de {npc:9298}, ao lado das fontes termais.",

	-- Step 52: Felpaw Village
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw; walks around here: look inside the circle on the map"] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "",

	-- Step 56: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "",
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with Feign Death, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 60: Umber
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1450} Moonglade · {npc:11939} Umber
	["Take the Timbermaw Hold tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {zone:1450} branch to Nighthaven. {npc:11939} studies by the lake shore."] = "",
	-- {npc:11939} Umber
	["{npc:11939} walks around Nighthaven: look inside the circle on the map"] = "",

	-- Step 61: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {npc:11939} Umber
	["{npc:11801}'s house stands in Nighthaven, east of {npc:11939}."] = "",

	-- Step 63: Nighthaven
	["Nighthaven"] = "",
	["Learn the flight path in Nighthaven."] = "",

	-- Step 64: Fly to Rut'theran Village
	["Fly to Rut'theran Village"] = "",

	-- Step 65: Rut'theran Village
	["Rut'theran Village"] = "",
	-- {npc:7916} Erelas Ambersky
	["The flight lands in Rut'theran Village. {npc:7916} stands a short walk north-west of the flight master."] = "",

	-- Step 67: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Pegue o portal para subir até {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, no Templo da Lua",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, no banco",
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, atop the Cenarion Enclave"] = "",

	-- Step 68: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 69: Fly to Auberdine
	["Fly to Auberdine"] = "",
	["Rut'theran Village flight master"] = "",

	-- Step 70: Boat to Menethil Harbor
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["Boat to {object:1162}"] = "",

	-- Step 71: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {object:1162} Menethil Harbor (no name in this language: may be words)
	["{object:1162} flight master"] = "",

	-- Step 72: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, em {object:2096}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",

	-- Step 73: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 74: Ironforge
	-- {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the Deeprun Tram to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} não tem instrutor de xamã",

	-- Step 75: Fly to Southshore
	["Fly to Southshore"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 79: Chillwind Camp
	["Chillwind Camp"] = "",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} é um elite de nível 61",

	-- Step 80: Andorhal
	["Andorhal"] = "Ruínas de Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} espera na estalagem em ruínas no lado oeste das Ruínas de Andorhal, a cidade em ruínas ao norte do acampamento. {npc:1852} protege o filactério dele no meio da cidade.",
	["Araj is elite: grouping up is advised."] = "Araj, o Evocador, é elite: recomenda-se formar um grupo.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",

	-- Step 81: Felstone Field
	["Felstone Field"] = "",
	-- {npc:10778} Janice Felstone
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of Felstone Field, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "",
	["Upstairs"] = "",

	-- Step 82: Northridge Lumber Camp
	["Northridge Lumber Camp"] = "",
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Siga a estrada para o norte até a serraria e coloque o barril de cupins no meio dela.",

	-- Step 83: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (opcional)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} Fordring vive numa pequena cabana à beira do rio da fronteira, a nordeste da madeireira. Entregue {quest:5781} se você a concluiu.",

	-- Step 85: Of Lost Honor
	["Underwater"] = "",

	-- Step 87: Egan
	-- {npc:1855} Tirion Fordring · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into Terrordale: {npc:11140} stands by Augustus' ruined hut."] = "",

	-- Step 89: Scholomance (optional)
	["Scholomance (optional)"] = "",
	-- {zone:1422} Western Plaguelands
	["Running Scholomance (Caer Darrow, south-east {zone:1422}) or Stratholme instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "",
	-- {quest:5505} The Key to Scholomance
	["Scholomance fits levels 58 to 60; {quest:5505} is handed in at Chillwind Camp below."] = "",

	-- Step 90: Grind to 60
	["Grind to 60"] = "Upe até o 60",
	-- {npc:1855} Tirion Fordring
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into Terrordale. The Terrordale Spirits haunt the woods there. Or, with a group, run the Scholomance dungeon or the Stratholme dungeon instead."] = "",
	-- {npc:14564} Terrordale Spirit · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at Terrordale, {zone:1423}"] = "",

	-- Step 92: Chillwind Camp
	["Ride back south-west to Chillwind Camp."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "De volta a {area:1770}: {npc:9861} e {npc:9860} protegem {npc:9517} na câmara mais profunda.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Suba {area:537}, no meio da cratera, e use o {item:14644} junto ao lago de lava no topo, com duas Barras de Tório nas bolsas. Encha as Jarras de Amostra Pura Vazias de {npc:9616} nas Gosmas Primevas das poças ao redor da serra.",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Atravesse o rio a leste de {npc:1855} até {area:2627}. Os Espíritos da Várzea do Medo assombram o bosque ali.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Os Dragasmagas vagueiam pelas dunas entre {area:2743} e {area:3425}, no caminho de volta. {npc:15181} só oferece {quest:8304} a partir do nível 58.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Voe para {area:3137} em {zone:1447} e siga para o oeste pela estrada até {area:2358}, logo depois da fronteira de {zone:1440}.",
	-- ["Fly to {area:976}."] = "Voe para {area:976}.",
	-- ["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Siga a estrada para o norte até {area:1767}. Os Pisoteadores de Ferrárbol carregam o coração; termine as garras nos Ursos-cinzentos Garraivosos e nos Assoladores Patavil do norte.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Siga a estrada para o sudoeste, saindo do desfiladeiro, até {area:3425}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Desça de volta até {area:702}, pegue o barco para {area:442} e depois o barco até {area:17203}. Leve sessenta Sedas, sessenta Magitramas e sessenta {item:14047} para {npc:14722}: compre o que faltar na Casa de Leilões.",
	-- ["Grind to 58"] = "Upe até o 58",
	-- ["Grind to 59"] = "Upe até o 59",
	-- ["Havunth's camp sits just west of {area:3425}."] = "O acampamento do Guardião do Crepúsculo Havunth fica logo a oeste de {area:3425}.",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Regresse para {area:1519} e treine seus feitiços de nível 60. Este é o fim da rota de evolução: veja depois os guias de reputação e de masmorras.",
	-- ["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Regresse para {area:392} e voe para {area:976}. Compre duas Barras de Tório na Casa de Leilões daqui para {quest:5801}.",
	-- ["Into {zone:1451}"] = "Rumo a {zone:1451}",
	-- ["Level 60"] = "Nível 60",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Volte para o norte até {area:2255} e siga para o oeste pela estrada até a aldeia dos elfos noturnos.",
	-- ["Ride back south-west to {area:3197}."] = "Volte para o sudoeste até {area:3197}.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Volte para {area:3137} e voe para {area:2255}.",
	-- ["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Siga para o leste até as ruínas de {area:2738}. {object:179565} está entre os edifícios em ruínas, vigiado por Sentinelas Torturadas.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Siga para o norte saindo de {area:415} até {zone:1448}, até o acampamento dos druidas na estrada, logo depois da fronteira.",
	-- ["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Siga para o norte até a aldeia dos furbolgs de Lenha Morta, perto da entrada da caverna de {area:1769}.",
	-- ["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Siga para o norte até {area:541}. Use {npc:10980} ao lado de {npc:10977}.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Siga para o sul até {area:2250}. Proteja {npc:10300} enquanto ela acende as tochas a caminho de {object:177404}.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Siga para o sudoeste até o acampamento de {npc:7771} em {area:1938}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Siga para o oeste ao longo da parede norte da cratera até o desfiladeiro no canto noroeste, que sobe para {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:2057} ({area:2298}, sudeste de {zone:1422}) ou {area:2279} em vez de farmar leva você lá mais rápido em grupo. Pule esta etapa para farmar sozinho.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:2577} em {zone:1444} em vez de farmar leva você lá mais rápido em grupo. Pule esta etapa para farmar sozinho.",
	-- ["Shaman training"] = "Treinamento de xamã",
	-- ["Take the boat from {area:442} to {area:702}."] = "Pegue o barco de {area:442} para {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Pegue a rota de voo em {area:2361} e voe para {area:442}.",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Pegue a estrada para o oeste, desça até a cratera e siga até a {area:540}, a caverna dos silitídeos no sul. {npc:10041} espera na câmara mais profunda.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Pegue o túnel de {area:1769} pela entrada de {zone:1452}, a oeste de {npc:9298}, e siga o ramal de {area:493} até {area:2361}. {npc:11939} estuda à beira do lago.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Pegue o {area:2257} para {zone:1455}. {npc:14724} e {npc:14723} querem, cada um, sessenta Lãs, sessenta Sedas e sessenta Magitramas, e depois sessenta {item:14047}: 120 de cada no total, das suas bolsas ou da Casa de Leilões.",
	-- ["The hermit hides among the rocks south-east of {area:2738}."] = "O eremita se esconde entre as rochas a sudeste de {area:2738}.",
	-- ["The {area:2479}"] = "{area:2479}",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {area:3098}"] = "{area:3098}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Os ursos {npc:7446} vagueiam pelo vale nevado ao sul de {area:2250}.",
	-- ["Toward the north-west pass"] = "Rumo ao desfiladeiro noroeste",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Você começa em {area:392}, para onde o guia anterior mandou você regressar. Voe para {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "farme {npc:11741} nas dunas a leste de {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "farme {npc:14564} em {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "farme {npc:7446} no vale ao sul de {area:2250}, {zone:1452}",
	-- ["{area:1770} braziers"] = "Braseiros de {area:1770}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} é a caverna no fundo de {area:1763}, a oeste da estrada. Use o {item:12906} nos quatro braseiros lá dentro. Mate os Ursos Garraivosos e os Lobos Patavil pelo caminho para obter {item:11172}.",
	-- ["{area:2057} (optional)"] = "{area:2057} (opcional)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} é para os níveis 58 a 60; {quest:5505} é entregue em {area:3197}, abaixo.",
	-- ["{area:2577} (optional)"] = "{area:2577} (opcional)",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} é para os níveis 55 a 60; farmar {npc:7446}, abaixo, leva você ao 59 sozinho.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "O fantasma de {npc:10778} vagueia perto da casa da fazenda de {area:199}, a oeste das Ruínas de Andorhal. Os Carniçais Grasnantes do campo carregam a outra metade do amuleto: junte as duas metades.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: termina em {zone:1452}, guarde-a",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, se você tiver trinta {quest:6031}",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, logo na entrada da caverna: só a partir de Neutro com os Presamatos",
	-- ["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "A casa de {npc:11801} fica em {area:2361}, a leste de {npc:11939}.",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, o estalajadeiro",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} acampa fora de {area:2743}, a colmeia do oeste. Pegue um Silitista em um dos gêiseres vermelhos próximos e leve-o ao extrator da Aliança no acampamento dele.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, nas tendas da Aliança",
	-- ["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, no alto de {area:1658}",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: o guia anterior leva você até aqui com a pedra de regresso, então isto costuma ser marcado na hora",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} espera em {area:1767}. Escolte-a para fora do bosque e mantenha-a viva.",
	-- ["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, se você encontrou o Frasco Vazio de Aguardente em {zone:1452}",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} em {zone:1452}, guarde-a",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} e as Terras Pestilentas",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} de {object:28027} para {zone:1455} e treine seus feitiços de nível 60 com {npc:258098}.",
}
