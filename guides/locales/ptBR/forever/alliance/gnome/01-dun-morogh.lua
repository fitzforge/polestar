-- Portuguese (Brazil) (ptBR): the guide forever/alliance/gnome/01-dun-morogh (forever/alliance/gnome/01-dun-morogh.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {area:77} Anvilmar · {npc:658} Sten Stoutarm
	["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "Você começa diante de {area:77}, o salão de pedra no extremo norte do vale. {npc:658} espera do lado de fora da porta.",

	-- Step 2: Young wolves
	["Young wolves"] = "Lobos jovens",
	-- {area:77} Anvilmar
	["Ragged Young Wolves roam the snow just south of {area:77}."] = "Lobos Jovens Rotos vagam pela neve logo ao sul de {area:77}.",

	-- Step 3: Anvilmar
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, ao lado de {npc:658}",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}, o instrutor de guerreiro",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, o instrutor de ladino",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, o instrutor de sacerdote",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, o instrutor de mago, dentro de {area:77}",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, dentro de {area:77}",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "Dentro de {area:77}",

	-- Step 4: The troggs
	["The troggs"] = "Os troggs",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "Troggs Pedraqueixo e Troggs Pedraqueixo Parrudos cavam por todo o fundo do vale ao sul de {area:77}.",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "De volta a {area:77}",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}; inside"] = "{npc:8416}, junto à porta de {area:77}; lá dentro",

	-- Step 6: Talin Keeneye
	-- {npc:714} Talin Keeneye · {item:10438} Felix's Box
	["{npc:714}'s camp is at the west end of the valley. {item:10438} lies in the snow south of it, his Chest by the troll cave and his Bucket of Bolts east of the cave: grab them as you pass."] = "O acampamento de {npc:714} fica no extremo oeste do vale. A {item:10438} está na neve ao sul dele, o Baú de Felix perto da caverna dos trolls e o Balde de Parafusos a leste da caverna: pegue-os ao passar.",

	-- Step 7: The boars
	["The boars"] = "Os javalis",
	-- {npc:714} Talin Keeneye
	-- plural, as words: Small Crag Boars = {npc:708} Small Crag Boar
	["Small Crag Boars graze around {npc:714}'s camp and along the west side of the valley."] = "Rochetuscos Pequenos pastam em volta do acampamento de {npc:714} e pelo lado oeste do vale.",

	-- Step 9: Grelin Whitebeard
	-- {npc:786} Grelin Whitebeard · {npc:12738} Nori Pridedrift
	["{npc:786} and {npc:12738} camp at the south-west edge of the valley, below the troll cave."] = "{npc:786} e {npc:12738} acampam na borda sudoeste do vale, abaixo da caverna dos trolls.",

	-- Step 10: Coldridge Valley: kill these as you meet them
	-- {area:132} Coldridge Valley
	["{area:132}: kill these as you meet them"] = "{area:132}: vá matando estes pelo caminho",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "Jovens Trolls Jubafria enchem as encostas ao sul e a leste do acampamento de {npc:786}.",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "Patuás de Penas, dos Noviços Jubafria",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}: com tempo, cinco minutos para chegar a {npc:836} em {area:77}",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "O Rabo-de-galo Escaldante dura cinco minutos: vá direto para o norte até {npc:836} dentro de {area:77}.",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:836}, inside {area:77}; below ground"] = "{npc:836}, dentro de {area:77}; no subterrâneo",
	["Level 4 spells, before Gozwin's camp"] = "Feitiços de nível 4, antes do acampamento de Gozwin",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}, dentro de {area:77}",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "{npc:8416}, na porta, na saída; lá dentro",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} fica com {npc:8416} junto à porta de {area:77}. O acampamento de Gozwin fica nas colinas logo a noroeste; o {npc:269075} ronda por ali.",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "{npc:2756}, lá dentro",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, no acampamento",
	["The troll cave"] = "A caverna dos trolls",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} está dentro da caverna dos trolls a leste do acampamento de {npc:786}, não na colina acima: entre pela boca e siga o túnel até o fundo.",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "{item:2004}; no subterrâneo",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, ao lado dele",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "Pingentes de Urso Garrálgido, dos Jovens Trolls Jubafria nas encostas acima do acampamento",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "De volta a {npc:257446} em {area:77}. Ele lhe dá a {item:6635}: pegue a trilha marcada por escombros que sobe para oeste a partir do sul do vale até a Pedra Espiritual na crista, beba a Sapta ao lado dela e fale com a {npc:5891}, depois leve o {item:6656} dela de volta a Teo.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, ao lado da Pedra Espiritual",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}: {npc:5873} e seu {item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "O túnel",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965} guarda o túnel que sai do vale, a leste de {area:77}; {npc:6782} fica ao lado dele na entrada.",

	-- Step 18: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "Sente na fogueira do Ériic (digite /sit) e espere o bônus.",

	-- Step 19: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Follow the road through the tunnel and north-east to {area:131}. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}.\n{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "Siga a estrada pelo túnel e para nordeste até {area:131}. Comece do lado de fora: {npc:1252} e a fogueira do Ériic ficam em frente a {area:2102}.\n{npc:1872} trabalha na forja a oeste da cervejaria.\nDepois entre: {npc:6806}, o estalajadeiro, {npc:1226} e {npc:1267}. A aula de {skill:185} com {npc:1699} fica para a volta com as costelas, quando já tiver o cobre para ela.",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "{npc:1241}, no subterrâneo",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "{npc:6806}, lá dentro",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "{npc:1226}, no andar de cima",
	["Last: some classes' trainers stand outside"] = "Por último: os instrutores de algumas classes ficam do lado de fora",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Siga a estrada para nordeste a partir de {area:131} até a garagem abaixo da estrada de {zone:1455}.",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "{npc:1694}, ao lado dele",

	-- Step 21: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}."] = "A {object:176785} fica ao lado de {npc:271546}, ao sul de {area:136}.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}: {object:176785}",

	-- Step 22: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "A Gretchen acampa logo do lado de fora de {area:136}, a caverna dos wendigos a sudoeste de {area:131}.",

	-- Step 23: The Grizzled Den
	-- {npc:278166} Mountaineer Cornelius
	["Flintfire's shipments lie on the cave floor, and {npc:278166} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "Os carregamentos do Pederfogo estão no chão da caverna, e {npc:278166} sumiu em algum lugar lá dentro.\nCuidado: os wendigos ficam bem juntos dentro da caverna, então é fácil puxar vários de uma vez; atraia um de cada vez com ataques à distância lá de fora.",

	-- Step 25: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "{npc:1243} acampa a sudoeste dali, junto à estrada para o Vale Cristálgida.",

	-- Step 26: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "{zone:1426}: vá matando estes pelo caminho",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "Rochetuscos e Ursos Pretos Jovens vagam pelos campos do acampamento de Rumbleshot, a nordeste, até {area:131} e o depósito: mate-os na caminhada de volta.",

	-- Step 27: Kharanos
	-- {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1241} Tognus Flintfire
	["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it."] = "{npc:1252} fica junto à fogueira de Eric, na frente de {area:2102}; {npc:1241} está no porão a oeste dela.",

	-- Step 28: Thunderbrew Distillery
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "Mate os Rochetuscos no caminho: as costelas caem antes de você ter a missão de {npc:1267} e contam para ela. De volta à cervejaria: {npc:1699} ensina {skill:185}, depois as costelas vão para {npc:1267}.",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "{item:2894}, com {npc:1247}; no andar de cima",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "{npc:1699}: Introdução ao acampamento pede que você aprenda; no subterrâneo",
	["Upstairs"] = "No andar de cima",

	-- Step 29: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131} e a garagem",
	-- {npc:1269} Razzle Sprysprocket · {area:131} Kharanos
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "Os pilotos ficam no depósito; {npc:1269} está na estrada de volta a oeste, ao norte de {area:131}.",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "{npc:1377}, ao lado dele",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "{npc:1269}, no caminho de volta; no subterrâneo",

	-- Step 30: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "{area:137} fica no lago a oeste de {area:131}. O cais de {npc:8508} é a primeira parada; {npc:1374} e {npc:1375} ficam na vila logo depois.",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "{npc:8508}, no cais",
	-- {npc:1196} Ice Claw Bear
	["{npc:1196}, on the way to the Hold"] = "{npc:1196}, no caminho para o Covil",
	-- {npc:1127} Elder Crag Boar
	["{npc:1127}, on the way"] = "{npc:1127}, no caminho",
	-- {npc:1201} Snow Leopard
	["{npc:1201}, on the way"] = "{npc:1201}, no caminho",

	-- Step 31: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135} é a caverna dos trolls nas colinas a sudoeste de {area:137}. Os Ursos Garra de Gelo, Rochetuscos Anciãos e Leopardos da Neve que você matar no caminho contam para {npc:1374}. Mate os Caçadores de Cabeças da entrada e atravesse até o fundo.",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "{npc:1123}, no subterrâneo",

	-- Step 32: Gnomeregan: kill these as you meet them
	-- {area:133} Gnomeregan
	["{area:133}: kill these as you meet them"] = "{area:133}: vá matando estes pelo caminho",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "Gnomos Leprosos em volta da Aldeia da Cevada e da estrada de {area:133} levam as rodas dentadas e engrenagens. Ursos Garra de Gelo, Rochetuscos Anciões e Leopardos da Neve vagam pelas colinas em volta do lago.",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}: Gnomos Leprosos",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}: Gnomos Leprosos",

	-- Step 35: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373} guarda os barris de {item:2686} no porão da cervejaria. Compre uma {item:2686} com {npc:1247}, clique no barril vigiado e entregue a cerveja a {npc:1373} pela janela de missão dele (não há missão para aceitar); depois disso, o barril desprotegido recebe o {spell:8553}.",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "{npc:1252}: quem recebe é {npc:1274}, em {zone:1455}",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "{item:2686}, com {npc:1247} na cervejaria; no andar de cima",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "O {object:269} no porão",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "{npc:1373}, ao lado do barril; no subterrâneo",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "O {object:270} na cervejaria; no subterrâneo",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "{npc:1269}, no subterrâneo",

	-- Step 36: Shimmerweed
	-- {item:2676} Shimmerweed · {area:802} Shimmer Ridge · {area:131} Kharanos
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on {area:802}, the snowy slope north of the road between {area:131} and Brewnall: climb from the road west of {area:131}. The Frostmane Seers camped on the ridge drop it too."] = "A {item:2676} cresce em cestos lá em cima, em {area:802}, a encosta nevada ao norte da estrada entre {area:131} e Brewnall: suba pela estrada a oeste de {area:131}. Os Videntes Jubafria acampados na crista também deixam cair.",

	-- Step 38: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {area:131} Kharanos · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of the road back east from Brewnall to {area:131}. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "{npc:1266} acampa em {area:801}, ao sul da estrada que volta de Brewnall para {area:131}. As carnes dele estão no armário da caverna de {npc:1271}, a leste do acampamento. {npc:1271} é um yeti elite: espere escondido até ele sair para a patrulha, pegue as carnes e saia antes de ele voltar. Não precisa brigar com ele.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "{item:2667}: o armário de carnes; no subterrâneo",

	-- Step 39: Kharanos
	-- {area:131} Kharanos
	["Back east through {area:131}: the class quests here wait for level 10."] = "De volta para leste por {area:131}: as missões de classe daqui ficam para o nível 10.",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: {npc:257597}, perto do Portão Sul, a recebe",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}: {npc:258785} em {zone:1455} a recebe",

	-- Step 40: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1426} Dun Morogh
	["Follow the road north-east from {area:131} to the depot: the whole east of {zone:1426} is one sweep from here."] = "Siga a estrada para nordeste de {area:131} até o depósito: daqui dá para varrer todo o leste de {zone:1426} de uma vez.",

	-- Step 41: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "Siga a estrada para leste passando a garagem até o {area:138}.",

	-- Step 42: Firewood
	["Firewood"] = "Lenha",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "A lenha está na neve em volta do lago congelado junto ao refúgio.",

	-- Step 44: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "{npc:276003} no caminho",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "{npc:276003} no caminho até {npc:1253}",

	-- Step 45: Misty Pine Refuge: kill these as you meet them
	-- {area:138} Misty Pine Refuge
	["{area:138}: kill these as you meet them"] = "{area:138}: vá matando estes pelo caminho",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "Os três rifles estão na neve em volta do lago congelado perto do refúgio. Elementais de Gelo Menores vagam pelo lago e pelo caminho: mate-os pelo caminho para {quest:99160}.\nSe ainda faltar, termine os Elementais de Gelo Menores em volta do laguinho logo a oeste do refúgio.",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "{npc:276003}, em volta do laguinho",

	-- Step 47: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "O {item:286325} fica junto ao lago congelado, entre os elementais de gelo.",

	-- Step 52: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen acampa na crista que dá vista para a {area:134}, a oeste. Fale com ele para usar a vidência dele.",

	-- Step 55: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "A pedreira fica logo a leste da crista do Farsen.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, na pedreira",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: só ferreiros",

	-- Step 56: The quarry troggs
	["The quarry troggs"] = "Os troggs da pedreira",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "Batecrânios Pedraqueixo, Quebraossos e Emboscadores dividem a pedreira e as encostas ao norte dela; os Emboscadores soltam o {item:268548}.",

	-- Step 58: Helm's Bed Lake
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "Emboscadores Pedraqueixo perto de {area:212}, ao norte da pedreira, e Quebradorsos Pedraqueixo mais a leste soltam {quest:95214}. Espiões Ferro Negro rondam a margem do lago a leste da pedreira; um deles solta {item:274268}.",

	-- Step 59: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Leopardos da Neve e javalis vagam pela neve entre o rancho e a pedreira. Ferreiros: Barras de Cobre vêm da fundição de {item:2770} ou dos mercadores de profissão.",

	-- Step 62: Protecting the Herd
	-- {npc:1388} Vagash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: most classes solo it at level 14, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:1388} é elite de nível 12: a maioria das classes encara sozinha no nível 14, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	["Below ground"] = "No subterrâneo",

	-- Step 63: Rudra Amberstill
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "Na estrada de volta para oeste, rumo a {zone:1455}.",

	-- Step 66: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "Siga a estrada até o fim, para leste, até {area:806}, no túnel de {zone:1432}.",

	-- Step 67: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} espera numa caverna acima da fazenda a noroeste do {area:806}; a trilha começa atrás da fazenda.",

	-- Step 69: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "Atravesse o túnel até {zone:1432}. Logo depois, uma trilha marcada por pedras sobe as colinas à direita da estrada, para o norte, até o acampamento de {npc:257808}.",

	-- Step 70: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026} e a {item:6652}",
	-- {area:923} Stonesplinter Valley · {npc:257808} Braldir Ashmantle · {area:149} Silver Stream Mine
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "Videntes Lascapedra (nível 13) ficam entre os troggs no sul do {area:923}, ao sul de {npc:257808}; Geomantes Ratatúnel (nível 12) trabalham na {area:149}, no extremo norte do lago. Os troggs vêm em bandos e alguns atacam à distância: atraia um de cada vez.",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}: Videntes Lascapedra",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}: Geomantes Ratatúnel",

	-- Step 71: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "A Pedra do Espírito de Fogo",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} lhe dá a {item:6636}. Suba ao pico acima do acampamento dele, beba a Sapta ao lado da Pedra Espiritual e derrote a {npc:5893}, depois coloque a {item:6655} dela no {object:61934}, no alto do Santuário da Chama Eterna.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, ao lado da Pedra Espiritual",

	-- Step 72: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "De volta a {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Volte pelo túnel até a caverna de {npc:257597} acima da fazenda.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, seu {item:5176} e o {item:263412}",

	-- Step 73: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960} espera em {area:808}, ao norte do Portão Sul; o corpo do anão está subindo a passagem a oeste dele.",

	-- Step 74: The tunnel post
	["The tunnel post"] = "O posto do túnel",
	-- {zone:1432} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "Para leste, pelo túnel do Portão Sul, até {zone:1432}. {npc:1089} e {npc:1092} ficam no posto dos anões, logo depois dele.",

	-- Step 75: Stonesplinter troggs
	["Stonesplinter troggs"] = "Troggs Lascapedra",
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth."] = "Ao norte do posto, a oeste da estrada: os troggs e batedores Lascapedra acampam nas colinas. Ambos soltam os Dentes de Pedra de Trogg.",

	-- Step 76: Back to the tunnel post
	["Back to the tunnel post"] = "De volta ao posto do túnel",

	-- Step 77: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {area:2101} Stoutlager Inn · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to {area:144}. {npc:1340} walks the road through town, {npc:1963} stands outside the {area:2101}, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "Ao norte pela estrada até {area:144}. {npc:1340} anda pela estrada que atravessa a cidade, {npc:1963} fica na frente de {area:2101}, {npc:1681} no lado leste da cidade; {npc:1572} cuida dos grifos.",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "{npc:1572}, o mestre de grifos",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "{npc:1572}: para {npc:4256} em {zone:1455}",

	-- Step 78: The west hills and the Algaz Station
	-- {area:925} Algaz Station
	["The west hills and the {area:925}"] = "As colinas do oeste e {area:925}",
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the {area:925}. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "Ao norte pelas colinas a oeste da estrada até {npc:1343}, em {area:925}. Os kobolds Ratatúnel cavam nas colinas no caminho; Ursos Pretos Anciões, Javalis Montanheses e Tocaieiras da Floresta vagam pelo mesmo terreno.",
	-- {item:3110} Tunnel Rat Ear
	["{item:3110}: Tunnel Rat kobolds"] = "{item:3110}: kobolds Ratatúnel",
	-- {item:3172} Boar Intestines
	-- plural, as words: Mountain Boars = {npc:1190} Mountain Boar
	["{item:3172}: Mountain Boars"] = "{item:3172}: Javalis Montanheses",
	-- {item:3173} Bear Meat
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear
	["{item:3173}: Elder Black Bears"] = "{item:3173}: Ursos Pretos Anciãos",
	-- {item:3174} Spider Ichor
	-- plural, as words: Forest Lurkers = {npc:1195} Forest Lurker
	["{item:3174}: Forest Lurkers"] = "{item:3174}: Tocaieiras da Floresta",
	-- {npc:5413} Furen Longbeard · {zone:1453} Stormwind
	["{npc:5413} in {zone:1453} takes it"] = "{npc:5413}, em {zone:1453}, recebe",

	-- Step 79: Silver Stream Mine
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats."] = "Para o leste, pelas colinas, até a mina na ponta norte do lago: os caixotes da Liga dos Mineradores ficam nos túneis dela, entre mais Ratatúneis.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "{item:2640}, dos caixotes",

	-- Step 80: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "De volta a {area:925}",

	-- Step 81: Thelsamar
	-- {area:144} Thelsamar
	["South down the road to {area:144}, finishing the ears, meat and ichor on the way."] = "Ao sul pela estrada até {area:144}, terminando as orelhas, a carne e o icor no caminho.",

	-- Step 82: Golnir Bouldertoe
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:4256} Golnir Bouldertoe · {npc:1573} Gryth Thurden
	["The gryphons land in the {object:32372}: {npc:4256} works at its north end, and {npc:1573} keeps the gryphons where you landed."] = "Os grifos pousam na {object:32372}: {npc:4256} trabalha no extremo norte dela, e {npc:1573} cuida dos grifos onde você pousou.",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:4256}, in the {object:32372}"] = "{npc:4256}, na {object:32372}",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "{npc:1573}, o mestre de grifos onde você pousou",

	-- Step 83: Tinker Town
	-- {object:32372} Great Forge (no name in this language: may be words) · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {object:171709} High Seat · {object:32359} Military Ward (no name in this language: may be words)
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "A leste da {object:32372}, até {object:171524}: {object:660964} ficam junto à caixa de correio de lá. A partir daqui, o guia dá uma volta pela cidade: ao norte até {object:32383}, a oeste até {object:32362}, ao sul pelo Commons até {object:171709}, a leste por {object:32359} e de volta a {object:171524} para pegar o metrô.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, perto da caixa de correio na {object:171524}",

	-- Step 84: Forlorn Cavern
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "Ao norte da {object:32372}: {npc:258098}, o instrutor de xamã, fica no extremo sul de {object:32383}, os instrutores de ladino e de bruxo e {npc:6120} logo ao norte dele.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {npc:6122} em {zone:1453} a recebe",

	-- Step 85: The Tome of Divinity
	-- {item:6775} Tome of Divinity
	["The {item:6775}"] = "{item:6775}",
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, Tiza and Muiredon on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "A oeste de {object:32383}, até {object:32362}: {npc:5149}, {npc:6179} e {npc:6178} estão em {object:32386}, Tiza e Muiredon no andar de cima: a escada começa logo a nordeste de {npc:5149}. {npc:6175}, um mendigo, vaga pela cidade. Ele pede dez {item:2589}: os troggs e trolls de {zone:1426} soltam, e a Casa de Leilões vende.",

	-- Step 86: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "Saia de {zone:1455} e siga a estrada para leste até {area:212}. {npc:6177} está morto na margem: use o {item:6866} nele. Os Espiões Ferro Negro que se esgueiram pelo lago carregam a carta.",

	-- Step 88: Mystic Ward
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "Os instrutores de paladino, sacerdote e mago estão em {object:32386}, em {object:32362}.",

	-- Step 89: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "Para o sul pela área comum: {npc:1274} fica em {object:171709}, com o Rei Magni.",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "{npc:1274}, em {object:171709}, com o Rei Magni",

	-- Step 90: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "Já que está aqui: aprenda {spell:197} com {npc:11865} ({object:32359}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Paladino.",

	-- Step 91: Military Ward
	-- {object:32359} Military Ward (no name in this language: may be words) · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms (no name in this language: may be words)
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "A leste, até {object:32359}: os instrutores de guerreiro e {npc:11865} em {object:32390}, os instrutores de caçador ao lado.",

	-- Step 92: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:197} com {npc:11865} ({object:32359}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 93: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:199} com {npc:11865} ({object:32359}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 94: Druid trainer
	["Druid trainer"] = "Instrutor de druida",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "{npc:5505} em {zone:1453}; {zone:1426} não tem instrutor de druida",

	-- Step 95: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "O {area:2257}",
	-- {object:171524} Tinker Town · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["East back into {object:171524}: the {area:2257} leaves from its east end. Ride it to {zone:1453}."] = "De volta a leste até {object:171524}: o {area:2257} parte do extremo leste dela. Pegue-o até {zone:1453}.",

	-- Step 96: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Metrô para {zone:1453}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "Na plataforma de {zone:1455} do {area:2257}, {npc:12997} pede ajuda com os ratos: use o {item:17117} dele nos Ratos Correfundo em volta da plataforma, entregue-os e depois leve a carta dele ao irmão dele, {npc:13018}, no extremo de {zone:1453}.",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "{npc:12997}, na plataforma de {zone:1455}",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "{npc:13016}: use a {item:17117}",
	-- {npc:13016} Deeprun Rat
	["Catch {npc:13016}"] = "",

	-- Step 97: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "Pegue o metrô até {zone:1453}: {npc:13018} espera na plataforma de {zone:1453}. {npc:5413} fica no {object:28027}, logo fora do metrô.",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "{npc:13018}, na plataforma de {zone:1453}",

	-- Step 98: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "Do {object:28027} para sudoeste até a {object:2098}: a bússola de {npc:1646} está na antiga casa dele em {zone:1436}, no caminho. O mestre de voo e o {object:2096} ficam ao sul da praça.",

	-- Step 99: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 100: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11867} ({object:2096}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Paladino.",

	-- Step 101: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:11867} ({object:2096}, 10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 102: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Já que está aqui: aprenda Espadas com {npc:11867} ({object:2096}, 10 pratas); espada na mão principal faz o Ladino subir de nível sem tropeço.",

	-- Step 103: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "De {zone:1436}, caminhe até {zone:1453}; o metrô de {zone:1455} chega no {object:28027}. {npc:5480} treina guerreiros na {object:2100}; {npc:6089} e {npc:6090} ficam juntos ao lado da {object:2152}. {npc:6090} luta com você pela caneca dele. Se {npc:5480} não oferecer {quest:1638}, vá direto a {npc:6089}: ele entrega {quest:1639} mesmo sem ela.",

	-- Step 104: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11867} ({object:2096}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 105: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} espera no porão do {object:2164}, no {object:2101}.",

	-- Step 106: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Já que está aqui: aprenda Cajados com {npc:11867} ({object:2096}, 10 pratas); enquanto você sobe de nível, um cajado traz mais atributos de feitiço que uma arma de uma mão.",

	-- Step 107: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Saia de {zone:1453} pelo portão principal, vá para o sul até {area:87} e para leste pela estrada até a {area:62}. {npc:881} (nível 9) fica junto à casa da fazenda.",

	-- Step 108: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {area:87} Goldshire · {zone:1436} Westfall
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {area:87} and east Elwynn are next, then {zone:1436}."] = "De volta a {npc:6122}. Use {item:6928} no círculo de evocação no porão de {object:2164} e derrote o emissário do caos que ele invocar. {area:87} e o leste de Elwynn vêm em seguida, depois {zone:1436}.",
	["Subdue the voidwalker"] = "Subjugue o emissário do caos",

	-- Step 109: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} fica na torre do {object:2101}; ela lhe dá um frasco para a cachoeira do {quest:1861}.",

	-- Step 110: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Saia de {zone:1453} pelo portão principal. A cachoeira de {quest:1861} fica a sudoeste dos portões, no caminho para o oeste rumo a {zone:1436}: encha {item:7207} na base dela.",

	-- Step 111: Goldshire
	-- {zone:1453} Stormwind · {area:87} Goldshire · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to {area:87}: east Elwynn comes before {zone:1436}."] = "Saia de {zone:1453} pelo portão principal e siga a estrada para o sul até {area:87}: o leste de Elwynn vem antes de {zone:1436}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Rochetuscos e Ursos Pretos Jovens vagam pelos campos em volta de {area:131} e da garagem.",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Siga a estrada até {zone:1455} e treine com seu instrutor de classe. O {area:2257} sai da {object:171524}, no leste da cidade. Vá nele até {zone:1453}.",
	-- ["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Batecrânios Pedraqueixo enchem a pedreira; Emboscadores Pedraqueixo junto ao {area:212} deixam cair o {item:268548}.",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "O metrô chega no {object:28027}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto da {object:2152} de lá. {npc:6090} luta com você pela caneca dele.",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}, na garagem",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, o instrutor de xamã, ao norte da {object:32372}",
	-- ["{zone:1455} class quests"] = "Missões de classe em {zone:1455}",
}
