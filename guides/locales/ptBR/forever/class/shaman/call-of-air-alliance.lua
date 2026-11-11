-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-air-alliance (forever/class/shaman/call-of-air-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94789} Call of Air
	["{quest:94789} and the Tempest's Weapons (Alliance)"] = "{quest:94789} e The Tempest's Weapons (Aliança)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "O {item:5178} que permite pôr totens de ar, e depois uma arma à sua escolha no nível 40.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:259023} Veyric Thunderhame · {zone:1417} Arathi Highlands · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} he gives."] = "No nível 30, {npc:258098}, o instrutor de xamã em {zone:1455}, manda você para {npc:259023}, em {zone:1417}. Seus totens de ar do nível 30 (Aterramento, {spell:10596}) precisam de {item:5178}, que ele entrega.",

	-- Step 2: Veyric Thunderhame
	-- {npc:259023} Veyric Thunderhame · {area:321} Hammerfall · {area:320} Refuge Pointe
	["{npc:259023} camps in the hills just west of {area:321}, the Horde town in the north-east of Arathi: mind its guards. Fly to {area:320} and head north-east."] = "{npc:259023} acampa nas colinas logo a oeste de {area:321}, a cidade da Horda no nordeste de Arathi: cuidado com os guardas. Voe para {area:320} e siga para nordeste.",
	-- {npc:259023} Veyric Thunderhame · {item:5178} Air Totem
	["{npc:259023}: your {item:5178}"] = "{npc:259023}: seu {item:5178}",

	-- Step 3: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} é uma masmorra para cinco jogadores no extremo sul de {zone:1413} (a seta aponta para a entrada); {npc:4421} (elite de nível 33) é o último chefe. Ela lança {spell:8292}, {spell:139} nos aliados e Pureza; {item:274463} cai só dela.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, de {npc:4421}",

	-- Step 5: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Totens do Fogo Deturpados",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "Cinco Totens do Fogo Deturpados. Os trogues da Abóbada de Pedra (Batecrânios, Quebraossos e Xamãs, nível 37-41) ao sul de {area:338}, em {zone:1418}, carregam; os Xamãs soltam Totens de Nova de Fogo e {npc:3560}, e os Quebraossos correm atrás de ajuda quando feridos. Voltam em cerca de cinco minutos.",

	-- Step 6: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Totens da Terra Deturpados",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "Cinco Totens da Terra Deturpados. Os Perdidos (murlocs, nível 34-39) ao norte e nordeste de {area:75}, em {zone:1435}, carregam; a maioria corre atrás de ajuda quando ferida.",

	-- Step 7: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Totens da Água Deturpados",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "Cinco Totens da Água Deturpados. Os murlocs Pântano Fino (nível 35-38) a nordeste de {area:496}, no norte de {zone:1445}, carregam.",

	-- Step 8: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Totens do Ar Deturpados",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "Cinco Totens do Ar Deturpados. Os centauros Maraudine (nível 36-40) ao norte e nordeste de {area:2408}, no oeste de {zone:1443}, carregam; os Batedores soltam um quase a cada duas mortes. Os Domadores usam Rede e Desarmar, os Caçaventos curam e os Tempestuosos jogam {spell:9654}: puxe um de cada vez. Voltam em cerca de cinco minutos.",

	-- Step 10: The steam pools
	["The steam pools"] = "As fontes de vapor",
	-- {npc:259023} Veyric Thunderhame · {item:268582} Corrupted Totems · {zone:1441} Thousand Needles · {area:489} Thalanaar · {zone:1444} Feralas · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:259023} hands you the {item:268582}. {zone:1441} is far: the boat to Theramore and the road west, or fly to {area:489} on the {zone:1444} border and head east into the canyon. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:259023} entrega {item:268582} a você. {zone:1441} é longe: pegue o barco até Theramore e siga a estrada para oeste, ou voe até {area:489}, na divisa com {zone:1444}, e siga para leste, rumo ao desfiladeiro. Coloque {item:268582} nas poças de vapor a noroeste de {area:484} para chamar os elementais corrompidos e depois {npc:216474}; os quilboar Navalha se juntam à luta enquanto o ritual corre. Missão de grupo: leve pelo menos um ou dois amigos. {item:212792} cai quase a cada duas mortes, e todo membro do grupo pode saquear.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, de {npc:216474}",

	-- Step 12: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}."] = "{npc:6176} acampa nas ruínas do leste de {zone:1416}: a partir de {area:272}, siga para o norte, pelas colinas, o rio a leste da cidade. Escolha sua arma: {item:280607}, {item:280605} ou {item:280604}.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}: o {item:280696} e sua arma",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:259023} in {zone:1417}."] = "No nível 30, {npc:258098}, o instrutor de xamãs em {zone:1455}, manda você até {npc:259023} nas {zone:1417}.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Os Perdidos no norte do {zone:1435} carregam os Totens da Terra Deturpados.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Os centauros Maraudinos do oeste de {zone:1443} carregam os Totens do Ar Deturpados.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Os murlocs Lamapina do norte de {zone:1445} carregam os Totens da Água Deturpados.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Os troggs da Abóbada de Pedra no sul das {zone:1418} carregam os Totens do Fogo Deturpados.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} é uma masmorra na borda sul dos {zone:1413} (a seta aponta para a entrada); {npc:4421} é o último chefe. Leve um grupo.",
	-- ["{npc:259023} camps in the northern hills of {zone:1417}."] = "{npc:259023} Thunderhame acampa nas colinas do norte das {zone:1417}.",
	-- ["{npc:259023} hands you the {item:268582}: place them at the steam pools of {zone:1441} and defeat the {npc:216474} they call. {quest:96135} is an elite quest: grouping up is advised."] = "{npc:259023} Thunderhame entrega a você os {item:268582}: ponha-os nas fontes de vapor de {zone:1441} e derrote {npc:216474} que eles invocam. {quest:96135} é uma missão de elite: é recomendado formar um grupo.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} acampa no leste das {zone:1416}, a nordeste de {area:272}.",
}
