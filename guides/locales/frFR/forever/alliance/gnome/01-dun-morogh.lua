-- French (frFR): the guide forever/alliance/gnome/01-dun-morogh (forever/alliance/gnome/01-dun-morogh.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {area:77} Anvilmar · {npc:658} Sten Stoutarm
	["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "Vous commencez devant {area:77}, la salle de pierre au nord de la vallée. {npc:658} attend devant la porte.",

	-- Step 2: Young wolves
	["Young wolves"] = "Jeunes loups",
	-- {area:77} Anvilmar
	["Ragged Young Wolves roam the snow just south of {area:77}."] = "Les Jeunes loups décharnés rôdent dans la neige juste au sud de {area:77}.",

	-- Step 3: Anvilmar
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, à côté de {npc:658}",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}, le maître des guerriers",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, le maître des voleurs",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, le maître des prêtres",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, le maître des mages, à l'intérieur de {area:77}",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, à l'intérieur de {area:77}",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "À l'intérieur de {area:77}",

	-- Step 4: The troggs
	["The troggs"] = "Les troggs",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "Les Troggs Mâcheroc et les Troggs Mâcheroc forcenés creusent partout dans le fond de la vallée, au sud de {area:77}.",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "Retour à {area:77}",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}; inside"] = "{npc:8416}, près de la porte de {area:77} ; à l'intérieur",

	-- Step 6: Talin Keeneye
	-- {npc:714} Talin Keeneye · {item:10438} Felix's Box
	["{npc:714}'s camp is at the west end of the valley. {item:10438} lies in the snow south of it, his Chest by the troll cave and his Bucket of Bolts east of the cave: grab them as you pass."] = "Le camp de {npc:714} est à l'extrémité ouest de la vallée. {item:10438} est dans la neige au sud du camp, le Coffre de Felix près de la grotte des trolls et le Seau de boulons de Felix à l'est de la grotte : ramassez-les en passant.",

	-- Step 7: The boars
	["The boars"] = "Les sangliers",
	-- {npc:714} Talin Keeneye
	-- plural, as words: Small Crag Boars = {npc:708} Small Crag Boar
	["Small Crag Boars graze around {npc:714}'s camp and along the west side of the valley."] = "Les Petits sangliers des rochers paissent autour du camp de {npc:714} et le long du côté ouest de la vallée.",

	-- Step 9: Grelin Whitebeard
	-- {npc:786} Grelin Whitebeard · {npc:12738} Nori Pridedrift
	["{npc:786} and {npc:12738} camp at the south-west edge of the valley, below the troll cave."] = "{npc:786} et {npc:12738} campent au bord sud-ouest de la vallée, sous la grotte des trolls.",

	-- Step 10: Coldridge Valley: kill these as you meet them
	-- {area:132} Coldridge Valley
	["{area:132}: kill these as you meet them"] = "{area:132} : tuez-les au passage",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "Des Jeunes trolls Frostmane ({npc:706}) peuplent les pentes au sud et à l'est du camp de {npc:786}.",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "Charmes de plume, sur les Novices Frostmane",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738} : chronométrée, cinq minutes pour rejoindre {npc:836} à {area:77}",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "Le Thé brûlant de Durnan dure cinq minutes : allez droit au nord jusqu'à {npc:836}, à l'intérieur de {area:77}.",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:836}, inside {area:77}; below ground"] = "{npc:836}, dans {area:77} ; sous terre",
	["Level 4 spells, before Gozwin's camp"] = "Sorts du niveau 4, avant le camp de Gozwin",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}, à l'intérieur de {area:77}",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "{npc:8416}, à la porte en sortant ; à l'intérieur",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} se tient près de {npc:8416} à la porte de {area:77}. Le camp de Gozwin est dans les collines juste au nord-ouest ; {npc:269075} rôde autour.",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "{npc:2756}, à l'intérieur",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, dans le camp",
	["The troll cave"] = "La grotte des trolls",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} est à l'intérieur de la grotte des trolls à l'est du camp de {npc:786}, pas sur la colline au-dessus : entrez par l'ouverture et suivez le tunnel jusqu'au fond.",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "{item:2004} ; sous terre",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}, à côté de lui",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "Pendentifs d'ours griffeglace ({item:264356}), sur les Jeunes trolls Frostmane ({npc:706}) des pentes au-dessus du camp",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "Retournez voir {npc:257446} à {area:77}. Il vous donne {item:6635} : prenez le chemin bordé d'éboulis qui monte vers l'ouest depuis le sud de la vallée jusqu'à la Pierre de l'esprit sur la crête, buvez le Sapta à côté et parlez à {npc:5891}, puis rapportez son {item:6656} à Teo.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, à côté de la Pierre de l'esprit",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446} : {npc:5873} et votre {item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "Le tunnel",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965} garde le tunnel qui sort de la vallée, à l'est de {area:77} ; {npc:6782} se tient à côté de lui, à l'entrée.",

	-- Step 18: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "Asseyez-vous près du feu de camp d'Eric (tapez /asseoir) et attendez l'amélioration.",

	-- Step 19: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Follow the road through the tunnel and north-east to {area:131}. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}.\n{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "Suivez la route à travers le tunnel puis vers le nord-est jusqu'à {area:131}. Commencez dehors : {npc:1252} et le feu de camp d'Eric sont devant la {area:2102}.\n{npc:1872} travaille à la forge à l'ouest de la brasserie.\nEntrez ensuite : {npc:6806}, l'aubergiste, {npc:1226} et {npc:1267}. La leçon de {skill:185} de {npc:1699} attend le retour avec les côtes, quand vous aurez le cuivre nécessaire.",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "{npc:1241}, sous terre",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "{npc:6806}, à l'intérieur",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "{npc:1226}, à l'étage",
	["Last: some classes' trainers stand outside"] = "Pour finir : les maîtres de certaines classes se tiennent dehors",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Suivez la route vers le nord-est depuis {area:131} jusqu'au dépôt, sous la route de {zone:1455}.",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "{npc:1694}, à côté de lui",

	-- Step 21: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}."] = "La {object:176785} se trouve à côté de {npc:271546}, au sud de la {area:136}.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850} : {object:176785}",

	-- Step 22: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "Gretchen campe juste devant la {area:136}, la grotte des wendigos au sud-ouest de {area:131}.",

	-- Step 23: The Grizzled Den
	-- {npc:278166} Mountaineer Cornelius
	["Flintfire's shipments lie on the cave floor, and {npc:278166} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "",

	-- Step 25: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "{npc:1243} campe au sud-ouest, près de la route vers les Frigères.",

	-- Step 26: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "{zone:1426} : tuez-les au passage",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "",

	-- Step 27: Kharanos
	-- {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1241} Tognus Flintfire
	["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it."] = "",

	-- Step 28: Thunderbrew Distillery
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "Tuez les Sangliers des rochers en chemin : leurs côtes tombent avant que vous ayez la quête de {npc:1267} et comptent pour elle. De retour à la brasserie : {npc:1699} enseigne la {skill:185}, puis les côtes vont à {npc:1267}.",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "{item:2894}, auprès de {npc:1247} ; à l'étage",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "{npc:1699} : Camping 101 vous demande de l'apprendre ; sous terre",
	["Upstairs"] = "À l'étage",

	-- Step 29: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131} et le dépôt",
	-- {npc:1269} Razzle Sprysprocket · {area:131} Kharanos
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "",

	-- Step 30: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "{area:137} se trouve au bord du lac, à l'ouest de {area:131}. Le quai de {npc:8508} est le premier arrêt ; {npc:1374} et {npc:1375} sont dans le village au-delà.",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "{npc:8508}, sur le quai",
	-- {npc:1196} Ice Claw Bear
	["{npc:1196}, on the way to the Hold"] = "{npc:1196}, en chemin vers le Fort",
	-- {npc:1127} Elder Crag Boar
	["{npc:1127}, on the way"] = "{npc:1127}, en chemin",
	-- {npc:1201} Snow Leopard
	["{npc:1201}, on the way"] = "{npc:1201}, en chemin",

	-- Step 31: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135} est la grotte des trolls dans les collines au sud-ouest de {area:137}. Les Ours Griffeglace, les Anciens sangliers des rochers et les Léopards des neiges que vous tuez en chemin comptent pour {npc:1374}. Tuez les chasseurs de têtes à l'entrée et traversez la grotte jusqu'au fond.",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "{npc:1123}, sous terre",

	-- Step 32: Gnomeregan: kill these as you meet them
	-- {area:133} Gnomeregan
	["{area:133}: kill these as you meet them"] = "{area:133} : tuez-les au passage",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "Les Gnomes lépreux autour de Brassetout et de la route de {area:133} portent les rouages et les engrenages. Les Ours Griffeglace, les Anciens sangliers des rochers et les Léopards des neiges parcourent les collines autour du lac.",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083} : Gnomes lépreux",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084} : Gnomes lépreux",

	-- Step 35: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373} garde les tonneaux de {item:2686} dans la cave de la brasserie. Achetez une {item:2686} à {npc:1247}, cliquez sur le tonneau gardé, puis remettez la bière à {npc:1373} depuis sa fenêtre de quête (il n'y a pas de quête à accepter) ; ensuite, le tonneau non gardé reçoit l'{spell:8553}.",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "{npc:1252} : {npc:1274}, à {zone:1455}, la prend",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "{item:2686}, auprès de {npc:1247} dans la brasserie ; à l'étage",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "{object:269}, au sous-sol",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "{npc:1373}, à côté du tonneau ; sous terre",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "Le {object:270} dans la brasserie ; sous terre",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "{npc:1269}, sous terre",

	-- Step 36: Shimmerweed
	-- {item:2676} Shimmerweed · {area:802} Shimmer Ridge · {area:131} Kharanos
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on {area:802}, the snowy slope north of the road between {area:131} and Brewnall: climb from the road west of {area:131}. The Frostmane Seers camped on the ridge drop it too."] = "L'{item:2676} pousse dans des paniers sur la {area:802}, la pente enneigée au nord de la route entre {area:131} et Brassetout : grimpez depuis la route à l'ouest de {area:131}. Les Prophètes Frostmane installés sur la crête en laissent aussi tomber.",

	-- Step 38: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {area:131} Kharanos · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of the road back east from Brewnall to {area:131}. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "{npc:1266} campe dans la {area:801}, au sud de la route qui revient vers l'est de Brassetout à {area:131}. Ses viandes sont dans le garde-manger de la grotte de {npc:1271}, à l'est de son camp. {npc:1271} est un yéti élite : attendez hors de vue qu'il parte en patrouille, puis prenez les viandes et repartez avant son retour. Inutile de le combattre.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "{item:2667} : le garde-manger ; sous terre",

	-- Step 39: Kharanos
	-- {area:131} Kharanos
	["Back east through {area:131}: the class quests here wait for level 10."] = "Retournez vers l'est en passant par {area:131} : les quêtes de classe ici attendent le niveau 10.",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113} : à rendre à {npc:257597}, près de la porte Sud",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226} : à rendre à {npc:258785}, à {zone:1455}",

	-- Step 40: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1426} Dun Morogh
	["Follow the road north-east from {area:131} to the depot: the whole east of {zone:1426} is one sweep from here."] = "Suivez la route vers le nord-est depuis {area:131} jusqu'au dépôt : tout l'est de {zone:1426} se fait d'une traite à partir d'ici.",

	-- Step 41: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "Suivez la route vers l'est après le dépôt jusqu'au {area:138}.",

	-- Step 42: Firewood
	["Firewood"] = "Bois de chauffage",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "Le bois de chauffage est dans la neige autour du lac gelé, près du refuge.",

	-- Step 44: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "{npc:276003} en chemin",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "{npc:276003} sur le chemin de {npc:1253}",

	-- Step 45: Misty Pine Refuge: kill these as you meet them
	-- {area:138} Misty Pine Refuge
	["{area:138}: kill these as you meet them"] = "{area:138} : tuez-les au passage",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "Les trois fusils reposent dans la neige autour du lac gelé près du refuge. Des Élémentaires de glace mineurs dérivent autour du lac et le long du chemin : tuez-les en passant pour {quest:99160}.\nAchevez les Élémentaires de glace mineurs autour du petit lac juste à l'ouest du refuge s'il vous en manque encore.",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "{npc:276003}, autour du petit lac",

	-- Step 47: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325} est près du lac gelé, parmi les élémentaires de glace.",

	-- Step 52: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen campe sur la crête qui domine la {area:134} à l'ouest. Parlez-lui pour sa vision lointaine.",

	-- Step 55: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "La carrière se trouve juste à l'est de la crête de Farsen.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, dans la carrière",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698} : forgerons uniquement",

	-- Step 56: The quarry troggs
	["The quarry troggs"] = "Les troggs de la carrière",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "",

	-- Step 58: Helm's Bed Lake
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "",

	-- Step 59: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Les Léopards des neiges et les sangliers parcourent la neige entre la ferme et la carrière. Forgerons : les Barres de cuivre s'obtiennent en fondant du {item:2770} ou auprès des marchands d'artisanat.",

	-- Step 62: Protecting the Herd
	-- {npc:1388} Vagash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: most classes solo it at level 14, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:1388} est un élite de niveau 12 : la plupart des classes le battent seules au niveau 14, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",
	["Below ground"] = "Sous terre",

	-- Step 63: Rudra Amberstill
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "Sur la route du retour vers l'ouest, vers {zone:1455}.",

	-- Step 66: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "Suivez la route jusqu'au bout vers l'est, jusqu'à l'{area:806} au tunnel du {zone:1432}.",

	-- Step 67: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} attend dans une grotte au-dessus de la ferme au nord-ouest de l'{area:806} ; le chemin qui y monte part de derrière la ferme.",

	-- Step 69: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "Passez le tunnel pour entrer dans le {zone:1432}. Juste après, un chemin marqué de pierres grimpe dans les collines à droite de la route, vers le nord, jusqu'au camp de {npc:257808}.",

	-- Step 70: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026} et {item:6652}",
	-- {area:923} Stonesplinter Valley · {npc:257808} Braldir Ashmantle · {area:149} Silver Stream Mine
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "Les Prophètes Brisepierre (niveau 13) se tiennent parmi les troggs au sud de {area:923}, au sud de {npc:257808} ; les Géomanciens Rat des tunnels (niveau 12) travaillent dans {area:149}, au nord du loch. Les troggs vont en groupes et certains attaquent à distance : attirez-les un par un.",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652} : Prophètes Brisepierre",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026} : Géomanciens Rat des tunnels",

	-- Step 71: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "La pierre de l'esprit du feu",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} vous donne {item:6636}. Montez au sommet au-dessus de son camp, buvez le Sapta à côté de la Pierre de l'esprit et vainquez {npc:5893}, puis placez son {item:6655} dans {object:61934}, au sommet de l'autel de la Flamme éternelle.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, à côté de la Pierre de l'esprit",

	-- Step 72: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "Retour auprès de {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Repassez le tunnel jusqu'à la grotte de {npc:257597}, au-dessus de la ferme.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597} : {npc:2523}, votre {item:5176} et {item:263412}",

	-- Step 73: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960} attend à l'{area:808}, au nord de la porte Sud ; le cadavre du nain se trouve en haut du col, à l'ouest de lui.",

	-- Step 74: The tunnel post
	["The tunnel post"] = "",
	-- {zone:1432} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "",

	-- Step 75: Stonesplinter troggs
	["Stonesplinter troggs"] = "",
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth."] = "",

	-- Step 76: Back to the tunnel post
	["Back to the tunnel post"] = "",

	-- Step 77: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {area:2101} Stoutlager Inn · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to {area:144}. {npc:1340} walks the road through town, {npc:1963} stands outside the {area:2101}, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "{npc:1572}, le maître des griffons",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "",

	-- Step 78: The west hills and the Algaz Station
	-- {area:925} Algaz Station
	["The west hills and the {area:925}"] = "",
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the {area:925}. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "",
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

	-- Step 79: Silver Stream Mine
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats."] = "",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "",

	-- Step 80: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "",

	-- Step 81: Thelsamar
	-- {area:144} Thelsamar
	["South down the road to {area:144}, finishing the ears, meat and ichor on the way."] = "",

	-- Step 82: Golnir Bouldertoe
	-- {object:32372} Great Forge · {npc:4256} Golnir Bouldertoe · {npc:1573} Gryth Thurden
	["The gryphons land in the {object:32372}: {npc:4256} works at its north end, and {npc:1573} keeps the gryphons where you landed."] = "",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge
	["{npc:4256}, in the {object:32372}"] = "{npc:4256}, à la {object:32372}",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "{npc:1573}, le maître des griffons là où vous avez atterri",

	-- Step 83: Tinker Town
	-- {object:32372} Great Forge · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {object:171709} High Seat · {object:32359} Military Ward
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, près de la boîte aux lettres de {object:171524}",

	-- Step 84: Forlorn Cavern
	-- {object:32372} Great Forge · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120} : à rendre à {npc:6122}, à {zone:1453}",

	-- Step 85: The Tome of Divinity
	-- {item:6775} Tome of Divinity
	["The {item:6775}"] = "{item:6775}",
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, Tiza and Muiredon on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "",

	-- Step 86: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "Ressortez de {zone:1455} et suivez la route vers l'est jusqu'au {area:212}. {npc:6177} gît, mort, sur sa rive : utilisez le {item:6866} sur lui. Les Espions Sombrefer qui se faufilent autour du lac portent le texte.",

	-- Step 88: Mystic Ward
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "",

	-- Step 89: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "{npc:1274}, au {object:171709} avec le roi Magni",

	-- Step 90: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",

	-- Step 91: Military Ward
	-- {object:32359} Military Ward · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms (no name in this language: may be words)
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "",

	-- Step 92: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:197} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 93: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:199} auprès de {npc:11865} ({object:32359}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 94: Druid trainer
	["Druid trainer"] = "Maître des druides",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "",

	-- Step 95: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {object:171524} Tinker Town · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["East back into {object:171524}: the {area:2257} leaves from its east end. Ride it to {zone:1453}."] = "",

	-- Step 96: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "",
	-- {npc:13016} Deeprun Rat
	["Catch {npc:13016}"] = "",

	-- Step 97: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "",

	-- Step 98: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "",

	-- Step 99: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 100: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",

	-- Step 101: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 102: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Pendant que vous y êtes : apprenez le maniement des épées auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; une épée en main droite fait progresser un Voleur régulièrement.",

	-- Step 103: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "",

	-- Step 104: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 105: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} attend dans la cave de {object:2164}, dans {object:2101}.",

	-- Step 106: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Pendant que vous y êtes : apprenez le maniement des bâtons auprès de {npc:11867} ({object:2096}, 10 pièces d'argent) ; un bâton apporte plus de caractéristiques de sorts qu'une arme à une main pendant la progression.",

	-- Step 107: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Quittez {zone:1453} par la grande porte, allez au sud jusqu'à {area:87} puis à l'est par la route jusqu'au {area:62}. {npc:881} (niveau 9) se tient près de la ferme.",

	-- Step 108: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {area:87} Goldshire · {zone:1436} Westfall
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {area:87} and east Elwynn are next, then {zone:1436}."] = "",
	["Subdue the voidwalker"] = "Soumettez le marcheur du Vide",

	-- Step 109: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} se tient dans le Sanctum des sorciers, la tour de {object:2101} ; elle vous donne une flasque pour la cascade de {quest:1861}.",

	-- Step 110: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Quittez {zone:1453} par la porte principale. La cascade du {quest:1861} se trouve au sud-ouest des portes, sur le chemin de la {zone:1436} à l'ouest : remplissez la {item:7207} à son pied.",

	-- Step 111: Goldshire
	-- {zone:1453} Stormwind · {area:87} Goldshire · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to {area:87}: east Elwynn comes before {zone:1436}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {area:40} is next, west of {area:87}."] = "Retournez voir {npc:6122}. Utilisez le {item:6928} au cercle d'invocation dans la cave de l'{object:2164} et vainquez le marcheur du Vide qu'il appelle. La {area:40} est la suite, à l'ouest de {area:87}.",
	-- ["Class trainer"] = "Maître de classe",
	-- ["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Les Sangliers des rochers et les Jeunes ours noirs parcourent les champs autour de {area:131} et du dépôt.",
	-- ["Defensive Stance"] = "Posture défensive",
	-- ["Flintfire's shipments lie on the cave floor, and {object:460004} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "Les cargaisons de Tognus reposent sur le sol de la grotte, et le Montagnard Cornelius a disparu quelque part à l'intérieur.\nAttention : les wendigos se tiennent serrés dans la grotte, les combats en attirent donc facilement plusieurs à la fois ; les attirer un par un avec des attaques à distance depuis l'extérieur évite ce problème.",
	-- ["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, Tiza and Muiredon on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {area:1} drop it, and the Auction House sells it."] = "Suivez la route jusqu'à {zone:1455} et prenez la {object:32362} : {npc:5149}, {npc:6179} et {npc:6178} sont dans la Salle des Mystères, Tiza et Muiredon à son étage : l'escalier commence juste au nord-est de {npc:5149}. {npc:6175}, un mendiant, erre dans la ville. Il demande dix {item:2589} : les troggs et les trolls de {area:1} en laissent tomber, et l'hôtel des ventes en vend.",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Suivez la route jusqu'à {zone:1455} et allez voir votre maître de classe. {area:2257} part de {object:171524}, à l'est de la ville. Prenez-le jusqu'à {zone:1453}.",
	-- ["Hearth to {area:2102}"] = "Pierre de foyer vers la {area:2102}",
	-- ["If you skipped {quest:314}, grind here to level 11.41 to stay on the route's plan."] = "Si vous avez passé {quest:314}, tuez des monstres ici jusqu'au niveau 11.41 pour suivre le plan de l'itinéraire.",
	-- ["Inn and flight master"] = "Auberge et maître de vol",
	-- ["Instead of walking back up to {area:1537}, go east through the South Gate tunnel into {area:38} and follow the road north to {area:144}. {npc:1681} stands on the east side of town, past the {area:2101}; his errand pays for a flight back to {area:1537}."] = "Au lieu de remonter à pied jusqu'à {area:1537}, passez à l'est par le tunnel de la porte Sud pour entrer dans le {area:38} et suivez la route vers le nord jusqu'à {area:144}. {npc:1681} se tient du côté est de la ville, après l'{area:2101} ; sa course vous paie un vol de retour vers {area:1537}.",
	-- ["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {area:40}: fill {item:7207} at its base."] = "Sortez de {zone:1453} par la porte principale. La cascade du {quest:1861} se trouve au sud-ouest des portes, sur le chemin vers l'ouest et la {area:40} : remplissez la {item:7207} à son pied.",
	-- ["Level 11.41"] = "Niveau 11.41",
	-- ["On the way"] = "En chemin",
	-- ["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Rockjaw Bonesnappers prowl the quarry and the lake; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "Les Embusqués Mâcheroc près du {area:212}, au nord de la carrière, et les Brise-dos Mâcheroc plus à l'est laissent tomber la {quest:95214}. Les Briseurs d'os Mâcheroc rôdent dans la carrière et autour du lac ; des Espions Sombrefer se faufilent sur la rive du lac. Un espion laisse tomber la {item:274268}.",
	-- ["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Les Brise-crâne Mâcheroc remplissent la carrière ; les Embusqués Mâcheroc près du {area:212} laissent tomber {item:268548}.",
	-- ["Summon Voidwalker"] = "Invocation d'un marcheur du Vide",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Le tram arrive dans {object:28027}. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} s'y tiennent ensemble près de {object:2152}. {npc:6090} vous affronte pour sa chope.",
	-- ["grind on {npc:260157}"] = "tuez en boucle : {npc:260157}",
	-- ["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090} est dans la Salle des Armes, {npc:258785} dans la Salle des Mystères, {npc:6120} dans la {object:32383}.",
	-- ["{npc:1117} along the way to {area:134}"] = "{npc:1117} sur le chemin de {area:134}",
	-- ["{npc:1117} on the way"] = "{npc:1117} en chemin",
	-- ["{npc:1127}, on the way"] = "{npc:1127}, en chemin",
	-- ["{npc:1201}, on the way"] = "{npc:1201}, en chemin",
	-- ["{npc:1269}, by the depot; below ground"] = "{npc:1269}, près du dépôt ; sous terre",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}, au dépôt",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, le maître des chamans, au nord de {object:32372}",
	-- ["{npc:270459} in {zone:1416}; {area:1} has no druid trainer"] = "{npc:270459} dans {zone:1416} ; {area:1} n'a pas de maître des druides",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089} : Posture défensive",
	-- ["{npc:706} along the way to {npc:786}"] = "{npc:706} sur le chemin de {npc:786}",
	-- ["{npc:706} on the way"] = "{npc:706} en chemin",
	-- ["{zone:1455} class quests"] = "Quêtes de classe de {zone:1455}",
}
