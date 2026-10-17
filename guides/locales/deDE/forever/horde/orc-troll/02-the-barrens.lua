-- German (deDE): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "Du kommst von {area:379}. {npc:3338} steht beim Gasthaus; {npc:3429} und {npc:3449} auf der Turmplattform; Helbrim und {npc:3464} am Nordtor; {npc:3448} am Südtor.",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Ebenenschreiter und Raptoren",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Ebenenschreiter und Raptoren der Bluthorn streifen überall um {area:380} über die Ebenen.",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "Zhevras und Raptoren",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "Zhevra-Läufer grasen auf denselben Ebenen; sammle dabei die restlichen Raptorköpfe.",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}, auf der Turmplattform: erfordert Stufe 12",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} lagert an der Straße nach Osten Richtung {area:392}.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} steht auf dem Kamm nördlich des Lagers der Grimmhauer, östlich von {area:380}.",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900} wartet am Ufer des {area:814} auf der Seite von {zone:1411}, östlich des Lagers der Grimmhauer.",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Kultisten in {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "Kultisten der Burning Blade halten {area:1898} im Norden von {zone:1411}, bei {area:370}; sie lassen {item:6652} fallen.",

	-- Step 10: Razormane camp
	["Razormane camp"] = "Lager der Grimmhauer",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Wassersucher, Dornenwirker und Jäger halten das Lager östlich von {area:380}. Die Vorratskisten stehen an seinem östlichen Ende. Krieger: {object:58369} steht im Lager. Schamanen: Die Stacheleber lassen {item:5026} fallen. Töte Savannenstreuner, an denen du vorbeikommst, für ihre Klauen.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} macht aus dem Teer und dem Beutel {item:6636}. Benutze es am Kohlenbecken neben ihm, um {npc:5893} sichtbar zu machen, töte sie für {item:6655} und leg die Glut dann ins Kohlenbecken.",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, dein {item:5176} und {item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Folge der Straße nach Südosten nach {area:392} an der Küste.",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, am Kai",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Strand der Südmeerfreibeuter",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "Die Piraten lagern am Strand südlich von {area:392}. Die Haufen komplizierter Teile liegen in und um ihr Lager.",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "Zurück zum Piratenlager: Die Stiefel sind in der Kiste mit der Aufschrift {object:3767} am Südende des Lagers, die Linse in der zerbrechlichen Kiste gleich östlich davon.",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "Zurück nach {area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Geh die Straße zurück hinauf nach {area:380}. Savannenstreuner jagen an ihr entlang und auf den Ebenen westlich des Orts: Sammle die restlichen Klauen, bevor du sie abgibst.",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} steht am Wachposten der Kolkar gleich westlich von {area:380}.",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "Lager der Kolkar und {area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Die Lager der Kolkar verteilen sich nordwestlich von {npc:3389}; jeder Kolkar kann {quest:855} fallen lassen. {area:386} liegen in ihrer Mitte, mit Potenten Pilzen rund ums Wasser. Savannenstreuner streifen über dieselben Ebenen.",
	["Wade into the pools to explore them"] = "Wate in die Teiche, um sie zu erkunden",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "Harpyien der Hexenschwingen",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "Die Harpyien nisten in {area:383} nordwestlich von {area:386}; jede kann eine Klaue fallen lassen.",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Geh nach Osten zur Forschungsstätte der Venture Co. westlich vom {area:382}. Benutze {object:4141}, schließ die drei Ventile um den Bohrer, benutze die Konsole erneut und nimm dann {item:5089} von {npc:3471}.",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "Der Unterschlupf von {quest:881} liegt südlich vom {area:382}, nordöstlich von {area:380}. Benutze dort das Horn, das {npc:3338} dir gegeben hat, um den weißen Löwen hervorzulocken. Nimm dann den Ruhestein nach {area:392}.",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Auf dem Rückweg nach {area:380} wieder das Lager der Grimmhauer: Geomanten und Verteidiger halten die östliche Hälfte; {npc:3438} läuft zwischen ihnen herum.",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "Die Oase liegt südöstlich von {area:380}. Teste die Samen an der blubbernden Spalte mitten im Wasser.",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697} liegt südwestlich der Oase. Bluthornsensenklauen lassen die Federn fallen, die du an den drei Nestern benutzt.",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Oasenschnappkiefer drängen sich im Wasser von {area:387}, südwestlich von {area:380}.",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "Folge der Straße nach Norden zum {area:1703}; {npc:9316} steht gleich südlich davon.",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "Die Werkzeugkisten stehen um das Lager der Venture Co. im {area:382}, östlich von {npc:9316}.",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "Töterinnen der Hexenschwingen",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "Die Töterinnen halten das westliche Ende von {area:383}, hinter den Harpyien, die du schon bekämpft hast; sie lassen die Ringe fallen.",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "grinde Töterinnen der Hexenschwingen in {area:383}, {zone:1413}",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "Zurück nach {area:380}; der nächste Guide beginnt hier.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "Zurück nach {area:380}",
	-- ["Back to the {area:380}; the next guide starts here."] = "Zurück nach {area:380}; der nächste Guide beginnt hier.",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Geh nach Osten zur Forschungsstätte der Venture Co. westlich von {area:382}. Benutze {object:4141}, schließ die drei Ventile um den Bohrer, benutze die Konsole erneut und nimm dann {item:5089} von {npc:3471}.",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Oasenschnappkiefer drängen sich im Wasser von {area:387}, südwestlich von {area:380}.",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "Auf dem Rückweg nach {area:380} wieder das Lager der Grimmhauer: Geomanten und Verteidiger halten die östliche Hälfte; {npc:3438} läuft zwischen ihnen herum.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Ebenenschreiter und Raptoren der Bluthorn streifen überall um {area:380} über die Ebenen.",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "Regthar steht am Wachposten der Kolkar gleich westlich von {area:380}.",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Die Lager der Kolkar verteilen sich nordwestlich von Regthar; jeder Kolkar kann {quest:855} fallen lassen. {area:386} liegen in ihrer Mitte, mit Potenten Pilzen rund ums Wasser. Savannenstreuner streifen über dieselben Ebenen.",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "Die Werkzeugkisten stehen um das Lager der Venture Co. in {area:382}, östlich von Wenikee.",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "Die Oase liegt südöstlich von {area:380}. Teste die Samen an der blubbernden Spalte mitten im Wasser.",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Geh die Straße zurück hinauf nach {area:380}. Savannenstreuner jagen an ihr entlang und auf den Ebenen westlich des Orts: Sammle die restlichen Klauen, bevor du sie abgibst.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Wassersucher, Dornenwirker und Jäger halten das Lager östlich von {area:380}. Die Vorratskisten stehen an seinem östlichen Ende. Krieger: {object:58369} steht im Lager. Schamanen: Die Stacheleber lassen {item:5026} fallen. Töte Savannenstreuner, an denen du vorbeikommst, für ihre Klauen.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} steht auf dem Kamm nördlich des Lagers der Grimmhauer, östlich von {area:380}.",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "Der Unterschlupf von {quest:881} liegt südlich von {area:382}, nordöstlich von {area:380}. Benutze dort das Horn, das Sergra dir gegeben hat, um den weißen Löwen hervorzulocken. Nimm dann den Ruhestein nach {area:392}.",
}
