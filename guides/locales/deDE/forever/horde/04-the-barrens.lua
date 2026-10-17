-- German (deDE): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- {object:172982} Valley of Strength
	["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doras, der Windreitermeister, steht auf dem Turm im {object:172982}.",

	-- Step 2: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, neben dem Windreitermeister. Behalte sie: {quest:1483} ist im Steinkrallengebirge, später",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Plakat „{object:3972}“",
	-- {npc:3453} Wharfmaster Dizzywig
	["{npc:3453}, on the dock"] = "{npc:3453}, am Kai",

	-- Step 3: Bruuz
	-- {npc:209797} Bruuz · {area:392} Ratchet
	["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} schwimmt im Hafen gleich vor den Docks von {area:392}. {npc:209797} ist Elite: Eine Gruppe wird empfohlen.",

	-- Step 4: Baron Longshore
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Die Piraten lagern am Strand südlich von {area:392}; {npc:3467} steht an seinem Südende.",

	-- Step 5: Northwatch Hold
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, weiter südlich an der Küste. Die Marinesoldaten und Bewahrerinnen von Theramore (15-16) lassen die Medaillen fallen; {npc:3393} (20) und die beiden Kanoniere (19) stehen in der Feste und auf ihren Mauern, und ihretwegen wartet die Feste bis jetzt.",

	-- Step 6: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} ist in der Feste angekettet. Sprich mit ihm, um die Eskorte zu starten, und bleib dicht dran: Soldaten von Theramore greifen auf dem Weg hinaus an. Er führt dich zurück nach {area:392}.",

	-- Step 8: Raptor Horns
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Bluthornsensenklauen jagen auf den Ebenen südlich von {area:380}, um {area:1697}; sie lassen die Hörner fallen. Gib sie ab, wenn du das nächste Mal durch {area:392} kommst.",

	-- Step 9: Crossroads
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Behalte sie: Kadrak am {area:1703}, nächster Guide",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: Die Eier sind im {area:390}, später",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, oben auf dem Turm",

	-- Step 10: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Reite von {area:380} nach Norden zum {area:384} und füll {item:15842} am {object:19464}, dann zurück zu {npc:3448} in {area:380}. Kein {skill:182}? {npc:3490} neben ihm verkauft {item:2449}, je drei, bis er nachfüllt.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} von {npc:3490}; Kräuterkundige pflücken es auf den Ebenen",

	-- Step 11: Level 20
	["Level 20"] = "Stufe 20",
	-- {zone:1454} Orgrimmar · {npc:3354} Sorek · {npc:5892} Searn Firewarder · {area:380} Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Die Klassenquests der Stufe 20 in {zone:1454} ({npc:3354}, {npc:5892}, die Lehrer für Hexenmeister und Schurken) gibt es erst ab Stufe 20, also schließ die Stufe hier ab, bevor du fliegst. Die Donnerfalkenjungtiere (18) auf den Ebenen südwestlich von {area:380} und die Kolkar (14-15) an {area:388} sind die nächsten Gegner, die sich lohnen; dir fehlt deutlich weniger als eine Stufe.",
	-- {area:380} Crossroads
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "grinde Donnerfalkenjungtiere südwestlich von {area:380}",

	-- Step 12: Orgrimmar
	-- {area:1637} Orgrimmar · {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Flieg nach {area:1637}, um deine Ränge der Stufe 20 zu trainieren. {npc:3354} ist im {object:172958}, {npc:5892} im {object:172957}.",

	-- Step 13: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} ist die Schlucht unter dem {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, ein paar Schritte entfernt",

	-- Step 14: Shenthul
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {quest:2460} The Shattered Salute
	["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} steht in {object:172960}. Nimm ihn ins Ziel und tippe /salute, um {quest:2460} abzuschließen.",
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, bei {area:382}",

	-- Step 15: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} steht im {object:172961}, auf der Westseite der Stadt.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} in {zone:1458}, zwei Guides weiter",

	-- Step 16: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Flieg nach {area:1638} und trainiere deine Ränge der Stufe 20: {npc:3033} ist auf der {area:1639}.",

	-- Step 17: Back to the Crossroads
	-- {area:380} Crossroads
	["Back to the {area:380}"] = "Zurück nach {area:380}",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} steht am Wachposten der Kolkar gleich westlich von {area:380}.",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} steht im Lager der Kolkar nordwestlich von {npc:3389}.",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: Verirrte Brachlandkodos auf den Ebenen um das Lager der Kolkar",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449}: Kräuterkundige pflücken es hier",

	-- Step 21: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} lebt in {area:2539}, dem Trolldorf gleich hinter der Grenze zum Steinkrallengebirge, am Ende der Straße westlich von {npc:3389}.",

	-- Step 22: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Nach Norden zu {area:383}. {npc:3682} lagert unterhalb der Hügel; {npc:261366}, der Einsiedler auf dem Kamm hinter ihm, hat erst Arbeit für dich, wenn {npc:3682} dich hinaufschickt.",

	-- Step 23: Dry Hills
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Savannenpatriarchen streifen über die Ebenen östlich der Hügel, und die Ausgelösten Fallen liegen zwischen ihnen. {quest:876} führt die Harpyien der Hexenschwingen in den Hügeln im Westen an.",

	-- Step 26: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} und seine Marinesoldaten halten die zerstörte Karawane südlich von {npc:261366}.",

	-- Step 27: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Hilf {npc:261366}: Bleib bei ihm, wenn {npc:261367} und die Marinesoldaten von {area:21} den Kamm heraufkommen",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} liegt am Nordrand von {area:382}, beim Turm der Venture Co. Darin ist {item:15883} für {quest:30}.",

	-- Step 29: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "Nach Osten zu {area:382}. {npc:3439} steht im Lager der Venture Co.; {npc:3445} trägt den Schlüssel.",

	-- Step 30: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Wizzlecrank fährt seinen Schredder aus dem Lager: Bleib bei ihm und töte alles, was ihn angreift. {npc:3442} nimmt die Abgabe in {area:392} entgegen.",

	-- Step 31: Taskmaster Fizzule
	-- {area:382} Sludge Fen
	["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule leitet das Lager der Venture Co. am Ostende von {area:382}. Er greift Fremde an: Nimm ihn ins Ziel und mach /salute, bevor er es tut.",

	-- Step 32: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Bleib verstohlen: {npc:7287} trägt den Schlüssel zum Turm; Gallywix und seine Schließkassette sind oben. Gallywix ist Elite: Such dir am besten eine Gruppe.",
	["Venture Co. tower"] = "Turm der Venture Co.",

	-- Step 33: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Die Vorarbeiter und Vollstrecker der Venture Co. an der Mine in der Nordostecke des Gebiets lassen {item:5097} fallen.",

	-- Step 34: Hearth to the Crossroads
	-- {area:380} Crossroads
	["Hearth to the {area:380}"] = "Ruhestein nach {area:380}",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Er gibt dir {item:15826}",

	-- Step 35: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} läuft zwischen den Kolkar an {area:388} südöstlich von {area:380} herum.",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: Benutze {item:15826} an ihnen; sie streifen überall um {area:380} über die Ebenen",

	-- Step 36: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Folge der {area:458} nach Süden zum {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, im Käfig",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, am Nordrand des Lagers",

	-- Step 37: Bristleback camps
	["Bristleback camps"] = "Lager der Borstennacken",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {item:5075} Blood Shard · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Die Lager der Borstennacken verteilen sich über die Ebenen nördlich vom {area:378}, zu beiden Seiten der {area:458}. Jeder Borstennacken lässt einen Hauer fallen; die Frau von {npc:3432} liegt am Nordrand. Behalte einen {item:5075}. {quest:883}, ein grauer Kodo, wandert manchmal hier: Sein Huf startet eine Quest.",

	-- Step 38: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran ist im Stacheleberlager westlich der Straße angekettet.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Behalte sie: {npc:5875} in {zone:1454}, am Ende dieses Guides",

	-- Step 40: Stolen Silver
	-- {area:385} Northwatch Hold
	["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Nach Osten über die Ebenen Richtung Küste: Das gestohlene Silber liegt in einem Raptornest nordwestlich von {area:385}.",

	-- Step 41: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} wartet auf dem Hügel südlich von {area:392}, auf deinem Weg nach Norden.",

	-- Step 43: Ishamuhale
	-- {quest:882} Ishamuhale · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, ein großer Raptor der Bluthorn, jagt auf den Ebenen nördlich der Straße von {area:392} nach {area:380}.",

	-- Step 44: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} bietet {quest:95774} an, sobald {quest:4921} abgegeben ist",

	-- Step 46: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} führt die Kolkar am Westufer von {area:387} an, südlich von {npc:3389}. Gib seinen Kopf bei deinem letzten Halt in {area:380} an {npc:3389}.",

	-- Step 47: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "Auf dem Weg die {area:458} zurück hinunter zum {area:378}: Die Räuber der Grimmhauer zwischen den Lagern der Borstennacken, zu beiden Seiten der Straße nördlich des Lagers, tragen {item:277277}. Gib sie bei deinem letzten Halt in {area:380} an {npc:3432}.",

	-- Step 48: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Die {area:458} wieder hinunter zum {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Behalte sie: {npc:12696} in {zone:1440}, nächster Guide",

	-- Step 49: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Donnerköpfe grasen auf den Ebenen gleich südlich vom {area:378}. {quest:884}, eine blaue Donnerechse, streift zwischen ihnen umher: Ihr Schwanzstachel startet eine Quest.",

	-- Step 51: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Donnerfalkenwolkenkitzler kreisen über denselben Ebenen südlich des Lagers.",

	-- Step 53: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Südlich von Camp Taurajo verteilen sich die Silithid-Buckel über {area:390}; die Eier liegen darin, und Silithidschwärmer kommen heraus, um sie zu verteidigen. Silithidernter sind selten: Siehst du einen, töte ihn für seinen Kopf.",

	-- Step 54: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} wartet in einem kleinen Lager weiter südlich, an der Straße Richtung {area:359}.",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, oben im Baum gleich östlich von {npc:3341}",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, gleich westlich von {npc:3341}",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Füll {item:7766} am Wasserloch der Stacheleber",
	-- {object:107045} Spring Well · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "Behalte sie: {object:107045} ist neben {area:272}",

	-- Step 55: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "Westlich von {npc:3341} halten die Grimmhauer {area:1701}. {npc:3436} ist auf der Ostseite, {npc:3434} im Süden, {npc:3435} am Westende. Lok (25) und die Kriegsberserker (24-25) sind ein paar Stufen über dir; {npc:5859}, ein seltener Elite, läuft manchmal über den Kamm: Lass ihn. Pfadfinder und Schleicher lassen den Grimmhauerrückenstecher fallen, Seher den Zauberstab, Kriegsberserker den Grimmhauerkriegsschild. {npc:3238}-Echsen und Fleischreißerpirscher streifen über die Ebene zwischen Gann und dem Kamm. {quest:885}, eine seltene rote Windnatter, fliegt über dem Kamm: Ihre Feder startet eine Quest.",
	-- {npc:3238} Stormhide · {npc:3341} Gann Stonespire
	["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, auf der Ebene zwischen {npc:3341} und dem Kamm",

	-- Step 56: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Südlich von Gann graben die Zwerge von Bael'dun bei {area:359}. Ausgräber und Großknechte arbeiten in der Grube; {npc:3392} (26) trägt das Tagebuch: Zieh ihn allein.",

	-- Step 58: Bael'dun fortress
	["Bael'dun fortress"] = "Festung von Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Die Soldaten, Scharfschützen und Offiziere von Bael'dun bewachen die Festung auf der Ostseite der Grabung; alle drei Gegenstände kommen von ihnen.",

	-- Step 60: The flying machine
	["The flying machine"] = "Die Flugmaschine",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "Die Flugmaschine der Zwerge steht auf ihrer Plattform in der Grabungsstätte.",

	-- Step 62: Twitching Antennae
	["Twitching Antennae"] = "Zuckende Fühler",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Die Fühler verschwinden fünfzehn Minuten nachdem sie fallen, also sammle sie jetzt, auf dem Rückweg nach Norden: Töte die Silithidschwärmer und Silithidkrabbler an den Buckeln im {area:390}, bis du fünf hast, und nimm dann sofort deinen Ruhestein zum {area:378}.",
	["Twitching Antennae from the silithid"] = "Zuckende Fühler von den Silithiden",

	-- Step 66: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} lagert an der Straße östlich von {area:380}.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Als Nächstes bietet er {quest:1838} an (1838, Stufe 30): Sie erfordert {area:1717} und schickt dich durch ganz Kalimdor und die Östlichen Königreiche. Der Kriegerklassen-Guide {quest:1838} deckt sie ab.",

	-- Step 67: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "Flieg zum Trainieren nach {area:1637}.",

	-- Step 68: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} bildet in {area:1638} Paladine aus. Du hast dort noch keine Flugroute: Flieg zum {area:378}, reite nach Westen durch {zone:1412} und einen Aufzug hinauf und hol dir die Flugroute bei {npc:2995} auf der mittleren Anhöhe.",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} steht in {object:172960}. Benutze dort {item:6626} am Beschwörungskreis und besiege die Sukkubus, um sie zu binden.",

	-- Step 70: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} in {area:272} lehrt Gifte: behalte sie",

	-- Step 71: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Flieg zum Trainieren nach {area:1638}: {npc:3033} ist auf der {area:1639}.",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Wirke {spell:18960}. Tauren: Füge die beiden Anhängerhälften beim {area:2362} am Nordwestufer des Sees zusammen, bevor du zu {npc:11802} in {area:2361} gehst.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: Benutze eine Hälfte beim {area:2362}",
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: der Willkommensgruß von {npc:3033}",

	-- Step 73: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Tauren: {npc:11957} wartet auf dem südlichen Hügel über der Brücke. Himmelsgeborene: {npc:272054} steht südlich der Zwillingsbrücken. Dann die Grabhügel östlich des Sees: Verlass deine Gestalt, klick die Statue am Eingang an für fünf Minuten Verstohlenheit, halte dich von den Geistern darin fern und nimm von jedem Relikt eins; {item:280680} liegt am Fuß der weißen Katzenstatue.",

	-- Step 75: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} in {area:2361} fliegt Druiden dorthin",

	-- Step 76: Back to the Crossroads
	-- {area:380} Crossroads · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Flieg zurück nach {area:380}. Der nächste Guide beginnt hier und nimmt die Straße nach Norden zum {area:1703} und nach {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bruuz"] = "Bruuz",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790} liegt am Nordrand von {area:382}, beim Turm der Venture Co. Darin ist {item:15883} für {quest:30}.",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391} in {area:272} lehrt {spell:2842}: behalte sie",
}
