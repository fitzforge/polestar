-- French (frFR): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "Poisons (Alliance)",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Sur Forever, les poisons s'apprennent par cette suite de quêtes, pas auprès du maître ; la recette du {item:7676} vient avec.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "Au niveau 20, {npc:332}, à l'étage du bâtiment du SI:7 dans la {object:2100}, vous envoie voir {npc:7024} en {zone:1436}. C'est par cette suite que vous apprenez les poisons sur Forever : ne la passez pas.",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "Kearnen se cache, camouflé, contre le côté ouest d'un grand arbre devant lequel poussent deux petits arbres, juste au nord de la tour défias de {npc:7053}, tout à l'est de la {zone:1436}, près de la frontière du {zone:1431}. Lisez le {item:8046} pour connaître la disposition de la tour si vous le souhaitez.",

	-- Step 3: The Defias Tower Key
	-- {item:7923} Defias Tower Key
	["The {item:7923}"] = "La {item:7923}",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol."] = "Prenez d'abord la clé. Le {npc:7051} (niveau 23, non élite) part de l'entrée de la tour et fait une boucle autour de l'extérieur ; c'est celui aux cheveux hérissés qui laisse une traînée d'étincelles jaunes. Camouflez-vous et utilisez {spell:921} sur lui par-derrière : il a toujours la clé. Il frappe fort : si votre camouflage tombe, fuyez avec {spell:2983}. Méfiez-vous des deux Pantins défias qui patrouillent aussi.",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "",

	-- Step 4: Klaven's journal
	["Klaven's journal"] = "Le journal de Klaven",
	-- {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "Montez la tour en douce. Des Patrouilleurs défias (23) et des Sentinelles (24) gardent les étages ; une Embuscade avec une dague les tue d'un coup si vous préférez les éliminer. {npc:7053}, un élite de niveau 26, attend au dernier étage : assommez-le, ou venez avec un ami. Le {object:123214} à côté de son bureau demande environ 70-75 en Crochetage (entraînez-vous d'abord sur les coffrets d'{area:97}, dans les Carmines). Une astuce : pendant que les Sentinelles sont loin, sautez de la chaise à la lampe puis à la bibliothèque au-dessus du coffre, sortez du camouflage et ouvrez le coffre de là. L'ouvrir vous empoisonne avec le {spell:9810}, qui empêche votre camouflage un moment et permet au pantin de vous voir ; c'est pour cela qu'on prend la clé d'abord. Puis sortez.",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{item:7908} : le {object:123214}, dernier étage",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {item:6947} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {item:6947} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "Remontez vers le nord à travers la forêt d'Elwynn jusqu'à {zone:1453} ; Mathias Shaw est à l'étage du SI:7. Il vous apprend les poisons et vous donne la recette du {item:7676}. Les poisons se fabriquent, ils ne s'achètent pas : chaque fournée de {item:6947} demande une {item:2928} et une {item:3371}, que {npc:1325} et {npc:1326} vendent dans la {object:2100}, à côté du SI:7. Achetez une pile de chaque, ouvrez Poisons depuis votre grimoire pour les fabriquer, puis appliquez un poison sur votre arme.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "{npc:332} : Poisons",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "{quest:2607} pèse toujours sur vous. {npc:7207} travaille dans la cave du bâtiment du SI:7 : l'escalier qui descend est sous l'escalier qui monte à l'étage, derrière {npc:1325}. Ciblez-le et tapez /lay (rien après) pour être examiné, puis attendez. S'il ne fait rien, abandonnez la quête, reprenez-la et attendez qu'il vous demande de vous allonger.",
	["/lay with the Doc targeted"] = "/lay en ciblant le docteur",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "Les ingrédients du remède",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread (no name in this language: may be words) · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "Retour auprès de {npc:7207}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/lay down",
	-- ["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: an engineering supplier, who keeps only a few (or an engineer or the Auction House). The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "Les quatre se trouvent à {zone:1453}. {item:3421} : Bernard ou la boutique de fleurs de {npc:1303}, au bord du canal du {object:2096}. Une {item:3372} : chez beaucoup de marchands d'articles généraux et d'alchimie ({npc:1257}, {npc:1325} et d'autres). Un {item:4371} : chez un fournisseur d'ingénierie, qui n'en a que quelques-uns (ou auprès d'un ingénieur ou à l'hôtel des ventes). La {item:8431} est posée au sol à côté du bout gauche du comptoir de la boutique de tailleur Au fil le plus fin, sur les canaux ; vous ne pouvez la ramasser qu'avec cette quête. Si vous vous passez du remède, un {item:6452} ({skill:129}) ou le {spell:526} d'un druide dissipe aussi le {spell:9810}.",
	-- ["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "Au niveau 20, {npc:332}, au SI:7 dans {object:2100}, vous envoie voir {npc:7024} en {zone:1436}.",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "Tout se trouve à {zone:1453} : les Gump vendent des {item:3421}, la {item:8431} se trouve dans la ville, et les marchands les plus proches vendent une {item:3372} et un {item:4371}.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Dans Forever, {spell:2842} s'apprend par cette suite de quêtes, pas auprès du maître ; la recette du {item:7676} vient avec.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Chevauchez vers le nord à travers Elwynn jusqu'à {zone:1453} ; Mathias Shaw se trouve au SI:7, dans {object:2100}.",
	-- ["{item:7908}, in the {object:123214}"] = "{item:7908}, dans le {object:123214}",
	-- ["{item:7923}: {spell:921} the {npc:7051}"] = "{item:7923} : {spell:921} sur le {npc:7051}",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024} surveille la tour de {npc:7053} depuis les collines à l'extrême est de {zone:1436}, près de la frontière de {zone:1431}. Le {npc:7051} (niveau 23) qui garde la tour porte sa clé ; le journal de Klaven est dans le coffre au sommet.",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207} travaille dans la cave du SI:7, la caserne. Tapez /lay down à côté de lui pour être examiné.",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842} (Alliance)",
}
