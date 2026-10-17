-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran · {npc:270844} Sylessa Duskwhisper
	["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} fica em {area:2103}; {npc:2094} e {npc:270844} ficam juntos perto do portão norte.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}"] = "{npc:2104}: para {npc:270637}",
	-- {npc:270844} Sylessa Duskwhisper · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: para {npc:3649} em {area:442} (02-desolace)",

	-- Step 2: Prospector Whelgar
	-- {area:118} Whelgar's Excavation Site
	["Follow the road east to {area:118}."] = "Siga a estrada para o leste até {area:118}.",

	-- Step 3: Goaz Warder
	-- {item:279996} Goaz Stone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Os Goaz Warders ficam logo a oeste do acampamento de Whelgar: use a {item:279996} que ele lhe deu ao lado de um deles.",

	-- Step 4: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Uma nova {item:279996}, para os quatro vigias titânicos espalhados por {zone:1437}",

	-- Step 5: The Green Belt
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Siga a estrada para o nordeste até a {area:1025}: {npc:270637} acampa ao lado dela; {npc:1244}, um pouco a leste.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, um raptor elite",

	-- Step 6: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Para o sul, até {area:1036}, dos Presa do Dragão; {object:671518} está no acampamento.",
	-- {quest:98221} From the Ashes
	["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Destrua os quatro conjuntos de Planos de Ataque no acampamento para {quest:98221}.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: para {npc:2104}",

	-- Step 7: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} fica nas colinas do sudeste: use a {item:279996} ao lado dele.",

	-- Step 8: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271373} Subdued Dragonspawn · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Para o nordeste, até {area:1038}: {npc:271373} está preso lá, e {npc:271338} fica nos portões (use a {item:279996}).",

	-- Step 9: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "Dragonetes, raptores e {npc:271458}",
	-- {area:1025} The Green Belt · {npc:271458} Neru · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Dragonetes Vermelhos enchem as colinas a oeste dos portões; {npc:271334}, a {area:1025}; Rasgaqueixos, as encostas do norte. {npc:271458} fica no nordeste (use a {item:279996}).\n{quest:98283} é elite: recomenda-se formar um grupo.",

	-- Step 10: The Green Belt
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Para o Rei Magni em {zone:1455}, no fim deste guia",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Para o norte pela estrada até {area:205}. {npc:271460} fica nas ruínas (use a {item:279996}); {npc:271481} está preso no lado oeste: leve-o até {npc:1072}.",

	-- Step 12: The Villards
	["The Villards"] = "Os Villard",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:881} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} espera ao norte de {area:205}, perto de {area:881}; {npc:271322}, um pouco mais a nordeste.",

	-- Step 13: Prospector Whelgar
	["Back south down the road to the excavation site."] = "Volte para o sul pela estrada até o sítio de escavação.",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} em {zone:1455}, no fim deste guia",

	-- Step 14: Menethil Harbor
	["West along the road to Menethil."] = "Para o oeste pela estrada até o Porto de Menethil.",

	-- Step 15: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Barco para {area:271}",

	-- Step 16: Southshore
	-- {npc:251493} Captain McManus · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Pegue tudo na cidade antes de sair. Ao desembarcar, {npc:251493} é o primeiro que você encontra, a noroeste do mestre de voo; {npc:2381} e {npc:2438} ficam entre o mestre de voo e a estalagem; Fárrio e {npc:2366}, na estalagem; Maleb, na prefeitura.",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, de {npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: os leões ficam para depois",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, na estalagem: para {area:35} (04-stranglethorn-vale)",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: a pista dele leva ao Planalto Arathi",

	-- Step 17: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Rancapina",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Os murlocs Rancapina lotam {area:295}, a sudoeste de {area:271}.",

	-- Step 18: Farren
	["Farren"] = "Fárrio",

	-- Step 19: Murloc heads
	["Murloc heads"] = "Cabeças de murloc",
	["Back to the same murlocs; not every one drops a head."] = "Volte aos mesmos murlocs; nem todos soltam uma cabeça.",

	-- Step 21: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinhadaga",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "As nagas ocupam a costa a sudeste de {area:271}.",

	-- Step 22: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}"] = "Um relatório para {object:2117}",

	-- Step 23: Snapjaws
	["Snapjaws"] = "Mordeliscas",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "As tartarugas Mordeliscas tomam sol ao longo do rio a leste de {area:271}, ao sul de {area:272} (Horda).",

	-- Step 24: Syndicate camp
	["Syndicate camp"] = "Acampamento da Camarilha",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "O acampamento da Camarilha fica na divisa com as Montanhas de Alterac, no norte de {area:287}, a oeste de {area:272} (Horda); os documentos estão no acampamento.",

	-- Step 25: Yeti cave
	["Yeti cave"] = "Caverna dos yetis",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Os yetis vivem na caverna nas colinas ao norte de {area:271}, no caminho de volta para o sul.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} também quer um {item:3719}, um {item:2997} e {item:2321}: fabricados ou comprados; o manto é entregue quando você voltar a {area:271} mais tarde.",

	-- Step 26: Hillsbrad's town hall
	-- {area:287} Hillsbrad
	["{area:287}'s town hall"] = "Prefeitura de {area:287}",
	-- {area:287} Hillsbrad · {item:279386} Sealed Company Request · {npc:2335} Magistrate Burnside
	["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Para o oeste, até as fazendas de {area:287}: coloque {item:279386} na mesa de contabilidade da prefeitura, onde ficam {npc:2335} e os conselheiros.",
	-- {area:287} Hillsbrad
	["{area:287} town hall"] = "Prefeitura de {area:287}",

	-- Step 28: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {npc:2432} Darla Harris · {area:271} Southshore
	["From {npc:2432} in {area:271}"] = "Com {npc:2432} em {area:271}",

	-- Step 29: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "A loja de queijos em {object:2096}.",

	-- Step 30: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} espera na Taberna do Javatusco Saltitante, em {object:2100}; ele e seus dois capangas lutam com você, mas param quando derrotados.",

	-- Step 31: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} treina guerreiros em {object:2100}, ao lado da Taberna do Javatusco Saltitante. {npc:6236} espera em {area:720}, em {zone:1413}, no caminho para {area:392}, bem mais tarde (40-50/01).",

	-- Step 33: Cathedral of Light
	["Cathedral of Light"] = "Catedral da Luz",

	-- Step 34: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} está em {object:2164}; {npc:211033}, perto do canal; {npc:5081}, ao sul de {object:2101}.",

	-- Step 36: Druid training
	["Druid training"] = "Treinamento de druida",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} não tem instrutor de druidas: treine com {npc:5504} em {zone:1453} antes do metrô.",

	-- Step 37: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Pegue o {area:2257} em {object:28027} até {zone:1455}.",
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	["Level 30 and 32 spells"] = "Feitiços de nível 30 e 32",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- ["Golm"] = "Golm",
}
