-- French (frFR): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} est votre base pour ce guide : la pierre de foyer vous y ramène deux fois. Tout le monde se tient autour de la place du village.",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Remplissez l'{item:7768} au {object:107045} à côté de l'auberge",
	-- {object:556670} WANTED
	["The {object:556670} poster by the inn"] = "L'affiche {object:556670} près de l'auberge",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, à l'intérieur",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "Après avoir rendu Mission : possible mais pas probable à Shenthul, apportez {quest:2479} à {npc:2391}, à {area:272}. Restez à côté de lui jusqu'à ce que l'objectif de préparation soit rempli, puis rendez la quête suivante pour apprendre les Poisons. Terminez-la même si le poison de Zanzil a déjà été retiré ; retirer l'affaiblissement ne suffit pas à apprendre la compétence.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391} : Poisons",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "Suite des poisons inachevée ? Reprenez votre étape actuelle dans le guide de classe Poisons (Horde) ; les quêtes terminées n'ont pas besoin d'être recommencées. Formez un groupe pour Gallywix, terminez la suite d'Hinott, puis revenez à ce guide de progression.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Ours, rampemousses et lions",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "À l'ouest de Moulin-de-Tarren, des Ours gris, des Rampemousses forestières et des Lions des montagnes affamés parcourent les collines en descendant vers les fermes. Les rampemousses lâchent rarement l'{item:3477} ; il vous en faut un seul.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Les fermes à l'est du village de {area:287}. {npc:232} travaille le champ près de la ferme du nord, {npc:2403} celui plus au sud-est ; Ouvriers agricoles et Fermiers d'Hillsbrad sont partout. {npc:2451} s'occupe du champ au sud des fermes.",

	-- Step 5: Mountain Lion Blood
	["Careful: When one lion is attacked, nearby lions come to its aid, and the Vicious Black Bears sharing those fields can also join the fight."] = "Attention : quand un lion est attaqué, les lions proches viennent l'aider, et les Ours noirs vicieux qui partagent ces champs peuvent aussi rejoindre le combat.",

	-- Step 6: Tarren Mill
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, à l'intérieur",
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon; inside"] = "{npc:2230}, à côté de Lydon ; à l'intérieur",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: Kalaba with the peasants, Wilkes at the smithy; the clerk and the miner on the visit at about 30; inside"] = "",

	-- Step 7: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} est le chien de {npc:232}, à la ferme du nord dans {area:286}.",

	-- Step 8: Hillsbrad Fields: kill these as you meet them
	-- {area:286} Hillsbrad Fields
	["{area:286}: kill these as you meet them"] = "{area:286} : tuez-les au passage",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often.\nCareful: A fleeing peasant that reaches the town hall can bring back many adds, including {area:287} footmen; snares, roots or similar effects keep them from escaping."] = "Les Paysans travaillent dans les champs au sud des fermes. Tous les humains de {area:287} lâchent des crânes ; les Paysans le plus souvent.\nAttention : un paysan qui fuit et atteint l'hôtel de ville peut ramener de nombreux renforts, dont des fantassins de {area:287} ; les effets de ralentissement, d'immobilisation ou similaires l'empêchent de s'échapper.",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692} : les Paysans d'Hillsbrad dans les champs",
	-- {npc:2451} Farmer Kalaba · {area:286} Hillsbrad Fields
	["{npc:2451} walks around {area:286}: look inside the circle on the map"] = "{npc:2451} se promène autour de {area:286} : cherchez dans le cercle sur la carte",

	-- Step 9: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215} : ordres pour {npc:270438}, sur la route de Fort-de-Durn",
	-- {npc:2216} Apothecary Lydon · {item:3502} Mudsnout Blossoms
	["{npc:2216}, inside: the {item:3502} grow south-west of Durnholde, on the walk there"] = "",

	-- Step 10: Durnholde Keep: kill these as you meet them
	-- {area:275} Durnholde Keep
	["{area:275}: kill these as you meet them"] = "{area:275} : tuez-les au passage",
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep · {area:272} Tarren Mill
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks.\nFrom {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Drull et {npc:2238} sont enchaînés dans les bâtiments de la cour de {area:275} ; ouvrez les deux cadenas.\nDepuis {area:272}, allez vers le sud-est dans les collines en direction de {area:275}. Des Voleurs et des Guetteurs tiennent les camps en chemin.",
	-- {npc:2261} Syndicate Watchman
	["{npc:2261} walks around here: look inside the circle on the map"] = "{npc:2261} se promène par ici : cherchez dans le cercle sur la carte",
	["Drull's ball and chain"] = "Boulet et chaîne de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Boulet et chaîne de {npc:2238}",

	-- Step 11: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "Au sud-ouest de Fort-de-Durn, les {item:3502} poussent sur les collines au-dessus de la rivière.",

	-- Step 12: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj se cache sur le flanc de colline au-dessus de {area:290}, au sud de Fort-de-Durn, en descendant vers les fleurs.",
	-- {npc:270438} Deathstalker Masoj · {quest:98094} Scout Support
	["{npc:270438}, once {quest:98094} is in"] = "",

	-- Step 13: The southern peak
	["The southern peak"] = "",
	-- {area:290} Dun Garok
	["Masoj wants an Apothecary Vial placed on three peaks. The southern one is the hilltop above {area:290}, just south of him: use a vial at the top."] = "",

	-- Step 14: The smithy
	["The smithy"] = "La forge",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "La forge se trouve au centre du village de {area:287}. {npc:2404} et ses apprentis y travaillent ; la {object:1736} est empilée à côté. {npc:2449} arpente la rue au nord.",
	["Inside"] = "À l'intérieur",

	-- Step 15: The western peak
	["The western peak"] = "",
	-- {area:287} Hillsbrad
	["From {area:287} town climb the mountain to the north, right up to its top on the Alterac border: the western vial goes there, not on the lower slope."] = "",

	-- Step 16: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Retour à {area:272}",
	-- {area:272} Tarren Mill
	["East along the foothills, then down into {area:272}."] = "",

	-- Step 17: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, à {zone:1458}",

	-- Step 18: The northern peak
	["The northern peak"] = "",
	-- {area:272} Tarren Mill
	["The northern peak rises south-east of {area:272}, on the way down towards Durnholde."] = "",

	-- Step 19: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Back down to Masoj on the hillside above {area:290}."] = "",

	-- Step 20: The Sepulcher
	-- {area:272} Tarren Mill · {area:228} The Sepulcher · {npc:2121} Shadow Priest Allister
	["Walk back up to {area:272} and fly to the {area:228}: {npc:2121} stands by the crypt entrance."] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Maître de vol de {area:272}",

	-- Step 21: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "",
	-- {npc:2226} Karos Razok · {area:1497} Undercity
	["Fly on from {npc:2226}, the bat handler just east of the crypt, to the {area:1497}."] = "",

	-- Step 22: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606} se tient dans le {object:36070}.",

	-- Step 23: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, dans l'Apothicarium",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Gardez-la : la côte de {area:287}, plus loin sur l'itinéraire",

	-- Step 24: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11870} ({object:36070}, 10 pièces d'argent) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 25: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); two-handers level a Warrior fastest."] = "Pendant que vous y êtes : apprenez le maniement des armes d'hast auprès de {npc:11870} ({object:36070}, 1 pièce d'or) ; les armes à deux mains font progresser un Guerrier le plus vite.",

	-- Step 26: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Paladin fastest."] = "Pendant que vous y êtes : apprenez {spell:202} auprès de {npc:11870} ({object:36070}, 10 pièces d'argent) ; les armes à deux mains font progresser un Paladin le plus vite.",

	-- Step 27: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Pendant que vous y êtes : apprenez le maniement des armes d'hast auprès de {npc:11870} ({object:36070}, 1 pièce d'or) ; l'arme de mêlée d'un Chasseur vaut surtout par ses caractéristiques, et les armes à deux mains en portent le plus.",

	-- Step 28: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Swords from {npc:11870} ({object:36070}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Pendant que vous y êtes : apprenez le maniement des épées auprès de {npc:11870} ({object:36070}, 10 pièces d'argent) ; une épée en main droite fait progresser un Voleur régulièrement.",

	-- Step 29: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885} : utilisez une moitié au {area:2362}",

	-- Step 30: Aquatic Form
	-- {quest:31} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Take {quest:31} from {npc:11802}, who stands upstairs in his building. Then {npc:11798} in {area:2361} flies druids to {area:1638}: {npc:3033} is on {area:1639}."] = "",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} à {area:2361} y emmène les druides",

	-- Step 31: Back to the Crossroads
	["Back to the Crossroads"] = "",
	-- {npc:3033} Turak Runetotem
	["Train with {npc:3033}, then fly on to the Crossroads, where the next guide starts."] = "",

	-- Step 32: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",

	-- Step 33: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 34: Orgrimmar
	["Train before you fly on: the next guide flies from here to the Crossroads."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull et {npc:2238} sont enchaînés dans les bâtiments de la cour de {area:275} ; ouvrez les deux cadenas.",
	-- ["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {area:17}."] = "Volez des {zone:1456} jusqu'au {area:378} et prenez la route vers le sud jusqu'à {area:1718}, tout au bout des {area:17}.",
	-- ["Fly to {area:392}"] = "Prendre un vol pour {area:392}",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Suivez la route vers l'est le long de la rivière, puis montez vers le nord-est dans les collines jusqu'à {area:272}.",
	-- ["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Suivez la route vers le sud jusqu'au site de fouilles des nains à {area:359}. {npc:3421} se cache au bord sud des fouilles ; {object:3646} se trouve au fond de l'excavation.",
	-- ["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Depuis {area:272}, allez au sud-est dans les collines en direction de {area:275}. Des Voleurs et des Sentinelles du Syndicat tiennent les camps en chemin.",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Depuis {zone:1454} (zeppelin aux tours devant {zone:1458}), prenez un vol pour {area:1638} et entraînez-vous sur {area:1639}, puis prenez un vol pour {area:378}.",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Depuis {zone:1454} (zeppelin aux tours devant {zone:1458}), prenez un vol pour {area:378}.",
	-- ["Head east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {area:85}; the {zone:1458} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Allez vers l'est jusqu'à la {area:380} et volez jusqu'à {zone:1454}. Prenez le zeppelin aux tours devant {zone:1454} jusqu'aux {area:85} ; {zone:1458} se trouve sous les {area:153}. Le dresseur de chauves-souris est dans le {object:36078}.",
	-- ["Hearth to {area:272}"] = "Pierre de foyer vers {area:272}",
	-- ["Hearth to {area:378}"] = "Pierre de foyer vers le {area:378}",
	-- ["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Pierre de foyer vers {area:378}, puis prenez un vol pour {area:392}. {quest:874} campe sur le rivage au nord de {area:392}.",
	-- ["Inside {area:288}"] = "Dans {area:288}",
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Pas encore de Gallywix ? Le guide de classe Poisons (Horde) reprend la suite depuis Shenthul, avec un groupe pour Gallywix.",
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Pas encore de Gallywix ? Le guide de classe {spell:2842} (Horde) refait la suite depuis Shenthul, avec un groupe pour Gallywix.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Seulement si Gallywix est tombé dans les {zone:1413} (Mission : possible mais non probable) : {npc:2391} se trouve à {area:272}. Attendez près de lui pendant qu'il prépare le remède, puis prenez votre récompense : Poisons.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Seulement si Gallywix est tombé dans {zone:1413} (Mission : possible mais non probable) : {npc:2391} se tient à {area:272}. Attendez à côté de lui pendant qu'il prépare le remède, puis prenez votre récompense : {spell:2842}.",
	-- ["Peasants and skulls"] = "Paysans et crânes",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "Au sud-ouest de Bael Modan, {npc:12576} attend en haut de {area:1718}.",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "Au sud-ouest de Bael Modan, {npc:12576} attend en haut de {area:485}.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Parlez à {npc:10181}, dans le {object:36126} : {quest:93739}",
	-- ["Syndicate camps"] = "Camps du Syndicat",
	-- ["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Prenez le zeppelin aux tours devant {zone:1458} pour {zone:1454} et entraînez-vous avant de repartir.",
	-- ["Talk to {npc:10181}"] = "Parlez à {npc:10181}",
	-- ["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Les Paysans d'Hillsbrad travaillent les champs au sud des fermes. Tous les humains de {area:287} lâchent des crânes ; les Paysans le plus souvent.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "La forge se trouve au centre du village de {area:287}. {npc:2404} et ses apprentis y travaillent ; le {item:3564} est empilé à côté. {npc:2449} arpente la rue au nord.",
	-- ["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "L'hôtel de ville est à l'ouest de {area:287}. {npc:2335} (30) et {npc:2448} sont à l'intérieur avec le Registre municipal d'Hillsbrad ; la Proclamation d'Hillsbrad est affichée à côté. Des Conseillers d'Hillsbrad arpentent le village.",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288} se trouve au sud du village de {area:287}. Des Mineurs d'Hillsbrad travaillent dans les galeries ; {npc:2305} (30) et {npc:2450} (29) sont tout au fond.",
	-- ["The {object:1763} poster by the inn"] = "L'affiche {object:1763} près de l'auberge",
	-- ["The {quest:567} poster: its targets come up along the way"] = "L'affiche {quest:567} : ses cibles se présentent en chemin",
	-- ["The {quest:567} poster: its targets come up along the way; inside"] = "L'affiche {quest:567} : ses cibles se présentent en chemin ; à l'intérieur",
	-- ["To the {zone:1458}"] = "Vers {zone:1458}",
	-- ["Town hall"] = "Hôtel de ville",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Vous arrivez lié à l'auberge de {area:272}. Tout le monde se tient autour de la place du village.",
	-- ["{area:378} flight master"] = "Maître de vol du {area:378}",
	-- ["{npc:10079}, at the top of the lift"] = "{npc:10079}, en haut de l'élévateur",
	-- ["{npc:2055}, in the {object:36072}"] = "{npc:2055}, dans {object:36072}",
	-- ["{npc:2230}, next to Lydon"] = "{npc:2230}, à côté de l'Apothicaire Lydon",
	-- ["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, près des quais de {area:392}",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "La hutte de {npc:5899} se dresse sur la crête au-dessus du point d'eau des hurans, au sud de {area:378}, sur la route de {area:359}.",
	-- ["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899} : l'outre bleue se remplit dans {zone:1440}, au guide suivant",
	-- ["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899} : l'outre rouge de {area:272}",
	-- ["{object:1761}, inside"] = "{object:1761}, à l'intérieur",
	-- ["{object:3646}; below ground"] = "{object:3646} ; sous terre",
	-- ["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, un grand battrodon, nage dans les hauts-fonds au large de {area:391}, à l'est de {npc:3388}.",
}
