-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Corcelorror de brujo",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "Tu montura épica a nivel 60, invocada en cualquier lugar: sin caballo épico que comprar ni Equitación de oficial de 1.000 de oro.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60 {npc:5520}, el instructor de demonios de {object:2164}, te manda con {quest:7562} en {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60 {npc:6382}, el instructor de demonios de {zone:1455}, te manda con {quest:7562} en {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60 {npc:5815}, el instructor de demonios de {object:172960}, te manda con {quest:7562} en {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60 {npc:5753}, la instructora de demonios de {object:36082}, te manda con {quest:7562} en {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14522} Ur'dan · {area:2057} Scholomance · {area:2577} Dire Maul
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the {area:255}, in the far north-west of the {zone:1428}, west of {area:254}. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the {area:2057} and {area:2577}. Start buying or gathering the materials of the next steps now."] = "{quest:7562} y su goblin {npc:14437} acampan en la colina al otro lado del camino desde {area:255}, en el extremo noroeste de {zone:1428}, al oeste de {area:254}. La cadena es larga: unos 420 de oro en mercancías de {npc:14437} y {npc:14522}, un montón de materiales fabricados, {area:2057} y {area:2577}. Empieza ya a comprar o juntar los materiales de los pasos siguientes.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2250} Owl Wing Thicket · {area:2242} Hidden Grove
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. {area:2250}, in the north-east, and the {area:2242}'s surroundings are packed with them, and they respawn in five and a half minutes."] = "Todos los lechúcicos de {zone:1452} (nivel 53-58, ninguno élite) sueltan la sangre más o menos una vez de cada tres: unas noventa muertes para treinta. {area:2250}, en el noreste, y los alrededores de {area:2242} están llenos de ellos, y reaparecen en cinco minutos y medio.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {area:1763} Jaedenar · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in {area:1763}: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "De vuelta con {npc:14436}: te da el {item:18591} para {npc:14437}, a su lado. Luego {npc:14436} pide la campana, la rueda y la vela, y {npc:14437} te manda con {quest:7623} en {area:1763}: cómprale tres pociones sombrías para ese viaje (6 de oro cada una: una para entrar, una después de {npc:14523} y una de repuesto por si se acaba alguna) y lleva 150 de oro para el polvo estelar.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "te da la {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, de {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Las piezas del ritual",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {area:1584} Blackrock Depths · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and {area:1584}) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "{npc:14437} quiere 10 elixires de poder de las Sombras ({skill:171}: 3 champiñones fantasma y un {item:8925} cada uno), 6 fragmentos brillantes grandes ({skill:333}: desencanta objetos azules de nivel 51 o más), 25 {item:11370} ({skill:186} 230: los depósitos de hierro negro de {zone:1428} y {area:1584}) y 35 escamas de dragón negro ({skill:393}: los dragonantes negros de {zone:1428}, un pequeño porcentaje por muerte, mejor de los {npc:7043}). Fabrica o junta lo que permitan tus profesiones y compra el resto en la casa de subastas; encontrar 35 escamas puede llevar un rato.",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "{item:9264}: la casa de subastas",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "{item:14344}: la casa de subastas",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "Dale las tres piezas a {npc:14437}. Luego quiere 3 barras de arcanita para la {item:18629}: los alquimistas las transmutan (un {item:12363} y una {item:12359} cada una, con un tiempo de reutilización largo); los demás las compran.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "{item:12360}: la casa de subastas",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {zone:1448} Felwood · {area:1770} Shadow Hold · {item:18802} Shadowy Potion · {spell:23179} Taint of Shadow · {quest:7623} Lord Banehollow
	["{area:1763} lies just south of {area:1997} in western {zone:1448}, west of the road; of its two caves, {area:1770} is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own ({spell:23179}). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "{area:1763} está justo al sur de {area:1997}, en el oeste de {zone:1448}, al oeste del camino; de sus dos cuevas, {area:1770} es la del norte, más arriba en la colina. Bebe una {item:18802} en su entrada: durante 20 minutos el Consejo de la Sombra de ahí te trata como a uno de los suyos ({spell:23179}). Los mocos de la poza roja y la súcubo Rakaiah más allá igual atacan: pégate a la pared al pasar. Baja pasando la segunda poza roja, sube la rampa y cruza dos puentes hasta {quest:7623}, un gran señor del terror alado al fondo. Solo te habla mientras dura la poción.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {spell:23179} Taint of Shadow · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your {spell:23179} aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "{npc:14523} espera en una salita lateral, subiendo por un puente que pasaste de bajada. Háblale y él y cuatro guardias atacan (todos de nivel 57, ninguno élite): deja que tu abisario contenga a los guardias y acaba con {npc:14523}, sacrificándolo si hace falta. O quítate el aura de {spell:23179} para empezar la pelea, mata a {npc:14523} y bebe otra poción: los guardias se detienen al instante. Llévale su corazón a {npc:9516} con una poción activa.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "{npc:14522}, junto a {quest:7623}, vende el {item:18687} por 150 de oro. Solo trata contigo mientras tengas una {item:18802} activa.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, de {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the {area:2057}. Put a group of five together now: a party, not a raid group."] = "De vuelta con {npc:14437} con el polvo estelar; con {quest:7630} también hecha, te da el {item:18688} para {area:2057}. Arma ya un grupo de cinco: un grupo, no un grupo de banda.",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "{quest:7625}, de {npc:14522}",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The {area:2057} (level 58-60, a group of five) lies under {area:2298}, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "{area:2057} (nivel 58-60, un grupo de cinco) está debajo de {area:2298}, el pueblo isleño del sureste de {zone:1422}: alguien necesita la {item:13704} o un pícaro para abrir la puerta. Avanza peleando hasta la sala de {npc:10508} y usa el {item:18688} en las mesas del laboratorio de alquimia de la derecha: {npc:14500} hace el pergamino. No hace falta matar a Ras, pero solo cuenta en este laboratorio y solo en grupo.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "Usa el {item:18688} en el laboratorio de alquimia de adentro",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "De vuelta con {npc:14437}, y luego {npc:14436} te da sus instrucciones. Cómprale a {npc:14437} el {item:18663} (150 de oro), la {item:18629} (50) y los {item:18670} (50); un amigo brujo que ya los tenga puede traer los suyos. Cada otro brujo que vaya a recargar los nodos necesita su propia piedra imán. Lleva 15 o más fragmentos de alma.",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "{item:18663}, 150 de oro",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "{item:18629}, 50 de oro",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "{item:18670}, 50 de oro",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "Adentro de La Masacre Oeste",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["{area:2577} stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "{area:2577} está en las ruinas del centro de {zone:1444}: desde la puerta al pie de las ruinas, sube por los patios exteriores hasta la puerta del ala oeste, en el extremo norte. Esa puerta y una puerta interior necesitan la {item:18249} (la suelta Pusillin en La Masacre Este) o un pícaro con 300 de Forzar cerraduras. Lleva un grupo de cinco. Baja el escudo de {npc:11496} matando a los guardianes de los cinco pilones (dos están en su propia sala), y luego mata a {npc:11496}: su estrado es el círculo de invocación. Descansa y renueva beneficios antes de empezar.",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "{npc:11496}, dentro del ala oeste",

	-- Step 17: The ritual
	["The ritual"] = "El ritual",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "Párate en el estrado y usa el {item:18663}: {npc:14500} coloca la Campana, la Rueda y la Vela. La Campana sana a los brujos, la Rueda protege al grupo, la Vela quema a los diablillos: ignora a los diablillos y mata a los guardias del terror (guardias viles élite, unos diez, a veces dos a la vez); Desterrar o Esclavizar ayudan. Asigna a un jugador cada nodo para vigilarlo: cuando uno se apaga, se inclina y suena, un brujo con piedra imán lo recarga, un lanzamiento de 3 segundos que cualquier golpe interrumpe (un {item:6265} cada vez), así que mantén a los atacantes lejos de ellos. Si fallan los tres, el ritual termina y empiezas de nuevo; mientras quede uno en pie, sobrevive incluso a que muera todo el grupo. Después de unos seis minutos brillan nueve símbolos y un vórtice rojo cierra el círculo: sal caminando y los demonios que queden desaparecen en su borde. Descansa y usa los {item:18670}. Mata al {npc:14502} (nivel 62, élite); a mitad de vida se une {npc:14506}, que pega fuerte y te empuja. Habla con el {npc:14504}: cada brujo del grupo que tenga esta misión puede vincularlo.",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "{item:18663}, en el estrado de {npc:11496}",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "{item:18670}, cuando el círculo esté completo",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:5520} en {object:2164} te manda con {quest:7562} en {zone:1428}.",
	-- ["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:5753} en {object:36082} te manda con {quest:7562} en {zone:1428}.",
	-- ["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:5815} en {object:172960} te manda con {quest:7562} en {zone:1428}.",
	-- ["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:6382} en {zone:1455} te manda con {quest:7562} en {zone:1428}.",
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Vuelve con {npc:14436} y entrega su {item:18591} a {npc:14437}, a su lado. Luego {npc:14436} pide tres piezas para el ritual y {npc:14437} te manda a {zone:1448}: cómprale dos Pociones enigmáticas a {npc:14437} para ese viaje.",
	-- ["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Vuelve con {npc:14437} con el polvo estelar. Te da el {item:18688} para {area:2057}.",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Vuelve con {npc:14437}; luego {npc:14436} te da sus instrucciones para el ritual. Cómprale a {npc:14437} el {item:18663}, la {item:18629} y los {item:18670}, y lleva diez o más Fragmentos de alma.",
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Gorzeeki quiere 10 Elixires de {spell:5896} ({skill:171}), 6 Fragmentos luminosos grandes ({item:14344}, {skill:333}), 25 {item:11370} ({skill:186}, en {area:1584} y {zone:1427}) y 35 Dragontinas negras ({item:15416}, {skill:393}, dracónidos negros de {zone:1428}). Fabrica o recolecta lo que te permitan tus profesiones; compra el resto en la casa de subastas.",
	-- ["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Entrega las tres piezas a {npc:14437}. Luego quiere 3 Barras de arcanita ({item:12360}): los alquimistas las transmutan, los demás las compran en la casa de subastas.",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Las lechubestias de {zone:1452} sueltan la sangre, más o menos una de cada tres: las Lechubestias pulgosas y enfurecidas ({npc:7451}) al oeste y alrededor de {area:2255}, y las enloquecidas, lunadón y de {spell:417141} en el este. Mientras cazas, empieza con los materiales del siguiente paso: la casa de subastas los tiene todos.",
	-- ["The ritual in {area:2577}"] = "El ritual en {area:2577}",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} está bajo {area:2298}, el pueblo de la isla al sureste de {zone:1422}: necesitas su llave o un pícaro para abrir la puerta, y la {item:13873} de Traquesangre para avanzar. Usa el {item:18688} en el laboratorio de alquimia de la sala de {npc:10508}; {npc:14500} hace el pergamino. Lleva un grupo.",
	-- ["Use the {item:18688} at the alchemy lab"] = "Usa el {item:18688} en el laboratorio de alquimia",
	-- ["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Tu montura épica a nivel 60: se invoca en cualquier lugar, sin gastar oro en un caballo épico.",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} está al oeste de {zone:1448}. Bebe una {item:18802} antes de entrar: los cultistas del Shadow Council se vuelven amistosos un rato, los demonios no. {quest:7623} espera en lo profundo de la {area:1770}, la cueva sobre {area:1763}, cruzando un puente en la gran cámara de raíces.",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} está en las ruinas del centro de {zone:1444}; el círculo del ritual está en su ala oeste, pasando a {npc:11496}, y la puerta requiere la {item:18249} o un pícaro. Usa el {item:18663} para empezar; cuando la campana, la rueda o la vela se apague, haz clic en ella con la {item:18629} (un {item:6265} cada vez). Cuando dejen de llegar demonios, usa los {item:18670}, derrota al {npc:14502} y a su amo señor del terror, y habla con el {npc:14504}. Lleva un grupo.",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} quiere 10 Elixires de poder de las Sombras ({skill:171}), 6 Fragmentos luminosos grandes ({item:14344}, {skill:333}), 25 {item:11370} ({skill:186}, en {area:1584} y {zone:1427}) y 35 Dragontinas negras ({item:15416}, {skill:393}, dracónidos negros de {zone:1428}). Fabrica o recolecta lo que te permitan tus profesiones; compra el resto en la casa de subastas.",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504}: se vincula contigo",
	-- ["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, junto a {quest:7623}, vende el {item:18687}; solo trata contigo mientras una {item:18802} esté activa. Lleva mucho oro.",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} espera en una cámara lateral junto a un puente, de camino a la salida. Habla con él y atacarán él y sus cuatro guardias; ninguno es élite. Lleva su corazón a {npc:9516}, y bebe otra poción si la primera se acabó.",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} y su goblin {npc:14437} acampan en el {area:255}, al noroeste de {zone:1428}, al oeste de {area:254}. La cadena es larga, cuesta oro con {npc:14437} y termina en dos calabozos.",
}
