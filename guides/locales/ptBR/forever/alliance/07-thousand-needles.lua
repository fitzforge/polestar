-- Portuguese (Brazil) (ptBR): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "Sem {item:4371} para {quest:174}? {npc:3133} vende na casa ao lado de {npc:276}, em estoque limitado; {npc:1448}, em {area:150}, também vende.",
	-- {npc:352} Dungar Longdrink · {zone:1453} Stormwind
	["From {npc:352} in {zone:1453}"] = "De {npc:352}, em {zone:1453}",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taberna Corvo Escarlate",
	-- {npc:840} Watcher Backus
	["{npc:840}, at the north entrance of town"] = "{npc:840}, na entrada norte da cidade",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, na prefeitura",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, junto à prefeitura",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, de {npc:3133}, se não tiver nenhum",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, at the east end of town"] = "{npc:276}, no extremo leste da cidade",

	-- Step 2: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "Tece-sombras Nocturnos",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "Os worgens dominam a mata do Bosque Brilhante, a oeste de {area:42} e ao norte da estrada. Puxe um de cada vez.",

	-- Step 4: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "Corretrevas Nocturnos",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "Os Corretrevas rondam a mata ao sul da estrada, a oeste de {area:42}.",

	-- Step 6: Blind Mary
	-- {area:42} Darkshire
	["Her house stands on the hill south-east of {area:42}."] = "A casa dela fica na colina a sudeste de {area:42}.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "Presas Torpes Nocturnos e {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "Os worgens mais fortes vagam pela mata ao sul de {area:42}, a oeste e ao sul de {area:121}. {npc:511} se esconde na pequena cripta junto ao cemitério.",

	-- Step 8: Darkshire
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house"] = "{npc:661}, junto à casa de {npc:633}",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "Siga para o oeste pela estrada; o barraco do eremita fica a nordeste de {area:492}.",

	-- Step 10: Plague Spreaders
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["Plague Spreaders"] = "Vetores da Peste",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Os Vetores da Peste andam pela metade norte de {area:492}. {npc:522}, um elite, vaga entre os túmulos: fique longe dele.",

	-- Step 11: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "Acampamento do {npc:311}",

	-- Step 12: Raven Hill Cemetery, west
	-- {area:492} Raven Hill Cemetery
	["{area:492}, west"] = "{area:492}, oeste",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "Saqueadores, Curandeiros e Guardadores Descarnados dominam a parte oeste do cemitério, logo a leste do acampamento de {npc:311}.",

	-- Step 13: Sven Yorgen's Camp
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "Para {npc:1212}, em {zone:1453}, no próximo guia",

	-- Step 14: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "O acampamento dos Défias fica no sudoeste de {zone:1431}, ao sul de {area:94}, perto da fronteira com {zone:1436}. A caixa-forte fica entre as barracas.",

	-- Step 15: Vul'Gol Ogre Mound
	-- {object:119} Abercrombie's Crate
	["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Siga para o leste até a Gruta de Vul'Gol. {object:119} está no acampamento da entrada; ogros Punhalasca o guardam.",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "Só se um {npc:272273} deixou cair {quest:96138}: clique com o botão direito nele",

	-- Step 17: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "De volta a {area:42}",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "Para {npc:482}, em {zone:1453}, no próximo guia",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}, na prefeitura",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, na casa atrás da prefeitura",
	["Wait a moment, then speak with her again"] = "Espere um momento e fale com ela de novo",

	-- Step 18: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, na estalagem",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217}, no andar de cima da estalagem",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104}, junto à fortaleza",

	-- Step 19: The wreck of the Third Fleet
	["The wreck of the Third Fleet"] = "O naufrágio da Terceira Frota",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "Siga a costa para o norte até o navio naufragado. Marinheiros Amaldiçoados andam pela praia, Fuzileiros Amaldiçoados pelo convés; {npc:1159} fica na praia, junto à proa. Crocoliscos do Pantanal Gigantes espreitam na costa logo ao norte.",

	-- Step 20: Bluegill Raiders
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Bluegill Raiders"] = "Saqueadores Guelrazul",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "Siga a costa para nordeste, passando o naufrágio: os Saqueadores Guelrazul dominam o brejo depois dos Crocoliscos Gigantes.",

	-- Step 22: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "O capitão anda pelo convés do navio naufragado; a caixa-forte dele fica no porão.",

	-- Step 23: Glorin Steelbrow
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, in the next guide"] = "Para {npc:1284}, em {zone:1453}, no próximo guia",

	-- Step 24: Whelgar's Excavation Site
	["Follow the road east to the excavation site."] = "Siga a estrada para o leste até o Sítio de Escavação de Whelgar.",

	-- Step 25: The dig and Sarltooth
	-- {npc:1353} Sarltooth
	["The dig and {npc:1353}"] = "A escavação e {npc:1353}",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "As relíquias ficam na própria escavação. {npc:1353}, um Rasgaqueixo grande, ronda o vale dos raptores logo a oeste.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 26: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} e Whelgar",

	-- Step 27: Dragonmaw camp
	["Dragonmaw camp"] = "Acampamento Presa do Dragão",
	["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Os orcs Presa do Dragão acampam a leste do sítio de escavação. Saqueadores e Corre-brejos carregam os estandartes de guerra.",

	-- Step 28: Captain Stoutfist
	-- {area:150} Menethil Harbor
	["Ride back west along the road to {area:150}."] = "Volte para o oeste pela estrada até {area:150}.",

	-- Step 29: Dragonmaw catapult
	["Dragonmaw catapult"] = "Catapulta Presa do Dragão",
	["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "Siga para o leste de novo; a catapulta fica no acampamento Presa do Dragão, ao sul da estrada.",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "A próxima etapa, Derrotar Nek'rosh, coloca você contra um chefe elite: pule-a.",

	-- Step 30: To Theramore
	["To Theramore"] = "Para Theramore",
	-- {area:513} Theramore Isle · {zone:1445} Dustwallow Marsh
	["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "Pegue o barco no píer de Menethil até {area:513}, em {zone:1445}.",

	-- Step 31: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Na estrada para o sul por {zone:1413}, {npc:6244} acampa a leste da estrada, a nordeste de {area:378}; chegue pelo leste e fique longe dos guardas da Horda.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: em {zone:1440}, no caminho para {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: o íncubo, ao lado da súcubo; {item:190309} fica perto de {quest:1738}",

	-- Step 32: The Great Lift
	-- {zone:1413} Barrens · {area:378} Camp Taurajo · {area:485} The Great Lift · {zone:1441} Thousand Needles
	["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "De Theramore, siga a estrada para o oeste, saindo do Pântano Vadeoso para {zone:1413}, e desça para o sul por ela; mantenha distância de {area:378}. {area:485}, no extremo sul de {zone:1413}, leva você para baixo, até {zone:1441}. O diário fica ao pé do elevador.",
	-- {npc:4048} Falfindel Waywarder · {zone:1444} Feralas
	["For {npc:4048} in {zone:1444}, much later"] = "Para {npc:4048}, em {zone:1444}, bem mais tarde",

	-- Step 33: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Siga os cânions para o leste até as planícies de sal. Os goblins e gnomos de {area:2240} são neutros e dão missões às duas facções.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Para {quest:5762}, na Selva do Espinhaço, mais tarde",

	-- Step 34: The salt flats
	["The salt flats"] = "As planícies de sal",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Scorpid Terrors = {npc:4139} Scorpid Terror
	["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868} está espalhado por toda a planície. Aniquiladores Escorpídeos, Tartarugas Quelobrilho e Basiliscos Sal-gema vagam pela metade norte; Cristaldermes, Terrores Escorpídeos e Tartaliscas, pelo meio; e os Observadores (34-35, cinco níveis acima de você: um de cada vez), pelo extremo sul. Abutres sobrevoam tudo.",

	-- Step 35: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}: para Martek, em {zone:1418}, mais tarde",

	-- Step 36: Back to Menethil
	["Back to Menethil"] = "De volta a Menethil",
}
