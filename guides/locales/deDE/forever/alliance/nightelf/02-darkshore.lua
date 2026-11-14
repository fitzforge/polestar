-- German (deDE): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Das Boot legt westlich des Dorfes an. Der Flugmeister steht auf dem Hügel südlich des Gasthauses; die Questgeber sind entlang der Hauptstraße verteilt.",
	["The WANTED poster outside the inn"] = "Der Steckbrief vor dem Gasthaus",

	-- Step 2: The beach
	["The beach"] = "Der Strand",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Gezeitenkriecher krabbeln unterhalb des Dorfes am Ufer entlang; {quest:983} steht am Strand gleich südlich der Anlegestelle. Dunkelküstendrescher schwimmen im seichten Wasser. {object:175207} liegt gleich südlich des Dorfes am Ufer.",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, am Nordende des Dorfes",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Das Boot legt westlich des Dorfes an. Der Flugmeister steht auf dem Hügel südlich des Gasthauses; die Questgeber verteilen sich entlang der Hauptstraße. {npc:3666} steht oben im Gasthaus: Nimm drinnen die Treppe, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}, oben im Gasthaus",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, auf dem Steg",

	-- Step 5: The skeletal turtle
	["The skeletal turtle"] = "Die Skelettschildkröte",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, am Strand westlich der Docks; unter Wasser",

	-- Step 6: Buzzbox 827
	-- {quest:983} Buzzbox 827
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler
	["Only if you still carry {quest:983}'s quest: the Tide Crawlers scuttle along the shore below the village, and {quest:983} stands on the beach just south of the docks."] = "Nur, falls du die Quest von {quest:983} noch dabeihast: Die Tide Crawlers krabbeln am Ufer unterhalb des Dorfes entlang, und {quest:983} steht am Strand gleich südlich der Docks.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Crawler Legs: die Tide Crawlers",

	-- Step 7: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Bären und das Lager der Schwarzfelle",
	-- {area:442} Auberdine · {item:7586} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Rabid Thistle Bears streifen durch die Hügel südlich von {area:442}: Benutze {item:7586} an einem, um ihn einzufangen. Geh dann zum Furbolg-Lager direkt östlich von ihnen: Noch ist nichts zu töten.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "die Rabid Thistle Bears in der Nähe von {npc:3701}",

	-- Step 8: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} steht am Nordrand der Ruinen. Verfluchte und Zuckende Hochgeborene sowie {npc:2178} spuken dort; der Geist von {npc:3667} wandelt zwischen ihnen, die Eule {npc:270196} kreist östlich davon. Die beiden Schrifttafeln liegen in den Ruinen; eine {quest:4722} liegt westlich davon am Ufer.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Hochgeborenenrelikte",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Lies {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Lies {object:17189}",
	-- {item:5382} Anaya's Pendant · {npc:3667} Anaya Dawnrunner
	["{item:5382}: {npc:3667}, level 16; pull her away from the Highborne"] = "{item:5382}: {npc:3667}, Stufe 16; zieh sie von den Hochgeborenen weg",

	-- Step 9: The red crystal
	["The red crystal"] = "Der rote Kristall",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Klettere östlich von {area:447} in die östlichen Berge; der {object:175524} liegt auf einem Felsvorsprung.",

	-- Step 10: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {object:17183} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Nördlich an den Hügeln entlang. {npc:3650} wartet in den Ruinen von {quest:954}; Wild Grells und Vile Sprites bevölkern sie, Deth'ryll Satyrs den Ostrand. {object:17183} steht an der Straße westlich der Ruinen; ein {quest:4723} liegt auf dem Weg zu ihm am Ufer.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Grell-Ohrringe",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: Satyrn der Deth'ryll",

	-- Step 12: Auberdine
	["Fill the tube at the moonwell in the village"] = "Fülle die Phiole am Mondbrunnen im Dorf",

	-- Step 13: Blackwood furbolgs
	["Blackwood furbolgs"] = "Furbolgs der Schwarzfelle",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Pfadfinder und Windsprecher der Schwarzfelle halten das Lager südöstlich von {area:442}.",

	-- Step 14: The southern beaches
	["The southern beaches"] = "Die südlichen Strände",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Folge der Küste nach Süden an {area:447} vorbei: Eine {quest:4728} liegt am Ufer westlich des Hains, eine weitere weiter südlich nahe {area:450}. Drei weitere Überreste liegen weiter südwestlich zwischen Orakeln und Gezeitenjägern der Grauflossen (18-20): Der Guide hebt sie für die letzte Runde auf, wenn du näher an ihrer Stufe bist.",

	-- Step 15: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "Zurück nach Norden nach {area:447}: Die Flamme brennt im Süden der Ruinen.",

	-- Step 16: The red crystal
	["Back north-east into the mountains to the crystal."] = "Zurück nach Nordosten in die Berge zum Kristall.",

	-- Step 17: Bashal'Aran
	-- {npc:3650} Asterion · {area:442} Auberdine
	["North along the hills to {npc:3650}, then west down to {area:442}."] = "Nördlich an den Hügeln entlang zu {npc:3650}, dann westlich hinunter nach {area:442}.",

	-- Step 18: Auberdine
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, wo der Steg auf das Ufer trifft, auf dem Weg zum Boot",

	-- Step 19: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Boot nach {area:17203}",

	-- Step 20: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "Vom Boot runter steht {npc:268511} am Hafen: Seine Lieferung geht an {npc:483}s Käseladen im {object:2096}, neben dem Flugmeister.",

	-- Step 21: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}, in ihrem Käseladen",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "Die Treppe in ihrem Laden hinauf: Lass die Lieferung bei {object:460004}",

	-- Step 22: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} steht in {object:2098}, westlich von {object:2096}: Sein Kompass liegt in seinem alten Haus in {zone:1436}, auf dem Weg.",

	-- Step 23: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne {spell:202} bei {npc:11867} ({object:2096}, 10 Silber); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 24: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Wenn du schon hier bist: Lerne Schwerter bei {npc:11867} ({object:2096}, 10 Silber); ein Schwert in der Haupthand levelt einen Schurken zuverlässig.",

	-- Step 25: Druid trainer
	["Druid trainer"] = "Druidenlehrer",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} in {zone:1453}; {area:87} hat keinen Druidenlehrer",

	-- Step 27: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 28: Shaman trainer
	["Shaman trainer"] = "Schamanenlehrer",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} in {zone:1426}; {area:87} hat keinen Schamanenlehrer",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Into {area:148}"] = "Nach {area:148}",
}
