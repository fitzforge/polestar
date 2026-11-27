-- German (deDE): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451}: {area:3425}'s quests, to 60."] = "{zone:1451}: {area:3425}'s Quests, bis 60.",

	-- Step 1: Innkeeper Vizzie
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {npc:11118} Innkeeper Vizzie
	["Back from {zone:2482} in {area:2255}: {npc:11118}'s mail went astray in the hills east of town, where the Ice Thistle yetis carry it off."] = "Rückwärts von {zone:2482} in {area:2255}: {npc:11118}'s Post ging in den Hügeln östlich der Stadt verloren, wo die Eis-Tistel-Yetis es mitnehmen.",

	-- Step 2: Missing Mail
	-- {area:2255} Everlook · {item:258323} Missing Mail
	["The Ice Thistle yetis (53-57) in the hills east of {area:2255} carry the {item:258323}: take it from the ones at the edge of the hills."] = "Die Eis-Tistel-Yetis (53-57) in den Hügeln östlich von {area:2255} tragen das {item:258323}: nimm es von den, die am Hügelrand stehen.",

	-- Step 4: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Flieg nach {area:541}",
	-- {area:541} Marshal's Refuge · {zone:1449} Un'Goro Crater · {zone:1451} Silithus
	["Fly to {area:541} in {zone:1449}, the way into {zone:1451}."] = "Fliege zu {area:541} in {zone:1449}, dem Weg in die {zone:1451}.",
	["Maethrya, the Alliance flight master"] = "Maethrya, Allianz-Flugmeister",

	-- Step 5: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Nach {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Ride west from {area:541} to the crater's north-western pass into {zone:1451}."] = "Fahre nach Westen von {area:541} zum nordwestlichen Pässe des Crater in die {zone:1451}.",

	-- Step 6: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["{npc:13220} stands at {area:3077}, where the pass comes out."] = "{npc:13220} steht in {area:3077}, wo der Pass raus führt.",

	-- Step 9: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Reite weiter nach Westen bis {area:3425}. {npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:15183} Geologist Larksbane
	["{npc:15183}: the tablet fragments come from the Twilight dig"] = "{npc:15183}: Die Schrifttafelfragmente stammen von der Grabung der Twilight",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: his Twilight texts come from the dig"] = "{npc:15306}: seine Twilight-Texte kommen vom Abbau",

	-- Step 10: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: Töte sie, wenn du ihnen begegnest",
	-- {npc:15185} Brood of Nozdormu
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around.\nCareful: {npc:15185} (62, elite) guard the Caverns of Time's mouth in the south-west, around 21,82: stay out of there."] = "Baggerschläger graben in den Dünen nordwestlich des Horts; Steinpanzerskorpide und Sandhuscher streifen überall umher.\nVorsicht: {npc:15185} (62, Elite) bewachen den Eingang der Caverns of Time im Südwesten, um 21,82: bleib da weg.",

	-- Step 11: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Zurück zu {area:3425}. {npc:15189} steht oben in seinem Gebäude: geh hinauf rein, der Pfeil kann die Etagen nicht voneinander unterscheiden.",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189}, upstairs"] = "{npc:15189}, oben",

	-- Step 12: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["From the hold, west into the sands: Dredge Crushers dig there; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Von der Feste nach Westen in den Sand: Dort graben Baggerbrecher; Steinpanzerzangen, Schinder und Felspirscher jagen im selben Sand.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} läuft hier umher: Schau in den Kreis auf der Karte",

	-- Step 13: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "{npc:15190}, oben neben {npc:15189}",
	-- {npc:15181} Commander Mar'alith
	["{npc:15181} (from level 58): Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181} (ab Level 58): Bronzebeards Lager kommt später, auf dem Weg nach Süden",

	-- Step 14: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742}: Töte sie, wenn du ihnen begegnest",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell · {area:2742} Hive'Ashi · {quest:8308} Brann Bronzebeard's Lost Letter
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Twilight Avengers = {npc:11880} Twilight Avenger · Twilight Flamereavers = {npc:15201} Twilight Flamereaver
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait.\nThe {area:2742} silithids sometimes drop {quest:8308}: keep it for Bronzebeard's Encampment in the south."] = "Die Ausgrabung des Twilight's Hammer füllt die Nordwestecke: Tafelfragmente liegen auf dem Boden, und die Staubstürmer und Wüstenrumpler tragen sie ebenfalls. Jeder Kultist kann einen {item:20404} fallen lassen: Behalte zwanzig, zehn für {npc:15306} und zehn für {npc:15194} später.\nVorsicht: Nimm die Texte von den Rächern der Twilight und Geolords; lass die Flammenhäscher der Twilight (60) in Ruhe und halte dich vom Eingang des Bienenstocks fern, wo die {area:2742}-Eliten (59-60) warten.\nDie Silithiden von {area:2742} lassen manchmal {quest:8308} fallen: Behalte es für Bronzebeards Lager im Süden.",
	["Twilight's Hammer cultists"] = "Kultisten der Twilight",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Schrifttafelfragmente der Twilight",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Zehn weitere für {quest:8323}",

	-- Step 16: Southwind Village
	["The tortured druids and sentinels haunt the ruined village east of the hold."] = "Die geschändeten Druiden und Wächter geistern das ruinerische Dorf östlich der Festung.",

	-- Step 17: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride north-east to {npc:13220} at {area:3077}."] = "Fahre nordöstlich zu {npc:13220} in {area:3077}.",

	-- Step 18: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "Der Turm von {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Reite zurück nach Südwesten zum Turm von {area:2742} in {area:2738}; klettere hinauf und töte die Angreifer, die beim Verkrusteten Silithidenobjekt auftauchen.",

	-- Step 19: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {zone:1450} Moonglade
	["{npc:13220}'s next task goes to {zone:1450}: skip it."] = "{npc:13220}'s nächster Auftrag geht an {zone:1450}: überspringe es.",

	-- Step 20: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "Der Einsiedler versteckt sich zwischen den Felsen südöstlich von {area:2738}.",
	["Below ground"] = "Unter der Erde",

	-- Step 21: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Bronzebeards Lager",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "Reite nach Südwesten zum Lager der Zwerge nahe den südlichen Bergen und befrag {npc:15171} und {npc:15170}. {npc:15190}s Ranzen liegt im Sand südöstlich des Lagers, wo Deathclasp, ein Elite-Skorpid, patrouilliert: Schnapp dir den Ranzen, während er weg ist.",

	-- Step 22: Brann Bronzebeard's Lost Letter
	-- {area:2742} Hive'Ashi · {npc:15170} Rutgar Glyphshaper
	["From a {area:2742} silithid: for {npc:15170} at Bronzebeard's Encampment"] = "Von einem {area:2742}-Silithiden: für {npc:15170} beim Bronzebeards Lager",

	-- Step 24: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["Careful: the Twilight Keepers are level 60: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Vorsicht: Die Dämmerungswächter sind Stufe 60: räume zuerst die Kultisten um jeden herum auf und kämpfe mit voller Gesundheit gegen den Wächter.\n{npc:11803} hält das Lager der Kultisten im äußersten Südwesten.",

	-- Step 25: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp.\nCareful: Mayna is level 60: clear her camp first and fight her at full health."] = "Reite an der Westseite entlang nach Norden zu Maynas kleinem Lager.\nVorsicht: Mayna ist Stufe 60: Räum zuerst ihr Lager und kämpfe mit voller Gesundheit gegen sie.",

	-- Step 26: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}.\nCareful: Havunth is level 60: clear his camp first and fight him at full health."] = "Havunths Lager liegt gleich westlich von {area:3425}.\nVorsicht: Havunth ist Stufe 60: Räum zuerst sein Lager und kämpfe mit voller Gesundheit gegen ihn.",

	-- Step 27: Hermit Ortell
	["Ride back south-east to the hermit."] = "Reite zurück nach Südosten zum Einsiedler.",
	["Hand him the ten texts you kept"] = "Gib ihm die zehn Texte, die du behalten hast",

	-- Step 28: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 29: Level 60
	["Level 60"] = "Stufe 60",
	-- {area:3425} Cenarion Hold · {area:2057} Scholomance · {area:2279} Stratholme · {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel · {zone:1451} Silithus
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger · Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["{area:3425}'s last hand-ins can leave a player who followed only this route short of 60 (up to about a level for the slowest; most players less).\nWith a group: run the {area:2057} dungeon or the {area:2279} dungeon, in the Plaguelands by {area:3197} and {area:2268}.\nAlone: the Twilight's Hammer camps of {zone:1451}'s north-west (Twilight Avengers 57-59 and Geolords 58-60; leave the Flamereavers, 60) and the Stonelash Flayers and Rock Stalkers (57-59) around {area:3425} are at your level. {area:3425}'s repeatable quests open only at 60."] = "Die letzten Abgaben in {area:3425} können einen Spieler, der nur dieser Route folgte, unter 60 lassen (bis zu etwa einer Stufe für die Langsamsten; die meisten weniger).\nMit einer Gruppe: Laufe das Verlies {area:2057} oder das Verlies {area:2279}, in den Seuchengebieten bei {area:3197} und {area:2268}.\nAllein: Die Lager des Twilight's Hammer im Nordwesten von {zone:1451} (Dämmerungs-Rächer 57-59 und Geolords 58-60; lass die Flamereavers, 60) und die Steinpanzerschinder und Felspirscher (57-59) rund um {area:3425} sind auf deinem Level. Die wiederholbaren Quests von {area:3425} öffnen erst mit 60.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal"] = "Andorhal",
	-- ["Angerclaw bears and Felpaw wolves"] = "Wutklauenbären und Teufelspfotenwölfe",
	-- ["Araj is elite: grouping up is advised."] = "Araj ist Elite: Eine Gruppe wird empfohlen.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Zurück in {area:1770}: {npc:9861} und {npc:9860} bewachen {npc:9517} in der tiefsten Kammer.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "Wieder hinein in {area:1770}: {npc:9861} und {npc:9860} bewachen {npc:9517} in seiner tiefsten Kammer. Die Sukkubus {npc:9518} wartet auf dem Weg, mit den Überresten von Trey Lightforge neben ihr.\nVorsicht: Die drei Bosse kämpfen als Gruppe. Töte zuerst die Mobs in der Nähe, damit du keine zusätzlichen Gegner pullst.",
	-- ["Boat to {area:150}"] = "Schiff nach {area:150}",
	-- ["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Vorsicht: Ancient Irontree Walkers, Elites der Stufe 59, stehen zwischen den {quest:5086}: Bekämpfe die Horrors an der Nordostspitze des Lagers (etwa 50.6,22.4) einzeln und halte vor jedem Pull nach einem Walker Ausschau.",
	-- ["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Vorsicht: Die Bewahrer der Twilight sind Stufe 60, ein oder zwei Stufen über dir: Räum zuerst die Kultisten um jeden herum weg und kämpfe mit voller Gesundheit gegen den Bewahrer.\n{npc:11803} hält das Lager der Kultisten ganz im Südwesten.",
	-- ["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Steig den Hügel westlich von {area:190} hinauf, um auf die Stadt hinabzublicken.\nVorsicht: Am Tor postierte Wachposten können getarnte Spieler entdecken. In der Stadt stehen weitere Wachposten, und ein Elite patrouilliert in der Nähe.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Klettere auf den {area:537} in der Mitte des Kraters und benutze {item:14644} am Lavasee oben, mit zwei Thoriumbarren im Gepäck. Füll {npc:9616}' Leere reine Probenkrüge an den Urzeitbrühschlammern in den Tümpeln um den Grat.",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Überquere den Fluss östlich von {npc:1855} nach {area:2627}. Die Schreckenstalgeister spuken dort in den Wäldern.",
	-- ["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "Überquere den Fluss östlich der Hütte von {npc:1855} nach {area:2627}: {npc:11140} steht bei Augustus' zerstörter Hütte.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Baggerbrecher streifen durch die Dünen zwischen {area:2743} und {area:3425}, auf deinem Rückweg. {npc:15181} bietet {quest:8304} erst ab Stufe 58 an.",
	-- ["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "Flints nächste Aufgabe führt nach {zone:1453}: Du bist jetzt Stufe 60, überspring sie.",
	-- ["Fly from {area:541} to {area:392}."] = "Flieg von {area:541} nach {area:392}.",
	-- ["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- ["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- ["Fly to {area:2255}"] = "Flieg nach {area:2255}",
	-- ["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- ["Fly to {area:3137}"] = "Flieg nach {area:3137}",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Flieg nach {area:3137} in {area:16} und reite die Straße nach Westen nach {area:2358}, gleich hinter der Grenze zu {zone:1440}.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Flieg nach {area:3137} in {zone:1447} und reite die Straße nach Westen nach {area:2358}, gleich hinter der Grenze zu {zone:1440}.",
	-- ["Fly to {area:3425}"] = "Flieg nach {area:3425}",
	-- ["Fly to {area:442}"] = "Flieg nach {area:442}",
	-- ["Fly to {area:702}"] = "Flieg nach {area:702}",
	-- ["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- ["Fly to {area:976}."] = "Flieg nach {area:976}.",
	-- ["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Flieg nach {area:976}. Kaufe hier im Auktionshaus zwei Thoriumbarren für {quest:5801}.",
	-- ["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- ["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "Folge der Straße nach Norden zum {area:1767}. Die Donnerstampfer der Eisenstämme tragen das Herz; sammle die restlichen Klauen bei den Wutklauengrizzlys und Teufelspfotenverheerern im Norden.\nVorsicht: Uralte Eisenbaumwandler, Elites der Stufe 59, stehen zwischen den Treants in der Mitte des {area:1767}: Nimm dir die Donnerstampfer auf der Nordseite vor (etwa 48,21).",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Folge der Straße aus dem Pass nach Südwesten zur {area:3425}.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Folge {npc:9298}s Wegbeschreibung zum Eingang von {area:2256}, vorbei an den Frosthagelriesen: Passiere sie einzeln.",
	-- ["For {npc:10778}: keep it"] = "Für {npc:10778}: Behalte es",
	-- ["For {npc:11053} at {area:3197}, at the end of this guide"] = "Für {npc:11053} im {area:3197}, am Ende dieses Guides",
	-- ["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "Reite von {area:3137} nach {zone:1448}: Der {area:2479} ist das Lager der Druiden an der Straße, gleich hinter der Grenze zu {zone:1440}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Geh zurück hinab nach {area:702}, nimm das Boot nach {area:442} und dann das Boot weiter zum {area:17203}. Bring je sechzig Seidenstoff, Magiestoff und {item:14047} für {npc:14722} mit: Kauf, was dir fehlt, im Auktionshaus.",
	-- ["Grind to 58"] = "Grinde bis 58",
	-- ["Grind to 59"] = "Grinde bis 59",
	-- ["Grind to 60"] = "Grinde bis 60",
	-- ["Havunth's camp sits just west of {area:3425}."] = "Havunths Lager liegt gleich westlich der {area:3425}.",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Ruhestein nach {area:1519} und trainiere deine Zauber der Stufe 60. Hier endet die Levelroute: Sieh dir als Nächstes die Ruf- und Dungeon-Guides an.",
	-- ["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Ruhestein nach {area:392} und flieg nach {area:976}. Kauf hier im Auktionshaus zwei Thoriumbarren für {quest:5801}.",
	-- ["Inside"] = "Drinnen",
	-- ["Irontree Stompers"] = "Donnerstampfer der Eisenstämme",
	-- ["Its jars are filled on the Un'Goro visit"] = "Die Gefäße werden beim Besuch in Un'Goro gefüllt",
	-- ["Keep the {item:11169}, the claws and the heart he hands back"] = "Behalte {item:11169}, die Klauen und das Herz, die er dir zurückgibt",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Bleib auf der Straße nach Westen bis zu {npc:9298}s Lager neben den heißen Quellen.",
	-- ["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Führ sie aus {area:1770} hinaus und halte sie am Leben, bis sie draußen vor der Höhle ist: Räume zuerst den Weg zurück.",
	-- ["Learn the flight path in {area:2361}."] = "Lerne die Flugroute in {area:2361}.",
	-- ["Level 59.85"] = "Stufe 59,85",
	-- ["Lots of flying between zones"] = "Viel Fliegen zwischen den Gebieten",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Sammle die Vorräte um den Wagen auf und hol dir {npc:10301}s Amulett von den Eulenbestien in der Nähe zurück.",
	-- ["Portal to {zone:1438}"] = "Portal nach {zone:1438}",
	-- ["Radley and Durgen"] = "Radley und Durgen",
	-- ["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Reite zurück nach Osten an {area:2255} vorbei und nach Südosten das Tal hinunter zu der beschädigten Kiste von {npc:10301} im Schnee bei {area:2245}, mit seinem zerstörten Wagen gleich östlich davon.",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Reite zurück nach Norden nach {area:2255} und die Straße nach Westen zum Nachtelfendorf.",
	-- ["Ride back south along the road to the Sanctuary."] = "Reite die Straße zurück nach Süden zum Refugium.",
	-- ["Ride back south-west to {area:3197}."] = "Reite zurück nach Südwesten zum {area:3197}.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Reite zurück nach {area:3137} und flieg nach {area:2255}.",
	-- ["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Reite nach Osten in die Hügel. Benutze {item:11169}, um {quest:4005} zu beschwören, und besiege ihn für das Totem.",
	-- ["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Reite nach Osten zu den Ruinen von {area:2738}. {object:179565} liegt zwischen den verfallenen Gebäuden, bewacht von Gequälten Schildwachen.",
	-- ["Ride north along the west side to Mayna's small camp."] = "Reite an der Westseite nach Norden zu Maynas kleinem Lager.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Reite nach Norden aus {area:415} hinaus in den {zone:1448} zum Lager der Druiden an der Straße gleich hinter der Grenze.",
	-- ["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Reite nach Norden zum Dorf der Furbolgs der Totenwaldfelle beim Höhleneingang der {area:1769}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Reite nach Norden zum nordöstlichen Rand von {area:2277}.\nVorsicht: Die Trolle auf dem Weg nach {area:2273} sind Stufe 57-59. Sie laufen bei niedriger Gesundheit weg und rufen Hilfe, also bringen sie oft Adds mit.",
	-- ["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Reite nach Norden zu {area:541}. Benutze {npc:10980} neben {npc:10977}.",
	-- ["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Reite die Straße nach Norden zum Holzlager und stell das Termitenfass in dessen Mitte ab.",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Reite das Tal nach Norden hinauf, an {area:2255} vorbei, bis {area:2253}.",
	-- ["Ride north-west up the road to {area:2253}."] = "Reite die Straße nach Nordwesten hinauf bis {area:2253}.",
	-- ["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "Reite nach Süden aus {zone:1448} hinaus Richtung {area:3137}: Das Lager von {npc:3848} bei {area:2358} liegt gleich hinter der Grenze zu {zone:1440}, auf dem Weg.",
	-- ["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "Reite nach Süden zum {area:2260}, dem Hof nordwestlich von {area:2262}. Die Überreste der drei Agenten sind Knochenumrisse auf dem Boden: einer an der Straße südlich des Hofs, einer auf dem Hügel östlich des Hauses, einer auf dem Erdhügel davor. Wenn du nahe genug herankommst, um den Blightcaller vor dem Haus zu sehen, ist die Erkundung abgeschlossen.\nVorsicht: {npc:11878} (Elite der Stufe 62) und seine Elite-Hunde stehen vor dem Haus: Nimm die Überreste auf dem Hügel von der Seite und pull ihn nicht. Du musst nicht gegen ihn kämpfen.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Reite nach Süden nach {area:2250}. Beschütze {npc:10300}, während sie auf dem Weg zum {object:177404} die Fackeln entzündet.",
	-- ["Ride south-east from the lake to the chapel."] = "Reite vom See nach Südosten zur Kapelle.",
	-- ["Ride south-east to {area:201}: {npc:11078} guards the cauldron, and {item:12955} lies east of the barn."] = "Reite nach Südosten nach {area:201}: {npc:11078} bewacht den Kessel, und {item:12955} liegt östlich der Scheune.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Reite nach Südwesten zum {area:2261}. Der Erdhügel liegt darin. {npc:11886} ist Elite: Eine Gruppe wird empfohlen.\nVorsicht: Etwa vier Adds ohne Elite-Status kommen mit Mercutio. Sie laufen zum Grab, statt sofort zu erscheinen.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Reite nach Südwesten zum Lager von {npc:7771} bei {area:1938}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Reite an der Nordwand des Kraters nach Westen zum Pass in der Nordwestecke, der nach {zone:1451} hinaufführt.",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "{area:2057} ({area:2298}, Südosten der {area:28}) oder {area:2279} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "{area:2057} ({area:2298}, Südosten von {zone:1422}) oder {area:2279} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "{area:2577} in {zone:1444} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "Erschrecke {npc:10977} mit {npc:10980}",
	-- ["Scourge Champions"] = "Champions der Geißel",
	-- ["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Champions der Geißel (59) streifen durch {area:2270}, nördlich der {area:2268}. Halte {npc:11063}s {item:13156} über jeden, den du tötest: Die Schädel, die mitschwingen, sind die, die er will. Zieh sie einzeln.",
	-- ["Shaman training"] = "Schamanentraining",
	-- ["Stays on the main route"] = "Bleibt auf der Hauptroute",
	-- ["Take the boat from {area:442} to {area:702}."] = "Nimm das Boot von {area:442} nach {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Nimm die Flugroute in {area:2361} und flieg nach {area:442}.",
	-- ["Take the portal up to {zone:1457}."] = "Nimm das Portal hinauf nach {zone:1457}.",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Nimm die Straße nach Westen hinab in den Krater und reite zu {area:540}, der Silithidenhöhle im Süden. {npc:10041} wartet in ihrer tiefsten Kammer.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Nimm den Tunnel der {area:1769} von seinem Eingang in {area:618}, westlich von {npc:9298}, und folge dem Abzweig nach {area:493} bis {area:2361}. {npc:11939} forscht am Seeufer.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Nimm den Tunnel der {area:1769} von seinem Eingang in {zone:1452}, westlich von {npc:9298}, und folge dem Abzweig nach {area:493} bis {area:2361}. {npc:11939} forscht am Seeufer.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "Nimm die {area:2257} nach {zone:1455}. {npc:14724} und {npc:14723} nehmen je sechzig Wollstoff, sechzig Seidenstoff und sechzig Magiestoff, dann sechzig {item:14047}: Gib ab, was du dabeihast (oder kaufe es im Auktionshaus), den Rest überspring.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Nimm die {area:2257} nach {zone:1455}. {npc:14724} und {npc:14723} wollen je sechzig Wollstoff, Seidenstoff und Magiestoff, dann sechzig {item:14047}: insgesamt je 120, aus deinem Gepäck oder dem Auktionshaus.",
	-- ["Takes you all the way to 60"] = "Bringt dich bis Stufe 60",
	-- ["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "Das Deadwood-Totem aus {area:1762}, falls {npc:11558} es damals nicht genommen hat.",
	-- ["The Terrordale Spirits haunt the woods around {npc:11140}. Top up here to level 59.85 while you stand in {area:2627}: the hand-ins still to come (the {area:2261}, {area:2298}, {npc:10667} and {area:3197}) take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Die Terrordale Spirits spuken in den Wäldern um {npc:11140}. Grinde hier bis Stufe 59,85, solange du in {area:2627} bist: Die noch ausstehenden Abgaben ({area:2261}, {area:2298}, {npc:10667} und {area:3197}) bringen dich auf Stufe 60. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:2057} oder den Dungeon {area:2279}.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Die Grabung der Twilight füllt die Nordwestecke: Schrifttafelfragmente liegen auf dem Boden, und auch die Staubstürmer und Wüstenrumpler tragen welche. Jeder Kultist kann einen {item:20404} fallen lassen: Behalte zwanzig, zehn für {npc:15306} und zehn für {npc:15194} später.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "Die Grabung der Twilight füllt die Nordwestecke: Schrifttafelfragmente liegen auf dem Boden, und auch die Staubstürmer und Wüstenrumpler tragen welche. Jeder Kultist kann einen {item:20404} fallen lassen: Behalte zwanzig, zehn für {npc:15306} und zehn für {npc:15194} später.\nVorsicht: Hol dir die Texte von den Rächern der Twilight und Geolords; lass die Flammenhäscher der Twilight (60) in Ruhe und bleib dem Eingang des Bienenstocks fern, wo die Elites von {area:2742} (59-60) warten.",
	-- ["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "Der Flug landet in {area:702}. {npc:7916} steht einen kurzen Fußweg nordwestlich vom Flugmeister.",
	-- ["The lake for {quest:5845}"] = "Der See für {quest:5845}",
	-- ["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "Die Hauptroute bis 60: {zone:1451}, {zone:1448}, {zone:1452} und die Pestländer, mit den Abgaben in {zone:1453}, {zone:1455} und {spell:437801} auf dem Weg.",
	-- ["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Die westlichen Winterquell-Furbolgs lassen die Perlen fallen.\nVorsicht: Beim Abgeben erscheinen drei oder vier Winterquell-Furbolgs der Stufe 56-57 aus dem Hinterhalt, die dich angreifen; du kannst ihnen auf deinem Reittier, getarnt oder mit {spell:5384} entkommen, und sie sammeln sich dann am See, sodass du die nächste Quest annehmen kannst.",
	-- ["The {area:2479}"] = "{area:2479}",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Die Bären ({npc:7446}) streifen durch das verschneite Tal südlich von {area:2250}.",
	-- ["The {quest:5086}"] = "{quest:5086}",
	-- ["Theramore flight master"] = "Flugmeister von Theramore",
	-- ["To {area:392}"] = "Nach {area:392}",
	-- ["Toward the north-west pass"] = "Richtung Nordwestpass",
	-- ["Tram to {zone:1455}"] = "Tiefenbahn nach {zone:1455}",
	-- ["Underwater"] = "Unter Wasser",
	-- ["Upstairs"] = "Oben",
	-- ["Use the jars on slain oozes"] = "Benutze die Krüge an getöteten Brühschlammern",
	-- ["Wait a moment for {npc:9116}"] = "Warte kurz auf {npc:9116}",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Du beginnst in {area:392}, wohin dich der vorige Guide per Ruhestein gebracht hat. Flieg nach {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "Grinde an {npc:11741} in den Dünen östlich von {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "Grinde an {npc:14564} in {area:2627}, {area:139}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "Grinde an {npc:14564} in {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "Grinde an {npc:7446} im Tal südlich von {area:2250}, {zone:1452}",
	-- ["{area:150} flight master"] = "Flugmeister von {area:150}",
	-- ["{area:1770} braziers"] = "Kohlenbecken in {area:1770}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} ist die Höhle im hinteren Teil von {area:1763}, westlich der Straße. Benutze das {item:12906} an den vier Kohlenbecken darin. Töte die Wutklauenbären und Teufelspfotenwölfe unterwegs für {item:11172}.",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "{area:1770} ist die Höhle am Ende von {area:1763}, westlich der Straße. Benutze {item:12906} an den vier Feuerschalen darin. Töte die Angerclaw-Bären und Felpaw-Wölfe, an denen du vorbeikommst, für {item:11172}.\nVorsicht: Mobs des Schattenrats der Stufe 53-55 füllen die Höhle und kommen oft in großen verbundenen Gruppen, viele mit Betäubungen. Eine Gruppe von 2-3 Spielern wird empfohlen.\nDie Jaedenar Darkweavers, Warlocks und Enforcers hier drin lassen einen {item:13140} fallen, etwa bei jedem dreißigsten Kill: Töte sie weiter, bis er fällt. Er öffnet die Zelle von {npc:11018}, der Nachtelfe, die in der Höhle gefangen ist.",
	-- ["{area:190} overlook"] = "Aussichtspunkt über {area:190}",
	-- ["{area:2057} (optional)"] = "{area:2057} (optional)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} passt für Stufe 58 bis 60; {quest:5505} wird unten beim {area:3197} abgegeben.",
	-- ["{area:2255} flight master"] = "Flugmeister in {area:2255}",
	-- ["{area:2577} (optional)"] = "{area:2577} (optional)",
	-- ["{area:2577} fits levels 55 to 60; alone, the {area:2627} grind at the end of this guide gets you to 60."] = "{area:2577} passt für Stufe 55 bis 60; allein bringt dich der Grind in {area:2627} am Ende dieses Guides auf 60.",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} passt für Stufe 55 bis 60; das Grinden an {npc:7446} unten bringt dich allein auf 59.",
	-- ["{area:3137} flight master"] = "Flugmeister in {area:3137}",
	-- ["{area:392} flight master"] = "Flugmeister in {area:392}",
	-- ["{area:493} flight path on the way"] = "Flugroute nach {area:493} auf dem Weg",
	-- ["{area:541} flight master"] = "Flugmeister in {area:541}",
	-- ["{area:702} flight master"] = "Flugmeister von {area:702}",
	-- ["{area:976} flight master"] = "Flugmeister von {area:976}",
	-- ["{item:12954}; inside"] = "{item:12954}; drinnen",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, von den Champions der Geißel",
	-- ["{item:14047}, from your bags"] = "{item:14047}, aus deinen Taschen",
	-- ["{item:2592}, from your bags"] = "{item:2592}, aus deinen Taschen",
	-- ["{item:4306}, from your bags"] = "{item:4306}, aus deinen Taschen",
	-- ["{item:4338}, from your bags"] = "{item:4338}, aus deinen Taschen",
	-- ["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300} wartet bei {area:2250}, südlich von {area:2255}.\nBeschütze {npc:10300}, während sie auf dem Weg zum {object:177404} die Fackeln entzündet.",
	-- ["{npc:10301}'s camp"] = "{npc:10301}s Lager",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}s Vorräte",
	-- ["{npc:10667} in Andorhal: keep it"] = "{npc:10667} in Andorhal: Behalte es",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} wartet im verfallenen Gasthaus auf der Westseite von Andorhal, der verfallenen Stadt nördlich des Lagers. {npc:1852} bewacht seine Phylakterie mitten in der Stadt.",
	-- ["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667} wartet oben im zerstörten Gasthaus auf der Westseite von Andorhal, auf dem Weg zurück nach {area:3197}.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, oben",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "{npc:10778}s Geist wandert beim Bauernhaus von {area:199}, westlich von Andorhal. Die Plappernden Ghule auf dem Feld tragen die andere Hälfte des Talismans: Füg die beiden Hälften zusammen.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn."] = "{npc:10897}, der Flugmeister von {area:493}, steht südlich des Sees, außerhalb von {area:2361}: Lerne bei ihm die Flugroute. Die Flugmeisterin in {area:2361} selbst fliegt nur Druiden, über ihr Gesprächsmenü, und hat keine Flugroute zum Lernen.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: endet in {zone:1452}, behalte es",
	-- ["{npc:11016}, in her cell; below ground"] = "{npc:11016}, in ihrer Zelle; unterirdisch",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, unterirdisch",
	-- ["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "{npc:11038}, bei den Gräbern südlich der Kapelle: {npc:11140} ist in {area:2627}, behalte es",
	-- ["{npc:11053}: {area:201}'s cauldron, on this loop"] = "{npc:11053}: Der Kessel von {area:201}, auf dieser Runde",
	-- ["{npc:11556}'s {quest:8464} waited for this visit: the furbolg village lies just east of {area:2255}, with Shaman (56-57), Den Watchers (55-56) and Ursa (57-58). Kill the Shaman first, they heal. {npc:10738} in the cave at the back is elite: stay out."] = "{quest:8464} von {npc:11556} hat auf diesen Besuch gewartet: Das Furbolgdorf liegt gleich östlich von {area:2255}, mit Schamanen (56-57), Höhlenwächtern (55-56) und Ursa (57-58). Töte zuerst die Schamanen, sie heilen. {npc:10738} in der Höhle ganz hinten ist Elite: Bleib draußen.",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, falls du dreißig {quest:6031} hast",
	-- ["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "{npc:11557}, gleich hinter dem Eingang der Höhle neben {npc:11558}, nimmt dreißig {quest:6031} ab Freundlich bei den Timbermaw: Der Grind an den Winterquell-Furbolgs in {zone:1452} bringt dir beides.",
	-- ["{npc:11557}; below ground"] = "{npc:11557}; unterirdisch",
	-- ["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "{npc:11558} steht gleich hinter dem Eingang der Höhle {area:1769}: Sie spricht ab Neutral mit dir, wenn du bei den Timbermaw so weit bist, was die Winterquell-Furbolgs, die du in {zone:1452} gegrindet hast, dir gebracht haben.",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, gleich in der Höhle: erst ab Neutral bei der Holzschlundfeste",
	-- ["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}, gleich hinter dem Eingang der Höhle: läuft hier umher: Schau in den Kreis auf der Karte",
	-- ["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: läuft hier umher: Schau in den Kreis auf der Karte",
	-- ["{npc:11610} hides at the Northridge lumber camp's edge."] = "{npc:11610} versteckt sich am Rand des Holzfällerlagers von Nordhain.",
	-- ["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} versteckt sich am Rand des Holzfällerlagers.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} läuft durch das Lager von Northridge östlich von {npc:11610}; {npc:11611} bewacht den Turm an der südlichen Zufahrt von {area:190}.\nVorsicht: Wachen stehen am Fuß des Turms, und eine weitere kreist patrouillierend um ihn. Räume sie, bevor du Durgen angreifst, damit sie sich dem Kampf nicht anschließen.",
	-- ["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "Das Haus von {npc:11801} steht in {area:2361}, östlich von {npc:11939}.",
	-- ["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} hält das Lager der Kultisten im äußersten Südwesten.",
	-- ["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} läuft um {area:2361} umher: Schau in den Kreis auf der Karte",
	-- ["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} nimmt sechzig Seidenstoff, sechzig Magiestoff und sechzig {item:14047}: Gib ab, was du dabeihast (oder kaufe es im Auktionshaus), den Rest überspring.",
	-- ["{npc:14722}, in the {object:2096}"] = "{npc:14722}, im {object:2096}",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, der Gastwirt",
	-- ["{npc:15181}: Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181}: Bronzebarts Lager kommt später, auf dem Weg nach Süden",
	-- ["{npc:15306}: his Twilight texts come from the dig after the next stop here"] = "{npc:15306}: Seine Texte der Twilight stammen von der Grabung nach dem nächsten Halt hier",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} lagert vor {area:2743}, dem westlichen Bau. Heb an einem der roten Geysire in der Nähe ein Silithyst auf und trag es zum Extraktor der Allianz in seinem Lager.",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080} lagert vor {area:2743}, dem westlichen Stock. Hol dir an einem der roten Geysire in der Nähe ein Silithyst und trag es zum Extraktor der Allianz in seinem Lager.\nVorsicht: Du verlierst das Silithyst, wenn du aufsitzt, dich tarnst, {spell:642}, {spell:5384} oder Verschwinden einsetzt. Blinzeln und {spell:17} lassen es nicht fallen.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, bei den Zelten der Allianz",
	-- ["{npc:17082}, at the Alliance tents: for {npc:17080} at {area:2743}"] = "{npc:17082}, bei den Zelten der Allianz: für {npc:17080} bei {area:2743}",
	-- ["{npc:1852} is a level 61 elite"] = "{npc:1852} ist ein Elite der Stufe 61",
	-- ["{npc:1855} (optional)"] = "{npc:1855} (optional)",
	-- ["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} lebt in einer kleinen Hütte am Grenzfluss, nordöstlich des Holzlagers. Gib {quest:5781} ab, falls du sie abgeschlossen hast.",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, bei SI:7",
	-- ["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, oben im {area:1658}",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, der an den Kanälen entlanggeht",
	-- ["{npc:4155}, in the bank"] = "{npc:4155}, in der Bank",
	-- ["{npc:5594}, inside"] = "{npc:5594}, drinnen",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: Der letzte Guide bringt dich per Ruhestein hierher, daher ist das meist sofort abgehakt",
	-- ["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} in {zone:1457}: Behalte es",
	-- ["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, im Tempel des Mondes",
	-- ["{npc:8496}, inside"] = "{npc:8496}, drinnen",
	-- ["{npc:8737}, at the back of the refuge"] = "{npc:8737}, hinten in der Zuflucht",
	-- ["{npc:9116}, inside"] = "{npc:9116}, drinnen",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",
	-- ["{npc:9517}; below ground"] = "{npc:9517}; unterirdisch",
	-- ["{npc:9518}, below ground"] = "{npc:9518}, unterirdisch",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} wartet im {area:1767}. Eskortiere sie aus dem Wald und halte sie am Leben.",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598} wartet in {area:1767}. Eskortiere sie aus dem Wald und halte sie am Leben.\nVorsicht: Drei {quest:5086} überfallen dich kurz nach Beginn der Eskorte.",
	-- ["{npc:9616}'s jars went to {zone:1455} on the {zone:1452} guide's {zone:1455} stop: fly straight to {area:976}."] = "Die Krüge von {npc:9616} gingen beim Halt in {zone:1455} des Guides für {zone:1452} nach {zone:1455}: Flieg direkt nach {area:976}.",
	-- ["{npc:9860}, below ground"] = "{npc:9860}, unterirdisch",
	-- ["{npc:9861}, below ground"] = "{npc:9861}, unterirdisch",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, falls du das Feuerwasserfläschchen in {area:618} gefunden hast",
	-- ["{object:176158}, below ground"] = "{object:176158}, unterirdisch",
	-- ["{object:176159}, below ground"] = "{object:176159}, unterirdisch",
	-- ["{object:176160}, below ground"] = "{object:176160}, unterirdisch",
	-- ["{object:176161}, below ground"] = "{object:176161}, unterirdisch",
	-- ["{object:179565}; inside"] = "{object:179565}; drinnen",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}: {npc:9298} in {area:618}, behalte es",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} in {zone:1452}, behalte es",
	-- ["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}: Die Route nimmt sie an und holt das Symbol, damit ihre Abgabe klappt",
	-- ["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} bei {area:3197}: Behalte es",
	-- ["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "{quest:6184}: Die Überreste der Agenten liegen am {area:2260} in der {zone:1423}",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618} & die Pestländer",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} & die Pestländer",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands."] = "{zone:1451}, {zone:1448}, {zone:1452} und die Pestländer.",
	-- ["{zone:1452}: kill these as you meet them"] = "{zone:1452}: Töte sie, wenn du ihnen begegnest",
	-- ["{zone:1453} has no shaman trainer"] = "{zone:1453} hat keinen Schamanenlehrer",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm die {area:2257} vom {object:28027} nach {zone:1455} und trainiere deine Zauber der Stufe 60 bei {npc:258098}.",
	-- ["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",
}
