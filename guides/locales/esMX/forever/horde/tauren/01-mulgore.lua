-- Spanish (Latin America) (esMX): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Empiezas en la meseta de {area:221}. {npc:2980} y el jefe están junto a la gran tienda del centro.",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "Los zancudos de llanura deambulan por el pasto alrededor del campamento.",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "{npc:3059}, el instructor de guerreros",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, la instructora de cazadores",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, la instructora de chamanes del campamento",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, el instructor de druidas a su lado",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {object:2907} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {object:2907} stands next to her."] = "{npc:2991} está sentada junto a la tienda del borde este del campamento; {object:2907} está a su lado.",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} está en el extremo oeste del campamento, en la esquina noroeste de las colinas donde merodean los Pumas monteses ({npc:2961}): acepta su misión, caza los pumas desde allí hacia el sur y el este, y luego regresa con {npc:2980}.",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, junto a {npc:2980}",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Sigue el sendero al sur fuera del campamento hasta la tienda del Vidente, al pie de las colinas.",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "El santuario de An'she y Mu'sha",
	-- {object:660739} Ritual Fire (no name in this language: may be words)
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "El incienso se consume en diez minutos: corre directo al este por las colinas del sur hasta {object:660739}.",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "Los jabaguerreros pastan al norte del santuario; los jabaespines Erizapúas ocupan el barranco al noreste. {npc:8554} está en su extremo este y {object:3076} está en el suelo del campamento.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "De vuelta al oeste al campamento.",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888} está en {area:221}. {quest:1516} necesita nivel 4, que alcanzas con las entregas de aquí.",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "De vuelta al este a {area:358}: los Chamanes Erizapúas ({npc:2953}) están entre los jabaespines de allí.",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "De vuelta con {npc:5888} en el campamento. La {npc:5891} espera en la meseta al este del campamento: bebe {item:6635} allí para verla y luego llévale {item:6656} al Vidente.",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}: {npc:5873} y tu {item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "Sigue el camino al norte fuera de {area:220}. {npc:265810} espera en el camino justo al sur de {area:222}; usa /sentarse junto a su fogata hasta obtener {spell:1229451}.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "Usa /sentarse junto a la fogata de Kaga hasta obtener {spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "Habla con {npc:3067}",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Los lobos de pradera y los Zancudos de llanura adultos ({npc:2956}) deambulan por las llanuras alrededor del poblado.",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "El pozo está al sureste del poblado.",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130} y {quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, un lobo solitario, merodea las llanuras al oeste del poblado. Los Acechadores de pradera ({npc:2959}) y los Pumas de las estepas ({npc:3035}) recorren las llanuras al norte y al oeste.",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "De vuelta a Poblado Pezuña de Sangre",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Misión de {npc:3063}: vence a tres Guerreros novicios ({npc:10721}) (o a jugadores en duelos) a su lado.",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} está en el borde norte del poblado. Kyle quiere {item:287505} de los zancudos de llanura.",

	-- Step 26: Thunderhorn Water Well
	-- {object:2912} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {object:2910} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "El pozo está al norte del poblado. Las Piedras de pozo están alrededor del pozo y {object:2912} está bajo los árboles cercanos. Mata lobos, pumas, zancudos y aguilones en el camino para {quest:766} y {quest:761}.",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, en el extremo norte del poblado",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "Los aguilones planean sobre las llanuras alrededor de Poblado Pezuña de Sangre.",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} acampa junto a {area:396}, al sureste de Poblado Pezuña de Sangre.",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} está en {area:821}, un poco al este del pozo.",

	-- Step 31: Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas"] = "Lobos alfa de pradera",
	-- {npc:275789} Malah Longwind
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas roam among the wolves on the plains around {npc:275789} and the Galak camp to the east."] = "Los Lobos alfa de pradera recorren la zona entre los lobos de las llanuras alrededor de {npc:275789} y del campamento Galak al este.",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "La caravana destrozada está al noroeste de los centauros, al este del camino a {zone:1456}.",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Termina el corazón de lobo, el fémur de puma, la escama de zancudo y la molleja de aguilón en las llanuras alrededor del poblado.",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "De vuelta al sureste a {area:396}.",

	-- Step 37: Galak centaurs
	["Galak centaurs"] = "Centauros Galak",
	-- {npc:275767} Herak the Pillager
	["The Galak centaurs camp on the plains east of the well; {npc:275767} leads them."] = "Los centauros Galak acampan en las llanuras al este del pozo; {npc:275767} los dirige.",

	-- Step 38: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Los goblins trabajan la mina en las colinas al noreste del pozo. {quest:765} está al fondo de la mina; sus {item:281031} inician {quest:98424}, y las otras páginas están dentro de la mina.",

	-- Step 39: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Cruza al noroeste pasando {zone:1456} hasta {area:398}, en el extremo norte de {zone:1412}.",

	-- Step 40: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "Las arpías Viento Furioso ocupan {area:819}, al norte y al oeste del pozo.",

	-- Step 41: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} está al borde de {area:404}, al sur del pozo.",

	-- Step 42: Dwarven Digging
	-- {area:404} Bael'dun Digsite
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the dwarves' forge in the digsite."] = "Los enanos de {area:404} llevan los Picos de prospector. Destrúyelos en la forja de los enanos de la excavación.",
	-- {item:4703} Broken Tools
	["{item:4703}, at the digsite forge"] = "{item:4703}, en la forja de la excavación",

	-- Step 43: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Los gnolls Crines Pálidas ocupan {area:818}, al sur de la excavación y al oeste de Poblado Pezuña de Sangre. {npc:272203} está cautivo en su campamento: guíalo afuera.",

	-- Step 44: Bloodhoof Village
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, para {npc:3057} en {zone:1456}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, para Hamuul en {zone:1456}",

	-- Step 46: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Ve al norte hasta {area:225}, al este de {zone:1456}. {npc:3233} está al pie de las rocas; los Intrusos Erizapúas ({npc:3232}) excavan en el cementerio y el {npc:2994} espera en la cima.",
	-- {item:5203} Flatland Prowler Claw · {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["{item:5203}: Flatland Prowlers roam the plains around {area:225}"] = "{item:5203}: los merodeadores de las estepas recorren las llanuras alrededor de {area:225}",

	-- Step 47: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Sube en un elevador a las mesetas. {npc:2995} cuida a los jinetes del viento en la elevación central; {npc:3057} está en la gran tienda de allí.",

	-- Step 48: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} quiere incienso tauren: compra sus cuatro partes a {npc:3014} la herbolaria, a {npc:3012} la proveedora de encantamiento, a {npc:3005} la proveedora de peletería y a {npc:3027} el proveedor de cocina; luego combínalas en {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, de {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, de {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, de {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, de {npc:3027}",

	-- Step 49: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Usa {item:278078} en la estera ceremonial y el quemador del acantilado sur de {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Esparce {item:278078} desde {area:1641}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}: para {quest:860} en {area:380}",

	-- Step 51: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}: para {npc:3448} en {area:380}",

	-- Step 53: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746}, en la elevación central, te manda con {npc:3033} en {area:1639}.",

	-- Step 54: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}; {quest:5930} está en el bosque del noroeste.",

	-- Step 55: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "Usa tu piedra de hogar para ir a {area:222} y cabalga al norte hasta {area:1639}.",

	-- Step 56: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Baja cabalgando a {area:222} y domestica con {item:15908}: un {npc:2956} en las llanuras, un {npc:2959} al norte del poblado y un aguilón al noroeste.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestícalo con {item:15908}",

	-- Step 57: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "La piedra está en el paso que sale de {zone:1412}, de camino al este. Usa {item:15710} allí y derrota a Garraluna.",

	-- Step 58: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Sal de {zone:1412} por el paso del sureste y sigue el camino hasta {area:380}. {quest:860} está junto a la posada y {npc:3448}, en la puerta sur. La guía de {zone:1413} empieza aquí.",

	-- Step 59: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "Entregas de clase en {area:1638}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "Los jabaguerreros pastan al norte del santuario; los jabaespines Erizapúas ocupan el barranco al noreste. {npc:8554} está en su extremo este y {item:4851} está en el suelo del campamento.",
	-- ["Flatland Prowlers roam the plains around {area:225}"] = "Merodeadores de las estepas ({npc:3566}) recorren las llanuras alrededor de {area:225}",
	-- ["Galak centaurs and Prairie Wolf Alphas"] = "Centauros Galak y Lobos alfa de pradera ({npc:2960})",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Los centauros Galak acampan en las llanuras al norte de {area:821}; Herak los dirige. Los Lobos alfa de pradera ({npc:2960}) recorren la zona entre los lobos.",
	-- ["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Los enanos de {area:404} llevan los Picos de prospector ({item:4702}). Destrúyelos en la forja de {area:222}.",
	-- ["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "El pozo está al norte del poblado. Las Piedras de pozo ({item:4808}) están alrededor del pozo y {item:4809} está bajo los árboles cercanos. Mata lobos, pumas, zancudos y aguilones en el camino para {quest:766} y {quest:761}.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} está sentada junto a la tienda del borde este del campamento; {item:4755} está a su lado.",
}
