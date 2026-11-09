-- Spanish (Spain) (esES): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: tres bichos que atrapar en Tierras Altas de Arathi, {zone:1443} y Vega de Tuercespina",

	-- Step 4: The western swamp
	["The western swamp"] = "El oeste de la ciénaga",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Crocoliscos jóvenes, Girapenas y Jaguares del pantano recorren la ciénaga alrededor del camino.",

	-- Step 6: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Sigue el camino al norte hasta los draenei de {area:657}.",

	-- Step 7: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Al este por el camino hasta {area:76}. Los {npc:256028} sueltan los cristales; Noboru recorre las ruinas y suelta su garrote.",

	-- Step 8: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} está enjaulado en el extremo norte del santuario. Libéralo y mantenlo con vida mientras salís; después, su cofre te espera junto al camino.",

	-- Step 10: The Harborage
	-- {npc:5391} Galen Goodward · {area:657} The Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "",

	-- Step 11: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "",

	-- Step 13: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Vuelve al oeste por {zone:1430} hasta {area:42}.",

	-- Step 14: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, camino de {area:17203}",

	-- Step 15: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} espera en el sótano de {object:2164}, en {object:2101}. Usa el {item:6913} en el círculo de invocación de allí y derrota a la súcubo que aparece. Si aceptaste {quest:65602}, entrégale también la {item:190309}, colócala en el mismo círculo y derrota al íncubo.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, si la aceptaste",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, en el mismo círculo",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} vincula el íncubo a ti",

	-- Step 16: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, en la catedral",

	-- Step 18: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, la biblioteca real del castillo",

	-- Step 19: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 22: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Un {npc:2434} acecha sin ser visto en las afueras de {area:271}; mátalo y lee el contrato que lleva.",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 25: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Sigue el camino al este desde {area:287}, por {area:1057}, hasta {area:320}.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "",

	-- Step 26: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "",

	-- Step 27: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "",

	-- Step 28: Witherbark Village
	-- {area:314} Go'Shek Farm
	["A few Witherbark trolls camp south of Northfold, on the way; the main village lies in the hills south of {area:314} in the south-east, where the Witch Doctors stand and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "",

	-- Step 29: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Ve al norte pasando {area:314}; los fragmentos brillan en la colina junto a {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Solo si Gluggle te dio el colgante en Vega de Tuercespina",

	-- Step 30: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "",
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "",

	-- Step 31: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Los fragmentos están en el extremo de {area:318}.",
	["Below ground"] = "",

	-- Step 32: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 33: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "",

	-- Step 34: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "El mensajero recorre el camino al oeste de {area:314} con dos guardias; atráelos fuera del camino.",

	-- Step 36: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} y {npc:2713}",

	-- Step 37: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "El encargo de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "",

	-- Step 38: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Para {npc:2711} en {area:271}",

	-- Step 39: Refuge Pointe
	-- {area:320} Refuge Pointe · {object:2689} Stone of West Binding
	["West along the road to {area:320}, on the way to the {object:2689}."] = "",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {area:327} Faldir's Cove
	["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "",

	-- Step 41: Faldir's Cove
	["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "",

	-- Step 42: Phizzlethorpe
	["Phizzlethorpe"] = "Fiseltor",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 44: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Los dos naufragios están en la bahía al oeste de la cala. Las cartas de navegación y los diarios están dentro; las gemas están en el fondo del mar a su alrededor. Los nagas Espinadaga nadan por toda la bahía.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "",

	-- Step 45: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Para {npc:2487} en {area:35}: guárdalo",

	-- Step 46: Kor'gresh Coldrage
	-- {area:327} Faldir's Cove · {npc:2793} Kor'gresh Coldrage
	["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "",

	-- Step 47: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "",

	-- Step 49: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "",

	-- Step 50: Brewmeister Bilger
	-- {area:271} Southshore
	["Off the flight, straight to the {area:271} inn."] = "",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "",

	-- Step 52: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Sigue el camino al norte desde {area:271} hacia las montañas. Los leones monteses recorren las laderas; los miembros del Sindicato de {area:280} llevan los anillos de sello, y {npc:2306} recorre los terrenos de la mansión en el lado norte del pueblo.",

	-- Step 53: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: ogros Aplastacresta",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}; inside"] = "",

	-- Step 54: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 55: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "",
	-- {npc:2320} Nagaz
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "",

	-- Step 56: Crushridge ogres
	["Crushridge ogres"] = "Ogros Aplastacresta",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "",
	["Inside"] = "",

	-- Step 58: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Al suroeste hasta el campamento del Kirin Tor en la orilla del lago al oeste de {area:279}, justo al otro lado de la frontera de {zone:1421}: allí está {npc:269127}. El archimago Ansirem está al sureste, junto a la cúpula.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Para {npc:2542} en {area:35}: guárdalo",

	-- Step 60: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Para {npc:1440} en {zone:1453}: guárdalo",
	-- {npc:2277} Loremaster Dibbs
	["{npc:2277}: the parchment"] = "",

	-- Step 61: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "",

	-- Step 64: Ironforge
	-- {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "",

	-- Step 65: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "",

	-- Step 66: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Desde {zone:1455}, toma el túnel al este por {zone:1426} hasta {zone:1432} y sigue el camino hasta {area:144}.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 67: Prospector Ironband
	["South-east along the loch to the dig site."] = "Al sureste por el lago hasta la excavación.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Cada llave está en uno de los círculos de piedras de las Tierras Altas: al este de los fragmentos, cerca de {area:320} y en el oeste. La {object:2702} está al oeste de {area:320}.",
	-- ["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escolta al profesor hasta la playa al norte de la cala y protégelo mientras trabaja; los nagas atacan en oleadas.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Sigue el camino al sur por el puente hasta {area:205}, en el extremo de {zone:1437}, donde espera {npc:1075}.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Desde {area:42}, sigue el camino al este por {zone:1430} hasta {zone:1435}; Biggs vigila el cruce de caminos nada más entrar. {npc:217412} está un poco al norte de él.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "Desde {zone:1455}, toma el túnel al este por {zone:1426} hasta {area:38} y sigue el camino hasta {area:144}.",
	-- ["Gyll, {area:35}"] = "Gyll, {area:35}",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Cabalga de vuelta al noreste pasando {area:320}; {npc:2712} y {npc:2713} acampan en las colinas al norte de {area:314}.",
	-- ["Shaman training"] = "Entrenamiento de chamán",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Al suroeste hasta el campamento del Kirin Tor en la orilla del lago al oeste de {area:279}, justo al otro lado de la frontera de {area:130}: allí está {npc:269127}. El archimago Ansirem está al sureste, junto a la cúpula.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Quédate con {npc:2713} mientras se cuela en {area:314} y vuelve; los orcos de la Horda te atacan por el camino.",
	-- ["Subdue the succubus"] = "Somete a la súcubo",
	-- ["Summon Succubus"] = "Invocar súcubo",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Los ogros Aplastacresta ocupan las colinas al norte de {area:280}. Más al norte, un cofre de madera gastado contiene el {item:3706}; {npc:2320}, de {quest:537}, está justo a su lado.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Los kóbolds Mostacho Seco excavan en la garganta al este de {area:321} (Horda); rodea el pueblo por el norte. Sueltan tanto las motas como el mineral de Krazek.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "El Sindicato ocupa la granja al noroeste de {area:320}. Un {npc:217589} corretea por la granja: atrapa uno con el kit de iniciación a la entomología de {npc:217412} y márcalo.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Los trols Secacorteza viven en las colinas al sur de {area:314}; los médicos brujos están en el poblado y los cazadores de las Sombras guardan el fondo del valle.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Los tomos están en el castillo en ruinas al oeste de {area:280}; los Magos oscuros Artus ocupan las ruinas.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "La caravana destrozada está fuera del camino, cerca de Biggs.",
	-- ["The wrecks"] = "Los naufragios",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Vuelve al puente: Ebenezer yace bajo su extremo de Arathi.",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Al oeste por la costa hasta la cala de los goblins; Lolo vigila desde las rocas de encima.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} para la capa de {npc:2438}, de {npc:2381}, si no tienes",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}: la {object:1760}",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: atrápalo, para {quest:93176}",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, en Ciudad de Dalaran",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, un ogro mago, ocupa la cueva del extremo sur del valle Secacorteza.",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455} y entrena con {npc:258098}. {npc:1573}, en {object:32372}, también vuela a {area:271}.",
}
