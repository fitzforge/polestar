-- Spanish (Spain) (esES): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["{object:176946} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {zone:1454} Orgrimmar
	["Fly from {object:176946} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to {zone:1454} from there."] = "",

	-- Step 3: Back to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Back to {zone:1454}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 6: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",

	-- Step 7: Grom'gol
	["The zeppelin lands at the tower on the west side of the camp."] = "El zepelín aterriza en la torre del lado oeste del campamento.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para las Tierras Altas de Arathi, más adelante en la ruta",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "Campamento de Hemet Decautela",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Sigue el camino hacia el norte desde {object:3202}; el campamento de caza de Hemet Decautela está en la colina al noreste del río. A partir de aquí, guarda cada página de {quest:338} que consigas: {npc:716} te las pedirá más adelante.",

	-- Step 9: Nesingwary's Expedition: kill these as you meet them
	["Nesingwary's Expedition: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 10: Booty Bay
	-- {object:3204} Booty Bay (no name in this language: may be words) · {npc:2858} Gringer
	["Follow the road south to {object:3204} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	["Upstairs"] = "",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["{object:3204} flight master"] = "",

	-- Step 12: Grom'gol
	-- {npc:2497} Nimboya · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "",

	-- Step 14: The camp by the river
	["The camp by the river"] = "El campamento junto al río",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "El campamento de los cazadores desaparecidos de {npc:773} es el de Hemet Decautela: camina entre sus tiendas y la investigación se completa. Los crocoliscos fluviales están a lo largo del río, bajo el campamento.",

	-- Step 16: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by Lake Nazferiti, south-east of the camp."] = "",

	-- Step 17: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Las Panteras Faucesombría llegan mucho más tarde, junto a {object:3202}",

	-- Step 18: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Tigres mayores y raptores colazote",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 19: Nesingwary's camp
	["Back north to the camp."] = "Vuelve al norte, al campamento.",

	-- Step 20: The Savage Coast: kill these as you meet them
	["The Savage Coast: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

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
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Los raptores colazote (35-36) cazan en la selva justo al noreste de {object:3202}.",

	-- Step 26: The Vile Reef
	-- {item:4094} Tablet Shard
	["North-west of Grom'gol the Vile Reef lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "",
	["Underwater"] = "",

	-- Step 27: Ruins of Zul'Kunda: kill these as you meet them
	["Ruins of Zul'Kunda: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "",

	-- Step 29: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 30: Green Hills pages
	["Green Hills pages"] = "Páginas de Las verdes colinas",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Las páginas de {item:2755} caen con un 1% aprox. cada una de los trols Cabellesangre y Machacacráneos; guarda cada página que consigas y busca el resto en la casa de subastas. {npc:716} recoge los capítulos más adelante en esta guía.",

	-- Step 31: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panteras Faucesombría",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Las panteras Faucesombría (37-38) acechan en la selva al este de las colinas Mosh'Ogg y al noreste, hacia el lago; atacan desde el sigilo. Recoge cada página de Las verdes colinas de Tuercespina que encuentres por el camino.",

	-- Step 32: Venture Co. camp
	["Venture Co. camp"] = "Campamento de Ventura y Cía.",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north to Lake Nazferiti, south-east of Nesingwary's camp: the Venture Co. Geologists (34-36) work the camps by the lake and carry the Tumbled Crystals."] = "",

	-- Step 33: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Campamento Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Los ogros Mosh'Ogg acampan en las colinas justo al este de {object:3202}. Mata a un tosco Mosh'Ogg y a un médico brujo Mosh'Ogg (36-37); atráelos de uno en uno.",

	-- Step 34: Level 36
	["Level 36"] = "",
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Below 36? Keep killing the Mosh'Ogg Brutes and Witch Doctors here until level 36; pull one at a time. Or, with a group, run the Scarlet Monastery dungeon (Armory) or the Razorfen Downs dungeon instead."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- Step 35: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De vuelta a {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "",
}
