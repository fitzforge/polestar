-- Spanish (Spain) (esES): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:253092} Alba Fairmoon · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} y {npc:821} están en lo alto de la torre de piedra. {npc:491} está dentro de la torre; {npc:878} y {npc:253092}, en la ladera sur de la colina, junto a la posada y a {npc:523}, el maestro de grifos.",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; omite el vuelo gratis que te ofrece",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Sigue el camino hacia el norte. {npc:233} está fuera, {npc:235} Saldean en la casa y {npc:253395} en el granero al oeste.",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Más al norte por el camino. Los Cejade están sentados junto a su granja quemada. Recoge la avena de los Sacos de avena de los campos por el camino y llena el vial en el pozo de la finca.",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Solo si conseguiste una {item:1972} en el Bosque de Elwynn: haz clic derecho en ella",
	["Fill the vial at the well"] = "Llena el vial en el pozo",
	["Sacks of Oats"] = "Sacos de avena",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Los Dentosangre jóvenes y los Desgarradores recorren los campos alrededor de la granja: empieza con los hígados y la carne del estofado a la vuelta.",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "Al oeste de la Finca de Saldean. Los Vigilantes de la cosecha y los Gólems trabajan los campos; sueltan los isomuelles, los giroestabilizadores, {item:732} y a veces un {item:255155}. {npc:573}, un raro de nivel 20, anda por aquí: déjalo en paz. Sigue matando Dentosangre y Desgarradores en cada tramo de esta vuelta.",
	["Fill the vial at the farm's well"] = "Llena el vial en el pozo de la granja",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Vigilantes de la cosecha",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Desgarradores",

	-- Step 6: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "Al oeste de La Granja de Molsen, hacia la costa. Los Mineros Zarparrío trabajan en la cantera.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineros Zarparrío",

	-- Step 7: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Kobold Diggers = {npc:1236} Kobold Digger
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Al norte de La Granja de Molsen. Los Tramperos Defias y los Contrabandistas acampan fuera de la mina; los Cavadores kóbold trabajan dentro. {object:290} está junto a la casa en ruinas al este de la mina.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Cavadores kóbold",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: los suelta cualquier Defias",

	-- Step 8: The north coast
	["The north coast"] = "La costa norte",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Los Correcostas múrloc y los Asaltantes ocupan la playa al norte de la mina. Huyen con poca salud: atráelos de uno en uno.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Branquias de múrloc de Playa Larga",

	-- Step 9: The gnoll hills
	["The gnoll hills"] = "Las colinas de los gnolls",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Los Gnolls Zarparrío y los Exploradores recorren las colinas entre la costa y {area:916}.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Garras gnoll",

	-- Step 11: Saldean's Farm
	["Only if he takes the isosprings alone"] = "Solo si acepta los isomuelles por separado",

	-- Step 13: The western farms
	["The western farms"] = "Las granjas del oeste",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Los Saqueadores Defias y los Despojadores ocupan las granjas al oeste de {area:108}, entre el camino de la costa y {area:20}.",

	-- Step 15: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} y las colinas Defias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Los Acechacaminos Defias y los Sacudillos recorren {area:20}; los Bandoleros (nivel 17) patrullan en parejas las colinas al sur y al este: sepáralos. La entrada a {area:1581}, en la herrería, es una mazmorra de grupo.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, de las cajas alrededor de {area:20}",

	-- Step 16: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "Vuelve a {area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "¿Piedra de hogar en reutilización? Sigue el camino hacia el noreste.",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Para {npc:266} en {area:69}, Montañas Crestagrana",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Para {npc:11026}, en {object:28027} de {zone:1453}",

	-- Step 17: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Vuela o cabalga hasta {zone:1453}. {npc:5480} entrena a los guerreros en {object:2100}; {npc:6089} y {npc:6090} están juntos junto a {object:2152}, allí mismo. {npc:6090} pelea contigo por su jarra.",

	-- Step 18: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Vuela o cabalga hasta {zone:1453}. {npc:376} está en la Catedral de la Luz.",

	-- Step 19: Shaman training
	["Shaman training"] = "Instrucción de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Cabalga hasta {zone:1453}. No tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y vuelve en el tranvía para coger el barco.",

	-- Step 20: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:11026} Sprite Jumpsprocket · {object:28027} Dwarven District · {npc:279} Morgan Pestle · {object:2096} Trade District
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Vuela o cabalga hasta {zone:1453}. Instructores: {object:2100} (guerreros, pícaros), la Catedral (paladines, sacerdotes), {object:2101} (magos, brujos), el Parque (druidas). {npc:11026} trabaja en {object:28027}; {npc:279}, en {object:2096}.",
	["Level 12, 14 and 16 spells"] = "Hechizos de nivel 12, 14 y 16",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} para Reunir los ingredientes del remedio (6123) en {zone:1439}: {npc:1313}, Suministros de alquimia; los herboristas la recogen allí",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Sagrario del Mago: {quest:1861}",

	-- Step 21: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vende suministros de pesca junto al canal, justo al oeste de {object:2096}; {npc:267118} pesca en el puerto, de camino al barco.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, de {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defensive Stance"] = "Actitud defensiva",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:23299} (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Vuela o cabalga hasta {zone:1453}. Instructores: {object:2100} (guerreros, pícaros), la Catedral (paladines, sacerdotes), {object:2101} (magos, brujos), {object:23299} (druidas). {npc:11026} trabaja en {object:28027}; {npc:279}, en {object:2096}.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Los Gnolls Zarparrío y los Exploradores recorren las colinas entre la costa y {area:916}.",
	-- ["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, {skill:171} Supplies; herbalists pick it there instead"] = "{item:2449} para Reunir los ingredientes del remedio (6123) en {zone:1439}: {npc:1313}, suministros de {skill:171}; los herboristas la recogen allí",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}: Actitud defensiva",
}
