-- Portuguese (Brazil) (ptBR): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} é sua base neste guia: a pedra de regresso traz você de volta aqui duas vezes. Todos ficam em volta da praça da cidade.",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well (no name in this language: may be words)
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Encha o {item:7768} no {object:107045} ao lado da estalagem",
	-- {object:556670} WANTED (no name in this language: may be words)
	["The {object:556670} poster by the inn"] = "O cartaz {object:556670} perto da estalagem",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, lá dentro",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "Depois de entregar Missão: possível, mas não provável a Shenthul, leve {quest:2479} a {npc:2391}, em {area:272}. Fique ao lado dele até o objetivo da poção terminar e entregue a continuação para aprender Venenos. Termine mesmo que o veneno de Zanzil já tenha saído; só tirar a penalidade não ensina a perícia.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Venenos",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "Cadeia dos venenos pela metade? Retome a etapa em que parou no guia de classe Venenos (Horda); missões já concluídas não precisam ser refeitas. Junte um grupo para o Gallywix, termine a continuação do Hinoto e depois volte para este guia de evolução.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Ursos, rastejantes e leões",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "A oeste da Serraria Tarren, Ursos Cinzentos, Rastejantes do Musgo da Floresta e Leões da Montanha Esfomeados vagam pelas colinas no caminho até as fazendas. Os rastejantes raramente derrubam {item:3477}; você só precisa de um.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "As fazendas a leste da cidade de {area:287}. {npc:232} trabalha no campo perto da casa da fazenda ao norte, {npc:2403} no que fica mais a sudeste; Lavradores e Fazendeiros estão por toda parte. {npc:2451} cuida do campo ao sul das fazendas.",

	-- Step 5: Mountain Lion Blood
	["Careful: When one lion is attacked, nearby lions come to its aid, and the Vicious Black Bears sharing those fields can also join the fight."] = "Cuidado: quando um leão é atacado, os leões por perto vêm ajudar, e os ursos negros que dividem esses campos também podem entrar na briga.",

	-- Step 6: Tarren Mill
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, lá dentro",
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon; inside"] = "{npc:2230}, ao lado de Lindolfo; lá dentro",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: Kalaba with the peasants, Wilkes at the smithy; the clerk and the miner on the visit at about 30; inside"] = "O cartaz {quest:567}: Kalaba com os camponeses, Urbano na ferraria; o escrivão e o mineiro na visita por volta do nível 30; lá dentro",

	-- Step 7: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} é o cachorro de {npc:232}, na casa da fazenda ao norte, em {area:286}.",

	-- Step 8: Hillsbrad Fields: kill these as you meet them
	-- {area:286} Hillsbrad Fields
	["{area:286}: kill these as you meet them"] = "{area:286}: vá matando estes pelo caminho",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often.\nCareful: A fleeing peasant that reaches the town hall can bring back many adds, including {area:287} footmen; snares, roots or similar effects keep them from escaping."] = "Os Camponeses trabalham nos campos ao sul das casas da fazenda. Todo humano de {area:287} deixa cair crânios; os Camponeses são os que mais deixam.\nCuidado: um camponês fugido que chega à prefeitura pode voltar com um monte de reforço, incluindo soldados de {area:287}; lentidão, enraizar e efeitos parecidos impedem a fuga.",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}: os Camponeses de Eira dos Montes nos campos",
	-- {npc:2451} Farmer Kalaba · {area:286} Hillsbrad Fields
	["{npc:2451} walks around {area:286}: look inside the circle on the map"] = "{npc:2451} anda por {area:286}: procure dentro do círculo no mapa",

	-- Step 9: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: ordens para {npc:270438}, a caminho do Forte do Desterro",
	-- {npc:2216} Apothecary Lydon · {item:3502} Mudsnout Blossoms
	["{npc:2216}, inside: the {item:3502} grow south-west of Durnholde, on the walk there"] = "{npc:2216}, lá dentro: os {item:3502} crescem a sudoeste do Forte do Desterro, no caminho até lá",

	-- Step 10: Durnholde Keep: kill these as you meet them
	-- {area:275} Durnholde Keep
	["{area:275}: kill these as you meet them"] = "{area:275}: vá matando estes pelo caminho",
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep · {area:272} Tarren Mill
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks.\nFrom {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Drull e {npc:2238} estão acorrentados nas construções do pátio de {area:275}; abra os dois cadeados.\nDe {area:272}, siga para sudeste pelas colinas rumo a {area:275}. Ladinos e Vigias da Camarilha ocupam os acampamentos pelo caminho.",
	-- {npc:2261} Syndicate Watchman
	["{npc:2261} walks around here: look inside the circle on the map"] = "{npc:2261} anda por aqui: procure dentro do círculo no mapa",
	["Drull's ball and chain"] = "Bola e corrente de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Bola e corrente de {npc:2238}",

	-- Step 11: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "A sudoeste do Forte do Desterro, as {item:3502} crescem nas encostas acima do rio.",

	-- Step 12: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj se esconde na encosta acima de {area:290}, ao sul do Forte do Desterro, no caminho até as flores.",
	-- {npc:270438} Deathstalker Masoj · {quest:98094} Scout Support
	["{npc:270438}, once {quest:98094} is in"] = "{npc:270438}, depois que {quest:98094} estiver entregue",

	-- Step 13: The southern peak
	["The southern peak"] = "O pico sul",
	-- {area:290} Dun Garok
	["Masoj wants an Apothecary Vial placed on three peaks. The southern one is the hilltop above {area:290}, just south of him: use a vial at the top."] = "Masoj quer uma Ampola de Boticário colocada em três picos. O do sul é o topo do morro acima de {area:290}, logo ao sul dele: use uma ampola no alto.",

	-- Step 14: The smithy
	["The smithy"] = "A ferraria",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "A ferraria fica no meio da cidade de {area:287}. {npc:2404} e seus aprendizes trabalham na forja; o {object:1736} está empilhado ao lado. {npc:2449} anda pela rua ao norte dela.",
	["Inside"] = "Lá dentro",

	-- Step 15: The western peak
	["The western peak"] = "O pico oeste",
	-- {area:287} Hillsbrad
	["From {area:287} town climb the mountain to the north, right up to its top on the Alterac border: the western vial goes there, not on the lower slope."] = "Da cidade de {area:287}, suba a montanha ao norte, até o topo, na divisa com Alterac: o frasco ocidental vai ali, não na encosta de baixo.",

	-- Step 16: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "De volta a {area:272}",
	-- {area:272} Tarren Mill
	["East along the foothills, then down into {area:272}."] = "Para leste pelo sopé, depois desça até {area:272}.",

	-- Step 17: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, em {zone:1458}",

	-- Step 18: The northern peak
	["The northern peak"] = "O pico norte",
	-- {area:272} Tarren Mill
	["The northern peak rises south-east of {area:272}, on the way down towards Durnholde."] = "O pico norte fica a sudeste de {area:272}, no caminho para o Forte do Desterro.",

	-- Step 19: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Back down to Masoj on the hillside above {area:290}."] = "De volta a Masoj, na encosta acima de {area:290}.",

	-- Step 20: The Sepulcher
	-- {area:272} Tarren Mill · {area:228} The Sepulcher · {npc:2121} Shadow Priest Allister
	["Walk back up to {area:272} and fly to the {area:228}: {npc:2121} stands by the crypt entrance."] = "Volte a pé até {area:272} e voe para {area:228}: {npc:2121} fica na entrada da cripta.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Mestre de voo de {area:272}",

	-- Step 21: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Voe para a {area:1497}",
	-- {npc:2226} Karos Razok · {area:1497} Undercity
	["Fly on from {npc:2226}, the bat handler just east of the crypt, to the {area:1497}."] = "Siga voando com {npc:2226}, o tratador de morcegos logo a leste da cripta, até a {area:1497}.",

	-- Step 22: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter (no name in this language: may be words)
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606} fica no {object:36070}.",

	-- Step 23: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, no Apothecarium",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Guarde: o litoral de {area:287}, mais adiante na rota",

	-- Step 24: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter (no name in this language: may be words)
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11870} ({object:36070}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 25: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter (no name in this language: may be words)
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda Armas de Haste com {npc:11870} ({object:36070}, 1 ouro); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 26: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter (no name in this language: may be words)
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Paladin fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11870} ({object:36070}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Paladino.",

	-- Step 27: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter (no name in this language: may be words)
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Armas de Haste com {npc:11870} ({object:36070}, 1 ouro); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 28: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter (no name in this language: may be words)
	["While you're here: learn Swords from {npc:11870} ({object:36070}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Já que está aqui: aprenda Espadas com {npc:11870} ({object:36070}, 10 pratas); espada na mão principal faz o Ladino subir de nível sem tropeço.",

	-- Step 29: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Use {spell:18960}. Junte as duas metades do pingente em {area:2362}, na margem noroeste do lago, antes de ver {npc:11802} em {area:2361}. {npc:11802} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: use uma metade em {area:2362}",

	-- Step 30: Aquatic Form
	-- {quest:31} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Take {quest:31} from {npc:11802}, who stands upstairs in his building. Then {npc:11798} in {area:2361} flies druids to {area:1638}: {npc:3033} is on {area:1639}."] = "Pegue {quest:31} com {npc:11802}, que fica no andar de cima do prédio dele. Depois {npc:11798}, em {area:2361}, leva druidas de voo até {area:1638}: {npc:3033} fica em {area:1639}.",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798}, em {area:2361}, leva druidas voando até lá",

	-- Step 31: Back to the Crossroads
	["Back to the Crossroads"] = "De volta à Encruzilhada",
	-- {npc:3033} Turak Runetotem
	["Train with {npc:3033}, then fly on to the Crossroads, where the next guide starts."] = "Treine com {npc:3033} e depois voe para a Encruzilhada, onde começa o próximo guia.",

	-- Step 32: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 33: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 34: Orgrimmar
	["Train before you fly on: the next guide flies from here to the Crossroads."] = "Treine antes de seguir voo: o próximo guia voa daqui até a Encruzilhada.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull e {npc:2238} estão acorrentados nos prédios do pátio de {area:275}; abra as duas trancas.",
	-- ["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Siga a estrada para o sul até a escavação anã em {area:359}. {npc:3421} se esconde na borda sul da escavação; {object:3646} fica no fundo da escavação.",
	-- ["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "De {area:272}, vá para sudeste pelas colinas no caminho até {area:275}. Ladinos e Vigias ocupam os acampamentos pelo caminho.",
	-- ["From {area:287} town go north into the foothills of Alterac: the western vial goes on the hilltop just past the border."] = "Da vila de {area:287}, siga para o norte pelo sopé de Alterac: a ampola do oeste vai no topo do morro logo depois da fronteira.",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "De {zone:1454} (zepelim das torres fora de {zone:1458}), voe até {area:1638} e treine em {area:1639}, depois siga voando até {area:378}.",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "De {zone:1454} (zepelim das torres fora de {zone:1458}), voe até {area:378}.",
	-- ["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Use a Pedra de Regresso para {area:378} e voe até {area:392}. {quest:874} acampa na praia ao norte de {area:392}.",
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Ainda sem Gallywix? O guia de classe Venenos (Horda) refaz a cadeia a partir de Shenthul, com um grupo para Gallywix.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Só se Gallywix caiu nos {zone:1413} (Missão: possível, mas não provável): {npc:2391} fica em {area:272}. Espere ao lado dele enquanto prepara a cura e pegue sua recompensa: Venenos.",
	-- ["Peasants and skulls"] = "Camponeses e caveiras",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "A sudoeste de Bael Modan, {npc:12576} espera no topo do {area:485}.",
	-- ["Syndicate camps"] = "Acampamentos da Camarilha",
	-- ["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Pegue o zepelim nas torres fora de {zone:1458} até {zone:1454} e treine antes de seguir voando.",
	-- ["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Os Camponeses trabalham nos campos ao sul das casas de fazenda. Todo humano de {area:287} derruba caveiras; os Camponeses derrubam com mais frequência.",
	-- ["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "A prefeitura fica no lado oeste de {area:287}. {npc:2335} (30) e {npc:2448} estão lá dentro com o Cartório de Eira dos Montes; a Proclamação de Eira dos Montes está afixada ao lado. Conselheiros andam pela cidade.",
	-- ["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "A {area:288} fica ao sul da cidade de {area:287}. Mineradores trabalham nos túneis; {npc:2305} (30) e {npc:2450} (29) estão bem lá no fundo.",
	-- ["The {quest:567} poster: its targets come up along the way"] = "O cartaz {quest:567}: os alvos aparecem pelo caminho",
	-- ["Town hall"] = "Prefeitura",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Você chega vinculado à estalagem de {area:272}. Todos ficam em volta da praça da cidade.",
	-- ["{npc:2230}, next to Lydon"] = "{npc:2230}, ao lado de Lindolfo",
	-- ["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, perto das docas em {area:392}",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "A cabana de {npc:5899} fica na crista acima do bebedouro dos javaligs, ao sul de {area:378}, no caminho até {area:359}.",
	-- ["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: o odre azul é enchido em {zone:1440}, no próximo guia",
	-- ["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: o odre vermelho de {area:272}",
	-- ["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, um grande manguadonte, nada nas águas rasas da {area:391}, a leste de {npc:3388}.",
}
