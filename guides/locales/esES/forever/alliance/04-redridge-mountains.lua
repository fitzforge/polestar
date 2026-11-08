-- Spanish (Spain) (esES): the guide forever/alliance/04-redridge-mountains (forever/alliance/04-redridge-mountains.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormwind
	-- {zone:1429} Elwynn Forest
	["Train, then leave by the main gate and follow the road east through {zone:1429}."] = "",
	["Level 18 and 20 spells"] = "Hechizos de nivel 18 y 20",

	-- Step 2: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 3: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Polearms from {npc:11867} ({object:2096}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 4: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 5: Shaman training
	["Shaman training"] = "Entrenamiento de chamán",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the Deeprun Tram from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "",

	-- Step 6: Fly to Sentinel Hill
	-- {object:81} Sentinel Hill (no name in this language: may be words)
	["Fly to {object:81}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 7: Half Pendant of Aquatic Endurance
	-- {object:81} Sentinel Hill (no name in this language: may be words) · {object:177790} Strange Lockbox
	["Fly to {object:81} and head north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then head east along the road through Elwynn."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: la {object:177790}",

	-- Step 8: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "",

	-- Step 10: Theocritus
	["On the top floor"] = "",

	-- Step 11: Henze Faulk
	-- {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["On the road east, past the Tower of Azora, head north from the bridge to Stone Cairn Lake. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Usa el {item:6866} en {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Zahoríes bribones Defias",

	-- Step 12: Three Corners
	["Three Corners"] = "",
	-- {zone:1431} Duskwood
	["The road east through Elwynn crosses into Redridge at Three Corners, where the roads to Redridge, {zone:1431} and Elwynn meet: south to {zone:1431} first."] = "",

	-- Step 14: Darkshire
	["Darkshire"] = "",
	-- {zone:1431} Duskwood · {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {object:1162} Menethil Harbor (no name in this language: may be words)
	["Follow the road south from Three Corners into {zone:1431}; Darkshire lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {object:1162} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}, en el extremo norte del pueblo",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Mesón del Cuervo Escarlata",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, en el ayuntamiento",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, en el ayuntamiento",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}, en la casa detrás del ayuntamiento",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "",
	-- {npc:633} Elaine Carevin · {npc:288} Jitters · {quest:163} Raven Hill
	["{npc:633}: {npc:288}, at {quest:163}"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "{item:4371}, de {npc:3133}, si no tienes",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "",
	-- {npc:302} Blind Mary
	["For {npc:302}, on the hill south-east of town"] = "",

	-- Step 15: Tranquil Gardens Cemetery: kill these as you meet them
	["Tranquil Gardens Cemetery: kill these as you meet them"] = "",
	-- {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of Darkshire, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "",

	-- Step 16: Watcher Dodds
	-- {npc:888} Watcher Dodds
	["{npc:888} stands south of the road, at the Yorgen Farmstead."] = "",

	-- Step 17: Raven Hill
	-- {quest:163} Raven Hill · {object:673515} Memory of Valor · {npc:288} Jitters
	["Continue west to {quest:163}. The {object:673515} glows by the ruined house south of the road; {npc:288} hides in the house at the west end of the village."] = "",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}, del {object:673515}",
	-- {npc:272} Chef Grual
	["for {npc:272} in Darkshire"] = "",

	-- Step 18: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Sigue el camino al noroeste, pasado el cementerio, hasta el campamento de {npc:311}, en el extremo oeste del bosque. {npc:893} está junto a {npc:311}.",

	-- Step 19: The Hushed Bank: kill these as you meet them
	["The Hushed Bank: kill these as you meet them"] = "",
	-- {npc:289} Abercrombie · {quest:163} Raven Hill · {npc:311} Sven Yorgen · {zone:1436} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders are the small spiders, and few: most crawl along the Hushed Bank west of {quest:163}, fewer up north towards {npc:311}'s camp; they drop the venom too. Every ghoul of the cemetery's northern half can drop a fang. Wolves and the bigger spiders share the {zone:1436} border, so pull with care."] = "",
	-- {item:1130} Vial of Spider Venom
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Venom Web Spiders = {npc:217} Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "",

	-- Step 20: Abercrombie
	["The hermit's shack stands in the woods north-east of the Raven Hill Cemetery."] = "",

	-- Step 21: Raven Hill Cemetery: kill these as you meet them
	["Raven Hill Cemetery: kill these as you meet them"] = "",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "El cementerio está al norte de la aldea. Horrores esqueléticos y Mefistos esqueléticos recorren su mitad sur. {npc:522}, un élite, deambula entre las tumbas: mantente lejos de él.",

	-- Step 22: Watcher Dodds
	["Head back east along the road to the Yorgen Farmstead."] = "",

	-- Step 23: Yorgen Farmstead
	["Yorgen Farmstead"] = "",
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "El montón de tierra suelta está al sur de la granja, junto al viejo tocón.",

	-- Step 24: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "",
	-- {npc:272} Chef Grual
	["{npc:272}, in the Scarlet Raven Tavern"] = "",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}, junto al ayuntamiento",

	-- Step 26: Redridge Mountains
	["Back north along the road from Darkshire to Three Corners."] = "",

	-- Step 27: Lakeridge Highway
	["Lakeridge Highway"] = "",
	-- {npc:903} Guard Howe
	["Follow the road along the south shore of Lake Everstill to the gryphon master. {npc:903} stands by the road next to her."] = "",

	-- Step 28: Lake Everstill's murlocs: kill these as you meet them
	["Lake Everstill's murlocs: kill these as you meet them"] = "",
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Murloc Flesheaters and Tidecallers line the south shore of Lake Everstill, just east of the gryphons and the bridge. Any of them can carry a fin."] = "",

	-- Step 29: Lakeshire
	["Lakeshire"] = "",
	-- {npc:381} Dockmaster Baren · {npc:900} Bailiff Conacher · {npc:342} Martie Jainrose · {npc:382} Marshal Marris · {quest:98386} Alther's Mill
	["Cross the long bridge north into town: {npc:381} on the docks, {npc:900} in the town hall, the innkeeper in the inn, {npc:342} in her garden at the west end. {npc:382}'s Blackrock quests and {quest:98386} came with you from your first Redridge visit."] = "",
	-- {npc:900} Bailiff Conacher
	["{npc:900}, in the town hall"] = "",
	["The Wanted poster by the inn"] = "El cartel de Se busca junto a la posada",

	-- Step 30: Bellygrub
	-- {npc:345} Bellygrub · {npc:342} Martie Jainrose
	["{npc:345} (level 24) roots around the pen just west of Lakeshire, beside {npc:342}'s garden. Pull him away from the other boars and fight at full health."] = "",

	-- Step 31: Martie Jainrose
	-- {npc:342} Martie Jainrose
	["{npc:342}'s garden is at the west end of town."] = "",

	-- Step 32: Lakeshire
	-- {npc:342} Martie Jainrose
	["Back east through town from {npc:342}'s garden: two Wanted posters hang on the town hall doorway."] = "",
	["The Wanted poster on the town hall doorway"] = "",
	["The Wanted poster beside it"] = "",

	-- Step 33: Lake Everstill: kill these as you meet them
	["Lake Everstill: kill these as you meet them"] = "",
	-- plural, as words: Greater Tarantulas = {npc:505} Greater Tarantula
	["Greater Tarantulas crawl on the slopes around the mill north-east of the lake."] = "",

	-- Step 34: Blackrock camps
	["Blackrock camps"] = "",
	-- {object:116} Stonewatch Keep (no name in this language: may be words)
	["South-east from the mill, west of Galardell Valley's gnolls, to the Blackrock camps east of {object:116}. Renegades, Grunts and Outrunners fill them; keep east of the keep, whose orcs are elite. Weapon racks and swords lie about the camps; meat haunches, grain sacks and water barrels hold the supplies."] = "",
	-- {item:280841} Stolen Weapon
	["{item:280841}: weapon racks and swords on the ground"] = "",
	-- {item:280839} Blackrock Supplies
	["{item:280839}: meat haunches, grain sacks, water barrels"] = "",

	-- Step 35: Incinerator Gar'im
	["Gar'im keeps to the cave at the camps' south end with his imp and two orcs. Elite: group up if you can; solo, pull the orcs at the mouth first and interrupt his fire cast."] = "",

	-- Step 36: Galardell Valley
	["Galardell Valley"] = "",
	-- {npc:703} Lieutenant Fangore · {object:116} Stonewatch Keep (no name in this language: may be words)
	["North up the valley's east side. Shadowhide gnolls fill it; {npc:703} (26) and his two guards stand at its north end: clear the gnolls around him first and fight at full health. Stay out of {object:116} to the west until the watch tower: its orcs are elite."] = "",
	-- {item:1075} Shadowhide Pendant
	["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: cualquier gnol Pielsombra",

	-- Step 37: A Watchful Eye
	-- {object:31} Old Lion Statue
	["The {object:31} stands at the valley's east edge."] = "",

	-- Step 38: Looking Further
	-- {object:116} Stonewatch Keep (no name in this language: may be words)
	["West to the intact watch tower beside {object:116}: climb it and leave the Glyph in the empty jar at the top."] = "",

	-- Step 39: Stonewatch Keep
	-- {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The keep stands beside the tower. {npc:334} (elite) waits in the keep's top room with two guards and a dragon; Blackrock Shadowcasters (elite) and Sentries stand on its west side, so pull one at a time on the way in, and hug the right wall as you enter his room so you don't pull him at once. Elite: group up if you can."] = "",

	-- Step 40: Render's Valley
	["Render's Valley"] = "",
	-- plural, as words: Blackrock Champions = {npc:435} Blackrock Champion
	["From the keep head back west along the lake's north shore and north up the Redridge Canyons to Render's Valley; Lakeshire's hand-ins wait for Keeshan's escort, which ends there. Blackrock Champions camp in the valley."] = "",
	-- {npc:435} Blackrock Champion
	["{npc:435}, below ground"] = "",

	-- Step 41: Corporal Keeshan
	-- {zone:1428} Burning Steppes
	["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to Lakeshire; Blackrock orcs ambush you on the way."] = "",
	-- {npc:349} Corporal Keeshan
	["{npc:349}, below ground"] = "",

	-- Step 42: Back to Lakeshire
	["Back to Lakeshire"] = "",
	-- {npc:900} Bailiff Conacher · {npc:344} Magistrate Solomon · {npc:382} Marshal Marris · {npc:341} Foreman Oslow · {npc:903} Guard Howe
	["Into Lakeshire from the north with Keeshan: {npc:900} and {npc:344} in the town hall, {npc:382} and {npc:341} at the north end of the bridge, then over the bridge to {npc:903} and the gryphons."] = "",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, en el ayuntamiento",
	-- {npc:903} Guard Howe
	["{npc:903}, by the gryphons south of the bridge"] = "{npc:903}, junto a los grifos al sur del puente",
	-- {zone:1431} Duskwood
	["Next: the gryphon to Darkshire for {zone:1431}'s second loop (05-duskwood)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:69}"] = "Vuelve a {area:69}",
	-- ["Bellygrub"] = "Panzallena",
	-- ["Cross the long bridge north into town. {npc:341} and {npc:382} stand at the north end of the bridge, {npc:900} in the town hall, {npc:381} and {npc:266} on the docks, {npc:343} at the inn, {npc:342} in her garden at the west end."] = "Cruza el largo puente hacia el norte hasta el pueblo. {npc:341} y {npc:382} están en el extremo norte del puente; {npc:900}, en el ayuntamiento; {npc:381} y {npc:266}, en los muelles; {npc:343}, en la posada; {npc:342}, en su huerto del extremo oeste.",
	-- ["East past the mill and across the river. Shadowhide gnolls fill the valley; {npc:703} (26, well above you) leads them at its north end: clear his escort first and fight him at full health. Stay out of {area:2099} to the south: its orcs are elite."] = "Al este, pasado el molino, cruza el río. Los gnols Pielsombra llenan el valle; {npc:703} (26, muy por encima de ti) los dirige en el extremo norte: acaba primero con su escolta y lucha contra él con la salud al máximo. No entres en {area:2099}, al sur: sus orcos son élite.",
	-- ["Fly to {area:108} and ride north-west to the coast: the {object:177790} lies on the sea floor off the shore. Then ride east along the road through Elwynn to Redridge."] = "Vuela a {area:108} y cabalga al noroeste hasta la costa: la {object:177790} está en el fondo del mar frente a la orilla. Después cabalga al este por el camino a través de Bosque de Elwynn hasta Montañas Crestagrana.",
	-- ["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} and {npc:903} stand by the road next to her."] = "Sigue el camino por la orilla sur de {area:68} hasta la maestra de grifos. {npc:1070} y {npc:903} están junto al camino, a su lado.",
	-- ["For {npc:3649}, on the return to {area:442} (06-ashenvale)"] = "Para {npc:3649}, a la vuelta a {area:442} (06-ashenvale)",
	-- ["Gnolls toward {area:1002}"] = "Gnols hacia {area:1002}",
	-- ["Greater Tarantulas crawl on the slopes around the mill north-east of the lake; Blackrock Renegades hold the mill itself."] = "Las Tarántulas mayores recorren las laderas alrededor del molino al noreste del lago; los Renegados Roca Negra ocupan el propio molino.",
	-- ["Head north out of {area:69} up the {area:95} to {area:997}. Blackrock Champions camp in the valley."] = "Sal de {area:69} hacia el norte, sube por {area:95} hasta {area:997}. Los Campeones Roca Negra acampan en el valle.",
	-- ["Keeshan hides at the very north end of the valley, by the {zone:1428} border. Escort him down to {area:69}; Blackrock orcs ambush you on the way."] = "Keeshan se esconde en el extremo norte del valle, junto a la frontera de {zone:1428}. Escóltalo hasta {area:69}; los orcos Roca Negra te tienden emboscadas por el camino.",
	-- ["Lake murlocs"] = "Múrlocs del lago",
	-- ["Murloc Flesheaters and Tidecallers line the south shore east of the bridge. Any of them can carry a {item:1467} or a fin."] = "Los Comecarnes múrloc y los llamamareas ocupan la orilla sur al este del puente. Cualquiera de ellos puede llevar un {item:1467} o una aleta.",
	-- ["Redridge Mongrels and other gnolls hold the hills east of {area:1002}, north of the road; Redridge Thrashers prowl among them, Poachers camp south of the road. Dire Condors and Great Goretusks roam the same hills."] = "Los Bastardos de Crestagrana y otros gnols ocupan las colinas al este de {area:1002}, al norte del camino; los Vándalos de Crestagrana merodean entre ellos y los furtivos acampan al sur del camino. Dire Condors y Grandes dentosangre recorren las mismas colinas.",
	-- ["Swim east from the bridge into {area:68}; the chest lies on the lake bed."] = "Nada al este desde el puente hasta {area:68}; el cofre está en el fondo del lago.",
	-- ["The Wanted poster by the inn: {npc:703}, in {area:1000}"] = "El cartel de Se busca junto a la posada: {npc:703}, en {area:1000}",
	-- ["The road from Elwynn enters Redridge at {area:1002}. {npc:464} stands where the roads to Redridge and {zone:1431} meet."] = "El camino desde Bosque de Elwynn entra en Montañas Crestagrana por {area:1002}. {npc:464} está donde se cruzan los caminos a Montañas Crestagrana y {zone:1431}.",
	-- ["The {area:442} boat docks at {area:17203}. Walk up into the city for training and {npc:1646}, then leave by the main gate and follow the road east through {zone:1429}."] = "El barco de {area:442} atraca en {area:17203}. Sube a la ciudad para entrenar y ver a {npc:1646}; después sal por la puerta principal y sigue el camino hacia el este por {zone:1429}.",
	-- ["{item:1075}: any Shadowhide gnoll"] = "{item:1075}: cualquier gnol Pielsombra",
	-- ["{item:280911}: Redridge Thrashers"] = "{item:280911}: Vándalos de Crestagrana",
	-- ["{item:3014}: any Blackrock orc"] = "{item:3014}: cualquier orco Roca Negra",
	-- ["{item:3014}: the Blackrock Renegades at the mill"] = "{item:3014}: los Renegados Roca Negra del molino",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: la carta de Thundris desde {area:442}",
	-- ["{npc:266}, by the docks"] = "{npc:266}, junto a los muelles",
	-- ["{npc:332} is at SI:7 in {object:2100}, {npc:6122} in the {object:2164}'s cellar in the {object:2101}, {npc:376} in the Cathedral of Light."] = "{npc:332} está en el IV:7 de {object:2100}; {npc:6122}, en el sótano de {object:2164}, en {object:2101}; {npc:376}, en la catedral.",
	-- ["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}"] = "{npc:332}: la recoge {npc:7024} en {zone:1436}, al final de {zone:1431}",
	-- ["{npc:341}: after {quest:89}"] = "{npc:341}: después de {quest:89}",
	-- ["{npc:344}, in the town hall"] = "{npc:344}, en el ayuntamiento",
	-- ["{npc:345} (level 24) roots around the pen just west of {area:69}. Pull him away from the other boars and fight at full health."] = "{npc:345} (nivel 24) hoza en el corral justo al oeste de {area:69}. Apártalo de los demás jabalíes y lucha con la salud al máximo.",
	-- ["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: la recoge {npc:11401} en {zone:1457}, más adelante",
	-- ["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: la recoge {npc:11406} en {zone:1455}, más adelante",
	-- ["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: la recoge {npc:258785} en {zone:1455}, más adelante",
	-- ["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: la recoge {npc:6244} en {zone:1413}, más adelante",
	-- ["{zone:1431} is next: follow the road west to {area:1002}, then south to {area:42}."] = "Ahora toca {zone:1431}: sigue el camino al oeste hasta {area:1002} y luego al sur hasta {area:42}.",
	-- ["{zone:1453} class quests"] = "Misiones de clase de {zone:1453}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} no tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y vuelve en el tranvía.",
}
