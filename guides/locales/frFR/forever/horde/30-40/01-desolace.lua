-- French (frFR): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Freewind Post
	-- {area:484} Freewind Post
	["Hearth to {area:484}"] = "",

	-- Step 2: To Freewind Post
	-- {area:484} Freewind Post
	["To {area:484}"] = "",

	-- Step 3: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prenez un vol pour {area:1637}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 4: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} attend dans la Herse ; {npc:5640} se tient dans {object:172961} à l'ouest de la ville. Célestes : {npc:4949} attend dans le fort Grommash, dans {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Grommash Hold, si vous l'avez",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Quêtes de classe à {zone:1454}",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} se tient dans {object:172957}.",

	-- Step 6: Train
	["Train"] = "Entraînement",
	["Train your new spells."] = "Apprenez vos nouveaux sorts.",

	-- Step 7: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short walk south of the town."] = "",

	-- Step 8: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "Prenez un vol pour {area:484}. {npc:5905} se cache dans une petite grotte, dans la paroi du canyon au nord-est du poste.",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905} : votre {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} lance aussi Elemental Aid ({area:1717}), la suite 33-40 menant à The Tempest's Weapons : forever/class/shaman/call-of-air-horde.",

	-- Step 9: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",

	-- Step 10: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Prenez un vol pour {area:460}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 13: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395} se tient dans le poste ; {npc:5641} et {npc:4498} attendent sur la butte à l'ouest, au-dessus de {area:596}.",

	-- Step 14: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "Utilisez le {item:13892} de {npc:11596} sur un Vieux kodo, un Kodo mourant ou un {npc:4702} du cimetière, puis ramenez le kodo apprivoisé à {npc:11596}. Cinq kodos, un à la fois.",

	-- Step 15: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Head north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "",

	-- Step 16: Sargeron
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "",
	-- {npc:4670} Hatefury Rogue
	["grind on {npc:4670}"] = "",

	-- Step 17: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Head west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "",

	-- Step 18: Ghost Walker Post
	["Head back south to the post."] = "",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "La quête suivante de {npc:5641}, {quest:1431}, vous renvoie à {zone:1454} pour rien : laissez-la.",

	-- Step 19: Kolkar ears
	["Kolkar ears"] = "Oreilles de Kolkar",
	-- {area:609} Kolkar Village
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["Back at {area:609}, every Kolkar can drop an ear.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "",

	-- Step 20: Shadowstalker scalp
	["Shadowstalker scalp"] = "Scalp de traqueur des ténèbres",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "Les Traqueurs des ténèbres Fielfurie de {area:603} restent invisibles jusqu'à leur attaque ; environ un sur trois porte un scalp.",
	-- {npc:4674} Hatefury Shadowstalker
	["grind on {npc:4674}"] = "",

	-- Step 22: Shadowprey Village
	-- {area:606} Gelkis Village
	["Head south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877} : pour {npc:715} à Strangleronce",

	-- Step 24: On the way
	["On the way"] = "",

	-- Step 25: Clam beds
	["Clam beds"] = "Bancs de praires",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "",
	["Underwater"] = "",
	-- {npc:12347} Enraged Reef Crawler
	["grind on {npc:12347}"] = "",

	-- Step 26: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "Oracles Ondulame",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "Continuez au nord jusqu'à {area:598}. Les Oracles se tiennent parmi les autres nagas à son extrémité nord ; attirez-les un par un.",
	-- {npc:4718} Slitherblade Oracle
	["grind on {npc:4718}"] = "",

	-- Step 27: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863} attend dans la tour en ruine de {area:2405}, dans les terres au sud-est.",

	-- Step 28: Ghost Walker Post
	["Head south-east to the post."] = "",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "La mission suivante de {npc:5641} vous envoie contre un seigneur démon escorté d'élites : passez-la.",

	-- Step 30: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 31: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 33: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "Depuis Proie-de-l'Ombre, prenez un vol pour {area:1638} et entraînez-vous auprès de {npc:3033} sur {area:1639}, puis prenez un vol pour {zone:1454}.",

	-- Step 34: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",

	-- Step 35: Back to Orgrimmar
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 37: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 38: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 39: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229} : pour {zone:1413}, plus loin sur l'itinéraire",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770} : pour {area:321} en Arathi, plus loin sur l'itinéraire",

	-- Step 40: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 41: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 42: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515} demande un {item:3388}, un objet d'{skill:171} : achetez-en un à l'hôtel des ventes ici si vous pouvez (ou demandez à un alchimiste). Sans potion, passez les étapes de l'élixir à {area:287}.",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388} : hôtel des ventes ou un alchimiste, pour {quest:515}.",

	-- Step 43: Brazier of Everfount
	-- {zone:1458} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {zone:1458} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "pour {npc:5901} : depuis Strangleronce, guide suivant",

	-- Step 44: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Retour à {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 46: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, pour {npc:2333}",

	-- Step 47: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Suivez la route au nord de {area:272} jusqu'aux contreforts d'Alterac. {quest:535} attend près du camp du Syndicat ; donnez-lui la bière.",

	-- Step 48: Syndicate missives
	["Syndicate missives"] = "Missives du Syndicat",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Les Détrousseurs et Larrons du Syndicat (32-33) autour des camps à l'ouest de la route portent les missives ; environ un sur trois en laisse tomber une.",

	-- Step 50: Daggerspine naga
	["Daggerspine naga"] = "Nagas Daguéchine",
	-- {area:271} Southshore
	["Head south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "",
	["Daggerspine shore"] = "Rivage des Daguéchine",

	-- Step 51: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs Aileron déchiré",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "Suivez le rivage vers l'ouest au-delà de la baie d'{area:271} ; les murlocs Aileron déchiré campent sur les plages plus loin.",
	["Torn Fin beach"] = "Plage des Aileron déchiré",

	-- Step 52: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Head back north to {area:272}, keeping west of {area:271}."] = "",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",

	-- Step 53: Shindigger keg
	["Shindigger keg"] = "Tonneau de Shindigger",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Le tonneau se trouve avec quelques autres au camp du Syndicat, sur la côte sud-est de {area:287}.",
	["Below ground"] = "",

	-- Step 54: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Head back north to {area:272}."] = "",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "",

	-- Step 55: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "Au sud-ouest, les Yétis des grottes et les Yétis féroces (30-31) peuplent les grottes des collines à l'ouest de {area:272} ; environ un sur seize porte le bâton.",

	-- Step 57: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "Les traîtres de {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens.\nCareful: Many guards stand in linked pairs and others patrol alone around the camp."] = "",

	-- Step 58: Hearth to Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth to {area:272}"] = "",

	-- Step 59: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "La tâche suivante de Thaivand se termine au cimetière d'{area:271} et le magus propose une mission de donjon : laissez les deux.",

	-- Step 61: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "",

	-- Step 62: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "",

	-- Step 65: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back south to {area:272}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back at {area:609}, every Kolkar can drop an ear."] = "De retour à {area:609}, chaque Kolkar peut laisser tomber une oreille.",
	-- ["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Faites d'abord vos achats à {area:1497}, puis volez jusqu'au {area:228}. {object:113791} se dresse sur la colline juste au sud-ouest : battez la Manifestation d'eau corrompue mineure à côté, placez ses bracelets dans le brasero, parlez à {npc:5895} et gardez {item:7813} pour {npc:5901}. Volez ensuite jusqu'à {area:272} depuis le {area:228}.",
	-- ["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt {npc:11256} beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for Islen. Fly on to {area:272} from the {area:228}."] = "Faites d'abord vos achats à {area:1497}, puis prenez un vol pour {area:228}. Le {object:113791} se dresse sur la colline juste au sud-ouest : vainquez la {npc:11256} corrompue à côté, placez ses brassards dans le brasero, parlez à la {npc:5895} et gardez l'{item:7813} pour Islen. Depuis {area:228}, prenez un vol pour {area:272}.",
	-- ["Fly to the {area:1497}"] = "Prenez un vol pour {area:1497}",
	-- ["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "Prenez un vol pour {area:392}. {npc:5901} campe sur la côte, un peu au sud de la ville.",
	-- ["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "Suivez la route au sud-ouest depuis Roche-Soleil jusqu'en {zone:1443}, puis vers le sud au-delà de {area:608}. La caravane de kodos de {npc:11625} attend au bord de la route, au nord de {area:609} ; si elle est déjà partie, continuez.",
	-- ["From {area:484}, fly to {area:1637}."] = "Depuis {area:484}, prenez un vol pour {area:1637}.",
	-- ["Gizelton caravan"] = "Caravane de Gizelton",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. Ricter, Alina and Dermot (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn {quest:556}."] = "Allez à l'ouest au pied des montagnes jusqu'au dôme violet de {area:279}. Ricter, Alina et Dermot (33-34) se tiennent ensemble au bord est du cratère, {npc:2414} (35) un peu à l'ouest d'eux ; chacun porte un fragment de pierre de sang. Les Défenseurs et Théurges de Dalaran (31-32) autour d'eux laissent tomber les runes usées pour {quest:556}.",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "Allez vers l'ouest au pied des montagnes jusqu'au dôme violet de {area:279}. {npc:2411}, {npc:2412} et {npc:2413} (33-34) se tiennent ensemble à l'intérieur du bord est du cratère, {npc:2414} (35) un peu à l'ouest ; chacun porte un morceau de pierre de sang. Les Défenseurs et Théurges de Dalaran (31-32) autour d'eux lâchent les Runes gravées usées.",
	-- ["Hearth back (or ride north if it is on cooldown)."] = "Utilisez votre Pierre de foyer (ou remontez au nord si elle n'est pas prête).",
	-- ["His next errand is not on this route."] = "Sa mission suivante ne fait pas partie de cet itinéraire.",
	-- ["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "Quittez {zone:1454} par la porte principale ; la tour des zeppelins se dresse juste au nord-est. Prenez le zeppelin pour {area:1497}.",
	-- ["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "Au nord, le long des collines de l'est, les satyres occupent les ruines de {area:603}. Les Traqueurs des ténèbres sont invisibles ; les quatre types qu'il vous faut ne le sont pas.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn"] = "Placez le {object:1729} sur la {object:1728} à côté de l'auberge",
	-- ["Ride back east to {area:272}."] = "Retournez à l'est jusqu'à {area:272}.",
	-- ["Ride back north to {area:272}, keeping west of {area:271}."] = "Retournez au nord jusqu'à {area:272}, en restant à l'ouest d'{area:271}.",
	-- ["Ride back south to the post."] = "Retournez au poste, au sud.",
	-- ["Ride back south to {area:272}."] = "Retournez au sud jusqu'à {area:272}.",
	-- ["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "Allez au nord au-delà du camp de {quest:535} jusqu'à {area:280}, le village tenu par le Syndicat (35-37). {npc:2431} porte la {item:3704} ; {quest:503} est enfermé dans une cage, dans la maison du côté nord.",
	-- ["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "Remontez la côte vers le nord. Les Praires géantes reposent dans les hauts-fonds et les Clampants des récifs enragés arpentent la plage ; ouvrez chaque praire dans vos sacs pour en obtenir la chair.",
	-- ["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "Allez au nord-est jusqu'à {area:609}. {quest:1365} (35) circule entre les tentes du côté est avec un ou deux Seigneurs de guerre (32-33) : nettoyez les alentours, puis attirez-le seul, en pleine santé.",
	-- ["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "Descendez au sud jusqu'à la côte, à l'est d'{area:271}. Les nagas Daguéchine bordent le rivage au sud-est de la ville.",
	-- ["Ride south-east to the post."] = "Allez au sud-est jusqu'au poste.",
	-- ["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "Allez au sud-ouest jusqu'au village troll sur la côte, en évitant {area:606} en chemin.",
	-- ["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "Allez au sud-ouest vers Proie-de-l'Ombre. Les centaures gelkis (32-35) autour de leur village sont un bon endroit : combattez-les jusqu'au niveau 32.",
	-- ["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "Allez à l'ouest jusqu'à {area:599}. Affaiblissez un Sectateur de la Lame ardente, puis utilisez la {item:6436} sur lui avant sa mort pour obtenir une {item:6435}. Ils laissent parfois tomber une {item:20310} (1-5 %) : si vous en obtenez une, lisez-la.",
	-- ["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "Le Prophète se tient du côté sud de {area:599}, à l'est de {area:2405}. Éliminez d'abord les sectateurs autour de lui.",
	-- ["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "La caravane descend vers le sud au-delà de {area:609}. Des pillards kolkar l'attaquent par vagues : tuez-les avant qu'ils n'atteignent {npc:11625}. Elle s'arrête près de {area:2617}, à l'est de {area:597}.",
	-- ["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "Le guide suivant commence à {area:1497}, au zeppelin de {object:3202}.",
	-- ["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "Votre maître est à {area:1638}, à un vol d'ici : {npc:3033} (druides) sur {area:1639}, {npc:246344} (paladins). De là, prenez un vol pour {area:460}.",
	-- ["Zeppelin to the {area:1497}"] = "Zeppelin pour {area:1497}",
	-- ["Zeppelin tower"] = "Tour des zeppelins",
	-- ["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "tuez des Poinçonneurs gelkis et des Chasse-vent gelkis à {area:606}, {zone:1443}",
	-- ["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093} entraîne les paladins à {area:1497}.",
	-- ["{npc:4551}, the bat handler"] = "{npc:4551}, le dresseur de chauves-souris",
	-- ["{npc:5639} waits in the {object:172959}; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639} attend dans {object:172959} ; {npc:5640} se tient dans {object:172961}, à l'ouest de la ville. Skyborne : {npc:4949} attend à Grommash Hold, dans {object:172957}.",
}
