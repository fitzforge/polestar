-- French (frFR): the guide forever/class/rogue/certificate-of-thievery (forever/class/rogue/certificate-of-thievery.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6966} Lucius · {quest:2282} Alther's Mill · {quest:2300} SI:7
	["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Votre premier crochetage au niveau 16 : le coffret de {npc:6966} à {quest:2282}, pour le {quest:2300}.",

	-- Step 1: SI:7 (Goldshire)
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:6946} Renzik "The Shiv" · {zone:1453} Stormwind
	["At 16 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}. Taking it shuts out the other towns' breadcrumbs."] = "Au niveau 16, {npc:917}, le maître des voleurs à l'étage de l'auberge de la Fierté du lion à {area:87}, vous envoie voir {npc:6946} à {zone:1453}. L'accepter vous ferme les quêtes d'orientation des autres villes.",

	-- Step 2: To Hulfdan! (Kharanos)
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge · {object:32383} Forlorn Cavern
	["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165} in {zone:1455}'s {object:32383}."] = "Au niveau 16, {npc:1234}, dans la {area:2102} à {area:131}, vous envoie voir {npc:5165} dans {object:32383} de {zone:1455}.",

	-- Step 3: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["{npc:5165} is in the house with a shady dealer outside, in the {object:32383}, down the stairs. Then fly or take the {area:2257} to {zone:1453}."] = "{npc:5165} est dans la maison devant laquelle se tient un marchand louche, dans {object:32383}, en bas de l'escalier. Prenez ensuite un vol ou le {area:2257} jusqu'à {zone:1453}.",

	-- Step 4: Erion Shadewhisper (Dolanaar)
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {quest:2259} Erion Shadewhisper · {zone:1457} Darnassus
	["At 16 {npc:3599} in the {area:186} inn sends you to {quest:2259} in {zone:1457}."] = "Au niveau 16, {npc:3599}, dans l'auberge de {area:186}, vous envoie voir {quest:2259} à {zone:1457}.",

	-- Step 5: Erion Shadewhisper
	-- {npc:4214} Erion Shadewhisper · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor
	["{npc:4214} stands in the {area:1658}. Then the boat from {area:702} to {area:442}, and the boat from {area:442} to {area:17203}."] = "{npc:4214} se tient dans l'{area:1658}. Prenez ensuite le bateau du {area:702} à {area:442}, puis le bateau d'{area:442} au {area:17203}.",

	-- Step 6: Renzik "The Shiv"
	-- {npc:6946} Renzik "The Shiv" · {quest:2300} SI:7 · {object:2100} Old Town · {spell:1804} Pick Lock · {npc:13283} Lord Tony Romano
	["{npc:6946} stands upstairs in the {quest:2300} building in {object:2100}, behind the rogue trainers. Before you leave: if you lack {spell:1804}, {npc:13283} in the {quest:2300} building teaches it; Lockpicking is the test of the next quest."] = "{npc:6946} se tient à l'étage du bâtiment du {quest:2300}, dans la {object:2100}, derrière les maîtres des voleurs. Avant de partir : si vous n'avez pas {spell:1804}, {npc:13283}, dans le bâtiment du {quest:2300}, vous l'apprend ; le crochetage est l'épreuve de la quête suivante.",

	-- Step 7: Lucius
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {npc:6966} Lucius · {item:5060} Thieves' Tools · {npc:3090} Gerald Crawley · {spell:1804} Pick Lock
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} stands on a crate on one of the {area:69} docks, south of town; he gives you {item:5060} with the job ({npc:3090} in {area:69} sells more). {spell:1804} does not work without the tools in your bags."] = "Traversez la {zone:1429} vers l'est jusqu'aux Carmines, ou volez jusqu'à {area:69}. {npc:6966} se tient sur une caisse sur l'un des quais de {area:69}, au sud de la ville ; il vous remet des {item:5060} avec le travail ({npc:3090} à {area:69} en vend d'autres). {spell:1804} ne fonctionne pas sans les outils dans vos sacs.",

	-- Step 8: Alther's Mill
	-- {quest:2282} Alther's Mill · {area:69} Lakeshire · {object:121264} Lucius's Lockbox
	["{quest:2282} stands east of {area:69}, up off the road; Blackrock orcs roam near it. Inside, the Practice Lockboxes come back almost at once: pick them until {object:121264} opens for you (about 25 Lockpicking). Your Lockpicking cap rises 5 per level, so a low character may stall. Some boxes are trapped (a frost trap, for one); the skill still goes up. On Forever level 20 spiders wander near the boxes: clear them first or bring a friend. The lockbox always holds the token and is back two seconds after use. Practise on while it still gives skill: the next class quest needs about 75."] = "{quest:2282} se dresse à l'est de {area:69}, en hauteur, à l'écart de la route ; des orcs Blackrock rôdent tout près. À l'intérieur, les coffrets d'entraînement reviennent presque aussitôt : crochetez-les jusqu'à ce que le {object:121264} s'ouvre pour vous (environ 25 en Crochetage). Votre maximum en Crochetage augmente de 5 par niveau, un personnage de bas niveau peut donc bloquer. Certains coffrets sont piégés (un piège de givre, par exemple) ; la compétence augmente quand même. Sur Forever, des araignées de niveau 20 errent près des coffrets : éliminez-les d'abord ou venez avec un ami. Le coffret contient toujours le jeton et revient deux secondes après usage. Continuez à vous entraîner tant que cela fait monter la compétence : la quête de classe suivante demande environ 75.",

	-- Step 9: Back to Lucius
	-- {npc:6966} Lucius
	["Back to {npc:6966}"] = "Retournez voir {npc:6966}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165}, in the north of {zone:1455}."] = "Au niveau 16, {npc:1234}, dans la {area:2102} à {area:131}, vous envoie voir {npc:5165}, au nord de {zone:1455}.",
	-- ["At 16 {npc:3599} in {area:186} sends you to {quest:2259} in {zone:1457}."] = "Au niveau 16, {npc:3599} à {area:186} vous envoie voir {quest:2259} à {zone:1457}.",
	-- ["At 16 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}."] = "Au niveau 16, {npc:917}, le maître des voleurs de l'auberge de la Fierté du lion à {area:87}, vous envoie voir {npc:6946} à {zone:1453}.",
	-- ["Ride east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "Allez vers l'est à travers la {zone:1429} jusqu'aux Carmines, ou volez jusqu'à {area:69}. {npc:6966} attend à l'ouest de {area:69} et vous donne des {item:5060}.",
	-- ["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}, then {item:7676} from {npc:7009}."] = "Votre premier travail de crochetage au niveau 16 : le coffret de {npc:6966} à {quest:2282}, pour le {quest:2300}, puis du {item:7676} auprès d'{npc:7009}.",
	-- ["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Votre premier crochetage au niveau 16 : le coffret de {npc:6966} à {quest:2282}, pour le {quest:2300}.",
	-- ["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}."] = "{npc:6946} se tient à côté de {npc:332} au {quest:2300}, dans la {object:2100}. Nains et gnomes prennent le {area:2257} depuis {zone:1455} ; les elfes de la nuit prennent le bateau d'{area:442} au {area:17203}.",
	-- ["{npc:7009}, beside {npc:6966}, wants the {quest:2358}, which the Blackrock orcs of Redridge carry: the first one you kill drops them. The easiest are the Blackrock Grunts (level 19) and Outrunners (20) east of {area:69}; the Shadowcasters (22) and {npc:334} (26) are elite."] = "{npc:7009}, à côté de {npc:6966}, veut les {quest:2358}, que portent les orcs Blackrock des Carmines : le premier que vous tuez les laisse tomber. Les plus faciles sont les Grunts Blackrock (niveau 19) et les Estafettes (20) à l'est de {area:69} ; les Exhalombres (22) et {npc:334} (26) sont élites.",
	-- ["{npc:7009}: ten {item:7676}"] = "{npc:7009} : dix {item:7676}",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {item:7869} there."] = "{quest:2282} se trouve à l'est de {area:69}, en hauteur à l'écart de la route. Ouvrez-y le {item:7869}.",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there."] = "{quest:2282} se trouve à l'est de {area:69}, en hauteur à l'écart de la route. Ouvrez-y {object:121264}.",
	-- ["{quest:2358}: any Blackrock orc"] = "{quest:2358} : n'importe quel orc Blackrock",
}
