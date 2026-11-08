-- French (frFR): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["{object:176946} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {zone:1454} Orgrimmar
	["Fly from {object:176946} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to {zone:1454} from there."] = "",

	-- Step 3: Back to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Back to {zone:1454}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maître de vol des {zone:1456}",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 6: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zeppelin pour {object:3202}",

	-- Step 7: Grom'gol
	["The zeppelin lands at the tower on the west side of the camp."] = "Le zeppelin arrive à la tour à l'ouest du campement.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497} : pour les Hautes-terres Arathies, plus loin sur l'itinéraire",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "Camp de Nesingwary",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Suivez la route vers le nord depuis {object:3202} ; le camp de chasse de Nesingwary se trouve sur la colline au nord-est de la rivière. Dès maintenant, gardez chaque page de {quest:338} ramassée : {npc:716} les demandera plus tard.",

	-- Step 9: Nesingwary's Expedition: kill these as you meet them
	["Nesingwary's Expedition: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Les Jeunes tigres de Strangleronce rôdent à l'ouest du camp, les Jeunes panthères au sud et à l'est.\nAllez vers l'ouest après le camp. Les Raptors de Strangleronce (33-34) chassent dans les clairières, et les trolls Bloodscalp tiennent les ruines sur la côte : chaque Bloodscalp peut lâcher une défense. Le {item:4614} est un butin très rare sur eux : si vous en obtenez un, lisez-le.\nAttention : les camps trolls ont de nombreuses patrouilles, d'autres trolls rejoignent donc souvent le combat.",

	-- Step 10: Booty Bay
	-- {object:3204} Booty Bay (no name in this language: may be words) · {npc:2858} Gringer
	["Follow the road south to {object:3204} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, à l'intérieur",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, à l'étage",
	["Upstairs"] = "À l'étage",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Prendre un vol pour {object:3202}",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["{object:3204} flight master"] = "",

	-- Step 12: Grom'gol
	-- {npc:2497} Nimboya · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "",

	-- Step 14: The camp by the river
	["The camp by the river"] = "Le camp près de la rivière",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Le camp des chasseurs disparus de {npc:773} est celui de Nesingwary : marchez parmi ses tentes et l'enquête est terminée. Des Crocilisques des rivières se trouvent le long de la rivière sous le camp.",

	-- Step 16: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434} : tuez-les au passage",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by Lake Nazferiti, south-east of the camp."] = "",

	-- Step 17: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Les Panthères Ombregueule viendront bien plus tard, près de {object:3202}",

	-- Step 18: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Anciens tigres et raptors flagellants",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Les Anciens tigres de Strangleronce (34-35) parcourent les collines au sud-ouest du camp ; les Raptors flagellants (35-36) chassent plus au sud, vers Grom'gol.\nAttention : des camps trolls sont proches du territoire des tigres, et des trolls peuvent rejoindre le combat si vous attirez sans prudence.",

	-- Step 19: Nesingwary's camp
	["Back north to the camp."] = "Retournez au camp, au nord.",

	-- Step 20: The Savage Coast: kill these as you meet them
	["The Savage Coast: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "À l'ouest après le camp, des Basilics de cristal (34-35) se tiennent sur les rochers ; chaque Bloodscalp du village plus loin peut lâcher une oreille.\n{npc:729}, un tigre de niveau 37, rôde au sommet de la colline au sud-ouest du camp.\nAttention : le nid de raptors abrite de jeunes raptors qui rejoignent le combat quand vous attaquez les adultes.",

	-- Step 22: Level 35
	["Level 35"] = "",
	-- {object:3204} Booty Bay (no name in this language: may be words) · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{object:3204}'s and {object:3202}'s next quests are 35-38. Below 35? The Lashtail Raptors (35) hunt the slopes south of the camp, on your way back to {object:3202}: kill them until level 35. Or, with a group, run the Scarlet Monastery dungeon (Library or Armory) instead."] = "",
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "",

	-- Step 23: Fly to Booty Bay
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Fly to {object:3204}"] = "",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {object:3204} Booty Bay (no name in this language: may be words)
	["Head south down the coast to {object:3202} and fly to {object:3204}."] = "",

	-- Step 24: Fly to Grom'gol
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}, beside the flight master: the Shadowmaw and tigress parts come after the trolls"] = "",

	-- Step 25: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Les Raptors flagellants (35-36) chassent dans la jungle juste au nord-est de {object:3202}.",

	-- Step 26: The Vile Reef
	-- {item:4094} Tablet Shard
	["North-west of Grom'gol the Vile Reef lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "",
	["Underwater"] = "Sous l'eau",

	-- Step 27: Ruins of Zul'Kunda: kill these as you meet them
	["Ruins of Zul'Kunda: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Les Chasseurs de tête Bloodscalp (36-37) du village sur la côte portent les têtes réduites.\nLes trolls Bloodscalp tiennent les ruines plus haut sur la côte, au nord du récif, et le village au-delà ; chacun peut lâcher un {item:3915}. Continuez à ramasser des pages de {quest:338}.",

	-- Step 29: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "À l'est des ogres, les Panthères Ombregueule (37-38) rôdent invisibles jusqu'à ce qu'elles frappent ; les Tigresses de Strangleronce parcourent le même terrain et lâchent de temps en temps un croc intact. Les Crocilisques Gueule d'acier bordent la rivière juste à l'ouest de la jungle ; gardez leurs peaux pour {npc:2495}.\nAttention : les Panthères Ombregueule (niveau 37-38) et les Anciennes panthères Ombregueule (niveau 42-43) se camouflent hors combat, elles restent donc cachées jusqu'à ce que vous vous approchiez.",

	-- Step 30: Green Hills pages
	["Green Hills pages"] = "Pages des Vertes collines",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Les pages de {item:2755} tombent à environ 1 % chacune sur les trolls Bloodscalp et Skullsplitter ; gardez chaque page ramassée et cherchez le reste à l'hôtel des ventes. {npc:716} prend les chapitres plus loin dans ce guide.",

	-- Step 31: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panthères Ombregueule",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Les Panthères Ombregueule (37-38) rôdent dans la jungle à l'est des collines Mosh'Ogg et au nord-est vers le lac ; elles attaquent en camouflage. Ramassez chaque page des Vertes collines trouvée en chemin.",

	-- Step 32: Venture Co. camp
	["Venture Co. camp"] = "Camp de la KapitalRisk",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north to Lake Nazferiti, south-east of Nesingwary's camp: the Venture Co. Geologists (34-36) work the camps by the lake and carry the Tumbled Crystals."] = "",

	-- Step 33: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Camp Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Les ogres Mosh'Ogg campent dans les collines juste à l'est de Grom'gol. Tuez une Brute et un Sorcier-docteur (36-37) ; attirez-les un par un.",

	-- Step 34: Level 36
	["Level 36"] = "Niveau 36",
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Below 36? Keep killing the Mosh'Ogg Brutes and Witch Doctors here until level 36; pull one at a time. Or, with a group, run the Scarlet Monastery dungeon (Armory) or the Razorfen Downs dungeon instead."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "tuez en boucle : {npc:1142}",

	-- Step 35: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "Retour à {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "",
}
