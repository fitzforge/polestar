-- French (frFR): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "Réputation : Forgefer",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {area:133} Gnomeregan · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay {area:133} too; {zone:1459} adds more."] = "Étoffes, quêtes des {zone:1428} et étapes de {zone:1426}, qui rapportent aussi auprès de {area:133} ; la {zone:1459} en ajoute.",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "Exalté auprès de {faction:47} : dans Classic, les autres races peuvent acheter les béliers",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "Environ 600 de réputation auprès de {faction:47} grâce aux quêtes de niveau 52-59 des {zone:1428} et de {zone:1452} ; les quêtes de la {zone:1459} rapportent aussi auprès de {faction:47}",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh · {area:133} Gnomeregan
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too"] = "",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "{npc:14723}, l'intendante des étoffes",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {area:132} Coldridge Valley · {area:131} Kharanos · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: {area:132} (about 37 a minute at full value), {area:131} (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14723} prend les étoffes pour {faction:47} ; elle se tient devant la boutique de vêtements, côté nord de la {object:32372}, parmi les tailleurs. Chaque premier don de 60 étoffes de laine, de soie, de tisse-mage et d'{item:14047} rapporte une fois 150 de réputation ; après celui d'{item:14047}, {quest:7806} rapporte 50 pour chaque lot de 20 {item:14047}, aussi souvent que vous le voulez. L'hôtel des ventes de Forgefer est la source d'étoffes la plus rapide. Dans Classic, les quêtes rapportent toute leur réputation tant qu'elles sont au plus 5 niveaux sous le vôtre : faites donc {zone:1426} (niveaux 1-12), le {zone:1432} (10-20) et les {zone:1437} (20-30) pendant que vous y montez de niveau. Après les dons viennent les quêtes de niveau 52-59 des {zone:1428} et de {zone:1452} (environ 600), puis les étapes facultatives de {zone:1426}, la meilleure d'abord : {area:132} (environ 37 par minute à pleine valeur), {area:131} (26), la carrière (17). Chaque gain auprès de {faction:47} en donne aussi un quart à {zone:1453}, à {zone:1457} et aux Exilés de Gnomeregan, sauf les quêtes des zones de départ de niveau 1 à 10. Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain.",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592} : troggs, gnolls et kobolds du {zone:1432} et des {zone:1437}",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

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
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "L'{item:14047} tombe des humanoïdes de niveau 50 et plus : les sectateurs du Fléau et la Croisade écarlate dans les Maleterres, les furbolgs Mort-bois de {zone:1448}, les furbolgs Tombe-hiver de {zone:1452}. Gardez l'{item:14047} au-delà des 60 premières pour {quest:7806}.",

	-- Step 19: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat · {zone:1428} Burning Steppes
	["These quests are level 52 to 59, so they pay in full at 60: about 600 {faction:47} reputation. {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "Écoutez l'{npc:8879} jusqu'au bout",

	-- Step 20: Morgan's Vigil: Oralius
	-- {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {npc:9177} Oralius · {area:249} Dreadmaul Rock
	["{area:2418} sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of {area:249}, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "Le {area:2418} se trouve dans le sud-est des {zone:1428}, en haut du col qui monte des Carmines. {npc:9177} veut qu'on éclaircisse les rangs des ogres Brûlentrailles du {area:249}, au nord du camp ; les Brutes restent sur le côté est du rocher.",

	-- Step 21: Thaurissan and Blackrock Stronghold
	-- {area:252} Blackrock Stronghold
	["Thaurissan and {area:252}"] = "Thaurissan et le {area:252}",
	-- {area:251} Flame Crest · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around {area:251}, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of {area:254}, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "Les reliques de Thaurissan sont les pierres sculptées dans les ruines autour de la {area:251}, à l'ouest le long de la route : cliquez sur douze d'entre elles. {npc:9176} et les orcs et worgs Rochenoire tiennent les camps au pied du {area:254}, plus à l'ouest ; chacun peut laisser un {item:11467} (environ une victime sur trois), et {npc:9177} en veut cinquante. Les orcs sont de niveau 50 et plus, ils laissent donc aussi de l'{item:14047} : gardez-la pour {quest:7806}.",

	-- Step 22: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418} : rendez les quêtes",
	-- {npc:9176} Gor'tesh · {area:249} Dreadmaul Rock
	["Plant {npc:9176}'s head on the soft dirt mound at the top of {area:249}."] = "Plantez la tête de {npc:9176} sur le monticule de terre meuble au sommet du {area:249}.",

	-- Step 23: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "{faction:47} : de nouveau Archesonus",
	-- {area:1584} Blackrock Depths · {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, {area:1584} pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "En groupe, les {area:1584} rapportent davantage : la suite d'Archesonus continue avec {npc:9021} (100) et Le destin du Royaume (l'empereur Thaurissan, 150), et {npc:9177} prend 20 sacoches sombrefer sur les nains de l'intérieur (The Good Stuff, 100). La {zone:1459}, dès le niveau 51, rapporte aussi auprès de {faction:47} : ses quêtes uniques environ 1 900 à mesure que votre réputation Foudrepique grandit (le guide de la {zone:1459} les détaille), et dans la bataille 25 pour chaque lot de 10 Gouffrefer ou {item:17542} et 50 pour 5 cristaux de tempête, aussi souvent que vous le voulez.",

	-- Step 24: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village · {area:2245} Mazthoril · {faction:47} Ironforge
	["{npc:11755} in {area:2255} sends you west to {npc:10301} at {area:2253}. {npc:10301}'s damaged crate and wrecked wagon lie at {area:2245}, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "{npc:11755}, à {area:2255}, vous envoie à l'ouest auprès de {npc:10301}, au {area:2253}. La caisse abîmée et le chariot détruit de {npc:10301} se trouvent à {area:2245}, en descendant la vallée vers le sud-est ; ses fournitures sont autour du chariot et les chouettards voisins portent son amulette. La dernière quête est de niveau 59 : 100 auprès de {faction:47}, en entier.",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806} jusqu'à Honoré",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {area:144} Thelsamar · {zone:1432} Loch Modan · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806} jusqu'à Révéré",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honoré : dans Classic, les marchands de Forgefer vous font 10 % de remise, les béliers de {npc:1261} (20 po, les rapides 200 po) compris ; Forever n'a pas tranché, et les sites de guides parlent de 5 % à Amical, jusqu'à 20 % à Exalté. D'Honoré à Révéré, il faut 12 000 de réputation : 240 remises, 4 800 {item:14047}.",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806} jusqu'à Exalté",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {area:803} Amberstill Ranch · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at {area:803} in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "De Révéré à Exalté, il faut 21 000 de réputation : 420 remises, 8 400 {item:14047}. À Exalté, {npc:1261}, au {area:803} dans l'est de {zone:1426}, vend ses béliers aux autres races dans Classic ; les guides Bélier et Bélier rapide en parlent.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too (in Classic, a fifth of it at 60)"] = "Environ 2 900 de réputation auprès de {faction:47} grâce aux quêtes de bas niveau de {zone:1426}, en grande partie rapportées aussi à {area:133} (dans Classic, un cinquième au niveau 60)",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et Ombremages (niveau 58-60) en lâchent ici ; chaque Fléau tué ici compte aussi pour l'{object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7806} jusqu'à être Exalté auprès de {faction:47}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7806}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation (100 at a fifth) in 30 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : l'est de {zone:1426}, du camp de {npc:264936} jusqu'à la {area:134} et au {area:803}, environ 500 de réputation (100 à un cinquième) en 30 minutes au niveau 60. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation (220 at a fifth) in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : la vallée de départ des Nains et des Gnomes au sud-ouest de {area:131}, environ 1 100 de réputation (220 à un cinquième) en 30 minutes au niveau 60. {npc:658} et {npc:713} se tiennent à {area:77}. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation (260 at a fifth) in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : {area:131} et les routes de Brewnall et de {area:133} alentour, environ 1 300 de réputation (260 à un cinquième) en 50 minutes au niveau 60. La plupart des donneurs de quêtes se tiennent dans et autour de la {area:2102} et au {area:189}, à l'est. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Les Bandits et Sous-chefs Rivepatte (niveau 16-18) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Les Mercenaires du Syndicat du Donjon de Stromgarde (niveau 31-32) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["These quests are level 52 to 59, so they pay in full at 60, or nearly: about 600 {faction:47} reputation (in Classic about 450 at 60, as the {zone:1428} ones are level 52 to 54). {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "Ces quêtes sont de niveau 52 à 59 et rapportent donc en entier au niveau 60, ou presque : environ 600 de réputation auprès de {faction:47} (dans Classic, environ 450 au niveau 60, car celles des {zone:1428} sont de niveau 52 à 54). L'{npc:8879} se tient à côté du roi Magni dans le {object:171709} ; elle vous envoie aux ruines de Thaurissan, dans les {zone:1428}.",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723} prend les étoffes pour {faction:47} à {faction:47}. Les premiers dons d'étoffe de laine, de soie, de tisse-mage et d'{item:14047} (60 étoffes chacun) se font une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7806} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723} : {item:14047} livrée",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806} prend 20 {item:14047} par remise et se répète à volonté. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off if it paid in full. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7806} : 50 de réputation pour 20 {item:14047}, aussi souvent que vous le voulez. Après les quatre premiers dons, un Humain, un Elfe de la nuit ou un Gnome est à Amical 700 sur 6 000, donc Honoré est à 5 300 : 106 remises, 2 120 {item:14047} (les Nains commencent 900 plus haut : 88 remises ; les Éolides commencent à Neutre 2 000, donc à 6 400 : 128, deux de moins après Exploring the Alliance). Les quêtes de niveau 52-59 ci-dessus en retirent 12 ; chaque étape de {zone:1426} que vous avez faite en retire 10 à 26 de plus si elle a rapporté en entier. D'autres groupes de quêtes rapportent auprès de {faction:47}, en entier tant qu'ils ne sont pas plus de 5 niveaux sous le vôtre : {area:144} dans le {zone:1432} (environ 3 500 en tout) et {area:150} dans les {zone:1437} (environ 2 500). Dès le niveau 51, les quêtes uniques de la {zone:1459} ajoutent environ 1 900. Chaque gain auprès d'une ville en donne aussi un quart aux trois autres villes de l'Alliance (non compté ici). Rendez tout votre {item:14047} d'un coup.",
}
