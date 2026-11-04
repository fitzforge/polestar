-- German (deDE): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {area:361} Felwood · {area:618} Winterspring
	["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "",

	-- Step 1: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 2: To Ratchet
	-- {area:392} Ratchet
	["To {area:392}"] = "",

	-- Step 3: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:415} Astranaar · {area:361} Felwood
	["Ride north out of {area:415} into {area:361} to the druids' camp on the road just past the border."] = "",
	["Inside"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Warte kurz auf {npc:9116}",

	-- Step 6: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Kohlenbecken in {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Angerclaw bears and Felpaw wolves"] = "Wutklauenbären und Teufelspfotenwölfe",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "",

	-- Step 8: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Folge der Straße nach Norden zum {area:1767}. Die Donnerstampfer der Eisenstämme tragen das Herz; sammle die restlichen Klauen bei den Wutklauengrizzlys und Teufelspfotenverheerern im Norden.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Donnerstampfer der Eisenstämme",

	-- Step 9: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "",

	-- Step 10: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Reite nach Norden zum Dorf der Furbolgs der Totenwaldfelle beim Höhleneingang der {area:1769}.",
	-- {object:176091} Deadwood Cauldron · {area:618} Winterspring
	["{object:176091}, if you found the Firewater flask in {area:618}"] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {area:618} Winterspring
	["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "",

	-- Step 11: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "",

	-- Step 12: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Reite die Straße zurück nach Süden zum Refugium.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Behalte {item:11169}, die Klauen und das Herz, die er dir zurückgibt",

	-- Step 14: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "",

	-- Step 15: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Ruhestein nach {area:392} und flieg nach {area:976}. Kauf hier im Auktionshaus zwei Thoriumbarren für {quest:5801}.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 16: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Reite nach Osten in die Hügel. Benutze {item:11169}, um {quest:4005} zu beschwören, und besiege ihn für das Totem.",

	-- Step 17: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Reite nach Südwesten zum Lager von {npc:7771} bei {area:1938}.",

	-- Step 19: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Nimm die Straße nach Westen hinab in den Krater und reite zu {area:540}, der Silithidenhöhle im Süden. {npc:10041} wartet in ihrer tiefsten Kammer.",

	-- Step 20: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "",
	["Use the jars on slain oozes"] = "Benutze die Krüge an getöteten Brühschlammern",

	-- Step 21: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Reite nach Norden zu {area:541}. Benutze {npc:10980} neben {npc:10977}.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, hinten in der Zuflucht",

	-- Step 22: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "",

	-- Step 24: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Die Grabung der Twilight füllt die Nordwestecke: Schrifttafelfragmente liegen auf dem Boden, und auch die Staubstürmer und Wüstenrumpler tragen welche. Jeder Kultist kann einen {item:20404} fallen lassen: Behalte zwanzig, zehn für {npc:15306} und zehn für {npc:15194} später.",
	["Twilight's Hammer cultists"] = "Kultisten der Twilight",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Schrifttafelfragmente der Twilight",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Zehn weitere für {quest:8323}",

	-- Step 25: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "",

	-- Step 28: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Reite nach Osten zu den Ruinen von {area:2738}. {object:179565} liegt zwischen den verfallenen Gebäuden, bewacht von Gequälten Schildwachen.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "",

	-- Step 29: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "Der Einsiedler versteckt sich zwischen den Felsen südöstlich von {area:2738}.",
	["Below ground"] = "",

	-- Step 30: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Bronzebeards Lager",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Reite nach Südwesten zum Lager der Zwerge nahe den südlichen Bergen und befrag {npc:15171} und {npc:15170}. {npc:15190}s Ranzen liegt im Sand gleich südöstlich des Lagers.",

	-- Step 31: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} hält das Lager der Kultisten im äußersten Südwesten.",

	-- Step 32: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Reite an der Westseite nach Norden zu Maynas kleinem Lager.",

	-- Step 33: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "Havunths Lager liegt gleich westlich der {area:3425}.",

	-- Step 34: Hermit Ortell
	["Ride back south-east to the hermit."] = "Reite zurück nach Südosten zum Einsiedler.",
	["Hand him the ten texts you kept"] = "Gib ihm die zehn Texte, die du behalten hast",

	-- Step 36: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Flieg nach {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} in {zone:1457}: Behalte es",

	-- Step 37: Forest Song
	-- {area:3137} Talrendis Point · {area:16} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "",

	-- Step 38: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",

	-- Step 39: Everlook
	-- {area:3137} Talrendis Point · {area:2255} Everlook
	["Ride back to {area:3137} and fly to {area:2255}."] = "Reite zurück nach {area:3137} und flieg nach {area:2255}.",

	-- Step 41: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "",

	-- Step 42: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "",

	-- Step 44: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (optional)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "{area:2577} in {zone:1444} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",
	-- {area:2577} Dire Maul · {npc:7446} Rabid Shardtooth
	["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} passt für Stufe 55 bis 60; das Grinden an {npc:7446} unten bringt dich allein auf 59.",

	-- Step 45: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Bleib auf der Straße nach Westen bis zu {npc:9298}s Lager neben den heißen Quellen.",

	-- Step 48: Felpaw Village
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw; walks around here: look inside the circle on the map"] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "",

	-- Step 52: Winterspring: kill these as you meet them
	-- {area:618} Winterspring
	["{area:618}: kill these as you meet them"] = "",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 56: Umber
	-- {area:1769} Timbermaw Hold · {area:618} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 57: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "Das Haus von {npc:11801} steht in {area:2361}, östlich von {npc:11939}.",

	-- Step 59: Hearth to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Hearth to {area:3425}"] = "",

	-- Step 60: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:3425} Cenarion Hold
	["{area:3425} flight master"] = "",

	-- Step 62: Nighthaven
	-- {area:2361} Nighthaven · {area:442} Auberdine
	["Take the flight path in {area:2361} and fly to {area:442}."] = "Nimm die Flugroute in {area:2361} und flieg nach {area:442}.",

	-- Step 64: Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["Take the boat from {area:442} to {area:702}."] = "Nimm das Boot von {area:442} nach {area:702}.",

	-- Step 66: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Nimm das Portal hinauf nach {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, im Tempel des Mondes",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, in der Bank",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, oben im {area:1658}",

	-- Step 67: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 68: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 69: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "",

	-- Step 70: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 71: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 72: Stormwind
	-- {npc:14722} Clavicus Knavingham · {quest:6031} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {quest:6031}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, im {object:2096}",

	-- Step 73: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth · {spell:7992} Slowing Poison · {area:1997} Bloodvenom Post
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest.\nCareful: Jadefire Shadowstalkers are level 51-52 and move stealthed. They use {spell:7992} and are found about 550 yd south of {area:1997}.\nCareful: Jadefire Shadowstalkers sneak around and use {spell:7992}."] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} hat keinen Schamanenlehrer",

	-- Step 75: Stormwind City
	["Stormwind City"] = "",
	-- {item:2592} Wool Cloth
	["Sixty {item:2592}, if you carry them"] = "",

	-- Step 77: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 81: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} ist ein Elite der Stufe 61",

	-- Step 82: Andorhal
	["Andorhal"] = "Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} wartet im verfallenen Gasthaus auf der Westseite von Andorhal, der verfallenen Stadt nördlich des Lagers. {npc:1852} bewacht seine Phylakterie mitten in der Stadt.",
	["Araj is elite: grouping up is advised."] = "Araj ist Elite: Eine Gruppe wird empfohlen.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",

	-- Step 83: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "{npc:10778}s Geist wandert beim Bauernhaus von {area:199}, westlich von Andorhal. Die Plappernden Ghule auf dem Feld tragen die andere Hälfte des Talismans: Füg die beiden Hälften zusammen.",
	["Upstairs"] = "",

	-- Step 84: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Reite die Straße nach Norden zum Holzlager und stell das Termitenfass in dessen Mitte ab.",

	-- Step 85: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (optional)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} lebt in einer kleinen Hütte am Grenzfluss, nordöstlich des Holzlagers. Gib {quest:5781} ab, falls du sie abgeschlossen hast.",

	-- Step 87: Of Lost Honor
	["Underwater"] = "",

	-- Step 90: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (optional)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {area:28} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} passt für Stufe 58 bis 60; {quest:5505} wird unten beim {area:3197} abgegeben.",

	-- Step 91: Grind to 60
	["Grind to 60"] = "Grinde bis 60",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Überquere den Fluss östlich von {npc:1855} nach {area:2627}. Die Schreckenstalgeister spuken dort in den Wäldern.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {area:139} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {area:139}"] = "",

	-- Step 93: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Reite zurück nach Südwesten zum {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Zurück in {area:1770}: {npc:9861} und {npc:9860} bewachen {npc:9517} in der tiefsten Kammer.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Klettere auf den {area:537} in der Mitte des Kraters und benutze {item:14644} am Lavasee oben, mit zwei Thoriumbarren im Gepäck. Füll {npc:9616}' Leere reine Probenkrüge an den Urzeitbrühschlammern in den Tümpeln um den Grat.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Baggerbrecher streifen durch die Dünen zwischen {area:2743} und {area:3425}, auf deinem Rückweg. {npc:15181} bietet {quest:8304} erst ab Stufe 58 an.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Flieg nach {area:3137} in {zone:1447} und reite die Straße nach Westen nach {area:2358}, gleich hinter der Grenze zu {zone:1440}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Folge der Straße aus dem Pass nach Südwesten zur {area:3425}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Geh zurück hinab nach {area:702}, nimm das Boot nach {area:442} und dann das Boot weiter zum {area:17203}. Bring je sechzig Seidenstoff, Magiestoff und {item:14047} für {npc:14722} mit: Kauf, was dir fehlt, im Auktionshaus.",
	-- ["Grind to 58"] = "Grinde bis 58",
	-- ["Grind to 59"] = "Grinde bis 59",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Ruhestein nach {area:1519} und trainiere deine Zauber der Stufe 60. Hier endet die Levelroute: Sieh dir als Nächstes die Ruf- und Dungeon-Guides an.",
	-- ["Into {zone:1451}"] = "Nach {zone:1451}",
	-- ["Level 60"] = "Stufe 60",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Reite zurück nach Norden nach {area:2255} und die Straße nach Westen zum Nachtelfendorf.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Reite nach Norden aus {area:415} hinaus in den {zone:1448} zum Lager der Druiden an der Straße gleich hinter der Grenze.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Reite nach Süden nach {area:2250}. Beschütze {npc:10300}, während sie auf dem Weg zum {object:177404} die Fackeln entzündet.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Reite an der Nordwand des Kraters nach Westen zum Pass in der Nordwestecke, der nach {zone:1451} hinaufführt.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "{area:2057} ({area:2298}, Südosten der {zone:1422}) oder {area:2279} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",
	-- ["Shaman training"] = "Schamanentraining",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Nimm die Straße nach Westen hinab in den Krater und reite zur {area:540}, der Silithidenhöhle im Süden. {npc:10041} wartet in ihrer tiefsten Kammer.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Nimm den Tunnel der {area:1769} von seinem Eingang in {zone:1452}, westlich von {npc:9298}, und folge dem Abzweig nach {area:493} bis {area:2361}. {npc:11939} forscht am Seeufer.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Nimm die {area:2257} nach {zone:1455}. {npc:14724} und {npc:14723} wollen je sechzig Wollstoff, Seidenstoff und Magiestoff, dann sechzig {item:14047}: insgesamt je 120, aus deinem Gepäck oder dem Auktionshaus.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Die Bären ({npc:7446}) streifen durch das verschneite Tal südlich von {area:2250}.",
	-- ["Toward the north-west pass"] = "Richtung Nordwestpass",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Du beginnst in {area:392}, wohin dich der vorige Guide per Ruhestein gebracht hat. Flieg nach {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "Grinde an {npc:11741} in den Dünen östlich von {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "Grinde an {npc:14564} in {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "Grinde an {npc:7446} im Tal südlich von {area:2250}, {zone:1452}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} ist die Höhle im hinteren Teil von {area:1763}, westlich der Straße. Benutze das {item:12906} an den vier Kohlenbecken darin. Töte die Wutklauenbären und Teufelspfotenwölfe unterwegs für {item:11172}.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: endet in {zone:1452}, behalte es",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, falls du dreißig {quest:6031} hast",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, gleich in der Höhle: erst ab Neutral bei der Holzschlundfeste",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, der Gastwirt",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} lagert vor {area:2743}, dem westlichen Bau. Heb an einem der roten Geysire in der Nähe ein Silithyst auf und trag es zum Extraktor der Allianz in seinem Lager.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, bei den Zelten der Allianz",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: Der letzte Guide bringt dich per Ruhestein hierher, daher ist das meist sofort abgehakt",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} wartet im {area:1767}. Eskortiere sie aus dem Wald und halte sie am Leben.",
	-- ["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, falls du das Feuerwasserfläschchen in {zone:1452} gefunden hast",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} in {zone:1452}, behalte es",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} & die Pestländer",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm die {area:2257} vom {object:28027} nach {zone:1455} und trainiere deine Zauber der Stufe 60 bei {npc:258098}.",
}
