-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Rumo a {zone:1418}",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and follow the road south through the {zone:1437} to the {object:1668} tunnel into {zone:1432}. {area:144}, the dwarf town on the road in the middle of {zone:1432}, has guards who attack the Horde: leave the road before it and pass the town on the hills to its west. The road leaves {zone:1432} to the south into the {zone:1418}; follow it to the goblin camp in the {area:1877}."] = "Vá até {object:2673}, a grande ponte no limite sul de Arathi, atravesse-a e siga a estrada para o sul por {zone:1437} até o túnel de {object:1668} para {zone:1432}. {area:144}, a cidade anã na estrada, no meio de {zone:1432}, tem guardas que atacam a Horda: saia da estrada antes dela e passe pela cidade pelas colinas a oeste. A estrada sai de {zone:1432} para o sul, rumo a {zone:1418}; siga-a até o acampamento goblin em {area:1877}.",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: a carta de Bulho, de {area:439}",

	-- Step 3: The Dustbowl
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl
	["Head west along the road towards {area:340}; {npc:2921}'s camp sits in the {area:1878} halfway there."] = "Siga para oeste pela estrada rumo a {area:340}; o acampamento de {npc:2921} fica em {area:1878}, no meio do caminho.",

	-- Step 4: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "{area:340} é a fortaleza da Horda construída nos penhascos, na ponta oeste da zona. {npc:5394} fica no andar de cima de {area:340}, bem acima do mestre de voo: suba pelas rampas, a seta não distingue os andares.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "para Helgrum, em {area:75}, por volta do nível 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, lá dentro",

	-- Step 5: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementais Inferiores da Rocha",
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between {area:340} and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "Os elementais pequenos vagam pelas planícies entre {area:340} e o acampamento de {npc:2921}, na estrada de volta ao leste. Todo elemental de rocha da zona pode deixar cair os Estilhaços de Elemental da Rocha de {npc:6868}.",

	-- Step 7: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418}: vá matando estes pelo caminho",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards."] = "Os Coiotes Anciões do Rochedo e os Urubus Gigantes andam pela bacia ao sul de {area:1878}. Os coiotes deixam cair tanto as mandíbulas quanto as presas; os Urubus Gigantes deixam cair as moelas.",

	-- Step 8: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementais da Rocha",
	-- {area:345} Agmond's End · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["South-east across the basin, the bigger Rock Elementals (39) stand on the slopes west of {area:345}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards."] = "A sudeste, atravessando a bacia, os Elementais da Rocha maiores (39) ficam nas encostas a oeste de {area:345}; cada um deixa cair uma laje. Todo elemental da rocha pode deixar cair os Estilhaços de Elemental da Rocha de {npc:6868}.",

	-- Step 9: Agmond's End
	-- {area:345} Agmond's End
	["Theldurin sits among the dwarven ruins at {area:345}, just east of the elementals."] = "Theldurin fica entre as ruínas anãs em {area:345}, logo a leste dos elementais.",

	-- Step 10: Stonevault troggs
	["Stonevault troggs"] = "Troggs da Abóbada de Pedra",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End · {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way north from {area:345}; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the {area:1877} and {area:345}."] = "Os troggs da Abóbada de Pedra cavam em volta das bocas das cavernas ao sul de {area:1877}, no caminho para o norte, saindo de {area:345}; os Quebraossos e Xamãs deixam cair as lascas. Os Urubus para as asas de {npc:2817} sobrevoam as colinas entre {area:1877} e {area:345}.",

	-- Step 11: Valley of Fangs
	-- {area:1517} Uldaman · {area:1877} Valley of Fangs · {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to {area:1517} runs through the {area:1877}: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "A estrada ao norte para {area:1517} atravessa {area:1877}: {npc:2817} e {npc:4618} recebem as asas e as lascas no caminho.",
	-- {area:2240} Mirage Raceway · {area:484} Freewind Post · {zone:1446} Tanaris
	["for Fizzle at the {area:2240}, on the way from {area:484} to {zone:1446} around level 43"] = "para Xabu em {area:2240}, no caminho de {area:484} para {zone:1446}, por volta do nível 43",

	-- Step 12: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Continue para o norte pela estrada; o baú fica no sítio de escavação de {area:1517}, ao pé das ruínas a noroeste da estrada.",
	["Below ground"] = "No subterrâneo",

	-- Step 13: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Volte para o sul pela estrada, passando por {area:1877}.",

	-- Step 14: The Dustbowl
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["North-west across the basin to {npc:2921}'s camp. Short of Jarkal's shards? The Lesser Rock Elementals (37) on the flats west of the camp drop them about one kill in five."] = "A noroeste, atravessando a bacia, até o acampamento de {npc:2921}. Faltam estilhaços para Jarkal? Os Elementais Inferiores da Rocha (37) nas planícies a oeste do acampamento os deixam cair em cerca de uma morte a cada cinco.",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s next study wants bracers from the Greater Rock Elementals (42-44) in the south-western gulches, well above you: leave it."] = "O próximo estudo de {npc:2921} pede braçadeiras dos Elementais Maiores da Rocha (42-44) nas ravinas do sudoeste, bem acima do seu nível: deixe para lá.",

	-- Step 15: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["Head west back to {area:340}. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "Siga a oeste, de volta a {area:340}. {npc:5394} fica no andar de cima de {area:340}, bem acima do mestre de voo: suba pelas rampas, a seta não distingue os andares.",
	-- {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide flies from {area:340} to {object:3202}."] = "O próximo guia voa de {area:340} para {object:3202}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Todo elemental da rocha de {zone:1418} deixa cair os estilhaços para {npc:6868}: os Elementais Inferiores da Rocha (37) na planície a oeste do acampamento de {npc:2921} são os tranquilos, mais ou menos um a cada cinco. Só os Elementais Maiores da Rocha (42-44, bem acima de você) nos barrancos do sudoeste deixam cair as braçadeiras para {npc:2921}, também uns um a cada cinco: puxe um de cada vez e descanse entre as lutas, ou deixe para lá. Pelo caminho, continue matando os coiotes e urubus que ainda faltam.",
	-- ["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and go south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Siga para {object:2673}, a grande ponte no extremo sul de Arathi, atravesse-a e vá para o sul por {zone:1437} (fique longe de {area:150}) e depois para leste até {zone:1432}; a estrada sai de {zone:1432} para o sul, rumo a {zone:1418}. Siga-a para o sul até o acampamento goblin em {area:1877}.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards.\nThe bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards."] = "Os Coiotes Anciões do Rochedo e Urubus Gigantes vagam pela bacia ao sul de {area:1878}. Os coiotes deixam cair tanto as mandíbulas quanto as presas; os Urubus Gigantes deixam cair as moelas.\nOs Elementais da Rocha maiores ficam nas encostas a noroeste de {area:1878}; cada um deixa cair uma laje. Todo elemental de rocha pode deixar cair os Estilhaços de Elemental da Rocha de {npc:6868}.",
	-- ["The next guide flies from {area:340} to {area:35}."] = "O próximo guia voa de {area:340} para {area:35}.",
	-- ["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin fica entre as ruínas anãs em {area:345}, ao sul de {area:1877}.",
	-- ["{area:1878}: kill these as you meet them"] = "{area:1878}: vá matando estes pelo caminho",
	-- ["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: só se você tiver {item:2868} ({skill:164} ou a Casa de Leilões)",
}
