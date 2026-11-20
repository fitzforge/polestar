-- French (frFR): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "Pour les personnages de niveau 35 à 36, mais plusieurs quêtes ici sont de niveau 37-38 : c'est voulu, pour leur expérience. Les élémentaires d'eau sont de niveau 36-37 : attirez-les un par un.",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "Dans {object:2164}, si vous l'avez encore",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Prendre un vol pour {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "Vers {zone:1434}",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "Depuis {zone:1431}, prenez la route vers le sud ; le camp se trouve dans les collines à l'ouest de la route.",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}, si 30-40/04 ne vous l'a pas donnée : pour {npc:773} à {area:35}",

	-- Step 5: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "Vers le sud le long de la route : les tentes des chasseurs se trouvent juste à l'ouest. {npc:717} et Hemet vous les ont données lors de la première boucle : ne les prenez maintenant que si ce n'est pas le cas.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}. Keep it for the later visit if you skip {npc:729} on the raptor hill."] = "",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}, si 30-40/04 ne vous l'a pas donnée : les Raptors flagellants, après les ruines de la jungle",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "À l'est vers {area:101} : les registres d'Herod se trouvent dans une hutte du côté ouest.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}, à l'étage",

	-- Step 7: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "{npc:218230}, un cuisinier, est enfermé dans une cage à la lisière ouest du camp : prenez sa quête maintenant et gardez-la ; la clé de sa cage et l'uniforme de combattant viennent avec le guide Strangleronce 40-50, quand les Sous-chefs et les Élites sont de votre niveau. Les Réducteurs de têtes se tiennent plus loin dans le camp ; les Commandos rôdent camouflés autour et dans la grotte, et le coffre d'Herod se trouve à l'entrée de la grotte. Ramassez les pages des Collines verdoyantes à mesure qu'elles tombent.\nAttention : les Commandos de Kurzen sont de niveau 34-35, non élites, et apparaissent souvent camouflés ; près de la mort, ils utilisent {spell:7964}. {npc:813}, un Élite de niveau 39-40, se tient au nord du camp : laissez-le tranquille.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}, dans sa cage",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, sous terre",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}, sous terre",

	-- Step 8: The jungle ruins
	["The jungle ruins"] = "Les ruines de la jungle",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "À l'ouest à travers la jungle vers les ruines trolls : chacune abrite une tablette de pierre des légendes trolls, les deux premières dans les ruines au sud-ouest du camp de Nesingwary, les deux dernières sur la colline au nord-ouest.\nAttention : les murlocs Écaille-salée sur la rive près de la deuxième tablette sont élites (35-37) : rejoignez la tablette à la nage et tenez-vous à l'écart.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006} : {object:58} ; sous l'eau",

	-- Step 9: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "L'île hantée se trouve juste au large de la côte, à l'ouest de la deuxième tablette : les Élémentaires d'eau mineurs surgissent de l'eau tout autour.",

	-- Step 10: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "{area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "Au nord le long de la côte vers les ruines sur la colline : les deux dernières tablettes s'y trouvent. {npc:268992}, un gobelin, est enfermé dans une cage à côté de la troisième tablette : n'importe quel Bloodscalp peut lâcher sa {item:277957}, puis escortez-le hors des ruines. Les Cargaisons volées se trouvent à la lisière est des ruines. Ramassez les pages des Collines verdoyantes à mesure qu'elles tombent.\nAttention : les Berserkers, Chasseurs de têtes et Sorciers-docteurs Bloodscalp (36-37) tiennent le cœur des ruines : attirez-les un par un.",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}, dans sa cage à côté de la troisième tablette",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}, sur les trolls Bloodscalp",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "Pour {npc:4631} à {area:35}, à la fin de cette boucle",

	-- Step 11: Sin'Dall on the raptor hill
	-- {npc:729} Sin'Dall
	["{npc:729} on the raptor hill"] = "",
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["Check the hilltop on your way to the raptors. If {npc:729} isn't here or you can't pull her alone, keep moving; {npc:717} can take the paw on the later visit."] = "",
	-- {npc:729} Sin'Dall
	["{npc:729}'s hill"] = "",
	-- {npc:729} Sin'Dall
	["{npc:729} (37) prowls the hilltop."] = "",

	-- Step 12: The Lashtail raptors
	["The Lashtail raptors"] = "Les raptors flagellants",
	-- {quest:187} Tiger Mastery · {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins, hunt Lashtail Raptors around the hill south-west of Nesingwary's camp. If you have {quest:187}, are at least 36 and see {npc:729} (37) alone, you can take her paw here or leave the hunt for your next visit."] = "",

	-- Step 13: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["Hand the paw to {npc:717} beside Hemet."] = "",

	-- Step 14: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715} : les Traqueurs de la jungle, ce sera en 40-50",

	-- Step 15: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "Au nord-est par la route jusqu'au {area:99}, puis revenez vers le sud à travers la jungle.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733} : les Commandos et les Réducteurs de têtes tombés dans le camp",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "gardez-la : les Sorciers-docteurs Skullsplitter (41-42) attendent le guide Strangleronce 40-50",

	-- Step 16: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocilisques Gueule d'acier",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "Des Crocilisques Gueule d'acier se prélassent le long de la rivière au milieu de la jungle, sur le chemin de {area:35} au sud.",

	-- Step 17: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, à l'intérieur",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, à l'étage de la taverne",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Pour l'archimage Ansirem dans {zone:1416}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, à l'étage",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}, à l'étage : cette quête facultative demande quatre {item:4278}. Minez des Gisements de pierre de sang inférieure dans {zone:1417} avec {skill:186} 75, ou achetez le minerai à l'hôtel des ventes, ou demandez à un ami mineur. Les kobolds ne le lâchent pas ; passez cette quête si vous ne pouvez pas obtenir le minerai.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}, sur les quais",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "À l'est des ruines vers la colline au sud-ouest du camp de Nesingwary : les Raptors flagellants courent dans la jungle autour. Laissez {npc:729}, le grand tigre (37) au sommet, pour le guide Strangleronce 40-50 : vous êtes environ niveau 35 ici. Puis continuez vers les tentes des chasseurs.",
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "À l'est vers {area:99}, sur le chemin du retour au camp de Nesingwary.",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "Pour les personnages de niveau 35 à 36, mais plusieurs quêtes ici sont de niveau 37-41 : c'est voulu, pour leur expérience. Les trolls Skullsplitter de {quest:205} sont de niveau 39-42 : attirez-les un par un.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "Les Réducteurs de têtes se tiennent plus loin dans le camp ; les Commandos rôdent camouflés autour et dans la grotte, et le coffre d'Herod se trouve à l'entrée de la grotte. Ramassez les pages des Collines verdoyantes à mesure qu'elles tombent.\nAttention : les Commandos de Kurzen sont de niveau 34-35, non élites, et apparaissent souvent camouflés ; près de la mort, ils utilisent {spell:7964}.",
	-- ["Level 36"] = "Niveau 36",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Faites le tour des ruines trolls du nord et du centre : chacune abrite une tablette de pierre des légendes trolls. Les Panthères Ombregueule rôdent camouflées dans la jungle autour ; le camp de la KapitalRisk sur {area:37} porte les Cristaux réduits.",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "Au nord le long de la côte vers les ruines sur la colline : les deux dernières tablettes s'y trouvent. Ramassez les pages des Collines verdoyantes à mesure qu'elles tombent.",
	-- ["Skullsplitter trolls"] = "Trolls Skullsplitter",
	-- ["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "Des Crocilisques Gueule d'acier se prélassent le long de la rivière au milieu de la jungle, sur le chemin des ruines Skullsplitter au sud.",
	-- ["South along the road: the hunters' tents stand just west of it."] = "Au sud par la route : les tentes des chasseurs se trouvent juste à l'ouest.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "Au sud du campement, vers {area:37} : les Géologues de la KapitalRisk dans les camps sur ses rives portent les Cristaux réduits, et les Panthères Ombregueule rôdent camouflées dans la jungle au sud et à l'est.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "Au sud du camp, vers {area:37} : les Géologues de la KapitalRisk dans les camps sur ses rives portent les Cristaux réduits. Attention : des Agents de la KapitalRisk (39) circulent parmi eux : attaquez les Géologues en bordure des camps, un par un. Des Panthères Ombregueule (37-38) rôdent camouflées dans la jungle au sud et à l'est du lac : restez dans les camps des rives.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Les trolls Skullsplitter tiennent les ruines à l'est de la route entre Nesingwary et {object:3202}.",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "À l'ouest à travers la jungle vers les ruines trolls : chacune abrite une tablette de pierre des légendes trolls, les deux premières dans les ruines au sud-ouest du camp de Nesingwary, les deux dernières sur la colline au nord-ouest.",
	-- ["grind on {npc:1152}"] = "tuez en boucle : {npc:1152}",
	-- ["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}, si 30-40/04 ne vous l'a pas donnée : {npc:729}, dans le guide Strangleronce 40-50",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718} : les Panthères Ombregueule rôdent autour de {area:37}, après {area:101}",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770} : pour {npc:773} à {area:35}",
	-- ["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Les trolls Skullsplitter de {quest:205} sont de niveau 39-42. En dessous de 36 ? Continuez à tuer les Crocilisques Gueule d'acier le long de la rivière jusqu'au niveau 36. Ou, en groupe, faites plutôt le donjon {area:796} (Armurerie) ou le donjon {area:1316}.",
	-- ["{zone:1434}: kill these as you meet them"] = "{zone:1434} : tuez-les au passage",
}
