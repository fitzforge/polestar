-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",
	-- {area:1099} Camp Mojache
	["From {area:1099}'s flight master."] = "Do mestre de voo do {area:1099}.",

	-- Step 2: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, ao lado do mestre de mantícoras",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "o {object:150075} na praça",

	-- Step 3: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "A oeste de Geringontzan, use o {item:8584} junto ao poço d'água no acampamento troll.",

	-- Step 5: Caliph Scorpidsting
	-- {npc:7847} Caliph Scorpidsting
	["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "A sudeste de Geringontzan, os bandidos Errantes acampam nas dunas; {npc:7847} fica no acampamento leste.",

	-- Step 6: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "Para oeste pela estrada do sul; {npc:7771} acampa junto às ruínas no {area:1938}. Equipe o {item:9978} dele: ele mostra os ornamentos enterrados, aqui e em volta do {area:983}.",

	-- Step 7: The Noxious Lair
	["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "A oeste, os insetos Centiparte enxameiam em volta das colmeias; qualquer um deles deixa cair as peças.",

	-- Step 8: Dunemaul Compound
	-- {area:982} The Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Ao sul do {area:982}, os ogros Dunamalho ocupam o complexo, com {npc:12046} no extremo leste. Desenterre ornamentos de {quest:3161} entre as lutas.",

	-- Step 9: Thistleshrub Valley
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "A oeste do complexo, as criaturas-cacto enchem o vale; só os Coletores de Orvalho levam uma glândula de orvalho. A maioria das criaturas de {zone:1446} pode deixar cair o transmissor de emergência de OOX-17/TN, raramente: guarde-o se aparecer.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, item raro",

	-- Step 10: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Escolta de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} espera no vale. Leve-o a pé até a esposa dele, {npc:6015}, no {area:977}, a nordeste atravessando o deserto: fique perto, diminua o passo por ele e afaste o que o atacar. Não monte nem use a Pedra de Regresso longe dele. {npc:8579} também fica no porto.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride south-west to {area:976}."] = "Cavalgue para sudoeste até {area:976}.",
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "a {item:8526} cresce em {zone:1425}, por volta do nível 48",

	-- Step 12: Marvon Rivetseeker
	["South down the road again."] = "Para o sul pela estrada de novo.",

	-- Step 13: Scrimshank's gear
	["Scrimshank's gear"] = "O equipamento de Anilhacido",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Mais ao sul, o equipamento do Inspetor Júnior Anilhacido está na entrada de uma colmeia Centiparte.",

	-- Step 14: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Só com o transmissor de emergência: OOX-17/TN fica a sudeste da colmeia de Anilhacido. Escolte-o para o norte até o {area:977}; a recompensa espera com Olhatorto em {area:35}.",

	-- Step 15: Gadgetzan
	-- {npc:7010} Zilzibin Drumlore · {area:1637} Orgrimmar
	["for {npc:7010} in {area:1637}, around level 50"] = "para {npc:7010} em {area:1637}, por volta do nível 50",

	-- Step 16: Orgrimmar
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {area:392} Ratchet
	["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Voe até {area:1637} e treine: a parada de treino do próximo guia é {zone:1458}, que não tem instrutor de Caçador nem de Xamã. Depois voe até {area:392}.",

	-- Step 17: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:392} Ratchet
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Voe até {area:1638} e treine com {npc:3033} no {area:1639}, depois voe até {area:392}.",

	-- Step 18: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voar para {area:392}",

	-- Step 19: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Navio para {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "O navio para {area:35} atraca no píer de {area:392}, abaixo do morro do mestre de voo.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Píer de {area:392}",

	-- Step 20: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Voar para {area:340}",
	-- {area:35} Booty Bay
	["From the {area:35} flight master, above the harbour."] = "Do mestre de voo de {area:35}, acima do porto.",

	-- Step 21: The Grimesilt Dig Site
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "O {area:247}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Pegue o desfiladeiro do lado oeste de {area:340} até {zone:1427} e cavalgue para sudoeste até o sítio de escavação. {object:173265} fica no extremo sul; os Geólogos Ferro Negro cavam logo ao norte. Leve 15 {item:4306} (a Casa de Leilões vende).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "a {object:173265}",

	-- Step 22: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Cavalgue para noroeste atravessando a garganta; {area:1446} é o acampamento com andaimes no noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "O quadro {object:179827}",

	-- Step 23: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Kalaran fica sozinho ao sul de {area:1446}, na borda d'O Caldeirão. Ouça a história dele.",

	-- Step 24: The Cauldron
	-- {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster
	["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Golens de Guerra Pesados patrulham O Caldeirão abaixo de Kalaran e deixam cair o óleo; os Elementais de Magma e Fulgurantes que flutuam entre eles deixam cair os corações. Os Capatazes e Feitores Ferro Negro tocam os escravos pelas trilhas; um Feitor pode deixar cair a {item:11818}: guarde-a.",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, item raro",

	-- Step 26: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "As fornalhas dos Vaporistas",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Os Vaporistas Ferro Negro trabalham nas fornalhas no meio d'O Caldeirão; metade deles leva um {item:10551}, um em dez o {item:18959}. Escravos, Feitores e Capatazes também levam punhais.",

	-- Step 27: Kalaran Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "O próximo pedido dele requer o {item:10552} de sectários de elite: deixe-o.",

	-- Step 28: The Slag Pit
	-- {area:1443} The Slag Pit
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} se abre no norte d'O Caldeirão. Incendossauros nadam nas poças de lava: atraia-os para a borda. Os planos secretos ficam na saliência superior do fosso.",

	-- Step 29: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Aranhas de Lava Abrasadoras",
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "As Aranhas de Lava Abrasadoras vagam pelos platôs e poças de lava no sudoeste da garganta.",

	-- Step 30: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Atalaias Ferro Negro",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Os Atalaias Ferro Negro ficam nas cristas em volta das torres de vigia ao sul d'O Caldeirão; cerca de um em dez leva a {item:18960}.",

	-- Step 31: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Só com a {item:11818}: de volta a leste até a {object:173265} no sítio de escavação.",

	-- Step 32: Thorium Point
	-- {area:1446} Thorium Point · {area:75} Stonard
	["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Cavalgue de volta para o norte até {area:1446}. Fique aqui: o próximo guia começa com o voo para {area:75}.",
}
