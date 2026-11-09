-- French (frFR): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the {area:382}. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}."] = "",

	-- Step 3: Into Ashenvale
	-- {zone:1440} Ashenvale
	["Into {zone:1440}"] = "",
	-- {area:431} Splintertree Post
	["The road north to {area:431}"] = "",

	-- Step 4: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12696} Senani Thunderheart · {area:428} Night Run · {npc:12867} Kuray'bin · {quest:6503} Ashenvale Outrunners
	["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers {quest:6503}: leave it for the way back, at 22."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "",

	-- Step 5: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "En allant vers l'ouest, {npc:267214} est coincé dans un ravin au sud de la route principale, au sud-est d'{area:415}. Des Cerfs à corne noire et des Ours d'Ashenvale parcourent les bois tout autour.",

	-- Step 6: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Guidez {npc:271181} de {npc:267214} hors du ravin jusqu'à la route principale en moins de quatre minutes ; si la canalisation se rompt, redemandez à {npc:267214}.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, sur la route",

	-- Step 7: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "",

	-- Step 8: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "",
	["Naga brazier"] = "Brasero naga",

	-- Step 9: Naga heads
	["Naga heads"] = "Têtes de nagas",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Chaque naga Irequeue de la grève au nord de l'avant-poste lâche des têtes.",

	-- Step 10: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "",

	-- Step 11: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "À l'est de Zoram'gar, les furbolgs Crins-de-chardon remplissent le village et les collines autour de leur repaire.\nAttention : un Chaman à 15 % de vie ou moins fuit chercher de l'aide, ce qui peut attirer des furbolgs en plus.",

	-- Step 12: Thistlefur Hold
	["Thistlefur Hold"] = "Antre des Crins-de-Chardon",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "Dans le repaire, des Coffres de troll se trouvent le long des tunnels. {npc:12818} est retenu tout au fond : libérez-le et protégez-le jusqu'à la sortie, puis il rentre chez lui à {area:428}.\nAttention : deux embuscades scénarisées ont lieu, chacune composée de trois Crins-de-chardon (un Chaman, un Éclaireur et un Vengeur, une Ursa ou un Protecteur) : la première quand vous revenez à l'embranchement du tunnel dans la grotte, la seconde juste après la porte où rôde {npc:3987}.",
	["Below ground"] = "Sous terre",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "{npc:12818}, sous terre",

	-- Step 13: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "",

	-- Step 14: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12837} Yama Snowhoof
	["Fly to {area:431}: {npc:12837} waits in the inn for news of Ruul."] = "",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["Out of the inn and south down the road to the lumber camp: {npc:12867} stands there. The night elf Outrunners (23-24) stalk the woods south-east of it; they stealth, so watch for them."] = "",

	-- Step 16: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:431} Splintertree Post · {area:1637} Orgrimmar
	["Back north up the road to the {area:431} flight master and fly to {area:1637}."] = "",
	-- {area:431} Splintertree Post
	["{area:431} flight master"] = "",

	-- Step 17: Druid trainer
	["Druid trainer"] = "Maître des druides",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} en {zone:1412} ; {zone:1454} n'a pas de maître des druides",

	-- Step 19: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} se tient dans {object:172960}. Utilisez le {item:6626} sur le cercle d'invocation qui s'y trouve et vainquez la succube pour la lier.",

	-- Step 20: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "",
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391}, à {area:272}, enseigne les Poisons : gardez la quête",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 22: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} entraîne les paladins à {area:159}, à courte distance au nord par la route depuis les tours des zeppelins. Redescendez la même route pour la forêt des Pins argentés.",

	-- Step 23: Strange Lockbox
	-- {area:240} Dead Field · {object:177790} Strange Lockbox · {item:15882} Half Pendant of Aquatic Endurance · {area:228} Sepulcher
	["From the zeppelin towers, run south into Silverpine and west past the {area:240} to the coast: the {object:177790} lies at the bottom of very deep water there, beside an air fissure where you can breathe. Watch your breath on the way down. It holds the {item:15882} for Trial of the Sea Lion. Then on to the {area:228}."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "{item:15882}, dans le {object:177790}",

	-- Step 24: Sepulcher
	-- {area:228} Sepulcher · {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road to the {area:228}. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "",
	-- {npc:1937} Apothecary Renferrel · {area:272} Tarren Mill
	["{npc:1937}: Lydon in {area:272}, next guide"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril · {area:233} Ambermill
	["{npc:2121}: {quest:516}, south-east of {area:233}"] = "",

	-- Step 25: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "",
	-- {area:233} Ambermill · {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around {area:233}, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["The Ravenclaw undead haunt the ruins of {quest:516}, east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}.\nAn elite spirit (20) often stands beside the {object:645153}: pull the Ravenclaws away from the stone before you fight them."] = "",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, sur un {npc:1973}",
	-- {object:645153} Offering Stone · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "{item:271350}, sur les Âmes torturées parmi les ruines ; sous terre",

	-- Step 27: The Offering of Blood
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["The quest hands you a {item:210713}: use it beside the {object:645153} to offer your blood, then kill the elite spirit that answers.\n{quest:95883} is elite: grouping up is advised."] = "",
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone
	["{item:210713}, beside the {object:645153}: summons the elite spirit"] = "",

	-- Step 28: Into Hillsbrad
	-- {area:287} Hillsbrad
	["Into {area:287}"] = "",
	-- {area:285} Southpoint Tower
	["The road east to {area:285}"] = "",

	-- Step 29: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "De nouveau sur la route vers le sud. Là où elle tourne vers l'est dans {area:287}, {npc:2214} attend à {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214} : Darthalia à {area:272}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:8582}"] = "Retour à {npc:8582}",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "À l'est de Ziz, la KapitalRisk rase {area:461} ; l'un des Opérateurs porte les plans. {npc:4276} creuse dans la petite mine du côté est : restez avec lui pendant qu'il mine, des brutes de la KapitalRisk viennent l'attaquer.",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "À l'est de Ziz, la KapitalRisk rase {area:461} ; l'un des Opérateurs porte les plans. {npc:4276} creuse dans la petite mine du côté est : restez avec lui pendant qu'il mine, des brutes de la KapitalRisk viennent s'en prendre à lui.\nAttention : les kobolds arrivent par vagues. La première vague est composée de combattants au corps à corps, la seconde y ajoute des lanceurs de sorts. Les monstres normaux de la mine réapparaissent vite et peuvent rejoindre le combat pendant les vagues. Un groupe est recommandé.",
	-- ["Fly from {area:392} to {area:2897} on the {area:331} coast."] = "Volez de {area:392} jusqu'à {area:2897}, sur la côte d'{area:331}.",
	-- ["Fly to {area:1637} to train."] = "Volez jusqu'à {area:1637} pour vous entraîner.",
	-- ["Fly to {area:431} and head south down the road to the {area:1703}."] = "Volez jusqu'à {area:431} et descendez la route vers le sud jusqu'à {area:1703}.",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Volez jusqu'au {area:431} et descendez la route vers le sud jusqu'au {area:1703}.",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Suivez la route vers l'est le long de la rivière, puis montez vers le nord-est dans les collines jusqu'à {area:272}.",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Suivez la route vers le nord en direction du {area:467}. Des Coursiers à ramure ({npc:4018}) paissent en chemin ; Bêtes de sève ({npc:4020}), Coureurs crépusculaires ({npc:4067}) et Dragons-faë ({npc:4016}) parcourent les bois sous le pic, et les druides cénariens tiennent le bosquet là-bas.",
	-- ["Follow the road west to {area:460}."] = "Suivez la route vers l'ouest jusqu'à {area:460}.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {area:331}. Open the {item:16783} he gives you."] = "Depuis la {area:380}, suivez la route vers le nord. {npc:8582} se tient sur la tour de guet de {area:1703}, là où la route entre en {area:331}. Ouvrez la {item:16783} qu'il vous donne.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "Depuis {area:380}, suivez la route vers le nord. {npc:8582} se tient sur la tour de guet du {area:1703}, là où la route entre en {zone:1440}. Ouvrez {item:16783} qu'il vous donne.",
	-- ["Gaea Dirt Mounds"] = "Monticules de poussière de Gaea ({object:177929})",
	-- ["Gaea Seeds"] = "Graines de Gaea ({item:16205})",
	-- ["Head back down the {area:1076} to {area:2539}."] = "Redescendez {area:1076} jusqu'à {area:2539}.",
	-- ["Head south to the {area:380}, then west along the road out of the {area:17} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Allez vers le sud jusqu'à la {area:380}, puis vers l'ouest par la route qui quitte les {area:17} pour entrer dans les Serres-Rocheuses. Le village troll de {area:2539} se trouve à l'entrée du canyon.",
	-- ["Head west along the main road across {area:331}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Allez vers l'ouest par la route principale à travers {area:331}, en passant {area:415} (Alliance : restez sur la route), jusqu'à la côte. {area:2897} est sur {area:414}, au nord-ouest. Ses autres quêtes sont pour la prochaine visite, au niveau 27.",
	-- ["Hearth to {area:460}"] = "Pierre de foyer vers {area:460}",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and head south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Si vous connaissez déjà le trajet aérien de {area:272}, volez-y et passez directement à {area:272}. Sinon, volez de {zone:1458} jusqu'au {area:228} et descendez la route vers le sud en passant Bois-du-Bûcher. Les morts-vivants Ravenclaw hantent les ruines de {area:231}, à l'est de la route, au sud-est de la forêt ; un {npc:1973} lâche le {item:271343} qui mène à la {object:645153}.",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Si vous connaissez déjà le trajet aérien de {area:272}, volez-y et passez directement à {area:272}. Sinon, volez de {zone:1458} au {area:228} et descendez la route vers le sud en passant Bois-du-Bûcher. Les morts-vivants Ravenclaw hantent les ruines de {area:231} à l'est de la route, au sud-est de la forêt ; un {npc:1973} lâche {item:271343} qui mène à {object:645153}.",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Continuez vers le nord sur la route. {npc:12862} attend au camp de bûcherons Warsong, au sud de Bois-brisé.",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "En chevauchant vers l'ouest, {npc:267214} est coincé dans un ravin au sud de la route principale, au sud-est d'{area:415}. Des Cerfs à corne noire ({npc:3817}) et des Ours d’Ashenvale ({npc:3809}) parcourent les bois tout autour.",
	-- ["Paladin trainer"] = "Maître des paladins",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "Redescendez {area:1076} jusqu'à {area:2539}.",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Chevauchez vers l'est jusqu'à {area:380} et volez jusqu'à {zone:1454}. Prenez le zeppelin aux tours devant {zone:1454} pour {zone:1420} ; {area:1497} se trouve sous les {area:153}. Le maître des chauves-souris est dans {object:36078}.",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Chevauchez vers le sud jusqu'à {area:380}, puis vers l'ouest sur la route pour quitter {zone:1413} et entrer dans les Serres-Rocheuses. Le village troll de {area:2539} se trouve à l'entrée du canyon.",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Chevauchez vers l'ouest sur la route principale à travers {zone:1440}, en passant {area:415} (Alliance : restez sur la route), jusqu'à la côte. {area:2897} se trouve sur {area:414} au nord-ouest. Ses autres quêtes sont pour la prochaine visite, au niveau 27.",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Au sud-ouest de Roche-Soleil s'étend le {area:465}. Plantez les Graines de Gaea dans les monticules de terre au fond de la vallée ; les élémentaires de feu lâchent {item:16312}. Harpies et Embusquées Rougefurie nichent au nord, Tueuses et Volplumes au sud.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Parlez à {npc:10181}, dans {object:36126} : {quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "Sputtervalve à {area:392} : le prochain guide y passe",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "Les Graines de Gaea ({item:16205}) se trouvent dans l'herbe autour de la rive sud du {area:464}, au nord de Roche-Soleil.",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "Les Graines de Gaea se trouvent dans l'herbe autour de la rive sud du {area:464}, au nord du Roc-Soleil.\nAttention : les Fièrailes autour du lac peuvent attaquer en groupe lié.",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "La route grimpe vers le nord : c'est {area:1076}. {quest:1483} a une cabane là où la route bifurque vers l'est en direction de {area:461}.",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} patrouille sur la route à l'est de {area:428}, en direction de {area:430}.",
	-- ["To the {area:1497}"] = "Vers {area:1497}",
	-- ["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Utilisez {npc:212753} à {object:645153} pour un sacrifice consentant et tuez {npc:212753} qui répond. {quest:95883} est élite : il est conseillé de se grouper.",
	-- ["{area:380} flight master"] = "Maître de vol de la {area:380}",
	-- ["{area:431} is just north up the road."] = "{area:431} est juste au nord sur la route.",
	-- ["{area:465}: kill these as you meet them"] = "{area:465} : tuez-les au passage",
	-- ["{item:16746}, from the {item:16783}"] = "{item:16746}, dans la {item:16783}",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, sur les Âmes torturées parmi les ruines",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, sur n'importe quelle harpie Rougefurie",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860} : Héliolites lumineuses ({item:277936}) sur les harpies Rougefurie",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860} : Grish est au {area:1718}, dans le prochain guide",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, à côté de {npc:11862}",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}, en haut sur la corniche",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} se tient à {area:428}, le camp Warsong juste au nord-est de Bois-brisé, à côté du tableau de chasse.",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board.\nNorth up the road to {area:431} and {area:428} beside it."] = "{npc:12696} se tient à {area:428}, le camp Chanteguerre juste au nord-est de Bois-Brisé, à côté du tableau de chasse.\nRemontez la route vers le nord jusqu'à {area:431} et {area:428}, juste à côté.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {area:331} visit, at 27."] = "Les cibles de chasse de {npc:12696} (Ursangous, Shadumbra, Serres-tranchantes) sont pour la prochaine visite en {area:331}, au niveau 27.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "Les cibles de chasse de {npc:12696} (Ursangous, Shadumbra, Serres-tranchantes) sont pour la prochaine visite en {zone:1440}, au niveau 27.",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} à Zoram'gar, au niveau 27",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} se tient au camp de bûcherons. Les Coursiers elfes de la nuit rôdent dans les bois au sud-est ; ils sont camouflés, alors restez attentif.",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} aux {zone:1456} ; {zone:1454} n'a pas de maître des paladins",
	-- ["{npc:3995}, below ground"] = "{npc:3995}, sous terre",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {area:331}. Skip it."] = "La quête suivante de {npc:4198}, Ordanus, se trouve du côté Alliance d'{area:331}. Passez-la.",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "La quête suivante de {npc:4198}, Ordanus, se trouve du côté Alliance d'{zone:1440}. Passez-la.",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}, devant la porte",
	-- ["{npc:4201}, inside"] = "{npc:4201}, à l'intérieur",
	-- ["{npc:4276}, below ground"] = "{npc:4276}, sous terre",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606} se tient dans {object:36070}.",
	-- ["{quest:1483}, inside"] = "{quest:1483}, à l'intérieur",
	-- ["{zone:1442}: kill these as you meet them"] = "{zone:1442} : tuez-les au passage",
	-- ["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",
}
