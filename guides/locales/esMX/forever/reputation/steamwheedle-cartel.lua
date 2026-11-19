-- Spanish (Latin America) (esMX): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "Reputación con el Cártel Bonvapor",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "Todos los pueblos goblin a la vez: los gigantes electrocutados de {npc:14637} y los grilletes de {npc:14338}, y luego cinco intendentes nuevos y sus sombreros.",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Los intendentes goblin de Forever: equipo para los niveles 20 a 50 en Amistoso y Honorable",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "Cinco pueblos goblin comparten una familia de reputación, el Cártel Bonvapor: {faction:470}, {faction:21}, {faction:369}, {faction:577} y el nuevo {faction:2827} de Forever en {zone:2548}. Todos empiezan en Neutral con cada uno (500 adentro). Lo que ganas con un pueblo da a los otros la mitad; una misión para el propio Cártel, como las de {npc:14637}, paga completo a cada pueblo. Las pérdidas se reparten igual: un {npc:4624} o cualquier goblin de los pueblos cuesta 125 (la mitad con los otros pueblos), y la reputación con los Bucaneros Velasangre solo se gana así. {npc:14637} acampa en el camino que cruza el centro de {zone:1444} y trabaja para cualquiera, incluso para los jugadores que los goblins odian. Sus dos primeras misiones son de nivel 48 y abren sus repetibles (nivel 55); Forever las paga todas completas a cualquier nivel.",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}: 150 con cada pueblo",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}: 150 con cada pueblo",

	-- Step 2: Zapped giants
	["Zapped giants"] = "Gigantes encogidos",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "Usa {item:18904} en un gigante vivo ({npc:5357}, {npc:5358}, o un zancudo de la costa, de las profundidades o {npc:5361}, nivel 47-50) y se encoge en una versión electrocutada; mátala por su {item:18956}, uno siempre. Los caminantes de la tierra y gigantes de los riscos de las colinas del noroeste son los más abundantes; los zancudos caminan por la costa y las aguas bajas. El encogedor dura dos horas: si se acaba, abandona la misión y vuelve a tomarla.",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}, en un gigante vivo",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}, de los gigantes electrocutados",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "Elementales marinos y espumas marinas",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "Los elementales marinos y espumas marinas (nivel 47-49) flotan a lo largo de {area:1108} y en las aguas bajas debajo de los gigantes: más o menos la mitad suelta un {item:18958}.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}: elementales marinos y espumas marinas",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "De vuelta con {npc:14637}",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "Desde ahora {npc:14637} ofrece {quest:7725} (10 residuos) y {quest:7726} (6 núcleos), una y otra vez: 25 de reputación con cada pueblo cada vez.",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}, por debajo del 56",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "Los piratas de los Mares del Sur de {area:1336} (nivel 44-45), en la costa este de {zone:1446}, dan 5 cada uno con {faction:369} hasta el final de Honorable, y la mitad a los otros pueblos. Dos misiones en {area:977} pagan 100 con {faction:369} cada una: {quest:8366} (10 de cada pirata) y {quest:8365} (20 sombreros de pirata de los Mares del Sur, uno de cada diez piratas). Desde el nivel 56 los piratas son grises y pagan poco: entonces sáltate este paso.",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{npc:10267}, una goblin en {area:251}, en el norte de {zone:1428}, tiene una cadena que paga 150 a cada pueblo y 150 más con {faction:577}. Usa su {item:12284} en una cría, mátala mientras el aparato la retiene y recoge la {quest:4726} que deja. El aparato solo sirve con crías negras y abrasadoras, no con las crías Escamafuego del oeste: las crías abrasadoras (nivel 53-54) recorren justo al oeste y al este de {area:251}, las crías negras (51-52) la esquina noreste de la zona, el grupo más abundante. Son pocas y están dispersas: el camino pasa por ambas y termina entre las crías negras.",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "Crías abrasadoras al oeste de {area:251}",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "Crías abrasadoras al este de {area:251}",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "Crías negras en el noreste",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}, en una cría negra o {npc:7048}",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}, que dejan las crías",
	["100 to every town"] = "100 con cada pueblo",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808} está en {faction:577}. Las quimeras Viento Helado (nivel 55-57) al suroeste de {faction:577} sueltan los cuernos una vez de cada cinco.",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}: quimeras Viento Helado",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "De vuelta con {npc:10267}",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810} da 50 a cada pueblo. Sus misiones posteriores, Congelar huevos (150 a cada pueblo) y Recolección de huevos (200), se hacen en el Criadero de la Cumbre de Roca Negra superior, una mazmorra de diez jugadores: tómalas con tu grupo.",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "La Masacre Norte: {npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338} está encadenado en La Masacre Norte, el ala de los ogros Gordok (una mazmorra de cinco jugadores desde el nivel 57: agrúpate). Cada {item:18250} lo libera una vez: 150 a cada pueblo, y vuelve a estar encadenado en tu siguiente pasada. Los ogros Gordok sueltan las llaves (más o menos una de cada quince; {npc:14321} una de cada siete): una pasada completa del ala suele dar una. Su {item:18258} paga 100 la primera vez y 50 después, por 4 rollos de paño rúnico, 8 {item:8170}, 2 {item:14341} y el {item:18240} de la canasta del ala. ¿Por debajo de 57 cuando llegas aquí? Vuelve a activar este paso más tarde.",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}, ogros Gordok",
	-- {quest:5525} Free Knot! · {npc:14338} Knot Thimblejack
	["{quest:5525}: 150 to every town, handed in from {npc:14338}'s window"] = "{quest:5525}: 150 con cada ciudad, se entrega desde la ventana de {npc:14338}",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}, otra vez en cada pasada posterior: 150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "Cada pueblo hasta Amistoso",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "De Neutral 500 a Amistoso son 2.500 con cada pueblo. Las misiones de arriba pagan a cada pueblo hasta 700 (las dos de {npc:14637} 300, la de {npc:10267} 150, la primera ¡Libera a Knot! 150 y el primer traje de ogro 100); las repetibles de {npc:14637} hacen el resto, 25 a cada pueblo cada una: 10 residuos (diez gigantes) o 6 núcleos (unos doce elementales). Las misiones propias de los pueblos también cuentan, y cada una da la mitad a los otros pueblos: las de {faction:470} en {zone:1413} (niveles 10-25, unos 4.300: la cadena del Samofalanje 625, los encargos de {npc:3446}, las escoltas de Wizzlecrank y Gilthares 150 cada una), las de {faction:21} en Tuercespina, Arathi y {zone:1418} (30-50, unos 6.500: los tres rescates de robots OOX 250 cada uno, Un OOX propio 200, La fiebre de Tuercespina 200, Enfrentar a Negolash 200, la cadena del Tesoro hundido en {area:327}), las de {faction:369} en {zone:1446} (43-55, unos 3.000: el {item:8548} 200, Justicia Vagayermos 100 cada una, los carteles de SE BUSCA) y las de {faction:577} en {zone:1452} (52-60, unos 1.450: la cadena Nevada de {npc:9298}, las misiones de yetis de Umi). Forever agrega algunas de nivel bajo: Una tormenta a fuego lento y Potencial tormentoso en {zone:1411} y SE BUSCA: Bruuz ({faction:470} 100 cada una), Reliquias familiares importantes en {zone:1455} ({faction:369} 100). Forever las paga completas a cualquier nivel. Las muertes ayudan mientras no sean grises, 5 cada una: los piratas de los Mares del Sur en {zone:1413} para {faction:470} y en {zone:1446} para {faction:369}, y los campamentos de Ventura y Cía. de Tuercespina para {faction:21}, hasta el final de Honorable; los bandidos Vagayermos para {faction:369} y los piratas Velasangre para {faction:21} solo hasta el final de Neutral. Amistoso abre el primer equipo de cada intendente.",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}: 10 residuos",
	["25 to every town"] = "25 a cada pueblo",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}: 6 núcleos",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "Cada pueblo hasta Honorable",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "De Amistoso a Honorable son 6.000: 240 entregas a {npc:14637}, o 40 pasadas de ¡Libera a Knot!, o una combinación. No se puede acumular nada: los residuos y núcleos solo caen mientras su misión está en tu registro, y solo puedes llevar una {item:18250} a la vez, así que entrega cada una antes de la siguiente pasada. Honorable abre los objetos azules de cada intendente.",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "Cada pueblo hasta Reverenciado",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "De Honorable a Reverenciado son 12.000 más: 480 entregas a {npc:14637} (4.800 residuos) u 80 pasadas de ¡Libera a Knot!. Reverenciado abre los cinco sombreros cosméticos, el motivo por el que la mayoría de los jugadores hace esto. El Diplomático del Legado suma hasta un 10%.",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}, el intendente de {faction:470}, junto a los muelles. Amistoso, equipo de nivel 20: {item:274740} 41s (Aguante, Agilidad), {item:274741} 54s (Aguante, poder con hechizos), {item:274742} 34s (Intelecto, Agilidad). Honorable: {item:274743}, una mano izquierda, 66s (Intelecto, Espíritu); {item:274744}, una maza de una mano, 1g 65s (Aguante, Fuerza). Reverenciado: el {item:274021}, un sombrero cosmético, 2g.",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}, Amistoso",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}, Amistoso",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}, Amistoso",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}, Honorable",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}, Honorable",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}, Reverenciado",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}, el intendente de {faction:21}. Amistoso, equipo de nivel 30: {item:274745} 1g 10s (Fuerza, Agilidad), {item:274746} 1g 48s (sanación y daño con hechizos), {item:274747} 1g 3s (Intelecto, Espíritu). Honorable: {item:274748}, un arma de fuego, 3g 11s (poder de ataque, Aguante); {item:274749}, un collar, 1g 66s (regeneración de salud, Aguante). Reverenciado: {item:274022}, 5g.",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}, Amistoso",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}, Amistoso",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}, Amistoso",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}, Honorable",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "{item:274749}, Honorable",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}, Reverenciado",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}, el intendente de {faction:369}. Amistoso, equipo de nivel 40: {item:274750} 2g 74s (Intelecto, sanación, daño con hechizos), {item:274751} 2g 94s (Agilidad, poder de ataque), {item:274752}, una capa, 2g 36s (Espíritu, poder con hechizos). Honorable: {item:274753}, un arma de una mano, 9g 46s (Fuerza, Agilidad); {item:274754}, un anillo, 3g 80s (Fuerza, Aguante). Reverenciado: la {item:274023}, 10g.",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}, Amistoso",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}, Amistoso",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}, Amistoso",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}, Honorable",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}, Honorable",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}, Reverenciado",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}, el intendente de {faction:577}. Amistoso, equipo de nivel 50: {item:274755} 3g 10s (Espíritu, Intelecto), {item:274756} 5g 84s (Agilidad, Aguante, resistencia a la escarcha), {item:274757} 4g 68s (Agilidad, poder de ataque), {item:274758}, una pechera, 10g 96s (Fuerza, Aguante). Honorable, tres abalorios a unos 7g 55s: {item:274759} (resistencia a la naturaleza), {item:274760} (resistencia a la escarcha) y {item:274761} (resistencia a las sombras), los dos últimos con un uso. Reverenciado: {item:274024}, 25g.",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}, Amistoso",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}, Amistoso",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}, Amistoso",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}, Amistoso",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}, Honorable",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}, Honorable",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}, Honorable",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}, Reverenciado",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897} vende las recompensas de {faction:2827} en {area:16727}, en la costa este de {zone:2548}, junto con artículos generales. Amistoso, equipo de nivel 40: {item:276200} 2g 74s (Aguante, poder de ataque), {item:276201} 2g 94s (Intelecto, Espíritu), {item:276202} 2g 36s (Agilidad, Espíritu). Honorable: {item:276203}, un arma de dos manos, 9g 46s (Aguante, Fuerza, Agilidad); {item:276204}, un escudo, 3g 80s (Aguante, daño con hechizos, sanación). Reverenciado: {item:276199}, 10g.",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}, Amistoso",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}, Amistoso",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}, Amistoso",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}, Honorable",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}, Honorable",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}, Reverenciado",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "Cada pueblo hasta Exaltado",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "De Reverenciado a Exaltado son 21.000 más con cada pueblo: 840 entregas a {npc:14637} o 140 pasadas de ¡Libera a Knot!. Ningún intendente vende nada para Exaltado: es solo para la barra de títulos.",
}
