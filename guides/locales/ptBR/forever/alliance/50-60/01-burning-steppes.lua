-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {area:150} Menethil Harbor · {area:442} Auberdine
	["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "Voe de {zone:1455} para {area:150} e pegue o barco para {area:442}.",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {area:415} Astranaar
	["From the {area:442} dock, fly to {area:415}."] = "Do cais de {area:442}, voe para {area:415}.",

	-- Step 3: Talrendis Point
	-- {zone:1440} Ashenvale · {zone:1447} Azshara · {area:3137} Talrendis Point
	["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "Siga para o leste pela estrada, saindo de {zone:1440} e entrando em {zone:1447}, até o acampamento das Sentinelas em {area:3137}.",

	-- Step 4: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "O santuário fica no canto sudoeste de {zone:1447}, ao sul de {area:3137}.",

	-- Step 5: Haldarr Encampment
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "Os fantasmas Altaneiros assombram as ruínas ao redor do santuário; os sátiros Haldarr ocupam o acampamento logo ao norte dele.",

	-- Step 7: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "Siga para o nordeste a partir do santuário: {npc:8405} acampa em {area:1224}, nas colinas acima da estrada.",

	-- Step 8: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "Ginetes Cascomusgo",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "Os Ginetes Cascomusgo mais próximos pastam nas colinas a nordeste de {area:1224}, em direção a {area:1219}; um rebanho maior vagueia pelo campo aberto ao sul.",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "Opcional: {npc:8395} quer duas Penas Intactas de Hipogrifo dos hipogrifos ao redor do acampamento dele. Os dados não indicam experiência para ela.",

	-- Step 11: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420} acampa em {area:1219}, no norte; o equipamento dele está espalhado por {area:1220}, logo a sudeste dele.",

	-- Step 12: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "Os nagas Iralisca de {area:1221} carregam {item:13815}. As quatro runas de {npc:8507} ficam entre as ruínas: use o {item:10445} dele em cada uma.",
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}: {npc:7864}, cerca de 10%",

	-- Step 13: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "Suba de volta até {npc:8405} em {area:1224}, acima das ruínas.",

	-- Step 15: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "Nade até a pequena ilha na ponta sul de {zone:1447}: {npc:8392} espera junto ao monumento.",

	-- Step 17: Lakeshire
	-- {zone:1455} Ironforge · {area:69} Lakeshire
	["Fly from {zone:1455} to {area:69}."] = "Voe de {zone:1455} para {area:69}.",

	-- Step 18: Morgan's Vigil
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "Siga para o norte saindo de {area:69}, pelo desfiladeiro, até {zone:1428}; {area:2418} fica no alto, no sudeste da região.",
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}: os orcs Rocha Negra deixam cair os medalhões, mantenha-a aberta por toda a região",

	-- Step 19: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "Os ogros Pirobucho ocupam a grande rocha ao norte da Vigia de Morgan, com os Brutamontes no lado leste.",

	-- Step 21: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "Siga a estrada para o oeste e depois suba para o norte até o acampamento goblin em {area:251}.",

	-- Step 22: Thaurissan Relics
	-- plural, as words: Thaurissan Relics = {object:153556} Thaurissan Relic
	["Thaurissan Relics"] = "Relíquias Thaurissanas",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "As relíquias são as pedras entalhadas espalhadas por {area:250} ao redor de {area:251}: clique nelas até recuperar as informações.",

	-- Step 23: The Tablet of the Seven
	-- {quest:4296} Tablet of the Seven
	["The {quest:4296}"] = "{quest:4296}",
	-- {object:147516} Dark Iron (no name in this language: may be words) · {area:251} Flame Crest
	["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "Leia a tábua no acampamento {object:147516} entre as ruínas, a sudoeste de {area:251}, para copiar a transcrição.",

	-- Step 24: Broodling Essence
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "Use o {item:12284} em um {npc:7047} nas encostas a leste de {area:251} pouco antes de ele morrer e depois saqueie a essência que ele deixa.",

	-- Step 25: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "Termina com {quest:4808} em {area:2255}, {zone:1452}: guarde-a",

	-- Step 26: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176} e os orcs Rocha Negra ocupam os acampamentos e a fortaleza ao pé de {area:254}, a oeste de {area:251}. Puxe-os um de cada vez; todo orc e worg pode deixar cair um medalhão, então mate-os até ter cinquenta.",

	-- Step 27: Franclorn Forgewright
	-- {npc:8888} Franclorn Forgewright · {area:254} Blackrock Mountain
	["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "Opcional: o fantasma de {npc:8888} fica sobre o túmulo dele, na grande corrente dentro de {area:254}, e só os mortos podem vê-lo. Se você morrer perto da montanha de qualquer forma, corra com seu espírito até ele antes de ressuscitar.",

	-- Step 28: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "Volte para o leste pela estrada até a Vigia de Morgan.",

	-- Step 29: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "Suba até o topo de {area:249} e finque a cabeça no monte de terra fofa.",

	-- Step 31: Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}."] = "Voe para {area:1438}.",

	-- Step 32: Kum'isha the Collector
	-- {npc:7363} Kum'isha the Collector · {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}, espera em {area:2517}, a colina a sudoeste da fortaleza. Os monstros de {zone:1419} no caminho deixam cair os Fragmentos Imperfeitos de Draenetista; leve a ele o que você tiver.",

	-- Step 33: Wildkin feathers
	["Wildkin feathers"] = "Penas de Coruscante",
	-- {area:1438} Nethergarde Keep · {area:348} Aerie Peak · {zone:1425} Hinterlands
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "Volte para {area:1438} e voe para {area:348}. As Penas de Coruscante ficam no chão por {zone:1425}, ao sul e a leste de {area:348}, onde as ferujas vagueiam; os monstros daqui agora são de nível bem abaixo do seu.",

	-- Step 35: Menethil Harbor
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "Voe para {area:150} e pegue o barco para {area:442} e depois o barco até {area:702}.",

	-- Step 36: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "Os coruscantes estão em {zone:1452}: guarde-a",

	-- Step 37: Druid training
	["Druid training"] = "Treinamento de druida",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455} não tem instrutor de druida: pegue o portal para subir até {zone:1457} e treine em {area:1658}, depois desça de volta até {area:702}.",
}
