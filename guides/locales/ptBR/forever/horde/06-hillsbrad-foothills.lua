-- Portuguese (Brazil) (ptBR): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Você chega vinculado à estalagem de {area:272}. Todos ficam em volta da praça da cidade.",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "O cartaz {object:1763} perto da estalagem",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "O cartaz {quest:567}: os alvos aparecem pelo caminho",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well (no name in this language: may be words)
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Encha o {item:7768} no {object:107045} ao lado da estalagem",

	-- Step 2: Serge Hinott
	-- {zone:1413} The Barrens · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Só se Gallywix caiu nos {zone:1413} (Missão: possível, mas não provável): {npc:2391} fica em {area:272}. Espere ao lado dele enquanto prepara a cura e pegue sua recompensa: Venenos.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Venenos",
	["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Ainda sem Gallywix? O guia de classe Venenos (Horda) refaz a cadeia a partir de Shenthul, com um grupo para Gallywix.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Ursos, rastejantes e leões",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "A oeste da Serraria Tarren, Ursos Cinzentos, Rastejantes do Musgo da Floresta e Leões da Montanha Esfomeados vagam pelas colinas no caminho até as fazendas. Os rastejantes raramente derrubam {item:3477}; você só precisa de um.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "As fazendas a leste da cidade de {area:287}. {npc:232} trabalha no campo perto da casa da fazenda ao norte, {npc:2403} no que fica mais a sudeste; Lavradores e Fazendeiros estão por toda parte. {npc:2451} cuida do campo ao sul das fazendas.",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "{npc:2230}, ao lado de Lindolfo",
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: ordens para {npc:270438}, a caminho do Forte do Desterro",

	-- Step 6: Syndicate camps
	["Syndicate camps"] = "Acampamentos da Camarilha",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "De {area:272}, vá para sudeste pelas colinas no caminho até {area:275}. Ladinos e Vigias ocupam os acampamentos pelo caminho.",

	-- Step 7: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull e {npc:2238} estão acorrentados nos prédios do pátio de {area:275}; abra as duas trancas.",
	["Drull's ball and chain"] = "Bola e corrente de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Bola e corrente de {npc:2238}",

	-- Step 8: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj se esconde na encosta acima de {area:290}, ao sul do Forte do Desterro, no caminho até as flores.",

	-- Step 9: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "A sudoeste do Forte do Desterro, as {item:3502} crescem nas encostas acima do rio.",

	-- Step 10: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, em {zone:1458}",

	-- Step 11: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} é o cachorro de {npc:232}, na casa da fazenda ao norte, em {area:286}.",

	-- Step 12: Peasants and skulls
	["Peasants and skulls"] = "Camponeses e caveiras",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Os Camponeses trabalham nos campos ao sul das casas de fazenda. Todo humano de {area:287} derruba caveiras; os Camponeses derrubam com mais frequência.",

	-- Step 14: The smithy
	["The smithy"] = "A ferraria",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "A ferraria fica no meio da cidade de {area:287}. {npc:2404} e seus aprendizes trabalham na forja; o {object:1736} está empilhado ao lado. {npc:2449} anda pela rua ao norte dela.",

	-- Step 16: Town hall
	["Town hall"] = "Prefeitura",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "A prefeitura fica no lado oeste de {area:287}. {npc:2335} (30) e {npc:2448} estão lá dentro com o Cartório de Eira dos Montes; a Proclamação de Eira dos Montes está afixada ao lado. Conselheiros andam pela cidade.",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "A {area:288} fica ao sul da cidade de {area:287}. Mineradores trabalham nos túneis; {npc:2305} (30) e {npc:2450} (29) estão bem lá no fundo.",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, no Apothecarium",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Guarde: o litoral de {area:287}, mais adiante na rota",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Pegue o zepelim nas torres fora de {zone:1458} até {zone:1454} e treine antes de seguir voando.",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "De {zone:1454} (zepelim das torres fora de {zone:1458}), voe até {area:1638} e treine em {area:1639}, depois siga voando até {area:378}.",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "De {zone:1454} (zepelim das torres fora de {zone:1458}), voe até {area:378}.",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "A cabana de {npc:5899} fica na crista acima do bebedouro dos javaligs, ao sul de {area:378}, no caminho até {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: o odre vermelho de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: o odre azul é enchido em {zone:1440}, no próximo guia",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Siga a estrada para o sul até a escavação anã em {area:359}. {npc:3421} se esconde na borda sul da escavação; {object:3646} fica no fundo da escavação.",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "A sudoeste de Bael Modan, {npc:12576} espera no topo do {area:1718}.",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Use a Pedra de Regresso para {area:378} e voe até {area:392}. {quest:874} acampa na praia ao norte de {area:392}.",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, um grande manguadonte, nada nas águas rasas da {area:391}, a leste de {npc:3388}.",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, perto das docas em {area:392}",
}
