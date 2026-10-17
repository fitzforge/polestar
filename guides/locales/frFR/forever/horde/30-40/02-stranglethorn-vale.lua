-- French (frFR): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",
	-- {zone:1458} Undercity · {object:3202} Grom'gol (no name in this language: may be words)
	["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Quittez {zone:1458} par l'ascenseur et montez à travers les ruines jusqu'aux tours des zeppelins ; le zeppelin pour {object:3202} est celui de la tour sud-ouest.",
	["Zeppelin towers"] = "Tours des zeppelins",

	-- Step 2: Grom'gol Base Camp
	["The zeppelin lands at the tower on the west side of the camp."] = "Le zeppelin arrive à la tour à l'ouest du campement.",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Prenez le zeppelin pour {zone:1454} à la tour à l'ouest de {object:3202} et entraînez-vous en ville avant de repartir.",

	-- Step 4: Islen Waterseer
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Prenez le zeppelin pour {zone:1454} à la tour à l'ouest de {object:3202}, puis prenez un vol pour {area:392}. {npc:5901} campe sur la côte, un peu au sud.",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901} : {npc:3527} et votre {item:5177}",

	-- Step 5: Back to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}"] = "Retour à {object:3202}",

	-- Step 6: Nesingwary's camp
	["Nesingwary's camp"] = "Camp de Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Suivez la route vers le nord depuis {object:3202} ; le camp de chasse de Nesingwary se trouve sur la colline au nord-est de la rivière. Dès maintenant, gardez chaque page de {quest:338} ramassée : {npc:716} les demandera plus tard.",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "Jeunes tigres et panthères",
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Les Jeunes tigres de Strangleronce rôdent à l'ouest du camp, les Jeunes panthères au sud et à l'est.",

	-- Step 9: Tigers and panthers
	["Tigers and panthers"] = "Tigres et panthères",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Les Tigres de Strangleronce et les Panthères (32-33) parcourent les collines à l'est du camp, le long du lac.",

	-- Step 10: Raptors and the Bloodscalp trolls
	["Raptors and the Bloodscalp trolls"] = "Raptors et trolls Bloodscalp",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Allez vers l'ouest après le camp. Les Raptors de Strangleronce (33-34) chassent dans les clairières, et les trolls Bloodscalp tiennent les ruines de la côte : chaque Bloodscalp peut lâcher une défense. Ils lâchent très rarement un {item:4614} : si vous en obtenez un, lisez-le.",

	-- Step 11: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Les Panthères Ombregueule viendront bien plus tard, près de {object:3202}",

	-- Step 12: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Anciens tigres et raptors flagellants",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Les Anciens tigres de Strangleronce (34-35) parcourent les collines au sud-ouest du camp ; les Raptors flagellants (35-36) chassent plus au sud, vers {object:3202}.",

	-- Step 13: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the road south to {object:3202}."] = "Suivez la route vers le sud jusqu'à {object:3202}.",

	-- Step 14: Nesingwary's camp
	["Back north to the camp."] = "Retournez au camp, au nord.",

	-- Step 15: Sin'Dall
	-- {npc:729} Sin'Dall
	["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, un tigre de niveau 37, rôde au sommet de la colline au sud-ouest du camp.",

	-- Step 17: Bloodscalp headhunters
	["Bloodscalp headhunters"] = "Chasseurs de tête Bloodscalp",
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Les Chasseurs de tête Bloodscalp (36-37) du village de la côte portent les têtes réduites.",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Hearth to {object:3202}"] = "Pierre de foyer vers {object:3202}",

	-- Step 19: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Suivez la route vers le sud jusqu'à {area:35}, à la pointe sud de la vallée, et entrez par le tunnel dans les falaises. Restez sur la route : la jungle alentour est bien au-dessus de votre niveau. {npc:2858}, le maître de vol de la Horde, attend sur le ponton supérieur.",

	-- Step 20: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",

	-- Step 21: The camp by the river
	["The camp by the river"] = "Le camp près de la rivière",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Le camp des chasseurs disparus de {npc:773} est celui de Nesingwary : marchez parmi ses tentes et l'enquête est terminée. Des Crocilisques des rivières se trouvent le long de la rivière sous le camp.",

	-- Step 22: Basilisks and the Bloodscalp village
	["Basilisks and the Bloodscalp village"] = "Basilics et village Bloodscalp",
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "À l'ouest après le camp, des Basilics de cristal (34-35) se tiennent sur les rochers ; chaque Bloodscalp du village plus loin peut lâcher une oreille.",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Descendez la côte vers le sud jusqu'à {object:3202} et prenez un vol pour {area:35}.",

	-- Step 24: Fly to Grom'gol
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497} : pour les Hautes-terres Arathies, plus loin sur l'itinéraire",

	-- Step 25: Lashtail raptors
	["Lashtail raptors"] = "Raptors flagellants",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Les Raptors flagellants (35-36) chassent dans la jungle juste au nord-est de {object:3202}.",

	-- Step 27: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Camp Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Les ogres Mosh'Ogg campent dans les collines juste à l'est de {object:3202}. Tuez une Brute Mosh'Ogg et un Sorcier-docteur Mosh'Ogg (36-37) ; attirez-les un par un.",

	-- Step 28: Shadowmaw jungle and the Snapjaw river
	["Shadowmaw jungle and the Snapjaw river"] = "Jungle des Ombregueule et rivière des Gueule d'acier",
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "À l'est des ogres, les Panthères Ombregueule (37-38) rôdent invisibles jusqu'à leur attaque ; les Tigresses de Strangleronce parcourent le même terrain et lâchent parfois un Croc de tigresse en parfait état. Les Crocilisques Gueule d'acier bordent la rivière juste à l'ouest de la jungle ; gardez leurs peaux pour {npc:2495}.",

	-- Step 29: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "Retour à {object:3202}.",

	-- Step 30: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Au nord-ouest de Grom'gol, {area:104} s'étend sous l'eau au large de la côte. L'{item:4094} repose au fond de la mer près des ruines englouties ; surveillez votre souffle et les murlocs.",

	-- Step 31: Bloodscalp ruins
	["Bloodscalp ruins"] = "Ruines Bloodscalp",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Les trolls Bloodscalp tiennent les ruines de la côte au nord du récif et le village plus loin ; chacun peut lâcher un {item:3915}. Continuez à ramasser les pages de {quest:338}.",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back south to {object:3202}."] = "Retournez au sud jusqu'à {object:3202}.",

	-- Step 33: Green Hills pages
	["Green Hills pages"] = "Pages des Vertes collines",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Les pages de {item:2755} tombent à environ 1 % chacune sur les trolls Bloodscalp et Skullsplitter ; gardez chaque page ramassée et cherchez le reste à l'hôtel des ventes. {npc:716} prend les chapitres plus loin dans ce guide.",

	-- Step 34: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panthères Ombregueule",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Les Panthères Ombregueule (37-38) rôdent dans la jungle à l'est des collines Mosh'Ogg et au nord-est vers le lac ; elles attaquent en camouflage. Ramassez chaque page des Vertes collines trouvée en chemin.",

	-- Step 35: Green Hills pages
	-- {item:2755} Green Hills of Stranglethorn
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "Les pages de {item:2755} tombent à environ 1 % chacune sur les trolls Bloodscalp et Skullsplitter ; prenez ce qui tombe et cherchez le reste à l'hôtel des ventes.",

	-- Step 38: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Traqueurs de la jungle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Les Traqueurs de la jungle (40-41) chassent sur la côte au sud de {object:3202}. Ils sont bien au-dessus de votre niveau : attirez-les un par un et reposez-vous entre les combats.",

	-- Step 40: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilles de Valbrume",
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Prenez la route vers le sud en direction de {area:35}. Les Anciens gorilles de Valbrume (40-41) vivent à {area:1737}, à l'est de la route ; environ un sur vingt porte un Tendon d'ancien gorille.",

	-- Step 41: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road on south into {area:35}."] = "Continuez la route vers le sud jusqu'à {area:35}.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495} : les peaux de Gueule d'acier récupérées plus tôt",

	-- Step 43: Venture Co. camp
	["Venture Co. camp"] = "Camp de la KapitalRisk",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Allez vers le nord après le camp de Nesingwary jusqu'au lac. Les Géologues de la KapitalRisk (34-36) travaillent dans les camps de sa rive ouest ; ils portent les Cristaux réduits.",

	-- Step 44: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "Le guide suivant vous emmène en vol au nord jusqu'à {area:272} et dans {zone:1417}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the camp."] = "Suivez la route vers le nord jusqu'au camp.",
}
