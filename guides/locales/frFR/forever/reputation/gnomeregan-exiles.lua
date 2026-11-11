-- French (frFR): the guide forever/reputation/gnomeregan-exiles (forever/reputation/gnomeregan-exiles.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gnomeregan Exiles Reputation"] = "Réputation : Exilés de Gnomeregan",
	-- {npc:9616} Laris Geardawdle · {zone:1426} Dun Morogh · {zone:1455} Ironforge
	["Cloth, {npc:9616}'s ooze quests and the {zone:1426} hubs, which pay {zone:1455} too: best done while leveling."] = "Étoffes, quêtes de limons de {npc:9616} et étapes de {zone:1426}, qui rapportent aussi auprès de {zone:1455} : à faire de préférence pendant la montée de niveau.",
	-- {faction:54} Gnomeregan Exiles
	["Exalted with {faction:54}: in Classic, other races may buy the mechanostriders"] = "Exalté auprès des {faction:54} : dans Classic, les autres races peuvent acheter les mécanotrotteurs",
	-- {area:133} Gnomeregan · {npc:9616} Laris Geardawdle · {quest:4262} Overmaster Pyron
	["400 {area:133} reputation from {npc:9616}'s ooze jars and {quest:4262} (level 52-54)"] = "400 de réputation auprès de {area:133} grâce aux bocaux de limon de {npc:9616} et à {quest:4262} (niveau 52-54)",
	-- {area:133} Gnomeregan · {zone:1426} Dun Morogh · {zone:1455} Ironforge
	["About 3,000 {area:133} reputation from low-level quests in {zone:1426}, paid to {zone:1455} too"] = "",

	-- Step 1: Bubulo Acerbus, the cloth quartermaster
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, the cloth quartermaster"] = "{npc:14724}, l'intendant des étoffes",
	-- {npc:14724} Bubulo Acerbus · {faction:54} Gnomeregan Exiles · {object:171524} Tinker Town · {zone:1455} Ironforge · {item:14047} Runecloth · {quest:7812} Additional Runecloth · {zone:1426} Dun Morogh · {npc:4077} Gaxim Rustfizzle · {npc:9616} Laris Geardawdle · {quest:4262} Overmaster Pyron · {area:132} Coldridge Valley · {area:131} Kharanos · {area:133} Gnomeregan · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14724} takes cloth for the {faction:54}; he stands in {object:171524} in {zone:1455}, by the tram. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7812} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12) and {npc:4077}'s quests in Stonetalon (20-25) while you level. After the donations come {npc:9616}'s ooze quests and {quest:4262} (400), then the optional {zone:1426} hubs, best rate first: {area:132} (about 38 a minute at full value), {area:131} (26), the quarry (17). Every {area:133} gain also gives a quarter as much to {zone:1453}, {zone:1455} and {zone:1457}, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14724} prend les étoffes pour les {faction:54} ; il se tient à {object:171524}, à {zone:1455}, près du tram. Chaque premier don de 60 étoffes de laine, de soie, de tisse-mage et d'{item:14047} rapporte une fois 150 de réputation ; après celui d'{item:14047}, {quest:7812} rapporte 50 pour chaque lot de 20 {item:14047}, aussi souvent que vous le voulez. L'hôtel des ventes de Forgefer est la source d'étoffes la plus rapide. Dans Classic, les quêtes rapportent toute leur réputation tant qu'elles sont au plus 5 niveaux sous le vôtre : faites donc {zone:1426} (niveaux 1-12) et les quêtes de {npc:4077} dans les Serres-Rocheuses (20-25) pendant votre montée de niveau. Après les dons viennent les quêtes de limons de {npc:9616} et {quest:4262} (400), puis les étapes facultatives de {zone:1426}, la meilleure d'abord : {area:132} (environ 38 par minute à pleine valeur), {area:131} (26), la carrière (17). Chaque gain auprès de {area:133} en donne aussi un quart à {zone:1453}, à {zone:1455} et à {zone:1457}, sauf les quêtes des zones de départ de niveau 1 à 10. Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain.",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592} : troggs, gnolls et kobolds du {zone:1432} et des {zone:1437}",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,150 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "Coldridge : loups, troggs et affaires de {npc:8416}",
	-- {area:77} Anvilmar · {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of {area:77}; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "Les loups errent au fond de la vallée ; les troggs creusent dans les camps à l'est d'{area:77} ; la boîte, le coffre et le seau de {npc:8416} se trouvent dans les camps de troggs.",

	-- Step 4: Coldridge: Anvilmar and Talin Keeneye
	-- {area:77} Anvilmar · {npc:714} Talin Keeneye
	["Coldridge: {area:77} and {npc:714}"] = "Coldridge : {area:77} et {npc:714}",

	-- Step 5: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "Coldridge : {npc:786} et la grotte des trolls",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786} campe au sud d'{area:77}, à l'entrée de la grotte des trolls ; le journal se trouve au fond de la grotte.",

	-- Step 6: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "Coldridge : la Mornbrew brûlante",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at {area:77}."] = "La Mornbrew brûlante refroidit en cinq minutes : courez directement auprès de {npc:836} à {area:77}.",

	-- Step 7: Coldridge: on to Kharanos
	-- {area:131} Kharanos
	["Coldridge: on to {area:131}"] = "Coldridge : en route pour {area:131}",
	-- {npc:1252} Senir Whitebeard · {area:131} Kharanos
	["{npc:1252}, in {area:131}"] = "{npc:1252}, à {area:131}",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "{npc:6806}, à l'auberge",

	-- Step 8: Kharanos
	-- {area:131} Kharanos · {area:133} Gnomeregan · {area:2102} Thunderbrew Distillery · {area:189} Steelgrill's Depot
	["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 9: Kharanos: the hills and the depot
	-- {area:131} Kharanos
	["{area:131}: the hills and the depot"] = "{area:131} : les collines et le dépôt",
	-- {area:131} Kharanos · {area:136} Grizzled Den · {area:133} Gnomeregan
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "Les sangliers et les ours errent autour de {area:131} ; les wendigos vivent dans la {area:136}, au sud-ouest de la ville ; les gnomes lépreux sur la route de {area:133} portent les rouages et engrenages ; les munitions de Rumbleshot sont à son camp, à l'ouest de la ville.",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131} : de retour en ville",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131} : Brewnall et {quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374} se tient près du {area:137}, au bord du lac au nord-ouest de {area:131} ; {quest:287} est la grotte des trolls à l'ouest.",
	["walk to the back of the cave"] = "allez au fond de la grotte",

	-- Step 12: Kharanos: last hand-in
	-- {area:131} Kharanos
	["{area:131}: last hand-in"] = "{area:131} : dernière remise",

	-- Step 13: The quarry and Amberstill Ranch
	-- {area:803} Amberstill Ranch
	["The quarry and {area:803}"] = "La carrière et le {area:803}",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {area:134} Gol'Bolar Quarry · {area:803} Amberstill Ranch
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation in 30 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 14: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "La carrière : troggs, espions et {npc:1388}",
	-- {area:134} Gol'Bolar Quarry · {npc:1388} Vagash · {area:803} Amberstill Ranch
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {area:134}; {npc:1388}, a big snow leopard, prowls the hills above {area:803}."] = "Les espions Sombrefer rôdent autour du camp de Farsen ; les troggs creusent dans la {area:134} ; {npc:1388}, un grand léopard des neiges, rôde dans les collines au-dessus du {area:803}.",

	-- Step 15: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "{npc:1274}, dans la salle du trône",

	-- Step 16: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "L'{item:4306} tombe des humanoïdes de niveau 23 à 40 : les Gueule-de-dragon des {zone:1437}, le Syndicat d'Alterac et d'Arathi, les trolls de Strangleronce.",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "L'{item:4338} tombe des humanoïdes de niveau 35 à 50 : les nains Forgombre et {object:147516} des {zone:1418} et de la {zone:1427}, les ogres Cognedune de {zone:1446}, les nagas Hainecrête de {zone:1444}.",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7812} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7812}."] = "L'{item:14047} tombe des humanoïdes de niveau 50 et plus : les sectateurs du Fléau et la Croisade écarlate dans les Maleterres, les furbolgs Mort-bois de {zone:1448}, les furbolgs Tombe-hiver de {zone:1452}. Gardez l'{item:14047} au-delà des 60 premières pour {quest:7812}.",

	-- Step 19: Tinker Town: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle · {object:171524} Tinker Town · {area:133} Gnomeregan
	["{npc:9616} in {object:171524} wants ooze samples for her research: 150 {area:133} reputation for each of her two quests (level 52 and 54: in Classic 60 and 120 of it at 60). She hands you the empty jars."] = "{npc:9616}, à {object:171524}, veut des échantillons de limon pour ses recherches : 150 de réputation auprès de {area:133} pour chacune de ses deux quêtes (niveau 52 et 54 : dans Classic, 60 et 120 au niveau 60). Elle vous donne les bocaux vides.",

	-- Step 20: Felwood: Cursed and Tainted Oozes
	-- {zone:1448} Felwood
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{zone:1448}: Cursed and Tainted Oozes"] = "{zone:1448} : Limons maudits et Limons corrompus",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill one and use an empty jar on its remains."] = "Les Limons maudits et les Limons corrompus glissent dans les ruisseaux et les mares gangrenées autour de {area:1763} et des {area:1765} : tuez-en un et utilisez un bocal vide sur ses restes.",

	-- Step 21: Tinker Town: the second jars
	-- {object:171524} Tinker Town
	["{object:171524}: the second jars"] = "{object:171524} : les seconds bocaux",

	-- Step 22: Un'Goro Crater: Primal Oozes
	-- {zone:1449} Un'Goro Crater
	-- plural, as words: Primal Oozes = {npc:6557} Primal Ooze
	["{zone:1449}: Primal Oozes"] = "{zone:1449} : Limons primitifs",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Primal Oozes = {npc:6557} Primal Ooze · Glutinous Oozes = {npc:6559} Glutinous Ooze
	["The Primal Oozes live in the pools around {area:537} in the middle of the crater; the Muculent and Glutinous Oozes fill the jars too. Kill one and use a jar on its remains."] = "Les Limons primitifs vivent dans les mares autour de la {area:537}, au milieu du cratère ; les Limons de mucus et les Limons gluants remplissent aussi les bocaux. Tuez-en un et utilisez un bocal sur ses restes.",

	-- Step 23: Tinker Town: hand in
	-- {object:171524} Tinker Town
	["{object:171524}: hand in"] = "{object:171524} : rendez les quêtes",

	-- Step 24: Morgan's Vigil: Jalinda Sprig
	-- {npc:9561} Jalinda Sprig · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4262} Overmaster Pyron · {area:133} Gnomeregan · {area:1584} Blackrock Depths
	["{npc:9561} at {area:2418}, in the south-east of the {zone:1428}, wants {quest:4262} dead: 100 {area:133} reputation (level 52: in Classic 40 at 60). Her next quest, Incendius!, needs a {area:1584} group: 100 more, in full."] = "{npc:9561}, au {area:2418} dans le sud-est des {zone:1428}, veut la mort du {quest:4262} : 100 de réputation auprès de {area:133} (niveau 52 : dans Classic, 40 au niveau 60). Sa quête suivante, Incendius !, demande un groupe pour les {area:1584} : 100 de plus, en entier.",

	-- Step 25: Blackrock Mountain: Overmaster Pyron
	-- {area:254} Blackrock Mountain · {zone:1428} Burning Steppes · {quest:4262} Overmaster Pyron · {area:1584} Blackrock Depths
	["{area:254} stands in the west of the {zone:1428}. {quest:4262}, a fire elemental, walks the lava paths inside it, near the door of {area:1584} but outside the dungeon: at 60 you take him alone."] = "Le {area:254} se dresse dans l'ouest des {zone:1428}. Le {quest:4262}, un élémentaire de feu, arpente les chemins de lave à l'intérieur, près de la porte des {area:1584} mais hors du donjon : au niveau 60, vous le tuez seul.",

	-- Step 26: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418} : rendez les quêtes",

	-- Step 27: Additional Runecloth to Honored
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Honored"] = "{quest:7812} : Honoré",
	-- {quest:7812} Additional Runecloth · {item:14047} Runecloth · {npc:9616} Laris Geardawdle · {npc:9561} Jalinda Sprig · {zone:1426} Dun Morogh · {npc:4077} Gaxim Rustfizzle · {object:171524} Tinker Town · {area:133} Gnomeregan
	["{quest:7812}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Night Elf stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Gnomes start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). {npc:9616}'s and {npc:9561}'s quests above take 8 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. Outside Dun Morogh Gnomeregan pays little: {npc:4077}'s quests in Stonetalon (about 500) and {object:171524}'s {area:133} dungeon quests. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 28: Additional Runecloth to Revered
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Revered"] = "{quest:7812} : Révéré",
	-- {faction:54} Gnomeregan Exiles · {npc:7955} Milli Featherwhistle · {item:14047} Runecloth
	["Honored: in Classic the {faction:54}' vendors take 10% off for you, {npc:7955}'s mechanostriders (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honoré : dans Classic, les marchands des {faction:54} vous font 10 % de remise, les mécanotrotteurs de {npc:7955} (20 po, les rapides 200 po) compris ; Forever n'a pas tranché, et les sites de guides parlent de 5 % à Amical, jusqu'à 20 % à Exalté. D'Honoré à Révéré, il faut 12 000 de réputation : 240 remises, 4 800 {item:14047}.",

	-- Step 29: Additional Runecloth to Exalted
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Exalted"] = "{quest:7812} : Exalté",
	-- {item:14047} Runecloth · {npc:7955} Milli Featherwhistle · {area:189} Steelgrill's Depot · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:7955} at {area:189} in {zone:1426} sells her mechanostriders to other races in Classic; the Mechanostrider and Swift Mechanostrider guides cover them."] = "De Révéré à Exalté, il faut 21 000 de réputation : 420 remises, 8 400 {item:14047}. À Exalté, {npc:7955}, au {area:189} à {zone:1426}, vend ses mécanotrotteurs aux autres races dans Classic ; les guides Mécanotrotteur et Mécanotrotteur rapide en parlent.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 3,000 {area:133} reputation from low-level quests in {zone:1426}, paid to {zone:1455} too (in Classic, a fifth of it at 60)"] = "Environ 3 000 de réputation auprès de {area:133} grâce aux quêtes de bas niveau de {zone:1426}, rapportées aussi à {zone:1455} (dans Classic, un cinquième au niveau 60)",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en laissent tomber ici ; chaque mort du Fléau ici compte aussi pour {object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Keep handing in {quest:7812} until {faction:54} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7812} jusqu'à être exalté auprès de {faction:54}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7812}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7812}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
	-- ["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation (100 at a fifth) in 30 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : l'est de {zone:1426}, du camp de {npc:264936} jusqu'à la {area:134} et au {area:803}, environ 500 de réputation (100 à un cinquième) en 30 minutes au niveau 60. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,150 reputation (230 at a fifth) in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : la vallée de départ des Nains et des Gnomes au sud-ouest de {area:131}, environ 1 150 de réputation (230 à un cinquième) en 30 minutes au niveau 60. {npc:658} et {npc:713} se tiennent à {area:77}. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation (260 at a fifth) in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : {area:131} et les routes de Brewnall et de {area:133} alentour, environ 1 300 de réputation (260 à un cinquième) en 50 minutes au niveau 60. La plupart des donneurs de quêtes se tiennent dans et autour de la {area:2102} et au {area:189}, à l'est. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Les Bandits et Sous-chefs Rivepatte (niveau 16-18) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Les Mercenaires du Syndicat de Stromgarde (niveau 31-32) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",
	-- ["{npc:14724} takes cloth for {faction:54} in {object:171524}, {zone:1455}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7812} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14724} prend les étoffes pour {faction:54} à {object:171524}, {zone:1455}. Les premiers dons d'Etoffe de laine, d'Etoffe de soie, d'Etoffe de tisse-mage et de {item:14047} (60 étoffes chacun) ne se font qu'une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7812} se répète jusqu'à Exalté. Être exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14724}: {item:14047} delivered"] = "{npc:14724} : {item:14047} livrée",
	-- ["{quest:7812} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7812} prend 20 {item:14047} par remise et se répète autant que vous voulez. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
	-- ["{quest:7812}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Night Elf stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Gnomes start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). {npc:9616}'s and {npc:9561}'s quests above take 8 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off if it paid in full. Outside Dun Morogh Gnomeregan pays little: {npc:4077}'s quests in Stonetalon (about 500) and {object:171524}'s {area:133} dungeon quests. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7812} : 50 de réputation pour 20 {item:14047}, aussi souvent que vous le voulez. Après les quatre premiers dons, un Humain, un Nain ou un Elfe de la nuit est à Amical 700 sur 6 000, donc Honoré est à 5 300 : 106 remises, 2 120 {item:14047} (les Gnomes commencent 900 plus haut : 88 remises ; les Éolides commencent à Neutre 2 000, donc à 6 400 : 128, deux de moins après Exploring the Alliance). Les quêtes de {npc:9616} et de {npc:9561} ci-dessus en retirent 8 ; chaque étape de {zone:1426} que vous avez faite en retire 10 à 26 de plus si elle a rapporté en entier. Hors de Dun Morogh, Gnomeregan rapporte peu : les quêtes de {npc:4077} dans les Serres-Rocheuses (environ 500) et les quêtes du donjon de {area:133} à {object:171524}. Chaque gain auprès d'une ville en donne aussi un quart aux trois autres villes de l'Alliance (non compté ici). Rendez tout votre {item:14047} d'un coup.",
}
