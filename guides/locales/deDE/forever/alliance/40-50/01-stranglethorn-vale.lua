-- German (deDE): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1445} Dustwallow Marsh · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["{zone:1445} first, then {zone:1434} and the {zone:1435}."] = "Zuerst {zone:1445}, dann {zone:1434} und {zone:1435}.",

	-- Step 1: Theramore
	["Theramore"] = "Theramore",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} steht nahe dem Gasthaus; {npc:4897}, ein Handwerkswarenhändler ein paar Schritte südlich, verkauft die Gewürze, die Jarl will.",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "{quest:1260}, drinnen",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "{npc:4964}, im obersten Stockwerk von {area:514}",
	-- {npc:271167} Guard Jameson · {quest:98233} Sword in the Slime
	["{npc:271167}: {quest:98233}, from the oozes on the way back east"] = "{npc:271167}: {quest:98233}, von den Schlammern auf dem Rückweg nach Osten",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, für Sumpfauge Jarl",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point · {quest:1265} The Missing Diplomat · {npc:4967} Archmage Tervosh
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\nIf {quest:1265} isn't done yet: {npc:4967} waits at the foot of the tower once you have looked around. Hand the quest in to him there, not in Theramore, and take his next errand on the spot."] = "Folge der Straße nach Nordwesten aus Theramore bis zum Wachturm bei {area:503}. Schlammpanzereinbuddler streifen durch den Sumpf darum herum.\nFalls {quest:1265} noch nicht gemacht ist: {npc:4967} wartet am Fuß des Turms, sobald du dich umgesehen hast. Gib die Quest dort bei ihm ab, nicht in Theramore, und nimm seinen nächsten Auftrag gleich dort an.",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the tower"] = "{npc:4967}, am Turm",

	-- Step 3: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "Nimm die Straße nach Norden zum Herrenhaus in Ruinen; Jarl wohnt in der Hütte daneben, und die lockere Erde ist an der Hausecke. Jarl will drei {quest:1218}: Falls du an {npc:4897} vorbeigekommen bist, kauf sie zuerst bei ihr in Theramore.",
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["{quest:1218}: {npc:4897} in Theramore, if you left without them"] = "{quest:1218}: {npc:4897} in Theramore, falls du ohne sie aufgebrochen bist",
	["with the spices from Theramore"] = "mit den Gewürzen aus Theramore",

	-- Step 4: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "Stinki Ignatz",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Stinki wartet westlich des Anwesens, im Sumpf unterhalb von {area:504}. Führ ihn zu seinen Sumpfbohnenblättern und halte die Sumpfkreaturen von ihm fern.",

	-- Step 5: North Point Tower
	-- {npc:4966} Private Hendel · {npc:4967} Archmage Tervosh · {npc:4968} Lady Jaina Proudmoore
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders.\n{npc:4967} and {npc:4968} wait beside the tower: once he yields, hand in to both on the spot."] = "{npc:4966} hält den Turm mit ein paar Deserteuren. Er wendet sich gegen dich: Schlag ihn, bis er aufgibt.\nVorsicht: Hendel hat zwei Wachen, die in den Kampf eingreifen, wenn er feindlich wird. Die Wachen fliehen, sobald er sich ergibt.\n{npc:4967} und {npc:4968} warten neben dem Turm: Sobald er aufgibt, gib bei beiden direkt vor Ort ab.",

	-- Step 6: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Die Darkmist-Spinnen nisten rund um die Höhle im Nordwesten des Sumpfes; jede Spinne lässt Augen fallen.\nVorsicht: Darkmist Lurkers bewegen sich getarnt und benutzen im Kampf Gift. Die Spinnen stehen dicht beieinander, daher sind zusätzliche Mobs üblich; einzelne Ziele vom Außenrand zu ziehen verringert das.",

	-- Step 7: Mudcrush Durtfeet
	["Head south to the giant's hut in the middle of the marsh."] = "Geh nach Süden zur Hütte des Riesen mitten im Sumpf.",

	-- Step 8: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes."] = "Das abgebrannte Gasthaus Zur süßen Ruh steht an der Straße nach Westen, Richtung {zone:1413}; die Plakette der Wache liegt in der Asche.",

	-- Step 9: Corrosive Swamp Oozes
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze
	["Corrosive Swamp Oozes"] = "Ätzende Sumpfbrühschlammer",
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze · Elder Daggermaws = {npc:272384} Elder Daggermaw · Bubbling Swamp Oozes = {npc:4394} Bubbling Swamp Ooze
	["On the way back east, the Corrosive Swamp Oozes (38-40) creep through the marsh south of the road, between the middle of the marsh and Theramore: one of them carries Jameson's training sword. Careful: Elder Daggermaws (48-49) lurk in the water among them, and the larger Bubbling Swamp Oozes (39-40) are elite: leave both alone."] = "Auf dem Rückweg nach Osten kriechen die Ätzenden Sumpfbrühschlammer (38-40) durch den Sumpf südlich der Straße, zwischen der Sumpfmitte und Theramore: Einer von ihnen trägt Jamesons Übungsschwert. Vorsicht: Uralte Dolchmäuler (48-49) lauern zwischen ihnen im Wasser, und die größeren Brodelnden Sumpfbrühschlammer (39-40) sind Elite: Lass beide in Ruhe.",

	-- Step 10: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. The officers are in {area:514}."] = "Folge der Straße nach Osten zurück nach Theramore. Die Offiziere sind in {area:514}.",
	["On the top floor"] = "Im obersten Stockwerk",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "{npc:4948}, im obersten Stockwerk",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, drinnen",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "{npc:4794}: Die Crawler sind am Ufer von {zone:1435}, behalte es",

	-- Step 11: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs der Schlammflossen",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}."] = "Die Murlocs der Schlammflossen drängen sich an der Nordküste hinter {area:497}.",

	-- Step 12: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "nur wenn du einen {item:3853} dabeihast (von Schmieden hergestellt)",

	-- Step 14: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Die Deserteure lagern südlich der Straße, westlich von {npc:4503}s Hütte.",

	-- Step 15: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["Back east along the road to Theramore: {npc:4944} takes the deserters' news on the top floor of {area:514}, and the flight master stands by its gate."] = "Zurück nach Osten entlang der Straße nach Theramore: {npc:4944} nimmt die Neuigkeiten der Deserteure im oberen Stockwerk von {area:514} entgegen, und der Flugmeister steht an seinem Tor.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, im obersten Stockwerk",

	-- Step 16: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",
	["Theramore flight master"] = "Flugmeister von Theramore",

	-- Step 18: Fly to Ratchet
	-- {npc:6236} Klannoc Macleod · {area:720} Fray Island · {area:392} Ratchet · {area:150} Menethil Harbor
	["{npc:6236}'s Affray first: {area:720} lies just south of {area:392}. The boat to {area:150} leaves from Theramore afterwards."] = "Zuerst {npc:6236}s Auseinandersetzung: {area:720} liegt direkt südlich von {area:392}. Das Boot nach {area:150} fährt danach von Theramore ab.",

	-- Step 20: The Affray
	-- {area:720} Fray Island · {area:391} Merchant Coast · {area:392} Ratchet · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["{area:720} lies off the {area:391} just south of {area:392}: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "{area:720} liegt vor der {area:391} gleich südlich von {area:392}: Wate über die Untiefen der Sandbank. {npc:6236} schickt dir nacheinander vier Herausforderer und dann {npc:6238} (Stufe 33) entgegen.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Besiege die Herausforderer und {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236} bietet als Nächstes Der Windbehüter (1791) an: Die Questreihe um die Waffe für Wirbelwind, mit einem Elite am Ende, steht im Kriegerklassen-Guide „Wirbelwaffe“.",

	-- Step 21: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	-- {area:150} Menethil Harbor
	["Back to Theramore for the boat to {area:150}."] = "Zurück nach Theramore, um das Boot nach {area:150} zu nehmen.",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Flugmeister in {area:392}",

	-- Step 22: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 23: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Flugmeister von {area:150}",

	-- Step 25: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4732} lehrt Menschen in {area:88} im östlichen {zone:1429}, neben den Pferden von {npc:384}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: andere Farben, 20g",

	-- Step 26: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "Auf Stufe 40 kannst du mit 100 Gold das Reiten lernen, und beim Lernen bekommst du ein Reittier. Himmelsgeborene lernen es bei {npc:265756}, dem Stallmeister und Reitlehrer in den {area:17684} in {area:16638} auf Zephras Isle, der auch die Galestrider verkauft: Das Himmelsboot zur Insel legt etwa alle fünf Minuten an der Nordseite von {area:279} ab. Sammlungen, Reittiere · Stufe 40 listet die Galestrider auf.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Reiten und Galestrider: {npc:265756}, in den {area:17684} in {area:16638} auf Zephras Isle.",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "Himmelsboot nach Zephras Isle: die Nordseite von {area:279}, etwa alle fünf Minuten.",

	-- Step 27: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Boot nach {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet · {zone:1413} Barrens
	["The boat to {area:35} leaves from {area:392}'s dock, below the flight master. Without the {area:392} flight path: follow the road west out of the marsh into the {zone:1413} and north up the coast to {area:392}, and learn it there."] = "Das Boot nach {area:35} legt am Dock von {area:392} ab, unterhalb des Flugmeisters. Ohne die Flugroute nach {area:392}: Folge der Straße nach Westen aus dem Sumpf in den {zone:1413} und dann nach Norden die Küste entlang bis {area:392}, und lerne sie dort.",

	-- Step 28: Boat to Booty Bay
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["Level 40 with 100 gold later on? {npc:4732} teaches riding at {area:88} in {zone:1429}: Collectibles, Mounts · Level 40 has the trip."] = "Später Stufe 40 und 100 Gold? {npc:4732} lehrt Reiten in {area:88} in {zone:1429}: Sammelobjekte, Reittiere · Stufe 40 hat die Reise.",

	-- Step 30: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "Flugmeister von {area:42}",

	-- Step 31: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, oben",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "für {npc:770} beim {area:99}, auf der nördlichen Runde",
	-- {npc:2494} Privateer Bloads · {area:35} Booty Bay
	["{npc:2494}' Akiris by the Bundle waits for the level-48 {area:35} stop (its naga are 43-44): leave it for now."] = "{npc:2494}' Akiris vom Bündel wartet auf den Stopp der Stufe 48 in {area:35} (die Naga dort sind 43-44): lass es vorerst.",
	-- {npc:2487} Fleet Master Seahorn · {quest:669} Sunken Treasure · {area:327} Faldir's Cove
	["{npc:2487}, top floor: {quest:669}, if you did {area:327} with a group"] = "{npc:2487}, oberstes Stockwerk: {quest:669}, falls du {area:327} mit einer Gruppe gemacht hast",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "{npc:737}, oben: die Skullsplitter-Trolle, auf der nördlichen Runde",
	-- {npc:737} Kebok · {area:37} Lake Nazferiti
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, at {area:37} on the northern loop"] = "{npc:737}: die Gerommelten Kristalle, bei {area:37} auf der nördlichen Runde",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}'s Zanzil's Secret waits for the same stop (Zanzil's village is 43-44): leave it for now."] = "{npc:2498}s Zanzil's Secret wartet auf denselben Halt (Zanzils Dorf ist 43-44): Lass es vorerst liegen.",
	["Seahorn's next errand goes back to Arathi: skip it."] = "Seehorns nächster Auftrag führt zurück nach Arathi: Überspring ihn.",

	-- Step 32: Kebok
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["Already have all eight Tumbled Crystals? Hand them to {npc:737} now."] = "Hast du schon alle acht Gerommelte Kristalle? Gib sie jetzt an {npc:737}.",

	-- Step 33: Booty Bay
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "{npc:2542}, oben",
	["Upstairs"] = "Oben",

	-- Step 34: Bloodsail camp
	["Bloodsail camp"] = "Lager der Blutsegelbukaniere",
	-- plural, as words: Bloodsail Mages = {npc:1562} Bloodsail Mage
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks.\nCareful: the Bloodsail Mages and Warlocks here are level 40-43 and cast from range: pull one at a time and fight with your back to the open beach."] = "Verlass den Ort durch den Tunnel und folge der Küste nach Norden; der Brief liegt im Lager der Blutsegelbukaniere am Strand, wo Schönling Duncan umhergeht.\nVorsicht: Die Magier und Hexenmeister der Blutsegelbukaniere hier sind Stufe 40-43 und wirken aus der Ferne: Zieh sie einzeln und kämpfe mit dem Rücken zum offenen Strand.",

	-- Step 35: Booty Bay
	-- {quest:597} The Bloodsail Buccaneers · {area:35} Booty Bay · {area:43} Wild Shore
	["Seahorn's next task, {quest:597}, waits for the level-48 {area:35} stop with the {area:43} camp (41-43): leave it for now."] = "Seahorns nächste Aufgabe, {quest:597}, wartet auf den Stopp bei Stufe 48 in {area:35} mit dem {area:43}-Lager (41-43): Lass sie vorerst.",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, im obersten Stockwerk",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} schwimmt vor der Nordwestküste, auf der nördlichen Runde",

	-- Step 36: Booty Bay
	["You missed this on the route's earlier visit here: take it now, before the Bloodsail camp. Its gorillas live on the hills just above the camp."] = "Mistvale-Innereien",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",

	-- Step 37: Bloodsail pirates: kill these as you meet them
	["Bloodsail pirates: kill these as you meet them"] = "Blutsegelbukaniere: Töte diese, sobald sie dir begegnen",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit.\nCareful: Rippa (44, a rare crocolisk) swims the shore beside the camp: stay out of the water."] = "Jeder Blutsegel lässt Schnupftabak fallen und einer von ihnen trägt {npc:2493}s Auge: nimm sie von den Räubern und Magiern (39-41) im Blutsegel-Lager am Strand nördlich der Stadt, wo du den Brief gefunden hast. Lass das Lager in {area:43} südlich der Stadt (Hexenmeister und Haudegen 41-43) für den Besuch auf Stufe 48.\nVorsicht: Rippa (44, ein seltenes Krokodil) schwimmt entlang des Ufers neben dem Lager: bleib aus dem Wasser.",

	-- Step 38: Gorilla hills
	["Gorilla hills"] = "Gorillahügel",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["From the Bloodsail camp, climb into the Mistvale hills just east of it: the Elder Mistvale Gorillas (40) there drop the giblets."] = "Suche einzelne Level-40-Älter in diesemselben Lager für Sehnen und Innereien. Lass Level-41-Gorillas allein; bleibe nicht nur extra für Zähne.",

	-- Step 39: Booty Bay
	-- {npc:2488} Deeg
	["Back down to town: Shaky stands at the tunnel mouth; {npc:2488} and MacKinley are on the top floor."] = "Wieder hinab in die Stadt: Shaky steht am Tunnelmund; {npc:2488} und MacKinley sind im obersten Stockwerk.",
	-- {npc:2486} Fin Fizracket · {npc:1514} Mokk the Savage · {area:35} Booty Bay
	["{npc:2486}'s Stranglethorn Fever ({npc:1514}) waits for the level-48 {area:35} stop: leave it for now."] = "Das Schlingendornfieber von {npc:2486} ({npc:1514}) wartet auf den Halt in {area:35} auf Stufe 48: Lass es vorerst liegen.",
	-- {area:35} Booty Bay
	["MacKinley's Voodoo Dues waits for the level-48 {area:35} stop, with Zanzil's village: leave it for now."] = "MacKinleys Voodoo Dues wartet auf den Halt in {area:35} auf Stufe 48, zusammen mit Zanzils Dorf: Lass es vorerst liegen.",

	-- Step 40: Stoley's Debt
	-- {quest:2872} Stoley's Debt · {area:35} Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor, offers {quest:2872} from level 40 (under 40, this guide's last {area:35} stop offers it again)."] = "\"Sea Wolf\" MacKinley, oben, bietet {quest:2872} ab Stufe 40 an (unter Stufe 40 bietet es der letzte {area:35}-Stopp dieses Guides erneut an).",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley: for Stoley in {zone:1446}, keep it"] = "\"Sea Wolf\" MacKinley: für Stoley in {zone:1446}, behalte es",

	-- Step 41: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Dschungelpirscher",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "Die Jungle Stalkers streifen über die Hänge westlich der Mine.",

	-- Step 42: Zul'Mamwe's Mystics and the Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Zul'Mamwe's Mystics and the Shadowmaw Panthers"] = "Die Mystiker von Zul'Mamwe und die Schattentatzenpanther",
	-- {npc:739} Brother Nimetz
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["East from the stalkers' slopes to the ruins of Zul'Mamwe: the Skullsplitter Mystics (39-40) in its northern half carry {npc:739}'s fetishes. Careful: the Witch Doctors, Berserkers and Headhunters (41-44) hold the ruins' southern half: stay north. Then north-west toward the coast: the Shadowmaw Panthers (37-38) prowl the jungle west of the ruins, often stealthed."] = "Von den Hängen der Pirscher nach Osten zu den Ruinen von Zul'Mamwe: Die Mystiker der Skullsplitter (39-40) in der nördlichen Hälfte tragen die Fetische für {npc:739}. Vorsicht: Die Hexendoktoren, Berserker und Kopfjäger (41-44) halten die südliche Hälfte der Ruinen: Bleib im Norden. Dann nach Nordwesten Richtung Küste: Die Schattentatzenpanther (37-38) streifen durch den Dschungel westlich der Ruinen, oft getarnt.",
	-- {item:2466} Skullsplitter Fetish
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic
	["{item:2466}, from the Skullsplitter Mystics"] = "{item:2466}, von den Mystikern der Skullsplitter",

	-- Step 43: The north-west coast
	["The north-west coast"] = "Die Nordwestküste",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Go on north-west to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Geh weiter nach Nordwesten zur Bucht an der Nordwestküste. Die Riesenmuscheln liegen auf ihrem Grund und enthalten die Perlen; {npc:2624} schwimmt zwischen ihnen und lässt {item:4034} fallen.",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "{item:4611}; unter Wasser",

	-- Step 44: Sin'Dall
	-- {npc:729} Sin'Dall
	["North-east from the bay toward Nesingwary's camp: {npc:729}, the great tiger (37), lairs on the hilltop just south-west of the camp."] = "Von der Bucht nach Nordosten Richtung Nesingwarys Lager: {npc:729}, der große Tiger (37), haust auf der Hügelkuppe direkt südwestlich des Lagers.",

	-- Step 45: Hemet Nesingwary
	-- {npc:718} Sir S. J. Erlgadin
	["{npc:718}, beside him"] = "{npc:718}, neben ihm",

	-- Step 46: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["{npc:717}, beside the other hunters"] = "{npc:717}, neben den anderen Jägern",

	-- Step 49: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit · {item:213562} Bug Catching Net
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: open {npc:217412}'s {item:213565} and use its {item:213562} on one. Don't kill it."] = "Ein {npc:217588} krabbelt im Dschungel südöstlich von Nesingwarys Lager, auf dem Weg zu {area:99}: Öffne {item:213565} von {npc:217412} und benutze dessen {item:213562} an einem. Töte ihn nicht.",
	-- {item:213562} Bug Catching Net · {npc:217588} Arbor Tarantula · {item:213566} Arbor Tarantula Specimen
	["{item:213562}, on an {npc:217588}: the {item:213566}"] = "{item:213562}, an einem {npc:217588}: {item:213566}",

	-- Step 50: Rebel Camp
	["Head north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Geh nach Nordosten an Nesingwarys Lager vorbei und folge der Straße nach Norden zum Lager am oberen Ende des Tals.",

	-- Step 51: Brother Nimetz
	-- {npc:739} Brother Nimetz · {area:301} Savage Coast · {npc:2277} Loremaster Dibbs · {area:271} Southshore · {zone:1418} Badlands · {zone:1425} Hinterlands
	["{npc:739}: the {area:301} report bundle for {npc:2277} in {area:271}, on the {zone:1418} & {zone:1425} guide: keep it"] = "{npc:739}: das Berichtsbündel von der {area:301} für {npc:2277} in {area:271}, im Guide {zone:1418} & {zone:1425}: Behalte sie",

	-- Step 52: Kurzen's Compound
	-- {area:99} Rebel Camp · {area:101} Kurzen's Compound · {npc:218230} Wendel Mathers · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Subchiefs = {npc:978} Kurzen Subchief
	["East from the {area:99} to {area:101}: {npc:218230} is caged at its western edge. The Kurzen Subchiefs (35-36) and Elites (36-37) carry his cage key; the fighter's uniform lies in a supply crate in the compound's eastern part.\nCareful: {npc:813}, an elite of 39-40, stands at the compound's north end beside three of the Subchiefs: take the key from the Subchiefs and Elites further south and leave him be."] = "Vom {area:99} nach Osten zu {area:101}: {npc:218230} ist an dessen Westrand eingesperrt. Kurzens Stabschefs (35-36) und Elitesoldaten (36-37) tragen seinen Käfigschlüssel; die Kämpferuniform liegt in einer Vorratskiste im Ostteil des Lagers.\nVorsicht: {npc:813}, ein Elite der Stufe 39-40, steht am Nordende des Lagers neben drei der Stabschefs: Hol dir den Schlüssel von den Stabschefs und Elitesoldaten weiter südlich und lass ihn in Ruhe.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage, if you didn't take it on the 30-40 loop"] = "{npc:218230}, in seinem Käfig, falls du sie nicht schon in der Runde 30-40 angenommen hast",
	-- {item:216616} Compound Cage Key
	["{item:216616}, from the Subchiefs (or the Elites)"] = "{item:216616}, von den Stabschefs (oder den Elitesoldaten)",
	-- {item:216617} Kurzen Fighter's Uniform
	["{item:216617}, in the supply crate deep in the cave"] = "{item:216617}, in der Vorratskiste tief in der Höhle",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, back at his cage on the way out"] = "{npc:218230}, auf dem Rückweg wieder an seinem Käfig",
	-- {npc:218229} Captain Aransas · {area:35} Booty Bay
	["For {npc:218229} in {area:35}, at the end of the jungle loop"] = "Für {npc:218229} in {area:35}, am Ende der Dschungelrunde",

	-- Step 53: Lake Nazferiti
	-- {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Head south from the compound to {area:37}. The Venture Co. Geologists in the shore camps carry the Tumbled Crystals; Venture Co. Agents (39) walk among them. Stay on the shore: stealthed Shadowmaw Panthers prowl the jungle south and east of the lake."] = "Geh vom Lager nach Süden nach {area:37}. Die Geologen der Venture Co. in den Strandlagern tragen die Gerommelten Kristalle; Venture Co. Agents (39) laufen unter ihnen umher. Bleibe am Ufer: getarnte Schattentatzenpanther streifen durch den Dschungel südlich und östlich des Sees.",

	-- Step 54: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:728} ist ein Elite der Stufe 40: Die meisten Klassen schaffen ihn allein auf Stufe 42, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- Step 55: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "{area:103}: Töte diese, sobald sie dir begegnen",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Die Skullsplitter-Trolle halten die Ruinen direkt östlich der Mine; jeder von ihnen kann Hauer fallen lassen, ihre Panther immer.\nFolge der Straße nach Nordosten zum Lager der Venture Co. an der {area:310}; die Miners, Surveyors und Foremen lassen die Kristalle fallen.\nVorsicht: Getarnte Shadowmaw Panthers und Stranglethorn Tigresses streifen durch das Gebiet rund um das Lager.",
	-- {item:1524} Skullsplitter Tusk
	["{item:1524}, from the trolls of the ruins"] = "{item:1524}, von den Trollen der Ruinen",

	-- Step 56: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:730} ist ein Elite der Stufe 43: Die meisten Klassen schaffen ihn allein auf Stufe 45, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- Step 60: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:731} ist ein Elite der Stufe 43: Die meisten Klassen schaffen ihn allein auf Stufe 45, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.\nVorsicht: Tiger und getarnte Shadowmaw Panthers streifen in seiner Nähe umher. Räum sie, bevor du ihn ziehst. Wenn er gezogen wird, ruft {npc:731} Kreaturen im Umkreis von 20 Metern zu Hilfe.",

	-- Step 62: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road south to {area:35}."] = "Folge der Straße nach Süden nach {area:35}.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, oben",

	-- Step 63: Kebok
	-- {area:37} Lake Nazferiti
	["The crystals gathered at {area:37}"] = "Die bei {area:37} gesammelten Kristalle",

	-- Step 64: Booty Bay
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: für {quest:2864} in {zone:1446}, behalte es",

	-- Step 65: Stoley's Debt
	-- {quest:2872} Stoley's Debt
	["If you didn't take {quest:2872} on the earlier stop: \"Sea Wolf\" MacKinley, on the top floor."] = "Falls du {quest:2872} nicht am früheren Stopp angenommen hast: \"Sea Wolf\" MacKinley, im obersten Stockwerk.",

	-- Step 66: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 67: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} kocht im {object:2169}; {npc:5384} ist im {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "{npc:5694}: für {npc:5464} in {area:42}, auf dem Weg zum Sumpf",

	-- Step 68: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, Königliche Bibliothek in {object:2117}",

	-- Step 70: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladin: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, in der Kathedrale des Lichts",

	-- Step 71: Stormwind City
	["Stormwind City"] = "Sturmwind",

	-- Step 72: Warlock: Summon Felsteed
	-- {quest:4488} Summon Felsteed
	["Warlock: {quest:4488}"] = "Hexenmeister: {quest:4488}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, im {object:2164}: {npc:6251} in {area:392} nimmt es am Ende des nächsten Guides an",

	-- Step 74: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Flieg nach {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Flugmeister von {area:442}",

	-- Step 77: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4753} lehrt Nachtelfen in {zone:1457}, neben den Säblern von {npc:4730}: das Boot vom {area:17203} nach {area:442}, dann der Flug nach {area:702}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt), etwa bei {npc:4732} in {area:88} im {zone:1429}. Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: andere Farben, 20g",

	-- Step 79: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Flieg nach {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Flugmeister von {area:702}",

	-- Step 80: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Boot nach {area:17203}",

	-- Step 81: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 82: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "{npc:5464}, beim Flugmeister",

	-- Step 84: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "Die Schriftrolle liegt im Sumpf nördlich von Biggs. Die Sumpfwandler nördlich davon können Khadgars Aufsätze fallen lassen.",

	-- Step 85: Amaryllis Webb
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends · {zone:1417} Arathi Highlands
	["{npc:217412}: {quest:93176}, from the {zone:1417} guide"] = "{npc:217412}: {quest:93176}, aus dem {zone:1417}-Führer",

	-- Step 86: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "{npc:5476} steht an der Straßenkreuzung im Westen des Sumpfes.",

	-- Step 87: The sunken temple
	["The sunken temple"] = "Der versunkene Tempel",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Head east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Geh nach Osten; die Wuchernden Schrecken unterwegs lassen auch die Aufsätze fallen. Durchsuche den Rand des {area:74}, wo die Ruinen des Tempels aus dem Wasser ragen.",

	-- Step 88: Misty Reed Strand
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler · Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Silt Crawlers (40-41) crowd the north end of the eastern shore, and the driftwood washes up along it from there.\nCareful: the big Monstrous Crawlers (43-44) further south on the shore are over you: take the legs at the north end and pick up the driftwood without pulling them."] = "Die Schlickkriecher (40-41) drängen sich am Nordende des Ostufers, und das Treibholz wird von dort aus am Ufer angespült.\nVorsicht: Die großen Monströsen Kriecher (43-44) weiter südlich am Ufer sind über deiner Stufe: Hol dir die Beine am Nordende und sammle das Treibholz ein, ohne sie zu pullen.",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers"] = "{item:5938}, von den Schlickkriechern",

	-- Step 89: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}, just south of the swamp"] = "für {area:1438}, direkt südlich des Sumpfes",

	-- Step 90: Into the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Into the {zone:1419}"] = "Nach {zone:1419}",
	-- {zone:1419} Blasted Lands · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang
	["Follow the road south-east from Biggs to the pass into the {zone:1419}, keeping clear of {area:75}, the Horde town to the north-east.\nDown the pass, the road bends east to {area:1438}. Careful: {npc:5982} vultures (46) and Starving Snickerfangs (45) hunt in the dry hills south of the road: stay on it and keep moving."] = "Folge der Straße nach Südosten von Biggs zum Pass in den {zone:1419} und meide {area:75}, die Hordestadt im Nordosten.\nDen Pass hinunter biegt die Straße nach Osten zu {area:1438}. Vorsicht: {npc:5982}-Geier (46) und Verhungernde Kicherfänge (45) jagen in den trockenen Hügeln südlich der Straße: Bleib auf ihr und bleib in Bewegung.",
	-- {zone:1419} Blasted Lands
	["The pass to the {zone:1419}"] = "Der Pass zur {zone:1419}",
	-- {area:1438} Nethergarde Keep
	["The road to {area:1438}"] = "Die Straße nach {area:1438}",

	-- Step 91: Nethergarde Keep
	-- {npc:5385} Watcher Mahar Ba · {npc:5393} Quartermaster Lungertz
	["{npc:5385} is upstairs in the keep and {npc:5393} inside it; the gryphon master stands south of the keep."] = "{npc:5385} ist oben in der Festung und {npc:5393} drinnen; der Greifenmeister steht südlich der Festung.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}, oben",

	-- Step 92: Fly to Stormwind
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "Flugmeister von {area:1438}",

	-- Step 93: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "für {npc:5635} in {area:348}: Behalte es",

	-- Step 94: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tiefenbahn nach {zone:1455}",

	-- Step 97: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "{npc:5637} ist in der Halle der Reclaimers beim {object:32356}, {npc:2786} in der {object:32383}.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} hat keinen Schamanenlehrer",

	-- Step 99: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4772} lehrt Zwerge in {area:803}, östlich von {area:131} an der Straße nach {zone:1432}, neben den Widdern von {npc:1261}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: andere Farben, 20g",

	-- Step 101: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:7954} lehrt Gnome in {area:189}, gleich östlich von {area:131}, neben den Roboschreitern von {npc:7955}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: andere Farben, 20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["\"Sea Wolf\" MacKinley: keep it, for the level-48 {area:35} stop, with Zanzil's village"] = "\"Seewolf\" MacKinley: Behalte sie für den Halt in {area:35} auf Stufe 48, zusammen mit Zanzils Dorf",
	-- ["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "Allein überspringst du Nesingwarys drei Elite-Jagden: Hol dir ihre Erfahrung stattdessen von den Skullsplitter-Trollen von Zul'Mamwe, direkt östlich der Mine, sodass jeder Kill auch für die Hauer von {npc:737} zählt. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1517}.",
	-- ["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Eine {npc:217588} kriecht im Dschungel südöstlich von Nesingwarys Lager, auf dem Weg zum {area:99}: Fang eine mit dem Werkzeug aus dem {item:213565} von {npc:217412}.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. Es ist kein Reitlehrer der Himmelsgeborenen bekannt; der Forever-Client führt {spell:1285849} unter der einen Reitfertigkeit, also sollte {npc:4732} in {area:88} im östlichen {zone:1429}, der nächste Lehrer bei {zone:1453}, es lehren (unbestätigt). Die Windschreiter verkauft {npc:265756} in {area:16638} auf der Insel Zephras; Sammelobjekte, Reittiere · Stufe 40 listet sie.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4732} lehrt Menschen in {area:88} im östlichen {area:12}, neben den Pferden von {npc:384}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt). Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "Mit 40 und 100 Gold kannst du reiten lernen, und dabei erhältst du ein Reittier. {npc:4753} lehrt Nachtelfen in {zone:1457}, neben den Säblern von {npc:4730}: das Boot vom {area:17203} nach {area:442}, dann der Flug nach {area:702}. In Forever kann womöglich jedes Volk bei jedem Reitlehrer lernen (unbestätigt), etwa bei {npc:4732} in {area:88} im {area:12}. Sammelobjekte, Reittiere · Stufe 40 listet alle Farben.",
	-- ["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "Zurück in Theramore: Tervosh wartet mit Lady Jaina im Turm von {area:514}.",
	-- ["Bloodsail pirates"] = "Piraten der Blutsegelbukaniere",
	-- ["Cold Eye Basilisks"] = "Kaltaugenbasilisken",
	-- ["Cortello's scroll"] = "Cortellos Schriftrolle",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit."] = "Jeder Blutsegelbukanier lässt Schnupftabak fallen, und einer von ihnen trägt das Auge von {npc:2493}: Hol sie dir von den Plünderern und Magiern (39-41) im Lager der Blutsegelbukaniere am Strand direkt nördlich des Ortes, wo du den Brief gefunden hast. Spar dir das Lager an der {area:43} südlich des Ortes (Hexenmeister und Swashbuckler 41-43) für den Besuch auf Stufe 48 auf.",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}.\nCareful: the {area:43} camp's Warlocks and Swashbucklers are level 41-43, a level or more above you, and stand close together: pull them singly from the edge."] = "Jeder Blutsegelbukanier lässt Schnupftabak fallen, und einer trägt {npc:2493}s Auge; die Schwadroneure gehen gleich nördlich des Orts am Ufer entlang. Die Karten und Befehle liegen im Piratenlager an der {area:43} südlich von {area:35}.\nVorsicht: Die Hexenmeister und Schwadroneure im Lager an der {area:43} sind Stufe 41-43, eine Stufe oder mehr über dir, und stehen dicht beieinander: Zieh sie einzeln vom Rand.",
	-- ["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Jeder Anhänger von Zanzil kann die Mixtur fallen lassen; {npc:2537} geht im Süden des Lagers umher.",
	-- ["Fly to {area:144}"] = "Flieg nach {area:144}",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Flieg nach {area:42} und reite nach Osten durch den {zone:1430} in die {zone:1435}; {npc:5476} steht gleich hinter der Grenze an der Straße.",
	-- ["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Folge der Straße nach Osten zurück nach Theramore. Tervosh, Lady Jaina und die Offiziere sind im Turm und in {area:514}.",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Folge der Straße nach Nordosten zum Lager der Venture Co. an der {area:310}; Minenarbeiter, Feldmesser und Großknechte lassen die Kristalle fallen.",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Folge der Straße nach Nordwesten aus Theramore hinaus zum Wachturm bei {area:503}. Schlammpanzereinbuddler streifen durch den Sumpf darum herum.",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\n{npc:4967} waits at the foot of the tower: once you have looked around, hand the quest in to him there, not in Theramore."] = "Folge der Straße nach Nordwesten aus Theramore hinaus zum Wachturm bei {area:503}. Schlammpanzereinbuddler streifen durch den Sumpf darum herum.\n{npc:4967} wartet am Fuß des Turms: Sobald du dich umgesehen hast, gib die Quest dort bei ihm ab, nicht in Theramore.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Windschreiter: {npc:265756}, in {area:16638} auf der Insel Zephras.",
	-- ["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Gib die Fangzähne ab und bleib: Drei Wellen Gorillas kommen, {npc:1514} zuletzt. Kämpfe mit voller Gesundheit.",
	-- ["Head back down to town; Shaky stands at the tunnel mouth."] = "Geh zurück hinab in den Ort; Zitterhand steht am Tunneleingang.",
	-- ["Head inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets."] = "Geh ins Landesinnere zu den Gorillahügeln im Nebeltal. Alte Nebeltalgorillas lassen die Innereien fallen.",
	-- ["Head north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "Geh nach Nordwesten ins {zone:1413} und die Küste hinauf nach {area:392}: Das Boot nach {area:35} legt an seinem Steg ab, und der Greifenmeister von {area:392} steht gleich darüber.",
	-- ["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Falls du {quest:543} übersprungen hast, grinde hier bis Stufe 42,46, um im Plan der Route zu bleiben. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1517}.",
	-- ["Inside"] = "Drinnen",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Klannoc bietet als Nächstes Der Windbehüter (1791) an: Die Questreihe um die Waffe für {spell:1680}, mit einem Elite am Ende, steht im Kriegerklassen-Guide „Wirbelwind-Waffe“.",
	-- ["Level 42.16"] = "Stufe 42,16",
	-- ["Level 42.16 at Zul'Mamwe"] = "Stufe 42,16 bei Zul'Mamwe",
	-- ["Level 42.46"] = "Stufe 42,46",
	-- ["MacKinley's next task sends you after elite ogres: skip it."] = "MacKinleys nächster Auftrag schickt dich zu Elite-Ogern: Überspring ihn.",
	-- ["Mudrock tortoises"] = "Schlammpanzerschildkröten",
	-- ["Naga Explorers"] = "Forscher der Naga",
	-- ["No flight path to {area:144} yet: ride out of {zone:1455}'s gates, east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Noch keine Flugroute nach {area:144}: Reite aus den Toren von {zone:1455}, nach Osten durch {zone:1426} und den Tunnel nach {zone:1432} und weiter entlang der Straße nach {area:144}.",
	-- ["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "Auf dem Ritt nach Norden nach {area:392} liegt {area:720} vor der {area:391} südlich des Orts: Wate über die Untiefen der Sandbank. {npc:6236} schickt dir nacheinander vier Herausforderer und dann {npc:6238} (Stufe 33) entgegen.",
	-- ["On the way north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "Auf dem Weg nach Norden nach {area:392} liegt {area:720} vor der {area:391} südlich des Orts: Wate über die Untiefen der Sandbank. {npc:6236} schickt dir nacheinander vier Herausforderer und dann {npc:6238} (Stufe 33) entgegen.",
	-- ["Optional: Cortello's scroll lies inside one of the three Bloodsail ships anchored off the coast just south of {area:35}, on a middle or lower deck, and is not always on the same ship. Their crews are 42-45 pirates: clear your way from the edge, one at a time, and leave the captains (45-48), whom the route comes back for at 48."] = "Optional: Cortellos Schriftrolle liegt in einem der drei Schiffe der Blutsegelbukaniere, die direkt südlich von {area:35} vor der Küste ankern, auf einem mittleren oder unteren Deck, und nicht immer auf demselben Schiff. Ihre Mannschaften sind Piraten der Stufe 42-45: Kämpf dich vom Rand aus vor, einen nach dem anderen, und lass die Kapitäne (45-48) in Ruhe; für sie kommt die Route auf Stufe 48 zurück.",
	-- ["Ride back down to town; Shaky stands at the tunnel mouth."] = "Reite zurück hinab in den Ort; Zitterhand steht am Tunneleingang.",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Reite die Straße zurück nach Westen; {npc:217412} steht ein kurzes Stück nördlich von Biggs.",
	-- ["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "Reite nach Osten aus {zone:1426} durch den Tunnel nach {zone:1432} und weiter entlang der Straße nach {area:144}.",
	-- ["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Reite nach Osten; die Wuchernden Schrecken unterwegs lassen auch die Aufsätze fallen. Durchsuche den Rand des {area:74}, wo die Ruinen des Tempels aus dem Wasser ragen.",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Reite von Theramore nach Westen über die Straße der Marschen ins {zone:1413} und nach Norden nach {area:392} an der Küste. Hol dir die Flugroute bei {npc:16227}, dann nimm am Steg das Boot nach {area:35}.",
	-- ["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Reite ins Landesinnere zu den Gorillahügeln im Nebeltal. Alte Nebeltalgorillas lassen die Innereien fallen; {npc:1449} sitzt zwischen ihnen.",
	-- ["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Reite nach Norden in die Hügel westlich der Straße. {npc:2535} und {npc:2536} stehen zusammen gleich nördlich von Zanzils Dorf.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Reite nach Nordosten an Nesingwarys Lager vorbei und folge der Straße nach Norden zum Lager am oberen Ende des Tals.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Reite nach Nordosten an Nesingwarys Lager vorbei und folge der Straße nach Norden zum Lager am oberen Ende des Tals. Unterwegs krabbelt eine {npc:217588} im Dschungel südöstlich von Nesingwarys Lager: Fang eine mit dem Einsteigerpaket für Entomologen und hak sie dann ab.",
	-- ["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Reite von der Mine nach Nordwesten zur Bucht an der Nordwestküste. Die Riesenmuscheln liegen auf ihrem Grund und enthalten die Perlen; {npc:2624} schwimmt zwischen ihnen und lässt {item:4034} fallen.",
	-- ["Ride north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "Reite nach Nordwesten ins {zone:1413} und die Küste hinauf nach {area:392}: Das Boot nach {area:35} legt an seinem Steg ab, und der Greifenmeister von {area:392} steht gleich darüber.",
	-- ["Ride south down the road to {area:35}."] = "Reite die Straße nach Süden nach {area:35}.",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {area:3}; {npc:2860} lagert bei der Ausgrabung.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Reite nach Süden aus {zone:1432} durch den Pass ins {zone:1418}; {npc:2860} lagert bei der Ausgrabung.",
	-- ["Ride south to the giant's hut in the middle of the marsh."] = "Reite nach Süden zur Hütte des Riesen mitten im Sumpf.",
	-- ["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "Seahorn bietet jetzt {quest:604} an: Lass sie aus. Ihre drei Captains sind Stufe 45-48 mit Besatzungen um sich, und die Route bringt dich mit 48 dafür zu Seahorn zurück.",
	-- ["Seahorn's Bloodsail Buccaneers: keep it for the level-48 {area:35} stop, with the {area:43} camp."] = "Seehorns Blutsegelbukaniere: Behalte sie für den Halt in {area:35} auf Stufe 48, zusammen mit dem Lager an der {area:43}.",
	-- ["Skullsplitter ruins"] = "Ruinen der Skullsplitter",
	-- ["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "Noch unter Stufe 42,16 nach den Jagden, die du gemacht hast? Hol den Rest bei den Cold Eye Basilisks an der {area:310} nach, auf deinem Weg nach Süden nach {area:35}. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1517}.",
	-- ["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Nimm die Straße nach Norden zum zerstörten Anwesen; Jarl wohnt in der Hütte daneben, und die lockere Erde ist an der Hausecke.",
	-- ["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "Nimm die {area:2257} vom {object:28027}. {npc:5637} ist in der Halle der Forscherliga beim {object:32356}, {npc:1356} in der Halle selbst, {npc:2786} im {object:32383}. Der nächste Guide fliegt weiter nach {area:144}.",
	-- ["The Bloodsail captains"] = "Die Kapitäne der Blutsegelbukaniere",
	-- ["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Die Kaltaugenbasilisken liegen auf den Felsen westlich der Mine.",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "Die Graunebelspinnen nisten um die Höhle im Nordwesten des Sumpfs; jede Spinne lässt Augen fallen.",
	-- ["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Die Murlocs der Schlammflossen drängen sich an der Nordküste hinter {area:497}; sammle die restlichen Zungen bei den Schildkröten daneben.",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Die Schlammpanzerschildkröten und Dornenschlammpanzer sonnen sich am Ufer nordöstlich des Anwesens.",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Die Skullsplitter-Trolle halten die Ruinen gleich östlich der Mine; jeder von ihnen kann Hauer fallen lassen, ihre Panther immer.",
	-- ["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "Das Boot legt in Theramore ab: Melde dich auf dem Weg zu den Docks bei {npc:4944} im obersten Stockwerk von {area:514}.",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "Das abgebrannte Gasthaus Zur süßen Ruh steht an der Straße nach Westen, Richtung {zone:1413}; die Plakette der Wache liegt in der Asche, und die Hufabdrücke sind im Schlamm neben dem Gasthaus.",
	-- ["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Die Kapitäne stehen auf den Schiffen vor der {area:43}, jeder mit einer Mannschaft aus Piraten der Stufe 42-45: Stillwasser (45) und Kielhol (46) auf den näheren Decks, {npc:2546} (48) auf dem Flaggschiff. Mit 42 ist das ein Kampf für eine Gruppe oder fürs Ende des Guides; säubere jedes Deck vorher, falls du gehst. Cortellos Schriftrolle liegt auf dem Wrack am Ufer.",
	-- ["The driftwood washes up along the eastern shore."] = "Das Treibholz wird am Ostufer angeschwemmt.",
	-- ["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Die Naga durchkämmen die Strände nördlich des Lagers der Blutsegelbukaniere; sie lassen das Schilf fallen.",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "Die nächste Schriftrolle des Rätsels liegt im Westen der Marschen von Dustwallow: Überspring sie.",
	-- ["Unbagwa's ritual"] = "Unbagwas Ritual",
	-- ["Warlock: {quest:3631}"] = "Hexenmeister: {quest:3631}",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.",
	-- ["Zanzil's village"] = "Zanzils Dorf",
	-- ["for Stoley in {zone:1446}: keep it"] = "für Stoley in {zone:1446}: Behalte es",
	-- ["for Stoley in {zone:1446}: keep it; on the top floor"] = "für Stoley in {zone:1446}: behalte es; im obersten Stockwerk",
	-- ["for the flight back to {npc:6251} at 43"] = "für den Rückflug zu {npc:6251} mit 43",
	-- ["for the {area:8} later"] = "für die {area:8} später",
	-- ["for the {zone:1435} later"] = "für die {zone:1435} später",
	-- ["for {area:1438}: keep it"] = "für {area:1438}: Behalte es",
	-- ["for {npc:2616} in Theramore: keep it"] = "für {npc:2616} in Theramore: Behalte es",
	-- ["grind on {npc:667}"] = "Grinde an {npc:667}",
	-- ["grind on {npc:690}"] = "Grinde an {npc:690}",
	-- ["grind on {npc:766}"] = "Grinde an {npc:766}",
	-- ["keep it: the {area:43} camp's charts and Swashbucklers (41-43) wait for the level-48 {area:35} stop"] = "behalte sie: Die Karten und Swashbuckler (41-43) im Lager an der {area:43} warten auf den Halt in {area:35} auf Stufe 48",
	-- ["{area:43}: kill these as you meet them"] = "{area:43}: Töte diese, sobald sie dir begegnen",
	-- ["{item:216617}, in the supply crate"] = "{item:216617}, in der Vorratskiste",
	-- ["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, für Sumpfauge Jarl",
	-- ["{item:5938}, from the Silt Crawlers on the same shore"] = "{item:5938}, von den Silt Crawlers am selben Ufer",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: für {npc:1344} in {zone:1432}, behalte es",
	-- ["{npc:1449}, inside {area:1742}"] = "{npc:1449}, in {area:1742}",
	-- ["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "{npc:1470} ist unter der Erde in {area:144}, beim Gasthaus. Seine Pilze wachsen in der Grabung von {area:1517} im {zone:1418}; der nächste Guide führt dich dorthin und zurück durch {area:144}.",
	-- ["{npc:1470}, below ground"] = "{npc:1470}, unter der Erde",
	-- ["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, aus 30-40/05-arathi-highlands",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: Fang sie, für {quest:93176}",
	-- ["{npc:2487}, top floor"] = "{npc:2487}, oberstes Stockwerk",
	-- ["{npc:2494}: keep it, its naga (43-44) wait for the level-48 {area:35} stop"] = "{npc:2494}: behalte sie, ihre Naga (43-44) warten auf den Halt in {area:35} auf Stufe 48",
	-- ["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}s nächster Zanzil-Auftrag beginnt in {zone:1441}: Überspring ihn.",
	-- ["{npc:2498}, inside: keep it, Zanzil's village (43-44) waits for the level-48 {area:35} stop"] = "{npc:2498}, drinnen: behalte sie, Zanzils Dorf (43-44) wartet auf den Halt in {area:35} auf Stufe 48",
	-- ["{npc:2535} and {npc:2536}"] = "{npc:2535} und {npc:2536}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} lagert allein in {area:1898}, südöstlich der Ausgrabungsstätte.",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} hält den Turm mit ein paar Deserteuren. Er wendet sich gegen dich: Schlag ihn, bis er aufgibt.",
	-- ["{npc:4968}, on the top floor"] = "{npc:4968}, im obersten Stockwerk",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: für {area:1438}, behalte es",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}: Berserkerhaltung",
	-- ["{npc:717}, beside them"] = "{npc:717}, neben ihnen",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} ist das hohe Gebäude über dem Hafen; die meisten Questgeber sind auf seinen Stockwerken oder unten an den Docks.",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, für „Sumpfauge“ Jarl",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} steht nahe dem Gasthaus; {npc:4897}, ein Handwerkswarenhändler ein paar Schritte südlich, verkauft die Gewürze, die Jarl will.",
	-- ["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}: {item:4612} ist ein seltener Drop, daher sind das Sammeln und die Abgabe ebenfalls optional",
	-- ["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",
}
