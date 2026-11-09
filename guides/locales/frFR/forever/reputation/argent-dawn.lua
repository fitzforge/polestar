-- French (frFR): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Réputation : Aube d'argent",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "Pierres du Fléau, {area:2057} et {area:2279} : les enchantements de résistance d'épaules et une douzaine de recettes.",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "Recettes pour tailleurs, travailleurs du cuir, forgerons, enchanteurs et alchimistes à Honoré et Révéré",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Alliance)",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10840} se tient au {area:3197}, dans le sud des {zone:1422}. {object:2160} commence à Neutre 200 pour tout le monde. Portez le bijou Brevet quand vous combattez le Fléau : les Pierres du Fléau ne tombent que si vous le portez. {npc:11039}, à la {area:2268}, donne le même Brevet ; vous ne pouvez en prendre qu'un.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horde)",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "{npc:10839} se tient au {area:152}, sur la route qui mène des {zone:1420} aux {zone:1422}. {object:2160} commence à Neutre 200 pour tout le monde. Portez le bijou Brevet quand vous combattez le Fléau : les Pierres du Fléau ne tombent que si vous le portez. {npc:11039}, à la {area:2268}, donne le même Brevet ; vous ne pouvez en prendre qu'un.",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "De Neutre à Amical : le Fléau des {zone:1422}",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "Chaque monstre du Fléau tué dans les Maleterres donne 5 de réputation (les monstres nommés 15), des goules et squelettes de niveau 50 vers le haut ; au niveau 60, choisissez ceux de niveau 53 et plus, car dans Classic les monstres gris ne donnent qu'environ un cinquième. De Neutre à Amical, il faut 2 800 : environ 560 victimes, moins avec les quêtes des Maleterres en chemin. Le Fléau le plus dense se trouve autour des quatre Chaudrons du Fléau : le {area:199} à l'ouest d'Andorhal (squelettes, 50-53), {area:200} au nord d'Andorhal (zombies et goules, 52-55), le {area:202} au sud (goules, 54-55) et {area:201} à l'est (fantômes, 56-57). Gardez chaque Pierre du Fléau et chaque quête que vous pouvez mettre de côté : les rendus comptent toujours, les victimes non. Les {quest:5510} tombent sur environ quatre de ces monstres du Fléau sur dix, celles des envahisseurs sur environ un tiers de ceux de niveau 56 et plus. Si vous mourez, retirez le Brevet puis remettez-le : il peut perdre son effet. Paladins (humains et nains) : {npc:10838}, au {area:3197}, demande une fois 20 {quest:5510} pour La dissipation du mal, 100 de réputation au lieu de 25. L'atout d'Héritage Diplomate ajoute jusqu'à 10 % à chaque gain.",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "{quest:5510} : gardez-les",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "Âmes en peine affamées à {area:201} ; tout monstre du Fléau compte",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "Goules dévastées au {area:202}",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "Quêtes des Maleterres et Chaudrons du Fléau",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "{npc:11056} : demandez un {item:13370}",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "{npc:11057}, au {area:152} : demandez un {item:13370}",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}"] = "le chaudron de {area:201}",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "Résonateurs ectoplasmiques : les fantômes autour du chaudron",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "{item:13320}, 50 pièces d'argent",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "Quêtes de la {area:2268}",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243254} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243254} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "La {area:2268}, du côté est des {zone:1423}, est le foyer de l'{faction:529} : {npc:11039}, {npc:11035} et {npc:243254} donnent ses quêtes de donjon, de 100 à 200 de réputation chacune et environ 1 700 au total. Ce sont des quêtes de groupe pour {area:2279} et {area:2057} (niveau 58-60, cinq joueurs) : prenez celles que votre groupe fera. La suite du duc se termine au {object:176317}, un coffre d'équipement de l'{faction:529}.",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "{area:2279} est un donjon pour cinq à l'extrémité nord des {zone:1423}. Ses monstres du Fléau donnent 5 de réputation par victime jusqu'au dernier point d'Honoré, et ses boss du Fléau 25 jusqu'à Exalté ({npc:10440} 50), chacun avec une {item:12843}. Les Sentinelles de la Garde noire près du baron donnent 5 jusqu'à Exalté. Le côté du Fléau, par l'entrée de service, rapporte bien plus que le côté écarlate.",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "Échantillons de chair pestiférée : le Fléau à l'intérieur",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "{item:13180} : les caisses de ravitaillement",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "{npc:10811}, côté écarlate",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire au sud-est des {zone:1422} ; les quêtes de {area:2057} de votre camp donnent la {item:13704} qui l'ouvre. C'est le meilleur donjon pour l'{faction:529} : ses monstres donnent 5 jusqu'au dernier point d'Honoré, et ses treize boss environ 375 de réputation pour un nettoyage complet, plus une dizaine de {quest:5508} (environ 250 de plus). {npc:10508} et {npc:1853} donnent 50 chacun.",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "{quest:5529}, dans le couvoir",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "De retour à la {area:2268}",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243254} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243254} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "{quest:5212} mène à {quest:5213} (les {item:13176} dans une ziggourat de {area:2279}), qui récompense par le {item:13209} ou la {item:19812} : de meilleurs bijoux qui font aussi tomber les Pierres du Fléau, ils peuvent donc remplacer le Brevet. {quest:5251} mène ensuite à la {item:13250} et à {npc:10440}. Une {item:13920}, un butin rare (environ 6 %) sur les {quest:5529} une fois {quest:5529} terminée, lance une quête qui rapporte 50 à chaque fois : gardez-les jusqu'à Révéré. {npc:10267}, dans les {zone:1428}, à la fin de ses quêtes du {area:1583}, vous envoie à {npc:243254} (75) puis au {item:12368} de {npc:11035} dans {area:2057} (25 et 200).",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "D'Amical à Honoré : pierres et monstres nommés du Fléau",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "Les monstres normaux du Fléau hors des donjons cessent de donner de la réputation à mi-chemin d'Amical (3 000 sur 6 000) ; {npc:10826}, {npc:10821} et {npc:10825} s'arrêtent à la fin d'Amical. Ensuite, seuls Araj, les monstres de {area:2057} et de {area:2279}, les livraisons aux chaudrons et les Pierres du Fléau comptent. Rendez maintenant les pierres mises de côté : {npc:11039}, à la {area:2268}, prend les trois sortes, tout comme les officiers du {area:3197} et du {area:152}. Chaque rendu rapporte 25 et une {item:12844} : gardez 35 marques pour les mantelets à Révéré et Exalté. Les {quest:5509} valent deux fois plus par pierre : les Adeptes noirs, Ombremages, Tisseurs d'effroi et Champions du Fléau (niveau 58-60) de {area:2272}, juste au nord de la {area:2268}, en laissent tomber environ une fois sur trois ou plus, à côté du lieu de rendu. Les monstres nommés du Fléau ci-dessous laissent tomber une {item:12843} une fois sur deux ou plus ({npc:1850} deux fois sur trois, Araj et {npc:10821} une fois sur deux) et donnent 15 par victime, Araj jusqu'à Exalté ; {npc:1850} ne donne aucune réputation, seulement la pierre. Amical débloque les Biscuits enrichis en manne (60 pièces d'argent) chez les intendants.",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "{item:12843} : les monstres nommés du Fléau ci-dessous, et les boss de donjon",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "Adeptes noirs et Ombremages à {area:2272}",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "{npc:1852}, Andorhal",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "{npc:1850}, {zone:1422} : la pierre seulement",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "{quest:5510} : 20 pour 25 de réputation",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "{quest:5509} : 10 pour 25 de réputation",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "{quest:5508} : 1 pour 25 de réputation",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "D'Honoré à Révéré : donjons et pierres",
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "D'Honoré à Révéré, il faut 12 000 : environ 2 400 monstres de {area:2057} et de {area:2279}, moins avec leurs boss. Leurs monstres s'arrêtent à 11 999 sur 12 000 d'Honoré ; un boss ou un rendu vous fait passer le cap. En solo, seuls les Pierres du Fléau, les livraisons aux chaudrons et Araj comptent : 12 000, c'est 480 rendus, ou 4 800 {quest:5509}. Gardez les pierres obtenues dans les donjons jusqu'à ce que leurs monstres ne comptent plus. Honoré débloque des recettes chez les trois intendants : {npc:11536} à la {area:2268}, {npc:10857} au {area:3197}, {npc:10856} au {area:152}. Ainsi que le {item:22014} (133 pièces d'or) pour la quête Les trois rois des flammes.",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "{item:19446}, 3 pièces d'or",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "{item:19216} ({skill:197}), 2 pièces d'or 20 pièces d'argent",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "{item:19328} ({skill:165}), 2 pièces d'or 20 pièces d'argent",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "{item:19203} ({skill:164}), 2 pièces d'or 20 pièces d'argent",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "{item:13482} ({skill:171}), 1 pièce d'or 50 pièces d'argent",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "{item:19442} ({skill:129}), 10 pièces d'or",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5504} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5504} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "À Révéré, {npc:11536} prend 10 Marques de valeur de l'Aube d'argent pour {quest:5504} (100 de réputation). Ensuite, tout intendant de l'{faction:529} vend les cinq enchantements d'épaules pour 10 pièces d'or chacun : Flammes, Givre, Arcanes, Nature et {item:18173}, +5 à la résistance correspondante. Révéré débloque aussi le {item:13810} et son jus (60 pièces d'argent) ainsi que les recettes de Révéré.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "Marques de valeur de l'Aube d'argent, des rendus de pierres",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "{item:18170} : choisissez la résistance dont vous avez besoin, 10 pièces d'or",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "{item:19447}, 6 pièces d'or",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "{item:19217} ({skill:197}), 4 pièces d'or",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "{item:19329} ({skill:165}), 4 pièces d'or",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "{item:19205} ({skill:164}), 4 pièces d'or",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "De Révéré à Exalté",
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "De Révéré à Exalté, il faut 21 000 : 840 rendus de Pierres du Fléau ou de livraisons aux chaudrons, ou les boss de donjon avec leurs {quest:5508} (un nettoyage complet de {area:2057} rapporte environ 600). Rendez chaque pierre et chaque {item:13920} mises de côté.",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "À Exalté, {npc:11536} prend 25 Marques de valeur de l'Aube d'argent pour le {quest:5517} (150 de réputation) : +5 à toutes les résistances, sur vos épaules. Ensuite, les intendants en vendent d'autres pour 40 pièces d'or chacun.",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "Marques de valeur de l'Aube d'argent",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "Pierres du Fléau des corrupteurs et donjons jusqu'à Révéré",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) laissent tomber ici des Pierres du Fléau des envahisseurs, ainsi que des pierres des serviteurs et de l'{item:14047}. Rendez celles des envahisseurs par 10 et celles des serviteurs par 20 à {npc:11039} à {area:2268}. En Classic, les deux ne rapportent plus de réputation à partir d'Honoré.",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "À partir d'Honoré, les Pierres du Fléau des corrupteurs (une par remise) et les morts du Fléau à {area:2279} et à {area:2057} apportent la réputation. Les pierres des corrupteurs tombent des boss du Fléau de ces donjons ({npc:1853}, {npc:10433}, Vectus) ainsi que de {npc:1852} et Putridius dans {zone:1422}. Enchaîner les donjons rapporte plus vite que tout farm en extérieur.",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Les goules et squelettes de tout {zone:1422} laissent tomber des Pierres du Fléau des serviteurs environ une fois sur deux ; ce secteur est dense. Rendez-les par 20 à n'importe quel officier de l'Aube d'argent (Pureheart à {area:3197}, Garush à {area:152}, {npc:11039} à {area:2268}). Chaque remise rapporte aussi une {item:12844} pour les intendants de l'Aube d'argent.",
	-- ["Invader's Scourgestones to Honored"] = "Pierres du Fléau des envahisseurs jusqu'à Honoré",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Continuez {area:2279} et {area:2057} et rendez chaque {item:12843} à {area:2268} jusqu'à Exalté.",
	-- ["Minion's Scourgestones to Friendly"] = "Pierres du Fléau des serviteurs jusqu'à Amical",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Faites {area:2279} (les deux ailes) et {area:2057} en tuant tous les membres du Fléau croisés.",
	-- ["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return ({area:199}'s pair is level 53: in Classic it pays three fifths at 60), then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "Les quêtes des Maleterres rapportent tout au niveau 60 si elles sont de niveau 55 ou plus et comptent toujours, environ 1 500 au total ; les guides de progression les parcourent. La suite des chaudrons de {npc:11053} au {area:3197} (Horde : {npc:11055} au {area:152}) : 150 par chaudron avec son retour (la paire du {area:199} est de niveau 53 : dans Classic, elle rapporte trois cinquièmes au niveau 60), puis Mission accomplie ! 200. Hélas, Andorhal 150 ({npc:1852}, élite). À la {area:2268}, les quêtes de {area:2262} de {npc:11063} (Frère Carlin 50, de Chromie à Andorhal, Vilains de Darrowshire 100, Les maraudeurs du Darrowshire 100) et Trésors cachés de {npc:10926}, 200, à la fin de l'histoire de {area:2262} ; {npc:12250} 75, de {npc:11038}. Après Mission accomplie !, chaque chaudron accepte une livraison répétable : 25 de réputation à chaque fois, jusqu'à Exalté. {npc:11056} au {area:3197} (Horde : {npc:11057} au {area:152}) vous donne un {item:13370}, sans lequel les composants ne tombent jamais, et vend des Catalyseurs des arcanes pour 50 pièces d'argent (un par livraison ; il se désagrège au bout de 30 minutes, alors achetez-le en dernier). Chaque livraison demande aussi 4 {item:14047}. Récoltez à {area:201} : ses fantômes laissent tomber un {item:13354} environ une fois sur quatre, donc environ 16 victimes remplissent une livraison ; les autres chaudrons veulent 5 ou 6 composants qui tombent une fois sur dix ou moins. Une fois que le Fléau des Maleterres ne compte plus, cela rapporte environ quatre fois plus que leurs Pierres du Fléau seules.",
	-- ["{faction:529} to Exalted"] = "{faction:529} jusqu'à Exalté",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} commence au niveau Neutre. Prenez le brevet auprès de {npc:10839} à {area:152} et portez-le : en Classic, les Pierres du Fléau ne tombent que si le bijou {quest:5401} est équipé. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} commence au niveau Neutre. Prenez le brevet auprès de {npc:10840} à {area:3197} et portez-le : en Classic, les Pierres du Fléau ne tombent que si le bijou {quest:5401} est équipé. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
}
