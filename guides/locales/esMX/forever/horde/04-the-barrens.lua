-- Spanish (Latin America) (esMX): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",
	-- {object:172982} Valley of Strength
	["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doras, el maestro de jinetes del viento, está en la torre de {object:172982}.",

	-- Step 2: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, junto al maestro de jinetes del viento. Guárdala: {quest:1483} está en Sierra Espolón, más adelante",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Cartel de {object:3972}",
	-- {npc:3453} Wharfmaster Dizzywig
	["{npc:3453}, on the dock"] = "{npc:3453}, en el muelle",

	-- Step 3: Bruuz
	-- {npc:209797} Bruuz · {area:392} Ratchet
	["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} nada en el puerto, justo frente a los muelles de {area:392}. {npc:209797} es de élite: se recomienda ir en grupo.",

	-- Step 4: Baron Longshore
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Los piratas acampan en la playa al sur de {area:392}; {npc:3467} está en su extremo sur.",

	-- Step 5: Northwatch Hold
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, en la costa, más al sur. Los Marinos de Theramore y los Presertores de Theramonte (15-16) sueltan las medallas; {npc:3393} (20) y los dos cañoneros (19) están en la fortaleza y en sus murallas, y por ellos el bastión espera hasta ahora.",

	-- Step 6: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} está encadenado dentro del bastión. Habla con él para iniciar la escolta y mantente cerca: los soldados de Theramore atacan en la salida. Te acompaña de vuelta a {area:392}.",

	-- Step 8: Raptor Horns
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Los Segadores Solescama cazan en las llanuras al sur de {area:380}, alrededor de {area:1697}; sueltan los cuernos. Entrégalos la próxima vez que pases por {area:392}.",

	-- Step 9: Crossroads
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Guárdala: Kadrak en {area:1703}, siguiente guía",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: los huevos están en {area:390}, más adelante",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, en lo alto de la torre",

	-- Step 10: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Cabalga hacia el norte desde {area:380} hasta {area:384} y llena {item:15842} en {object:19464}; luego regresa con {npc:3448} en {area:380}. ¿Sin {skill:182}? {npc:3490}, a su lado, vende {item:2449}, de tres en tres hasta que reabastece.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} de {npc:3490}; los herboristas la recogen en las llanuras",

	-- Step 11: Level 20
	["Level 20"] = "Nivel 20",
	-- {zone:1454} Orgrimmar · {npc:3354} Sorek · {npc:5892} Searn Firewarder · {area:380} Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Las misiones de clase de nivel 20 en {zone:1454} ({npc:3354}, {npc:5892}, los instructores de brujos y pícaros) solo se ofrecen desde el nivel 20, así que termina el nivel aquí antes de volar. Las Proles de Halcón Trueno (18) de las llanuras al suroeste de {area:380} y los Kolkar (14-15) de {area:388} son los enemigos más cercanos que vale la pena matar; necesitas bastante menos de un nivel.",
	-- {area:380} Crossroads
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "caza Proles de Halcón Trueno al suroeste de {area:380}",

	-- Step 12: Orgrimmar
	-- {area:1637} Orgrimmar · {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Vuela a {area:1637} para entrenar tus rangos de nivel 20. {npc:3354} está en {object:172958}; {npc:5892}, en {object:172957}.",

	-- Step 13: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} es el cañón bajo {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, a unos pasos",

	-- Step 14: Shenthul
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {quest:2460} The Shattered Salute
	["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} está en {object:172960}. Selecciónalo y escribe /salute para terminar {quest:2460}.",
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, junto a {area:382}",

	-- Step 15: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} está en {object:172961}, en el lado oeste de la ciudad.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} en {zone:1458}, dos guías más adelante",

	-- Step 16: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Vuela a {area:1638} y entrena tus rangos de nivel 20: {npc:3033} está en {area:1639}.",

	-- Step 17: Back to the Crossroads
	-- {area:380} Crossroads
	["Back to the {area:380}"] = "De vuelta a {area:380}",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} está en el puesto de vigilancia de los Kolkar, justo al oeste de {area:380}.",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} está en el campamento Kolkar al noroeste de {npc:3389}.",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: Kodos de Los Baldíos perdidos ({npc:3234}) en las llanuras alrededor del campamento Kolkar",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449}: los herboristas la recogen aquí",

	-- Step 21: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vive en {area:2539}, la aldea trol justo al entrar en Sierra Espolón, al final del camino hacia el oeste desde {npc:3389}.",

	-- Step 22: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Al norte, hasta {area:383}. {npc:3682} acampa al pie de las colinas; {npc:261366}, el ermitaño de la loma detrás de él, solo tiene trabajo para ti cuando {npc:3682} te envía arriba.",

	-- Step 23: Dry Hills
	-- {area:392} Ratchet · {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them, so do both here and skip the Matriarchs by {area:392}. {quest:876} leads the Witchwing harpies in the hills to the west."] = "",

	-- Step 26: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} y sus marinos defienden la caravana destrozada al sur de {npc:261366}.",

	-- Step 27: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Ayuda a {npc:261366}: quédate a su lado cuando {npc:261367} y los marines de {area:21} suban por la loma",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} está en el borde norte de {area:382}, junto a la torre de Ventura y Cía. Contiene {item:15883} para {quest:30}.",

	-- Step 29: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Al este, hasta {area:382}. {npc:3439} está dentro del campamento de Ventura y Cía.; {npc:3445} lleva la llave.",

	-- Step 30: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Rabiaire saca su machacador del campamento: quédate con él y mata lo que lo ataque. {npc:3442} la recibe en {area:392}.",

	-- Step 31: Taskmaster Fizzule
	-- {area:382} Sludge Fen
	["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule dirige el campamento de Ventura y Cía. en el extremo este de {area:382}. Ataca a los desconocidos: selecciónalo y haz /salute antes de que lo haga.",

	-- Step 32: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Mantente en sigilo: {npc:7287} lleva la llave de la torre; Gallywix y su cofre están en lo alto. Gallywix es de élite: se recomienda ir en grupo.",
	["Venture Co. tower"] = "Torre de Ventura y Cía.",

	-- Step 33: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Los Sobrestantes y los Déspotas de Ventura y Cía. de la mina en la esquina noreste de la zona sueltan {item:5097}.",

	-- Step 34: Hearth to the Crossroads
	-- {area:380} Crossroads
	["Hearth to the {area:380}"] = "Usa la piedra de hogar para ir a {area:380}",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Te da {item:15826}",

	-- Step 35: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} camina entre los Kolkar de {area:388}, al sureste de {area:380}.",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: usa {item:15826} en ellas; recorren las llanuras alrededor de {area:380}",

	-- Step 36: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Sigue {area:458} hacia el sur hasta {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, en la jaula",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, en el borde norte del campamento",

	-- Step 37: Bristleback camps
	["Bristleback camps"] = "Campamentos Lomopelo",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {item:5075} Blood Shard · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Los campamentos de jabaespines Lomopelo se extienden por las llanuras al norte de {area:378}, a ambos lados de {area:458}. Cada Lomopelo suelta un colmillo; la esposa de {npc:3432} yace en el borde norte. Guarda un {item:5075}. {quest:883}, un kodo gris, a veces deambula por aquí: su pezuña inicia una misión.",

	-- Step 38: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran está encadenado en el campamento de jabaespines al oeste del camino.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Guárdala: {npc:5875} en {zone:1454}, al final de esta guía",

	-- Step 40: Stolen Silver
	-- {area:385} Northwatch Hold
	["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Al este a través de las llanuras hacia la costa: la plata robada está en un nido de raptores al noroeste de {area:385}.",

	-- Step 41: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} espera en la colina al sur de {area:392}, de camino al norte.",

	-- Step 43: Ishamuhale
	-- {quest:882} Ishamuhale · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, un gran raptor Solescama, caza en las llanuras al norte del camino de {area:392} a {area:380}.",

	-- Step 44: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} ofrece {quest:95774} una vez entregada {quest:4921}",

	-- Step 46: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} dirige a los Kolkar en la orilla oeste de {area:387}, al sur de {npc:3389}. Entrega su cabeza a {npc:3389} en tu última parada en {area:380}.",

	-- Step 47: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "De regreso por {area:458} hacia {area:378}: los Asaltantes Crines de Acero entre los campamentos Lomopelo, a ambos lados del camino al norte del campamento, llevan {item:277277}. Entrégalos a {npc:3432} en tu última parada en {area:380}.",

	-- Step 48: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Baja otra vez por {area:458} hasta {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Guárdala: {npc:12696} en {zone:1440}, siguiente guía",

	-- Step 49: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Los Tronatestas pastan en las llanuras justo al sur de {area:378}. {quest:884}, un lagarto del trueno azul, deambula entre ellos: su púa caudal inicia una misión.",

	-- Step 51: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Los Desechanubes Halcón Trueno sobrevuelan las mismas llanuras al sur del campamento.",

	-- Step 53: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Al sur de Campamento Taurajo, los Montículos de silítidos ({object:3685}) salpican {area:390}; los huevos están en ellos, y los Enjambristas silítidos ({npc:3252}) salen a defenderlos. Los Cosechadores silítidos ({npc:3253}) son raros: si ves uno, mátalo para obtener su cabeza.",

	-- Step 54: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} espera en un pequeño campamento más al sur, en el camino hacia {area:359}.",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, arriba en el árbol justo al este de {npc:3341}",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, justo al oeste de {npc:3341}",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Llena {item:7766} en el abrevadero de los jabaespines",
	-- {object:107045} Spring Well · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "Guárdala: {object:107045} está junto a {area:272}",

	-- Step 55: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "Al oeste de {npc:3341}, los Crines de Acero ocupan {area:1701}. {npc:3436} está en el lado este, {npc:3434} al sur y {npc:3435} en el extremo oeste. Lok (25) y los Dementes bélicos (24-25) te superan por unos niveles; {npc:5859}, un élite raro, a veces recorre la cresta: déjalo. Los Abrecaminos y los Acechadores sueltan el apuñalador; los Videntes, la varita; los Dementes bélicos, el escudo de guerra. Los lagartos {npc:3238} y los Acechadores Dentecenado recorren la llanura entre Gann y la cresta. {quest:885}, un raro serpiente alada roja, sobrevuela la cresta: su pluma inicia una misión.",
	-- {npc:3238} Stormhide · {npc:3341} Gann Stonespire
	["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, en la llanura entre {npc:3341} y la cresta",

	-- Step 56: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Al sur de Gann, los enanos de Bael'dun excavan en {area:359}. Los Excavadores y los Supervisores trabajan en el foso; {npc:3392} (26) lleva el diario: atráelo solo.",

	-- Step 58: Bael'dun fortress
	["Bael'dun fortress"] = "Fortaleza de Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Los Soldados, Fusileros y Oficiales Bael'dun defienden la fortaleza en el lado este de la excavación; los tres objetos los sueltan ellos.",

	-- Step 60: The flying machine
	["The flying machine"] = "La máquina voladora",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "La máquina voladora de los enanos está en su plataforma dentro de la excavación.",

	-- Step 62: Twitching Antennae
	["Twitching Antennae"] = "Antenas temblorosas",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Las antenas desaparecen quince minutos después de soltarse, así que recógelas ahora, de regreso al norte: mata Enjambristas silítidos y Trepadores silítidos en los montículos de {area:390} hasta tener cinco y luego usa la piedra de hogar para ir a {area:378} de inmediato.",
	["Twitching Antennae from the silithid"] = "Antenas temblorosas de los silítidos",

	-- Step 66: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} acampa junto al camino al este de {area:380}.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Después ofrece {quest:1838} (1838, nivel 30): requiere {area:1717} y te envía por todo Kalimdor y los Reinos del Este. La guía de clase de guerrero {quest:1838} la cubre.",

	-- Step 67: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "Vuela a {area:1637} para entrenar.",

	-- Step 68: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} instruye a los paladines en {area:1638}. Aún no tienes ruta de vuelo ahí: vuela a {area:378}, cabalga hacia el oeste por {zone:1412}, sube por un elevador y consigue la ruta de vuelo de {npc:2995} en la meseta central.",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} está en {object:172960}. Usa {item:6626} en el círculo de invocación de ahí y derrota a la súcubo para vincularla.",

	-- Step 70: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391}, en {area:272}, enseña Venenos: guárdala",

	-- Step 71: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Vuela a {area:1638} para entrenar: {npc:3033} está en {area:1639}.",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Lanza {spell:18960}. Taurens: unan las dos mitades del colgante en {area:2362}, en la orilla noroeste del lago, antes de ver a {npc:11802} en {area:2361}.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: usa una mitad en {area:2362}",
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: la bienvenida de {npc:3033}",

	-- Step 73: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Tauren: {npc:11957} espera en la colina sur, sobre el puente. Cielonatos: {npc:272054} está al sur de los puentes gemelos. Luego, las guaridas al este del lago: sal de tu forma, haz clic en la estatua de la entrada para obtener cinco minutos de sigilo, mantente lejos de los espíritus de adentro y toma una reliquia de cada tipo; {item:280680} está al pie de la estatua del gato blanco.",

	-- Step 75: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798}, en {area:2361}, lleva volando a los druidas ahí",

	-- Step 76: Back to the Crossroads
	-- {area:380} Crossroads · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Vuela de vuelta a {area:380}. La siguiente guía empieza aquí y toma el camino al norte hacia {area:1703} y {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bruuz"] = "Bruuz",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Los Patriarcas de la sabana recorren las llanuras al este de las colinas, y las Trampas activadas están entre ellos. {quest:876} dirige a las arpías Alabruja en las colinas del oeste.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790} está en el borde norte de {area:382}, junto a la torre de Ventura y Cía. Contiene {item:15883} para {quest:30}.",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391}, en {area:272}, enseña {spell:2842}: guárdala",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033}: Cat Form",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033}: Cure Poison",
}
