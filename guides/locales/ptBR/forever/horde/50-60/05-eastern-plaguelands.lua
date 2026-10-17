-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Voe para a {area:2268}",
	-- {object:1661} The Undercity (no name in this language: may be words) · {object:36078} Trade Quarter (no name in this language: may be words)
	["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "O mestre de voo de {object:1661} fica na torre oeste do {object:36078}, fora das muralhas.",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Os itens de {quest:5168} estão nas próximas zonas das Terras Pestilentas: guarde-a.",

	-- Step 3: Lake Mereldar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Cães Pestilentos e seus filhotes vagam pelas margens do lago a sudoeste da capela.",

	-- Step 4: Sword of Marduk
	["Sword of Marduk"] = "Espada de Marduk",
	["The shattered sword lies on the ground north-west of the lake."] = "A espada estilhaçada está no chão a noroeste do lago.",

	-- Step 5: The Pestilent Scar
	-- {area:2622} Pestilent Scar
	["The {area:2622}"] = "A {area:2622}",
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "O crânio está na {area:2622}, entre Horrores Empesteados e Monstruosidades da Peste.",

	-- Step 6: Hameya's scroll
	["Hameya's scroll"] = "O pergaminho de Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Um pergaminho rasgado está na entrada da {area:2261}, a cripta ao sul da {area:2260}.",

	-- Step 7: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead
	["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "O campeão de {npc:15193} ocupa a casa da {area:2260}.",

	-- Step 8: The western hills
	["The western hills"] = "As colinas do oeste",
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Cães Pestilentos Miúdos e Quirópragos vagam pelas colinas ao norte de {area:2260}, e Vermes Carniceiros rastejam entre eles; avance para o norte rumo a {area:2627}.",

	-- Step 9: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "O fantasma {npc:11140} fica junto a uma cabana na {area:2627}, no canto noroeste.",

	-- Step 10: Quel'Lithien Lodge
	-- {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Os Patrulheiros, Trilheiros e Mateiros altos elfos guardam o pavilhão perto da {area:2275}; os Arquivos estão lá dentro. Os Patrulheiros chegam ao nível 60: puxe um de cada vez. Quirópragos Nóxios sobrevoam os campos no caminho.",

	-- Step 11: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Hameya se esconde entre os trolls Esfolamusgo de {area:2273}, no canto nordeste.",

	-- Step 12: Northdale
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Cães Pestilentos Frenéticos e Quirópragos Monstruosos dividem os campos em volta do {area:2272} e da {area:2271}, ao sul de {area:2273}.",

	-- Step 13: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} estraga em dez minutos: mate rápido o Flagelo da cidade e moa as sete partes com o {item:15454} na hora.",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Volte para oeste até a {area:2260}.",

	-- Step 15: Hameya's mound
	["Hameya's mound"] = "O monte de Hameya",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "O {object:177675} fica logo atrás da {area:2261}.",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Voe para {area:1638}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:1638} Thunder Bluff
	["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Voe para {zone:1458}, pegue o zepelim para {zone:1454} e siga voando para {area:1638}.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} no {area:1639}; {npc:246344}",

	-- Step 18: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "No {area:1641}. Tenha Lã, Seda e Magitrama na bolsa.",

	-- Step 20: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Só se você achou um frasco de {item:12820} em {zone:1452}: suba a estrada para o norte. O caldeirão fica em {area:1762}, logo a sudoeste de {area:1769}; os furbolgs Lenha Morta de lá são hostis.",

	-- Step 21: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Só se {quest:8471} caiu para você: {npc:11558} espera na entrada de {area:1769} pelo lado de {zone:1448}, e só fala com você com reputação Neutra com os Presamatos.",

	-- Step 22: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Atravesse {area:1769} e pegue o ramo do túnel para {zone:1450}. {npc:11801} está em {area:2361}.",
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "As duas missões levam a {zone:1451}: guarde-as.",

	-- Step 23: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Volte pelo túnel, pegue a saída para {zone:1452} e siga para o sul até {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} fica em {zone:1448}, numa viagem futura: guarde-a se a tiver.",

	-- Step 24: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Ferujas Lunamarcas",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Siga para leste até {area:2255} e saia dela para o norte; as Ferujas Lunamarcas vagam pelas colinas das encostas sul de {area:2241}. Puxe uma de cada vez.",

	-- Step 25: Back to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Back to {area:1638}"] = "De volta a {area:1638}",

	-- Step 26: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "A máquina {object:142071}",

	-- Step 27: Sprinkle
	-- {npc:10980} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Use {npc:10980} em {npc:7583}, a menina goblin em {area:976}. {npc:10977} e {npc:10978} levam o susto mais adiante na rota.",

	-- Step 28: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} é um fantasma no cemitério logo ao norte de {area:976}; a Lápide Suspeita fica ao sul dele, fora da muralha da cidade.",
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} volta para Linken na Cratera Un'Goro: guarde-a.",

	-- Step 29: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto à estrada da {area:1336}, ao sul de {area:976}.",

	-- Step 30: Hippogryph eggs
	["Hippogryph eggs"] = "Ovos de hipogrifo",
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Voe para o {area:1099}. Os ninhos de hipogrifo ficam no sul de {zone:1444}; cada um guarda um ovo para o {object:142071}.",

	-- Step 31: On to Silithus
	-- {zone:1451} Silithus
	["On to {zone:1451}"] = "Rumo a {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus · {area:3077} Valor's Rest
	["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Voe para o {area:541}, depois siga para sudoeste pela Cratera Un'Goro até o desfiladeiro que leva a {zone:1451}. O próximo guia começa em {area:3077}, onde o desfiladeiro termina.",
}
