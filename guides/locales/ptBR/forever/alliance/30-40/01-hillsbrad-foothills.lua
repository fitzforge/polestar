-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "",

	-- Step 4: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: para {npc:2104}",

	-- Step 5: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 6: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "",

	-- Step 7: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 8: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "",

	-- Step 9: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "",

	-- Step 10: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}."] = "",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {npc:1072} Roggo Harlbarrow · {npc:271481} Captive Fire Elemental
	["North along the road to {area:205}. {npc:1071}, {npc:1075} and {npc:1072} stand together in the dwarves' camp; the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "",

	-- Step 12: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "",

	-- Step 13: The Villards
	["The Villards"] = "Os Villard",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard · {npc:1075} Rhag Garmason
	["Comar Villard waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}."] = "",
	["Comar Villard"] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "",
	["the same corpse"] = "",

	-- Step 14: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron (no name in this language: may be words)
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "",

	-- Step 15: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "",
	-- {area:880} Thandol Span · {npc:2696} Foggy MacKreel
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end. {npc:2696} stands a short walk west of it."] = "",

	-- Step 17: Waterlogged Envelope
	["Underwater"] = "",

	-- Step 18: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "",

	-- Step 20: Prospector Whelgar
	["Below ground"] = "",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} em {zone:1455}, no fim deste guia",

	-- Step 21: Menethil Harbor
	["West along the road to Menethil."] = "Para o oeste pela estrada até o Porto de Menethil.",
	["On the top floor"] = "",

	-- Step 22: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "",

	-- Step 23: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "",
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Para o Rei Magni em {zone:1455}, no fim deste guia",

	-- Step 24: Level 30.8
	["Level 30.8"] = "",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 26: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Barco para {area:271}",

	-- Step 27: Southshore
	-- {npc:2711} Phin Odelic · {npc:2705} Brewmeister Bilger · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2705} below it and {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side."] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: a pista dele leva ao Planalto Arathi",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, na estalagem: para {area:35} (04-stranglethorn-vale)",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: os leões ficam para depois",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, de {npc:2381}",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438}: only if you have or can buy a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells them"] = "",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 28: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Rancapina",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 29: Farren
	["Farren"] = "Fárrio",
	["Inside"] = "",

	-- Step 30: Murloc heads
	["Murloc heads"] = "Cabeças de murloc",
	["Back to the same murlocs; not every one drops a head."] = "Volte aos mesmos murlocs; nem todos soltam uma cabeça.",

	-- Step 32: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinhadaga",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "As nagas ocupam a costa a sudeste de {area:271}.",

	-- Step 33: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 35: Southshore
	-- {npc:251493} Captain McManus
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave."] = "",

	-- Step 36: Yeti cave
	["Yeti cave"] = "Caverna dos yetis",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp."] = "",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719} ({skill:165}), a {item:2997} ({skill:197}) and {item:2321} (any trade supplier): the cloak is turned in when you are back in {area:271} later."] = "",

	-- Step 38: Syndicate camp
	["Syndicate camp"] = "Acampamento da Camarilha",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "",

	-- Step 39: Snapjaws
	["Snapjaws"] = "Mordeliscas",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "As tartarugas Mordeliscas tomam sol ao longo do rio a leste de {area:271}, ao sul de {area:272} (Horda).",

	-- Step 42: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:271} Southshore
	["{area:271} flight master"] = "",

	-- Step 43: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "",
	["Level 30 and 32 spells"] = "Feitiços de nível 30 e 32",

	-- Step 47: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",

	-- Step 48: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 49: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "A loja de queijos em {object:2096}.",

	-- Step 50: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} espera na Taberna do Javatusco Saltitante, em {object:2100}; ele e seus dois capangas lutam com você, mas param quando derrotados.",

	-- Step 51: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} treina guerreiros em {object:2100}, ao lado da Taberna do Javatusco Saltitante. {npc:6236} espera em {area:720}, em {zone:1413}, no caminho para {area:392}, bem mais tarde (40-50/01).",

	-- Step 53: Cathedral of Light
	["Cathedral of Light"] = "Catedral da Luz",

	-- Step 55: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:5081} south of the {object:2101}."] = "",

	-- Step 56: Druid training
	["Druid training"] = "Treinamento de druida",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Uma nova {item:279996}, para os quatro vigias titânicos espalhados por {zone:1437}",
	-- ["A report for {object:2117}"] = "Um relatório para {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Volte para o sul pela estrada até o sítio de escavação.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Destrua os quatro conjuntos de Planos de Ataque no acampamento para {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Siga a estrada para o leste até {area:118}.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Siga a estrada para o nordeste até a {area:1025}: {npc:270637} acampa ao lado dela; {npc:1244}, um pouco a leste.",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} em {zone:1455}, no fim deste guia",
	-- ["From {npc:2432} in {area:271}"] = "Com {npc:2432} em {area:271}",
	-- ["Golm"] = "Golm",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Para o norte pela estrada até {area:205}. {npc:271460} fica nas ruínas (use a {item:279996}); {npc:271481} está preso no lado oeste: leve-o até {npc:1072}.",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Para o nordeste, até {area:1038}: {npc:271373} está preso lá, e {npc:271338} fica nos portões (use a {item:279996}).",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Pegue tudo na cidade antes de sair. Ao desembarcar, {npc:251493} é o primeiro que você encontra, a noroeste do mestre de voo; {npc:2381} e {npc:2438} ficam entre o mestre de voo e a estalagem; Fárrio e {npc:2366}, na estalagem; Maleb, na prefeitura.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Dragonetes Vermelhos enchem as colinas a oeste dos portões; {npc:271334}, a {area:1025}; Rasgaqueixos, as encostas do norte. {npc:271458} fica no nordeste (use a {item:279996}).\n{quest:98283} é elite: recomenda-se formar um grupo.",
	-- ["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Para o sul, até {area:1036}, dos Presa do Dragão: a primeira catapulta fica no caminho, e {object:671518} está no acampamento.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Para o sul, até {area:1036}, dos Presa do Dragão; {object:671518} está no acampamento.",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Pegue o {area:2257} em {object:28027} até {zone:1455}.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Os Goaz Warders ficam logo a oeste do acampamento de Whelgar: use a {item:279996} que ele lhe deu ao lado de um deles.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "O acampamento da Camarilha fica na divisa com as Montanhas de Alterac, no norte de {area:287}, a oeste de {area:272} (Horda); os documentos estão no acampamento.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Os murlocs Rancapina lotam {area:295}, a sudoeste de {area:271}.",
	-- ["The Villards"] = "Os Villard",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "A etapa seguinte, Derrotar Nek'rosh, coloca você contra um chefe elite: pule-a.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Os yetis vivem na caverna nas colinas ao norte de {area:271}, no caminho de volta para o sul.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Para o oeste, até as fazendas de {area:287}: coloque {item:279386} na mesa de contabilidade da prefeitura, onde ficam {npc:2335} e os conselheiros.",
	-- ["Whelps, raptors and {npc:271458}"] = "Dragonetes, raptores e {npc:271458}",
	-- ["{area:287} town hall"] = "Prefeitura de {area:287}",
	-- ["{area:287}'s town hall"] = "Prefeitura de {area:287}",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, um raptor elite",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} fica em {area:2103}; {npc:2094} e {npc:270844} ficam juntos perto do portão norte.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} fica em {area:2103}; {npc:2094} fica perto do portão norte.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: para {npc:270637}",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} também quer um {item:3719}, um {item:2997} e {item:2321}: fabricados ou comprados; o manto é entregue quando você voltar a {area:271} mais tarde.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: para {npc:3649} em {area:442} (02-desolace)",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} está em {object:2164}; {npc:211033}, perto do canal; {npc:5081}, ao sul de {object:2101}.",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} fica nas colinas do sudeste: use a {item:279996} ao lado dele.",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} espera ao norte de {area:205}, perto de {area:881}; {npc:271322}, um pouco mais a nordeste.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} não tem instrutor de druidas: treine com {npc:5504} em {zone:1453} antes do metrô.",
}
