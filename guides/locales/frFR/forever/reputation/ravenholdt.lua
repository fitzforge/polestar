-- French (frFR): the guide forever/reputation/ravenholdt (forever/reputation/ravenholdt.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt Reputation"] = "Réputation : Ravenholdt",
	["The assassins' guild: Forever's new rogue quests, then Syndicate kills and Heavy Junkboxes to Exalted."] = "La guilde des assassins : les nouvelles quêtes de voleur de Forever, puis le Syndicat à tuer et des coffrets lourds jusqu'à Exalté.",
	-- {faction:349} Ravenholdt
	["{faction:349} reputation (no vendor or reward in Forever's data)"] = "Réputation {faction:349} (aucun marchand ni récompense dans les données de Forever)",

	-- Step 1: The Manor, Ravenholdt
	-- {item:17126} Elegant Letter · {object:1776} Durnholde Keep (no name in this language: may be words) · {npc:6707} Fahrad
	["Rogues from level 24: ask your class trainer in a capital \"May I have it, please?\" for the {item:17126}, and read it. The path up to the manor starts in the hills north of {object:1776}. In the tunnel on the way lies a chest: do not open it (an elite guard jumps out), just walk past it to earn the Rite of Cunning. {npc:6707} waits on the manor's balcony."] = "",
	-- {item:17126} Elegant Letter
	["{item:17126}, from your class trainer"] = "{item:17126}, auprès de votre maître de classe",
	["walk past the trapped chest in the tunnel"] = "passez à côté du coffre piégé dans le tunnel",
	-- {npc:6707} Fahrad
	["{npc:6707}: 100 reputation"] = "{npc:6707} : 100 de réputation",

	-- Step 2: Myrokos Silentform
	-- {npc:13085} Myrokos Silentform · {quest:96779} Syndicate Sabotage · {quest:96781} What's the Big Idea? · {quest:96782} Covert Extraction · {quest:96786} The Syndicate Sting · {quest:96783} A Way In · {item:5140} Flash Powder
	["{npc:13085}, in the manor, has Forever's new rogue quests: 100 reputation each for {quest:96779}, {quest:96781} and {quest:96782}, which follows it, and 300 for {quest:96786} at the end of the Stromgarde chain ({quest:96783} and the two quests after it pay nothing). All can be done solo with stealth from level 30; below that, the Master of Deception talent and a {item:5140} for Vanish help."] = "{npc:13085}, dans le manoir, propose les nouvelles quêtes de voleur de Forever : 100 de réputation chacune pour {quest:96779}, {quest:96781} et {quest:96782}, qui la suit, et 300 pour {quest:96786} à la fin de la suite de Stromgarde ({quest:96783} et les deux quêtes suivantes ne rapportent rien). Tout se fait seul en camouflage dès le niveau 30 ; en dessous, le talent Master of Deception et une {item:5140} pour Disparition aident.",

	-- Step 3: Durnholde Keep: Lord Tomas
	-- {npc:266216} Lord Tomas · {object:1776} Durnholde Keep (no name in this language: may be words)
	["{npc:266216} is inside {object:1776}, the Syndicate fortress east of Southshore. Stealth past the guards in the courtyard."] = "",

	-- Step 4: Strahnbrad: Barton
	["Strahnbrad: Barton"] = "",
	["Barton hides in a house in Strahnbrad, among stealthed Syndicate. Pick his pocket for the report; Distract turns him around if you are under his level."] = "",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482} : faites les poches de Barton",

	-- Step 5: Northfold Manor: a uniform
	["Northfold Manor: a uniform"] = "",
	-- {object:656157} Syndicate Footlocker (no name in this language: may be words) · {quest:96783} A Way In · {item:275706} Syndicate Uniform
	["The {object:656157} stands among the Syndicate camps of Northfold Manor, north of Stromgarde. Open it to finish {quest:96783} and take the {item:275706}."] = "",

	-- Step 6: Stromgarde: Anastasia Miller
	-- {npc:266847} Anastasia Miller
	["Stromgarde: {npc:266847}"] = "Stromgarde : {npc:266847}",
	-- {item:275706} Syndicate Uniform · {npc:266847} Anastasia Miller
	["Put on the {item:275706} and go into Stromgarde. {npc:266847} waits on a ledge just outside the castle; players reach her by jumping from the roof of the house beside the ledge. Her stash is upstairs in a house near the keep."] = "Revêtez l'{item:275706} et entrez dans Stromgarde. {npc:266847} attend sur une corniche juste à l'extérieur du château ; on la rejoint en sautant depuis le toit de la maison voisine. Sa cachette est à l'étage d'une maison près du donjon.",
	-- {item:275709} Stolen Funds
	["{item:275709}, in Anastasia's Stash upstairs"] = "{item:275709}, dans la cachette d'Anastasia à l'étage",

	-- Step 7: Thoradin's Wall: the shipment
	["Thoradin's Wall: the shipment"] = "",
	-- {zone:1417} Arathi Highlands · {item:275882} Intercepted Shipment · {npc:13085} Myrokos Silentform
	["The hand-off is at the southern end of Thoradin's Wall, in the west of the {zone:1417}: two Syndicate guard the box. Kill them or lure them off, then take the {item:275882}. Keep the uniform: {npc:13085} wants it back."] = "",

	-- Step 8: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Retour auprès de {npc:13085}",
	-- {quest:96782} Covert Extraction · {quest:96781} What's the Big Idea?
	["{quest:96782}, after {quest:96781}"] = "{quest:96782}, après {quest:96781}",

	-- Step 9: Ruins of Alterac: the Perenolde heirlooms
	["Ruins of Alterac: the Perenolde heirlooms"] = "",
	-- {zone:1416} Alterac Mountains
	["The two heirlooms lie in two towers of the Ruins of Alterac, the ogre-held ruin in the middle of the {zone:1416}. The tower with the sword is ringed by elite ogres: stay in stealth. Neither item is guarded once you are inside."] = "",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, the shield"] = "{item:275636}, le bouclier",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, the sword"] = "{item:275635}, l'épée",

	-- Step 10: Syndicate Emblems to Friendly
	-- {quest:6701} Syndicate Emblems
	["{quest:6701} to Friendly"] = "{quest:6701} jusqu'à Amical",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Neutral to Friendly is 3,000 reputation; the quests above pay 700 of it. Any {npc:6766} on the path takes {quest:6701}, 100 reputation each, until you reach Friendly: 23 emblems after the quests. Pick the pockets of Syndicate humans; they never drop emblems when killed. The Arathi camps pay best: Syndicate Prowlers and Conjurors carry one about a quarter of the time. Kill what you have robbed so the next ones respawn fresh."] = "De Neutre à Amical, il faut 3 000 de réputation ; les quêtes ci-dessus en rapportent 700. N'importe quel {npc:6766} sur le chemin prend {quest:6701}, 100 de réputation chacune, jusqu'à Amical : 23 emblèmes après les quêtes. Faites les poches des humains du Syndicat ; tués, ils ne laissent jamais d'emblème. Les camps d'Arathi rapportent le plus : les Rôdeurs du Syndicat et les Conjurateurs du Syndicat en portent un environ une fois sur quatre. Tuez ceux que vous avez volés pour que les suivants réapparaissent neufs.",
	-- {item:17124} Syndicate Emblem
	["{item:17124}: pickpocket Syndicate"] = "{item:17124} : faites les poches du Syndicat",
	-- {npc:6766} Ravenholdt Guard
	["a {npc:6766}: 100 per emblem"] = "un {npc:6766} : 100 par emblème",

	-- Step 11: Syndicate kills to the end of Honored
	["Syndicate kills to the end of Honored"] = "Tuer le Syndicat jusqu'à la fin d'Honoré",
	-- {faction:349} Ravenholdt · {zone:1416} Alterac Mountains
	-- plural, as words: Syndicate Assassins = {npc:2246} Syndicate Assassin
	["Everyone, not only rogues: in Classic every Syndicate human gave {faction:349} 5 reputation up to the end of Honored (11,999 of 12,000) and not one point more, so 0 to there is 4,200 kills (3,600 after a rogue's quests and emblems). This step ticks at Honored; keep killing until the bar stops moving, then go on to the junkboxes. The highest Syndicate are in the north-west of the {zone:1416}, Syndicate Assassins and Enforcers (level 38-40), with Syndicate Sentries (36-37) nearer the middle. At 60 all Syndicate are grey, and in Classic grey kills gave about a fifth: farm them before 48 if you can. Legacy Diplomat adds up to 10%."] = "Pour tout le monde, pas seulement les voleurs : dans Classic, chaque humain du Syndicat donnait 5 de réputation {faction:349} jusqu'à la fin d'Honoré (11 999 sur 12 000) et pas un point de plus ; de 0 jusque-là, il faut donc 4 200 victimes (3 600 après les quêtes et emblèmes d'un voleur). Cette étape se coche à Honoré ; continuez à tuer jusqu'à ce que la barre ne bouge plus, puis passez aux coffrets. Les membres du Syndicat de plus haut niveau sont au nord-ouest des {zone:1416} : Assassins du Syndicat et Massacreurs du Syndicat (niveau 38-40), et Sentinelles du Syndicat (36-37) plus vers le centre. Au niveau 60, tout le Syndicat est gris, et dans Classic les victimes grises donnaient environ un cinquième : farmez-les avant 48 si vous pouvez. Diplomate de l'Héritage ajoute jusqu'à 10 %.",
	-- {npc:2246} Syndicate Assassin
	["{npc:2246}, level 38-39"] = "{npc:2246}, niveau 38-39",
	-- {npc:2247} Syndicate Enforcer
	["{npc:2247}, level 39-40"] = "{npc:2247}, niveau 39-40",
	-- {npc:2243} Syndicate Sentry
	["{npc:2243}, level 36-37"] = "{npc:2243}, niveau 36-37",

	-- Step 12: A Simple Request, rogues 50+
	-- {quest:8233} A Simple Request
	["{quest:8233}, rogues 50+"] = "{quest:8233}, voleurs 50+",
	-- {npc:6768} Lord Jorach Ravenholdt · {quest:8234} Sealed Azure Bag · {zone:1447} Azshara · {quest:8235} Encoded Fragments · {quest:8236} The Azure Key
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman · Forest Oozes = {npc:8766} Forest Ooze
	["At level 50 your class trainer has another letter for you, and {npc:6768} a short chain: 360 reputation in all. The {quest:8234} drops from Timbermaw Shamans in northern {zone:1447} (about 1 in 27, or pick their pockets); the {quest:8235} from Forest Oozes in {zone:1447} (4 in 5). {quest:8236} comes from Morphaz, an elite drake deep in the Temple of Atal'Hakkar: a five-player dungeon, group up."] = "",
	-- {quest:8234} Sealed Azure Bag
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["{quest:8234}: Timbermaw Shamans"] = "{quest:8234} : Chamans Grumegueule",
	-- {item:20023} Encoded Fragment
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze
	["{item:20023}: Forest Oozes"] = "{item:20023} : Limons forestiers",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, Temple of Atal'Hakkar (group)"] = "",

	-- Step 13: Heavy Junkboxes to Exalted
	["Heavy Junkboxes to Exalted"] = "Coffrets lourds jusqu'à Exalté",
	-- {quest:8249} Junkboxes Needed · {npc:6707} Fahrad · {item:20086} Dusksteel Throwing Knife
	["From the top of Honored to Exalted is 21,001 reputation, and {quest:8249} is the only way: {npc:6707} pays 50 and a {item:20086} for every five Heavy Junkboxes (Classic Era paid 75), 421 turn-ins and 2,105 boxes. Boxes count at any standing, so take the cheap kills to their cap first. Any class can hand them in. Rogues get them by picking the pockets of humanoids around level 50 and up: Lower Blackrock Spire and Blackrock Depths are the classic spots, pick every pocket, reset and go again. The boxes do not bind, so everyone else buys them from rogues or at the auction house. Hand them in unopened; an opened box you empty vanishes, so leave one item in it."] = "",
	-- {item:16885} Heavy Junkbox
	["{item:16885}: pickpocket level 50+ humanoids, Blackrock Mountain"] = "",
	-- {npc:6707} Fahrad
	["{npc:6707}: 50 per five boxes"] = "{npc:6707} : 50 pour cinq coffrets",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At level 50 your class trainer has another letter for you, and {npc:6768} a short chain: 360 reputation in all. The {quest:8234} drops from Timbermaw Shamans in northern {zone:1447} (about 1 in 27, or pick their pockets); the {quest:8235} from Forest Oozes in {zone:1447} (4 in 5). {quest:8236} comes from Morphaz, an elite drake deep in the {area:1477}: a five-player dungeon, group up."] = "Au niveau 50, votre maître de classe a une autre lettre pour vous, et {npc:6768} une courte suite de quêtes : 360 de réputation en tout. Le {quest:8234} tombe sur les Chamans Grumegueule au nord d'{zone:1447} (environ 1 sur 27, ou faites-leur les poches) ; {quest:8235} sur les Limons forestiers d'{zone:1447} (4 sur 5). {quest:8236} vient de Morphaz, un drake élite au fond du {area:1477} : un donjon à cinq joueurs, formez un groupe.",
	-- ["Barton hides in a house in {area:280}, among stealthed Syndicate. Pick his pocket for the report; Distract turns him around if you are under his level."] = "Barton se cache dans une maison de {area:280}, parmi des membres du Syndicat camouflés. Faites-lui les poches pour le rapport ; Distraction le fait se retourner si vous êtes d'un niveau inférieur au sien.",
	-- ["From the top of Honored to Exalted is 21,001 reputation, and {quest:8249} is the only way: {npc:6707} pays 50 and a {item:20086} for every five Heavy Junkboxes (Classic Era paid 75), 421 turn-ins and 2,105 boxes. Boxes count at any standing, so take the cheap kills to their cap first. Any class can hand them in. Rogues get them by picking the pockets of humanoids around level 50 and up: Lower {area:1583} and {area:1584} are the classic spots, pick every pocket, reset and go again. The boxes do not bind, so everyone else buys them from rogues or at the auction house. Hand them in unopened; an opened box you empty vanishes, so leave one item in it."] = "Du haut d'Honoré à Exalté, il faut 21 001 de réputation, et {quest:8249} est le seul moyen : {npc:6707} donne 50 et un {item:20086} pour cinq coffrets lourds (Classic Era donnait 75), soit 421 remises et 2 105 coffrets. Les coffrets comptent à tout niveau de réputation : profitez d'abord des victimes faciles jusqu'à leur plafond. Toutes les classes peuvent les rendre. Les voleurs les obtiennent en faisant les poches des humanoïdes de niveau 50 et plus : le bas du {area:1583} et les {area:1584} sont les endroits classiques ; faites toutes les poches, réinitialisez et recommencez. Les coffrets ne sont pas liés : les autres les achètent aux voleurs ou à l'hôtel des ventes. Rendez-les fermés ; un coffret ouvert que vous videz disparaît, laissez-y donc un objet.",
	-- ["Rogues from level 24: ask your class trainer in a capital \"May I have it, please?\" for the {item:17126}, and read it. The path up to the manor starts in the hills north of {area:275}. In the tunnel on the way lies a chest: do not open it (an elite guard jumps out), just walk past it to earn the Rite of Cunning. {npc:6707} waits on the manor's balcony."] = "Voleurs dès le niveau 24 : demandez la {item:17126} à votre maître de classe dans une capitale (« Puis-je l'avoir, s'il vous plaît ? ») et lisez-la. Le chemin vers le manoir part des collines au nord du {area:275}. Dans le tunnel, sur le trajet, se trouve un coffre : ne l'ouvrez pas (un garde élite en surgit), passez simplement à côté pour accomplir le Rite of Cunning. {npc:6707} attend sur le balcon du manoir.",
	-- ["The hand-off is at the southern end of {area:1057}, in the west of the {zone:1417}: two Syndicate guard the box. Kill them or lure them off, then take the {item:275882}. Keep the uniform: {npc:13085} wants it back."] = "L'échange a lieu à l'extrémité sud du {area:1057}, à l'ouest des {zone:1417} : deux membres du Syndicat gardent la caisse. Tuez-les ou attirez-les ailleurs, puis prenez l'{item:275882}. Gardez l'uniforme : {npc:13085} veut le récupérer.",
	-- ["The two heirlooms lie in two towers of the {area:281}, the ogre-held ruin in the middle of the {zone:1416}. The tower with the sword is ringed by elite ogres: stay in stealth. Neither item is guarded once you are inside."] = "Les deux reliques se trouvent dans deux tours des {area:281}, les ruines tenues par les ogres au milieu des {zone:1416}. La tour de l'épée est entourée d'ogres élites : restez camouflé. Aucun des deux objets n'est gardé une fois à l'intérieur.",
	-- ["The {object:656157} stands among the Syndicate camps of {area:313}, north of Stromgarde. Open it to finish {quest:96783} and take the {item:275706}."] = "La cantine du Syndicat se trouve parmi les camps du Syndicat du {area:313}, au nord de Stromgarde. Ouvrez-la pour terminer {quest:96783} et prenez l'{item:275706}.",
	-- ["{area:1057}: the shipment"] = "{area:1057} : la cargaison",
	-- ["{area:280}: Barton"] = "{area:280} : Barton",
	-- ["{area:281}: the Perenolde heirlooms"] = "{area:281} : les reliques des Perenolde",
	-- ["{area:313}: a uniform"] = "{area:313} : un uniforme",
	-- ["{item:16885}: pickpocket level 50+ humanoids, {area:1445}"] = "{item:16885} : faites les poches des humanoïdes de niveau 50+, {area:1445}",
	-- ["{item:20022}: Morphaz, {area:1477} (group)"] = "{item:20022} : Morphaz, {area:1477} (groupe)",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress east of {area:271}. Stealth past the guards in the courtyard."] = "{npc:266216} est à l'intérieur du {area:275}, la forteresse du Syndicat à l'est d'{area:271}. Passez les gardes de la cour en camouflage.",
}
