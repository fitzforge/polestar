-- French (frFR): the guide forever/alliance/dwarf-gnome/01-dun-morogh (forever/alliance/dwarf-gnome/01-dun-morogh.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}, le maître des guerriers",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}, le maître des paladins",
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658} : une rune pour {npc:895}",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}, le maître des chasseurs",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}, le maître des voleurs",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}, le maître des prêtres",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658} : lisez {quest:98581}",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}, à l'intérieur de {area:77}",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}, le maître des mages, à l'intérieur de {area:77}",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}, à l'intérieur de {area:77}",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}, à côté de {npc:658}",
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
	["A few more troggs outside if you are short"] = "Encore quelques troggs dehors s'il vous en manque",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}"] = "{npc:8416}, près de la porte de {area:77}",

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
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["A few Frostmane Troll Whelps if you are short"] = "Quelques Jeunes trolls Frostmane ({npc:706}) s'il vous en manque",

	-- Step 10: The troll cave
	["The troll cave"] = "La grotte des trolls",
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
	["{npc:836}, inside {area:77}"] = "{npc:836}, à l'intérieur de {area:77}",
	["Level 4 spells, before Gozwin's camp"] = "Sorts du niveau 4, avant le camp de Gozwin",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756} se tient près de {npc:8416} à la porte de {area:77}. Le camp de Gozwin est dans les collines juste au nord-ouest ; {npc:269075} rôde autour.",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}, dans le camp",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808} est à l'intérieur de la grotte des trolls à l'est du camp de {npc:786}, pas sur la colline au-dessus : entrez par l'ouverture et suivez le tunnel jusqu'au fond.",

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

	-- Step 18: Kharanos
	-- {area:131} Kharanos · {npc:1267} Ragnar Thunderbrew · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1872} Tharek Blackstone
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. {npc:1252}, Eric and his campfire are outside the {area:2102}. {npc:6806}, {npc:1226} and {npc:1267} are inside. {npc:1872} works the forge."] = "Suivez la route à travers le tunnel puis vers le nord-est jusqu'à {area:131}. Tuez les Sangliers des rochers en chemin : leurs côtes tombent avant que vous ayez la quête de {npc:1267} et comptent pour elle. {npc:1252}, Eric et son feu de camp sont devant {area:2102}. {npc:6806}, {npc:1226} et {npc:1267} sont à l'intérieur. {npc:1872} travaille à la forge.",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the distillery"] = "{npc:6806}, dans la distillerie",
	-- {npc:1226} Maxan Anvol · {npc:6806} Tannok Frosthammer
	["{npc:1226}, next to {npc:6806}"] = "{npc:1226}, à côté de {npc:6806}",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}"] = "{item:2894}, auprès de {npc:1247}",

	-- Step 19: The Great Outdoors
	-- {npc:1699} Gremlock Pilsnor
	["Sit by Eric's campfire (type /sit) and wait for the buff, then {npc:1699} in the distillery teaches you cooking."] = "Asseyez-vous près du feu de camp d'Eric (tapez /asseoir) et attendez l'amélioration, puis {npc:1699}, dans la distillerie, vous apprend la cuisine.",
	-- {npc:1699} Gremlock Pilsnor
	["Speak with {npc:1699}"] = "Parlez à {npc:1699}",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "Suivez la route vers le nord-est depuis {area:131} jusqu'au dépôt, sous la route de {zone:1455}.",

	-- Step 21: Boars and bears
	["Boars and bears"] = "Sangliers et ours",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "Les Sangliers des rochers et les Jeunes ours noirs parcourent les champs autour de {area:131} et du dépôt.",

	-- Step 24: The Grizzled Den
	-- {quest:313} The Grizzled Den · {area:131} Kharanos
	["{quest:313} is the wendigo cave south-west of {area:131}. Flintfire's shipments lie on the cave floor."] = "{quest:313} est la grotte des wendigos au sud-ouest de {area:131}. Les Cargaisons de Flammesilex sont au sol dans la grotte.",

	-- Step 26: Mountaineer Cornelius
	-- {area:136} Grizzled Den
	["Cornelius is missing in the {area:136}: find him inside, then go back to Gretchen."] = "Cornelius a disparu dans {area:136} : trouvez-le à l'intérieur, puis retournez voir Gretchen.",

	-- Step 28: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131} et le dépôt",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, at the depot"] = "{npc:1377}, au dépôt",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, by the depot"] = "{npc:1269}, près du dépôt",

	-- Step 29: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den · {npc:1243} Hegnar Rumbleshot
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}; {npc:1243} camps south-west of it, by the road to Coldridge."] = "{object:176785} se trouve à côté de {npc:271546}, au sud de {area:136} ; {npc:1243} campe au sud-ouest, près de la route de la Vallée des Frigères.",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850} : {object:176785}",

	-- Step 30: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village
	["{area:135} is the troll cave in the hills west of {area:137}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135} est la grotte des trolls dans les collines à l'ouest de {area:137}. Tuez les Chasseurs de têtes Frostmane à l'entrée et traversez-la jusqu'au fond.",

	-- Step 31: Brewnall Village
	-- {area:137} Brewnall Village · {area:135} Frostmane Hold
	["{area:137} sits on the lake north-west of {area:135}."] = "{area:137} se trouve au bord du lac, au nord-ouest de {area:135}.",

	-- Step 32: Gnomes, bears and leopards
	["Gnomes, bears and leopards"] = "Gnomes, ours et léopards",
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
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373} garde les tonneaux de {item:2686} au sous-sol de la distillerie. Achetez une {item:2686} à {npc:1247}, cliquez sur le tonneau gardé, puis donnez la bière à {npc:1373} depuis sa fenêtre de quête (il n'y a pas de quête à accepter) ; ensuite, le tonneau non gardé accepte le {spell:8553}.",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery"] = "{item:2686}, auprès de {npc:1247} dans la distillerie",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "{object:269}, au sous-sol",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel"] = "{npc:1373}, à côté du tonneau",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery"] = "{object:270}, dans la distillerie",

	-- Step 37: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "Suivez la route vers l'est après le dépôt jusqu'au {area:138}.",

	-- Step 38: Firewood
	["Firewood"] = "Bois de chauffage",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "Le bois de chauffage est dans la neige autour du lac gelé, près du refuge.",

	-- Step 40: The cold
	["The cold"] = "Le froid",
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["Minor Ice Elementals drift around the frozen lake by the refuge. The three rifles are in the snow around it."] = "Les Elémentaires de glace mineurs dérivent autour du lac gelé près du refuge. Les trois fusils sont dans la neige autour.",

	-- Step 42: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325} est près du lac gelé, parmi les élémentaires de glace.",

	-- Step 45: Gol'Bolar Quarry
	["The quarry lies south-east of the ranch."] = "La carrière se trouve au sud-est de la ferme.",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698} : forgerons uniquement",

	-- Step 46: The quarry troggs
	["The quarry troggs"] = "Les troggs de la carrière",
	-- {area:212} Helm's Bed Lake · {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper · Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher
	["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "Les Brise-crâne Mâcheroc remplissent la carrière ; les Embusqués Mâcheroc près du {area:212} laissent tomber {item:268548}.",

	-- Step 47: Foreman Stonebrow and Quarrymaster Thesten
	-- {npc:1254} Foreman Stonebrow · {npc:1256} Quarrymaster Thesten
	["{npc:1254} and {npc:1256}"] = "{npc:1254} et {npc:1256}",

	-- Step 48: Stolen Blasting Powder
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}."] = "Les Embusqués Mâcheroc près du {area:212}, au nord de la carrière, et les Brise-dos Mâcheroc plus à l'est laissent tomber {quest:95214}.",

	-- Step 49: Leopards and boars
	["Leopards and boars"] = "Léopards et sangliers",
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Blacksmiths = {area:3421} Blacksmith · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "Les Léopards des neiges et les sangliers parcourent la neige entre la ferme et la carrière. Forgerons : les Barres de cuivre s'obtiennent en fondant du {item:2770} ou auprès des marchands d'artisanat.",

	-- Step 52: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960} attend à {area:808} ; le cadavre du nain est en haut du col, à l'ouest de lui.",

	-- Step 53: Hearth to Kharanos
	-- {area:131} Kharanos
	["Hearth to {area:131}"] = "Pierre de foyer vers {area:131}",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}, à la forge",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113} : à rendre à {npc:257597}, près de la porte Sud",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226} : à rendre à {npc:376}, à {zone:1453}",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226} : à rendre à {npc:258785}, à {zone:1455}",

	-- Step 54: Taming the Beast
	-- {item:15908} Taming Rod · {area:131} Kharanos
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "Chaque quête de Grif Wildheart vous donne un {item:15908} : utilisez-le sur la bête qu'il désigne, puis rapportez-lui le bâtonnet à la forge de {area:131}. Les Grands sangliers des rochers, les Léopards des neiges et les Ours Griffeglace parcourent tous les champs juste au sud et à l'est de {area:131}.",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126} : apprivoisez-le avec le {item:15908}",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201} : apprivoisez-le avec le {item:15908}",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196} : apprivoisez-le avec le {item:15908}",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "À rendre à {npc:10090}, à {zone:1455}",

	-- Step 55: Shimmerweed
	-- {item:2676} Shimmerweed · {area:137} Brewnall Village
	["{item:2676} bushes grow on the hills around {area:137}."] = "Des buissons de {item:2676} poussent sur les collines autour de {area:137}.",

	-- Step 58: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "Suivez la route tout à l'est jusqu'à l'{area:806}, au tunnel du {zone:1432}.",

	-- Step 59: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597} attend dans une grotte au-dessus de la ferme au nord-ouest de l'{area:806} ; le chemin qui y monte part de derrière la ferme.",

	-- Step 60: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "Traversez le tunnel jusqu'au {zone:1432}. Juste après, un chemin balisé de pierres grimpe dans les collines à droite de la route, vers le nord, jusqu'au camp de {npc:257808}.",

	-- Step 61: Fire Tar and the Reagent Pouch
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

	-- Step 62: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "La pierre de l'esprit du feu",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808} vous donne {item:6636}. Montez au sommet au-dessus de son camp, buvez le Sapta à côté de la Pierre de l'esprit et vainquez {npc:5893}, puis placez son {item:6655} dans {object:61934}, au sommet de l'autel de la Flamme éternelle.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}, à côté de la Pierre de l'esprit",

	-- Step 63: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "Retour auprès de {npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "Repassez le tunnel jusqu'à la grotte de {npc:257597}, au-dessus de la ferme.",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597} : {npc:2523}, votre {item:5176} et {item:263412}",

	-- Step 64: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen campe sur la crête qui domine la {area:134} à l'ouest. Parlez-lui pour sa vision lointaine.",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}, dans la carrière",

	-- Step 65: Spies and Bonesnappers
	["Spies and Bonesnappers"] = "Espions et Briseurs d'os",
	-- {area:212} Helm's Bed Lake · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Bonesnappers = {npc:1117} Rockjaw Bonesnapper
	["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "Des Briseurs d'os Mâcheroc ({npc:1117}) rôdent dans la carrière et autour du {area:212} ; des Espions Sombrefer se faufilent le long de la rive du lac. Un espion lâche {item:274268}.",

	-- Step 68: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave to the north-east of his camp: grab them and leave quickly."] = "{npc:1266} campe dans {area:801}, au sud de Brassetout. Ses viandes sont dans le coffre de la grotte de {npc:1271}, au nord-est de son camp : prenez-les et repartez vite.",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker"] = "{item:2667} : le coffre à viande",

	-- Step 69: The Tome of Divinity
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "Suivez la route jusqu'à {zone:1455} et prenez {object:32362} : {npc:5149}, {npc:6179} et {npc:6178} sont dans {object:32386}. {npc:6175}, un mendiant, erre dans la ville. Il demande dix {item:2589} : les troggs et les trolls de {zone:1426} en laissent tomber, et l'Hôtel des ventes en vend.",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "Grâce à {quest:2997} qu'elle vous donne",

	-- Step 70: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "Ressortez d'{zone:1455} et suivez la route vers l'est jusqu'au {area:212}. {npc:6177} gît mort sur sa rive : utilisez {item:6866} sur lui. Les Espions Sombrefer qui rôdent autour du lac portent le manuscrit.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "Utilisez {item:6866} sur {npc:6177}",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847} : Espions Sombrefer",

	-- Step 71: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179} : Rédemption",

	-- Step 72: Ironforge class quests
	-- {zone:1455} Ironforge
	["{zone:1455} class quests"] = "Quêtes de classe de {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern
	["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090} est dans {object:32390}, {npc:258785} dans {object:32386}, {npc:6120} dans {object:32383}.",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120} : à rendre à {npc:6122}, à {zone:1453}",

	-- Step 73: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "Suivez la route jusqu'à {zone:1455} et allez voir votre maître de classe. {area:2257} part de {object:171524}, à l'est de la ville. Prenez-le jusqu'à {zone:1453}.",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}, près de la boîte aux lettres de {object:171524}",
	-- {npc:258098} Eldrun Stormbreaker · {object:32372} Great Forge
	["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}, le maître des chamans, au nord de {object:32372}",

	-- Step 74: Defensive Stance
	-- {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Le tram arrive dans {object:28027}. {npc:5480} entraîne les guerriers dans {object:2100} ; {npc:6089} et {npc:6090} s'y tiennent ensemble près de {object:2152}. {npc:6090} vous affronte pour sa chope.",

	-- Step 75: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376} est dans la Cathédrale de la Lumière.",

	-- Step 76: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122} attend dans la cave de {object:2164}, dans {object:2101}.",

	-- Step 77: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Quittez {zone:1453} par la grande porte, allez au sud jusqu'à {area:87} puis à l'est par la route jusqu'au {area:62}. {npc:881} (niveau 9) se tient près de la ferme.",

	-- Step 78: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall · {area:87} Goldshire
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "Retournez voir {npc:6122}. Utilisez {item:6928} sur le cercle d'invocation de la cave de {object:2164} et vainquez le marcheur du Vide qu'il appelle. Ensuite : {zone:1436}, à l'ouest de {area:87}.",
	["Subdue the voidwalker"] = "Soumettez le marcheur du Vide",

	-- Step 79: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497} se tient dans le Sanctum des sorciers, la tour de {object:2101} ; elle vous donne une flasque pour la cascade de {quest:1861}.",

	-- Step 80: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Quittez {zone:1453} par la grande porte. La cascade de {quest:1861} est au sud-ouest des portes, sur le chemin de {zone:1436} vers l'ouest : remplissez {item:7207} à son pied.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A few {npc:1120} Whelps if you are short"] = "Quelques Jeunes {npc:1120} s'il vous en manque",
	-- ["Braldir gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of {object:148418}."] = "Braldir vous donne {item:6636}. Montez au sommet au-dessus de son camp, buvez le Sapta à côté de la Pierre de l'esprit et vainquez {npc:5893}, puis placez son {item:6655} dans {object:61934}, au sommet de l'autel de {object:148418}.",
	-- ["Defensive Stance"] = "Posture défensive",
	-- ["Iceclaw Bear Pendants, from the {npc:1120} Whelps on the slopes above the camp"] = "Pendentifs d'ours Griffeglace, sur les Jeunes {npc:1120} des pentes au-dessus du camp",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "Quittez {zone:1453} par la grande porte, allez au sud jusqu'à {area:87} puis à l'est par la route jusqu'à {area:62}. {quest:1688} (niveau 9) se tient près de la ferme.",
	-- ["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The {object:147516} Spies sneaking around the lake carry the script."] = "Ressortez de {zone:1455} et suivez la route vers l'est jusqu'au {area:212}. {npc:6177} gît mort sur la rive : utilisez {item:6866} sur lui. Les Espions {object:147516} qui se faufilent autour du lac portent le texte.",
	-- ["Rockjaw Bonesnappers prowl the quarry and {area:212}; {object:147516} Spies sneak around the lake shore. One spy drops the {item:274268}."] = "Les Briseurs d'os Mâcheroc rôdent dans la carrière et autour du {area:212} ; les Espions {object:147516} se faufilent sur la rive du lac. Un espion laisse tomber {item:274268}.",
	-- ["Summon Voidwalker"] = "Invocation d'un marcheur du Vide",
	-- ["Tame Beast"] = "Apprivoiser une bête",
	-- ["The ammo crate sits in the Frostmane camp on {area:802}; {npc:1243} camps south of it, by the road to Coldridge."] = "La caisse de munitions se trouve dans le camp Frostmane sur {area:802} ; {npc:1243} campe au sud, près de la route de la Vallée des Frigères.",
	-- ["The {npc:5896} Stone"] = "La pierre de {npc:5896}",
	-- ["{item:6847}: {object:147516} Spies"] = "{item:6847} : Espions {object:147516}",
	-- ["{npc:10090}: Beast Training"] = "{npc:10090} : Dressage des bêtes",
	-- ["{npc:1120} Whelps fill the slopes south and east of Grelin's camp."] = "Les Jeunes {npc:1120} peuplent les pentes au sud et à l'est du camp de Grelin.",
	-- ["{npc:460}: Summon Imp"] = "{npc:460} : Invocation d'un diablotin",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089} : Posture défensive",
}
