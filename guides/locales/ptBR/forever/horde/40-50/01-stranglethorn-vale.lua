-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["From {area:2408} fly to {area:392}."] = "De {area:2408}, voe para {area:392}.",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco para {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at the end of {area:392}'s pier."] = "O barco para {area:35} atraca no fim do píer de {area:392}.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Píer de {area:392}",

	-- Step 3: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "O barco chega ao porto de {area:35}. Os recrutadores de missões ficam nos passadiços em volta do porto e na estalagem.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}"] = "para Esmirno, em {zone:1446}",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864}, em {area:976}",

	-- Step 4: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Saia da cidade pelo túnel; o bilhete fica na enseada dos piratas, logo ao norte de {area:35}.",

	-- Step 6: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Ao sul de Angra do Butim, os Espadachins da Vela Sangrenta acampam em {area:43}; os mapas e as ordens ficam nas barracas deles. Qualquer pirata da Vela Sangrenta pode levar rapé e o olho do {npc:2493}, então continue matando até ter os dois.",

	-- Step 8: The Bloodsail ships
	["The Bloodsail ships"] = "Os navios da Vela Sangrenta",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Os três navios ficam ao largo de {area:43}. As tripulações são 42-45, Tranquiláguas 45, Querena 46 e {npc:2546} 48: no nível 41, isso é luta para grupo ou para o fim do guia. Se for, nade até lá e puxe a tripulação até a amurada, um de cada vez. Um pergaminho, {quest:624}, fica no convés dos navios: pegue-o.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para uma parada posterior em {zone:1435}",

	-- Step 10: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Pegue a estrada para o norte saindo de {area:35}; Unbagwa fica numa colina em {area:1737}, a leste da estrada.",

	-- Step 11: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas do Vale da Névoa",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Os gorilas vagam pelo vale em volta de Unbagwa. Os anciões deixam cair os miúdos; qualquer um deles pode deixar cair uma presa.",

	-- Step 12: Mokk the Savage
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Entregue as presas a Unbagwa e fique perto dele: ele chama três ondas de gorilas, depois {npc:1514}. Enfrente-os um de cada vez.",

	-- Step 13: Zanzil's camps
	["Zanzil's camps"] = "Acampamentos de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "A nordeste do Vale da Névoa, os seguidores de Zanzil acampam na selva; todos eles podem levar o preparado.",

	-- Step 14: Venture Co. mine
	["Venture Co. mine"] = "Mina da Empreendimentos S.A.",
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Mais ao norte, os goblins da Empreendimentos S.A. cavam na mina a leste da estrada; mineradores, encarregados, topógrafos e engenhoqueiros deixam cair os cristais.",

	-- Step 15: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north-west to {object:3202}."] = "Cavalgue para noroeste até {object:3202}.",
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "para depois: {zone:1425}, por volta do nível 48",

	-- Step 16: Nesingwary's Expedition
	["Ride north up the road; the hunters camp on the hill above the river."] = "Cavalgue para o norte pela estrada; os caçadores acampam na colina acima do rio.",

	-- Step 17: Zul'Kunda
	["Zul'Kunda"] = "Ruínas de Zul'Kanda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas Ruínas de Zul'Kanda. Elimine os guardas primeiro, depois puxe os dois.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Regresse para {object:3202}",
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "o {object:2076}, ao lado de {npc:2497}",

	-- Step 19: Jungle stalkers
	["Jungle stalkers"] = "Espreitadores da selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Os raptores espreitadores caçam na selva ao sul de {object:3202}, rumo à costa oeste.",

	-- Step 20: Naga shore and the Holy Spring
	-- {object:759} Holy Spring
	["Naga shore and the {object:759}"] = "Costa das nagas e {object:759}",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Siga a costa para o sul. As nagas exploradoras andam pela água ao longo da costa e levam os feixes de junco; {object:759} borbulha nas colinas logo a leste delas.",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cavalgue para o sul até {area:35}. Phillipe \"Sacode\" espera nas docas.",

	-- Step 22: Pirate ghosts
	["Pirate ghosts"] = "Fantasmas piratas",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Os três piratas fantasmagóricos assombram a selva ao norte de {area:35}, perto dos acampamentos de Zanzil: {npc:2535} e {npc:2536} ficam juntos, {npc:2537} mais a leste.",

	-- Step 23: Zul'Mamwe
	["Zul'Mamwe"] = "Ruínas de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cavalgue para o norte até as ruínas Rachacrânio, a leste da mina da Empreendimentos S.A.; puxe os caçadores de cabeças e os berserkers um de cada vez. {npc:1059} guarda as ruínas do sudoeste, e uma pilha de crânios-troféu fica no lado norte das ruínas. Todo Rachacrânio pode deixar cair uma presa ou um colar: os colares são a parte demorada, então continue matando no acampamento dos guerreiros ao norte das ruínas até ter todos.",
	["Skullsplitter warriors"] = "Guerreiros Rachacrânio",

	-- Step 24: Balia'mah Ruins
	["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Os próximos crânios-troféu ficam nas pequenas ruínas logo ao norte do acampamento dos guerreiros.",

	-- Step 25: Ziata'jai Ruins
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Os últimos crânios ficam nas ruínas um pouco a oeste, no caminho de volta para {object:3202}.",

	-- Step 26: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride west to {object:3202}."] = "Cavalgue para o oeste até {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "o {object:2076}",

	-- Step 27: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Regresse para {area:35}",

	-- Step 28: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",

	-- Step 29: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "Cavalgue para o norte pela estrada até o acampamento dos caçadores.",

	-- Step 30: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Rumo a {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continue cavalgando para o norte até {zone:1431}, depois para o leste pela estrada através de {zone:1430} até o pântano. {npc:1776} espera em {area:657}, o acampamento draenei perto da entrada vinda de {zone:1430}.",

	-- Step 31: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "Cavalgue para o leste até {area:75}, nos juncos ao sul da estrada.",

	-- Step 32: Draenethyst crystals
	["Draenethyst crystals"] = "Cristais de draenetista",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cavalgue para nordeste até {area:76}. Os cristais ficam ao longo da subida até a jaula de {npc:5391}.",

	-- Step 33: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está preso em {area:76}, no nordeste do pântano. Liberte-o e siga-o para fora, enfrentando as criaturas do pântano que o perseguem.",

	-- Step 34: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru vaga pela clareira a sudoeste de {area:76}; a clava dele inicia uma missão.",

	-- Step 35: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "O cofre dele está no antigo acampamento, ao norte de {area:75}.",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Dentesserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Os crocoliscos chafurdam nas poças em volta do acampamento de {npc:5391} e ao sul rumo a {area:75}; cerca de um em quatro deixa cair uma anca.",

	-- Step 37: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cavalgue para o oeste pela estrada até o acampamento draenei em {area:657}, perto da entrada vinda de {zone:1430}.",

	-- Step 38: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Cavalgue de volta para o leste, passando por {area:75}, e siga a estrada para sudeste até o pequeno posto da Horda na costa.",

	-- Step 39: Sawtooth snappers
	["Sawtooth snappers"] = "Tartaliscas Dentesserra",
	["The snappers line the strand south of the post."] = "As tartaliscas ocupam a praia ao sul do posto.",

	-- Step 40: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}."] = "O próximo guia começa aqui e leva você até {zone:1446}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:657}"] = "{area:657}",
}
