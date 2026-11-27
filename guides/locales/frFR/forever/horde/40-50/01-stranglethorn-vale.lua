-- French (frFR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Prendre un vol pour {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Votre entraînement de niveau 40 se fait à {area:1497} : prenez un vol depuis {area:340}, entraînez-vous, puis prenez le zeppelin aux tours à l'extérieur de la ville pour {object:3202}.",

	-- Step 2: Genavie Callow
	-- {npc:4486} Genavie Callow · {zone:1417} Arathi Highlands
	["{npc:4486} stands beside the flight master you land at: the Dabyrie heads from the {zone:1417}."] = "",
	-- {npc:4486} Genavie Callow
	["{npc:4486}, beside the flight master"] = "",

	-- Step 3: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Maîtres de {zone:1458}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "La monte au niveau 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès du maître de sa propre race : le vôtre est {npc:4773} à {area:159}, à courte distance au nord des tours des zeppelins, avec les chevaux squelettes de {npc:4731} (20 pièces d'or chacun) à côté d'elle. Revenez aux tours pour le zeppelin de {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, maître de monte",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Chevaux squelettes : {npc:4731}, à côté de {npc:4773} à {area:159}.",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",

	-- Step 6: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vol pour {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Maître de vol de {area:340}",

	-- Step 7: Grom'gol Base Camp
	-- {npc:5814} Innkeeper Thulbek
	["{npc:5814}, by the flight master: hearth back here after the trainer trip at 40"] = "",
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519} : la légende se trouve à Zul'Kunda, où ce guide va pour {npc:1061}",
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay · {quest:1261} Marg Speaks · {npc:4791} Nazeer Bloodpike · {area:496} Brackenwall Village
	["the {object:2076} beside {npc:2519}: {quest:1261}, for {npc:4791} in {area:496} on the Dustwallow guide, where the crabs drop the pendant"] = "",
	-- {npc:2519} Kin'weelay · {quest:598} Split Bone Necklace
	["{npc:2519}: {quest:598}, the trophy skulls stand in the Skullsplitter ruins, on this guide's second loop"] = "",
	-- {npc:2497} Nimboya · {quest:2932} Grim Message · {zone:1425} Hinterlands
	["{npc:2497}: {quest:2932}, for the {zone:1425}, around level 48"] = "",

	-- Step 8: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "Les Traqueurs de la jungle (40-41) chassent sur la côte au sud de {object:3202}. Ils sont bien au-dessus de vous : attirez-les un par un et reposez-vous entre les combats.\nAttention : {npc:730}, un raptor élite de niveau 43, rôde parmi les traqueurs : laissez-le pour l'étape de groupe de {quest:195}.",

	-- Step 10: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Maître de vol de Grom'gol",

	-- Step 11: Drizzlik
	-- {npc:2495} Drizzlik
	["{npc:2495}'s shop is in the building east of the inn."] = "La boutique de {npc:2495} est dans le bâtiment à l'est de l'auberge.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495} : les peaux de Gueule d'acier ramassées plus tôt ; à l'intérieur",

	-- Step 12: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, le maître de vol, attend sur le pont supérieur de {area:35}. Les donneurs de quête se tiennent sur les passerelles autour du port et dans l'auberge.",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495} : le {npc:2635} se dore au soleil sur la côte entre Zul'Kunda et {object:3202}, plus tard dans cette boucle",

	-- Step 13: Kebok
	-- {npc:737} Kebok
	["{npc:737} stands upstairs, beside the flight master."] = "{npc:737} se tient à l'étage, à côté du maître de vol.",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals from the earlier Stranglethorn guide"] = "{npc:737} : les cristaux roulés ({item:4106}) du guide précédent de Strangleronce",

	-- Step 14: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "{npc:737}, à l'étage, a maintenant sa mission suivante : les défenses Skullsplitter viennent des trolls de Zul'Mamwe, plus loin dans cette boucle.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",

	-- Step 15: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, sur les quais : la lettre de Gazlowe, si vous l'avez",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631} : {quest:97332}, après le sauvetage de Zimmix ; le paquet va à {npc:259961} à {area:16727}, dans le guide {zone:2548}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, sur le balcon à côté de MacKinley",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is in his house by {area:37}, on your way north to Nesingwary"] = "",
	["Inside"] = "À l'intérieur",

	-- Step 16: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Quittez la ville par le tunnel ; la note se trouve dans la crique des pirates juste au nord de {area:35}.",

	-- Step 18: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilles de Valbrume",
	-- {quest:348} Stranglethorn Fever
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: if you will take {quest:348} with a group, keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Les gorilles errent dans la vallée autour d'Unbagwa. Les anciens lâchent les abats ; n'importe lequel peut lâcher un croc : si vous prendrez {quest:348} en groupe, gardez-en dix pour Unbagwa, dont le Mokk (44) attend votre arrêt à Strangleronce vers le niveau 45.\nAttention : les anciens gorilles de Valbrume (40-41) se tiennent serrés dans la vallée : attirez-les un par un.",
	-- {quest:348} Stranglethorn Fever
	["Keep fangs from these same elders for Unbagwa ({quest:348}, with a group)."] = "Gardez les crocs de ces mêmes anciens pour Unbagwa ({quest:348}, en groupe).",

	-- Step 19: Mistvale giblets
	["Mistvale giblets"] = "",

	-- Step 20: Mistvale gorillas at 39
	["Mistvale gorillas at 39"] = "",
	["Look for lone level 40 elders in this same camp for the sinew and giblets. Leave level 41 gorillas alone; don't stay just for extra fangs."] = "",

	-- Step 21: Venture Co. mine
	["Venture Co. mine"] = "Mine de la KapitalRisk",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Plus au nord, les gobelins de la KapitalRisk creusent dans la mine à l'est de la route ; mineurs, contremaîtres, géomètres et bricoleurs lâchent tous les cristaux.\nAttention : des Panthères Ombregueule camouflées et des Tigresses de Strangleronce parcourent les environs du camp.",

	-- Step 22: Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Shadowmaw Panthers"] = "Panthères Ombregueule",
	-- {quest:192} Panther Mastery
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["{quest:192} is still open: the Shadowmaw Panthers (37-38) stalk the jungle north of the mine, towards the Mosh'Ogg hills. They use Sneak, so they show only when you are close: pull them one at a time, and leave the Elder Shadowmaw Panthers (42-43) alone."] = "{quest:192} est encore ouvert : les Panthères Ombregueule (37-38) rôdent dans la jungle au nord de la mine, vers les collines Mosh'Ogg. Elles se camouflent, elles ne se montrent que quand vous êtes proche : attirez-les une par une et laissez les Anciennes panthères Ombregueule (42-43) tranquilles.",

	-- Step 24: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptors Fouette-queue",
	-- {quest:195} Raptor Mastery · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:195} is still open: the Lashtail Raptors (35-36) hunt the jungle between {object:3202} and Nesingwary's camp, on your way north."] = "{quest:195} est encore ouvert : les Raptors flagellants (35-36) chassent la jungle entre {object:3202} et le camp de Nesingwary, sur votre chemin vers le nord.",

	-- Step 25: Foreman Cozzle's house
	-- {npc:4723} Foreman Cozzle
	["{npc:4723}'s house"] = "",
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Agents = {npc:260429} Venture Co. Agent
	["On the way north, a short way east of the road: {npc:4723}'s house stands on the north shore of {area:37}. {npc:4723} (38) carries the key to his footlocker, inside the house; the Venture Co. Agents (39) stand in and around it: pull them one at a time. Then on north-west to Nesingwary's camp."] = "",
	-- {object:20691} Cozzle's Footlocker
	["{object:20691}, inside the house"] = "",

	-- Step 26: Nesingwary's camp
	["Nesingwary's camp"] = "Camp de Nesingwary",
	["Head north up the road; the hunters camp on the hill above the river."] = "Remontez la route vers le nord ; les chasseurs campent sur la colline au-dessus de la rivière.",

	-- Step 27: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729}, le tigre que {npc:717} vous a demandé de traquer lors de votre dernière visite, rôde sur la colline juste au sud-ouest du camp.",

	-- Step 30: Nesingwary's camp
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Vous avez manqué ceci lors du passage précédent de l'itinéraire ici : cela passe d'abord maintenant. C'est rapide et cela ouvre les quêtes qui suivent.",

	-- Step 31: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} rassemble les pages de {quest:338} : les trolls de la vallée en lâchent de temps en temps. Prenez sa quête ; il prend chaque chapitre une fois que vous en avez toutes les pages.",

	-- Step 32: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716} : toutes les pages du chapitre I sont dans vos sacs",

	-- Step 33: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716} : toutes les pages du chapitre II sont dans vos sacs",

	-- Step 34: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716} : toutes les pages du chapitre III sont dans vos sacs",

	-- Step 35: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716} : toutes les pages du chapitre IV sont dans vos sacs",

	-- Step 36: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716} : les quatre chapitres",

	-- Step 37: Zul'Kunda
	["Zul'Kunda"] = "Ruines de Zul'Kunda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "À l'ouest de l'expédition, les chefs Bloodscalp {npc:1061} et {npc:1062} se tiennent ensemble dans les ruines de Zul'Kunda. Éliminez d'abord leurs gardes, puis attirez-les.\nSur la côte entre Zul'Kunda et {object:3202}, un {npc:2635} (élite de niveau 38) partage les points d'apparition des crocilisques ordinaires : tuez-le s'il est là et prenez sa peau pour {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "sur la {object:52}, dans les ruines",

	-- Step 38: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "le {object:2076}, à côté de {npc:2497}",
	-- {npc:2519} Kin'weelay
	["{npc:2519}, if you didn't take it on the first stop: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519} : l'entrée de la caverne sous {area:104}, à l'ouest du camp",

	-- Step 39: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454} : {npc:4752} enseigne aux Orcs dans la {object:172958}, près du chenil de {npc:3362} (loups à 20 po chacun). Puis reprenez le zeppelin vers {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par {zone:1454} vers le niveau 45."
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then hearth back to {object:3202}, or take the zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, maître de monte",

	-- Step 40: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454} et descendez vers le sud par la route de {zone:1411} jusqu'au {area:367} : {npc:7953} y enseigne aux Trolls, avec les raptors de Zjolnir (20 po chacun). Puis retournez au zeppelin pour {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par {zone:1454} vers le niveau 45."
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then hearth back to {object:3202}, or take the zeppelin from {zone:1454} if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",

	-- Step 41: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454}, volez jusqu'aux {zone:1456} et descendez jusqu'au {area:222} : {npc:3690} y enseigne aux Taurens, avec les kodos de {npc:3685} (20 po chacun). Puis revolez jusqu'à {zone:1454} pour le zeppelin de {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par les {zone:1456} vers le niveau 45."
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then hearth back to {object:3202}, or fly back to {zone:1454} for the {object:3202} zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, maître de monte",

	-- Step 42: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne un Galestrider, et {zone:2548} après Strangleronce sont une longue marche sans lui. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454} et volez jusqu'aux {zone:1456} : le bateau volant pour {zone:2521} part des falaises au sud de {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes, et {npc:265756} enseigne aux Skyborne aux {area:17684} à {area:16638}. Puis retournez à {zone:1454} pour le zeppelin de {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par {zone:1454} vers le niveau 45."
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then hearth back to {object:3202}, or go back to {zone:1454} for the {object:3202} zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}, Maître de monte, aux {area:17684} à {area:16638}",

	-- Step 43: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1444} Feralas · {zone:1446} Tanaris
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'aux tours de {area:1497} : {npc:4773} enseigne aux Réprouvés à {area:159}, un peu plus au nord, avec les chevaux squelettes de {npc:4731} (20 po chacun). Puis reprenez le zeppelin vers {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1435} repasse par {area:1497} vers le niveau 47."
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {zone:1458}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then hearth back to {object:3202}, or take the zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} & {zone:1446} guide passes the {zone:1458} again at about 45."] = "",

	-- Step 44: Your mount at 40
	["Your mount at 40"] = "Votre monture au niveau 40",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "Les démonistes n'achètent pas la monte : leur monture est le Palefroi corrompu, obtenu par leur quête de classe. Zevrost, à {object:172960} à {zone:1454}, la lance et {npc:6251} à {area:392} vous l'apprend, tous deux lors de l'étape à {zone:1454} du guide de {zone:1444}, vers le niveau 45.",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "Palefroi corrompu : Zevrost à {zone:1454}, puis {npc:6251} à {area:392}, lors de l'étape à {zone:1454} du guide de {zone:1444}.",

	-- Step 45: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol (no name in this language: may be words) · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770} : à l'ouest de {object:3202}, nagez au-dessus de {area:104} et plongez jusqu'à l'entrée de la caverne dans le récif ; la quête s'accomplit dès que vous la trouvez. Laissez la caverne pour l'instant : les traqueurs de la jungle sont au sud, le long de la côte.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "l'entrée de {area:16550}, sous l'eau",

	-- Step 46: Jungle stalkers
	["Jungle stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "Les raptors traqueurs chassent dans la jungle au sud de {object:3202}, vers la côte ouest.\nAttention : les Traqueurs de la jungle (40-41) sont nombreux ici : attirez-les un par un et reposez-vous entre les combats.",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "Les explorateurs nagas sur la côte au sud d'ici (43-44) sont pour Bloads et Mok'thardin : gardez les deux quêtes pour votre étape à Strangleronce vers le niveau 45.",

	-- Step 47: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Allez vers le sud jusqu'à {area:35}. Shaky Phillipe attend sur les quais.",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony"] = "",
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1444} Feralas · {zone:1446} Tanaris
	["{npc:2496}: for Pozzik at the {area:2240}, on the {zone:1444} & {zone:1446} guide's way"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}, à l'étage : les défenses viennent des Skullsplitter, plus loin dans cette boucle",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "MacKinley : gardez-la, les pirates fantômes (43-44) attendent votre étape à Strangleronce vers le niveau 45",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, à l'intérieur : la {item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493} : gardez-la pour {area:43} vers le niveau 45",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487} : gardez-la pour {area:43} vers le niveau 45",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}, au dernier étage : gardez-la pour {area:43} vers le niveau 45",

	-- Step 48: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "",
	-- {npc:2491} Whiskey Slim · {zone:1444} Feralas · {zone:1446} Tanaris · {area:35} Booty Bay
	["{npc:2491}, in the inn, and \"Sea Wolf\" MacKinley, on the top floor, offer these quests from level 40: pick them up now. Under 40, the {zone:1444} & {zone:1446} guide's {area:35} stop offers them again."] = "{npc:2491}, à l'auberge, et « Loup de mer » MacKinley, au dernier étage, proposent ces quêtes dès le niveau 40 : prenez-les maintenant. Sous le niveau 40, l'arrêt de {area:35} du guide {zone:1444} & {zone:1446} les propose à nouveau.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, dans l'auberge : ses bouteilles s'échouent sur la côte des {zone:1425}, vers le niveau 48",
	-- {quest:2872} Stoley's Debt · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for Stoley in {zone:1446}"] = "",

	-- Step 49: Fin Fizracket
	-- {quest:348} Stranglethorn Fever · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["Group quest: {quest:348} ends at {npc:1449} in Mistvale. Hand him ten gorilla fangs and he calls three waves of gorillas (41-42), one after another, then {npc:1514} (44). In players' recordings, 12 of the 27 people who started it died there. Take it if you have a friend or two along."] = "Quête de groupe : {quest:348} se termine auprès de {npc:1449} à Valbrume. Donnez-lui dix crocs de gorille et il appelle trois vagues de gorilles (41-42), l'une après l'autre, puis {npc:1514} (44). Dans les enregistrements des joueurs, 12 des 27 personnes qui l'ont commencée y sont mortes. Prenez-la si vous avez un ami ou deux avec vous.",
	-- {npc:2486} Fin Fizracket · {zone:1444} Feralas · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2486}, beside the inn: Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}, à côté de l'auberge : la partie d'Unbagwa à l'arrêt de {object:3202} du guide {zone:1444}",

	-- Step 50: The Bloodsail ships
	["The Bloodsail ships"] = "Les navires de la Voile sanglante",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Le parchemin, {quest:624}, se trouve sur les ponts des trois navires au large de {area:43}, dont l'équipage compte des pirates de niveau 42-45 qui vont par deux, et des capitaines de niveau 45-48 : faites-le en groupe. Sa suite se poursuit dans {zone:1435}, {zone:1445} et les {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "pour une étape ultérieure dans {zone:1435}",

	-- Step 51: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "Prenez un vol pour revenir à {object:3202} : les Fendeurs de crânes de Zul'Mamwe sont juste à l'est.",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 52: Zul'Mamwe
	["Zul'Mamwe"] = "Ruines de Zul'Mamwe",
	["The warriors in the northern ruins (39-40) drop both tusks and necklaces. Pull from the edge; leave the chief and his two guards to the south alone."] = "",

	-- Step 53: Zul'Mamwe and Balia'mah trophy skulls
	["Zul'Mamwe and Balia'mah trophy skulls"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Look for the trophy skulls in the small ruins north of Zul'Mamwe's warriors.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "",

	-- Step 54: Kin'weelay
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Allez vers l'ouest jusqu'à Grom'gol.",

	-- Step 57: Grom'gol Base Camp
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464} : pour {npc:256418} à {area:16743}, le fort de la Horde de {zone:2548}, dans le guide suivant",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "Gardez {quest:571}, {quest:621} et les défenses de {npc:737} : le chef des Fendeurs de crânes, les camps de Zanzil, la côte des nagas et {area:35} viennent lors de votre étape à Strangleronce vers le niveau 45, après {zone:2548}.",

	-- Step 59: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Remontez la route vers le nord jusqu'au camp des chasseurs.",

	-- Step 61: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:730} est un élite de niveau 43 : la plupart des classes le tuent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul.",

	-- Step 62: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:728} est un élite de niveau 40 : la plupart des classes le tuent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul.",

	-- Step 66: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. Le {npc:731} est un élite de niveau 43 : la plupart des classes le tuent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul.\nAttention : des tigres et des panthères Ombregueule camouflées rôdent près de lui. Éliminez-les avant de l'attirer. Une fois attiré, le {npc:731} appelle à l'aide les créatures à moins de 20 m.",

	-- Step 71: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Vers {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Suivez la route vers l'est depuis {zone:1431} à travers {zone:1430} jusqu'au marais. {npc:1776} attend à {area:657}, le camp draeneï juste à côté de la route, là où elle arrive depuis {zone:1430}.",

	-- Step 72: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Allez vers l'est jusqu'à {area:75}, dans les roseaux au sud de la route.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, à l'intérieur",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, à l'étage",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, au dernier étage",

	-- Step 73: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocilisques Dents-de-scie",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Les crocilisques se vautrent dans les mares autour du camp de {npc:5391} et vers le sud jusqu'à {area:75} ; environ un sur quatre laisse tomber un flanc.",

	-- Step 74: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru erre dans la clairière au sud-ouest de {area:76} ; son gourdin lance une quête.",

	-- Step 75: Draenethyst crystals
	["Draenethyst crystals"] = "Cristaux de draenéthyste",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Allez vers le nord-est jusqu'à {area:76}. Les cristaux se dressent le long du chemin qui monte vers la cage de {npc:5391}.",

	-- Step 76: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} est retenu à {area:76}, dans le nord-est du marais. Libérez-le et suivez-le dehors en repoussant les créatures du marais qui le poursuivent.",

	-- Step 77: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Son coffre attend à son ancien camp au nord de {area:75}, sur le chemin du retour vers l'ouest.",

	-- Step 78: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "",

	-- Step 79: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east along the road, past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}. Only Sawfin Frenzies (38-40) swim there."] = "",

	-- Step 80: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} takes the crocolisk flanks, and {npc:5593} stands beside him."] = "",

	-- Step 81: Sawtooth snappers
	["Sawtooth snappers"] = "Mordeurs Dents-de-scie",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Sawtooth Snappers = {npc:1087} Sawtooth Snapper
	["The Sawtooth Snappers (41-42) line the strand south of the post; nearly every one drops a claw. Leave the murlocs further along the shore for your next swamp visit.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "",

	-- Step 82: Misty Reed Post
	-- {npc:5593} Katar
	["{npc:5593}: the murlocs (41-44) wait for your next swamp visit"] = "",

	-- Step 83: Stonard
	-- {area:75} Stonard · {npc:1443} Fel'zerul · {quest:1430} Fresh Meat · {npc:5593} Katar
	["Back north-west along the road to {area:75}: {npc:1443}, on the top floor, takes the artifacts. {quest:1430}'s crawlers and {npc:5593}'s murlocs wait for your next swamp visit."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "Sous terre",
	-- ["Boat to {area:35}"] = "Bateau pour {area:35}",
	-- ["Boat to {area:392}"] = "Bateau pour {area:392}",
	-- ["Fly to {area:392}"] = "Vol pour {area:392}",
	-- ["Fly to {area:75}"] = "Prendre un vol pour {area:75}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Suivez la côte vers le sud. Les explorateurs nagas pataugent le long du rivage et portent les bottes de roseaux ; {object:759} bouillonne dans les collines juste à l'est.",
	-- ["From {area:2408} fly to {area:392}."] = "Depuis {area:2408}, prenez un vol pour {area:392}.",
	-- ["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "Depuis {object:3202}, allez vers l'est jusqu'aux ruines des Fendeurs de crânes, à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. Un tas de crânes trophées se trouve au nord des ruines. Chaque Fendeur de crânes peut lâcher une défense ou un collier : les colliers sont la partie la plus lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous. Attention : {npc:1059} (45) parcourt les ruines du sud-ouest avec deux gardes ; la dernière pièce de {npc:1061}, son Armure brisée, attend votre étape à Strangleronce vers le niveau 45.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Plus au nord, les gobelins de la KapitalRisk creusent la mine à l'est de la route ; mineurs, contremaîtres, géomètres et bricoleurs laissent tous tomber les cristaux.",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Donnez les crocs à Unbagwa et restez près de lui : il appelle trois vagues de gorilles, puis {npc:1514}. Combattez-les un par un.",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Allez vers le nord jusqu'aux ruines Skullsplitter, à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. {npc:1059} garde les ruines du sud-ouest, et un tas de crânes trophées se trouve du côté nord des ruines. Chaque Skullsplitter peut lâcher une défense ou un collier : les colliers sont la partie lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous.",
	-- ["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Allez vers l'ouest le long de la route jusqu'au camp draeneï de {area:657}, près de l'entrée depuis {zone:1430}. {quest:698} va à {npc:5592} à {area:1978} lors de la prochaine visite du marais : gardez les flancs.",
	-- ["Hearth to {area:117}"] = "Pierre de foyer vers {area:117}",
	-- ["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Hearth to {object:3202}"] = "Pierre de foyer vers {object:3202}",
	-- ["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "Si vous avez passé {quest:192} ou {quest:195}, tuez des monstres ici jusqu'au niveau 42.68 pour rester dans le plan de la route.",
	-- ["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "Si vous avez passé {quest:208}, tuez des monstres ici jusqu'au niveau 42.74 pour rester dans le plan de la route.",
	-- ["Inside {area:1742}"] = "Dans {area:1742}",
	-- ["Into the {area:8}"] = "Vers le {area:8}",
	-- ["Ironjaw Basilisks"] = "Basilics gueule de fer",
	-- ["Keep going north into {area:10}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continuez vers le nord jusqu'au {area:10}, puis vers l'est par la route à travers le {zone:1430} jusqu'au marais. {npc:1776} attend à {area:657}, le camp draeneï près de l'entrée depuis le {zone:1430}.",
	-- ["Level 42.68"] = "Niveau 42.68",
	-- ["Level 42.74"] = "Niveau 42.74",
	-- ["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "MacKinley, au dernier étage : pour Stoley à {zone:1446}",
	-- ["Naga shore and the {object:759}"] = "Rivage des nagas et {object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "Au nord-est de Valbrume, les disciples de Zanzil campent dans la jungle ; chacun d'eux peut porter le mélange.",
	-- ["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Facultatif, et difficile au niveau 42 : le parchemin, {quest:624}, se trouve sur les ponts des trois navires au large du {area:43}, dont l'équipage compte des pirates de niveau 42-45 qui vont par deux. Ne le prenez que si vous pouvez attirer l'équipage jusqu'au bastingage un par un, ou avec un ami ; sa suite se poursuit dans {zone:1435}, {zone:1445} et les {zone:1425}.",
	-- ["Pirate ghosts"] = "Pirates fantômes",
	-- ["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptors : Zjolnir, à côté de {npc:7953}, à {area:367}.",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Revenez vers l'est après {area:75} et suivez la route vers le sud-est jusqu'au petit poste de la Horde sur le rivage.",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "Chevauchez vers l'est jusqu'à {area:75}, dans les roseaux au sud de la route.",
	-- ["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Remontez vers le nord depuis {area:35} par la route ; les basilics se prélassent sur les rochers à l'est de celle-ci, au milieu de la jungle, sur le chemin du retour vers {object:3202}. Leurs éclats tombent souvent.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Chevauchez vers le nord jusqu'aux ruines Skullsplitter à l'est de la mine de la KapitalRisk ; attirez les chasseurs de têtes et les berserkers un par un. {npc:1059} garde les ruines du sud-ouest, et un tas de crânes trophées se trouve au nord des ruines. Tout Skullsplitter peut laisser tomber une défense ou un collier : les colliers sont la partie lente, alors continuez à tuer dans le camp des guerriers au nord des ruines jusqu'à les avoir tous.",
	-- ["Ride north up the road to the hunters' camp."] = "Remontez la route vers le nord jusqu'au camp des chasseurs.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Remontez la route vers le nord ; les chasseurs campent sur la colline au-dessus de la rivière.",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Chevauchez vers le nord-est jusqu'à {area:76}. Les cristaux se dressent le long du chemin qui monte vers la cage de {npc:5391}.",
	-- ["Ride on north to {object:3202}."] = "Continuez vers le nord jusqu'à {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Chevauchez vers le sud jusqu'à {area:35}. Phillippe le Chancelant attend sur les quais.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Chevauchez vers l'ouest le long de la route jusqu'au camp draeneï de {area:657}, près de l'entrée depuis {zone:1430}. {quest:698} va à {npc:5592} à {area:1978} lors de la prochaine visite du marais : gardez les flancs.",
	-- ["Ride west to {object:3202}."] = "Chevauchez vers l'ouest jusqu'à {object:3202}.",
	-- ["Riding at 40"] = "La monte au niveau 40",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne un Galestrider, et {zone:2548} après Strangleronce sont une longue marche sans lui. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454} et volez jusqu'aux {zone:1456} : le bateau volant pour {zone:2521} part des falaises au sud de {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes, et {npc:265756} enseigne aux Skyborne aux {area:17684} à {area:16638}. Puis retournez à {zone:1454} pour le zeppelin de {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par {zone:1454} vers le niveau 45.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'aux tours de {area:1497} : {npc:4773} enseigne aux Réprouvés à {area:159}, un peu plus au nord, avec les chevaux squelettes de {npc:4731} (20 po chacun). Puis reprenez le zeppelin vers {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1435} repasse par {area:1497} vers le niveau 47.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454} et descendez vers le sud par la route de {zone:1411} jusqu'au {area:367} : {npc:7953} y enseigne aux Trolls, avec les raptors de Zjolnir (20 po chacun). Puis retournez au zeppelin pour {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par {zone:1454} vers le niveau 45.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454}, volez jusqu'aux {zone:1456} et descendez jusqu'au {area:222} : {npc:3690} y enseigne aux Taurens, avec les kodos de {npc:3685} (20 po chacun). Puis revolez jusqu'à {zone:1454} pour le zeppelin de {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par les {zone:1456} vers le niveau 45.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "La monte exige le niveau 40 et coûte 100 po ; l'apprendre vous donne une monture, et {zone:2548} après Strangleronce sont une longue marche sans elle. Prenez le zeppelin depuis la tour de {object:3202} jusqu'à {zone:1454} : {npc:4752} enseigne aux Orcs dans la {object:172958}, près du chenil de {npc:3362} (loups à 20 po chacun). Puis reprenez le zeppelin vers {object:3202}. À court d'or ? Passez cette étape : le guide {zone:1444} repasse par {zone:1454} vers le niveau 45.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Another race's trainer (Kildar in {zone:1454}) teaches you only once you are Exalted with his city."] = "La monte demande le niveau 40 et coûte 100 pièces d'or ; l'apprendre vous donne une monture. Chaque race l'apprend auprès de son propre maître : le vôtre est {npc:7953}, à {area:367}, sur la côte de {zone:1411}, avec les raptors de Zjolnir (20 pièces d'or chacun) à côté de lui. Le maître d'une autre race (Kildar à {zone:1454}) ne vous l'enseigne qu'une fois Exalté auprès de sa ville.",
	-- ["Skullsplitter warriors"] = "Guerriers Skullsplitter",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres se trouvent dans leurs tentes et dans la barque à côté du plus grand camp. Tout pirate de la Voile sanglante peut porter le tabac et l'œil de {npc:2493} : continuez jusqu'à avoir les deux.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both.\nTake the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Au sud de Baie-du-Butin, les bretteurs de la Voile sanglante campent sur {area:43} ; les cartes et les ordres sont dans leurs tentes. Tout membre de la Voile sanglante peut porter du tabac à priser et l'œil de {npc:2493} : continuez à tuer jusqu'à avoir les deux.\nPrenez la route vers le sud en direction de {area:35}. Les Anciens gorilles de Valbrume (40-41) vivent dans {area:1737}, à l'est de la route ; environ un sur vingt porte un tendon vieilli.",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Prenez la route vers le nord hors de {area:35} ; Unbagwa est assis sur une colline de {area:1737}, à l'est de la route.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Les Traqueurs de la jungle (40-41) chassent sur la côte au sud de Grom'gol. Ils sont bien au-dessus de vous : attirez-les un par un et reposez-vous entre les combats.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Le bateau pour {area:35} accoste au bout du ponton de {area:392}.",
	-- ["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank.\nCareful: {npc:5592}'s camp sits by the coast. Along the way to it you pass level 40 spiders that chase a long distance, plus stealthed Shadow Panthers."] = "Les crocilisques se vautrent dans les mares autour du camp de {npc:5391} et au sud vers {area:75} ; environ un sur quatre lâche un flanc.\nAttention : le camp de {npc:5592} se trouve près de la côte. En chemin, vous passez près d'araignées de niveau 40 qui poursuivent loin, ainsi que de Panthères des ombres camouflées.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Les gorilles parcourent la vallée autour d'Unbagwa. Les anciens laissent tomber les abats ; tous peuvent laisser tomber un croc.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Les gorilles parcourent la vallée autour d'Unbagwa. Les anciens lâchent les abats ; tous peuvent lâcher un croc : gardez-en dix pour Unbagwa, dont le Mokk (44) attend votre passage à Strangleronce vers le niveau 45.\nAttention : les Anciens gorilles de Valbrume (40-41) sont proches les uns des autres dans la vallée : attirez-les un par un.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Les derniers crânes sont dans les ruines un peu à l'ouest, sur le chemin du retour vers {object:3202}.",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "Le prochain guide vous fait voler vers le nord jusqu'à {area:272} et dans les {zone:1417}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Le guide suivant commence ici et vous emmène en {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Les crânes trophées suivants se trouvent dans les petites ruines juste au nord du camp des guerriers.\nLes derniers crânes sont dans les ruines à quelques pas à l'ouest, sur le chemin du retour vers {object:3202}.",
	-- ["The snappers line the strand south of the post."] = "Les mordeurs bordent la grève au sud du poste.",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Les raptors traqueurs chassent dans la jungle au sud de {object:3202}, vers la côte ouest.",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Les trois pirates fantômes hantent la jungle au nord de {area:35}, près des camps de Zanzil : {npc:2535} et {npc:2536} se tiennent ensemble, {npc:2537} plus à l'est.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Les trois navires sont au large de {area:43}. Les équipages sont de niveau 42-45, Stillwater 45, Keelhaul 46 et {npc:2546} 48 : au niveau 41, c'est un combat pour un groupe, ou pour la fin du guide. Si vous y allez, nagez jusqu'aux navires et attirez l'équipage au bastingage un par un. Un parchemin, {quest:624}, se trouve sur le pont des navires : prenez-le.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:728} est un élite de niveau 40 : la plupart des classes le tuent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:730} est un élite de niveau 43 : la plupart des classes le tuent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. Le {npc:731} est un élite de niveau 43 : la plupart des classes le tuent seules au niveau 45, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : la route vous fait regagner cette expérience en tuant des monstres.\nAttention : des tigres et des panthères Ombregueule camouflées rôdent près de lui. Éliminez-les avant de l'attirer. Une fois attiré, le {npc:731} appelle à l'aide les créatures à moins de 20 m.",
	-- ["To {area:392}"] = "Vers {area:392}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "À l'ouest de l'expédition, les chefs Bloodscalp {npc:1061} et {npc:1062} se tiennent ensemble dans les Ruines de Zul'Kunda. Éliminez d'abord leurs gardes, puis attirez-les.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "À l'ouest de l'expédition, les chefs Bloodscalp {npc:1061} et {npc:1062} se tiennent ensemble dans les ruines de Zul'Kunda. Éliminez d'abord leurs gardes, puis attirez-les. Restez sur les Bloodscalp ici jusqu'au niveau 41 : {quest:586}, au chaudron juste après, vous envoie contre des Skullsplitter de niveau 41-43.\nSur la côte entre Zul'Kunda et {object:3202}, un {npc:2635} (élite de niveau 38) partage les points d'apparition des crocilisques ordinaires : tuez-le s'il est là et prenez sa peau pour {npc:2495}.",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Vous commencez à {area:75}. Faites de cette auberge votre foyer : vous y reviendrez avec la pierre de foyer après la côte.",
	-- ["Zanzil's camps"] = "Les camps de Zanzil",
	-- ["for Stoley in {zone:1446}"] = "pour Stoley en {zone:1446}",
	-- ["for Stoley in {zone:1446}; on the top floor"] = "pour Stoley en {zone:1446} ; au dernier étage",
	-- ["for a later stop in the {area:8}"] = "pour un arrêt plus tard dans {area:8}",
	-- ["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "tuez en boucle les Bloodscalp ici : {quest:586}, au chaudron juste après, vous envoie contre des Skullsplitter de niveau 41-43",
	-- ["grind on {npc:667}"] = "tuez en boucle : {npc:667}",
	-- ["the {object:2076}"] = "le {object:2076}",
	-- ["the {object:2076} again: Yenniku's fate"] = "le {object:2076} à nouveau : le sort de Yenniku",
	-- ["the {object:2076}, beside Nimboya"] = "le {object:2076}, à côté de Nimboya",
	-- ["the {object:2076}, beside {npc:2497}"] = "le {object:2076}, à côté de {npc:2497}",
	-- ["{area:127}: kill these as you meet them"] = "{area:127} : tuez-les au passage",
	-- ["{area:1497} trainers"] = "Maîtres de {area:1497}",
	-- ["{area:1577}: kill these as you meet them"] = "{area:1577} : tuez-les au passage",
	-- ["{area:1737}: kill these as you meet them"] = "{area:1737} : tuez-les au passage",
	-- ["{area:35} flight master"] = "Maître de vol de {area:35}",
	-- ["{area:392} pier"] = "Ponton de {area:392}",
	-- ["{area:75} flight master"] = "Maître de vol de {area:75}",
	-- ["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486} : {quest:348} (proposée dès le niveau 40), la partie d'Unbagwa se fait lors de l'étape à {object:3202} du guide de {zone:1444}",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, au dernier étage",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, sur le balcon à côté de MacKinley, a une dernière mission : les plans du régulateur de carburant, tirés du coffre de Cozzle, vont à Pozzik à la {area:2240}, sur le chemin de {zone:1446} vers le niveau 43.",
	-- ["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497} : pour {zone:1425}, vers le niveau 48",
	-- ["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	-- ["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519} : les basilics paissent à côté de la route du retour depuis {area:35}",
	-- ["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519} : les crânes trophées se trouvent dans les ruines Fendeurs de crânes, plus loin sur cette boucle",
	-- ["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} se promène par ici : cherchez dans le cercle sur la carte",
	-- ["{npc:6807}, upstairs"] = "{npc:6807}, à l'étage",
	-- ["{npc:6930}, upstairs"] = "{npc:6930}, à l'étage",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, à l'étage : pour {quest:2864} à {area:976}",
	-- ["{npc:773}: for {quest:2864} in {area:976}; upstairs"] = "{npc:773} : pour {quest:2864} à {area:976} ; à l'étage",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, maître de monte",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} et le {zone:1435} aux niveaux 40-43 : {object:3202}, les pirates de {area:35}, les chasses de Nesingwary et {area:75}.",
}
