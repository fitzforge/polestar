-- French (frFR): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} est votre base pour ce guide : la pierre de foyer vous y ramène deux fois. Tout le monde se tient autour de la place du village.",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "L'affiche {object:1763} près de l'auberge",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "L'affiche {quest:567} : ses cibles se présentent en chemin",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Remplissez l'{item:7768} au {object:107045} à côté de l'auberge",

	-- Step 2: Serge Hinott
	-- {zone:1413} The Barrens · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Seulement si Gallywix est tombé dans les {zone:1413} (Mission : possible mais non probable) : {npc:2391} se trouve à {area:272}. Attendez près de lui pendant qu'il prépare le remède, puis prenez votre récompense : Poisons.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391} : Poisons",
	["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Pas encore de Gallywix ? Le guide de classe Poisons (Horde) reprend la suite depuis Shenthul, avec un groupe pour Gallywix.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Ours, rampemousses et lions",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "À l'ouest de Moulin-de-Tarren, des Ours gris, des Rampemousses forestières et des Lions des montagnes affamés parcourent les collines en descendant vers les fermes. Les rampemousses lâchent rarement l'{item:3477} ; il vous en faut un seul.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Les fermes à l'est du village de {area:287}. {npc:232} travaille le champ près de la ferme du nord, {npc:2403} celui plus au sud-est ; Ouvriers agricoles et Fermiers d'Hillsbrad sont partout. {npc:2451} s'occupe du champ au sud des fermes.",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "{npc:2230}, à côté de l'Apothicaire Lydon",

	-- Step 6: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} est le chien de {npc:232}, à la ferme du nord dans {area:286}.",

	-- Step 7: Peasants and skulls
	["Peasants and skulls"] = "Paysans et crânes",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Les Paysans d'Hillsbrad travaillent les champs au sud des fermes. Tous les humains de {area:287} lâchent des crânes ; les Paysans le plus souvent.",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692} : les Paysans d'Hillsbrad dans les champs",

	-- Step 8: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215} : ordres pour {npc:270438}, sur la route de Fort-de-Durn",

	-- Step 9: Syndicate camps
	["Syndicate camps"] = "Camps du Syndicat",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Depuis {area:272}, allez au sud-est dans les collines en direction de {area:275}. Des Voleurs et des Sentinelles du Syndicat tiennent les camps en chemin.",

	-- Step 10: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Drull et {npc:2238} sont enchaînés dans les bâtiments de la cour de {area:275} ; ouvrez les deux cadenas.",
	["Drull's ball and chain"] = "Boulet et chaîne de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Boulet et chaîne de {npc:2238}",

	-- Step 11: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj se cache sur le flanc de colline au-dessus de {area:290}, au sud de Fort-de-Durn, en descendant vers les fleurs.",

	-- Step 12: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "Au sud-ouest de Fort-de-Durn, les {item:3502} poussent sur les collines au-dessus de la rivière.",

	-- Step 13: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, à {zone:1458}",

	-- Step 14: The smithy
	["The smithy"] = "La forge",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "La forge se trouve au centre du village de {area:287}. {npc:2404} et ses apprentis y travaillent ; la {object:1736} est empilée à côté. {npc:2449} arpente la rue au nord.",

	-- Step 16: Town hall
	["Town hall"] = "Hôtel de ville",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "L'hôtel de ville est à l'ouest de {area:287}. {npc:2335} (30) et {npc:2448} sont à l'intérieur avec le Registre municipal d'Hillsbrad ; la Proclamation d'Hillsbrad est affichée à côté. Des Conseillers d'Hillsbrad arpentent le village.",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288} se trouve au sud du village de {area:287}. Des Mineurs d'Hillsbrad travaillent dans les galeries ; {npc:2305} (30) et {npc:2450} (29) sont tout au fond.",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, dans l'Apothicarium",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Gardez-la : la côte de {area:287}, plus loin sur l'itinéraire",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Prenez le zeppelin aux tours devant {zone:1458} pour {zone:1454} et entraînez-vous avant de repartir.",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Depuis {zone:1454} (zeppelin aux tours devant {zone:1458}), prenez un vol pour {area:1638} et entraînez-vous sur {area:1639}, puis prenez un vol pour {area:378}.",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Depuis {zone:1454} (zeppelin aux tours devant {zone:1458}), prenez un vol pour {area:378}.",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "La hutte de {npc:5899} se dresse sur la crête au-dessus du point d'eau des hurans, au sud de {area:378}, sur la route de {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899} : l'outre rouge de {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899} : l'outre bleue se remplit dans {zone:1440}, au guide suivant",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Suivez la route vers le sud jusqu'au site de fouilles des nains à {area:359}. {npc:3421} se cache au bord sud des fouilles ; {object:3646} se trouve au fond de l'excavation.",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:485} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "Au sud-ouest de Bael Modan, {npc:12576} attend en haut de {area:485}.",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Pierre de foyer vers {area:378}, puis prenez un vol pour {area:392}. {quest:874} campe sur le rivage au nord de {area:392}.",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, un grand battrodon, nage dans les hauts-fonds au large de {area:391}, à l'est de {npc:3388}.",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, près des quais de {area:392}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Pas encore de Gallywix ? Le guide de classe {spell:2842} (Horde) refait la suite depuis Shenthul, avec un groupe pour Gallywix.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Seulement si Gallywix est tombé dans {zone:1413} (Mission : possible mais non probable) : {npc:2391} se trouve à {area:272}. Attendez près de lui pendant qu'il prépare le remède, puis prenez votre récompense : Poisons.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Seulement si Gallywix est tombé dans {zone:1413} (Mission : possible mais non probable) : {npc:2391} se tient à {area:272}. Attendez à côté de lui pendant qu'il prépare le remède, puis prenez votre récompense : {spell:2842}.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "La forge se trouve au centre du village de {area:287}. {npc:2404} et ses apprentis y travaillent ; le {item:3564} est empilé à côté. {npc:2449} arpente la rue au nord.",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Vous arrivez lié à l'auberge de {area:272}. Tout le monde se tient autour de la place du village.",
	-- ["{npc:2055}, in the {object:36072}"] = "{npc:2055}, dans {object:36072}",
}
