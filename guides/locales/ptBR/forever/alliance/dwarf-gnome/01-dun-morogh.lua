-- Portuguese (Brazil) (ptBR): the guide forever/alliance/dwarf-gnome/01-dun-morogh (forever/alliance/dwarf-gnome/01-dun-morogh.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}, o instrutor de guerreiro",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}, o instrutor de paladino",
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}: uma runa para {npc:895}",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}, o instrutor de caçador",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, o instrutor de ladino",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, o instrutor de sacerdote",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}: leia a {quest:98581}",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}, dentro de {area:77}",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, o instrutor de mago, dentro de {area:77}",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, dentro de {area:77}",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, ao lado de {npc:658}",
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
	["A few more troggs outside if you are short"] = "Mais alguns troggs lá fora se faltar algum",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}"] = "{npc:8416}, junto à porta de {area:77}",

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
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["A few Frostmane Troll Whelps if you are short"] = "Alguns Jovens Trolls Jubafria se faltar algum",

	-- Step 10: The troll cave
	["The troll cave"] = "A caverna dos trolls",
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
	["{npc:836}, inside {area:77}"] = "{npc:836}, dentro de {area:77}",
	["Level 4 spells, before Gozwin's camp"] = "Feitiços de nível 4, antes do acampamento de Gozwin",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} fica com {npc:8416} junto à porta de {area:77}. O acampamento de Gozwin fica nas colinas logo a noroeste; o {npc:269075} ronda por ali.",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, no acampamento",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} está dentro da caverna dos trolls a leste do acampamento de {npc:786}, não na colina acima: entre pela boca e siga o túnel até o fundo.",

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

	-- Step 18: Kharanos
	-- {area:131} Kharanos · {npc:1267} Ragnar Thunderbrew · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1872} Tharek Blackstone
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. {npc:1252}, Eric and his campfire are outside the {area:2102}. {npc:6806}, {npc:1226} and {npc:1267} are inside. {npc:1872} works the forge."] = "Siga a estrada pelo túnel e para nordeste até {area:131}. Mate os Rochetuscos no caminho: as costelas caem antes de você ter a missão de {npc:1267} e contam para ela. {npc:1252}, Eric e a fogueira dele ficam do lado de fora da {area:2102}. {npc:6806}, {npc:1226} e {npc:1267} estão lá dentro. {npc:1872} trabalha na forja.",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the distillery"] = "{npc:6806}, na destilaria",
	-- {npc:1226} Maxan Anvol · {npc:6806} Tannok Frosthammer
	["{npc:1226}, next to {npc:6806}"] = "{npc:1226}, ao lado de {npc:6806}",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}"] = "{item:2894}, de {npc:1247}",

	-- Step 19: The Great Outdoors
	-- {npc:1699} Gremlock Pilsnor
	["Sit by Eric's campfire (type /sit) and wait for the buff, then {npc:1699} in the distillery teaches you cooking."] = "Sente-se junto à fogueira de Eric (digite /sentar) e espere o bônus; depois {npc:1699}, na destilaria, ensina culinária a você.",
	-- {npc:1699} Gremlock Pilsnor
	["Speak with {npc:1699}"] = "Fale com {npc:1699}",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Siga a estrada para nordeste a partir de {area:131} até a garagem abaixo da estrada de {zone:1455}.",

	-- Step 21: Boars and bears
	["Boars and bears"] = "Javalis e ursos",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Rochetuscos e Ursos Pretos Jovens vagam pelos campos em volta de {area:131} e da garagem.",

	-- Step 24: The Grizzled Den
	-- {quest:313} The Grizzled Den · {area:131} Kharanos
	["{quest:313} is the wendigo cave south-west of {area:131}. Flintfire's shipments lie on the cave floor."] = "{quest:313} é a caverna de wendigos a sudoeste de {area:131}. Os carregamentos de Pederfogo estão no chão da caverna.",

	-- Step 26: Mountaineer Cornelius
	-- {area:136} Grizzled Den
	["Cornelius is missing in the {area:136}: find him inside, then go back to Gretchen."] = "Cornelius está desaparecido no {area:136}: encontre-o lá dentro e depois volte até Gretchen.",

	-- Step 28: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131} e a garagem",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, at the depot"] = "{npc:1377}, na garagem",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, by the depot"] = "{npc:1269}, perto da garagem",

	-- Step 29: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den · {npc:1243} Hegnar Rumbleshot
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}; {npc:1243} camps south-west of it, by the road to Coldridge."] = "{object:176785} fica ao lado de {npc:271546}, ao sul de {area:136}; {npc:1243} acampa a sudoeste dele, junto à estrada para o Vale Cristálgida.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}: {object:176785}",

	-- Step 30: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village
	["{area:135} is the troll cave in the hills west of {area:137}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135} é a caverna dos trolls nas colinas a oeste de {area:137}. Mate os Caçadores de Cabeças na entrada e atravesse até o fundo.",

	-- Step 31: Brewnall Village
	-- {area:137} Brewnall Village · {area:135} Frostmane Hold
	["{area:137} sits on the lake north-west of {area:135}."] = "{area:137} fica no lago a noroeste de {area:135}.",

	-- Step 32: Gnomes, bears and leopards
	["Gnomes, bears and leopards"] = "Gnomos, ursos e leopardos",
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
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373} guarda os barris de {item:2686} no porão da destilaria. Compre uma {item:2686} de {npc:1247}, clique no barril vigiado e depois entregue a cerveja a {npc:1373} pela janela de missão dele (não há missão para aceitar); depois disso, o barril sem vigia recebe o {spell:8553}.",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery"] = "{item:2686}, de {npc:1247} na destilaria",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "O {object:269} no porão",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel"] = "{npc:1373}, ao lado do barril",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery"] = "O {object:270} na destilaria",

	-- Step 37: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "Siga a estrada para leste passando a garagem até o {area:138}.",

	-- Step 38: Firewood
	["Firewood"] = "Lenha",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "A lenha está na neve em volta do lago congelado junto ao refúgio.",

	-- Step 40: The cold
	["The cold"] = "O frio",
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["Minor Ice Elementals drift around the frozen lake by the refuge. The three rifles are in the snow around it."] = "Elementais de Gelo Menores flutuam em volta do lago congelado junto ao refúgio. Os três rifles estão na neve em volta dele.",

	-- Step 42: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "O {item:286325} fica junto ao lago congelado, entre os elementais de gelo.",

	-- Step 45: Gol'Bolar Quarry
	["The quarry lies south-east of the ranch."] = "A pedreira fica a sudeste do rancho.",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: só ferreiros",

	-- Step 46: The quarry troggs
	["The quarry troggs"] = "Os troggs da pedreira",
	-- {area:212} Helm's Bed Lake · {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper · Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher
	["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Batecrânios Pedraqueixo enchem a pedreira; Emboscadores Pedraqueixo junto ao {area:212} deixam cair o {item:268548}.",

	-- Step 47: Foreman Stonebrow and Quarrymaster Thesten
	-- {npc:1254} Foreman Stonebrow · {npc:1256} Quarrymaster Thesten
	["{npc:1254} and {npc:1256}"] = "{npc:1254} e {npc:1256}",

	-- Step 48: Stolen Blasting Powder
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}."] = "Emboscadores Pedraqueixo junto ao {area:212}, ao norte da pedreira, e Quebradorsos Pedraqueixo mais a leste deixam cair a {quest:95214}.",

	-- Step 49: Leopards and boars
	["Leopards and boars"] = "Leopardos e javalis",
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Blacksmiths = {area:3421} Blacksmith · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Leopardos da Neve e javalis vagam pela neve entre o rancho e a pedreira. Ferreiros: Barras de Cobre vêm da fundição de {item:2770} ou dos mercadores de profissão.",

	-- Step 52: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960} espera no {area:808}; o cadáver do anão está subindo o desfiladeiro a oeste dele.",

	-- Step 53: Hearth to Kharanos
	-- {area:131} Kharanos
	["Hearth to {area:131}"] = "Regressar para {area:131}",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}, na ferraria",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: {npc:257597}, perto do Portão Sul, a recebe",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}: {npc:376} em {zone:1453} a recebe",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}: {npc:258785} em {zone:1455} a recebe",

	-- Step 54: Taming the Beast
	-- {item:15908} Taming Rod · {area:131} Kharanos
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "Cada missão de Grif Selvacuore lhe dá um {item:15908}: use-o na fera que ele indicar e depois leve o bastão de volta a ele na ferraria de {area:131}. Rochetuscos Grandes, Leopardos da Neve e Ursos Garra de Gelo vagam pelos campos logo ao sul e a leste de {area:131}.",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}: dome-o com o {item:15908}",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}: dome-o com o {item:15908}",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}: dome-o com o {item:15908}",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "{npc:10090} em {zone:1455} a recebe",

	-- Step 55: Shimmerweed
	-- {item:2676} Shimmerweed · {area:137} Brewnall Village
	["{item:2676} bushes grow on the hills around {area:137}."] = "Arbustos de {item:2676} crescem nas colinas em volta de {area:137}.",

	-- Step 58: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "Siga a estrada até o extremo leste, até o {area:806} no túnel de {zone:1432}.",

	-- Step 59: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} espera numa caverna acima da fazenda a noroeste do {area:806}; a trilha começa atrás da fazenda.",

	-- Step 60: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "Atravesse o túnel até {zone:1432}. Logo depois, uma trilha marcada por pedras sobe as colinas à direita da estrada rumo ao norte, até o acampamento de {npc:257808}.",

	-- Step 61: Fire Tar and the Reagent Pouch
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

	-- Step 62: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "A Pedra do Espírito de Fogo",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} lhe dá a {item:6636}. Suba ao pico acima do acampamento dele, beba a Sapta ao lado da Pedra Espiritual e derrote a {npc:5893}, depois coloque a {item:6655} dela no {object:61934}, no alto do Santuário da Chama Eterna.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, ao lado da Pedra Espiritual",

	-- Step 63: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "De volta a {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Volte pelo túnel até a caverna de {npc:257597} acima da fazenda.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, seu {item:5176} e o {item:263412}",

	-- Step 64: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen acampa na crista que dá vista para a {area:134}, a oeste. Fale com ele para usar a vidência dele.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, na pedreira",

	-- Step 65: Spies and Bonesnappers
	["Spies and Bonesnappers"] = "Espiões e Quebraossos",
	-- {area:212} Helm's Bed Lake · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Bonesnappers = {npc:1117} Rockjaw Bonesnapper
	["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "Quebraossos Pedraqueixo rondam a pedreira e {area:212}; Espiões Ferro Negro rondam às escondidas a margem do lago. Um espião deixa cair o {item:274268}.",

	-- Step 68: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave to the north-east of his camp: grab them and leave quickly."] = "{npc:1266} acampa no {area:801}, ao sul da Aldeia da Cevada. As carnes dele estão no armário da caverna do {npc:1271}, a nordeste do acampamento: pegue-as e saia rápido.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker"] = "{item:2667}: o armário de carne",

	-- Step 69: The Tome of Divinity
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "Siga a estrada até {zone:1455} e pegue a {object:32362}: {npc:5149}, {npc:6179} e {npc:6178} estão no {object:32386}. {npc:6175}, um mendigo, anda pela cidade. Ele pede dez {item:2589}: os troggs e trolls de {zone:1426} deixam cair, e a Casa de Leilões vende.",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "Do {quest:2997} que ela lhe dá",

	-- Step 70: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "Saia de {zone:1455} e cavalgue para leste pela estrada até {area:212}. {npc:6177} jaz morto na margem: use o {item:6866} nele. Os Espiões Ferro Negro que rondam o lago levam o manuscrito.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "Use o {item:6866} em {npc:6177}",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Espiões Ferro Negro",

	-- Step 71: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}: Redenção",

	-- Step 72: Ironforge class quests
	-- {zone:1455} Ironforge
	["{zone:1455} class quests"] = "Missões de classe em {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern
	["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090} está no {object:32390}, {npc:258785} no {object:32386}, {npc:6120} na {object:32383}.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {npc:6122} em {zone:1453} a recebe",

	-- Step 73: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "O {area:2257}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Siga a estrada até {zone:1455} e treine com seu instrutor de classe. O {area:2257} sai da {object:171524}, no leste da cidade. Vá nele até {zone:1453}.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, perto da caixa de correio na {object:171524}",
	-- {npc:258098} Eldrun Stormbreaker · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, o instrutor de xamã, ao norte da {object:32372}",

	-- Step 74: Defensive Stance
	-- {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "O metrô chega no {object:28027}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto da {object:2152} de lá. {npc:6090} luta com você pela caneca dele.",

	-- Step 75: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376} está na Catedral da Luz.",

	-- Step 76: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} espera no porão do {object:2164}, no {object:2101}.",

	-- Step 77: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Saia de {zone:1453} pelo portão principal, vá para o sul até {area:87} e para leste pela estrada até a {area:62}. {npc:881} (nível 9) fica junto à casa da fazenda.",

	-- Step 78: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall · {area:87} Goldshire
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "De volta a {npc:6122}. Use o {item:6928} no círculo de evocação do porão do {object:2164} e derrote o emissário do caos que ele chama. {zone:1436} é a próxima, a oeste de {area:87}.",
	["Subdue the voidwalker"] = "Subjugue o emissário do caos",

	-- Step 79: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} fica na torre do {object:2101}; ela lhe dá um frasco para a cachoeira do {quest:1861}.",

	-- Step 80: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Saia de {zone:1453} pelo portão principal. A cachoeira do {quest:1861} fica a sudoeste dos portões, no caminho para oeste até {zone:1436}: encha o {item:7207} na base dela.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The ammo crate sits in the Frostmane camp on {area:802}; {npc:1243} camps south of it, by the road to Coldridge."] = "O caixote de munição fica no acampamento Jubafria em {area:802}; {npc:1243} acampa ao sul dele, junto à estrada para o Vale Cristálgida.",
}
