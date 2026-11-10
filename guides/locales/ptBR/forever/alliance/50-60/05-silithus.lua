-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "Voe de {area:541} para {area:392}.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, lá dentro",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco para {area:35}",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 4: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Pegue o barco de {area:392} para {area:35} e voe para {zone:1453}.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, que anda pelos canais",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Para {npc:10778}: guarde-a",

	-- Step 5: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, na AVIN",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} em {area:3197}: guarde-a",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Metrô para {zone:1455}",

	-- Step 7: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "As jarras dela são enchidas na próxima visita à Cratera Un'Goro",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}, perto do metrô",

	-- Step 8: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Voe para a {area:2268}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 9: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: Egan is in {area:2627}, keep it"] = "{npc:11038}, junto aos túmulos ao sul da capela: Egan está em {area:2627}, guarde-o",

	-- Step 10: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeões do Flagelo",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Os Campeões do Flagelo (59) vagueiam por {area:2270}, ao norte de {area:2268}. Passe o {item:13156} de {npc:11063} sobre cada um que você matar: os crânios que ressoam são os que ele quer. Puxe-os um de cada vez.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, dos Campeões do Flagelo",

	-- Step 11: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "Crona nas Ruínas de Andorhal: guarde-a",

	-- Step 12: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Cavalgue para o norte até a borda nordeste de {area:2277}.\nCuidado: os trolls do caminho até {area:2273} são nível 57-59. Fogem com pouca vida e chamam ajuda, então costumam trazer reforço.",

	-- Step 13: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cavalgue para sudoeste até {area:2261}. O monturo de terra fica lá dentro. {npc:11886} é elite: melhor ir em grupo.\nCuidado: uns quatro capangas não elite vêm com o Mercutio. Eles caminham até o túmulo em vez de aparecer ali na hora.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}, de {npc:11886}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "Crona nas Ruínas de Andorhal: guarde-a",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Os Dragasmagas cavam mais a oeste; Tenazes Petraçoite, Esfoladores Petraçoite e Espreitadoras de Rocha caçam nas mesmas areias.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Os Dragatacas cavam nas dunas a noroeste do forte; Escorpídeos Petraçoite e Rastejantes da Areia vagueiam por toda parte.",
	-- ["Dredge and scorpids"] = "Dragas e escorpídeos",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Voe de {area:976} para {area:541}. A cabana de {npc:8737} fica em {area:538}, a oeste do refúgio; {npc:9117} está no alto da colina atrás dela.",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Voe para {area:271} e siga a estrada para o norte em direção às Montanhas de Alterac: o Tenente Haggerdin acampa em {area:1056}, ao lado dela.",
	-- ["For {area:3197}: keep it"] = "Para {area:3197}: guarde-a",
	-- ["For {npc:10778}: keep it"] = "Para {npc:10778}: guarde-a",
	-- ["For {zone:1448}: keep it"] = "Para {zone:1448}: guarde-a",
	-- ["From {area:392}, fly to {area:976}."] = "De {area:392}, voe para {area:976}.",
	-- ["Its jars are filled on the next Un'Goro visit"] = "As jarras dela são enchidas na próxima visita à Cratera Un'Goro",
	-- ["On {npc:7583}"] = "Em {npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "Volte para {area:3425} e voe para {area:392}.",
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Siga para o leste até a torre de {area:2742} em {area:2738}; suba nela e mate os emboscadores que surgem pelo objeto incrustado.",
	-- ["Ride east to {npc:13220}."] = "Siga para o leste até {npc:13220}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "Siga para o norte até a borda nordeste de {area:2277}.",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "Continue para o norte até {area:3197} e voe para {area:2268}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Saia da cratera pelo desfiladeiro noroeste até {zone:1451} e siga até {area:3425}.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Siga para o sudoeste até a {area:2261}. O monte de terra fica lá dentro. {npc:11886} é elite: recomenda-se formar um grupo.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Siga para o sudoeste até o acampamento de {npc:7771} em {area:1938}.",
	-- ["Scourge Champions"] = "Campeões do Flagelo",
	-- ["Sixty {item:2592}, if you carry them"] = "Sessenta {item:2592}, se você tiver",
	-- ["Take the {area:2257} to {zone:1455}."] = "Pegue o {area:2257} para {zone:1455}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Os Monstros de Piche chafurdam em {area:538}; os elementais de fogo de {area:537}, no meio, carregam a cinza; as vespas Gorishi de {area:540}, no sul, carregam a glândula. Toda criatura da cratera pode deixar cair {item:11018}.",
	-- ["The crater"] = "A cratera",
	-- ["The next guide starts here in {area:392}."] = "O próximo guia começa aqui, em {area:392}.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Os Druidas Torturados e as Sentinelas Torturadas assombram a aldeia em ruínas a sudoeste de {npc:13220}.",
	-- ["The western dunes"] = "As dunas do oeste",
	-- ["The {area:2742} tower"] = "A torre de {area:2742}",
	-- ["Umber in {zone:1450}: keep it"] = "Umbero em {zone:1450}: guarde-a",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "farme {npc:8532} no {area:2258}, {zone:1423}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, dos Campeões do Flagelo",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}, de {npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}, perto do metrô",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, na AVIN",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, que anda pelos canais",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera no cemitério logo a leste da cidade; a lápide fica perto.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} fica em {area:392}",
}
