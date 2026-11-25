-- Spanish (Latin America) (esMX): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {area:42} Darkshire · {zone:1431} Duskwood · {area:69} Lakeshire
	["Fly to {area:42} for {zone:1431}'s second loop: from {area:69}'s gryphon master if you come from the Redridge guide."] = "Vuela a {area:42} para la segunda vuelta de {zone:1431}: desde el maestro de grifos de {area:69} si vienes de la guía de Crestagrana.",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Su casa está en la colina al sureste de {area:42}, sobre {area:121}.",
	["Inside"] = "Adentro",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul
	["{item:1946}: the {npc:511}, in the crypt of the cemetery just below"] = "{item:1946}: el {npc:511}, en la cripta del cementerio justo abajo",

	-- Step 3: Tranquil Gardens Cemetery
	-- {npc:511} Insane Ghoul · {area:121} Tranquil Gardens Cemetery · {area:42} Darkshire
	["The {npc:511} (26) hides in the small crypt by the {area:121}, south of {area:42}; the glass is inside."] = "El {npc:511} (26) se esconde en la pequeña cripta junto a {area:121}, al sur de {area:42}; el espejo está adentro.",
	-- {item:1946} Mary's Looking Glass
	["{item:1946}; inside"] = "{item:1946}; adentro",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: botín raro de los enemigos de {zone:1431}",

	-- Step 4: Viktori Prism'Antras
	-- {area:42} Darkshire · {npc:276} Viktori Prism'Antras
	["North into {area:42}: {npc:276}'s house stands at the east end of town, on the way in."] = "Al norte, hacia {area:42}: la casa de {npc:276} está en el extremo este del pueblo, a la entrada.",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, adentro",
	-- {quest:177} Look to the Stars · {zone:1431} Duskwood
	["{quest:177}: the ogres of Vul'Gol, on your {zone:1431} return"] = "{quest:177}: los ogros de Vul'Gol, en tu vuelta a {zone:1431}",

	-- Step 6: Abercrombie
	["Head west along the road once more."] = "Ve al oeste por el camino una vez más.",

	-- Step 7: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}: mata a estos según te los encuentres",
	-- {npc:311} Sven Yorgen · {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["On the way west to {npc:311}: Skeletal Fiends and Skeletal Horrors walk the cemetery's southern half, north of {area:94}. {npc:522}, an elite, wanders the graves: keep away from him."] = "De camino al oeste hacia {npc:311}: los mefistos esqueléticos y los horrores esqueléticos recorren la mitad sur del cementerio, al norte de {area:94}. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.",

	-- Step 8: Gooey Spider Legs
	-- plural, as words: Gooey Spider Legs = {item:2251} Gooey Spider Leg
	["Gooey Spider Legs"] = "Patas de araña pegajosas",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Venom Web Spiders = {npc:217} Venom Web Spider · Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["Carrion Recluses lurk in the woods on the way west, and Venom Web Spiders, Pygmy Venom Web Spiders and Green Recluses crawl just south of {npc:311}'s camp: each can drop a leg."] = "Las reclusas carroñeras acechan en el bosque de camino al oeste, y las telarácnidas venenosas, telarácnidas venenosas pigmeas y reclusas verdes andan justo al sur del campamento de {npc:311}: cualquiera puede soltar una pata.",

	-- Step 9: Lars
	-- {npc:893} Lars · {npc:311} Sven Yorgen
	["{npc:893}, at {npc:311}'s camp"] = "{npc:893}, en el campamento de {npc:311}",

	-- Step 11: Moonbrook
	-- {quest:67} The Legend of Stalvan · {npc:311} Sven Yorgen · {zone:1436} Westfall · {area:20} Moonbrook · {object:3643} Old Footlocker · {area:42} Darkshire
	["{quest:67}: west from {npc:311}'s camp over the border into {zone:1436} and on to {area:20}, where the {object:3643} stands among the Defias (15-18). Then hearth back to {area:42}."] = "{quest:67}: al oeste desde el campamento de {npc:311}, cruzando el límite hacia {zone:1436} y hasta {area:20}, donde el {object:3643} está entre los Defias (15-18). Luego usa la piedra de hogar para volver a {area:42}.",

	-- Step 12: Moonbrook
	-- {quest:67} The Legend of Stalvan · {object:3643} Old Footlocker · {area:20} Moonbrook · {area:42} Darkshire
	["{quest:67}: the {object:3643} in {area:20}, among the Defias (15-18), holds the next part. Then hearth back to {area:42}."] = "{quest:67}: {object:3643} en {area:20}, entre los Defias (15-18), guarda la siguiente parte. Después vuelve con la piedra de hogar a {area:42}.",

	-- Step 13: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Regresa a {area:42}",
	-- {area:42} Darkshire
	["Hearth back to {area:42} if you bound at the Scarlet Raven Tavern on the first loop, or head back east along the road."] = "Usa la piedra de hogar para volver a {area:42} si la vinculaste en la Taberna del Cuervo Escarlata en el primer circuito, o vuelve al este por el camino.",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, adentro",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, en el ayuntamiento",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, en el ayuntamiento",
	-- {npc:264} Commander Althea Ebonlocke · {npc:289} Abercrombie
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["{npc:264}: the Plague Spreaders, with {npc:289}'s ghouls on the next trip west"] = "{npc:264}: los propagadores de la Peste, con los necrófagos de {npc:289} en el próximo viaje al oeste",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, en la taberna",

	-- Step 14: Clerk Daltry
	-- {quest:68} The Legend of Stalvan · {npc:267} Clerk Daltry
	["{quest:68}: {npc:267}, in the town hall, takes the footlocker's contents."] = "{quest:68}: {npc:267}, en el ayuntamiento, recibe el contenido del baúl.",
	-- {npc:267} Clerk Daltry · {npc:295} Innkeeper Farley · {area:87} Goldshire · {zone:1453} Stormwind
	["{npc:267}: for {npc:295} in {area:87}, on the walk north to {zone:1453}"] = "{npc:267}: para {npc:295} en {area:87}, en la caminata al norte hacia {zone:1453}",

	-- Step 15: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern too."] = "{npc:272} también está en la Taberna del Cuervo Escarlata.",
	-- {npc:288} Jitters · {area:94} Raven Hill
	["For {npc:288}, at {area:94} on the way west"] = "Para {npc:288}, en {area:94}, de camino al oeste",

	-- Step 16: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern."] = "{npc:272} está en la taberna.",

	-- Step 17: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Flores podridas ({item:1598})",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Los Horrores esqueléticos ({npc:202}) recorren la ladera entre {area:42} y {area:121}, al sureste del pueblo; sueltan las Flores podridas ({item:1598}).",

	-- Step 19: Abercrombie
	["Head west to the hermit once more."] = "Ve al oeste hasta el ermitaño una vez más.",

	-- Step 20: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Costillas de necrófago",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms · {npc:503} Lord Malathrom · {npc:771} Commander Felstrom · {npc:1200} Morbent Fel
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds.\nCareful: {npc:503} (31) and {npc:771} (32), both rares, haunt the cemetery's north and west, and {npc:1200} (32, elite) keeps to the house at its western edge: leave them be."] = "Cualquier necrófago de la mitad norte de {area:492} puede soltar una costilla: los comecarnes y masticahuesos Oseral (24-27) son más fáciles de matar; los propagadores de la Peste y comesesos (27-29) también las sueltan. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.\nCuidado: un {npc:948} lanza {spell:3428} al morir, lo que trae enemigos de más.\nCuidado: {npc:503} (31) y {npc:771} (32), los dos raros, rondan el norte y el oeste del cementerio, y {npc:1200} (32, élite) se queda en la casa del borde oeste: déjalos en paz.",
	-- {npc:604} Plague Spreader · {quest:58} The Night Watch
	["{npc:604}, for {quest:58}"] = "{npc:604}, para {quest:58}",

	-- Step 22: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se esconde en la casa del extremo oeste de {area:94}.",

	-- Step 25: Skeletal Raiders
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders"] = "Asaltantes esqueléticos",
	-- {area:492} Raven Hill Cemetery · {npc:311} Sven Yorgen · {npc:522} Mor'Ladim · {npc:771} Commander Felstrom
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["From level 28: the Skeletal Raiders, Healers and Warders stand in the west part of the {area:492}, just east of {npc:311}'s camp.\nCareful: The Warders are 28-29 and the skeletons stand close together: pull one at a time.\nCareful: {npc:522}, an elite (35), wanders these graves too, and {npc:771} (32, rare) haunts the west part: keep away from both."] = "Desde el nivel 28: los asaltantes, sanadores y guardas esqueléticos están en la parte oeste de {area:492}, justo al este del campamento de {npc:311}.\nCuidado: los guardas son de nivel 28-29 y los esqueletos están muy juntos: atráelos de uno en uno.\nCuidado: {npc:522}, un élite (35), también deambula por estas tumbas, y {npc:771} (32, raro) ronda la parte oeste: mantente lejos de los dos.",

	-- Step 26: Sven Yorgen
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "Lo siguiente: entrenar, luego el vuelo de {zone:1453} a {area:150} para {zone:1437}.",
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}'s Cathedral, on the walk north"] = "Para {npc:1212} en la Catedral de {zone:1453}, en la caminata al norte",

	-- Step 28: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Ve al oeste por el camino saliendo de {area:94} hacia {zone:1436}. {npc:7024} vigila la torre de {npc:7053} desde las colinas justo pasando la frontera. {npc:7051} (nivel 23) que vigila la torre lleva su llave; el diario de Klaven está en el cofre de arriba.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, en el cofre",

	-- Step 29: Master Mathias Shaw
	-- {area:1519} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {area:1519}; Mathias Shaw is at SI:7 in {object:2100}."] = "Dirígete al norte por Elwynn hasta {area:1519}; Mathias Shaw está en el IV:7, en {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Venenos y {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, en el sótano del Cuartel",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay down junto a {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, suministros de alquimia",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "{item:4371}: la casa de subastas, {object:2096}; {npc:5519} tiene uno y casi siempre está agotado",

	-- Step 30: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "Al norte desde {area:94} por Elwynn: {area:87} está en el camino a {zone:1453}.",

	-- Step 31: Class trainer
	["Class trainer"] = "Instructor de clase",
	["Your new spells"] = "Tus nuevos hechizos",

	-- Step 32: Innkeeper Farley
	-- {quest:69} The Legend of Stalvan · {npc:295} Innkeeper Farley · {area:87} Goldshire
	["{quest:69}: {npc:295} is in {area:87}'s Lion's Pride Inn; the chest with the letter is upstairs."] = "{quest:69}: {npc:295} está en la Posada Orgullo de León de {area:87}; el cofre con la carta está en el piso de arriba.",
	-- {item:910} An Undelivered Letter · {object:1560} Storage Chest
	["{item:910}, from the {object:1560} upstairs"] = "{item:910}, del {object:1560} del piso de arriba",

	-- Step 33: Caretaker Folsom
	-- {zone:1453} Stormwind · {npc:297} Caretaker Folsom · {object:1561} Sealed Crate
	["On into {zone:1453}: {npc:297} (the arrow shows him) takes the letter; the {object:1561} beside him holds the next clue."] = "Sigue hasta {zone:1453}: {npc:297} (la flecha lo marca) recibe la carta; la {object:1561} a su lado guarda la siguiente pista.",
	-- {object:1561} Sealed Crate
	["{object:1561}, beside him"] = "{object:1561}, a su lado",

	-- Step 34: Bishop Farthing
	-- {zone:1453} Stormwind · {npc:1212} Bishop Farthing · {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor
	["On into {zone:1453}: {npc:1212} stands in the Cathedral of Light, on the way to the gryphon master. His next quest is for {npc:1217} in {area:150}, where the flight lands."] = "Sigue hasta {zone:1453}: {npc:1212} está en la Catedral de la Luz, de camino al maestro de grifos. Su siguiente misión es para {npc:1217} en {area:150}, donde aterriza el vuelo.",
	-- {npc:1212} Bishop Farthing
	["{npc:1212}, in the Cathedral of Light"] = "{npc:1212}, en la Catedral de la Luz",
	-- {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["For {npc:1217} in {area:150} (the {zone:1437} guide)"] = "Para {npc:1217} en {area:150} (la guía de {zone:1437})",

	-- Step 35: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "Sigue hasta {zone:1453}: {npc:6173} y {npc:6171} están en la Catedral de la Luz, de camino al maestro de grifos.",
	["Cathedral of Light"] = "Cathedral of Light",

	-- Step 36: Gazin Tenorm
	-- {item:6846} Defias Script · {npc:6173} Gazin Tenorm · {quest:1787} The Tome of Divinity
	["The {item:6846} is already with {npc:6173}: take the last part of {quest:1787} from him, in the Cathedral of Light."] = "{item:6846} ya está con {npc:6173}: acepta de él la última parte de {quest:1787}, en la Catedral de la Luz.",

	-- Step 37: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm
	["{npc:6171} stands in the Cathedral of Light, beside {npc:6173}."] = "{npc:6171} está en la Catedral de la Luz, junto a {npc:6173}.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Redención",

	-- Step 38: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "{object:28027} de {zone:1453}",

	-- Step 39: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tranvía a {zone:1455}",

	-- Step 40: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} no tiene instructor de chamanes: toma {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y luego regresa en el tranvía.",

	-- Step 41: Rogue training
	["Rogue training"] = "Entrenamiento de pícaro",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "Entrena aquí, en {zone:1453}, antes de seguir.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "De vuelta con la maestra de grifos de {area:69}: vuela a {area:42} para el segundo circuito de {zone:1431}.",
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Sigue al oeste hasta {area:94}. {object:673515} brilla junto a la casa en ruinas al sur del camino.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "Cualquier necrófago de la mitad norte de {area:492} puede soltar una costilla: los comecarnes y masticahuesos Oseral (24-27) son más fáciles de matar; los propagadores de la Peste y comesesos (27-29) también las sueltan. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.\nCuidado: {npc:948} lanza {spell:3428} al morir, lo que trae enemigos de más.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Cualquier necrófago de la mitad norte de {area:492} puede soltar una costilla: comecarnes, masticahuesos Oseral, propagadores de peste y comesesos.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "Cualquier necrófago de la mitad norte de {area:492} puede soltar una costilla: comecarnes, roehuesos, propagadores de peste y comecerebros.\nCuidado: {npc:948} lanza {spell:3428} al morir, lo que trae enemigos de más.",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Sigue el camino al noroeste pasando el cementerio hasta el campamento de {npc:311}, en el extremo oeste del bosque. {npc:893} está junto a {npc:311}.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Sigue el camino al sur desde {area:1002} hacia {zone:1431}; {area:42} está en el lado este del bosque.",
	-- ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Ve al norte por Elwynn hasta {zone:1453}; Mathias Shaw está en el IV:7, en {object:2100}.",
	-- ["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Ve al sur por el cementerio hacia {area:94}. Los mefistos esqueléticos y horrores esqueléticos recorren su mitad sur. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.",
	-- ["Level 22 and 24 spells"] = "Hechizos de nivel 22 y 24",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Siguiente: {zone:1453} para entrenar, y luego el barco de {area:17203} a {area:442} para ir a {zone:1440}.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Los lobos temibles rabiosos deambulan por el bosque alrededor del cementerio y de {npc:289}; los lobos temibles famélicos, por las colinas al noreste de él. Las telarácnidas venenosas pigmeas se arrastran al este del cementerio y sueltan el veneno. Cualquier necrófago de la mitad norte del cementerio puede soltar un colmillo.",
	-- ["Ride back east along the road to the {area:245}."] = "Cabalga de vuelta al este por el camino hasta {area:245}.",
	-- ["Ride back east to {area:42}."] = "Cabalga de vuelta al este hasta {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Cabalga al norte por Elwynn hasta {zone:1453}; Mathias Shaw está en el IV:7 en {object:2100}.",
	-- ["Ride west along the road once more."] = "Cabalga otra vez al oeste por el camino.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Cabalga al oeste por el camino desde {area:94} hacia {zone:1436}. {npc:7024} vigila la torre de {npc:7053} desde las colinas justo pasando la frontera. El {npc:7051} (nivel 23) que guarda la torre lleva su llave; el diario de Klaven está en el cofre de arriba.",
	-- ["Ride west to the hermit once more."] = "Cabalga al oeste hasta el ermitaño una vez más.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Los guerreros esqueléticos y los magos esqueléticos caminan entre las tumbas al sureste de {area:42}, bajo la casa de {npc:302} en la colina. Cualquier esqueleto de {zone:1431} puede soltar un {item:2378}.",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "El cementerio está al norte del pueblo. Los horrores esqueléticos y los mefistos esqueléticos recorren su mitad sur. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "La choza del ermitaño está en el bosque al noreste de {area:492}.",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "El montón de tierra está al sur de la granja, junto al viejo tocón.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Entrena en {zone:1453}, al norte por {zone:1429}. Luego toma el barco de {area:17203} a {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Lobos, arañas y necrófagos",
	-- ["{area:492}, south"] = "{area:492}, sur",
	-- ["{area:69} flight master"] = "Maestro de vuelo de {area:69}",
	-- ["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "{item:1946}: {npc:511} de la cripta del cementerio es de nivel 26; espera a la vuelta a {zone:1431}",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}, de {object:673515}",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, de {npc:3133}: existencias limitadas. ¿Agotado? {npc:1448} en {area:150} también lo vende.",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}, en el extremo norte del pueblo",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, en su casa junto a la taberna",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}, en la casa detrás del ayuntamiento",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "La casa de {npc:276} está en el extremo este del pueblo. {npc:3133} vende artículos de ingeniería en la casa de al lado.",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} y {item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, en el extremo sur del pueblo",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, en la taberna",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} está al sur del camino, en {area:245}.",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: botín raro de los enemigos de {zone:1431}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y luego regresa en el tranvía para tomar el barco a {area:442}.",
}
