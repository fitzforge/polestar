-- Portuguese (Brazil) (ptBR): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {area:442} Auberdine · {area:17203} Stormwind Harbor · {npc:1646} Baros Alexston · {zone:1429} Elwynn Forest
	["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "O navio de {area:442} atraca em {area:17203}. Suba até a cidade para treinar e falar com {npc:1646}, depois saia pelo portão principal e siga a estrada a leste por {zone:1429}.",
	["Level 18 and 20 spells"] = "Feitiços de nível 18 e 20",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: a carta de Trovejius de {area:442}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Para {npc:3649}, na volta a {area:442} (06-ashenvale)",

	-- Step 2: Shaman training
	["Shaman training"] = "Treino de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} no {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô.",

	-- Step 3: Stormwind class quests
	-- {zone:1453} Stormwind
	["{zone:1453} class quests"] = "Missões de classe em {zone:1453}",
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:376} High Priestess Laurena
	["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} está na SI:7 em {object:2100}, {npc:6122} no porão do {object:2164} no {object:2101}, {npc:376} na Catedral da Luz.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: {npc:7024} em {zone:1436} a recebe, no fim de {zone:1431}",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {npc:6244} em {zone:1413} a recebe, mais tarde",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {npc:11406} em {zone:1455} a recebe, mais tarde",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {npc:258785} em {zone:1455} a recebe, mais tarde",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {npc:11401} em {zone:1457} a recebe, mais tarde",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Voe até {area:108} e cavalgue para noroeste até a costa: o {object:177790} está no fundo do mar perto da praia. Depois cavalgue a leste pela estrada, por Elwynn, até Cristarrubra.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: o {object:177790}",

	-- Step 5: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker · {zone:1431} Duskwood
	["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "A estrada de Elwynn entra em Cristarrubra em {area:1002}. {npc:464} fica onde se encontram as estradas para Cristarrubra e {zone:1431}.",

	-- Step 6: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon · {npc:903} Guard Howe
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Siga a estrada pela margem sul do {area:68} até a mestre de grifos. {npc:1070} e {npc:903} ficam na estrada ao lado dela.",

	-- Step 7: Lakeshire
	-- {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:900} Bailiff Conacher · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:343} Chef Breanna · {npc:342} Martie Jainrose
	["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Atravesse a ponte comprida para o norte até a vila. {npc:341} e {npc:382} ficam na ponta norte da ponte, {npc:900} na prefeitura, {npc:381} e {npc:266} nas docas, {npc:343} na estalagem, {npc:342} na horta dela, no extremo oeste.",
	-- {npc:266} Wiley the Black
	["{npc:266}, by the docks"] = "{npc:266}, nas docas",

	-- Step 8: Sunken Chest
	-- {area:68} Lake Everstill
	["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nade a leste da ponte para dentro do {area:68}; o baú está no fundo do lago.",

	-- Step 9: Gnolls toward Three Corners
	-- {area:1002} Three Corners
	["Gnolls toward {area:1002}"] = "Gnolls rumo a {area:1002}",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Redridge Thrashers = {npc:712} Redridge Thrasher · Dire Condors = {npc:428} Dire Condor · Great Goretusks = {npc:547} Great Goretusk
	["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Mestiços de Cristarrubra e outros gnolls ocupam as colinas a leste de {area:1002}, ao norte da estrada; Espancadores de Cristarrubra rondam entre eles, Caçadores Ilegais acampam ao sul da estrada. Condores Hediondos e Grandes Goretuscos vagam pelas mesmas colinas.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: Espancadores de Cristarrubra",

	-- Step 10: Bellygrub
	-- {npc:345} Bellygrub · {area:69} Lakeshire
	["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (nível 24) fuça em volta do chiqueiro logo a oeste de {area:69}. Afaste-o dos outros javalis e lute com a vida cheia.",

	-- Step 12: Lakeshire
	-- {npc:703} Lieutenant Fangore · {area:1000} Galardell Valley
	["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "O cartaz de PROCURA-SE perto da estalagem: {npc:703}, em {area:1000}",

	-- Step 13: Lake murlocs
	["Lake murlocs"] = "Murlocs do lago",
	-- {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Carniceiros Murloc e Chamarés ocupam a margem sul a leste da ponte. Qualquer um deles pode levar um {item:1467} ou uma barbatana.",

	-- Step 14: Alther's Mill
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula · Blackrock Renegades = {npc:437} Blackrock Renegade
	["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Grandes Tarântulas rastejam nas encostas em volta do moinho a nordeste do lago; Renegados Rocha Negra ocupam o próprio moinho.",
	-- {item:3014} Battleworn Axe
	["{item:3014}: any Blackrock orc"] = "{item:3014}: qualquer orc Rocha Negra",

	-- Step 15: Galardell Valley
	-- {npc:703} Lieutenant Fangore · {area:2099} Stonewatch Keep
	["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "A leste, passe o moinho e atravesse o rio. Gnolls Umbrapele enchem o vale; {npc:703} (26, bem acima de você) os lidera no extremo norte: elimine a escolta dele primeiro e lute com ele com a vida cheia. Fique longe de {area:2099} ao sul: os orcs de lá são elite.",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: qualquer gnoll Umbrapele",

	-- Step 16: Back to Lakeshire
	-- {area:69} Lakeshire
	["Back to {area:69}"] = "De volta a {area:69}",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, na prefeitura",

	-- Step 17: Render's Valley
	-- {area:69} Lakeshire · {area:95} Redridge Canyons · {area:997} Render's Valley
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Saia de {area:69} rumo ao norte, subindo os {area:95} até o {area:997}. Campeões Rocha Negra acampam no vale.",

	-- Step 18: Corporal Keeshan
	-- {zone:1428} Burning Steppes · {area:69} Lakeshire
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se esconde no extremo norte do vale, na divisa com {zone:1428}. Escolte-o até {area:69}; orcs Rocha Negra emboscam vocês no caminho.",

	-- Step 19: Lakeshire
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, junto aos grifos ao sul da ponte",
	-- {zone:1431} Duskwood · {area:1002} Three Corners · {area:42} Darkshire
	["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "{zone:1431} é a próxima: siga a estrada a oeste até {area:1002}, depois ao sul até {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bellygrub"] = "Ronquifuça",
}
