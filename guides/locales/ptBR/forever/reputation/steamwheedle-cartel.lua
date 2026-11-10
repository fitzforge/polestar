-- Portuguese (Brazil) (ptBR): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "Reputação: Cartel Bondebico",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "Todas as cidades goblins de uma vez: os gigantes eletrocutados de {npc:14637} e as algemas de {npc:14338}, depois cinco novos intendentes e seus chapéus.",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Intendentes goblins do Forever: equipamento para os níveis 20 a 50 em Amigável e Honrado",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "Cinco cidades goblins compartilham uma família de reputação, o Cartel Bondebico: {faction:470}, {faction:21}, {faction:369}, {faction:577} e a nova {faction:2827} do Forever em {zone:2548}. Todo mundo começa em Neutro em cada uma (500 dentro dele). Um ganho com uma cidade dá metade às outras; uma missão para o próprio Cartel, como a de {npc:14637}, paga todas as cidades por inteiro. As perdas se espalham do mesmo jeito: um {npc:4624} ou qualquer goblin das cidades custa 125 (metade disso com as outras cidades), e a reputação com os Bucaneiros da Vela Sangrenta só se ganha assim. {npc:14637} acampa na estrada pelo centro de {zone:1444} e trabalha para qualquer um, até para jogadores que os goblins odeiam. As duas primeiras missões dele são de nível 48 e abrem as repetíveis dele (nível 55); o Forever paga todas por inteiro em qualquer nível.",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}: 150 para cada cidade",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}: 150 para cada cidade",

	-- Step 2: Zapped giants
	["Zapped giants"] = "Gigantes eletrocutados",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "Use {item:18904} num gigante vivo ({npc:5357}, {npc:5358} ou um {npc:5361} da Costa, das Profundezas, de nível 47-50) e ele encolhe numa versão eletrocutada; mate-a para pegar o {item:18956}, um a cada vez. Os Terrâmbulos e Gigantes do Penhasco nas colinas do noroeste são os mais numerosos; os andarilhos caminham pela costa e pelos baixios. O encolhedor dura duas horas: se acabar, abandone a missão e pegue-a de novo.",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}, num gigante vivo",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}, dos gigantes eletrocutados",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "Elementais do Mar e Borrifos do Mar",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "Os Elementais do Mar e Borrifos do Mar (nível 47-49) vagam ao longo de {area:1108} e nos baixios abaixo dos gigantes: cerca de metade solta um {item:18958}.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}: Elementais do Mar e Borrifos do Mar",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "De volta a {npc:14637}",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "A partir de agora {npc:14637} oferece {quest:7725} (10 resíduos) e {quest:7726} (6 núcleos), vezes sem conta: 25 de reputação com cada cidade a cada vez.",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}, abaixo do 56",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "Os piratas dos Mares do Sul de {area:1336} (nível 44-45), na costa leste de {zone:1446}, dão 5 de {faction:369} cada um até o fim de Honrado, e metade às outras cidades. Duas missões em {area:977} pagam 100 de {faction:369} cada: {quest:8366} (10 de cada pirata) e {quest:8365} (20 Chapéus de Pirata dos Mares do Sul, um a cada dez piratas). A partir do nível 56 os piratas ficam cinzas e pagam pouco: pule este passo então.",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{npc:10267}, uma goblin em {area:251}, no norte de {zone:1428}, tem uma cadeia que paga 150 para cada cidade e mais 150 para {faction:577}. Use o {item:12284} dela num filhote, mate-o enquanto o aparelho o prende e pegue o {quest:4726} que ele deixa. O aparelho só pega Filhotes Negros e Ninhadas Escaldantes, não os Filhotes Flamescama do oeste: as Ninhadas Escaldantes (nível 53-54) vagam logo a oeste e a leste de {area:251}, os Filhotes Negros (51-52) ficam no canto nordeste da zona, o grupo mais numeroso. São poucos e espalhados: o caminho passa pelos dois e termina entre os Filhotes Negros.",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "Ninhadas Escaldantes a oeste de {area:251}",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "Ninhadas Escaldantes a leste de {area:251}",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "Filhotes Negros no nordeste",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}, num Filhote Negro ou {npc:7048}",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}, deixado pelos filhotes",
	["100 to every town"] = "100 para cada cidade",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808} fica em {faction:577}. As Quimeras Ventogelantes (nível 55-57) a sudoeste de {faction:577} soltam os chifres uma vez em cinco.",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}: Quimeras Ventogelantes",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "De volta a {npc:10267}",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810} dá 50 para cada cidade. As missões seguintes dela, Congelar os ovos (150 para cada cidade) e Coleção de ovos (200), são feitas no Viveiro do Topo da Montanha Rocha Negra Superior, uma masmorra para dez jogadores: pegue-as quando for com o seu grupo.",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "Gládio Cruel Norte: {npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338} está acorrentado em Gládio Cruel Norte, a ala dos ogros Gordok (uma masmorra para cinco jogadores a partir do nível 57: forme um grupo). Cada {item:18250} o liberta uma vez: 150 para cada cidade, e ele é acorrentado de novo na sua próxima passagem. Os ogros Gordok soltam as chaves (cerca de uma em quinze; {npc:14321}, uma em sete): uma passagem completa pela ala costuma render uma. O {item:18258} dele paga 100 na primeira vez e 50 depois, por 4 Rolos de Runatrama, 8 {item:8170}, 2 {item:14341} e o {item:18240} da cesta na ala. Abaixo do 57 quando chegar aqui? Reative este passo depois.",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}, ogros Gordok",
	-- {quest:5525} Free Knot!
	["{quest:5525}: 150 to every town"] = "{quest:5525}: 150 para cada cidade",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}, de novo em cada passagem seguinte: 150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "Todas as cidades até Amigável",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "De Neutro 500 a Amigável são 2.500 com cada cidade. As missões acima pagam até 700 a cada cidade (as duas de {npc:14637} dão 300 cada, a de {npc:10267} 150, a primeira Liberdade ainda que tardia 150 e o primeiro Traje de Ogro 100); as repetíveis de {npc:14637} fazem o resto, 25 para cada cidade por vez: 10 resíduos (dez gigantes) ou 6 núcleos (cerca de doze elementais). As missões das próprias cidades também contam, cada uma dando metade às outras: as de {faction:470} em {zone:1413} (níveis 10-25, cerca de 4.300: a cadeia de Rebimboca 625, os recados de {npc:3446}, as escoltas de Wizzlecrank e Gilthares Galhareda 150 cada), as de {faction:21} em Selva do Espinhaço, Arathi e {zone:1418} (30-50, cerca de 6.500: os três resgates de robôs OOX 250 cada, Um OOX para chamar de meu 200, Febre da Selva do Espinhaço 200, Confrontando Negolash 200, a cadeia do Tesouro submerso em {area:327}), as de {faction:369} em {zone:1446} (43-55, cerca de 3.000: o {item:8548} 200, O erro dos Errantes 100 cada, os cartazes de PROCURA-SE) e as de {faction:577} em {zone:1452} (52-60, cerca de 1.450: a cadeia dos Invernosos de {npc:9298}, as missões dos iétis de Umi). O Forever acrescenta algumas de nível baixo: Uma tempestade se formando e Potencial trovejante em {zone:1411} e PROCURA-SE: Bruuz ({faction:470}, 100 cada), Heranças importantes em {zone:1455} ({faction:369}, 100). O Forever paga todas por inteiro em qualquer nível. Matar ajuda enquanto não estiver cinza, 5 cada: piratas dos Mares do Sul em {zone:1413} para {faction:470} e em {zone:1446} para {faction:369}, e os acampamentos da Empreendimentos S.A. na Selva do Espinhaço para {faction:21}, até o fim de Honrado; bandidos Errantes para {faction:369} e piratas da Vela Sangrenta para {faction:21} só até o fim de Neutro. Amigável libera o primeiro equipamento de cada intendente.",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}: 10 resíduos",
	["25 to every town"] = "25 para cada cidade",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}: 6 núcleos",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "Todas as cidades até Honrado",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "De Amigável a Honrado são 6.000: 240 entregas de {npc:14637}, ou 40 passagens por Liberdade ainda que tardia, ou uma mistura. Nada pode ser guardado: resíduos e núcleos só caem enquanto a missão está no seu diário, e você só carrega uma {item:18250} por vez, então entregue cada um antes da próxima passagem. Honrado libera os itens azuis de cada intendente.",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "Todas as cidades até Reverenciado",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "De Honrado a Reverenciado são mais 12.000: 480 entregas de {npc:14637} (4.800 resíduos) ou 80 passagens por Liberdade ainda que tardia. Reverenciado libera os cinco chapéus cosméticos, o motivo pelo qual a maioria dos jogadores faz isto. O Legado Diplomata soma até 10%.",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}, intendente de {faction:470}, perto das docas. Amigável, equipamento de nível 20: {item:274740} 41s (Vigor, Agilidade), {item:274741} 54s (Vigor, poder mágico), {item:274742} 34s (Intelecto, Agilidade). Honrado: {item:274743}, item de mão secundária, 66s (Intelecto, Espírito); {item:274744}, maça de uma mão, 1g 65s (Vigor, Força). Reverenciado: {item:274021}, um chapéu cosmético, 2g.",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}, Amigável",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}, Amigável",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}, Amigável",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}, Honrado",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}, Honrado",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}, Reverenciado",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}, intendente de {faction:21}. Amigável, equipamento de nível 30: {item:274745} 1g 10s (Força, Agilidade), {item:274746} 1g 48s (cura e dano mágico), {item:274747} 1g 3s (Intelecto, Espírito). Honrado: {item:274748}, uma arma de fogo, 3g 11s (poder de ataque, Vigor); {item:274749}, um colar, 1g 66s (regeneração de vida, Vigor). Reverenciado: {item:274022}, 5g.",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}, Amigável",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}, Amigável",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}, Amigável",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}, Honrado",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "{item:274749}, Honrado",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}, Reverenciado",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}, intendente de {faction:369}. Amigável, equipamento de nível 40: {item:274750} 2g 74s (Intelecto, cura, dano mágico), {item:274751} 2g 94s (Agilidade, poder de ataque), {item:274752}, uma capa, 2g 36s (Espírito, poder mágico). Honrado: {item:274753}, uma arma de uma mão, 9g 46s (Força, Agilidade); {item:274754}, um anel, 3g 80s (Força, Vigor). Reverenciado: {item:274023}, 10g.",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}, Amigável",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}, Amigável",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}, Amigável",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}, Honrado",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}, Honrado",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}, Reverenciado",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}, intendente de {faction:577}. Amigável, equipamento de nível 50: {item:274755} 3g 10s (Espírito, Intelecto), {item:274756} 5g 84s (Agilidade, Vigor, resistência a gelo), {item:274757} 4g 68s (Agilidade, poder de ataque), {item:274758}, um peitoral, 10g 96s (Força, Vigor). Honrado, três berloques por cerca de 7g 55s: {item:274759} (resistência à natureza), {item:274760} (resistência a gelo) e {item:274761} (resistência às sombras), os dois últimos com efeito de uso. Reverenciado: {item:274024}, 25g.",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}, Amigável",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}, Amigável",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}, Amigável",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}, Amigável",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}, Honrado",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}, Honrado",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}, Honrado",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}, Reverenciado",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897} vende as recompensas de {faction:2827} em {area:16727}, na costa leste de {zone:2548}, junto com mercadorias em geral. Amigável, equipamento de nível 40: {item:276200} 2g 74s (Vigor, poder de ataque), {item:276201} 2g 94s (Intelecto, Espírito), {item:276202} 2g 36s (Agilidade, Espírito). Honrado: {item:276203}, arma de duas mãos, 9g 46s (Vigor, Força, Agilidade); {item:276204}, um escudo, 3g 80s (Vigor, dano mágico, cura). Reverenciado: {item:276199}, 10g.",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}, Amigável",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}, Amigável",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}, Amigável",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}, Honrado",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}, Honrado",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}, Reverenciado",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "Todas as cidades até Exaltado",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "De Reverenciado a Exaltado são mais 21.000 com cada cidade: 840 entregas de {npc:14637} ou 140 passagens por Liberdade ainda que tardia. Nenhum intendente vende algo para Exaltado: isto é só para a barra do título.",
}
