-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531} e The Tempest's Weapons (Horda)",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "O {item:5178}, que permite colocar totens de ar, e depois uma arma à sua escolha no nível 40.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words) · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} she gives."] = "No nível 30, {npc:5892}, no {object:172957}, manda você a {npc:5905} em {zone:1441}. Seus totens de ar de nível 30 (Aterramento, {spell:10596}) precisam do {item:5178} que ela dá.",

	-- Step 2: Alaana Stormwalker
	-- {quest:96136} Call of Air · {npc:259119} Alaana Stormwalker · {zone:1412} Mulgore · {zone:1456} Thunder Bluff · {npc:5906} Xanis Flameweaver
	["At 30 Skyborne shamans get their own {quest:96136}. {npc:259119} waits where the airship from Zephras Isle lands, in northern {zone:1412} beside {zone:1456}. Your level 30 air totems need the Air Totem Prate Cloudseer gives. If she has nothing for you, head up to {npc:5906} in {zone:1456} (next step): the trainers' {quest:96136} is open to Skyborne and gives the same totem."] = "No nível 30, os xamãs Celonatos recebem a própria {quest:96136}. {npc:259119} espera onde o barco celeste da Ilha de Zefras pousa, no norte de {zone:1412}, ao lado de {zone:1456}. Seus totens de ar do nível 30 precisam do Totem do Ar que Pradosa Fita Nuvens entrega. Se ela não tiver nada para você, suba até {npc:5906}, em {zone:1456} (próximo passo): a {quest:96136} dos instrutores está aberta aos Celonatos e dá o mesmo totem.",

	-- Step 3: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {npc:5892} Searn Firewarder · {quest:1531} Call of Air · {zone:1454} Orgrimmar
	["At 30 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the Air Totem Prate gives. Already carry {npc:5892}'s {quest:1531} from {zone:1454}? It goes to {npc:5905} too: skip {npc:5906}."] = "No nível 30, {npc:5906}, instrutor de xamã em {area:1640}, em {zone:1456}, manda você para {npc:5905}, em {zone:1441}. Seus totens de ar do nível 30 (Aterramento, {spell:10596}) precisam do Totem do Ar que Pradosa entrega. Já tem {quest:1531} de {npc:5892}, de {zone:1454}? Ela vai para {npc:5905} também: pule {npc:5906}.",

	-- Step 4: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} stands on a ledge above a cave mouth in the canyon wall north-east of the post, not inside the cave: climb the slope beside it. She also gives you an hour of faster attacks and running."] = "Voe para {area:484}. {npc:5905} fica numa saliência acima da boca de uma caverna na parede do desfiladeiro a nordeste do posto, não dentro da caverna: suba a encosta ao lado. Ela também dá uma hora de ataques e corrida mais rápidos.",

	-- Step 5
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: seu {item:5178}",

	-- Step 9: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} é uma masmorra para cinco jogadores no extremo sul de {zone:1413} (a seta aponta para a entrada); {npc:4421} (elite de nível 33) é o último chefe. Ela lança {spell:8292}, {spell:139} nos aliados e Pureza; {item:274463} cai só dela.",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}, de {npc:4421}",

	-- Step 10: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722} fica em {area:484}.",

	-- Step 12: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "Totens do Ar Deturpados",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "Cinco Totens do Ar Deturpados. Os centauros Maraudine (nível 36-40) ao norte e nordeste de {area:2408}, no oeste de {zone:1443}, carregam; os Batedores soltam um quase a cada duas mortes. Os Domadores usam Rede e Desarmar, os Caçaventos curam e os Tempestuosos jogam {spell:9654}: puxe um de cada vez. Voltam em cerca de cinco minutos.",

	-- Step 13: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "Totens da Água Deturpados",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "Cinco Totens da Água Deturpados. Os murlocs Pântano Fino (nível 35-38) a nordeste de {area:496}, no norte de {zone:1445}, carregam.",

	-- Step 14: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "Totens do Fogo Deturpados",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "Cinco Totens do Fogo Deturpados. Os trogues da Abóbada de Pedra (Batecrânios, Quebraossos e Xamãs, nível 37-41) ao sul de {area:338}, em {zone:1418}, carregam; os Xamãs soltam Totens de Nova de Fogo e {npc:3560}, e os Quebraossos correm atrás de ajuda quando feridos. Voltam em cerca de cinco minutos.",

	-- Step 15: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "Totens da Terra Deturpados",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "Cinco Totens da Terra Deturpados. Os Perdidos (murlocs, nível 34-39) ao norte e nordeste de {area:75}, em {zone:1435}, carregam; a maioria corre atrás de ajuda quando ferida.",

	-- Step 17: The steam pools
	["The steam pools"] = "As fontes de vapor",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:5905} hands you the {item:268582}. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:5905} entrega {item:268582} a você. Coloque {item:268582} nas poças de vapor a noroeste de {area:484} para chamar os elementais corrompidos e depois {npc:216474}; os quilboar Navalha se juntam à luta enquanto o ritual corre. Missão de grupo: leve pelo menos um ou dois amigos. {item:212792} cai quase a cada duas mortes, e todo membro do grupo pode saquear.",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}, da {npc:216474}",

	-- Step 19: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm · {item:280696} Elementalist's Guard
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}; the {item:280696} shield comes with it."] = "{npc:6176} acampa nas ruínas do leste de {zone:1416}: a partir de {area:272}, siga para o norte, pelas colinas, o rio a leste da cidade. Escolha sua arma: {item:280607}, {item:280605} ou {item:280604}; o escudo {item:280696} vem junto.",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}: o {item:280696} e sua arma",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "No nível 30, {npc:5892} no {object:172957} manda você a {npc:5905} em {zone:1441}.",
	-- ["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "No nível 30, {npc:5906}, um instrutor de xamã em {zone:1456}, manda você a {npc:5905} em {zone:1441}.",
	-- ["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "Voe até {area:484}. {npc:5905} se esconde numa pequena caverna na parede do cânion a nordeste do posto. Nascido nos Céus: seu próprio {quest:1531} (96136) também termina com ela.",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "Os Perdidos no norte do {zone:1435} levam os Totens da Terra Deturpados.",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "Os centauros Maraudinos do oeste de {zone:1443} levam os Totens do Ar Deturpados.",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "Os murlocs Lamapina do norte do {zone:1445} levam os Totens da Água Deturpados.",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "Os troggs da Abóbada de Pedra no sul de {zone:1418} levam os Totens do Fogo Deturpados.",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717} é uma masmorra na borda sul de {zone:1413} (a seta aponta para a entrada); {npc:4421} é o último chefe. Leve um grupo.",
	-- ["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905} lhe entrega os {item:268582}: coloque-os nas fontes de vapor a oeste de {area:484} e derrote a {npc:216474} que eles chamam. {quest:79366} é uma missão de elite: é recomendado formar grupo.",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} acampa no leste das {zone:1416}, a nordeste de {area:272}.",
	-- ["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}: a {item:213086} e sua arma",
}
