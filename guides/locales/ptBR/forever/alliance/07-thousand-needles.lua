-- Portuguese (Brazil) (ptBR): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Darkshire
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taberna Corvo Escarlate",
	-- {npc:840} Watcher Backus · {area:42} Darkshire
	["{npc:840}, at the north entrance of town; walks around {area:42}: look inside the circle on the map"] = "{npc:840}, na entrada norte da cidade; anda por {area:42}: procure dentro do círculo no mapa",

	-- Step 3: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "Tece-sombras Nocturnos",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "Os worgens dominam a mata do Bosque Brilhante, a oeste de {area:42} e ao norte da estrada. Puxe um de cada vez.",

	-- Step 5: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "Corretrevas Nocturnos",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "Os Corretrevas rondam a mata ao sul da estrada, a oeste de {area:42}.",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "Presas Torpes Nocturnos e {npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul · {spell:8282} Curse of Blood
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery.\nCareful: {spell:8282} lasts 10 minutes and adds 13 to each hit of physical damage you take.\nCareful: Some worgen outside the cave stand in groups, including one camp of four. To avoid adds, pull them one at a time from the raised ground next to the cave entrance."] = "Os worgens mais fortes andam pela mata ao sul de {area:42}, a oeste e ao sul de {area:121}. O {npc:511} se esconde na criptinha junto ao cemitério.\nCuidado: {spell:8282} dura 10 minutos e soma 13 a cada golpe de dano físico que você leva.\nCuidado: alguns worgens fora da caverna ficam em grupo, incluindo um acampamento de quatro. Para não puxar a mais, puxe um de cada vez do terreno alto ao lado da entrada da caverna.",
	-- {item:1946} Mary's Looking Glass
	["{item:1946}; inside"] = "{item:1946}; lá dentro",

	-- Step 8: Darkshire
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, lá dentro",
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house; inside"] = "{npc:661}, junto à casa de {npc:633}; lá dentro",

	-- Step 9: Vul'Gol Ogre Mound: kill these as you meet them
	-- {area:93} Vul'Gol Ogre Mound
	["{area:93}: kill these as you meet them"] = "{area:93}: vá matando estes pelo caminho",
	-- {area:42} Darkshire · {object:119} Abercrombie's Crate
	["Head south-west from {area:42} to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "Siga para sudoeste, de {area:42}, até a Gruta de Vul'Gol. {object:119} fica no acampamento da entrada; ogros Punhalasca o guardam.",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "Só se um {npc:272273} deixou cair {quest:96138}: clique com o botão direito nele",
	["Below ground"] = "No subterrâneo",

	-- Step 10: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "O acampamento dos Défias fica no sudoeste de {zone:1431}, ao sul de {area:94}, perto da fronteira com {zone:1436}. A caixa-forte fica entre as barracas.",
	-- {item:5947} Defias Docket
	["{item:5947}; inside"] = "{item:5947}; lá dentro",

	-- Step 12: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}: vá matando estes pelo caminho",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim · {npc:311} Sven Yorgen
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader · Skeletal Raiders = {npc:1110} Skeletal Raider
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him.\nSkeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp.\nCareful: The skeletons in the catacombs are packed close together, so you can easily pull extra mobs."] = "Os Vetores da Peste andam pela metade norte de {area:492}. {npc:522}, um elite, perambula entre os túmulos: fique longe dele.\nSaqueadores, Curandeiros e Guardadores Descarnados ocupam a parte oeste do cemitério, logo a leste do acampamento de {npc:311}.\nCuidado: os esqueletos das catacumbas ficam amontoados, então é fácil puxar monstro a mais.",

	-- Step 13: The Weathered Grave
	-- {npc:311} Sven Yorgen · {npc:268} Sirra Von'Indi · {area:42} Darkshire
	["The grave stands among the skeletons at the cemetery's north-west corner, on the way to {npc:311}. Its quest and the next are talk-only, to {npc:268} and Commander Althea in {area:42}: level 35 from level 28, but no fight."] = "O túmulo fica entre os esqueletos, no canto noroeste do cemitério, no caminho para {npc:311}. A missão dele e a seguinte são só de conversa, com {npc:268} e a Comandante Aldora, em {area:42}: nível 35 a partir do nível 28, mas sem luta.",

	-- Step 14: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "Acampamento do {npc:311}",
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "Para {npc:1212}, em {zone:1453}, no próximo guia",

	-- Step 15: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "De volta a {area:42}",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}, na prefeitura",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, na casa atrás da prefeitura",
	["Wait a moment, then speak with her again"] = "Espere um momento e fale com ela de novo",
	-- {npc:840} Watcher Backus · {area:42} Darkshire
	["{npc:840} walks around {area:42}: look inside the circle on the map"] = "{npc:840} anda por {area:42}: procure dentro do círculo no mapa",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "Para {npc:482}, em {zone:1453}, no próximo guia",

	-- Step 16: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}'s house stands at the east end of town, on the way to the flight master."] = "A casa de {npc:276} fica na ponta leste da cidade, no caminho para o mestre de voo.",
	["Inside"] = "Lá dentro",

	-- Step 17: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "Mestre de voo de {area:42}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Menethil"] = "De volta a Menethil",
	-- ["Bluegill Raiders"] = "Saqueadores Guelrazul",
	-- ["Dragonmaw camp"] = "Acampamento Presa do Dragão",
	-- ["Dragonmaw catapult"] = "Catapulta Presa do Dragão",
	-- ["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Siga os cânions para o leste até as planícies de sal. Os goblins e gnomos de {area:2240} são neutros e dão missões às duas facções.",
	-- ["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "Siga a costa para o norte até o navio naufragado. Marinheiros Amaldiçoados andam pela praia, Fuzileiros Amaldiçoados pelo convés; {npc:1159} fica na praia, junto à proa. Crocoliscos do Pantanal Gigantes espreitam na costa logo ao norte.",
	-- ["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "Siga a costa para nordeste, passando o naufrágio: os Saqueadores Guelrazul dominam o brejo depois dos Crocoliscos Gigantes.",
	-- ["Follow the road east to the excavation site."] = "Siga a estrada para o leste até o Sítio de Escavação de Whelgar.",
	-- ["For the Dragonmaw catapult, on the {zone:1437} loop of the next guide"] = "Para a catapulta dos Presa do Dragão, na volta por {zone:1437} do próximo guia",
	-- ["For {npc:1284} in {zone:1453}, in the next guide"] = "Para {npc:1284}, em {zone:1453}, no próximo guia",
	-- ["For {npc:4048} in {zone:1444}, much later"] = "Para {npc:4048}, em {zone:1444}, bem mais tarde",
	-- ["For {quest:5762} in Stranglethorn, later"] = "Para {quest:5762}, na Selva do Espinhaço, mais tarde",
	-- ["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "De Theramore, siga a estrada para o oeste, saindo do Pântano Vadeoso para {zone:1413}, e desça para o sul por ela; mantenha distância de {area:378}. {area:485}, no extremo sul de {zone:1413}, leva você para baixo, até {zone:1441}. O diário fica ao pé do elevador.",
	-- ["From {npc:352} in {zone:1453}"] = "De {npc:352}, em {zone:1453}",
	-- ["Her house stands on the hill south-east of {area:42}."] = "A casa dela fica na colina a sudeste de {area:42}.",
	-- ["Nightbane Shadow Weavers"] = "Tece-sombras Nocturnos",
	-- ["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "Sem {item:4371} para {quest:174}? {npc:3133} vende na casa ao lado de {npc:276}, em estoque limitado; {npc:1448}, em {area:150}, também vende.",
	-- ["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Na estrada para o sul por {zone:1413}, {npc:6244} acampa a leste da estrada, a nordeste de {area:378}; chegue pelo leste e fique longe dos guardas da Horda.",
	-- ["Plague Spreaders"] = "Vetores da Peste",
	-- ["Ride back west along the road to {area:150}."] = "Volte para o oeste pela estrada até {area:150}.",
	-- ["Ride east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "Cavalgue de novo para o leste até o acampamento dos Presa do Dragão. Os quatro conjuntos de planos de ataque estão em {area:1036}; {npc:2091}, um elite, também fica no acampamento.",
	-- ["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "Siga para o leste de novo; a catapulta fica no acampamento Presa do Dragão, ao sul da estrada.",
	-- ["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "Siga para o oeste pela estrada; o barraco do eremita fica a nordeste de {area:492}.",
	-- ["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "Saqueadores, Curandeiros e Guardadores Descarnados dominam a parte oeste do cemitério, logo a leste do acampamento de {npc:311}.",
	-- ["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "Pegue o barco no píer de Menethil até {area:513}, em {zone:1445}.",
	-- ["The Defias camp lies in the south-west of {area:10}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "O acampamento dos Défias fica no sudoeste de {area:10}, ao sul de {area:94}, perto da fronteira com {zone:1436}. A caixa-forte fica entre as barracas.",
	-- ["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "Os orcs Presa do Dragão acampam a leste do sítio de escavação. Saqueadores e Corre-brejos carregam os estandartes de guerra.",
	-- ["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Os Vetores da Peste andam pela metade norte de {area:492}. {npc:522}, um elite, vaga entre os túmulos: fique longe dele.",
	-- ["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "O capitão anda pelo convés do navio naufragado; a caixa-forte dele fica no porão.",
	-- ["The dig and {npc:1353}"] = "A escavação e {npc:1353}",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "A próxima etapa, Derrotar Nek'rosh, coloca você contra um chefe elite: pule-a.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "As relíquias ficam na própria escavação. {npc:1353}, um Rasgaqueixo grande, ronda o vale dos raptores logo a oeste.",
	-- ["The salt flats"] = "As planícies de sal",
	-- ["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "Os worgens mais fortes vagam pela mata ao sul de {area:42}, a oeste e ao sul de {area:121}. {npc:511} se esconde na pequena cripta junto ao cemitério.",
	-- ["The wreck of the Third Fleet"] = "O naufrágio da Terceira Frota",
	-- ["To Theramore"] = "Para Theramore",
	-- ["{area:492}, west"] = "{area:492}, oeste",
	-- ["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
	-- ["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",
	-- ["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, de {npc:3133}, se não tiver nenhum",
	-- ["{npc:1078} and Whelgar"] = "{npc:1078} e Whelgar",
	-- ["{npc:1217}, upstairs in the inn"] = "{npc:1217}, no andar de cima da estalagem",
	-- ["{npc:1239}, in the inn"] = "{npc:1239}, na estalagem",
	-- ["{npc:2104}, by the keep"] = "{npc:2104}, junto à fortaleza",
	-- ["{npc:2104}, in {area:2103}"] = "{npc:2104}, em {area:2103}",
	-- ["{npc:267}, in the town hall"] = "{npc:267}, na prefeitura",
	-- ["{npc:276}, at the east end of town"] = "{npc:276}, no extremo leste da cidade",
	-- ["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}: para Martek, em {zone:1418}, mais tarde",
	-- ["{npc:661}, by {npc:633}'s house"] = "{npc:661}, junto à casa de {npc:633}",
	-- ["{npc:663}, by the town hall"] = "{npc:663}, junto à prefeitura",
	-- ["{npc:840}, at the north entrance of town"] = "{npc:840}, na entrada norte da cidade",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868} está espalhado por toda a planície. Aniquiladores Escorpídeos, Tartarugas Quelobrilho e Basiliscos Sal-gema vagam pela metade norte; Cristaldermes, Terrores Escorpídeos e Tartaliscas, pelo meio; e os Observadores (34-35, cinco níveis acima de você: um de cada vez), pelo extremo sul. Abutres sobrevoam tudo.",
	-- ["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: em {zone:1440}, no caminho para {zone:1443}",
	-- ["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: o íncubo, ao lado da súcubo; {item:190309} fica perto de {quest:1738}",
	-- ["{quest:98221}: {quest:465} comes after it on Forever"] = "{quest:98221}: no Forever, {quest:465} vem depois dela",
}
