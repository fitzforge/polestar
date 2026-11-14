-- Spanish (Latin America) (esMX): the guide forever/class/shaman/call-of-fire-horde (forever/class/shaman/call-of-fire-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1522} Call of Fire
	["{quest:1522} (Horde)"] = "{quest:1522} (Horda)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Tu {item:5176} para todo tótem de fuego, {spell:3599} con él, y {item:263412} de Forever.",

	-- Step 1: Swart
	-- {npc:3173} Swart · {area:362} Razor Hill · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5892} Searn Firewarder · {zone:1454} Orgrimmar
	["At 10 {npc:3173}, the shaman trainer on the east side of {area:362}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5892}'s letter from {zone:1454}? It goes to {npc:5907} too: skip {npc:3173}."] = "A nivel 10, {npc:3173}, el instructor de chamanes del lado este de {area:362}, te manda con {npc:5907} en {zone:1413}. ¿Ya llevas la carta de {npc:5892} desde {zone:1454}? También va para {npc:5907}: omite a {npc:3173}.",

	-- Step 2: Narm Skychaser
	-- {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff
	["At 10 {npc:3066}, the shaman trainer in {area:222}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5906}'s letter from {zone:1456}? It goes to {npc:5907} too: skip Narm."] = "A nivel 10, {npc:3066}, el instructor de chamanes de {area:222}, te manda con {npc:5907} en {zone:1413}. ¿Ya llevas la carta de {npc:5906} desde {zone:1456}? También va para {npc:5907}: omite a Narm.",

	-- Step 3: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {zone:1411} Durotar · {area:1704} Grol'dom Farm · {area:379} Far Watch Post · {zone:1440} Ashenvale
	["{npc:5907} is not in the Crossroads: take the road north from the Crossroads and fork east towards {zone:1411}; past {area:1704} he paces by a tall tower east of the road (from {zone:1411}: over the Southfury bridge, past {area:379}). If you reach {zone:1440} you went too far."] = "{npc:5907} no está en el Cruce: toma el camino al norte desde el Cruce y en la bifurcación ve al este hacia {zone:1411}; pasando {area:1704}, camina de un lado a otro junto a una torre alta al este del camino (desde {zone:1411}: por el puente del Furia del Sur, pasando {area:379}). Si llegas a {zone:1440}, te pasaste.",

	-- Step 4
	-- {npc:5907} Kranal Fiss · {npc:3173} Swart
	["{npc:5907}: {npc:3173}'s letter"] = "{npc:5907}: la carta de {npc:3173}",

	-- Step 5
	-- {npc:5907} Kranal Fiss · {npc:5892} Searn Firewarder
	["{npc:5907}: {npc:5892}'s letter"] = "{npc:5907}: la carta de {npc:5892}",

	-- Step 6
	-- {npc:5907} Kranal Fiss · {npc:3066} Narm Skychaser
	["{npc:5907}: {npc:3066}'s letter"] = "{npc:5907}: la carta de {npc:3066}",

	-- Step 7
	-- {npc:5907} Kranal Fiss · {npc:5906} Xanis Flameweaver
	["{npc:5907}: {npc:5906}'s letter"] = "{npc:5907}: la carta de {npc:5906}",

	-- Step 8: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:6653} Torch of the Dormant Flame
	["{npc:5907} hands you the {item:6653}: keep it until the end of the chain."] = "{npc:5907} te da {item:6653}: guárdala hasta el final de la cadena.",

	-- Step 9: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back east over the bridge, then south along the {zone:1411} bank of the river to where the mountains meet the water. The trail up starts at the foot of the mountain beside a small dark stone carved with symbols, near the quilboar camp; it is narrow, and a slip costs fall damage. {npc:5900} keeps the shrine at the top."] = "De vuelta al este por el puente, luego al sur por la orilla de {zone:1411} del río hasta donde las montañas llegan al agua. El sendero de subida empieza al pie de la montaña, junto a una piedrita oscura tallada con símbolos, cerca del campamento de jabaespines; es angosto, y un resbalón cuesta daño por caída. {npc:5900} cuida el santuario de la cima.",

	-- Step 10: Fire Tar
	-- {item:5026} Fire Tar
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The Razormane casters north-east of the Crossroads drop the {item:5026} three times in four: Water Seekers and Thornweavers (level 10-11), Geomancers (level 12-13, they throw Fireballs and run for help when hurt) and Mystics (level 13-14, they heal themselves at low health). Pull them one at a time."] = "Los lanzadores de hechizos Crines de Acero al noreste del Cruce sueltan {item:5026} tres de cada cuatro veces: buscaaguas y tejespinas (nivel 10-11), geomantes (nivel 12-13, lanzan bolas de fuego y huyen a pedir ayuda cuando están heridos) y místicos (nivel 13-14, se curan con poca salud). Atráelos de a uno.",

	-- Step 11: Reagent Pouch
	-- {spell:348} Immolate · {area:371} Dustwind Cave · {area:362} Razor Hill · {area:817} Skull Rock · {zone:1454} Orgrimmar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["The Burning Blade Cultists (level 10-11, they call imps and cast {spell:348}) live deep in {area:371} north of {area:362}: climb the ramp just north-east of town and stay on the high ground above the ravines. The orcs at the cave mouth are not cultists; the cultists are further in, off to the left. Three kills in four drop a pouch. {area:817} by {zone:1454} is the wrong cave."] = "Los sectarios del Filo Ardiente (nivel 10-11, llaman diablillos y lanzan {spell:348}) viven en lo profundo de {area:371}, al norte de {area:362}: sube por la rampa justo al noreste del pueblo y mantente en lo alto sobre los barrancos. Los orcos de la entrada de la cueva no son sectarios; los sectarios están más adentro, hacia la izquierda. Tres de cada cuatro sueltan una bolsa. {area:817}, junto a {zone:1454}, no es la cueva.",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["Back up the trail to {npc:5900}. He makes the {quest:1464} from the tar and the pouch and hands it to you with the torch: keep both."] = "Vuelve a subir por el sendero hasta {npc:5900}. Prepara {quest:1464} con el alquitrán y la bolsa y te lo da con la antorcha: guarda ambos.",

	-- Step 13: Lost the Fire Sapta?
	-- {quest:1464} Fire Sapta
	["Lost the {quest:1464}?"] = "¿Perdiste {quest:1464}?",
	-- {quest:1464} Fire Sapta · {npc:5900} Telf Joolam
	["Only if the {quest:1464} is gone from your bags: {npc:5900} gives you another."] = "Solo si {quest:1464} ya no está en tus bolsas: {npc:5900} te da otro.",
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["{npc:5900}: a new {quest:1464}"] = "{npc:5900}: un {quest:1464} nuevo",

	-- Step 14: The Minor Manifestation of Fire
	-- {npc:5893} Minor Manifestation of Fire
	["The {npc:5893}"] = "La {npc:5893}",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words) · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Drink the {item:6636} beside the {object:63674}, the big grey stone just below the summit, then climb to the plateau. Of the fire elementals there only the one in the middle can be attacked: it is level 12, immune to fire and grows stronger the longer the fight lasts, so open at once with {spell:8017} and {spell:8042} and leave the others alone. Its {item:6655} drops every time."] = "Bebe {item:6636} junto a {object:63674}, la gran piedra gris justo debajo de la cima, y luego sube a la meseta. De los elementales de fuego de ahí, solo se puede atacar al del medio: es de nivel 12, inmune al fuego y se vuelve más fuerte cuanto más dura la pelea, así que empieza enseguida con {spell:8017} y {spell:8042} y deja en paz a los otros. Su {item:6655} cae siempre.",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words)
	["{item:6636}, beside the {object:63674}"] = "{item:6636}, junto a {object:63674}",

	-- Step 15: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} on the plateau with the torch in your bags to place the ember, then click it a second time: the next quest does not open by itself. It gives you the lit {item:277329}."] = "Haz clic en {object:61934} de la meseta con la antorcha en tus bolsas para colocar la brasa, y luego vuelve a hacer clic: la siguiente misión no se abre sola. Te da {item:277329} encendida.",

	-- Step 16: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:5176} Fire Totem
	["Down the trail, back over the bridge to {npc:5907} by his tower. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Baja por el sendero y vuelve por el puente hasta {npc:5907}, junto a su torre. Guarda {item:5176} en tus bolsas para siempre: todo tótem de fuego lo necesita.",
	-- {npc:5907} Kranal Fiss · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {spell:3599}, tu {item:5176} y {item:263412}",

	-- Step 17: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {item:6653} Torch of the Dormant Flame · {npc:254082} Aarnor Galestrike · {quest:97243} Call of Fire · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {spell:8050} Flame Shock · {npc:268605} Kuramaa
	["At 10 {npc:252382}, the shaman trainer beside {npc:251968} in {area:16638}, hands you the {item:6653} ({npc:254082} offers the same quest). Already left the isle? A {quest:97243} sends you back to them: take the skycutter from the cliffs south of {area:17045}, north of {zone:1456}. Learn {spell:8050} from her now: {npc:268605}, later in the chain, only takes fire damage."] = "A nivel 10, {npc:252382}, la instructora de chamanes junto a {npc:251968} en {area:16638}, te da {item:6653} ({npc:254082} ofrece la misma misión). ¿Ya saliste de la isla? Una {quest:97243} te manda de vuelta con ellos: toma el cortacielos desde los acantilados al sur de {area:17045}, al norte de {zone:1456}. Aprende ahora {spell:8050} con ella: {npc:268605}, más adelante en la cadena, solo recibe daño de fuego.",

	-- Step 18: Olariaan Swiftburn
	-- {area:16638} Valanaar · {area:16663} Windfield Orchard · {npc:268592} Olariaan Swiftburn
	["The Shrine of Flames hides on the island's outer rim south-west of {area:16638}, just south-east of {area:16663}: {npc:268592} keeps it."] = "El Santuario de las Llamas se esconde en el borde exterior de la isla al suroeste de {area:16638}, justo al sureste de {area:16663}: {npc:268592} lo cuida.",

	-- Step 19: Skypriest Faladiel
	-- {npc:268602} Skypriest Faladiel · {area:16638} Valanaar · {area:16629} Shrine of Akir · {area:17675} East Pylon Watchtower
	["{npc:268602} (level 10, a turncoat Windshaper with a single spawn) holds the farm north-east past {area:16638}, just south of the {area:16629}, on the hill west of the falls north of the {area:17675}. Kill him and take his heart."] = "{npc:268602} (nivel 10, un Formavientos traidor que aparece en un solo lugar) ocupa la granja al noreste, pasando {area:16638}, justo al sur de {area:16629}, en la colina al oeste de la cascada al norte de {area:17675}. Mátalo y toma su corazón.",

	-- Step 20: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn
	["Back to {npc:268592} at the Shrine of Flames."] = "De vuelta con {npc:268592} en el Santuario de las Llamas.",

	-- Step 21: Kuramaa
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words) · {area:16638} Valanaar · {npc:268605} Kuramaa · {spell:8050} Flame Shock
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{object:660848} is the twisted stump on the hilltop by the Shen'dar Highlands Anchor Pylon, west of {area:16638}, in the hills south of the Windsong Crawlers' lakes. Knock on it to call {npc:268605} (level 10). The spirit shrugs off most magic: only fire hurts it, so keep {spell:8050} on it. Take its wooden mask."] = "{object:660848} es el tocón retorcido en lo alto de la colina junto al Pilón ancla de las Tierras Altas de Shen'dar, al oeste de {area:16638}, en las colinas al sur de los lagos de los reptadores Cantoviento. Golpéalo para llamar a {npc:268605} (nivel 10). El espíritu ignora casi toda la magia: solo el fuego lo daña, así que mantén {spell:8050} sobre él. Toma su máscara de madera.",
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words)
	["{object:660848}: knock on the bark"] = "{object:660848}: golpea la corteza",

	-- Step 22: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {object:148418} Eternal Flame · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Accept the last quest, then wait by the {npc:268762} while he performs the ritual; when the fire spirits light the {object:148418}, hold the torch to it. From then you have six minutes: carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638}, with no detours or fights. Timer out? Abandon the quest and take it again from {npc:268592}."] = "De vuelta con {npc:268592}. Acepta la última misión y luego espera junto al {npc:268762} mientras hace el ritual; cuando los espíritus de fuego enciendan {object:148418}, acerca la antorcha. Desde ahí tienes seis minutos: lleva la llama directo al {npc:268679} junto a {npc:252382} en {area:16638}, sin desvíos ni peleas. ¿Se acabó el tiempo? Abandona la misión y vuelve a tomarla con {npc:268592}.",
	-- {npc:268679} Brazier of Eternal Flame · {area:16638} Valanaar
	["the ritual, then the {npc:268679} in {area:16638}"] = "el ritual, y luego el {npc:268679} en {area:16638}",

	-- Step 23: Sessaria Skystride
	-- {item:5176} Fire Totem
	["Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Guarda {item:5176} en tus bolsas para siempre: todo tótem de fuego lo necesita.",
	-- {npc:252382} Sessaria Skystride · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {spell:3599}, tu {item:5176} y {item:263412}",
}
