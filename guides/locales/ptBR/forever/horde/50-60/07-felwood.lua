-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "De {zone:1458}, pegue o zepelim na torre do lado de fora da cidade para {zone:1454}.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Voe para {area:431} e siga para o noroeste pela estrada que sai de {zone:1440} para {zone:1448}. {area:2479} é o acampamento dos druidas logo depois da fronteira.",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Coração de prata, de {npc:9116}, pede {item:11173} do norte de {zone:1448} e uma volta até aqui. Pule.",

	-- Step 3: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Siga para o noroeste até {area:1763}. Os quatro braseiros ficam entre as construções do Concílio das Sombras; use a água purificada em cada um.",

	-- Step 4: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Volte para o sul até o Santuário, perto daqui.",

	-- Step 5: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} e {npc:9517} esperam no fundo de {area:1770}, a caverna no norte de {area:1763}. Limpe o túnel no caminho.",

	-- Step 6: Greta Mosshoof
	["South to the Sanctuary once more."] = "Volte mais uma vez para o sul até o Santuário.",

	-- Step 7: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Siga a estrada para o norte, passando por {area:1763}, até {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "A próxima missão de {npc:10306}, {quest:4741}, traria você de volta de {zone:1452}. Pule.",

	-- Step 8: Toxic Horrors
	-- {npc:9298} Donova Snowden · {quest:5086} Toxic Horrors · {zone:1448} Felwood · {area:1767} Irontree Woods
	["Only if {npc:9298} gave you {quest:5086}: ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Só se {npc:9298} deu {quest:5086} a você: siga para o norte pela estrada de {zone:1448} até {area:1767}; os alvos de {quest:5086} escorrem entre as árvores.",

	-- Step 9: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Só com 30 de {quest:6031}, e só se estiver Neutro com os Presamatos: siga a estrada para o norte até {area:1769}; {npc:11557} negocia logo depois da entrada.",

	-- Step 10: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Atravesse o túnel dos Presamatos até {zone:1450}. {npc:11939} lê numa casa em {area:2361}.",

	-- Step 11: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Pedaços de Vinhavil, de {npc:11801}, pede {area:2577}. Pule.",

	-- Step 13: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Volte ao túnel dos Presamatos e pegue a saída para {zone:1452}; {npc:9298} acampa junto às fontes termais logo do lado de fora.",

	-- Step 14: Winterfall Runners
	-- {quest:5087} Winterfall Runners · {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden
	["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Só se tiver {quest:5087}: os mensageiros andam pela estrada de {area:1769} rumo a {area:2244} em pequenos grupos; espere na estrada perto de {npc:9298} e mate-os quando passarem. Cada um carrega um caixote.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Depois {npc:9298} manda você atrás de {npc:10738}, um elite na caverna dele. Pule.",

	-- Step 15: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Siga a estrada para o leste até {area:2255}.",

	-- Step 16: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "Masmorra em vez de matar monstros",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Fazer {area:2279}, {area:2057}, o Pico da Rocha Negra Inferior ou {area:1584} em grupo, em vez de matar monstros, leva você lá mais rápido.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Opcional: em grupo, uma masmorra 55-60 substitui a matança abaixo.",

	-- Step 17: Grind to 60
	["Grind to 60"] = "Mate monstros até o 60",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "As missões acabam aqui. Dentilhaços Raivosos rondam {area:2249}, no sul de {zone:1452}, ao sul da estrada que sai de {area:2255}.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "mate {npc:7446} em {area:2249}, {zone:1452}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "Em {zone:1454}: voe de {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "Em {zone:1456}: voe de {area:2255}",
}
