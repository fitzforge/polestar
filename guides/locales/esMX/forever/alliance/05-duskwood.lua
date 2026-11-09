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
	-- {area:69} Lakeshire · {area:42} Darkshire · {zone:1431} Duskwood
	["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Su casa está en la colina al sureste de {area:42}, sobre {area:121}.",
	["Inside"] = "",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul · {zone:1431} Duskwood
	["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "",

	-- Step 3: Tranquil Gardens Cemetery
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: botín raro de los enemigos de {zone:1431}",

	-- Step 5: Abercrombie
	["Head west along the road once more."] = "",

	-- Step 7: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Regresa a {area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, en el ayuntamiento",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, en la taberna",

	-- Step 8: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Flores podridas ({item:1598})",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Los Horrores esqueléticos ({npc:202}) recorren la ladera entre {area:42} y {area:121}, al sureste del pueblo; sueltan las Flores podridas ({item:1598}).",

	-- Step 10: Abercrombie
	["Head west to the hermit once more."] = "",

	-- Step 11: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Costillas de necrófago",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "",

	-- Step 13: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "",

	-- Step 14: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se esconde en la casa del extremo oeste de {area:94}.",

	-- Step 15: Sven's Camp
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "",

	-- Step 17: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, en el cofre",

	-- Step 18: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Venenos y {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, en el sótano del Cuartel",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay down junto a {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, suministros de alquimia",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "",

	-- Step 19: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "",

	-- Step 20: Class trainer
	["Class trainer"] = "",
	["Level 22 and 24 spells"] = "Hechizos de nivel 22 y 24",

	-- Step 21: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "",
	["Cathedral of Light"] = "Cathedral of Light",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Redención",

	-- Step 22: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 23: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 24: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} no tiene instructor de chamanes: toma {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y luego regresa en el tranvía.",

	-- Step 25: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Sigue al oeste hasta {area:94}. {object:673515} brilla junto a la casa en ruinas al sur del camino.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Cualquier necrófago de la mitad norte de {area:492} puede soltar una costilla: comecarnes, masticahuesos Oseral, propagadores de peste y comesesos.",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Sigue el camino al noroeste pasando el cementerio hasta el campamento de {npc:311}, en el extremo oeste del bosque. {npc:893} está junto a {npc:311}.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Sigue el camino al sur desde {area:1002} hacia {zone:1431}; {area:42} está en el lado este del bosque.",
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
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}, de {object:673515}",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, de {npc:3133}: existencias limitadas. ¿Agotado? {npc:1448} en {area:150} también lo vende.",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}, en el extremo norte del pueblo",
	-- ["{npc:264}, in the town hall"] = "{npc:264}, en el ayuntamiento",
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
