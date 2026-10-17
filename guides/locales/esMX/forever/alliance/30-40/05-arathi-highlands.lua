-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {area:35} Booty Bay
	["Gyll, {area:35}"] = "Gyll, {area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Desde {area:42} sigue el camino al este por {zone:1430} hasta {zone:1435}; Biggs vigila el cruce de caminos justo al entrar. {npc:217412} está un poco al norte de él.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: tres alimañas que atrapar en Arathi, {zone:1443} y Tuercespina",

	-- Step 3: The western swamp
	["The western swamp"] = "El pantano del oeste",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Crocoliscos jóvenes, Hilapenas ({npc:858}) y Jaguares del pantano ({npc:767}) recorren el pantano alrededor del camino.",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "La caravana destrozada está fuera del camino, cerca de Biggs.",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Sigue el camino al norte hasta los draenei de {area:657}.",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Al este por el camino hasta {area:76}. Los enemigos {npc:256028} sueltan los cristales; Noboru recorre las ruinas y suelta su garrote.",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} está enjaulado en el extremo norte del santuario. Libéralo y mantenlo con vida durante la salida; después, su caja fuerte espera junto al camino.",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "De vuelta al oeste por {zone:1430} hasta {area:42}.",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, camino de {area:17203}",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, en la catedral",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, la biblioteca real del castillo",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} espera en el sótano de {object:2164}, en {object:2101}. Usa el {item:6913} en el círculo de invocación de allí y derrota a la súcubo que aparece. Si aceptaste {quest:65602}, dale también la {item:190309}, colócala en el mismo círculo y derrota al íncubo.",
	["Subdue the succubus"] = "Somete a la súcubo",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, si la aceptaste",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, en el mismo círculo",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} vincula al íncubo contigo",

	-- Step 14: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} no tiene instructor de chamanes: toma {area:2257} desde {object:28027} hasta {zone:1455} y entrena con {npc:258098}. {npc:1573}, en {object:32372}, también vuela a {area:271}.",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Vuela a {area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Un {npc:2434} acecha sin ser visto en las afueras de {area:271}; mátalo y lee el contrato que lleva.",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Sigue el camino al este, saliendo de {area:287}, por {area:1057} hasta {area:320}.",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "La Hermandad ocupa la granja al noroeste de {area:320}. Un {npc:217589} se arrastra por la granja: atrapa uno con el kit de entomología de {npc:217412} y luego márcalo.",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: atrápalo, para {quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Sigue el camino al sur por el puente hasta {area:205}, en el extremo de {zone:1437}, donde espera {npc:1075}.",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Herrumbra",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Vuelve al puente: Ebenezer yace bajo su extremo de Arathi.",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Al oeste por la costa hasta la cala de los goblins; Lolo vigila desde las rocas de encima.",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "Fiseltor",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escolta al profesor hasta la playa al norte de la cala y protégelo mientras trabaja; los naga atacan en oleadas.",

	-- Step 26: The wrecks
	["The wrecks"] = "Los naufragios",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Los dos naufragios están en la bahía al oeste de la cala. Las cartas y los diarios están dentro; las gemas están en el fondo del mar a su alrededor. Los naga Espinadaga nadan por toda la bahía.",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Para {npc:2487} en {area:35}: guárdalo",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Cabalga de vuelta al noreste pasando {area:320}; {npc:2712} y {npc:2713} acampan en las colinas al norte de {area:314}.",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "El mensajero recorre el camino al oeste de {area:314} con dos guardias; atráelos fuera del camino.",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} y {npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "El encargo de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Quédate con {npc:2713} mientras se infiltra en {area:314} y regresa; los orcos de la Horda te atacan en el camino.",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Para {npc:2711} en {area:271}",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Ve al norte pasando {area:314}; los fragmentos brillan en la colina junto a {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Solo si Gluggle te dio el colgante en Tuercespina",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Los kóbolds Mostacho Seco cavan en el cañón al este de {area:321} (Horda); rodea el pueblo por el norte. Sueltan tanto las motas como el mineral de Krazek.",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Los fragmentos están al fondo de {area:318}.",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Los trols Secacorteza viven en las colinas al sur de {area:314}; los Médicos brujos están en la aldea, y los Cazadores de las Sombras vigilan el fondo del valle.",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Cada llave está en uno de los círculos de piedras de las Tierras Altas: al este de los fragmentos, cerca de {area:320} y en el oeste. {object:2702} está al oeste de {area:320}.",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, un mago ogro, ocupa la cueva del extremo sur del valle Secacorteza.",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Sigue el camino al norte, saliendo de {area:271}, hacia las montañas. Los leones de montaña rondan las laderas; la Hermandad de {area:280} lleva los anillos de sello, y {npc:2306} recorre los terrenos de la mansión al norte del pueblo.",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "Ogros Aplastacresta",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Los ogros Aplastacresta ocupan las colinas al norte de {area:280}. Más al norte, un cofre de madera gastado guarda el {item:3706}; {npc:2320}, de {quest:537}, está justo a su lado.",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Los tomos están en el castillo en ruinas al oeste de {area:280}; los Magos oscuros Argus ({npc:2318}) ocupan las ruinas.",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: ogros Aplastacresta",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Al suroeste hasta el campamento del Kirin Tor en la orilla del lago al oeste de {area:279}, justo al cruzar la frontera de {zone:1421}: ahí está {npc:269127}. El archimago Ansirem está al sureste, junto a la cúpula.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Para {npc:2542} en {area:35}: guárdalo",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} para la capa de {npc:2438}, de {npc:2381}, si no tienes",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Para {npc:1440} en {zone:1453}: guárdalo",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Desde {zone:1455} toma el túnel al este por {zone:1426} hasta {zone:1432} y sigue el camino hasta {area:144}.",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "Al sureste por la orilla del lago hasta la excavación.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the draenei of the {area:657}."] = "Sigue el camino al norte hasta los draenei de {area:657}.",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, en la Ciudad de Dalaran",
}
