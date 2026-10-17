-- Spanish (Spain) (esES): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Sigue el camino al sur desde {area:1002} hasta {zone:1431}; {area:42} está en el lado este del bosque.",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, en el extremo norte del pueblo",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Mesón del Cuervo Escarlata",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern"] = "{npc:265}, en su casa junto a la taberna",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, en el ayuntamiento",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, en la casa detrás del ayuntamiento",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town"] = "{npc:633}, en el extremo sur del pueblo",

	-- Step 2: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras · {npc:3133} Herble Baubbletump
	["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "La casa de {npc:276} está en el extremo este del pueblo. {npc:3133} vende artículos de ingeniería en la casa de al lado.",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, de {npc:3133}: existencias limitadas. ¿Agotado? {npc:1448}, en {area:150}, también lo vende.",

	-- Step 3: Tranquil Gardens Cemetery
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Guerreros esqueléticos y Magos esqueléticos deambulan entre las tumbas al sureste de {area:42}, bajo la casa de {npc:302} en la colina. Cualquier esqueleto de {zone:1431} puede soltar un {item:2378}.",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: botín poco frecuente de los enemigos de {zone:1431}",

	-- Step 5: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} está al sur del camino, en {area:245}.",

	-- Step 6: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Sigue al oeste hasta {area:94}. El {object:673515} brilla junto a la casa en ruinas al sur del camino.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}, del {object:673515}",

	-- Step 7: Raven Hill Cemetery, south
	-- {area:492} Raven Hill Cemetery
	["{area:492}, south"] = "{area:492}, sur",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "El cementerio está al norte de la aldea. Horrores esqueléticos y Mefistos esqueléticos recorren su mitad sur. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.",

	-- Step 8: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Sigue el camino al noroeste, pasado el cementerio, hasta el campamento de {npc:311}, en el extremo oeste del bosque. {npc:893} está junto a {npc:311}.",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "La choza del ermitaño está en el bosque al noreste del {area:492}.",

	-- Step 10: Wolves, spiders and ghouls
	["Wolves, spiders and ghouls"] = "Lobos, arañas y necrófagos",
	-- {npc:289} Abercrombie
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Los Lobos feroces rabiosos recorren el bosque alrededor del cementerio y de {npc:289}; los Lobos feroces hambrientos, las colinas al noreste de él. Las Telarácnidas pigmeovenenosas merodean al este del cementerio y sueltan el veneno. Cualquier necrófago de la mitad norte del cementerio puede soltar un colmillo.",

	-- Step 11: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Ride back east along the road to the {area:245}."] = "Vuelve al este por el camino hasta {area:245}.",

	-- Step 12: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "El montón de tierra suelta está al sur de la granja, junto al viejo tocón.",

	-- Step 14: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Su casa está en la colina al sureste de {area:42}, por encima del {area:121}.",

	-- Step 16: Abercrombie
	["Ride west along the road once more."] = "Ve otra vez al oeste por el camino.",

	-- Step 18: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Vuelta a {area:42}",
	-- {area:42} Darkshire
	["Ride back east to {area:42}."] = "Vuelve al este hasta {area:42}.",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, en el ayuntamiento",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, en la taberna",

	-- Step 19: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Flores podridas ({item:1598})",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Los horrores esqueléticos ({npc:202}) recorren la ladera entre {area:42} y el {area:121}, al sureste del pueblo; sueltan las flores podridas ({item:1598}).",

	-- Step 21: Abercrombie
	["Ride west to the hermit once more."] = "Ve otra vez al oeste hasta el ermitaño.",

	-- Step 22: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Costillas de necrófago",
	-- {area:492} Raven Hill Cemetery
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Cualquier necrófago de la mitad norte del {area:492} puede soltar una costilla: Comecarnes, Masticahuesos Oseral, Propagadores de la Peste y Comesesos.",

	-- Step 24: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} se esconde en la casa del extremo oeste de {area:94}.",

	-- Step 25: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Después: {zone:1453} para entrenar y luego el barco de {area:17203} a {area:442} para ir a {zone:1440}.",

	-- Step 26: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Ve al oeste por el camino, sal de {area:94} y entra en {zone:1436}. {npc:7024} vigila la torre de {npc:7053} desde las colinas, justo pasada la frontera. El {npc:7051} (nivel 23) que guarda la torre lleva su llave; el diario de Klaven está en el cofre de arriba.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, en el cofre",

	-- Step 27: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Ve al norte por el Bosque de Elwynn hasta {zone:1453}; Mathias Shaw está en el SI:7, en {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Venenos y {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, en el sótano del Cuartel",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "Usa /lay para tumbarte junto a {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, Suministros de alquimia",

	-- Step 28: Stormwind
	-- {zone:1453} Stormwind · {zone:1429} Elwynn Forest · {area:17203} Stormwind Harbor · {area:442} Auberdine
	["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Entrena en {zone:1453}, al norte a través de {zone:1429}. Luego toma el barco de {area:17203} a {area:442}.",
	["Level 22 and 24 spells"] = "Hechizos de nivel 22 y 24",

	-- Step 29: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde el {object:28027} hasta {zone:1455}, entrena con {npc:258098} y vuelve en el tren para tomar el barco a {area:442}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the {npc:14235} Blossoms."] = "Los Horrores esqueléticos recorren la ladera entre {area:42} y el {area:121}, al sureste del pueblo; sueltan las flores de {npc:14235}.",
	-- ["{item:3372}: {npc:1313}, {skill:171} Supplies"] = "{item:3372}: {npc:1313}, suministros de {skill:171}",
	-- ["{npc:14235} Blossoms"] = "Flores de {npc:14235}",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} y {item:18160}",
}
