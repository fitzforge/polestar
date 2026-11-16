-- Spanish (Latin America) (esMX): the guide forever/class/shaman/call-of-water-horde (forever/class/shaman/call-of-water-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:63} Call of Water
	["{quest:63} (Horde)"] = "{quest:63} (Horda)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "{item:5177}, que te permite colocar tótems de agua, y con él {spell:5394}.",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {area:362} Razor Hill
	["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}. (Swart in {area:362} gives the same letter: carry either.)"] = "A nivel 20, {npc:5892}, en {object:172957}, te manda con {npc:5901} en {zone:1413}. (Swart, en {area:362}, da la misma carta: lleva cualquiera de las dos.)",

	-- Step 2: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5901} Islen Waterseer · {zone:1413} Barrens · {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village
	["At 20 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5901} in the {zone:1413}. ({npc:3066} in {area:222} gives the same letter: carry either.)"] = "A nivel 20, {npc:5906}, un instructor de chamanes en {area:1640} en {zone:1456}, te manda con {npc:5901} en {zone:1413}. ({npc:3066}, en {area:222}, da la misma carta: lleva cualquiera de las dos.)",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} is not in {area:392}: take the small coast road south from {area:392} past the pirate camp and over a low hill; her fishing hut, with a shark strung up outside, stands by the water before the pirate ship. If you reach the ship you went too far."] = "{npc:5901} no está en {area:392}: toma el caminito de la costa al sur desde {area:392}, pasando el campamento pirata y cruzando una colina baja; su choza de pesca, con un tiburón colgado afuera, está junto al agua antes del barco pirata. Si llegas al barco, te pasaste.",

	-- Step 4
	-- {npc:5901} Islen Waterseer · {npc:5892} Searn Firewarder
	["{npc:5901}: {npc:5892}'s letter"] = "{npc:5901}: la carta de {npc:5892}",

	-- Step 5
	-- {npc:5901} Islen Waterseer · {npc:5906} Xanis Flameweaver
	["{npc:5901}: {npc:5906}' letter"] = "{npc:5901}: la carta de {npc:5906}",

	-- Step 6
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Swart's letter"] = "{npc:5901}: la carta de Swart",

	-- Step 7
	-- {npc:5901} Islen Waterseer
	["{npc:5901}: Narm's letter"] = "{npc:5901}: la carta de Narm",

	-- Step 9: Brine
	-- {npc:5899} Brine · {zone:1413} Barrens · {area:378} Camp Taurajo · {area:1701} Blackthorn Ridge
	["{npc:5899} lives in the southern {zone:1413}, south of {area:378}: her hut sits on a hilltop of {area:1701} with a spinning windmill beside it, and the way up is the ridge by the lone tree. Quilboar camp all around the hill; Stormhides, thunderhawks and hyenas roam the plains on the way."] = "{npc:5899} vive en el sur de {zone:1413}, al sur de {area:378}: su choza está en lo alto de una colina de {area:1701} con un molino girando al lado, y la subida es la cresta junto al árbol solitario. Hay campamentos de jabaespines alrededor de toda la colina; en el camino, por las llanuras rondan pieltormentas, halcones del trueno y hienas.",

	-- Step 10: The Quilboar Watering Hole
	-- {object:107046} Quilboar Watering Hole
	["The {object:107046}"] = "{object:107046}",
	-- {npc:5899} Brine · {item:7766} Empty Brown Waterskin · {npc:3456} Razormane Pathfinder
	["The muddy pond below {npc:5899}'s hut. Step right into the puddle before you use the {item:7766} (too far away and it refuses). Filling it calls a hostile {npc:3456} (level 20): kill it, and watch for the quilboar hunter by the pond, who may start shooting afterwards."] = "La charca embarrada debajo de la choza de {npc:5899}. Métete en el charco antes de usar {item:7766} (demasiado lejos y no funciona). Llenarlo llama a un {npc:3456} hostil (nivel 20): mátalo, y cuidado con el cazador jabaespín junto a la charca, que puede empezar a disparar después.",
	-- {item:7766} Empty Brown Waterskin
	["{item:7766}, standing in the puddle"] = "{item:7766}, parado en el charco",

	-- Step 12: The Spring Well
	-- {object:107045} Spring Well
	["The {object:107045}"] = "{object:107045}",
	-- {object:107045} Spring Well · {area:272} Tarren Mill · {zone:1413} Barrens · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {item:7768} Empty Red Waterskin
	["The {object:107045} stands in the middle of {area:272}, just outside the church. From the {zone:1413}: the zeppelin from {zone:1454} to {zone:1420}, then south past the {zone:1458} and through {zone:1421} (or fly once you have the {area:272} flight path). {area:287} is contested: Alliance players may attack. Stand beside the well and use the {item:7768}."] = "{object:107045} está en el centro de {area:272}, justo afuera de la iglesia. Desde {zone:1413}: el zepelín de {zone:1454} a {zone:1420}, luego al sur pasando {zone:1458} y por {zone:1421} (o vuela cuando tengas la ruta de vuelo de {area:272}). {area:287} es territorio en disputa: los jugadores de la Alianza pueden atacar. Párate junto al pozo y usa {item:7768}.",
	-- {item:7768} Empty Red Waterskin
	["{item:7768}, beside the well"] = "{item:7768}, junto al pozo",

	-- Step 14: The Ruins of Stardust
	-- {area:415} Astranaar · {zone:1413} Barrens · {area:1703} Mor'shan Rampart · {npc:12836} Wandering Protector · {zone:1440} Ashenvale · {item:7767} Empty Blue Waterskin
	["The right fountain stands in a ring of standing stones on the island of the small green lake south of {area:415}, west of Lake Mystral (not the island in Lake Mystral itself). From the {zone:1413} take the road north through the {area:1703} and on west. Water elementals and walking treants guard the lake and root you in place; an elite {npc:12836} roams {zone:1440} and can pass close by. Use the {item:7767} beside the fountain."] = "La fuente correcta está en un anillo de piedras erguidas en la isla del lago verde pequeño al sur de {area:415}, al oeste del lago Mystral (no en la isla del lago Mystral). Desde {zone:1413}, toma el camino al norte por {area:1703} y sigue al oeste. Elementales de agua y antárboles errantes custodian el lago y te enraízan; un {npc:12836} élite recorre {zone:1440} y puede pasar cerca. Usa {item:7767} junto a la fuente.",
	-- {item:7767} Empty Blue Waterskin
	["{item:7767}, beside the fountain"] = "{item:7767}, junto a la fuente",

	-- Step 15: Brine
	-- {npc:5899} Brine · {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["Back to {npc:5899}. She gives you the {item:7810} for {npc:5901}."] = "De vuelta con {npc:5899}. Te da {item:7810} para {npc:5901}.",
	-- {item:7810} Vial of Purest Water · {npc:5901} Islen Waterseer
	["the {item:7810}, for {npc:5901}"] = "{item:7810}, para {npc:5901}",

	-- Step 16: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water
	["{npc:5901} hands you the {item:6637} and the {item:7811}: take everything she offers before you leave for Silverpine, or you will be back for more."] = "{npc:5901} te da {item:6637} y {item:7811}: toma todo lo que te ofrezca antes de salir hacia Bosque de Argénteos, o vas a tener que volver por más.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}"] = "{npc:5901}: tu {item:6637}",

	-- Step 17: Lost the Water Sapta?
	-- {quest:972} Water Sapta
	["Lost the {quest:972}?"] = "¿Perdiste {quest:972}?",
	-- {quest:972} Water Sapta · {npc:5901} Islen Waterseer
	["Only if the {quest:972} is gone from your bags: {npc:5901} gives you another."] = "Solo si {quest:972} ya no está en tus bolsas: {npc:5901} te da otro.",
	-- {npc:5901} Islen Waterseer · {quest:972} Water Sapta
	["{npc:5901}: a new {quest:972}"] = "{npc:5901}: un {quest:972} nuevo",

	-- Step 18: The Brazier of Everfount
	-- {object:113791} Brazier of Everfount
	["The {object:113791}"] = "{object:113791}",
	-- {area:228} Sepulcher · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {spell:8056} Frost Shock · {spell:122} Frost Nova
	["Fly to the {area:228}. The shrine lies in a hollow just south-west of it: go round the back of the crypt to the thick tree between the two hills, hop past it onto the rocks and drop west down the slope to the pool (each drop costs a little health). Drink the {item:6637} beside the tall standing stone by the pool: several water elementals appear, and only the corrupt one near the middle can be attacked (Tab picks it). The {npc:5894} is level 22 and casts {spell:8056} and {spell:122}; if someone just killed it, it is back in about three minutes. Its bracers always drop."] = "Vuela a {area:228}. El santuario está en una hondonada justo al suroeste: rodea la cripta por detrás hasta el árbol grueso entre las dos colinas, salta pasándolo a las rocas y baja al oeste por la pendiente hasta la poza (cada bajada cuesta un poco de salud). Bebe {item:6637} junto a la piedra erguida alta al lado de la poza: aparecen varios elementales de agua, y solo se puede atacar al corrompido cerca del medio (Tab lo selecciona). La {npc:5894} es de nivel 22 y lanza {spell:8056} y {spell:122}; si alguien acaba de matarla, vuelve en unos tres minutos. Sus brazales siempre caen.",
	-- {item:6637} Water Sapta
	["{item:6637}, beside the standing stone"] = "{item:6637}, junto a la piedra erguida",

	-- Step 19: The Minor Manifestation of Water
	-- {npc:5895} Minor Manifestation of Water
	["The {npc:5895}"] = "La {npc:5895}",
	-- {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {spell:8202} Sapta Sight · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {quest:63} Call of Water · {quest:972} Water Sapta · {npc:7007} Tiev Mordune
	["Click the {object:113791} to place the bracers and the drops. A few seconds later the pure {npc:5895} rises on the stone in the middle of the pool: speak to it while the {spell:8202} lasts (drink again by the stone if it has worn off). It gives you the {item:7813} for {npc:5901}. Gone before you could speak to it? Back at {npc:5901} ask for {quest:63} (a fresh {quest:972} for {npc:7007}, who stands just west of the shrine): hand it to Tiev, stay close while he calls the spirit back, then speak to it."] = "Haz clic en {object:113791} para colocar los brazales y las gotas. Unos segundos después, la {npc:5895} pura se levanta sobre la piedra en el centro de la poza: háblale mientras dure {spell:8202} (vuelve a beber junto a la piedra si se te pasó). Te da {item:7813} para {npc:5901}. ¿Se fue antes de que pudieras hablarle? De vuelta con {npc:5901}, pide {quest:63} (un {quest:972} nuevo para {npc:7007}, que está justo al oeste del santuario): dáselo a Tiev, quédate cerca mientras llama de vuelta al espíritu y luego háblale.",

	-- Step 20: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet · {item:5177} Water Totem
	["Back to {npc:5901} south of {area:392}. Keep the {item:5177} in your bags for good: every water totem needs it."] = "De vuelta con {npc:5901}, al sur de {area:392}. Guarda {item:5177} en tus bolsas para siempre: todo tótem de agua lo necesita.",
	-- {npc:5901} Islen Waterseer · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {spell:5394} and your {item:5177}"] = "{npc:5901}: {spell:5394} y tu {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:5892} in the {object:172957} sends you to {npc:5901} in the {zone:1413}."] = "A nivel 20, {npc:5892}, en {object:172957}, te envía con {npc:5901} en {zone:1413}.",
	-- ["At 20 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5901} in the {zone:1413}."] = "A nivel 20, {npc:5906}, un instructor de chamanes de {zone:1456}, te envía con {npc:5901} en {zone:1413}.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Llena {item:7766} en el abrevadero de los jabaespines",
	-- ["Fill the {item:7767} at the fountain"] = "Llena {item:7767} en la fuente",
	-- ["Fill the {item:7768} at the {object:107045}"] = "Llena {item:7768} en {object:107045}",
	-- ["Fly to the {area:228}: the {object:113791} stands on the hill just south-west of it. Drink the {item:6637} there, beat the {npc:5894} for its bracers and place them in the brazier, then speak to the {npc:5895} and keep the {item:7813} for {npc:5901}."] = "Vuela a {area:228}: {object:113791} está en la colina justo al suroeste. Bebe {item:6637} ahí, derrota a {npc:5894} para obtener sus brazales y colócalos en el blandón; luego habla con {npc:5895} y guarda {item:7813} para {npc:5901}.",
	-- ["Take the zeppelin from {zone:1454} to {zone:1420} and travel south to {area:272}. The {object:107045} stands beside the inn."] = "Toma el zepelín de {zone:1454} a {zone:1420} y viaja hacia el sur hasta {area:272}. {object:107045} está junto a la posada.",
	-- ["The fountain stands in the middle of the {area:418}, in south-western {zone:1440}."] = "La fuente está en medio de {area:418}, en el suroeste de {zone:1440}.",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}."] = "La choza de {npc:5899} está en la loma sobre el abrevadero de los jabaespines, al sur de {area:378}.",
	-- ["{npc:5901} waits on the hill south of {area:392}."] = "{npc:5901} espera en la colina al sur de {area:392}.",
}
