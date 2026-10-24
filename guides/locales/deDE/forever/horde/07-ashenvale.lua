-- German (deDE): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Flieg von {area:392} zum {area:2897} an der Küste von {zone:1440}.",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717}: Seine Eskorte beginnt sofort",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} geht den Strand hinauf nach Norden zu einer Nagakohlenpfanne. Lösch die Kohlenpfanne und beschütze ihn dann durch die Wellen der Naga, bis Vorsha die Peitscherin tot ist.",
	["Naga brazier"] = "Nagakohlenpfanne",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "Ruinen: {area:2797}",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "Der Weg zu den Saphiren führt durch die versunkenen Ruinen am Nordende des Strands: Geh die Treppe hinunter in die Grube.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Saphire von Aku'Mai",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "Die Saphire sind blaue Kristalle an den Wänden der Tunnel zum Portal der {area:2797}, unterirdisch und außerhalb der Instanz: Schwimm aus der Grube hinab, unter der Mauer hindurch, in die Höhle. Die Satyrn und Naga in den Tunneln sind Elite: Eine Gruppe wird empfohlen. Die Kristalle erscheinen schnell wieder, du musst also nicht tief hinein.",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "{npc:12736} bietet als Nächstes eine Quest für die {area:2797} an; lass sie aus, außer du hast eine Gruppe.",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "Östlich von Zoram'gar bevölkern die Furbolgs der Distelfelle das Dorf und die Hügel um ihre Höhle.",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "Höhle der Distelfelle",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "In der Höhle stehen Trolltruhen entlang der Tunnel. {npc:12818} wird tief drinnen festgehalten: Befreie ihn und beschütze ihn den ganzen Weg hinaus, dann läuft er heim nach {area:428}.",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "Zurück nach Westen nach Zoram'gar, bevor es endgültig nach Osten geht.",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Folge der Hauptstraße nach Osten an {area:415} vorbei (Allianz: bleib auf der Straße). {npc:12678}, ein großer Grizzly, streift durch die Ruinen ({area:418}) südlich der Straße, westlich von {area:421}. Seine Pranke startet die nächste Jagdquest.",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "Brunnen: {area:418}",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "Der Brunnen steht mitten in den Ruinen ({area:418}): Benutze dort den {item:7767}.",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, eine Ergänzung von Forever, steht am Westufer von {area:421} mit drei schnellen Drachentöter-Quests.",
	-- {npc:210995} Alonso
	["{npc:210995} may not offer these to every class; if he doesn't, carry on."] = "{npc:210995} bietet diese vielleicht nicht jeder Klasse an; wenn nicht, mach weiter.",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, ein verderbter Wasserelementar, treibt im {area:421}. Ihr {item:16408} startet eine Quest für den Splintertreeposten.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Die Furbolgs der Fäulnisklauen halten die Wälder östlich von {area:421}, südlich der Straße. Stell {item:16972} auf den {object:178206} und bewache es: Die Furbolgs kommen, um es niederzureißen. {npc:12918} kommt zuletzt; sein Totem fällt in den Korb.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Bleib auf der Straße nach Osten. {npc:12858} wartet südwestlich vom Holzfällerlager der Warsong. Er und seine Grunzer stürmen den {area:2360}: Lass sie die Aggro ziehen und bleib bei {npc:12858}, bis {npc:12860} tot ist.",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} steht im Holzfällerlager. Die Kundschafter von Ashenvale pirschen durch die Wälder südöstlich davon; sie sind getarnt, also halte nach ihnen Ausschau.",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "Die Straße hinauf nach Norden zum {area:431} und nach {area:428} daneben.",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: nur, wenn du die Handbuchseiten dabeihast",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, ein großer Nachtsäbler, streift durch die Wälder südöstlich vom Holzfällerlager der Warsong. Ihre Klaue startet die nächste Jagdquest.",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "Satyrn der Teufelshufe",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "Nordwestlich vom Splintertreeposten lagern die Satyrn der Teufelshufe im Wald. Jeder Satyr kann Hörner fallen lassen.",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, ein Schattenpanther, pirscht durch die Wälder um {area:426}, westlich vom Lager der Teufelshufe. Ihr Kopf startet die nächste Jagdquest.",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "Zurück nach Südwesten zum {area:421}. Beschmutzte Wasserelementare treiben an seinen Ufern; der Pavillon steht auf der Insel mit Blick auf den Außenposten der Allianz.",
	["Gazebo"] = "Pavillon",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, head west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Flieg nach {area:1638}, wenn du den Flugpunkt kennst. Sonst flieg nach {area:378}, geh nach Westen in {zone:1412} an {area:222} vorbei nach {area:1638} und nimm seinen Flugpunkt bei {npc:2995} auf der mittleren Anhöhe.",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Sprich mit {npc:3057} in {area:1638}: {quest:93739}",
	-- {npc:3057} Cairne Bloodhoof
	["Talk to {npc:3057}"] = "Sprich mit {npc:3057}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "Der Irdene Ring",
	-- {zone:1456} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Fahr mit einem Aufzug von {zone:1456} hinunter. Das Lager des Irdenen Rings steht nördlich der Klippen: {npc:264074}, {npc:264072} und {npc:259118}.",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "Nördlich des Lagers überrennen Spinnen die Grabstätte {area:17044}. Benutze den {item:273015} von {npc:264074} an den Angenagten Leichnamen; die Spinner lassen {item:273181} fallen. {npc:264082} sitzt am Nordende: Ihr {item:273658} startet {quest:96294}.",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "Toxinproben der Düsteranhöhe, von den Angenagten Leichnamen",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, von Spinnern der Düsteranhöhe",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}, von {npc:264082}",

	-- Step 26: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "Zurück nach Süden zum Lager, dann hinauf nach {zone:1456} für den Flug nach {area:378}.",

	-- Step 27: Brine
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Flieg von {zone:1456} nach {area:378}. Die Hütte von {npc:5899} steht auf dem Kamm über dem Wasserloch der Stacheleber südlich des Lagers, an der Straße zum Aufzug ({area:1718}).",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "für {npc:5901}, südlich von {area:392}: nächster Guide",

	-- Step 28: Great Lift
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Flieg von {zone:1456} nach {area:378} und nimm die Straße nach Süden zum Aufzug ({area:1718}) ganz im Süden des {zone:1413}s.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, oben am Aufzug",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Fahr mit dem Aufzug hinunter und folge dann der Straße nach Osten durch die Schluchten zum {area:484}, einem Taurendorf oben auf den Tafelbergen. Sein Aufzug ist auf der Nordseite.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, beim Windreitermeister",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}, die Handwerkswarenhändlerin: die kreischenden Harpyien im {area:487}",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "Der Steckbrief neben {npc:10537}",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Fahr mit dem Aufzug hinunter. Das Ei liegt in einem Nest am Schluchtboden an einer von drei Stellen: südöstlich der Tafelberge (52.3,55.2), östlich (56.4,50.4) oder südwestlich (37.6,56.1).",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "Zentauren der Galak",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Die Lager der Galak füllen die Schlucht nördlich vom Freiwindposten; Späher, Zänker und Windhetzerinnen der Galak teilen sich jedes Lager. Ein einzelner {npc:10617} läuft zwischen den Lagern: Töte ihn, wenn du ihn triffst, seine Notiz startet eine Quest für den {area:2237}.",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} steht oben auf einem Tafelberg östlich der Lager der Galak. Für {quest:1149} geh über das Ende der Planken neben ihm hinaus: Du landest sicher.",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "Lager der Grimmtotem",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "Westlich vom Freiwindposten liegen die Lager der Grimmtotem unterhalb vom {area:2097}. Die Geheimnotizen liegen in Dokumententruhen im südöstlichen, südwestlichen und nordwestlichen Lager.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, südöstliches Lager",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, südwestliches Lager",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, nordwestliches Lager",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Steig den Pfad hinauf auf den {area:2097}. {npc:10646} wird neben {npc:10896} (29) gefangen gehalten: Besiege zuerst die Wachen und {npc:10896}, befreie sie dann und beschütze sie auf dem Weg hinunter; unterwegs greifen dich Grimmtotem aus dem Hinterhalt an.",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "Folge der Schlucht nach Westen zum {area:2237}.",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "{npc:10428}s nächste Quest, Hochheiliges Feuer, endet in {zone:1456}, abseits dieser Route. Überspring sie.",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Töte den {npc:10720}, der für {npc:10638} kommt",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "Westlich vom Weißgipfelposten nisten die Flügeldrachen auf den Klippen ({area:482}); die Eier liegen in den Nestern. {npc:10427} wartet auf der Ostseite der Nistplätze: Befreie ihn und halte ihn auf dem Rückweg zum {area:2237} am Leben.",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "Südlich vom Düsterwolkengipfel: die Harpyien im {area:487}. {npc:4490} (31) läuft zwischen ihnen umher: Dünn die Harpyien um sie aus, bevor du sie pullst. Die Kreischenden Harpyien, Wildfedern und Windruferinnen dort sind für {npc:4877}.",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}, ein hart zuschlagender Felselementar, wandert über die Klippen ({area:482}). {npc:4499} ist Elite: Eine Gruppe wird empfohlen.",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Folge der Schlucht nach Osten aus den Tafelbergen hinaus auf die Salzebenen. Die Goblins und Gnome der {area:2240} sind neutral und geben beiden Fraktionen Quests.",
	["His crate is for Stranglethorn, later on the route"] = "Seine Kiste ist fürs Schlingendorntal, später auf der Route",

	-- Step 45: The salt flats
	["The salt flats"] = "Die Salzebenen",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868} liegen überall auf den Ebenen nördlich der Rennbahn. Skorpidhäscher und Spiegelpanzerschildkröten streifen durch die Nordhälfte, Salzwüstenaasfresser kreisen am Himmel, und Salzsteinbasilisken grasen westlich der Strecke. Die Salzsteinkristallhäute streifen durch die Mitte der Ebenen und die Salzsteinstarrer (34-35, fünf Stufen über dir: einzeln) durch den äußersten Süden.",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: Sein Brief geht an Martek im {zone:1418}, etwa auf Stufe 38",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "Der nächste Guide fliegt von hier weiter nach {zone:1454}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Flieg nach {area:1638}, wenn du die Flugroute kennst. Wenn nicht, flieg nach {area:378}, reite nach Westen nach {zone:1412} an {area:222} vorbei bis {area:1638} und hol dir die Flugroute bei {npc:2995} auf der mittleren Anhöhe.",
	-- ["Shadumbra"] = "Schattumbra",
	-- ["Sharptalon"] = "Scharfkralle",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "Tideress",
	-- ["Ursangous"] = "Ursangus",
}
