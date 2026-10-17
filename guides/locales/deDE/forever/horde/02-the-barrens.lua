-- German (deDE): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:380} The Crossroads
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} ist deine Basis für diesen Guide. Alle, die du brauchst, stehen nur wenige Schritte vom Gasthaus entfernt.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, der Windreitermeister",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: Die Harpyien kommen später, in {area:383}",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Ebenenschreiter und Raptoren",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Ebenenschreiter und Raptoren der Bluthorn streifen überall um {area:380} über die Ebenen, am dichtesten im Norden.",

	-- Step 4: The Zhevra
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze north and east of town."] = "Zhevra-Läufer grasen nördlich und östlich des Orts.",
	["Zhevra"] = "Zhevras",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Lager der Grimmhauer",
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Die Savannenstreuner jagen auf den Ebenen zwischen dem Ort und dem Lager der Grimmhauer im Osten. Im Lager halten Wassersucher und Dornenwirker die westliche Hälfte, Jäger die Mitte; die Vorratskisten stehen am östlichen Ende.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss
	["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} steht auf dem Kamm nördlich des Lagers der Grimmhauer.",

	-- Step 8: Far Watch Post
	-- {area:814} Southfury River
	["Follow the road east to the outpost above the {area:814}."] = "Folge der Straße nach Osten zum Außenposten über dem {area:814}.",

	-- Step 9: Thunder lizards across the river
	["Thunder lizards across the river"] = "Donnerechsen jenseits des Flusses",
	-- {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Donnerechsen und Blitzechsen grasen gleich jenseits der Brücke unterhalb von {area:379}.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {area:379} Far Watch Post
	["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} wartet am Flussufer südlich von {area:379}, jenseits der Brücke.",

	-- Step 12: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Kultisten in {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {item:6652} Reagent Pouch · {item:5026} Fire Tar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Kultisten der Burning Blade halten {area:1898} im Norden von {zone:1411}; sie lassen {item:6652} fallen. {item:5026} bekommst du bei deinem nächsten Besuch im Lager der Grimmhauer.",

	-- Step 13: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} The Crossroads · {area:392} Ratchet · {object:58369} Stolen Iron Chest
	["{npc:5878} camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} lagert an der Straße von {area:380} nach {area:392}. {object:58369} steht im Süden des Lagers der Grimmhauer gleich nördlich von ihm.",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Folge der Straße nach Südosten nach {area:392} an der Küste.",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: Die Konsole ist in {area:382}, später",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, am Kai",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Strand der Südmeerfreibeuter",
	-- {area:392} Ratchet
	["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Die Piraten lagern am Strand südlich von {area:392}. Die Haufen komplizierter Teile liegen zwischen ihnen im Sand.",

	-- Step 17: Stolen Booty
	["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Zurück den Strand hinunter, am Piratenlager vorbei: Die Kiste mit Stiefeln und die zerbrechliche Kiste mit der Linse stehen an seinem Südende.",

	-- Step 19: The Crossroads
	-- {area:380} The Crossroads
	["Walk back west along the road to the {area:380}."] = "Geh die Straße zurück nach Westen nach {area:380}.",

	-- Step 20: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Zurück zum Lager der Grimmhauer. Geomanten und Verteidiger halten die östliche Hälfte; {npc:3438} läuft zwischen ihnen herum.",

	-- Step 21: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} macht aus dem Teer und dem Beutel {item:6636}. Benutze es am Kohlenbecken neben ihm, um {npc:5893} sichtbar zu machen, töte sie für {item:6655} und leg die Glut dann ins Kohlenbecken.",

	-- Step 22: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, dein {item:5176} und {item:263412}",

	-- Step 23: Echeyakee
	-- {quest:881} Echeyakee
	["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, ein weißer Löwe, streift über die Ebenen nördlich des Lagers der Grimmhauer.",

	-- Step 24: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "{object:4141} steht bei der Forschungsstätte der Venture Co. westlich von {area:382}. Schließ die drei Ventile um den Bohrer, benutze die Konsole erneut und nimm dann {item:5089} von {npc:3471} daneben.",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} in {area:392}: später, auf dem Weg",

	-- Step 25: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "Nach Westen in {area:383}. Die Harpyien der Hexenschwingen nisten überall dort; jede kann eine Klaue fallen lassen. {quest:819} liegt in ihren Hügeln.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["South to {npc:3389}'s watch post on the Kolkar border."] = "Nach Süden zu {npc:3389}s Wachposten an der Grenze zu den Kolkar.",

	-- Step 27: The Forgotten Pools
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Die Teiche liegen gleich nördlich von {npc:3389}. Geh ins Wasser, um sie zu erkunden; die Potenten Pilze für Helbrim wachsen drumherum. Töte jeden Kolkar auf dem Weg für Armschienen.",

	-- Step 28: Kolkar camps
	["Kolkar camps"] = "Lager der Kolkar",
	-- {npc:3389} Regthar Deathgate
	-- plural, as words: Kolkar Wranglers = {npc:3272} Kolkar Wrangler
	["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Zänker und Sturmruferinnen der Kolkar halten die Lager südlich von {npc:3389}.",

	-- Step 31: The Stagnant Oasis
	-- {area:380} The Crossroads
	["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Südöstlich von {area:380}. Teste die Samen an der blubbernden Spalte am Ostufer der Oase.",

	-- Step 32: Raptor nests
	["Raptor nests"] = "Raptornester",
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Die drei Nester liegen zusammen in {area:1697} südwestlich der Oase; Bluthornsensenklauen bewachen sie.",

	-- Step 33: Ratchet
	-- {area:392} Ratchet
	["East to {area:392}, on the coast."] = "Nach Osten nach {area:392} an der Küste.",

	-- Step 34: The Crossroads
	["Back west along the road."] = "Die Straße zurück nach Westen.",

	-- Step 35: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Oasenschnappkiefer kriechen um {area:387}, südwestlich von {area:380}, und um {area:388}.",

	-- Step 36: The Crossroads
	-- {quest:3301} Mura Runetotem · {area:228} Sepulcher · {zone:1421} Silverpine Forest
	["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} in {zone:1421}, nächster Guide",

	-- Step 37: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "Die Töterinnen der Hexenschwingen halten den Westen von {area:383}; sie tragen die Ringe.",

	-- Step 38: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "Nach Osten zum {area:1703}; {npc:9316} steht im Lager gleich südlich davon.",

	-- Step 39: Nugget Slugs
	-- {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}, east of {npc:9316}."] = "Die Werkzeugkisten mit den Patronen liegen um die Bohrstelle der Venture Co. in {area:382}, östlich von {npc:9316}.",

	-- Step 40: Wenikee Boltbucket
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar
	["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Behalte sie: {quest:3923} steht vor {zone:1454}; ein späterer Guide gibt sie ab",

	-- Step 41: The Crossroads
	-- {area:380} The Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Geh zurück nach Süden nach {area:380}. Der nächste Guide beginnt hier und bringt dich nach {zone:1454} und zum Zeppelin nach {zone:1420}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the {area:380}, and around the {area:388}."] = "Oasenschnappkiefer kriechen um {area:387}, südwestlich von {area:380}, und um {area:388}.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Ebenenschreiter und Raptoren der Bluthorn streifen überall um {area:380} über die Ebenen, am dichtesten im Norden.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "Südöstlich von {area:380}. Teste die Samen an der blubbernden Spalte am Ostufer der Oase.",
	-- ["The {area:383}"] = "{area:383}",
	-- ["Thun'grim camps beside the road from the {area:380} to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "Thun'grim lagert an der Straße von {area:380} nach {area:392}. {object:58369} steht im Süden des Lagers der Grimmhauer gleich nördlich von ihm.",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Geh zurück nach Süden nach {area:380}. Der nächste Guide beginnt hier und bringt dich nach {zone:1454} und zum Zeppelin nach {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Geh die Straße zurück nach Westen nach {area:380}.",
}
