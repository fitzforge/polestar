-- German (deDE): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Glitzernde Sonnensteine von den Harpyien der Blutfurien",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, vor dem Tor",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Gaeasamenkörner",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Folge der Straße nach Norden Richtung {area:467}. Gehörnte Renner grasen am Weg; die Blutsaftbestien, Mondlichtläufer und Siechdrachen streifen durch die Wälder unterhalb des Gipfels, und die Cenarischen Druiden halten den Hain dort.",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}s nächste Quest, Ordanus, liegt auf der Allianzseite von {zone:1440}. Überspring sie.",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Südwestlich vom Sonnenfels liegt das {area:465}. Pflanz die Gaeasamenkörner in die Erdhügel auf dem Talgrund; die Feuerelementare lassen {item:16312} fallen. Harpyien und Wegelagerinnen der Blutfurien nisten auf der Nordseite, Töterinnen und Wildfedern im Süden.",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, von jeder Harpyie der Blutfurien",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Gaeaerdhügel",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, neben {npc:11862}",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, oben auf dem Felsvorsprung",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "Geh den {area:1076} zurück hinunter nach {area:2539}.",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, am Nordrand des Lagers",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, im Käfig",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "Die Hütte von {npc:5899} steht auf dem Grat über dem Wasserloch der Stacheleber, südlich von {area:378}, auf dem Weg nach {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: der rote Wasserschlauch aus {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: Der blaue Wasserschlauch wird im {zone:1440} gefüllt, nächster Guide",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, oben im Baum gleich östlich von {npc:3341}",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "Festung von Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "",

	-- Step 24: The flying machine
	["The flying machine"] = "Die Flugmaschine",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "Die Flugmaschine der Zwerge steht auf ihrer Plattform in der Grabungsstätte.",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, oben am Aufzug",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, oben auf dem Turm",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	["Crossroads flight master"] = "",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, ein großer Dreschadon, schwimmt im seichten Wasser vor der Küste ({area:391}), östlich von {npc:3388} Skyseer.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Hilf {npc:261366}: Bleib bei ihm, wenn {npc:261367} und die Marinesoldaten von {area:21} den Kamm heraufkommen",
	-- ["At the {object:147538}: summons {quest:882}"] = "Am toten Baum: beschwört {quest:882}",
	-- ["Back to the {area:380}"] = "Zurück nach {area:380}",
	-- ["Bristleback camps"] = "Lager der Borstennacken",
	-- ["Bruuz"] = "Bruuz",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Wirke {spell:18960}. Tauren: Füge die beiden Anhängerhälften beim {area:2362} am Nordwestufer des Sees zusammen, bevor du zu {npc:11802} in {area:2361} gehst.",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "Dogran ist im Stacheleberlager westlich der Straße angekettet.",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doras, der Windreitermeister, steht auf dem Turm im {object:172982}.",
	-- ["Down the {area:458} to {area:378} again."] = "Die {area:458} wieder hinunter zum {area:378}.",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Nach Osten über die Ebenen Richtung Küste: Das gestohlene Silber liegt in einem Raptornest nordwestlich von {area:385}.",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Nach Osten zu {area:382}. {npc:3439} steht im Lager der Venture Co.; {npc:3445} trägt den Schlüssel.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Füll {item:7766} am Wasserloch der Stacheleber",
	-- ["Fizzule is by the Venture Co. tower north of the {area:382}. Use {item:8051} to fire TWO flares before approaching him, then target him and /salute. Keep that order: he attacks strangers who have not signalled first."] = "Fizzule ist beim Turm der Venture Co. nördlich des {area:382}. Benutze {item:8051}, um ZWEI Leuchtkugeln abzufeuern, bevor du dich ihm näherst, wähle ihn dann als Ziel und tippe /salute. Halte diese Reihenfolge ein: Er greift Fremde an, die nicht zuerst ein Signal gegeben haben.",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule leitet das Lager der Venture Co. am Ostende von {area:382}. Er greift Fremde an: Nimm ihn ins Ziel und mach /salute, bevor er es tut.",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Flieg zurück nach {area:380}. Der nächste Guide beginnt hier und nimmt die Straße nach Norden zum {area:1703} und nach {zone:1440}.",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Flieg nach {area:1637}, um deine Ränge der Stufe 20 zu trainieren. {npc:3354} ist im {object:172958}, {npc:5892} im {object:172957}.",
	-- ["Fly to {area:1637} to train."] = "Flieg zum Trainieren nach {area:1637}.",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Flieg nach {area:1638} und trainiere deine Ränge der Stufe 20: {npc:3033} ist auf der {area:1639}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Flieg zum Trainieren nach {area:1638}: {npc:3033} ist auf der {area:1639}.",
	-- ["Follow the {area:458} south to {area:378}."] = "Folge der {area:458} nach Süden zum {area:378}.",
	-- ["He gives you the {item:15826}"] = "Er gibt dir {item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Als Nächstes bietet er {quest:1838} an (1838, Stufe 30): Sie erfordert {area:1717} und schickt dich durch ganz Kalimdor und die Östlichen Königreiche. Der Kriegerklassen-Guide {quest:1838} deckt sie ab.",
	-- ["Head north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Geh vom {area:380} nach Norden zum {area:384} und fülle {item:15842} am Teich am Glutnebelgipfel, dann zurück zu {npc:3448} im {area:380}. Kein {skill:182}? {npc:3490} neben ihm verkauft {item:2449}, je drei auf einmal, bis er neu auffüllt.",
	-- ["Hearth to the {area:380}"] = "Ruhestein nach {area:380}",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "Behalte sie: {object:107045} ist neben {area:272}",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Behalte sie: {npc:12696} in {zone:1440}, nächster Guide",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Behalte sie: {npc:5875} in {zone:1454}, am Ende dieses Guides",
	-- ["Level 20"] = "Stufe 20",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Nach Norden zu {area:383}. {npc:3682} lagert unterhalb der Hügel; {npc:261366}, der Einsiedler auf dem Kamm hinter ihm, hat erst Arbeit für dich, wenn {npc:3682} dich hinaufschickt.",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "Auf dem Weg die {area:458} zurück hinunter zum {area:378}: Die Räuber der Grimmhauer zwischen den Lagern der Borstennacken, zu beiden Seiten der Straße nördlich des Lagers, tragen {item:277277}. Gib sie bei deinem letzten Halt in {area:380} an {npc:3432}.",
	-- ["Pickpocket {npc:7287} for the tower key before opening the lockbox. Gallywix and his lockbox are at the top; the key does not open that box, which still needs Lockpicking. Gallywix is elite: grouping up is advised. If you postpone this optional job, resume it in the Class guide Poisons (Horde)."] = "Stiehl {npc:7287} den Turmschlüssel, bevor du die Kiste öffnest. Gallywix und seine Kiste sind ganz oben; der Schlüssel öffnet diese Kiste nicht, sie braucht weiter Schlossknacken. Gallywix ist Elite: Eine Gruppe wird empfohlen. Schiebst du diesen optionalen Auftrag auf, setze ihn im Klassen-Guide Gifte (Horde) fort.",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Reite von {area:380} nach Norden zum {area:384} und füll {item:15842} am {object:19464}, dann zurück zu {npc:3448} in {area:380}. Kein {skill:182}? {npc:3490} neben ihm verkauft {item:2449}, je drei, bis er nachfüllt.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Savannenpatriarchen streifen über die Ebenen östlich der Hügel, und die Ausgelösten Fallen liegen zwischen ihnen. {quest:876} führt die Harpyien der Hexenschwingen in den Hügeln im Westen an.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Südlich von Camp Taurajo verteilen sich die Silithid-Buckel über {area:390}; die Eier liegen darin, und Silithidschwärmer kommen heraus, um sie zu verteidigen. Silithidernter sind selten: Siehst du einen, töte ihn für seinen Kopf.",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Südlich von Gann graben die Zwerge von Bael'dun bei {area:359}. Ausgräber und Großknechte arbeiten in der Grube; {npc:3392} (26) trägt das Tagebuch: Zieh ihn allein.",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Bleib verstohlen: {npc:7287} trägt den Schlüssel zum Turm; Gallywix und seine Schließkassette sind oben. Gallywix ist Elite: Such dir am besten eine Gruppe.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Bluthornsensenklauen jagen auf den Ebenen südlich von {area:380}, um {area:1697}; sie lassen die Hörner fallen. Gib sie ab, wenn du das nächste Mal durch {area:392} kommst.",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Tauren: {npc:11957} wartet auf dem südlichen Hügel über der Brücke. Himmelsgeborene: {npc:272054} steht südlich der Zwillingsbrücken. Dann die Grabhügel östlich des Sees: Verlass deine Gestalt, klick die Statue am Eingang an für fünf Minuten Verstohlenheit, halte dich von den Geistern darin fern und nimm von jedem Relikt eins; {item:280680} liegt am Fuß der weißen Katzenstatue.",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Die Soldaten, Scharfschützen und Offiziere von Bael'dun bewachen die Festung auf der Ostseite der Grabung; alle drei Gegenstände kommen von ihnen.",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Die Lager der Borstennacken verteilen sich über die Ebenen nördlich vom {area:378}, zu beiden Seiten der {area:458}. Jeder Borstennacken lässt einen Hauer fallen; die Frau von {npc:3432} liegt am Nordrand. Behalte einen {item:5075}. {quest:883}, ein grauer Kodo, wandert manchmal hier: Sein Huf startet eine Quest.",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Die Vorarbeiter und Vollstrecker der Venture Co. an der Mine in der Nordostecke des Gebiets lassen {item:5097} fallen.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Die Fühler verschwinden fünfzehn Minuten nachdem sie fallen, also sammle sie jetzt, auf dem Rückweg nach Norden: Töte die Silithidschwärmer und Silithidkrabbler an den Buckeln im {area:390}, bis du fünf hast, und nimm dann sofort deinen Ruhestein zum {area:378}.",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Die Klassenquests der Stufe 20 in {zone:1454} ({npc:3354}, {npc:5892}, die Lehrer für Hexenmeister und Schurken) gibt es erst ab Stufe 20, also schließ die Stufe hier ab, bevor du fliegst. Die Donnerfalkenjungtiere (18) auf den Ebenen südwestlich von {area:380} und die Kolkar (14-15) an {area:388} sind die nächsten Gegner, die sich lohnen; dir fehlt deutlich weniger als eine Stufe.",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Die Piraten lagern am Strand südlich von {area:392}; {npc:3467} steht an seinem Südende.",
	-- ["The {area:2363}"] = "{area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} ist die Schlucht unter dem {object:172982}.",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790} liegt am Nordrand von {area:382}, beim Turm der Venture Co. Darin ist {item:15883} für {quest:30}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} liegt am Nordrand von {area:382}, beim Turm der Venture Co. Darin ist {item:15883} für {quest:30}.",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Donnerfalkenwolkenkitzler kreisen über denselben Ebenen südlich des Lagers.",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Donnerköpfe grasen auf den Ebenen gleich südlich vom {area:378}. {quest:884}, eine blaue Donnerechse, streift zwischen ihnen umher: Ihr Schwanzstachel startet eine Quest.",
	-- ["Twitching Antennae"] = "Zuckende Fühler",
	-- ["Twitching Antennae from the silithid"] = "Zuckende Fühler von den Silithiden",
	-- ["Venture Co. tower"] = "Turm der Venture Co.",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "Westlich von {npc:3341} halten die Grimmhauer {area:1701}. {npc:3436} ist auf der Ostseite, {npc:3434} im Süden, {npc:3435} am Westende. Lok (25) und die Kriegsberserker (24-25) sind ein paar Stufen über dir; {npc:5859}, ein seltener Elite, läuft manchmal über den Kamm: Lass ihn. Pfadfinder und Schleicher lassen den Grimmhauerrückenstecher fallen, Seher den Zauberstab, Kriegsberserker den Grimmhauerkriegsschild. {npc:3238}-Echsen und Fleischreißerpirscher streifen über die Ebene zwischen Gann und dem Kamm. {quest:885}, eine seltene rote Windnatter, fliegt über dem Kamm: Ihre Feder startet eine Quest.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Wizzlecrank fährt seinen Schredder aus dem Lager: Bleib bei ihm und töte alles, was ihn angreift. {npc:3442} nimmt die Abgabe in {area:392} entgegen.",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "grinde Donnerfalkenjungtiere südwestlich von {area:380}",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, weiter südlich an der Küste. Die Marinesoldaten und Bewahrerinnen von Theramore (15-16) lassen die Medaillen fallen; {npc:3393} (20) und die beiden Kanoniere (19) stehen in der Feste und auf ihren Mauern, und ihretwegen wartet die Feste bis jetzt.",
	-- ["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}, von jedem Zhevra; Zhevra-Stürmer grasen rund um den Baum",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: Verirrte Brachlandkodos auf den Ebenen um das Lager der Kolkar",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: Benutze eine Hälfte beim {area:2362}",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} von {npc:3490}; Kräuterkundige pflücken es auf den Ebenen",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449}: Kräuterkundige pflücken es hier",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} in {area:2361} fliegt Druiden dorthin",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: der Willkommensgruß von {npc:3033}",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: Benutze {item:15826} an ihnen; sie streifen überall um {area:380} über die Ebenen",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} schwimmt im Hafen gleich vor den Docks von {area:392}. {npc:209797} ist Elite: Eine Gruppe wird empfohlen.",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} in {area:272} lehrt Gifte: behalte sie",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391} in {area:272} lehrt {spell:2842}: behalte sie",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} lehrt Paladine in {area:1638}. Du hast dort noch keinen Flugpunkt: Flieg nach {area:378}, geh nach Westen durch {zone:1412} und einen Aufzug hinauf und nimm den Flugpunkt bei {npc:2995} auf der mittleren Anhöhe.",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} bildet in {area:1638} Paladine aus. Du hast dort noch keine Flugroute: Flieg zum {area:378}, reite nach Westen durch {zone:1412} und einen Aufzug hinauf und hol dir die Flugroute bei {npc:2995} auf der mittleren Anhöhe.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} und seine Marinesoldaten halten die zerstörte Karawane südlich von {npc:261366}.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "{npc:262119} und seine Marinesoldaten halten die zerstörte Karawane südlich von {npc:261366}. Die Marinesoldaten sind verbunden: Pullst du einen, rufst du den Rest. Zieh vom Rand und lauf; sie lassen schnell ab, sodass du das Lager einzeln ausdünnen kannst, bevor du den Korporal angehst.",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, auf der Ebene zwischen {npc:3341} und dem Kamm",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} wartet in einem kleinen Lager weiter südlich, an der Straße Richtung {area:359}.",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} steht am Wachposten der Kolkar gleich westlich von {area:380}.",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} steht im Lager der Kolkar nordwestlich von {npc:3389}.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} läuft zwischen den Kolkar an {area:388} südöstlich von {area:380} herum.",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} führt die Kolkar am Westufer von {area:387} an, südlich von {npc:3389}. Gib seinen Kopf bei deinem letzten Halt in {area:380} an {npc:3389}.",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} steht in {object:172960}. Nimm ihn ins Ziel und tippe /salute, um {quest:2460} abzuschließen.",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}. Before leaving town, learn Lockpicking and bring {item:5060}; practise before attempting the tower lockbox. Keep the {item:8051} supplied with {quest:2458}. Gallywix is elite, so arrange help or leave that optional part for later."] = "{npc:3401} steht in der {object:172960}. Wähle ihn als Ziel und tippe /salute, um {quest:2460} abzuschließen. Lerne vor dem Verlassen der Stadt Schlossknacken und bring {item:5060} mit; übe, bevor du die Kiste im Turm versuchst. Halte {item:8051} mit {quest:2458} versorgt. Gallywix ist Elite, organisiere also Hilfe oder heb dir diesen optionalen Teil für später auf.",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: Die Eier sind im {area:390}, später",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Behalte sie: Kadrak am {area:1703}, nächster Guide",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} bietet {quest:95774} an, sobald {quest:4921} abgegeben ist",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, neben dem Windreitermeister. Behalte sie: {quest:1483} ist im Steinkrallengebirge, später",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}, am Kai",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} ist in der Feste angekettet. Sprich mit ihm, um die Eskorte zu starten, und bleib dicht dran: Soldaten von Theramore greifen auf dem Weg hinaus an. Er führt dich zurück nach {area:392}.",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} lebt in {area:2539}, dem Trolldorf gleich hinter der Grenze zum Steinkrallengebirge, am Ende der Straße westlich von {npc:3389}.",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} steht in {object:172960}. Benutze dort {item:6626} am Beschwörungskreis und besiege die Sukkubus, um sie zu binden.",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} lagert an der Straße östlich von {area:380}.",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, gleich westlich von {npc:3341}",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} wartet auf dem Hügel südlich von {area:392}, auf deinem Weg nach Norden.",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}, ein paar Schritte entfernt",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} steht im {object:172961}, auf der Westseite der Stadt.",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} in {zone:1458}, zwei Guides weiter",
	-- ["{object:3972} poster"] = "Plakat „{object:3972}“",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, bei {area:382}",
	-- ["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "{quest:865}, falls noch offen: Bluthornsensenklauen streifen zwischen den Löwen umher",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, ein großer Raptor der Bluthorn, jagt auf den Ebenen nördlich der Straße von {area:392} nach {area:380}.",
	-- ["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the {area:380}, and be ready when he arrives."] = "{quest:882}, ein großer Raptor der Sonnenschuppen, kommt nur zu einem frischen Kill: Plündere {item:10338} von einem Zhevra und benutze ihn am toten Baum nordwestlich von {area:392}, nördlich der Straße zum {area:380}, und sei bereit, wenn er kommt.",
}
