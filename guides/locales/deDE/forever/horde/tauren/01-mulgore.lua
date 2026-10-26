-- German (deDE): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "Du beginnst auf dem Tafelberg von {area:221}. {npc:2980} und der Häuptling stehen beim großen Zelt in der Mitte.",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "Ebenenschreiter streifen überall ums Lager durchs Gras.",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "{npc:3059}, der Kriegerlehrer",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "{npc:3061}, die Jägerlehrerin",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "{npc:3062}, die Schamanenlehrerin im Lager",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "{npc:3060}, der Druidenlehrer neben ihr",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {object:2907} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {object:2907} stands next to her."] = "{npc:2991} sitzt beim Zelt am Ostrand des Lagers; {object:2907} steht neben ihr.",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775} steht am Westende des Lagers, an der Nordwestecke der Hügel, wo die Bergpumas umherstreifen: Nimm seine Quest an, jag die Pumas von dort nach Süden und Osten und komm dann zurück hinauf zu {npc:2980}.",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}, neben {npc:2980}",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "Folge dem Pfad nach Süden aus dem Lager zum Zelt des Sehers am Fuß der Hügel.",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "Der Schrein von An'she und Mu'sha",
	-- {object:660739} Ritual Fire
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "Der Weihrauch brennt in zehn Minuten ab: Lauf an den südlichen Hügeln entlang direkt nach Osten zum {object:660739}.",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "Kampfeber grasen nördlich des Schreins; die Stacheleber der Borstennacken halten die Schlucht im Nordosten. {npc:8554} steht an ihrem östlichen Ende, und {object:3076} liegt im Lager auf dem Boden.",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "Zurück nach Westen zum Lager.",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888} steht im {area:221}. {quest:1516} erfordert Stufe 4, die du mit den Abgaben hier erreichst.",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "Zurück nach Osten zur {area:358}: Die Schamanen der Borstennacken stehen dort zwischen den Stacheleber.",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "Zurück zu {npc:5888} im Lager. {npc:5891} wartet auf dem Tafelberg östlich des Lagers: Trink dort {item:6635}, um sie zu sehen, und bring dann {item:6656} zurück zum Seher.",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}: {npc:5873} und dein {item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "Folge der Straße nach Norden aus {area:220}. {npc:265810} wartet auf der Straße gleich südlich von {area:222}; /sit an ihrem Lagerfeuer, bis du {spell:1229451} bekommst.",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "/sit an Kagas Lagerfeuer, bis du {spell:1229451} bekommst",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "Sprich mit {npc:3067}",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "Präriewölfe und Erwachsene Ebenenschreiter streifen über die Ebenen ums Dorf.",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "Der Brunnen liegt südöstlich des Dorfs.",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130} und {quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "{quest:96130}, ein einsamer Wolf, streift über die Ebenen westlich des Dorfs. Präriepirscher und Flachlandpumas streifen über die Ebenen nördlich und westlich davon.",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "Zurück nach Bloodhoof",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "Die Quest von {npc:3063}: Besiege drei Kriegernovizen (oder Spieler im Duell) neben ihm.",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182} steht am Nordrand des Dorfs. Kyle will {item:287505} von Ebenenschreitern.",

	-- Step 26: Thunderhorn Water Well
	-- {object:2912} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {object:2910} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {object:2912} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Der Brunnen liegt nördlich des Dorfs. Quellsteine liegen um den Brunnen, {object:2912} unter den Bäumen in der Nähe. Töte unterwegs Wölfe, Pumas, Ebenenschreiter und Sturzflieger für {quest:766} und {quest:761}.",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}, am Nordende des Dorfs",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "Sturzflieger gleiten überall um Bloodhoof über die Ebenen.",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988} lagert beim {area:396} südöstlich von Bloodhoof.",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789} steht auf den {area:821} ein Stück östlich des Brunnens.",

	-- Step 31: Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas"] = "Präriewolfalphas",
	-- {npc:275789} Malah Longwind
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Prairie Wolf Alphas roam among the wolves on the plains around {npc:275789} and the Galak camp to the east."] = "Präriewolfalphas streifen zwischen den Wölfen auf den Ebenen um {npc:275789} und das Lager der Galak im Osten umher.",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "Die zerstörte Karawane liegt nordwestlich der Zentauren, östlich der Straße nach {zone:1456}.",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "Sammle das restliche Wolfsherz, den Pumaknochen, die Ebenenschreiterschuppe und den Sturzfliegermagen auf den Ebenen ums Dorf.",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "Zurück nach Südosten zum {area:396}.",

	-- Step 37: Galak centaurs
	["Galak centaurs"] = "Zentauren der Galak",
	-- {npc:275767} Herak the Pillager
	["The Galak centaurs camp on the plains east of the well; {npc:275767} leads them."] = "Die Zentauren der Galak lagern auf den Ebenen östlich des Brunnens; {npc:275767} führt sie an.",

	-- Step 38: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "Die Goblins arbeiten in der Mine in den Hügeln nordöstlich des Brunnens. {quest:765} steht hinten in der Mine; seine {item:281031} starten {quest:98424}, und die anderen Seiten liegen in der Mine.",

	-- Step 39: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "Zieh nach Nordwesten an {zone:1456} vorbei zum {area:398} im äußersten Norden von {zone:1412}.",

	-- Step 40: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "Die Harpyien der Windfurien halten {area:819}, nördlich und westlich des Brunnens.",

	-- Step 41: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984} steht am Rand der {area:404}, südlich des Brunnens.",

	-- Step 42: Dwarven Digging
	-- {area:404} Bael'dun Digsite
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the dwarves' forge in the digsite."] = "Die Zwerge der {area:404} tragen die Ausgrabungsleiterhacken. Zerschlag sie an der Schmiede der Zwerge in der Ausgrabungsstätte.",
	-- {item:4703} Broken Tools
	["{item:4703}, at the digsite forge"] = "{item:4703}, an der Schmiede der Ausgrabungsstätte",

	-- Step 43: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "Die Gnolle der Bleichmähnen halten den {area:818}, südlich der Grabungsstätte und westlich von Bloodhoof. {npc:272203} wird in ihrem Lager festgehalten: Führ ihn hinaus.",

	-- Step 44: Bloodhoof Village
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}, für {npc:3057} in {zone:1456}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}, für Hamuul in {zone:1456}",

	-- Step 46: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "Geh nach Norden zu {area:225}, östlich von {zone:1456}. {npc:3233} steht am Fuß der Felsen; die Eindringlinge der Borstennacken graben auf der Grabstätte, und {npc:2994} wartet oben.",
	-- {item:5203} Flatland Prowler Claw · {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["{item:5203}: Flatland Prowlers roam the plains around {area:225}"] = "{item:5203}: Flachlandstreuner streifen über die Ebenen um {area:225}",

	-- Step 47: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "Fahr mit einem Aufzug hinauf zu den Tafelbergen. {npc:2995} hält die Windreiter auf der mittleren Anhöhe; {npc:3057} steht dort im großen Zelt.",

	-- Step 48: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} will Taurenweihrauch: Kauf seine vier Teile bei {npc:3014}, der Kräuterhändlerin, {npc:3012}, der Händlerin für Verzauberkunstbedarf, {npc:3005}, dem Händler für Lederverarbeitungsbedarf, und {npc:3027}, dem Händler für Kochbedarf, und kombiniere sie dann zu {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, von {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, von {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, von {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, von {npc:3027}",

	-- Step 49: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Benutze {item:278078} an der Zeremonienmatte und dem Räuchergefäß an der Südklippe der {area:1641}.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Verstreu {item:278078} von der {area:1641}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}: für {quest:860} in {area:380}",

	-- Step 51: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}: für {npc:3448} in {area:380}",

	-- Step 53: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "{npc:6746} auf der mittleren Anhöhe schickt dich zu {npc:3033} auf der {area:1639}.",

	-- Step 54: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}; {quest:5930} sitzt im Wald im Nordwesten.",

	-- Step 55: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and head north to {area:1639}."] = "Kehr per Ruhestein nach {area:222} zurück und geh nach Norden zum {area:1639}.",

	-- Step 56: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Head down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Geh hinunter nach {area:222} und zähme mit {item:15908}: einen {npc:2956} auf den Ebenen, einen {npc:2959} nördlich des Dorfes, einen Sturzflieger im Nordwesten.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Zähm ihn mit {item:15908}",

	-- Step 57: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "Der Stein steht im Pass aus {zone:1412} hinaus, auf deinem Weg nach Osten. Benutze dort {item:15710} und besiege Mondklaue.",

	-- Step 58: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "Verlass {zone:1412} durch den südöstlichen Pass und folge der Straße nach {area:380}. {quest:860} steht beim Gasthaus, {npc:3448} am Südtor. Hier beginnt der Guide für das {zone:1413}.",

	-- Step 59: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "Klassenabgaben in {area:1638}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "Kampfeber grasen nördlich des Schreins; die Stacheleber der Borstennacken halten die Schlucht im Nordosten. {npc:8554} steht an ihrem östlichen Ende, und {item:4851} liegt im Lager auf dem Boden.",
	-- ["Flatland Prowlers roam the plains around {area:225}"] = "Flachlandstreuner streifen über die Ebenen um {area:225}",
	-- ["Galak centaurs and Prairie Wolf Alphas"] = "Zentauren der Galak und Präriewolfalphas",
	-- ["Hearth to {area:222} and ride north to {area:1639}."] = "Ruhestein nach {area:222} und reite nach Norden zur {area:1639}.",
	-- ["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "Reite hinunter nach {area:222} und zähm mit {item:15908}: einen {npc:2956} auf den Ebenen, einen {npc:2959} nördlich des Dorfs und einen Sturzflieger im Nordwesten.",
	-- ["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "Die Zentauren der Galak lagern auf den Ebenen nördlich der {area:821}; Herak führt sie an. Präriewolfalphas streifen zwischen den Wölfen umher.",
	-- ["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "Die Zwerge der {area:404} tragen die Ausgrabungsleiterhacken. Zerschlag sie an der Schmiede in {area:222}.",
	-- ["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "Der Brunnen liegt nördlich des Dorfs. Quellsteine liegen um den Brunnen, {item:4809} unter den Bäumen in der Nähe. Töte unterwegs Wölfe, Pumas, Ebenenschreiter und Sturzflieger für {quest:766} und {quest:761}.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991} sitzt beim Zelt am Ostrand des Lagers; {item:4755} steht neben ihr.",
}
