-- German (deDE): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "Du beginnst am Fuß von {area:256}, dem großen Baum von {area:188}.",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}, am Pfad",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}, südlich des Baums",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "",
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Junge Nachtsäbler und Junge Disteleber streifen um {area:256} herum. Grells tragen {item:3297} in den Wäldern westlich des Baums, wo die Totems der Knarzklauen stehen.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "Zurück bei {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: ein Siegel für {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}, auf der Rampe des Baums",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: Wirke {spell:1259799} und Schattenmimik, dann gib sie bei {npc:3595} ab",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}, östlich des Baums",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "Nach Norden zur {area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "",

	-- Step 5: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}, die Jägerlehrerin",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}, der Schurkenlehrer",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595}, die Priesterlehrerin: durch den Vordereingang des Baums hinein und die Rampe hinauf",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}, der Druidenlehrer bei {area:256}",

	-- Step 6: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} und das Gegengift",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "Die {object:4406} liegen hinten in der {area:257}: Nimm den mittleren Pfad, dann links an der Gabelung, hinauf zum hohen Felsvorsprung. Hyazinth-Pilze lassen Grells fallen, Mondblütenlilien wachsen an den Teichen nördlich von {area:256}.",
	["Grells"] = "",

	-- Step 8: Shadowglen
	["Below ground"] = "",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "",

	-- Step 9: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}, oben im Baum",

	-- Step 10: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "Der Mondbrunnen und {npc:8584}",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Benutze die {item:5185} am Mondbrunnen",

	-- Step 11: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "Zurück nach oben auf {area:256}. Die {object:654846} liegt neben ihm.",
	["Upstairs"] = "",
	-- {object:654846} Lost Journal
	["{object:654846}, upstairs"] = "",

	-- Step 12: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "",

	-- Step 13: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Verlass {area:188} über den Pfad südöstlich von {area:256}: {npc:6780} steht daneben, wo er hinab zur Straße nach {area:186} führt.",

	-- Step 14: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "Folge der Straße nach Südwesten aus {area:188} hinaus. {npc:2150} sitzt daneben gleich östlich von {area:186}.",

	-- Step 15: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}, am Lagerfeuer",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "/sit an {npc:265811}s Lagerfeuer, bis du {spell:1229451} erhältst",
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "",

	-- Step 17: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}, südlich des Gasthauses",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "",

	-- Step 18: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} patrouilliert auf der Straße westlich des Dorfs: Wenn sie nicht beim Pfeil ist, folge der Straße, bis du sie triffst.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}, an der Straße westlich des Dorfs",

	-- Step 19: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "",
	["Nightsabers"] = "Nachtsäbler",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Waldweberlauerer",

	-- Step 20: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "",

	-- Step 21: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Benutze die {item:5619} am Mondbrunnen",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "",

	-- Step 22: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: {quest:922} in {zone:1457} nimmt sie an",

	-- Step 24: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Eingang des {area:258}",

	-- Step 25: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} wartet in der Höhle, unten oder oben auf dem Felsvorsprung; halte dich rechts.",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "",

	-- Step 26: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "Die Straße nach {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Wegelagerer der Knarzklauen verstecken sich entlang der Straße westlich des {area:258}.",

	-- Step 27: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road to the city gate: Shayla stands beside it. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "",

	-- Step 28: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "",
	["the city gate"] = "",

	-- Step 29: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "",

	-- Step 30: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs."] = "",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Schamanen der Knarzklauen",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "",

	-- Step 31: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Eskortiere {npc:275744} aus dem Grabhügel; {npc:2081} in {area:186} nimmt den Bericht an.",
	["Walk Lynessa out and keep her alive"] = "Führ Lynessa hinaus und halte sie am Leben",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}, außerhalb des Grabhügels",

	-- Step 32: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "Die {area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "Südwestlich des Grabhügels. Der Mondbrunnen liegt bei den Teichen.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Benutze die {item:5621} am Mondbrunnen",

	-- Step 33: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "",

	-- Step 35: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "",

	-- Step 36: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}, von {npc:7234}",

	-- Step 37: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "",

	-- Step 38: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["West along the road from {area:186}: Shayla still stands beside it, before the turn north to the glade."] = "",

	-- Step 39: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "",
	-- {area:265} Wellspring River
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor
	["North from the road the path to the glade crosses the {area:265}: the timberlings along it drop the Mossy Tumors."] = "",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "",

	-- Step 40: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "Der Mondbrunnen liegt mitten auf der Lichtung. Die {object:6752} wächst an ihrem Nordende.",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}, am Mondbrunnen",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "Benutze die {item:18152} am Mondbrunnen",

	-- Step 41: Bloodfeather harpies
	["Bloodfeather harpies"] = "Harpyien der Blutfedern",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "",

	-- Step 42: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "Zurück zum Mondbrunnen.",

	-- Step 43: The named harpies
	["The named harpies"] = "Die benannten Harpyien",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} und {npc:272044} fliegen gleich westlich des Mondbrunnens, {npc:272046} weiter nördlich.",

	-- Step 44: Lady Sathrah
	-- {object:6752} Strange Fronded Plant · {npc:272046} Witchmother Arysa · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north of {npc:272046}, along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "",

	-- Step 45: Sentinel Arynia again
	["Sentinel Arynia again"] = "Wieder zu Schildwache Arynia",
	-- {object:673378} Oracle Tree Bark
	["{object:673378}, just west of the moonwell"] = "{object:673378}, gleich westlich des Mondbrunnens",
	-- {object:673378} Oracle Tree Bark · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "",

	-- Step 46: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}.\nCareful: Gnarlpine of roughly level 9-12 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "",

	-- Step 47: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "Von Ursals Bau nach Nordosten, zurück nach {area:186}.",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{item:3371} von {npc:3614}, neben {npc:6094}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}: {npc:11401} in {zone:1457} nimmt sie an",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{item:159} von {npc:6736}, für {npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "Fandral in {zone:1457} nimmt sie an",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}: {npc:4217} in {zone:1457} nimmt sie an",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "",

	-- Step 48: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "Südöstlich von Dolanaar, zu {npc:2080}. Wildschlagsetzlinge wandern am Ufer um ihn herum.",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}, neben ihm",

	-- Step 49: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "Wieder {area:186}",
	-- {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["{npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "",

	-- Step 50: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Jede Quest von Dazalar gibt dir eine {item:15908}: Benutze sie an dem Wildtier, das er nennt, und bring den Stab dann zu ihm nach {area:186} zurück. Waldweberlauerer schleichen um das Dorf, Pirschende Nachtsäbler und Strigidkreischer streifen durch die Wälder südlich davon.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}: Zähme ihn mit der {item:15908}",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}: Zähme ihn mit der {item:15908}",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}: Zähme ihn mit der {item:15908}",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "{npc:4146} in {zone:1457} nimmt sie an",

	-- Step 51: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Nimm wieder die Straße von {area:186} nach Nordwesten; sie liegt noch daneben, auf dem Weg nach {zone:1457}.",

	-- Step 52: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "",

	-- Step 54: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "",

	-- Step 55: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "",

	-- Step 57: Darnassus
	-- {zone:1457} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "",

	-- Step 59: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}, im {area:1658}",

	-- Step 60: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}, in {area:1658}: {spell:5149}",

	-- Step 62: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}, im {area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}, im Tempel des Mondes",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}, über {npc:4092}",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}, im Tempel des Mondes: Sternensplitter",

	-- Step 63: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 64: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 65: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "",

	-- Step 66: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "Nimm das Portal hinunter nach {area:702}. {npc:10118} steht am Steg, {npc:3838} bei den Hippogryphen. Hast du {quest:6342}, sprich noch einmal mit {npc:3838} und wähle den Flug nach {area:442}: Er ist kostenlos und landet neben {npc:4200}. Öffnet sich stattdessen die Flugkarte, schließe sie und sprich noch einmal mit ihm, während du Umschalt gedrückt hältst.",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "sprich noch einmal mit {npc:3838}: kostenlos mit {quest:6342}",

	-- Step 67: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "",
	["The WANTED poster outside the inn"] = "Der Steckbrief vor dem Gasthaus",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "",

	-- Step 68: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "",

	-- Step 69: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Gezeitenkriecher krabbeln unterhalb des Dorfes am Ufer entlang; {quest:983} steht am Strand gleich südlich der Anlegestelle. Dunkelküstendrescher schwimmen im seichten Wasser. {object:175207} liegt gleich südlich des Dorfes am Ufer.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "",

	-- Step 70: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, am Nordende des Dorfes",

	-- Step 71: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Sprich mit dem {quest:5929}",

	-- Step 73: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "{npc:10118} steht am Steg von Rut'theran, wo du landest. Nimm dann das Portal hinauf zu {npc:4217} in der {area:1658}.",

	-- Step 76: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "Der {object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Geh zurück hinab nach {area:702} und flieg nach {area:442}. Der {object:177525} steht in den Hügeln gleich östlich des Dorfs: Benutze dort den {item:15208}, besiege Mondklaue und sprich mit dem {npc:12144}.",

	-- Step 77: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "Boot nach {zone:1453}",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}; {quest:5929} steht in den Wäldern im Nordwesten. Lerne den Flugpunkt {area:493} in {area:2361} und flieg nach {area:702} (über {area:442}).",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Jede Quest von {npc:3601} gibt dir eine {item:15908}: Benutze sie an dem Wildtier, das er nennt, und bring den Stab dann zu ihm nach {area:186} zurück. Waldweberlauerer schleichen um das Dorf, Pirschende Nachtsäbler und Strigidkreischer streifen durch die Wälder südlich davon.",
	-- ["East to {area:260}"] = "Nach Osten nach {area:260}",
	-- ["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "Teufelszapfen liegen unter den Bäumen rund um {area:186} und {npc:2150}. Nachtsäbler und Waldweberlauerer streifen weiter entlang der Straße nach Osten. {object:126158} ist im Haus auf dem Hügel am Ostende des Dorfs.",
	-- ["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442} for the boat."] = "Flieg von {npc:3841} zurück nach {area:702}, gib {item:16263} bei {npc:10118} am Steg ab und flieg dann zurück nach {area:442} zum Schiff.",
	-- ["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "Flieg noch einmal nach {area:702} und nimm das Portal hinauf zu {npc:4217}, dann flieg zurück nach {area:442} zum Boot.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "Folge der Straße nach Südwesten aus {area:188} hinaus nach {area:186}.",
	-- ["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "Folge der Straße nach Westen nach {zone:1457}. {npc:4241} steht auf der {area:1659} gleich hinter dem Stadteingang. {npc:3516} ist im {area:1658} am Nordende der Stadt, {quest:922} gleich südlich davon; {npc:4092} und {npc:7999} sind im Tempel des Mondes am Südende. {npc:7316} ist im Westen der Stadt, auf dem Weg zum rosa Portal hinab nach Rut'theran.",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Geh vom Hafen in {object:2100}. {npc:5480} bildet dort Krieger aus; {npc:6089} und {npc:6090} stehen zusammen beim {object:2152}. {npc:6090} kämpft mit dir um seinen Krug.",
	-- ["From {area:17203}, head through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "Geh von {area:17203} durch die Stadttore nach {zone:1429} und folge der Straße nach Westen nach {zone:1436}.",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "Reite vom {area:17203} durch die Stadttore in den {zone:1429} und folge der Straße nach Westen nach {zone:1436}.",
	-- ["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "Mystiker der Knarzklauen und Ferocitas der Traumfresser lagern nordöstlich von {area:260}. Ferocitas lässt den {item:8049} fallen: Öffne ihn für das Juwel.",
	-- ["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel."] = "Mystiker der Knarzklauen und {npc:7234} lagern nordöstlich von {area:260}. {npc:7234} lässt {item:8049} fallen: Öffne sie für das Juwel.",
	-- ["Hearth to {area:186}"] = "Ruhestein nach {area:186}",
	-- ["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks."] = "Lerne den Flugpunkt bei {npc:3841}, wo du landest. Der Fischstand von {npc:4200} ist direkt nördlich von ihr, bei den Docks.",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Hol dir die Flugroute von {area:442} auf dem Hügel südlich des Gasthauses, dann wirke {spell:18960}. {npc:11802} ist in {area:2361}; {quest:5929} sitzt im Wald im Nordwesten. Hol dir die Flugroute von {area:493} in {area:2361} und flieg nach {area:702} (über {area:442}).",
	-- ["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "Räudige Nachtsäbler und Disteleber streifen nördlich von {area:256} umher, auf dem Weg zur Höhle. {npc:8584} wartet zwischen den Bäumen westlich des Höhleneingangs; {npc:1994} sitzt tief drinnen.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Nachtsäbler, Strigideulen und Waldweberlauerer leben entlang der Straße nach Osten. Der Mondbrunnen liegt am Westrand von {area:260}.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "Nachtsäbler, Strigideulen und Waldweberlauerer streifen rund um {area:186} und entlang der Straße nach Osten umher. Der Mondbrunnen liegt am Westrand von {area:260}.",
	-- ["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Südlich von Zenn. {npc:2080} pflegt seine Setzlinge am Ufer; Wildschlagsetzlinge und Bäumlinge wandern um ihn herum, und die {quest:919} wachsen zwischen ihnen.",
	-- ["South of the pools. The {object:6751} grows by the Hold."] = "Südlich der Teiche. Die {object:6751} wächst bei der Höhle der Knarzklauen.",
	-- ["Speak with {npc:6286}, south of the inn"] = "Sprich mit {npc:6286}, südlich des Gasthauses",
	-- ["Take the boat to {zone:1453} from {area:442}'s docks."] = "Nimm das Schiff nach {zone:1453} von den Docks von {area:442}.",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Nimm das Portal hinab nach {area:702}. {npc:10118} steht am Steg, {npc:3838} bei den Hippogryphen.",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Nimm das Portal von {area:702} hinauf zu {npc:4217} im {area:1658}.",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Nimm die Straße von {area:186} nach Nordwesten in Richtung {area:264}; sie liegt verletzt daneben.",
	-- ["Talk to {npc:6286}"] = "Sprich mit {npc:6286}",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "Die Harpyien der Blutfedern nisten an den Hängen westlich und nördlich der Lichtung.",
	-- ["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "Der Grabhügel liegt südlich der Straße. {npc:275744} wird darin festgehalten, {npc:7317} schläft in seinen Tiefen, und die vier Reliquientruhen stehen in den unteren Räumen.",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "Der Mondbrunnen liegt nördlich von {area:256}; {npc:8584} ist etwas weiter nordwestlich. {quest:3522} dauert fünf Minuten: Füll die Phiole und geh direkt weiter zu ihm.",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Geh an der Westseite der Insel entlang nach Süden. Ursal der Raufer streift durch den äußersten Süden, unterhalb der {area:478}.",
	-- ["Webwood Spiders"] = "Waldweberspinnen",
	-- ["{area:186} quests"] = "Quests in {area:186}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}, im Tempel des Mondes: {spell:10797}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150} sitzt an der Straße gleich östlich von {area:186}, auf dem Weg nach {area:260}.",
	-- ["{npc:2150}, on the way back"] = "{npc:2150}, auf dem Rückweg",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567}, zurück in {area:186}",
	-- ["{npc:3593}, the warrior trainer"] = "{npc:3593}, die Kriegerlehrerin",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}, im Baum",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}, die Priesterlehrerin, im Baum",
	-- ["{npc:3595}: in at the tree's front entrance and up the ramp"] = "{npc:3595}: durch den Vordereingang des Baums hinein und die Rampe hinauf",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "Der Fischstand von {npc:4200} ist bei den Docks. Nimm dann das Boot nach {zone:1453}.",
	-- ["{npc:7318}, in the den"] = "{npc:7318}, im Bau",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488} und der Mondbrunnen von Starbreeze",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}: Wirke {spell:1259799} und {spell:20580}, dann gib sie bei {npc:3595} ab",
}
