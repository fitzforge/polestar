-- Portuguese (Brazil) (ptBR): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Sua forma de viagem aquática: nade rápido e respire debaixo d'água, com um cinto e um ídolo de quebra.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. Skyborne: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up."] = "{npc:4217} fica no andar de cima do prédio dos druidas em {area:1658}. Celonatos: usem {spell:18960} e peguem o voo de {npc:11800} no meio de {area:2361} (ela leva druidas para {area:702}, sem precisar de rota de voo), depois subam pelo portal.",

	-- Step 3: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:29} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:29} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "Use {spell:18960} para chegar aqui: {npc:11802} fica no andar de cima do prédio ao lado de onde você pousa. {quest:29} tem um limite de 30 minutos: depois de aceitá-la, nada de teleporte nem Pedra de Regresso até {npc:11799} recebê-la. Seis Recipientes de Adorno (vasos) ficam em reentrâncias estreitas no fundo de {area:656}, abaixo de {area:2361}, quase sempre perto das fendas borbulhantes (o {object:177524} no meio do lago renova o seu fôlego); cada um volta três minutos depois de aberto, e outros druidas também os pegam. Confira se o {item:15877} está nas suas bolsas antes de subir à superfície: ele some cinco minutos depois de você pegá-lo. Nade com ele direto até o {area:2362}, na margem noroeste, use-o dentro do terreno do santuário e fale com {npc:11799} junto à árvore.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de um {object:177785} no lago",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "No {area:2362}",

	-- Step 4: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:456} Cliffspring River
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Fly from {area:2361} to {area:442}. The {object:177792} lies far out on the sea floor off the north coast, between tall rocks west of where the {area:456} reaches the sea: it cannot be seen from the east side of the rocks. Watch your breath and the Darkshore Threshers; fight above water."] = "Voe de {area:2361} para {area:442}. O {object:177792} está longe, no fundo do mar ao largo da costa norte, entre rochas altas a oeste de onde {area:456} chega ao mar: do lado leste das rochas não dá para ver. Fique de olho no fôlego e nos Manguais da Costa Negra; lute fora d'água.",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}, from the {object:177792}"] = "{item:15883}, do {object:177792}",

	-- Step 5: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Head west to the coast: the {object:177790} lies far out on the sea floor beside a bubbling fissure (air), west of a sunken anchor. Sharks roam here; do not swim on past the wreck beyond it, the deep water brings fatigue."] = "Pegue o barco de {area:442} para {zone:1453} e voe para {area:108}. Siga para oeste até a costa: o {object:177790} está longe, no fundo do mar, ao lado de uma fenda borbulhante (ar), a oeste de uma âncora afundada. Tubarões rondam por ali; não passe do naufrágio mais adiante, a água funda dá fadiga.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "{item:15882}, do {object:177790}",

	-- Step 6: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "Use {spell:18960}. Com as duas metades nas bolsas, fique junto ao {area:2362}, na margem noroeste, e use o {item:15883} para juntá-las; depois use {spell:18960} de novo (funciona dentro de {zone:1450}) para pousar junto a {npc:11802}. Ele fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares. Depois, {npc:11800}, no meio de {area:2361}, leva druidas direto até {area:702}.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: junte as metades no santuário",

	-- Step 7: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:31} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:31}: swim fast and breathe underwater."] = "Suba pelo portal até {npc:4217}, em {area:1658}. {quest:31}: nade rápido e respire debaixo d'água.",

	-- Step 8: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:5061} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:5061}: swim fast and breathe underwater."] = "Suba pelo portal até {npc:4217}, em {area:1658}. {quest:5061}: nade rápido e respire debaixo d'água.",

	-- Step 9: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands in the druids' hut on {area:1639}."] = "{npc:3033} fica na cabana dos druidas em {area:1639}.",

	-- Step 10: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:28} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:28} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "Use {spell:18960} para chegar aqui: {npc:11802} fica no andar de cima do prédio ao lado de onde você pousa. {quest:28} tem um limite de 30 minutos: depois de aceitá-la, nada de teleporte nem Pedra de Regresso até {npc:11799} recebê-la. Seis Recipientes de Adorno (vasos) ficam em reentrâncias estreitas no fundo de {area:656}, abaixo de {area:2361}, quase sempre perto das fendas borbulhantes (o {object:177524} no meio do lago renova o seu fôlego); cada um volta três minutos depois de aberto, e outros druidas também os pegam. Confira se o {item:15877} está nas suas bolsas antes de subir à superfície: ele some cinco minutos depois de você pegá-lo. Nade com ele direto até o {area:2362}, na margem noroeste, use-o dentro do terreno do santuário e fale com {npc:11799} junto à árvore.",

	-- Step 11: Half Pendant of Aquatic Agility
	-- {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:1637} Orgrimmar · {object:177792} Strange Lockbox · {area:382} Sludge Fen
	["Take {npc:11798}'s flight to {area:1638} and fly on to {area:1637}. The {object:177792} lies underwater in the {area:382} pond, a short walk out of {area:1637}'s west gate, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "Pegue o voo de {npc:11798} até {area:1638} e siga voando até {area:1637}. {object:177792} fica debaixo d'água na lagoa {area:382}, a uma curta caminhada do portão oeste de {area:1637}, diante de uma parede de madeira. O pessoal da Empreendimentos S.A. ali entra logo na briga: chegue pelo oeste para evitar a maioria.",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["Back through {area:1637} to the zeppelin towers outside its main gate: the zeppelin to the {zone:1458} lands in {zone:1420}, and {zone:1421} is south of the {zone:1458}."] = "De volta por {area:1637} até as torres de zepelim fora do portão principal: o zepelim para {zone:1458} pousa em {zone:1420}, e {zone:1421} fica ao sul de {zone:1458}.",

	-- Step 13: Half Pendant of Aquatic Endurance
	-- {object:177790} Strange Lockbox · {area:228} Sepulcher · {spell:18960} Teleport: Moonglade
	["The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down. Then {spell:18960} takes you straight back."] = "{object:177790} fica no fundo de águas bem profundas, ao largo da costa a noroeste de {area:228}, ao lado de uma fissura de ar onde você consegue respirar: cuide do fôlego na descida. Depois {spell:18960} leva você direto de volta.",

	-- Step 14: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:11798} flies druids to {area:1638}."] = "Use {spell:18960}. Com as duas metades nas bolsas, fique junto ao {area:2362}, na margem noroeste, e use o {item:15883} para juntá-las; depois use {spell:18960} de novo (funciona dentro de {zone:1450}) para pousar junto a {npc:11802}. Ele fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares. {npc:11798} leva druidas para {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lance {spell:18960}. Junte as duas metades no {item:15885} perto de {area:2362}, na margem noroeste do lago, e depois fale com {npc:11802} em {area:2361}. Depois voe até {area:702}.",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lance {spell:18960}. Junte as duas metades no {item:15885} perto de {area:2362}, na margem noroeste do lago, e depois fale com {npc:11802} em {area:2361}. {npc:11798} leva druidas voando até {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Adornos de Altar ficam nos recipientes no fundo de {area:656}, abaixo de {area:2361}: leve um até {area:2362} na margem noroeste, use-o lá e fale com {npc:11799}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Os Adornos de Altar ficam no fundo de {area:656} e somem em poucos minutos: nade com um direto até {area:2362} na margem noroeste, use-o lá e fale com {npc:11799}.",
	-- ["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Voe de {area:2361} até {area:442}. O {object:177792} está debaixo d'água perto da costa norte, a oeste das {area:443}.",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Pegue o navio de {area:442} até {zone:1453} e voe até {area:108}. Cavalgue para noroeste até a costa: o {object:177790} está no fundo do mar perto da praia.",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "Pegue o portal até {npc:4217} no {area:1658}.",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down."] = "Pegue o voo de {npc:11798} para {zone:1456}, voe para {zone:1454} e pegue o zepelim para {zone:1420}; {zone:1421} fica ao sul de {zone:1458}. O {object:177790} está no fundo de águas bem fundas, ao largo da costa a noroeste de {area:228}, ao lado de uma fenda de ar onde dá para respirar: cuide do fôlego na descida.",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Pegue o voo de {npc:11798} até {zone:1456}, voe até {zone:1454} e pegue o zepelim até {zone:1420}; {zone:1421} fica ao sul de {zone:1458}. O {object:177790} está na costa a oeste do {area:240}, ao norte do {area:228}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "O {object:177792} está na borda norte do {area:382}, perto da torre da Empreendimentos S.A., ao norte da {area:380}.",
	-- ["The {object:177792} lies underwater in the {area:382} pond north of the Crossroads, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "O {object:177792} fica debaixo d'água na lagoa {area:382}, ao norte da Encruzilhada, em frente a uma parede de madeira. O pessoal da Empreendimentos S.A. ali entra logo na briga: chegue pelo oeste para evitar a maioria.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} fica no {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} fica no {area:1658}.",
}
