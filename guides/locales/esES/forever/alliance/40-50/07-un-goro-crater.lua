-- Spanish (Spain) (esES): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: la guía anterior te trae aquí con la piedra de hogar, así que esto suele marcarse al instante",

	-- Step 2: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Desde {area:144} vuela a {area:150}, toma el barco a Theramore y sigue volando hasta {area:976}. La primera misión de {npc:9619} en el cráter requiere nivel 48: si te falta, termina el nivel aquí.",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "mata Vagayermos u ogros Machacaduna alrededor de {area:976}",

	-- Step 3: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Sal de {area:976} cabalgando al oeste hasta la larga rampa que baja a {zone:1449}. {npc:9619} acampa al pie de la rampa, en la esquina sureste del cráter.",

	-- Step 4: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "El trillanodonte muerto yace junto al agua, al norte de {npc:9619}.",

	-- Step 6: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Amigos de Lar'korwi ({npc:9683}) y la balsa",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Los amigos de Lar'korwi ({npc:9683}) merodean por la jungla al oeste de {npc:9619}. La balsa naufragada está en la orilla del lago; el pequeño fardo está en el agua a su lado. Guarda la brújula, el mapa y la llave para {npc:8737}. Cualquier bestia del cráter puede soltar {item:11116}: haz clic derecho en él.",

	-- Step 8: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Cabalga hacia el norte por el lado este del cráter hasta {area:541}, el campamento en las cuevas del acantilado norte. Mantente lejos de los devilsaurios y estegodones élite. Recoge todos los cristales de poder y cada {object:157936} que encuentres a partir de aquí.",
	["Gryfe"] = "Gryfe",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina con {npc:9298} en {zone:1452}: guárdala",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, al fondo de la cueva",

	-- Step 9: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618} está justo fuera del refugio.",

	-- Step 10: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} y la jungla del este",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Cabalga al sur hasta {area:537}, en el centro del cráter, y luego al este hacia la jungla del este. Hay grupos de cristales por todo el cráter, muchos alrededor de {area:537}: coge unos cuantos de más de cada color. Los latigadores pétalo de sangre ({npc:6509}) y los trilladores sueltan los pétalos; el {item:11113} de la expedición está en un campamento abandonado de la jungla del este.",

	-- Step 11: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Cabalga al norte hasta {area:1943}, donde el robot está entre los gorilas. No entres en la cueva profunda de allí.",

	-- Step 12: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978} (opcional)",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Hacer {area:978} en grupo en vez de matar bichos te lleva allí más rápido. La ciudad trol está en el noroeste de {zone:1446}, justo al norte de {area:976}.",

	-- Step 13: Grind to 50
	["Grind to 50"] = "Sube hasta el 50",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Los gorilas de {area:1943} van en grupos pequeños y aún no sueltan nada para ti; la misión de las pieles de {npc:9619} llega más tarde. No entres en la cueva más profunda: {npc:9622} es de nivel 55.",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "mata {npc:6514} en {area:1943}, {zone:1449}",

	-- Step 14: Marshal's Refuge
	["Ride west back to the refuge."] = "Cabalga al oeste de vuelta al refugio.",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Para {npc:7775} en {zone:1444}: guárdala",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "El cartel de madera junto a {npc:9997}",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, en la entrada del refugio",

	-- Step 15: Northern Pylon
	["Northern Pylon"] = "La Torre del Norte",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "La torre está en la ladera al este del refugio. Los {npc:9166} vuelan en círculos por las laderas que la rodean: cuentan para {npc:9997} y sueltan las escamas de {npc:9998}.",

	-- Step 16: The east side
	["The east side"] = "El lado este",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Cabalga al sur por el lado este. Los diemetradones jóvenes ({npc:9162}) pastan en la jungla del este y los {npc:9165} vuelan cerca de los acantilados del este; ambos sueltan las escamas de {npc:9998}.",

	-- Step 17: Eastern Pylon
	["Eastern Pylon"] = "La Torre del Este",
	["The pylon stands on the eastern cliffs."] = "La torre está en los acantilados del este.",

	-- Step 18: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Cabalga al sur por los acantilados del este hasta {npc:9619}, al pie de la rampa.",
	["The pelts come after loop 2, on the gorilla plateau"] = "Las pieles van después de la vuelta 2, en la meseta de los gorilas",

	-- Step 19: The Gorishi hive
	["The Gorishi hive"] = "La colmena Gorishi",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Cabalga al oeste desde {npc:9619}: la colmena de silítidos ocupa el sur del cráter. Usa el vial de raspadura en un criadero, una cámara con larvas colgando. Las avispas y obreros Gorishi sueltan {quest:3764}; los {npc:9166} anidan en los acantilados del sur si aún necesitas matar alguno.",

	-- Step 20: Bones and equipment
	["Bones and equipment"] = "Huesos y equipo",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Los huesos de dinosaurio ({item:11114}) están en el suelo del suroeste, entre los estegodones: son élite, así que recoge los huesos a su alrededor y consigue el resto de los diemetradones. El {item:11112} de la expedición está en la jungla del suroeste.",

	-- Step 21: Western Pylon
	["Western Pylon"] = "La Torre del Oeste",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "La torre está en los acantilados del oeste. Los {npc:9167} vuelan por todo el lado oeste.",

	-- Step 22: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "Cabalga al norte por la jungla del oeste de vuelta al refugio.",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, en la entrada del refugio",

	-- Step 23: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9999}, el amigo de {npc:9997}, ha desaparecido.",

	-- Step 24: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Los gorilas viven en {area:1943}, al este de {area:541}. Guarda sus pieles para {npc:9619}. No entres en la cueva más profunda: {npc:9622} es de nivel 55.",

	-- Step 25: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado en la ladera sureste de {area:537}, en el centro del cráter.",

	-- Step 26: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Lleva a {npc:9999} al norte hasta {area:541}. Cuando se desmaye, usa {item:11804} en él para despertarlo.",

	-- Step 28: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Hacer el {area:1417} en grupo en vez de matar bichos te lleva allí más rápido. Omite este paso para subir de nivel en solitario.",

	-- Step 29: Grind to 51
	["Grind to 51"] = "Sube hasta el 51",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Los silítidos Centipaar rondan {area:982}, en el oeste de {zone:1446}, justo al este de la rampa del cráter. Los trabajadores son los más fáciles de atraer.",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "mata {npc:5458} en {area:982}, {zone:1446}",

	-- Step 30: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Baja por la rampa al cráter: {npc:9619} acampa al pie.",

	-- Step 31: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "La guarida de {npc:9684} está en la jungla al norte de {npc:9619}, bajo los acantilados del este: usa {item:11568} allí. {npc:9684} es de nivel 56: empieza con la salud al máximo.",

	-- Step 33: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Cabalga al norte por el lado este hasta la meseta de los gorilas. {npc:9622}, un gorila de nivel 55, está en su cueva más profunda: limpia primero los gorilas de la entrada.",

	-- Step 34: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Cabalga al oeste pasando {area:541} y baja al sur por el lado oeste hasta {area:543}: el goblin {npc:10302} está junto al agua.",

	-- Step 35: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Cabalga al este hasta {area:537}, súbela y usa {npc:10541} en las grietas de lava cerca de la cima.",

	-- Step 37: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Cruza el sur del cráter hasta {npc:9619}, junto a la rampa.",

	-- Step 39: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "Vuela de {area:144} a {area:1537}.",

	-- Step 41: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: los mocos están en {zone:1448}, guárdala",

	-- Step 42: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Cuatro calcos de runas en {zone:1447}: guárdala",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: para Ogtinc en {zone:1447}, guárdala",

	-- Step 43: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus está junto al rey Magni en {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "Las reliquias están en {zone:1428}: guárdala",

	-- Step 44: Bind and train
	["Bind and train"] = "Vincula y entrena",

	-- Step 45: Xiggs Fuselighter
	-- {object:32359} Military Ward (no name in this language: may be words)
	["Xiggs waits in the {object:32359}."] = "Xiggs espera en {object:32359}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "mata {npc:5458} en {area:982}, {zone:1446}",
}
