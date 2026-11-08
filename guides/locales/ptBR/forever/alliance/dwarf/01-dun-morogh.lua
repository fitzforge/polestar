-- Portuguese (Brazil) (ptBR): the guide forever/alliance/dwarf/01-dun-morogh (forever/alliance/dwarf/01-dun-morogh.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {npc:658} Sten Stoutarm
	["You start in front of Anvilmar, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "",

	-- Step 2: Young wolves
	["Young wolves"] = "Lobos jovens",
	["Ragged Young Wolves roam the snow just south of Anvilmar."] = "",

	-- Step 3: Anvilmar
	["Anvilmar"] = "",
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}: uma runa para {npc:895}",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}: leia a {quest:98581}",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, ao lado de {npc:658}",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer; inside"] = "",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}, o instrutor de paladino",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}, o instrutor de caçador",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, o instrutor de ladino",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, o instrutor de sacerdote",
	-- {npc:257446} Teo Hammerstorm
	["{npc:257446}, inside Anvilmar"] = "",
	["Inside Anvilmar"] = "",
	-- {npc:460} Alamar Grimm
	["{npc:460}, inside Anvilmar"] = "",

	-- Step 4: The troggs
	["The troggs"] = "Os troggs",
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of Anvilmar."] = "",

	-- Step 5: Back to Anvilmar
	["Back to Anvilmar"] = "",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, by the door of Anvilmar; inside"] = "",

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
	["Coldridge Valley: kill these as you meet them"] = "",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "Jovens Trolls Jubafria enchem as encostas ao sul e a leste do acampamento de {npc:786}.",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "Patuás de Penas, dos Noviços Jubafria",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter
	["{npc:12738}: timed, five minutes to reach {npc:836} in Anvilmar"] = "",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside Anvilmar."] = "",
	-- {npc:836} Durnan Furcutter
	["{npc:836}, inside Anvilmar; below ground"] = "",
	["Level 4 spells, before Gozwin's camp"] = "Feitiços de nível 4, antes do acampamento de Gozwin",
	-- {npc:460} Alamar Grimm
	["{npc:460}: Summon Imp"] = "",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of Anvilmar. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, no acampamento",
	["The troll cave"] = "A caverna dos trolls",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} está dentro da caverna dos trolls a leste do acampamento de {npc:786}, não na colina acima: entre pela boca e siga o túnel até o fundo.",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, ao lado dele",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "Pingentes de Urso Garrálgido, dos Jovens Trolls Jubafria nas encostas acima do acampamento",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in Anvilmar. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, ao lado da Pedra Espiritual",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}: {npc:5873} e seu {item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "O túnel",
	-- {npc:1965} Mountaineer Thalos · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of Anvilmar; {npc:6782} stands beside him at its mouth."] = "",

	-- Step 18: Kharanos
	["Kharanos"] = "",
	-- {npc:1252} Senir Whitebeard
	["Follow the road through the tunnel and north-east to Kharanos. Start outside: {npc:1252} and Eric's campfire are in front of the Thunderbrew Distillery."] = "",

	-- Step 19: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "",

	-- Step 20: Kharanos
	-- {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "",
	["Last: some classes' trainers stand outside"] = "",

	-- Step 21: Steelgrill's Depot
	["Steelgrill's Depot"] = "",
	-- {zone:1455} Ironforge
	["Follow the road north-east from Kharanos to the depot below the {zone:1455} road."] = "",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "",

	-- Step 22: Mountaineer Gretchen
	["Gretchen camps just outside the Grizzled Den, the wendigo cave south-west of Kharanos."] = "",

	-- Step 23: The Grizzled Den
	-- {npc:278166} Mountaineer Cornelius
	["Flintfire's shipments lie on the cave floor, and {npc:278166} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "",

	-- Step 24: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen
	["The {object:176785} sits next to {npc:271546}, south of the Grizzled Den."] = "",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}: {object:176785}",

	-- Step 26: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "",

	-- Step 27: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "",
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to Kharanos and the depot: kill them on the walk back."] = "",

	-- Step 28: Kharanos
	-- {npc:1252} Senir Whitebeard · {npc:1241} Tognus Flintfire
	["{npc:1252} stands by Eric's campfire in front of the Thunderbrew Distillery; {npc:1241} is in the cellar west of it."] = "",

	-- Step 29: Thunderbrew Distillery
	["Thunderbrew Distillery"] = "",
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "",
	["Upstairs"] = "",

	-- Step 30: Kharanos and the depot
	["Kharanos and the depot"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of Kharanos."] = "",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "",

	-- Step 31: Brewnall Village
	["Brewnall Village"] = "",
	-- {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["Brewnall Village sits on the lake west of Kharanos. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "",
	-- {npc:1196} Ice Claw Bear
	["{npc:1196}, on the way to the Hold"] = "",
	-- {npc:1127} Elder Crag Boar
	["{npc:1127}, on the way"] = "",
	-- {npc:1201} Snow Leopard
	["{npc:1201}, on the way"] = "",

	-- Step 32: Frostmane Hold
	-- {quest:287} Frostmane Hold · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{quest:287} is the troll cave in the hills south-west of Brewnall Village. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "",

	-- Step 33: Gnomeregan: kill these as you meet them
	["Gnomeregan: kill these as you meet them"] = "",
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the Gnomeregan road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}: Gnomos Leprosos",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}: Gnomos Leprosos",

	-- Step 36: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the Barleybrew Scalder."] = "",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "O {object:269} no porão",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "",

	-- Step 37: Shimmerweed
	-- {item:2676} Shimmerweed
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on Shimmer Ridge, the snowy slope north of the road between Kharanos and Brewnall: climb from the road west of Kharanos. The Frostmane Seers camped on the ridge drop it too."] = "",

	-- Step 39: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {npc:1271} Old Icebeard
	["{npc:1266} camps in Chill Breeze Valley, south of the road back east from Brewnall to Kharanos. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "",

	-- Step 40: Kharanos
	["Back east through Kharanos: the class quests here wait for level 10."] = "",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}, na ferraria",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}: {npc:257597}, perto do Portão Sul, a recebe",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}: {npc:376} em {zone:1453} a recebe",

	-- Step 41: Steelgrill's Depot
	-- {zone:1426} Dun Morogh
	["Follow the road north-east from Kharanos to the depot: the whole east of {zone:1426} is one sweep from here."] = "",

	-- Step 42: Misty Pine Refuge
	["Misty Pine Refuge"] = "",
	["Follow the road east past the depot to Misty Pine Refuge."] = "",

	-- Step 43: Firewood
	["Firewood"] = "Lenha",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "A lenha está na neve em volta do lago congelado junto ao refúgio.",

	-- Step 45: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "",

	-- Step 46: Misty Pine Refuge: kill these as you meet them
	["Misty Pine Refuge: kill these as you meet them"] = "",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "",

	-- Step 48: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "O {item:286325} fica junto ao lago congelado, entre os elementais de gelo.",

	-- Step 51: Taming the Beast
	-- {item:15908} Taming Rod
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the Kharanos smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of Kharanos."] = "",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}: dome-o com o {item:15908}",
	-- {npc:1126} Large Crag Boar
	["Tame {npc:1126}"] = "",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}: dome-o com o {item:15908}",
	-- {npc:1201} Snow Leopard
	["Tame {npc:1201}"] = "",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}: dome-o com o {item:15908}",
	-- {npc:1196} Ice Claw Bear
	["Tame {npc:1196}"] = "",
	["Tame Beast"] = "",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "{npc:10090} em {zone:1455} a recebe",

	-- Step 54: Earthseer Farsen
	-- {object:149024} Gol'Bolar Quarry (no name in this language: may be words)
	["Farsen camps on the ridge overlooking the {object:149024} from the west. Talk to him for his farsight."] = "",

	-- Step 57: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, na pedreira",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}: só ferreiros",

	-- Step 58: The quarry troggs
	["The quarry troggs"] = "Os troggs da pedreira",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "",

	-- Step 60: Helm's Bed Lake
	["Helm's Bed Lake"] = "",
	-- {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by Helm's Bed Lake, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "",

	-- Step 61: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Leopardos da Neve e javalis vagam pela neve entre o rancho e a pedreira. Ferreiros: Barras de Cobre vêm da fundição de {item:2770} ou dos mercadores de profissão.",

	-- Step 65: Protecting the Herd
	-- {npc:1388} Vagash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: most classes solo it at level 14, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "",

	-- Step 66: Amberstill Ranch
	["Amberstill Ranch"] = "",
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "",

	-- Step 68: South Gate Outpost
	["South Gate Outpost"] = "",
	-- {zone:1432} Loch Modan
	["Follow the road all the way east to the South Gate Outpost at the {zone:1432} tunnel."] = "",

	-- Step 69: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["{npc:257597} waits in a cave above the farm north-west of the South Gate Outpost; the path up starts behind the farm."] = "",

	-- Step 71: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "",

	-- Step 72: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026} e a {item:6652}",
	-- {npc:257808} Braldir Ashmantle
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of Stonesplinter Valley, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the Silver Stream Mine at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}: Videntes Lascapedra",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}: Geomantes Ratatúnel",

	-- Step 73: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "A Pedra do Espírito de Fogo",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} lhe dá a {item:6636}. Suba ao pico acima do acampamento dele, beba a Sapta ao lado da Pedra Espiritual e derrote a {npc:5893}, depois coloque a {item:6655} dela no {object:61934}, no alto do Santuário da Chama Eterna.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, ao lado da Pedra Espiritual",

	-- Step 74: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "De volta a {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Volte pelo túnel até a caverna de {npc:257597} acima da fazenda.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {npc:2523}, seu {item:5176} e o {item:263412}",

	-- Step 75: North Gate Outpost
	["North Gate Outpost"] = "",
	-- {npc:1960} Pilot Hammerfoot
	["{npc:1960} waits at the North Gate Outpost, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "",

	-- Step 76: The tunnel post
	["The tunnel post"] = "",
	-- {zone:1432} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "",

	-- Step 77: Stonesplinter troggs
	["Stonesplinter troggs"] = "",
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth."] = "",

	-- Step 78: Back to the tunnel post
	["Back to the tunnel post"] = "",

	-- Step 79: Thelsamar
	["Thelsamar"] = "",
	-- {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to Thelsamar. {npc:1340} walks the road through town, {npc:1963} stands outside the Stoutlager Inn, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "",

	-- Step 80: The west hills and the Algaz Station
	["The west hills and the Algaz Station"] = "",
	-- {npc:1343} Mountaineer Stormpike
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the Algaz Station. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "",
	-- {item:3110} Tunnel Rat Ear
	["{item:3110}: Tunnel Rat kobolds"] = "",
	-- {item:3172} Boar Intestines
	-- plural, as words: Mountain Boars = {npc:1190} Mountain Boar
	["{item:3172}: Mountain Boars"] = "",
	-- {item:3173} Bear Meat
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear
	["{item:3173}: Elder Black Bears"] = "",
	-- {item:3174} Spider Ichor
	-- plural, as words: Forest Lurkers = {npc:1195} Forest Lurker
	["{item:3174}: Forest Lurkers"] = "",
	-- {npc:5413} Furen Longbeard · {zone:1453} Stormwind
	["{npc:5413} in {zone:1453} takes it"] = "",

	-- Step 81: Silver Stream Mine
	["Silver Stream Mine"] = "",
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats."] = "",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "",

	-- Step 82: Back to the Algaz Station
	["Back to the Algaz Station"] = "",

	-- Step 83: Thelsamar
	["South down the road to Thelsamar, finishing the ears, meat and ichor on the way."] = "",

	-- Step 84: Golnir Bouldertoe
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:4256} Golnir Bouldertoe · {npc:1573} Gryth Thurden
	["The gryphons land in the {object:32372}: {npc:4256} works at its north end, and {npc:1573} keeps the gryphons where you landed."] = "",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:4256}, in the {object:32372}"] = "",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "",

	-- Step 85: Tinker Town
	-- {object:32372} Great Forge (no name in this language: may be words) · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {object:171709} High Seat · {object:32359} Military Ward (no name in this language: may be words)
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, perto da caixa de correio na {object:171524}",

	-- Step 86: Forlorn Cavern
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}: {npc:6122} em {zone:1453} a recebe",

	-- Step 87: The Tome of Divinity
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, {npc:6179} and {npc:6178} on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "Do {quest:2997} que ela lhe dá",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "Use o {item:6866} em {npc:6177}",

	-- Step 88: Narm Faulk
	-- {zone:1455} Ironforge · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to Helm's Bed Lake. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Espiões Ferro Negro",

	-- Step 90: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}: Redenção",

	-- Step 91: Mystic Ward
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "",

	-- Step 92: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "",

	-- Step 93: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 94: Military Ward
	-- {object:32359} Military Ward (no name in this language: may be words) · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms (no name in this language: may be words)
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "",
	-- {npc:10090} Belia Thundergranite
	["{npc:10090}: Beast Training"] = "",

	-- Step 95: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 96: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn Two-Handed Maces from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 97: Druid trainer
	["Druid trainer"] = "",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "",

	-- Step 98: The Deeprun Tram
	["The Deeprun Tram"] = "",
	-- {object:171524} Tinker Town · {zone:1453} Stormwind
	["East back into {object:171524}: the Deeprun Tram leaves from its east end. Ride it to {zone:1453}."] = "",
	["Deeprun Tram"] = "",

	-- Step 99: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",
	-- {zone:1455} Ironforge · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the Deeprun Tram, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "",

	-- Step 100: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "",

	-- Step 101: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "",

	-- Step 102: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 103: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 104: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 105: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 106: Defensive Stance
	["Defensive Stance"] = "",
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "",
	-- {npc:6089} Harry Burlguard
	["{npc:6089}: Defensive Stance"] = "",

	-- Step 107: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 108: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "",

	-- Step 109: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 110: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} espera no porão do {object:2164}, no {object:2101}.",

	-- Step 112: Surena Caledon
	-- {zone:1453} Stormwind · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to Goldshire and east along the road to the Brackwell Pumpkin Patch. {npc:881} (level 9) stands by its farmhouse."] = "",

	-- Step 113: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. Goldshire and east Elwynn are next, then {zone:1436}."] = "",
	["Subdue the voidwalker"] = "Subjugue o emissário do caos",
	["Summon Voidwalker"] = "",

	-- Step 114: Goldshire
	["Goldshire"] = "",
	-- {zone:1453} Stormwind · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to Goldshire: east Elwynn comes before {zone:1436}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:77}"] = "De volta a {area:77}",
	-- ["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "De volta a {npc:257446} em {area:77}. Ele lhe dá a {item:6635}: pegue a trilha marcada por escombros que sobe para oeste a partir do sul do vale até a Pedra Espiritual na crista, beba a Sapta ao lado dela e fale com a {npc:5891}, depois leve o {item:6656} dela de volta a Teo.",
	-- ["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Rochetuscos e Ursos Pretos Jovens vagam pelos campos em volta de {area:131} e da garagem.",
	-- ["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "Cada missão de Grif Selvacuore lhe dá um {item:15908}: use-o na fera que ele indicar e depois leve o bastão de volta a ele na ferraria de {area:131}. Rochetuscos Grandes, Leopardos da Neve e Ursos Garra de Gelo vagam pelos campos logo ao sul e a leste de {area:131}.",
	-- ["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen acampa na crista que dá vista para a {area:134}, a oeste. Fale com ele para usar a vidência dele.",
	-- ["Follow the road east past the depot to {area:138}."] = "Siga a estrada para leste passando a garagem até o {area:138}.",
	-- ["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Siga a estrada para nordeste a partir de {area:131} até a garagem abaixo da estrada de {zone:1455}.",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Siga a estrada até {zone:1455} e treine com seu instrutor de classe. O {area:2257} sai da {object:171524}, no leste da cidade. Vá nele até {zone:1453}.",
	-- ["Inside {area:77}"] = "Dentro de {area:77}",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Saia de {zone:1453} pelo portão principal, vá para o sul até {area:87} e para leste pela estrada até a {area:62}. {npc:881} (nível 9) fica junto à casa da fazenda.",
	-- ["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "Gnomos Leprosos em volta da Aldeia da Cevada e da estrada de {area:133} levam as rodas dentadas e engrenagens. Ursos Garra de Gelo, Rochetuscos Anciões e Leopardos da Neve vagam pelas colinas em volta do lago.",
	-- ["Ragged Young Wolves roam the snow just south of {area:77}."] = "Lobos Jovens Rotos vagam pela neve logo ao sul de {area:77}.",
	-- ["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Batecrânios Pedraqueixo enchem a pedreira; Emboscadores Pedraqueixo junto ao {area:212} deixam cair o {item:268548}.",
	-- ["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "Troggs Pedraqueixo e Troggs Pedraqueixo Parrudos cavam por todo o fundo do vale ao sul de {area:77}.",
	-- ["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "Videntes Lascapedra (nível 13) ficam entre os troggs no sul do {area:923}, ao sul de {npc:257808}; Geomantes Ratatúnel (nível 12) trabalham na {area:149}, no extremo norte do lago. Os troggs vêm em bandos e alguns atacam à distância: atraia um de cada vez.",
	-- ["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "O Rabo-de-galo Escaldante dura cinco minutos: vá direto para o norte até {npc:836} dentro de {area:77}.",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "O metrô chega no {object:28027}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto da {object:2152} de lá. {npc:6090} luta com você pela caneca dele.",
	-- ["The {area:2257}"] = "O {area:2257}",
	-- ["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "Você começa diante de {area:77}, o salão de pedra no extremo norte do vale. {npc:658} espera do lado de fora da porta.",
	-- ["{area:131} and the depot"] = "{area:131} e a garagem",
	-- ["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}: com tempo, cinco minutos para chegar a {npc:836} em {area:77}",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}, na garagem",
	-- ["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965} guarda o túnel que sai do vale, a leste de {area:77}; {npc:6782} fica ao lado dele na entrada.",
	-- ["{npc:257446}, inside {area:77}"] = "{npc:257446}, dentro de {area:77}",
	-- ["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} espera numa caverna acima da fazenda a noroeste do {area:806}; a trilha começa atrás da fazenda.",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, o instrutor de xamã, ao norte da {object:32372}",
	-- ["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} fica com {npc:8416} junto à porta de {area:77}. O acampamento de Gozwin fica nas colinas logo a noroeste; o {npc:269075} ronda por ali.",
	-- ["{npc:460}, inside {area:77}"] = "{npc:460}, dentro de {area:77}",
	-- ["{zone:1455} class quests"] = "Missões de classe em {zone:1455}",
}
