-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Alliance)"] = "{spell:71} e uma Arma (Aliança)",
	-- {spell:71} Defensive Stance · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{spell:71} at 10 and a one-hand weapon of your choice from {zone:1453}, {zone:1455} or {zone:1457}."] = "{spell:71} no nível 10 e uma arma de uma mão à sua escolha em {zone:1453}, {zone:1455} ou {zone:1457}.",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{npc:252377} em {area:16638}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "No nível 10, {npc:252377} fica com os instrutores junto ao portão oeste de {area:16638}. Uma cultista, {npc:257196}, guarda o escudo da família dela em {area:16629}.",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "Siga para noroeste saindo de {area:16638} até {area:16629}. {npc:257196} fica a oeste da aproximação do santuário, entre os Guardiões, Evocaespíritos e Mestres-lâmina do culto: puxe-os um de cada vez antes de pegá-lo. Ele solta {item:263993}.",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}, de {npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:6090} Bartleby · {zone:1453} Stormwind
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:6090}'s road below still gives a weapon, once you reach {zone:1453}."] = "De volta a {npc:252377}, em {area:16638}. Ela ensina {spell:71} e entrega {item:275290}, um escudo para usar com ela. O caminho de {npc:6090}, abaixo, ainda dá uma arma, quando você chegar a {zone:1453}.",

	-- Step 4: Muren Stormpike
	-- {npc:1229} Granis Swiftaxe · {area:131} Kharanos · {quest:1679} Muren Stormpike · {zone:1455} Ironforge · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:1229}, the warrior trainer in {area:131}, sends you to {quest:1679} in {zone:1455}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} is the quickest stance (one fight in a tavern), with a Haggard's weapon after it."] = "No nível 10, {npc:1229}, o instrutor de guerreiro em {area:131}, manda você para {quest:1679}, em {zone:1455}. Qualquer guerreiro da Aliança pode pegar um dos três caminhos, nunca dois: está em {zone:1453} no nível 10 de qualquer jeito? {quest:1638}, de {npc:5480}, é a postura mais rápida (uma luta numa taberna), com uma arma de Haggard depois.",

	-- Step 5: Muren Stormpike in Ironforge
	-- {quest:1679} Muren Stormpike · {zone:1455} Ironforge
	["{quest:1679} in {zone:1455}"] = "{quest:1679} em {zone:1455}",
	-- {quest:1679} Muren Stormpike · {object:32390} Hall of Arms (no name in this language: may be words) · {object:32359} Military Ward (no name in this language: may be words)
	["{quest:1679} stands in the {object:32390} in the {object:32359}."] = "{quest:1679} fica no {object:32390}, na {object:32359}.",

	-- Step 6: Vejrek
	-- {quest:1678} Vejrek · {area:135} Frostmane Hold · {spell:71} Defensive Stance · {spell:6343} Thunder Clap
	["{quest:1678} (level 11, a lone troll) waits at his hut on a hill south of {area:135}, near the mountains at the top of a short ramp, with no other trolls around; the hut at the front of {area:135} is the wrong one. He fights in {spell:71} and sunders your armor; {spell:6343} slows him. His head always drops; he returns about 8 minutes after dying."] = "{quest:1678} (nível 11, um troll solitário) espera na cabana dele, num morro ao sul de {area:135}, perto das montanhas, no topo de uma rampa curta, sem outros trolls por perto; a cabana da frente de {area:135} é a errada. Ele luta em {spell:71} e destrói sua armadura; {spell:6343} o deixa mais lento. A cabeça dele sempre cai; ele volta cerca de 8 minutos depois de morrer.",

	-- Step 7: Tormus Deepforge
	-- {npc:6114} Muren Stormpike · {spell:71} Defensive Stance · {quest:1680} Tormus Deepforge · {object:32372} Great Forge (no name in this language: may be words) · {zone:1455} Ironforge
	["Back to {npc:6114} for {spell:71}, then to {quest:1680} at the {object:32372} in the middle of {zone:1455}."] = "De volta a {npc:6114} para {spell:71}, depois a {quest:1680} na {object:32372}, no meio de {zone:1455}.",

	-- Step 8: Ironband's Compound
	-- {quest:1681} Ironband's Compound · {zone:1426} Dun Morogh · {area:212} Helm's Bed Lake · {object:85562} Ironband's Strongbox · {npc:6124} Captain Beld
	["{quest:1681} lies in eastern {zone:1426}, below {area:212} on its south side. Dark Iron Spies (level 8-10) stand along the way, far enough apart to pull one at a time. {object:85562} is in the basement of the southernmost house; {npc:6124} (level 11) stands by it and charges on sight. The box always holds the ore and refills 15 minutes after opening."] = "{quest:1681} fica no leste de {zone:1426}, embaixo de {area:212}, no lado sul. Espiões Ferro Negro (nível 8-10) ficam pelo caminho, afastados o bastante para puxar um de cada vez. {object:85562} fica no porão da casa mais ao sul; {npc:6124} (nível 11) fica ao lado e ataca assim que vê você. A caixa sempre guarda o minério e se enche 15 minutos depois de aberta.",
	-- {item:6800} Umbral Ore · {object:85562} Ironband's Strongbox
	["{item:6800}, from {object:85562}"] = "{item:6800}, de {object:85562}",

	-- Step 10: Elanaria
	-- {npc:3598} Kyra Windblade · {area:186} Dolanaar · {npc:2151} Moon Priestess Amara · {quest:1684} Elanaria · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {quest:1638} A Warrior's Training
	["At 10, {npc:3598}, the warrior trainer in {area:186}, or {npc:2151}, who patrols the road west of {area:186}, sends you to {quest:1684} on the {area:1660} in {zone:1457}. Any Alliance warrior may take one of the three roads, never two: in {zone:1453} at 10 anyway? {npc:5480}'s {quest:1638} teaches the same stance after one fight in a tavern."] = "No nível 10, {npc:3598}, o instrutor de guerreiro em {area:186}, ou {npc:2151}, que patrulha a estrada a oeste de {area:186}, manda você para {quest:1684}, em {area:1660}, em {zone:1457}. Qualquer guerreiro da Aliança pode pegar um dos três caminhos, nunca dois: está em {zone:1453} no nível 10 de qualquer jeito? {quest:1638}, de {npc:5480}, ensina a mesma postura depois de uma luta numa taberna.",

	-- Step 11: Elanaria in Darnassus
	-- {quest:1684} Elanaria · {zone:1457} Darnassus
	["{quest:1684} in {zone:1457}"] = "{quest:1684} em {zone:1457}",
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}."] = "{quest:1684} fica em {area:1660}.",

	-- Step 12: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:186} Dolanaar
	["{quest:1683} (level 10, a satyr) stands at a hidden moonwell up a hillside west of {area:186}. The trail is hard to spot: it starts behind a Gnarlpine camp and climbs in switchbacks lined with lamp posts. The furbolgs below can come in groups. His horn always drops; he returns 5 minutes after dying."] = "{quest:1683} (nível 10, um sátiro) fica num poço lunar escondido, morro acima a oeste de {area:186}. A trilha é difícil de achar: começa atrás de um acampamento Gnarlpine e sobe em ziguezague, ladeada de postes de lampião. Os furbolgs lá embaixo podem vir em grupos. O chifre dele sempre cai; ele volta 5 minutos depois de morrer.",

	-- Step 14: Elunite under Auberdine
	-- {area:442} Auberdine
	["Elunite under {area:442}"] = "Elunita embaixo de {area:442}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {npc:6133} Shade of Elura
	["Take the boat from {area:702} to {area:442}. The wreck lies underwater just south of {area:442}'s southern pier, where the Menethil boat docks. Open Crates of Elunite on the sea floor around the wreck, by a huge sunken turtle, toward the beach and under the pier until you have eight; every crate holds ore and comes back in 3-5 minutes. The grey {npc:6133} (level 11) drifts around the middle of the wreck and always drops the medallion: target it when you see it, so you can find it after surfacing for air. Watch your breath; Threshers can join in."] = "Pegue o barco de {area:702} até {area:442}. O naufrágio fica debaixo d'água, logo ao sul do cais sul de {area:442}, onde atraca o barco de Menethil. Abra Caixotes de Elunita no fundo do mar em volta do naufrágio, ao lado de uma tartaruga gigante afundada, em direção à praia e embaixo do cais, até ter oito; cada caixote guarda minério e volta em 3 a 5 minutos. O cinzento {npc:6133} (nível 11) flutua pelo meio do naufrágio e sempre solta o medalhão: selecione-o como alvo quando vir, para achar depois de subir para respirar. Fique de olho no fôlego; Debulhadores podem entrar na luta.",
	-- {item:6808} Elunite Ore
	["{item:6808}, from Crates of Elunite"] = "{item:6808}, dos Caixotes de Elunita",
	-- {item:6809} Elura's Medallion · {npc:6133} Shade of Elura
	["{item:6809}, from the {npc:6133}"] = "{item:6809}, de {npc:6133}",

	-- Step 15: Smith Mathiel
	-- {area:1660} Warrior's Terrace · {npc:4088} Elanaria · {item:6812} Case of Elunite · {npc:6142} Mathiel
	["Back on the {area:1660}: {npc:4088} hands you the {item:6812}; {npc:6142} works on the far, south side of the same terrace, easy to miss."] = "De volta a {area:1660}: {npc:4088} entrega {item:6812} a você; {npc:6142} trabalha no lado distante, ao sul, do mesmo terraço, fácil de passar batido.",

	-- Step 16: A Warrior's Training
	-- {npc:913} Lyria Du Lac · {area:87} Goldshire · {npc:6089} Harry Burlguard · {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town
	["At 10, {npc:913}, the warrior trainer by the inn in {area:87}, sends you to {npc:6089} in {zone:1453}; {npc:5480}, the warrior trainer in {zone:1453}'s {object:2100}, offers it too."] = "No nível 10, {npc:913}, o instrutor de guerreiro ao lado da estalagem de {area:87}, manda você para {npc:6089}, em {zone:1453}; {npc:5480}, o instrutor de guerreiro em {object:2100}, de {zone:1453}, também oferece.",

	-- Step 17: Bartleby
	-- {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2100} Old Town · {quest:1638} A Warrior's Training · {npc:5480} Ilsa Corbin · {zone:1453} Stormwind
	["{npc:6089} and {npc:6090} are in the Pig and Whistle tavern in {object:2100}; {npc:6090} is the drunk at the far end of the bar. {npc:6090} (level 10) hits harder than his level, so start at full health; he gives up at low health instead of dying. If he wins, he disappears for about three minutes: keep the quest and talk to him again when he is back. A Dwarf, Gnome or Night Elf who took {quest:1638} from {npc:5480} instead of their home road is led through {zone:1453} from here."] = "{npc:6089} e {npc:6090} ficam na Taberna do Javatusco Saltitante, em {object:2100}; {npc:6090} é o bêbado na ponta do balcão. {npc:6090} (nível 10) bate mais forte que o nível dele, então comece com vida cheia; ele desiste com pouca vida em vez de morrer. Se ele vencer, some por uns três minutos: mantenha a missão e fale com ele de novo quando ele voltar. Um Anão, Gnomo ou Elfo Noturno que pegou {quest:1638} com {npc:5480} em vez do caminho da própria terra é conduzido por {zone:1453} a partir daqui.",

	-- Step 18: Marshal Haggard
	-- {npc:294} Marshal Haggard · {area:88} Eastvale Logging Camp
	["{npc:294}'s manor stands at the south-east edge of the {area:88} in eastern Elwynn, at the end of a short road that does not join the main one."] = "A mansão de {npc:294} fica na borda sudeste de {area:88}, no leste de Elwynn, no fim de uma estradinha que não se liga à principal.",

	-- Step 19: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {item:6783} Dead-tooth's Key · {object:85563} Dead-tooth's Strongbox · {item:6782} Marshal Haggard's Badge
	["{npc:6093} (level 11) camps in the far south-east of Elwynn. A guard stands beside him and Defias and wolves are spread around the camp (now and then a rarer guard too): clear them one at a time, then kill Jack. He always drops {item:6783}; open {object:85563} in the crates by him for {item:6782}. Jack returns 3 minutes after dying, the box 1 minute after opening."] = "{npc:6093} (nível 11) acampa no extremo sudeste de Elwynn. Um guarda fica ao lado dele e Défias e lobos estão espalhados pelo acampamento (de vez em quando também um guarda mais raro): limpe um de cada vez e depois mate Jack. Ele sempre solta {item:6783}; abra {object:85563} nos caixotes ao lado dele para pegar {item:6782}. Jack volta 3 minutos depois de morrer, a caixa 1 minuto depois de aberta.",
	-- {npc:6093} Dead-Tooth Jack
	["from {npc:6093}"] = "de {npc:6093}",
	-- {item:6782} Marshal Haggard's Badge · {object:85563} Dead-tooth's Strongbox
	["{item:6782}, from {object:85563}"] = "{item:6782}, de {object:85563}",

	-- Step 20: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "De volta a {npc:294}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Haggard's Weapons"] = "Armas de Fadigas",
	-- ["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "A casa de {npc:294} fica no leste da {zone:1429}, ao sul da estrada de {zone:1453} para Cristarrubra.",
	-- ["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto da {object:2152} de lá. {npc:6090} luta com você pela caneca dele.",
	-- ["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093} acampa no extremo sudeste da {zone:1429}, a sudeste de {npc:294}. Ele leva a chave do cofre no acampamento dele.",
	-- ["{npc:6093}: his key opens the strongbox"] = "{npc:6093}: a chave dele abre o cofre",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} e uma arma de uma mão à sua escolha no nível 10.",
}
