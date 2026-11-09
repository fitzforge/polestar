-- French (frFR): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Réputation : Thunder Bluff",
	-- {zone:1412} Mulgore · {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth
	["{zone:1412} quests while you level, {zone:1452} quests and {item:11040} from 55, then {item:14047} to Exalted."] = "",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "Exalté : {faction:81}",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "{faction:81} : comment ça marche",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "",

	-- Step 2: Camp Narache (optional hub)
	-- {area:221} Camp Narache
	["{area:221} (optional hub)"] = "{area:221} (étape facultative)",
	-- {area:221} Camp Narache · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["Forever pays these old quests in full at any level. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "",

	-- Step 3: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "{npc:2991} et les plaines",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "La tente de {npc:2991} est au sud-est du camp ; la cruche d'eau est près du puits voisin. Des trotteurs des plaines paissent tout autour.",

	-- Step 4: Camp Narache: hand in
	-- {area:221} Camp Narache
	["{area:221}: hand in"] = "{area:221} : rendez les quêtes",

	-- Step 5: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "{npc:2982} et les pumas",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "{npc:2982} est assis sur la colline au sud du camp ; les Pumas des montagnes vivent dans ces collines.",

	-- Step 6: Camp Narache: the Battleboars
	-- {area:221} Camp Narache
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{area:221}: the Battleboars"] = "{area:221} : les Sangliers de guerre",

	-- Step 7: Brambleblade Ravine
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {area:358} Brambleblade Ravine · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold {area:358} beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "Les sangliers de guerre ({quest:780}) paissent à l'est du camp ; les hurans Dos-hirsute et {npc:8554} tiennent le {area:358} au-delà. Une {item:4851} se trouve dans le ravin : la lire lance {quest:781}.",

	-- Step 8: Camp Narache: last hand-in
	-- {area:221} Camp Narache
	["{area:221}: last hand-in"] = "{area:221} : dernière remise",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "{quest:763}, +75 : à {npc:2993}",

	-- Step 10: Bloodhoof Village (optional hub)
	-- {area:222} Bloodhoof Village
	["{area:222} (optional hub)"] = "{area:222} (étape facultative)",
	-- {area:222} Bloodhoof Village · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["Forever pays these old quests in full at any level. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes. {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "",

	-- Step 11: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "L'est de {zone:1412}",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest."] = "",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "la {object:2908}",

	-- Step 12: Bloodhoof Village: hand in
	-- {area:222} Bloodhoof Village
	["{area:222}: hand in"] = "{area:222} : rendez les quêtes",

	-- Step 13: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "La mine, les centaures et les plaines",
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes · {zone:1412} Mulgore
	-- plural, as words: Swoops = {npc:2970} Swoop
	["Back to the mine for the workers, supervisors and {quest:765} in the back: his {item:281031} start {quest:98424}, and its other pages lie inside the mine. The Galak centaurs and Herak camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "",
	-- {item:281031} Mulgore Expansion Plans · {quest:765} Supervisor Fizsprocket
	["{item:281031}, from {quest:765}"] = "",
	-- {item:281035} Shredder Operation Instructions
	["{item:281035}, inside the mine"] = "",

	-- Step 14: Morin Cloudstalker
	-- {quest:98427} Ceasing Operations · {quest:98424} Fizsprocket's Notes
	["{quest:98427}, +150: needs {quest:98424}"] = "",

	-- Step 15: The Venture Co. Mine: the Clearcutter
	-- {area:360} The Venture Co. Mine
	["{area:360}: the Clearcutter"] = "",
	-- {quest:98427} Ceasing Operations
	["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "",

	-- Step 16: Bloodhoof Village: last hand-in
	-- {area:222} Bloodhoof Village
	["{area:222}: last hand-in"] = "{area:222} : dernière remise",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "{quest:99082}, +10 : à {npc:3057} ({faction:81})",

	-- Step 18: Gloomrise (optional hub)
	-- {area:17044} Gloomrise
	["{area:17044} (optional hub)"] = "{area:17044} (étape facultative)",
	-- {area:17045} Skywatcher Plateau · {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["Forever pays these old quests in full at any level. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes, plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "{npc:264074} : {quest:96241} (Sombrelance +100)",

	-- Step 19: Gloomrise
	-- {area:17044} Gloomrise · {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["{area:17044} is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "{area:17044} est le cimetière tauren au nord de la ville ({faction:81}). Utilisez l'{item:273015} sur les Cadavres rongés. {npc:264082} attend en son cœur ; son corps porte un {item:273658} : lisez-le pour lancer {quest:96294}.",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, sur les Tisseuses de la cime du Chagrin",

	-- Step 20: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "Le camp des Guetteurs du ciel : rendre les quêtes",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "",

	-- Step 21: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise
	["{npc:264082}, at the heart of {area:17044}"] = "",

	-- Step 23: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "À partir d'ici, ce sont les étoffes. La laine, la soie et le tisse-mage doivent tous être donnés avant que {npc:14728} propose le don d'{item:14047}, et {quest:7825} demande le don d'{item:14047}. Achetez les étoffes à l'hôtel des ventes, ou farmez-les : les humanoïdes en laissent, la laine du niveau 15 à 25, la soie 25 à 40, le tisse-mage 40 à 50, l'{item:14047} 50 et plus. Au niveau 60, farmez des monstres de niveau 52 ou plus : les plus bas sont gris.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592} : les furbolgs Crin-de-Chardon en laissent environ une fois sur quatre",

	-- Step 24: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Soie : le Syndicat à {area:287} et en Alterac en laisse environ une fois sur trois, ou achetez-la.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306} : le Syndicat",

	-- Step 25: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Tisse-mage : les satyres Jadefeu du sud de {zone:1448} et les ogres Cognedune de {zone:1446} en laissent environ une fois sur trois, ou achetez-le.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338} : les satyres Jadefeu",

	-- Step 26: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047} : la Croisade écarlate à {area:2266} dans les {zone:1423}, les ogres Gordok devant {area:2577} à {zone:1444} et les camps du Crépuscule de {zone:1451} en laissent environ une fois sur trois. L'hôtel des ventes est plus rapide si vous avez de l'or.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047} : la Croisade écarlate devant {area:2266}",

	-- Step 27: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius · {area:2255} Everlook
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of {area:2255}: wait on a hilltop for him."] = "Les quatre quêtes de {npc:10303} sont de niveau 56 à 60 : elles paient donc en entier, 400 de réputation {faction:81}. {npc:10806}, un ours élite, fait une boucle sur les quatre collines au nord de {area:2255} : attendez-le au sommet d'une colline.",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "{npc:10806}, élite",

	-- Step 28: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "{npc:10807} et {quest:5056}",
	-- {npc:10807} Brumeran · {area:2255} Everlook · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of {area:2255}. For {quest:5056}, kill frostsabers north of {area:2255} until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around {area:2255} sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "{npc:10807}, une chimère élite, apparaît au sud de {area:2255}. Pour {quest:5056}, tuez des sabres-de-givre au nord de {area:2255} jusqu'à obtenir de la {item:12733} (environ une fois sur dix), puis utilisez la viande à la pierre de Shy-Rotam, loin au nord, et tuez le grand félin qui arrive. Si vous avez fait les quêtes Gardiens sauvages de {npc:10306} (le guide {zone:1454}), les chouettards affolés, lunaires et berserks autour de {area:2255} laissent parfois un {item:12558} : il lance {quest:4882}, 50 de réputation {zone:1454} puis 100 de réputation {faction:81} en entier.",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "{npc:10807}, élite",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "{item:12733}, sur les sabres-de-givre",

	-- Step 29: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring
	["{npc:10306} stands at {area:1997}, through the Timbermaw tunnel south of {zone:1452}."] = "{npc:10306} se tient au {area:1997}, de l'autre côté du tunnel des Grumegueules au sud du {zone:1452}.",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "{quest:4882}, +100 : à {npc:5770} ({faction:81})",

	-- Step 30: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {area:1639} Elder Rise · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {area:1639}, beside {npc:5769}."] = "{npc:5770} se tient sur la {area:1639}, à côté de {npc:5769}.",

	-- Step 31: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (optionnel)",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50. {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "",

	-- Step 32: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "Presque toutes les bêtes, plantes et silithides du cratère laissent de la terre ({quest:3761}), environ une fois sur trois (les Pétale-de-sang et les guêpes Gorishi environ une fois sur deux), et les monticules de terre en donnent aussi. Prenez-en bien plus de 20 : chaque enveloppe en utilise 2, environ 18 pour chaque remise de {item:11040}.",

	-- Step 33: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "{npc:9076} prend la terre. {npc:9087} vend la {item:11020} (1 po) et des paquets de graines de Tharlendris (10 pa chacun). Avec un paquet de graines et 2 portions de terre ({quest:3761}) dans vos sacs, utilisez la bourse : elle fait pousser une enveloppe ({item:11024}), une fois toutes les 10 minutes. Ouvrez chaque enveloppe : environ une sur trois contient 1 à 5 {item:11040}, les autres des herbes communes. Utilisez la bourse dès qu'elle est prête pendant que vous suivez le reste de ce guide.",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "{item:11020}, 1 po",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "{item:11022}, 10 pa chacun",

	-- Step 34: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "{item:11040} en chemin",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "{item:11040} : utilisez la bourse toutes les 10 minutes et ouvrez les enveloppes ; {npc:9087} la prend",

	-- Step 35: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {area:1639} Elder Rise · {item:11040} Morrowgrain
	["{npc:9087} stands on {area:1639}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "{npc:9087} se tient sur la {area:1639}. Si vos 10 {item:11040} ne sont pas encore prêtes, passez cette étape et continuez avec les étoffes : les étapes des étoffes ci-dessous indiquent aussi la remise de {item:11040}.",

	-- Step 36: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} jusqu'à Honoré",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7825} : 20 {item:14047} pour 50 de réputation, autant de fois que vous voulez. D'Amical à Honoré, il faut 6 000 : 120 remises, 2 400 {item:14047}, moins ce que les quêtes vous ont donné (un tauren commence à Amical 1 000 : 100 remises ; un mort-vivant à Neutre 500 a d'abord besoin de 50 de plus pour atteindre Amical). Rendez chaque lot de 20 que vous portez, l'un après l'autre.",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "{item:11040}, si vous en faites pousser : {npc:9087} la prend",

	-- Step 37: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} jusqu'à Révéré",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {area:1584} Blackrock Depths · {area:340} Kargath · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. {area:1584} pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at {area:340} ({npc:9017}, 150 in full)."] = "D'Honoré à Révéré, il faut 12 000 : 240 remises, 4 800 {item:14047}, moins si vous rendez aussi de la {item:11040}. Les {area:1584} rapportent aussi : les deux quêtes Discordance des flammes de Thunderheart à {area:340} ({npc:9017}, 150 en entier).",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "{item:11040}, si vous en faites pousser",

	-- Step 38: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} jusqu'à Exalté",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {area:222} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Révéré à Exalté, il faut 21 000 : 420 remises, 8 400 {item:14047}. Pour la Horde ! (la tête de Rend) et Le seigneur de Rochenoire (la tête de Nefarian) rapportent 200 à chaque ville de la Horde. À Exalté, {npc:3685} au {area:222} vend les kodos à toutes les races de la Horde : 20 po pour un kodo de niveau 40, 200 po pour un grand kodo au niveau 60 (les prix de Forever) ; dans Classic, les autres races devaient être Exaltées pour les acheter.",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "{npc:3685} : les kodos",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the mine for the workers, supervisors and {quest:765}. The Galak centaurs and {npc:275767} camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "Retour à la mine pour les ouvriers, les superviseurs et {quest:765}. Les centaures galaks et {npc:275767} campent à l'est du village. Les Rapaces volent partout dans {zone:1412} ; les harpies Furie-des-vents nichent au sud-est du village ; les gnolls Crin-pâle campent à l'ouest.",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en laissent tomber ici ; chaque Fléau tué ici compte aussi pour {object:92525} (voir ce guide). L'Hôtel des ventes convient aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les Ogres Cognedune (niveau 45-48) en laissent tomber ici. L'Hôtel des ventes convient aussi.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes (60 at a fifth), plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. Le camp du Cercle terrestre sur le {area:17045}, au nord-ouest de la ville ({faction:81}) : 300 de réputation {faction:81} en 20 minutes (60 au cinquième), plus 100 chacun pour {zone:1454} et les Trolls Sombrelance et 450 de Cercle terrestre. {npc:259118}, {npc:264074} et {npc:264072} se tiennent dans le camp.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes (220 at a fifth). Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. {area:221}, à l'extrémité sud de {zone:1412} : environ 1 100 de réputation {faction:81} en 25 minutes (220 au cinquième). Les quêtes de la zone de départ ne donnent rien aux autres villes. {npc:2980} et {npc:2981} se tiennent dans le camp, {npc:3209} à sa lisière.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes (200 at a fifth). {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. {area:222} et l'est de {zone:1412} : environ 1 000 de réputation {faction:81} en 45 minutes (200 au cinquième). {npc:2993} se tient au milieu du village ; {npc:2947}, {npc:2985} et {npc:3222} tout près ; {npc:2988} attend à l'est du village au bord de la route.",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7825} jusqu'à être Exalté auprès de {faction:81}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'Hôtel des ventes.",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7825}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'Hôtel des ventes.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Les Centaures kolkar (niveau 30-33) en laissent tomber ici. L'Hôtel des ventes convient aussi.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Les Massacreurs de la KapitalRisk de la {area:381} (niveau 16-17) en laissent tomber ici. L'Hôtel des ventes convient aussi.",
	-- ["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the {area:380} at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "La réputation {faction:81} vient des quêtes, de la {item:11040} et des étoffes. {npc:14728}, l'intendant des étoffes, se tient sur la butte centrale parmi les tentes des travailleurs du cuir et des tailleurs. Il prend quatre dons uniques de 60 étoffes (150 chacun), puis {quest:7825}, 20 {item:14047} pour 50, autant de fois que vous voulez. Chaque point de réputation {faction:81} gagné donne aussi un quart à {zone:1454}, à {zone:1458} et aux Trolls Sombrelance. Pendant que vous montez de niveau, faites les quêtes pour la faction {faction:81} à 5 niveaux près : {zone:1412} de 1 à 12, le {area:378} et la {area:380} de 13 à 22, {zone:1441} de 25 à 30. L'atout d'Héritage Diplomate ajoute jusqu'à 10 %. Récompenses : à Honoré, les marchands des Pitons-du-Tonnerre vous vendent 10 % moins cher (la règle de Classic), marchand de kodos compris ; à Exalté, les autres races peuvent acheter les kodos : 20 po pour un kodo de niveau 40, 200 po pour un grand kodo au niveau 60, une fois la monte apprise. La faction {faction:81} n'a ni tabard ni autre récompense.",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} accepte le tissu pour {faction:81}, à {faction:81}. Les premiers dons de laine, de soie, de tisse-mage et de {item:14047} (60 tissus chacun) ne se font qu'une fois et rapportent le plus de réputation par tissu ; ensuite, {quest:7825} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728} : {item:14047} livré",
	-- ["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50 (in Classic a fifth at 60). {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "{quest:3804} prend 10 {item:11040} pour 50, autant de fois que vous voulez, et paie en entier au niveau 60, mais c'est lent : la {item:11020} fait pousser une enveloppe toutes les 10 minutes et une enveloppe contient en moyenne environ une {item:11040} ; chaque remise demande donc environ 90 minutes d'attente, 18 portions de terre ({quest:3761}) et 9 paquets de graines (90 pa). Cela tourne à côté de tout ce que vous faites : un peu plus de 30 de réputation par heure. La suite de quêtes qui précède est de niveau 50 (dans Classic, un cinquième au niveau 60). {npc:6746} vous envoie voir {npc:5769} sur la {area:1639} ; il veut 20 portions de terre ({quest:3761}).",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825} demande 20 {item:14047} par rendu et se répète autant que vous voulez. Apportez du {item:14047} par multiples de 20 et rendez tout d'un coup, un rendu après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'Hôtel des ventes.",
	-- ["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest. {quest:764} mine is further north-east; the elite shredder Venture Co. Clearcutter works deep inside."] = "{quest:99079} attend près de la frontière est. La {object:2908} de la caravane saccagée se trouve au nord-est du village : ouvrez-la pour lancer la quête suivante. La mine de la KapitalRisk ({quest:764}) est plus au nord-est ; le déchiqueteur élite de la KapitalRisk travaille tout au fond.",
	-- ["{zone:1452}'s level 56-60 quests, {item:11040} and {item:14047} to Exalted, with {zone:1412}'s old quests as an optional extra."] = "Les quêtes de niveau 56-60 du {zone:1452}, la {item:11040} et l'{item:14047} jusqu'à Exalté, avec les anciennes quêtes de {zone:1412} en option.",
}
