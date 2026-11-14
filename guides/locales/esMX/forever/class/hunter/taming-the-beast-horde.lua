-- Spanish (Latin America) (esMX): the guide forever/class/hunter/taming-the-beast-horde (forever/class/hunter/taming-the-beast-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6061} Taming the Beast
	["{quest:6061} (Horde)"] = "{quest:6061} (Horda)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Tu propia mascota a nivel 10: tres domas de práctica con una {item:15908} enseñan {spell:1515}, y luego {spell:5149}.",

	-- Step 1: Thotar in Razor Hill
	-- {npc:3171} Thotar · {area:362} Razor Hill
	["{npc:3171} in {area:362}"] = "{npc:3171} en {area:362}",
	-- {npc:3171} Thotar · {area:362} Razor Hill · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:11814} Kali Remik · {area:367} Sen'jin Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff
	["At 10 go to {npc:3171}, the hunter trainer inside the barracks in {area:362}. If {npc:3407} in {zone:1454}, {npc:11814} in {area:367} or {npc:3038} in {zone:1456} hands you The Hunter's Path, take it and hand it to {npc:3171} for a little experience; it is only a pointer, and you can take the first rod without it."] = "A nivel 10 ve con {npc:3171}, el instructor de cazadores dentro del cuartel de {area:362}. Si {npc:3407} en {zone:1454}, {npc:11814} en {area:367} o {npc:3038} en {zone:1456} te da La senda del cazador, tómala y entrégasela a {npc:3171} por un poco de experiencia; es solo una indicación, y puedes tomar la primera vara sin ella.",
	-- {npc:3171} Thotar · {item:15908} Taming Rod
	["{npc:3171}: the first {item:15908}"] = "{npc:3171}: la primera {item:15908}",

	-- Step 2: Dire Mottled Boar
	-- {area:362} Razor Hill · {item:15908} Taming Rod · {npc:3171} Thotar · {spell:75} Auto Shot
	-- plural, as words: Dire Mottled Boars = {npc:3099} Dire Mottled Boar
	["Dire Mottled Boars (level 6-7) roam just north and west of {area:362}. How the rod works: target a living beast, use the {item:15908} from inside its range and stand still for the whole channel while the beast hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:3171}. The boars charge from 20 yards, so start with the rod, not {spell:75}. The tamed boar becomes your pet for practice. Keep each rod: it goes back to {npc:3171}."] = "Los jabalíes moteados terribles (nivel 6-7) recorren la zona justo al norte y oeste de {area:362}. Cómo funciona la vara: selecciona a una bestia viva, usa {item:15908} dentro de su alcance y quédate quieto durante toda la canalización mientras la bestia te pega. Moverte, defenderte, una curación de otro o que cualquier otro golpee a la bestia la rompe y gasta una de las pocas cargas de la vara; si se acaban, destruye la vara, abandona la misión y vuelve a tomarla con {npc:3171}. Los jabalíes cargan desde 20 m, así que empieza con la vara, no con {spell:75}. El jabalí domado se vuelve tu mascota de práctica. Guarda cada vara: vuelve a {npc:3171}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Usa {item:15908} sobre un jabalí vivo",

	-- Step 3: Surf Crawler
	-- {spell:2641} Dismiss Pet · {area:367} Sen'jin Village · {area:368} Echo Isles
	-- plural, as words: Surf Crawlers = {npc:3107} Surf Crawler · Pygmy Surf Crawlers = {npc:3106} Pygmy Surf Crawler
	["First dismiss the boar (right-click your pet's portrait, {spell:2641}): a released practice pet can turn on you. Surf Crawlers (level 7-8) walk the beaches around {area:367} and the {area:368}; the small Pygmy Surf Crawlers do not count. A crawler runs for help at 15% health, so do not hurt it."] = "Primero despide al jabalí (clic derecho en el retrato de tu mascota, {spell:2641}): una mascota de práctica liberada puede volverse contra ti. Los reptadores de la marea (nivel 7-8) caminan por las playas alrededor de {area:367} y {area:368}; los reptadores de la marea pigmeos, pequeños, no cuentan. Un reptador huye a pedir ayuda al 15 % de salud, así que no lo lastimes.",
	-- {item:15908} Taming Rod · {npc:3107} Surf Crawler
	["Use the {item:15908} on a living {npc:3107}"] = "Usa {item:15908} sobre un {npc:3107} vivo",

	-- Step 4: Armored Scorpid
	-- {area:362} Razor Hill · {spell:1494} Track Beasts
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Dismiss the crawler. Armored Scorpids (level 7-8) crawl the dry plains west and south-west of {area:362}, some just south of the road west out of town; {spell:1494} shows them. Their hits can break the channel: start at full health and keep still."] = "Despide al reptador. Los escórpidos acorazados (nivel 7-8) se arrastran por las llanuras secas al oeste y suroeste de {area:362}, algunos justo al sur del camino que sale del pueblo hacia el oeste; {spell:1494} los muestra. Sus golpes pueden romper la canalización: empieza con la salud al máximo y quédate quieto.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living scorpid"] = "Usa {item:15908} sobre un escórpido vivo",

	-- Step 5: Ormak Grimshot in Orgrimmar
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar
	["{npc:3352} in {zone:1454}"] = "{npc:3352} en {zone:1454}",
	-- {zone:1454} Orgrimmar · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor · {npc:10088} Xao'tsu
	["Follow the road north to {zone:1454}'s gate. {npc:3352} stands with the hunter trainers in the {object:172958}, up the ramp at the city's east side; {npc:10088}, the pet trainer, is a few steps north of him."] = "Sigue el camino al norte hasta la puerta de {zone:1454}. {npc:3352} está con los instructores de cazadores en {object:172958}, subiendo la rampa del lado este de la ciudad; {npc:10088}, el instructor de mascotas, está a pocos pasos al norte.",

	-- Step 6: Yaw Sharpmane at Bloodhoof
	-- {npc:3065} Yaw Sharpmane
	["{npc:3065} at Bloodhoof"] = "{npc:3065} en Pezuña de Sangre",
	-- {npc:3065} Yaw Sharpmane · {area:222} Bloodhoof Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:3171} Thotar · {area:362} Razor Hill
	["At 10 go to {npc:3065}, who stands at the north edge of {area:222}. The Hunter's Path from {npc:3038} in {zone:1456}, {npc:3407} in {zone:1454} or {npc:3171} in {area:362} also leads here, for a little experience; it is only a pointer."] = "A nivel 10 ve con {npc:3065}, que está en el borde norte de {area:222}. La Senda del cazador de {npc:3038} en {zone:1456}, {npc:3407} en {zone:1454} o {npc:3171} en {area:362} también lleva aquí, por un poco de experiencia; es solo una indicación.",
	-- {npc:3065} Yaw Sharpmane · {item:15908} Taming Rod
	["{npc:3065}: the first {item:15908}"] = "{npc:3065}: la primera {item:15908}",

	-- Step 7: Adult Plainstrider
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Adult Plainstriders (level 6-7) walk the plains south-west and north-west of {area:222}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). A plainstrider flees at 25% health, so do not damage it first. Keep each rod: it goes back to Yaw."] = "Los zancudos de llanura adultos (nivel 6-7) caminan por las llanuras al suroeste y noroeste de {area:222}. Cómo funciona la vara: selecciona a una bestia viva, usa {item:15908} y quédate quieto durante toda la canalización mientras te pega; moverte, defenderte o la ayuda de cualquier otro la rompe y gasta una de las pocas cargas de la vara (sin cargas: destruye la vara, abandona la misión y vuelve a tomarla). Un zancudo huye al 25 % de salud, así que no lo dañes antes. Guarda cada vara: vuelve a Yaw.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living plainstrider"] = "Usa {item:15908} sobre un zancudo vivo",

	-- Step 8: Prairie Stalker
	-- {spell:2641} Dismiss Pet · {area:222} Bloodhoof Village
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker
	["Dismiss the plainstrider first (right-click the pet portrait, {spell:2641}): a released practice pet may attack you. Prairie Stalkers (level 7-8) roam the grass north of {area:222}."] = "Primero despide al zancudo (clic derecho en el retrato de la mascota, {spell:2641}): una mascota de práctica liberada puede atacarte. Los acechadores de la pradera (nivel 7-8) recorren la hierba al norte de {area:222}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Usa {item:15908} sobre un acechador vivo",

	-- Step 9: Swoop
	-- {npc:2970} Swoop
	-- plural, as words: Swoops = {npc:2970} Swoop · Taloned Swoops = {npc:2971} Taloned Swoop
	["Dismiss the stalker. Swoops (level 7-9) glide over the plains north-west and north-east of Bloodhoof; the Taloned Swoops do not count. A {npc:2970}'s knockdown breaks the channel, but it lands only once per channel: start the rod just after it has used it."] = "Despide al acechador. Los planeadores (nivel 7-9) planean sobre las llanuras al noroeste y noreste de Pezuña de Sangre; los planeadores garrudos no cuentan. El derribo de un {npc:2970} rompe la canalización, pero solo lo usa una vez por canalización: empieza con la vara justo después de que lo haya usado.",
	-- {item:15908} Taming Rod · {npc:2970} Swoop
	["Use the {item:15908} on a living {npc:2970}"] = "Usa {item:15908} sobre un {npc:2970} vivo",

	-- Step 10: Holt Thunderhorn in Thunder Bluff
	-- {npc:3039} Holt Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:3039} in {zone:1456}"] = "{npc:3039} en {zone:1456}",
	-- {zone:1456} Thunder Bluff · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {npc:10086} Hesuwa Thunderhorn
	["Head north to {zone:1456} and take a lift up. {npc:3039} stands with the hunter trainers on {area:1641}; {npc:10086}, the pet trainer, is nearby."] = "Ve al norte hasta {zone:1456} y sube por un elevador. {npc:3039} está con los instructores de cazadores en {area:1641}; {npc:10086}, la instructora de mascotas, está cerca.",

	-- Step 11: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "A nivel 10, {npc:254084}, una instructora de cazadores en {zone:2521}, puede mandarte a {area:16638} con {quest:94007}. Es solo una indicación: omítela si ya estás en {area:16638}.",

	-- Step 12: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} en {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} está con los instructores junto a la puerta oeste de {area:16638}, con {npc:254411} a su lado.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}: la primera {item:15908}",

	-- Step 13: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs a charge. Killing one does not count."] = "Los reptadores Cantoviento viven solo junto al agua: los más cercanos corretean por la orilla al suroeste de {area:16638}, entre los cangrejos. Cómo funciona la vara: selecciona a un reptador vivo, usa {item:15908} y quédate quieto durante toda la canalización mientras te pega; moverte, defenderte o la ayuda de cualquier otro la rompe y gasta una carga. Matar uno no cuenta.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Usa {item:15908} sobre un reptador vivo",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Doma un {npc:254588}",

	-- Step 14: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Primero despide al reptador (clic derecho en el retrato de la mascota, {spell:2641}). Los Galestriders malhumorados pastan en {area:16626}, los campos a poca distancia al oeste y suroeste de {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Usa {item:15908} sobre un Galestrider vivo",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Doma un {npc:251707}",

	-- Step 15: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Despide al Galestrider. Los alfas Vuldren cazan en el mismo {area:16626}, un poco más al sur.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Usa {item:15908} sobre un alfa vivo",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Doma un {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, a su lado: {spell:5149}",

	-- Step 16: Your first pet
	["Your first pet"] = "Tu primera mascota",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} funciona como la vara: una bestia de tu nivel o menor, una canalización durante la que no puedes moverte, y la bestia pegándote todo el tiempo. Una mascota conserva el nivel al que la domas y sube de nivel contigo; nunca puede superar tu nivel, así que doma una cercana al tuyo. Cada familia tiene su propia habilidad en Forever (la Carga de un jabalí, por ejemplo). Para subir de nivel, un felino es el que más pega (Zarpa y {spell:17253}) y un jabalí aguanta más castigo.",
	["Tame a beast of your level to keep"] = "Doma una bestia de tu nivel para quedártela",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger · Venomtail Scorpids = {npc:3127} Venomtail Scorpid
	["Near {area:362}: Durotar Tigers (cats, level 7-8) roam the south of {zone:1411}, from {area:367} down the coast; Venomtail Scorpids (9-10) the north-west toward {zone:1454}; at 11-12, Savannah Huntresses (cats) prowl the plains around the Crossroads in the {zone:1413}."] = "Cerca de {area:362}: los tigres de Durotar (felinos, nivel 7-8) recorren el sur de {zone:1411}, desde {area:367} bajando por la costa; los escórpidos colavenenosa (9-10), el noroeste hacia {zone:1454}; a nivel 11-12, las cazadoras de la sabana (felinos) merodean por las llanuras alrededor del Cruce en {zone:1413}.",
	-- {zone:1412} Mulgore · {zone:1413} Barrens
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler · Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Near Bloodhoof: Flatland Prowlers (cats, level 9) and Prairie Wolf Alphas (wolves, 9-10) roam the plains of northern {zone:1412}; at 11-12, Savannah Huntresses (cats) prowl around the Crossroads in the {zone:1413}."] = "Cerca de Pezuña de Sangre: los merodeadores de las llanuras (felinos, nivel 9) y los lobos de la pradera alfa (lobos, 9-10) recorren las llanuras del norte de {zone:1412}; a nivel 11-12, las cazadoras de la sabana (felinos) merodean alrededor del Cruce en {zone:1413}.",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "Cerca de {area:16638}: los alfas Vuldren (nivel 10), la bestia de tu última doma de práctica, cazan en {area:16626}; las matriarcas chillonas (raptores, nivel 9) anidan justo al oeste de {area:16638}; los Ursera Sombraventisca (osos, 10-11) recorren el norte de {zone:2521}.",
	-- {spell:1584} Feed Pet · {npc:6928} Innkeeper Grosk · {area:362} Razor Hill · {npc:3025} Kaga Mistrunner · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Grimtak the butcher and {npc:6928} in {area:362} sell meat, {npc:3025} in {zone:1456} and the innkeepers on {zone:2521} too; Bloodhoof's innkeeper and bakers sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}: abre tu libro de hechizos, lanza {spell:1584} y haz clic en una comida que coma la familia de tu mascota (el recuadro de la mascota las muestra: los felinos comen carne y pescado, los jabalíes casi de todo). La carne cruda que sueltan las bestias cuenta. Para comprar: Grimtak, el carnicero, y {npc:6928} en {area:362} venden carne, {npc:3025} en {zone:1456} y los posaderos de {zone:2521} también; el posadero y los panaderos de Pezuña de Sangre venden pan. La comida de nivel cercano al de la mascota la pone más feliz; la de nivel mucho menor da más o menos la mitad. No puedes alimentarla en combate.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Felicidad: la cara en el marco de la mascota. Una mascota descontenta hace tres cuartos de su daño, una feliz un cuarto más. La felicidad baja despacio, más rápido cuando la mascota muere; una mascota descontenta demasiado tiempo puede escaparse.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "La lealtad crece con el tiempo y las muertes. Cada rango de lealtad sube los puntos de entrenamiento que gastas en {spell:5149} (nivel de la mascota por el rango de lealtad menos uno).",
	-- {spell:5149} Beast Training · {npc:9987} Shoja'my · {area:362} Razor Hill · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle · {npc:9988} Xon'cha · {zone:1454} Orgrimmar
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master ({npc:9987} in {area:362}, Seikwa at Bloodhoof, {npc:265756} on {zone:2521}, {npc:9988} in {zone:1454}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (libro de hechizos, pestaña General) le enseña a tu mascota actual las habilidades que conoces. Para aprender una habilidad o rango nuevo: deja tu mascota con un maestro de establos ({npc:9987} en {area:362}, Seikwa en Pezuña de Sangre, {npc:265756} en {zone:2521}, {npc:9988} en {zone:1454}), doma una bestia que la tenga (su pestaña del libro de mascota muestra lo que sabe), usa la habilidad en peleas hasta que el juego diga que la aprendiste, luego recupera tu mascota y enséñasela con {spell:5149}. Una mascota tiene como máximo cuatro habilidades activas.",
	-- {spell:1853} Growl · {area:362} Razor Hill · {npc:3688} Reban Freerunner · {npc:10088} Xao'tsu · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:10086} Hesuwa Thunderhorn · {zone:1456} Thunder Bluff · {area:1641} Hunter Rise · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Pet trainers sell {spell:1853} ranks and resistances. Horde: Harruk in {area:362}, {npc:3688} at Bloodhoof, {npc:10088} in {zone:1454}'s {object:172958}, {npc:10086} on {zone:1456}'s {area:1641}, {npc:254411} in {area:16638}, later Grokor in {area:75} and Zudd at {object:3202}."] = "Los instructores de mascotas venden rangos de {spell:1853} y resistencias. Horda: Harruk en {area:362}, {npc:3688} en Pezuña de Sangre, {npc:10088} en {object:172958} de {zone:1454}, {npc:10086} en {area:1641} de {zone:1456}, {npc:254411} en {area:16638}, y más adelante Grokor en {area:75} y Zudd en {object:3202}.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} y {spell:982} ya están en tu libro de hechizos; {spell:136} te lo enseña tu instructor a nivel 12. Una mascota muerta necesita {spell:982}; una que se aleja más de unos 100 m se despide y vuelve con {spell:883}.",
}
