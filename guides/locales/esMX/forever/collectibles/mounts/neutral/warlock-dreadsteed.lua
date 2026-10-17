-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Corcelorror de brujo",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Tu montura épica a nivel 60: se invoca en cualquier lugar, sin gastar oro en un caballo épico.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:5520} en {object:2164} te manda con {quest:7562} en {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:6382} en {zone:1455} te manda con {quest:7562} en {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:5815} en {object:172960} te manda con {quest:7562} en {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "A nivel 60, {npc:5753} en {object:36082} te manda con {quest:7562} en {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} y su goblin {npc:14437} acampan en el {area:255}, al noroeste de {zone:1428}, al oeste de {area:254}. La cadena es larga, cuesta oro con {npc:14437} y termina en dos calabozos.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Las lechubestias de {zone:1452} sueltan la sangre, más o menos una de cada tres: las Lechubestias pulgosas y enfurecidas ({npc:7451}) al oeste y alrededor de {area:2255}, y las enloquecidas, lunadón y de {spell:417141} en el este. Mientras cazas, empieza con los materiales del siguiente paso: la casa de subastas los tiene todos.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Vuelve con {npc:14436} y entrega su {item:18591} a {npc:14437}, a su lado. Luego {npc:14436} pide tres piezas para el ritual y {npc:14437} te manda a {zone:1448}: cómprale dos Pociones enigmáticas a {npc:14437} para ese viaje.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "te da la {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, de {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Las piezas del ritual",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} quiere 10 Elixires de poder de las Sombras ({skill:171}), 6 Fragmentos luminosos grandes ({item:14344}, {skill:333}), 25 {item:11370} ({skill:186}, en {area:1584} y {zone:1427}) y 35 Dragontinas negras ({item:15416}, {skill:393}, dracónidos negros de {zone:1428}). Fabrica o recolecta lo que te permitan tus profesiones; compra el resto en la casa de subastas.",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Entrega las tres piezas a {npc:14437}. Luego quiere 3 Barras de arcanita ({item:12360}): los alquimistas las transmutan, los demás las compran en la casa de subastas.",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} está al oeste de {zone:1448}. Bebe una {item:18802} antes de entrar: los cultistas del Shadow Council se vuelven amistosos un rato, los demonios no. {quest:7623} espera en lo profundo de la {area:1770}, la cueva sobre {area:1763}, cruzando un puente en la gran cámara de raíces.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} espera en una cámara lateral junto a un puente, de camino a la salida. Habla con él y atacarán él y sus cuatro guardias; ninguno es élite. Lleva su corazón a {npc:9516}, y bebe otra poción si la primera se acabó.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, junto a {quest:7623}, vende el {item:18687}; solo trata contigo mientras una {item:18802} esté activa. Lleva mucho oro.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, de {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Vuelve con {npc:14437} con el polvo estelar. Te da el {item:18688} para {area:2057}.",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} está bajo {area:2298}, el pueblo de la isla al sureste de {zone:1422}: necesitas su llave o un pícaro para abrir la puerta, y la {item:13873} de Traquesangre para avanzar. Usa el {item:18688} en el laboratorio de alquimia de la sala de {npc:10508}; {npc:14500} hace el pergamino. Lleva un grupo.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "Usa el {item:18688} en el laboratorio de alquimia",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Vuelve con {npc:14437}; luego {npc:14436} te da sus instrucciones para el ritual. Cómprale a {npc:14437} el {item:18663}, la {item:18629} y los {item:18670}, y lleva diez o más Fragmentos de alma.",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "El ritual en {area:2577}",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} está en las ruinas del centro de {zone:1444}; el círculo del ritual está en su ala oeste, pasando a {npc:11496}, y la puerta requiere la {item:18249} o un pícaro. Usa el {item:18663} para empezar; cuando la campana, la rueda o la vela se apague, haz clic en ella con la {item:18629} (un {item:6265} cada vez). Cuando dejen de llegar demonios, usa los {item:18670}, derrota al {npc:14502} y a su amo señor del terror, y habla con el {npc:14504}. Lleva un grupo.",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504}: se vincula contigo",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Gorzeeki quiere 10 Elixires de {spell:5896} ({skill:171}), 6 Fragmentos luminosos grandes ({item:14344}, {skill:333}), 25 {item:11370} ({skill:186}, en {area:1584} y {zone:1427}) y 35 Dragontinas negras ({item:15416}, {skill:393}, dracónidos negros de {zone:1428}). Fabrica o recolecta lo que te permitan tus profesiones; compra el resto en la casa de subastas.",
}
