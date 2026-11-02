-- French (frFR): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 2: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",

	-- Step 3: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	["The zeppelin lands at the tower on the west side of the camp."] = "Le zeppelin arrive à la tour à l'ouest du campement.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497} : pour les Hautes-terres Arathies, plus loin sur l'itinéraire",

	-- Step 4: Bloody Bone Necklace on the way
	-- {item:3915} Bloody Bone Necklace
	["{item:3915} on the way"] = "",

	-- Step 5: Islen Waterseer
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {area:1637} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short walk south of it."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901} : {npc:3527} et votre {item:5177}",

	-- Step 6: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "Camp de Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Suivez la route vers le nord depuis {object:3202} ; le camp de chasse de Nesingwary se trouve sur la colline au nord-est de la rivière. Dès maintenant, gardez chaque page de {quest:338} ramassée : {npc:716} les demandera plus tard.",

	-- Step 9: Young Panther on the way
	-- {npc:683} Young Panther
	["{npc:683} on the way"] = "",

	-- Step 10: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 11: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Suivez la route vers le sud jusqu'à {area:35}, à la pointe sud de la vallée, et entrez par le tunnel dans les falaises. Restez sur la route : la jungle alentour est bien au-dessus de votre niveau. {npc:2858}, le maître de vol de la Horde, attend sur le ponton supérieur.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	["Upstairs"] = "",

	-- Step 12: Bloodscalp Ear on the way
	-- {item:1519} Bloodscalp Ear
	["{item:1519} on the way"] = "",

	-- Step 13: Tumbled Crystal on the way
	-- {item:4106} Tumbled Crystal
	["{item:4106} on the way"] = "",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 15: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the road south to {object:3202}."] = "Suivez la route vers le sud jusqu'à {object:3202}.",

	-- Step 17: The camp by the river
	["The camp by the river"] = "Le camp près de la rivière",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Le camp des chasseurs disparus de {npc:773} est celui de Nesingwary : marchez parmi ses tentes et l'enquête est terminée. Des Crocilisques des rivières se trouvent le long de la rivière sous le camp.",

	-- Step 19: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Les Tigres de Strangleronce et les Panthères (32-33) parcourent les collines à l'est du camp, le long du lac.",

	-- Step 20: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Les Panthères Ombregueule viendront bien plus tard, près de {object:3202}",

	-- Step 21: Shadowmaw Panther on the way
	-- {npc:684} Shadowmaw Panther
	["{npc:684} on the way"] = "",

	-- Step 22: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Anciens tigres et raptors flagellants",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 23: Nesingwary's camp
	["Back north to the camp."] = "Retournez au camp, au nord.",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 26: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",

	-- Step 27: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Head south down the coast to {object:3202} and fly to {area:35}."] = "",

	-- Step 29: Lashtail Raptor on the way
	-- {npc:686} Lashtail Raptor
	["{npc:686} on the way"] = "",
	-- {npc:686} Lashtail Raptor · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:686} along the way to {object:3202}"] = "",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Les Raptors flagellants (35-36) chassent dans la jungle juste au nord-est de {object:3202}.",

	-- Step 31: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "Au nord-ouest de Grom'gol, {area:104} s'étend sous l'eau au large de la côte. L'{item:4094} repose au fond de la mer près des ruines englouties ; surveillez votre souffle et les murlocs.",
	["Underwater"] = "",

	-- Step 32: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "",

	-- Step 33: Grom'gol
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "",

	-- Step 34: Mosh'Ogg Brute on the way
	-- {npc:1142} Mosh'Ogg Brute
	["{npc:1142} on the way"] = "",

	-- Step 35: Mosh'Ogg Witch Doctor on the way
	-- {npc:1144} Mosh'Ogg Witch Doctor
	["{npc:1144} on the way"] = "",

	-- Step 36: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 37: Green Hills pages
	["Green Hills pages"] = "Pages des Vertes collines",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Les pages de {item:2755} tombent à environ 1 % chacune sur les trolls Bloodscalp et Skullsplitter ; gardez chaque page ramassée et cherchez le reste à l'hôtel des ventes. {npc:716} prend les chapitres plus loin dans ce guide.",

	-- Step 38: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panthères Ombregueule",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Les Panthères Ombregueule (37-38) rôdent dans la jungle à l'est des collines Mosh'Ogg et au nord-est vers le lac ; elles attaquent en camouflage. Ramassez chaque page des Vertes collines trouvée en chemin.",
	-- {npc:684} Shadowmaw Panther
	["grind on {npc:684}"] = "",

	-- Step 39: Venture Co. camp
	["Venture Co. camp"] = "Camp de la KapitalRisk",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "",

	-- Step 40: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "",

	-- Step 41: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "Retour à {object:3202}.",

	-- Step 42: Level 36
	["Level 36"] = "",
	-- {area:321} Hammerfall
	["Top up here to level 36 before the hand-ins at {area:321}: they take you to level 37."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {object:3202}"] = "Retour à {object:3202}",
	-- ["Basilisks and the Bloodscalp village"] = "Basilics et village Bloodscalp",
	-- ["Bloodscalp headhunters"] = "Chasseurs de tête Bloodscalp",
	-- ["Bloodscalp ruins"] = "Ruines Bloodscalp",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "À l'est des ogres, les Panthères Ombregueule (37-38) rôdent invisibles jusqu'à leur attaque ; les Tigresses de Strangleronce parcourent le même terrain et lâchent parfois un Croc de tigresse en parfait état. Les Crocilisques Gueule d'acier bordent la rivière juste à l'ouest de la jungle ; gardez leurs peaux pour {npc:2495}.",
	-- ["Follow the road north to the camp."] = "Suivez la route vers le nord jusqu'au camp.",
	-- ["Follow the road on south into {area:35}."] = "Continuez la route vers le sud jusqu'à {area:35}.",
	-- ["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Allez vers l'ouest après le camp. Les Raptors de Strangleronce (33-34) chassent dans les clairières, et les trolls Bloodscalp tiennent les ruines de la côte : chaque Bloodscalp peut lâcher une défense. Ils lâchent très rarement un {item:4614} : si vous en obtenez un, lisez-le.",
	-- ["Hearth to {object:3202}"] = "Pierre de foyer vers {object:3202}",
	-- ["Jungle Stalkers"] = "Traqueurs de la jungle",
	-- ["Lashtail raptors"] = "Raptors flagellants",
	-- ["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Quittez {zone:1458} par l'ascenseur et montez à travers les ruines jusqu'aux tours des zeppelins ; le zeppelin pour {object:3202} est celui de la tour sud-ouest.",
	-- ["Mistvale gorillas"] = "Gorilles de Valbrume",
	-- ["Mosh'Ogg camp"] = "Camp Mosh'Ogg",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "Les pages de {item:2755} tombent à environ 1 % chacune sur les trolls Bloodscalp et Skullsplitter ; prenez ce qui tombe et cherchez le reste à l'hôtel des ventes.",
	-- ["Raptors and the Bloodscalp trolls"] = "Raptors et trolls Bloodscalp",
	-- ["Ride back south to {object:3202}."] = "Retournez au sud jusqu'à {object:3202}.",
	-- ["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Allez vers le nord après le camp de Nesingwary jusqu'au lac. Les Géologues de la KapitalRisk (34-36) travaillent dans les camps de sa rive ouest ; ils portent les Cristaux réduits.",
	-- ["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Descendez la côte vers le sud jusqu'à {object:3202} et prenez un vol pour {area:35}.",
	-- ["Shadowmaw jungle and the Snapjaw river"] = "Jungle des Ombregueule et rivière des Gueule d'acier",
	-- ["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Prenez la route vers le sud en direction de {area:35}. Les Anciens gorilles de Valbrume (40-41) vivent à {area:1737}, à l'est de la route ; environ un sur vingt porte un Tendon d'ancien gorille.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Prenez le zeppelin pour {zone:1454} à la tour à l'ouest de {object:3202}, puis prenez un vol pour {area:392}. {npc:5901} campe sur la côte, un peu au sud.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Prenez le zeppelin pour {zone:1454} à la tour à l'ouest de {object:3202} et entraînez-vous en ville avant de repartir.",
	-- ["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Les Chasseurs de tête Bloodscalp (36-37) du village de la côte portent les têtes réduites.",
	-- ["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Les trolls Bloodscalp tiennent les ruines de la côte au nord du récif et le village plus loin ; chacun peut lâcher un {item:3915}. Continuez à ramasser les pages de {quest:338}.",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Les Anciens tigres de Strangleronce (34-35) parcourent les collines au sud-ouest du camp ; les Raptors flagellants (35-36) chassent plus au sud, vers {object:3202}.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Les Traqueurs de la jungle (40-41) chassent sur la côte au sud de {object:3202}. Ils sont bien au-dessus de votre niveau : attirez-les un par un et reposez-vous entre les combats.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Les ogres Mosh'Ogg campent dans les collines juste à l'est de {object:3202}. Tuez une Brute Mosh'Ogg et un Sorcier-docteur Mosh'Ogg (36-37) ; attirez-les un par un.",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "Le guide suivant vous emmène en vol au nord jusqu'à {area:272} et dans {zone:1417}.",
	-- ["Tigers and panthers"] = "Tigres et panthères",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "À l'ouest après le camp, des Basilics de cristal (34-35) se tiennent sur les rochers ; chaque Bloodscalp du village plus loin peut lâcher une oreille.",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Les Jeunes tigres de Strangleronce rôdent à l'ouest du camp, les Jeunes panthères au sud et à l'est.",
	-- ["Young tigers and panthers"] = "Jeunes tigres et panthères",
	-- ["Zeppelin towers"] = "Tours des zeppelins",
	-- ["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495} : les peaux de Gueule d'acier récupérées plus tôt",
	-- ["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, un tigre de niveau 37, rôde au sommet de la colline au sud-ouest du camp.",
}
