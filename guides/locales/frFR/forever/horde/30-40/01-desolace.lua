-- French (frFR): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prenez un vol pour {area:1637}",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "Depuis {area:484}, prenez un vol pour {area:1637}.",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} attend dans la Herse ; {npc:5640} se tient dans {object:172961} à l'ouest de la ville. Célestes : {npc:4949} attend dans le fort Grommash, dans {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Grommash Hold, si vous l'avez",

	-- Step 3: Train
	["Train"] = "Entraînement",
	["Train your new spells."] = "Apprenez vos nouveaux sorts.",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Votre maître est à {area:1638}, à un vol d'ici : {npc:3033} (druides) sur {area:1639}, {npc:246344} (paladins). De là, prenez un vol pour {area:460}.",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Quêtes de classe à {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} se tient dans {object:172957}.",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Prenez un vol pour {area:392}. {npc:5901} campe sur la côte, un peu au sud de la ville.",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Prenez un vol pour {area:484}. {npc:5905} se cache dans une petite grotte, dans la paroi du canyon au nord-est du poste.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905} : votre {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} lance aussi Elemental Aid ({area:1717}), la suite 33-40 menant à The Tempest's Weapons : forever/class/shaman/call-of-air-horde.",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Prenez un vol pour {area:460}",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "Caravane de Gizelton",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Suivez la route au sud-ouest depuis Roche-Soleil jusqu'en {zone:1443}, puis vers le sud au-delà de {area:608}. La caravane de kodos de {npc:11625} attend au bord de la route, au nord de {area:609} ; si elle est déjà partie, continuez.",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "La caravane descend vers le sud au-delà de {area:609}. Des pillards kolkar l'attaquent par vagues : tuez-les avant qu'ils n'atteignent {npc:11625}. Elle s'arrête près de {area:2617}, à l'est de {area:597}.",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} se tient dans le poste ; {npc:5641} et {npc:4498} attendent sur la butte à l'ouest, au-dessus de {area:596}.",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Utilisez le {item:13892} de {npc:11596} sur un Vieux kodo, un Kodo mourant ou un {npc:4702} du cimetière, puis ramenez le kodo apprivoisé à {npc:11596}. Cinq kodos, un à la fois.",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Allez au nord-est jusqu'à {area:609}. {quest:1365} (35) circule entre les tentes du côté est avec un ou deux Seigneurs de guerre (32-33) : nettoyez les alentours, puis attirez-le seul, en pleine santé.",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "Au nord, le long des collines de l'est, les satyres occupent les ruines de {area:603}. Les Traqueurs des ténèbres sont invisibles ; les quatre types qu'il vous faut ne le sont pas.",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Allez à l'ouest jusqu'à {area:599}. Affaiblissez un Sectateur de la Lame ardente, puis utilisez la {item:6436} sur lui avant sa mort pour obtenir une {item:6435}. Ils laissent parfois tomber une {item:20310} (1-5 %) : si vous en obtenez une, lisez-la.",

	-- Step 17: Ghost Walker Post
	["Ride back south to the post."] = "Retournez au poste, au sud.",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "La quête suivante de {npc:5641}, {quest:1431}, vous renvoie à {zone:1454} pour rien : laissez-la.",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "Oreilles de Kolkar",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "De retour à {area:609}, chaque Kolkar peut laisser tomber une oreille.",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "Scalp de traqueur des ténèbres",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Les Traqueurs des ténèbres Fielfurie de {area:603} restent invisibles jusqu'à leur attaque ; environ un sur trois porte un scalp.",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Allez au sud-ouest jusqu'au village troll sur la côte, en évitant {area:606} en chemin.",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877} : pour {npc:715} à Strangleronce",

	-- Step 22: Clam beds
	["Clam beds"] = "Bancs de praires",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Remontez la côte vers le nord. Les Praires géantes reposent dans les hauts-fonds et les Clampants des récifs enragés arpentent la plage ; ouvrez chaque praire dans vos sacs pour en obtenir la chair.",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Oracles Ondulame",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Continuez au nord jusqu'à {area:598}. Les Oracles se tiennent parmi les autres nagas à son extrémité nord ; attirez-les un par un.",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} attend dans la tour en ruine de {area:2405}, dans les terres au sud-est.",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "Le Prophète se tient du côté sud de {area:599}, à l'est de {area:2405}. Éliminez d'abord les sectateurs autour de lui.",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "Sa mission suivante ne fait pas partie de cet itinéraire.",

	-- Step 27: Ghost Walker Post
	["Ride south-east to the post."] = "Allez au sud-est jusqu'au poste.",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "La mission suivante de {npc:5641} vous envoie contre un seigneur démon escorté d'élites : passez-la.",

	-- Step 28: Gelkis Village
	["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Allez au sud-ouest vers Proie-de-l'Ombre. Les centaures gelkis (32-35) autour de leur village sont un bon endroit : combattez-les jusqu'au niveau 32.",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "tuez des Poinçonneurs gelkis et des Chasse-vent gelkis à {area:606}, {zone:1443}",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Depuis Proie-de-l'Ombre, prenez un vol pour {area:1638} et entraînez-vous auprès de {npc:3033} sur {area:1639}, puis prenez un vol pour {zone:1454}.",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "Zeppelin pour {area:1497}",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Quittez {zone:1454} par la porte principale ; la tour des zeppelins se dresse juste au nord-est. Prenez le zeppelin pour {area:1497}.",
	["Zeppelin tower"] = "Tour des zeppelins",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} entraîne les paladins à {area:1497}.",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Faites d'abord vos achats à {area:1497}, puis volez jusqu'au {area:228}. {object:113791} se dresse sur la colline juste au sud-ouest : battez la Manifestation d'eau corrompue mineure à côté, placez ses bracelets dans le brasero, parlez à {npc:5895} et gardez {item:7813} pour {npc:5901}. Volez ensuite jusqu'à {area:272} depuis le {area:228}.",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "pour {npc:5901} : depuis Strangleronce, guide suivant",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} demande un {item:3388}, un objet d'{skill:171} : achetez-en un à l'hôtel des ventes ici si vous pouvez (ou demandez à un alchimiste). Sans potion, passez les étapes de l'élixir à {area:287}.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388} : hôtel des ventes ou un alchimiste, pour {quest:515}.",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "{npc:4551}, le dresseur de chauves-souris",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, pour {npc:2333}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770} : pour {area:321} en Arathi, plus loin sur l'itinéraire",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229} : pour {zone:1413}, plus loin sur l'itinéraire",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "Nagas Daguéchine",
	-- {area:271} Southshore
	["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Descendez au sud jusqu'à la côte, à l'est d'{area:271}. Les nagas Daguéchine bordent le rivage au sud-est de la ville.",
	["Daggerspine shore"] = "Rivage des Daguéchine",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Suivez le rivage vers l'ouest au-delà de la baie d'{area:271} ; les murlocs Aileron déchiré campent sur les plages plus loin.",
	["Torn Fin beach"] = "Plage des Aileron déchiré",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Ride back north to {area:272}, keeping west of {area:271}."] = "Retournez au nord jusqu'à {area:272}, en restant à l'ouest d'{area:271}.",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "Tonneau de Shindigger",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Le tonneau se trouve avec quelques autres au camp du Syndicat, sur la côte sud-est de {area:287}.",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Retour à {area:272}",
	["Hearth back (or ride north if it is on cooldown)."] = "Utilisez votre Pierre de foyer (ou remontez au nord si elle n'est pas prête).",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "Placez le {object:1729} sur la {object:1728} à côté de l'auberge",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Suivez la route au nord de {area:272} jusqu'aux contreforts d'Alterac. {quest:535} attend près du camp du Syndicat ; donnez-lui la bière.",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "Missives du Syndicat",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Les Détrousseurs et Larrons du Syndicat (32-33) autour des camps à l'ouest de la route portent les missives ; environ un sur trois en laisse tomber une.",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "Au sud-ouest, les Yétis des grottes et les Yétis féroces (30-31) peuplent les grottes des collines à l'ouest de {area:272} ; environ un sur seize porte le bâton.",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Les traîtres de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Allez vers l'ouest au pied des montagnes jusqu'au dôme violet de {area:279}. {npc:2411}, {npc:2412} et {npc:2413} (33-34) se tiennent ensemble à l'intérieur du bord est du cratère, {npc:2414} (35) un peu à l'ouest ; chacun porte un morceau de pierre de sang. Les Défenseurs et Théurges de Dalaran (31-32) autour d'eux lâchent les Runes gravées usées.",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back east to {area:272}."] = "Retournez à l'est jusqu'à {area:272}.",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "La tâche suivante de Thaivand se termine au cimetière d'{area:271} et le magus propose une mission de donjon : laissez les deux.",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Allez au nord au-delà du camp de {quest:535} jusqu'à {area:280}, le village tenu par le Syndicat (35-37). {npc:2431} porte la {item:3704} ; {quest:503} est enfermé dans une cage, dans la maison du côté nord.",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back south to {area:272}."] = "Retournez au sud jusqu'à {area:272}.",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Prenez un vol pour {area:1497}",
	-- {area:1497} Undercity · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "Le guide suivant commence à {area:1497}, au zeppelin de {object:3202}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt {npc:11256} beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for Islen. Fly on to {area:272} from the {area:228}."] = "Faites d'abord vos achats à {area:1497}, puis prenez un vol pour {area:228}. Le {object:113791} se dresse sur la colline juste au sud-ouest : vainquez la {npc:11256} corrompue à côté, placez ses brassards dans le brasero, parlez à la {npc:5895} et gardez l'{item:7813} pour Islen. Depuis {area:228}, prenez un vol pour {area:272}.",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. Ricter, Alina and Dermot (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn {quest:556}."] = "Allez à l'ouest au pied des montagnes jusqu'au dôme violet de {area:279}. Ricter, Alina et Dermot (33-34) se tiennent ensemble au bord est du cratère, {npc:2414} (35) un peu à l'ouest d'eux ; chacun porte un fragment de pierre de sang. Les Défenseurs et Théurges de Dalaran (31-32) autour d'eux laissent tomber les runes usées pour {quest:556}.",
	-- ["{npc:5639} waits in the {object:172959}; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} attend dans {object:172959} ; {npc:5640} se tient dans {object:172961}, à l'ouest de la ville. Skyborne : {npc:4949} attend à Grommash Hold, dans {object:172957}.",
}
