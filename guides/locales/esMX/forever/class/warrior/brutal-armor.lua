-- Spanish (Latin America) (esMX): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Starts now at 20 at your trainer; four armor pieces at 30 (hauberk, helm, gauntlets, legguards), a shield on the way."] = "Empieza ahora, a nivel 20, con tu instructor; cuatro piezas de armadura a nivel 30 (cota, yelmo, guanteletes y musleras) y un escudo en el camino.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "A nivel 20, {npc:3354} en {object:172958} te manda con {npc:6394} en {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "A nivel 20, {npc:3041}, el instructor de guerreros de {zone:1456}, te manda con {npc:6394} en {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "A nivel 20, {npc:4595}, un instructor de guerreros de {zone:1458}, te manda con {npc:6394} en {area:378}.",

	-- Step 4: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Fly to {area:378}. {npc:6394} stands in the hut with the leatherworking and tailoring trainers."] = "Vuela a {area:378}. {npc:6394} está en la choza con los instructores de peletería y sastrería.",

	-- Step 5: Trial at the Field of Giants
	-- {item:7119} Twitching Antenna · {area:390} Field of Giants · {area:378} Camp Taurajo · {item:7120} Ruga's Bulwark
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["You have 30 minutes, and each {item:7119} rots 15 minutes after you loot it, so take the quest only when ready (logging out does not stop the clock). The Silithid Mounds dot the {area:390} south of {area:378}; every silithid drops an antenna. Creepers (level 20-21) and Grubs are the easiest: Swarmers (21-22) call small swarms and Creepers lay eggs that hatch adds. The eastern part of the field has plenty of Creepers. {item:7120}, a shield, is the reward."] = "Tienes 30 minutos, y cada {item:7119} se pudre 15 minutos después de saquearla, así que toma la misión solo cuando estés listo (desconectarte no detiene el reloj). Los montículos de silítidos salpican {area:390} al sur de {area:378}; todos los silítidos sueltan una antena. Los reptadores (nivel 20-21) y las larvas son los más fáciles: los enjambradores (21-22) llaman pequeños enjambres y los reptadores ponen huevos de los que salen refuerzos. La parte este del campo tiene muchos reptadores. La recompensa es {item:7120}, un escudo.",
	-- {item:7119} Twitching Antenna
	["{item:7119}, from the silithid"] = "{item:7119}, de los silítidos",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1838} Brutal Armor · {item:7587} Thun'grim's Instructions
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads: climb the broad ridge on the north or east side. {quest:1838} is a level 30 quest; take it now and gather on the way. {item:7587} list where each material comes from."] = "La choza de {npc:5878} está en lo alto de {area:1699}, al este del Cruce: sube por la cresta ancha del lado norte o este. {quest:1838} es una misión de nivel 30; tómala ahora y junta los materiales en el camino. {item:7587} dice de dónde sale cada material.",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {spell:116} Frostbolt
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["You need 15 Smoky Iron Ingots. The {area:2160} lies at the east end of {area:461}, east of {area:460}; every Windshear kobold (level 19-23) drops an ingot four kills in five. Stonecutters, Geomancers and Overlords run for help when low; Geomancers cast {spell:116}."] = "Necesitas 15 Lingotes de hierro humeante. {area:2160} está en el extremo este de {area:461}, al este de {area:460}; los kóbolds Cizalla (nivel 19-23) sueltan un lingote cuatro de cada cinco veces. Los picapedreros, geomantes y señores supremos huyen a pedir ayuda con poca salud; los geomantes lanzan {spell:116}.",
	-- {item:7126} Smoky Iron Ingot
	["{item:7126}, from the Windshear kobolds"] = "{item:7126}, de los kóbolds Cizalla",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Mineros de Trabalomas ({npc:2269})",
	-- {item:7127} Powdered Azurite · {area:271} Southshore · {spell:71} Defensive Stance · {area:272} Tarren Mill
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["You need 10 {item:7127}. The guide waits for level 25 first. The Hillsbrad Miners (level 26-27) work the mine in the hills west of {area:271} and drop the azurite four kills in five; they fight in {spell:71}, sunder your armor and run for help at 30% health. Fly to {area:272} and head south-west."] = "Necesitas 10 {item:7127}. La guía espera primero al nivel 25. Los Mineros de Trabalomas (nivel 26-27) trabajan en la mina de las colinas al oeste de {area:271} y sueltan la azurita en cuatro de cada cinco muertes; pelean en {spell:71}, te hienden la armadura y huyen en busca de ayuda al 30% de salud. Vuela a {area:272} y dirígete al suroeste.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127}, from the Hillsbrad Miners"] = "{item:7127}, de los mineros de Trabalomas",

	-- Step 9: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug en {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, his guards come with him. The guide waits for level 26 first. Inside take the left path at the first fork, cross the vine bridge over the pig pens, go past the room with the big cauldron: he waits in the room on the right. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Roogug es un jabaespín élite (nivel 28) dentro de {area:1717}, el calabozo del extremo sur de {zone:1413}; un calabozo para cinco jugadores: requiere un grupo de cinco, sus guardias vienen con él. La guía espera primero al nivel 26. Adentro, toma el camino de la izquierda en la primera bifurcación, cruza el puente de lianas sobre los chiqueros y pasa la sala del gran caldero: espera en la sala de la derecha. Lanza {spell:403} e invoca estruendores de tierra. El vial siempre cae.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, de Roogug",

	-- Step 10: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Barras de hierro",
	-- {item:2772} Iron Ore · {spell:3307} Smelt Iron · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["You need 10 Iron Bars. Miners smelt them from {item:2772} (one ore a bar, {spell:3307} at {skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Necesitas 10 Barras de hierro. Los mineros las funden con {item:2772} (un mineral por barra, {spell:3307} con {skill:186} 125); los demás las compran en la casa de subastas de {zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Barras de hierro: {npc:8673}",

	-- Step 11: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} on {area:1699}. {quest:1848} is the first piece; he then sends you to three crafters, one per piece: take all three."] = "De vuelta con {npc:5878} en {area:1699}. {quest:1848} es la primera pieza; después te manda con tres artesanos, uno por pieza: toma las tres.",

	-- Step 12: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast. He wants 7 Uncloven Satyr Hooves."] = "{npc:6408} está en {area:367}, en la costa de {zone:1411}. Quiere 7 Pezuñas de sátiro sin hender.",

	-- Step 13: Satyr Hooves
	-- {area:430} Satyrnaar · {area:431} Splintertree Post · {area:429} Xavian · {spell:6925} Gift of the Xavian
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The satyrs of {area:430}, north-east of {area:431} ({area:429}, level 28-30), and the Felmusk satyrs north-west of the post (25-27) drop a hoof four kills in five. A {area:429} satyr at 15% health may cast {spell:6925} and heal to full: finish it fast or stun it. Hellcallers throw Fireballs from 40 yards; Felmusk satyrs reek in melee and run for help at 15%."] = "Los sátiros de {area:430}, al noreste de {area:431} ({area:429}, nivel 28-30), y los sátiros Almizcle Vil al noroeste del puesto (25-27) sueltan una pezuña cuatro de cada cinco veces. Un sátiro de {area:429} al 15 % de salud puede lanzar {spell:6925} y curarse por completo: remátalo rápido o atúrdelo. Los clamainfiernos lanzan bolas de fuego desde 40 m; los sátiros Almizcle Vil apestan cuerpo a cuerpo y huyen a pedir ayuda al 15 %.",

	-- Step 15: Orm Stonehoof
	-- {npc:6410} Orm Stonehoof · {zone:1456} Thunder Bluff
	["{npc:6410} works on {zone:1456}'s lowest level, close to the blacksmith."] = "{npc:6410} trabaja en el nivel más bajo de {zone:1456}, cerca del herrero.",

	-- Step 16: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {area:465} Charred Vale · {zone:1443} Desolace · {item:6840} Galvanized Horn · {spell:3396} Corrosive Poison
	["The {npc:6167} (level 28, not elite, larger than the young ones around her) roams the south edge of the {area:465} in south-west Stonetalon, near the road to {zone:1443}. She is the only one: she returns 5 minutes after dying and drops the {item:6840} four kills in five. She spits {spell:3396} from 30 yards."] = "La {npc:6167} (nivel 28, no élite, más grande que las jóvenes que la rodean) recorre el borde sur de {area:465}, en el suroeste de Sierra Espolón, cerca del camino a {zone:1443}. Es la única: vuelve 5 minutos después de morir y suelta {item:6840} cuatro de cada cinco veces. Escupe {spell:3396} desde 30 m.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, de la {npc:6167}",

	-- Step 18: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {npc:6411} Velora Nitely · {zone:1458} Undercity · {object:36078} Trade Quarter
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Take the zeppelin from {zone:1454} to {zone:1420}; {npc:6411} works in the {zone:1458}'s {object:36078}. She wants 8 Sturdy Dragonmaw Shinbones."] = "Toma el zepelín de {zone:1454} a {zone:1420}; {npc:6411} trabaja en {object:36078} de {zone:1458}. Quiere 8 Espinillas Faucedraco robustas.",

	-- Step 19: Dragonmaw Shinbones
	-- {zone:1437} Wetlands · {area:321} Hammerfall · {area:881} Thandol Span · {area:150} Menethil Harbor · {quest:1846} Dragonmaw Shinbones · {npc:6411} Velora Nitely · {item:7131} Dragonmaw Shinbone · {spell:686} Shadow Bolt
	["The Dragonmaw orcs (level 26-30) camp in the middle of the {zone:1437}; from {area:321} in Arathi head south over the {area:881} ({area:150} is Alliance). With {quest:1846} from {npc:6411} in your log, every Raider, Swamprunner, Centurion, Shadowwarder and Bonewarder drops a {item:7131} (without the quest they drop none): right-click it to test it, and about one in four comes out sturdy, the rest break, so expect 30 or more kills for 8. You can test while moving or fighting. The orcs run for help at 15%; Raiders net you, Centurions shield-bash, Shadowwarders cast {spell:686}, Bonewarders raise skeletons."] = "Los orcos Faucedraco (nivel 26-30) acampan en medio de {zone:1437}; desde {area:321} en Arathi, ve al sur por {area:881} ({area:150} es de la Alianza). Con {quest:1846} de {npc:6411} en tu registro, cada Asaltante, Correpantanos, Centurión, Depositario de sombras y Guardahuesos suelta una {item:7131} (sin la misión no sueltan ninguna): haz clic derecho en ella para probarla; más o menos una de cada cuatro sale robusta y las demás se rompen, así que cuenta con 30 muertes o más para conseguir 8. Puedes probarlas mientras te mueves o peleas. Los orcos huyen en busca de ayuda al 15%; los Asaltantes te lanzan redes, los Centuriones golpean con el escudo, los Depositarios de sombras lanzan {spell:686} y los Guardahuesos alzan esqueletos.",
	["from the Dragonmaw orcs: right-click to test it"] = "de los orcos Faucedraco: haz clic derecho para probarla",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "Vuelve con {npc:5878} junto al camino al este de {area:380}. {quest:1848} es la primera pieza; luego te manda con tres artesanos para el resto.",
	-- ["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Vuela a {area:378}. Al sur del campamento, los Montículos de silítidos salpican la {area:390}: los silítidos de ahí llevan las Antenas agitadas.",
	-- ["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Cuatro piezas de armadura a nivel 30 (camisote, yelmo, guanteletes, musleras) y un escudo por el camino.",
	-- ["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Los mineros funden Barras de hierro con {item:2772} ({skill:186} 125); los demás las compran en la casa de subastas de {zone:1454}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug es un jabaespín élite dentro de {area:1717}, el calabozo del extremo sur de {zone:1413}; suelta el {item:6841}. {area:1717} es un calabozo: se recomienda ir en grupo.",
	-- ["Smoky Iron Ingots from the Windshear kobolds"] = "Lingotes de hierro humeante de los kóbolds Cortaviento",
	-- ["Sturdy Dragonmaw Shinbones"] = "Tibias de Faucedraco robustas ({item:7134})",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Toma el zepelín de {zone:1454} a {zone:1420}; {zone:1458} está bajo las {area:153}.",
	-- ["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Los orcos Faucedraco acampan en medio de {zone:1437}, al sur del camino; Asaltantes, Correpantanos, Centuriones, Depositarios de sombras y Guardahuesos sueltan las Tibias de Faucedraco robustas ({item:7134}).",
	-- ["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Los Mineros de Trabalomas ({npc:2269}) trabajan en la mina del oeste de {zone:1424}; sueltan la {item:7127}. Toma el zepelín de {zone:1454} a {zone:1420} y cabalga al sur por {zone:1421}.",
	-- ["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "La {area:2160} está en el extremo este del {area:461}, en Sierra Espolón. Sus kóbolds sueltan los Lingotes de hierro humeante.",
	-- ["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Los sátiros de {area:429} acampan en el este de {zone:1440}, con los sátiros Putredor más al oeste; ambos sueltan Pezuñas de sátiro sin rajar.",
	-- ["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "La {npc:6167} recorre el suroeste de Sierra Espolón cerca de las Quimeras volantonas y las Quimeras jóvenes; suelta el {item:6840}.",
	-- ["Twitching Antennae from the silithid"] = "Antenas agitadas de los silítidos",
	-- ["Uncloven {quest:1842}"] = "{quest:1842} sin rajar",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} de la {npc:6167}",
	-- ["{item:7127} from the Hillsbrad Miners"] = "{item:7127} de los Mineros de Trabalomas ({npc:2269})",
	-- ["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} acampa junto al camino al este de {area:380}. {quest:1838} es una misión de nivel 30; puedes aceptarla ya y reunir lo necesario por el camino.",
	-- ["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} está en {area:367}, en la costa de {zone:1411}.",
}
