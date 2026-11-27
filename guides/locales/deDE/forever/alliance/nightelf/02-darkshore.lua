-- German (deDE): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Das hast du beim früheren Besuch der Route hier verpasst: Es kommt jetzt zuerst. Es geht schnell und öffnet die Quests danach.\nDas Boot legt westlich des Dorfes an. Der Flugmeister steht auf dem Hügel südlich des Gasthauses; die Questgeber sind entlang der Hauptstraße verteilt.",
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

	-- Step 6: The skeletal turtle
	["The skeletal turtle"] = "Die Skelettschildkröte",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}, am Strand westlich der Docks; unter Wasser",

	-- Step 7: Buzzbox 827
	-- {quest:983} Buzzbox 827
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler
	["Only if you still carry {quest:983}'s quest: the Tide Crawlers scuttle along the shore below the village, and {quest:983} stands on the beach just south of the docks."] = "Nur, falls du die Quest von {quest:983} noch dabeihast: Die Tide Crawlers krabbeln am Ufer unterhalb des Dorfes entlang, und {quest:983} steht am Strand gleich südlich der Docks.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Crawler Legs: die Tide Crawlers",

	-- Step 8: Darkshore Threshers
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Darkshore Threshers"] = "Darkshore-Thresher",
	-- {quest:983} Buzzbox 827 · {area:452} Mist's Edge · {quest:1001} Buzzbox 411 · {quest:954} Bashal'Aran
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["{quest:983} stands on the beach just south of the docks: once his crawler legs are in, he asks for Thresher Eyes. The Darkshore Threshers (12-14) swim in the shallows off the docks and up the shore to {area:452}; {quest:1001}, who takes the eyes, stands north of {quest:954} at the end of the first loop."] = "{quest:983} steht am Strand direkt südlich der Anlegestellen: sobald seine Beine da sind, verlangt er Thresher-Augen. Die Darkshore-Thresher (12-14) schwimmen im Flachwasser vor den Anlegestellen und den Strand hinauf bis {area:452}; {quest:1001}, der die Augen entgegennimmt, steht nördlich von {quest:954} am Ende der ersten Schleife.",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes; underwater"] = "Thresher Eyes; unter Wasser",

	-- Step 9: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Bären und das Lager der Schwarzfelle",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {quest:2139} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Tollwütige Distelbären streifen durch die Hügel südlich von {area:442}: Benutze {quest:2139} auf einen, um ihn zu fangen. Geh dann zum Furbolg-Lager direkt östlich von ihnen: Hier gibt es noch nichts zu töten.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "die Rabid Thistle Bears in der Nähe von {npc:3701}",

	-- Step 10: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} steht am Nordrand der Ruinen. Verfluchte und Zuckende Hochgeborene sowie {npc:2178} spuken dort; der Geist von {npc:3667} wandelt zwischen ihnen, die Eule {npc:270196} kreist östlich davon. Die beiden Schrifttafeln liegen in den Ruinen; eine {quest:4722} liegt westlich davon am Ufer.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Hochgeborenenrelikte",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Lies {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Lies {object:17189}",

	-- Step 11: The red crystal
	["The red crystal"] = "Der rote Kristall",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Klettere östlich von {area:447} in die östlichen Berge; der {object:175524} liegt auf einem Felsvorsprung.",

	-- Step 12: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road north-north-west of {npc:3650}; a {quest:4723} lies on the shore on the way to him."] = "Nördlich an den Hügeln entlang. {npc:3650} wartet in den Ruinen von {quest:954}; Wilde Grells und Üble Grimmlinge bevölkern sie, Satyrn der Deth'ryll den Ostrand. {quest:1001} steht an der Straße nordnordwestlich von {npc:3650}; auf dem Weg zu ihm liegt ein {quest:4723} am Ufer.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Grell-Ohrringe",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: Satyrn der Deth'ryll",

	-- Step 13: Buzzbox 411
	-- {quest:4723} Beached Sea Creature · {quest:1001} Buzzbox 411 · {area:442} Auberdine
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["North-north-west of Asterion by the road, past the {quest:4723}: {quest:1001} wants Moonstalker Fangs next, from the second loop's hills. Then south-west down to {area:442}."] = "Nordnordwestlich von Asterion an der Straße, vorbei an {quest:4723}: {quest:1001} will als Nächstes Mondpirscher-Fangzähne, aus den Hügeln der zweiten Schleife. Dann nach Südwesten hinab zu {area:442}.",

	-- Step 14: Auberdine
	-- {npc:3693} Terenthis · {npc:3649} Thundris Windweaver
	["{npc:3693}: for {npc:3649}, at the north end of the village"] = "{npc:3693}: für {npc:3649}, am Nordende des Dorfes",
	-- {npc:6301} Gorbold Steelhand · {zone:1439} Darkshore
	["{npc:6301}, on the way north: the bay wrecks, on your next {zone:1439} visit"] = "{npc:6301}, auf dem Weg nach Norden: die Wracks in der Bucht, bei deinem nächsten Besuch in {zone:1439}",

	-- Step 15: Auberdine
	-- {npc:3701} Tharnariun Treetender
	["{npc:3701}: the bears are on the loop ahead"] = "{npc:3701}: die Bären sind auf der voraus liegenden Runde",
	-- {npc:3649} Thundris Windweaver · {area:445} Cliffspring Falls
	["{npc:3649}: his sample comes from the {area:445}, at the end of the next loop"] = "{npc:3649}: Seine Probe stammt aus dem {area:445}, am Ende des nächsten Loops",
	["Fill the tube at the moonwell in the village"] = "Fülle die Phiole am Mondbrunnen im Dorf",

	-- Step 16: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw · {npc:3667} Anaya Dawnrunner · {area:447} Ameth'Aran · {zone:1439} Darkshore
	["{npc:3644} waits where the pier meets the shore. {npc:3667} (16), whose pendant he wants, walks {area:447} on the loop ahead: from level 14.5 you take it there, else on your next {zone:1439} visit."] = "{npc:3644} wartet, wo der Kai auf das Ufer trifft. {npc:3667} (16), deren Anhänger er möchte, läuft durch {area:447} auf der Schleife danach: ab Stufe 14.5 nimmst du es dort an, sonst bei deinem nächsten {zone:1439}-Besuch.",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, auf dem Steg",

	-- Step 17: Rabid Thistle Bear on the way
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164} on the way"] = "{npc:2164} auf dem Weg",

	-- Step 18: Moonstalkers on the way
	["Moonstalkers on the way"] = "Moonstalkers auf dem Weg",
	-- {area:442} Auberdine · {area:456} Cliffspring River
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The Moonstalkers (14-15) roam the hills of the loop ahead, south of {area:442} and around the {area:456} at its end: any of them drops the fangs. Leave the Moonstalker Sires (17-18) and Matriarchs (19-20) south of the Grove."] = "Die Mondpirscher (14-15) streifen durch die Hügel der folgenden Schleife, südlich von {area:442} und um den {area:456} an deren Ende: alle lassen die Fangzähne fallen. Lass die Mondpirscher-Väter (17-18) und -Matriarchinnen (19-20) südlich des Hains in Ruhe.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Mondpirscher-Fangzähne",

	-- Step 19: Blackwood furbolgs
	["Blackwood furbolgs"] = "Furbolgs der Schwarzfelle",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder · Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}; Rabid Thistle Bears roam the hills around it.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "Pfadfinder der Schwarzfelle und Windtalkers halten das Lager südöstlich von {area:442}; Tollwütige Distelbären streifen durch die Hügel ringsum.\nVorsicht: Die Windtalkers (13-14) wirken aus der Ferne und die Furbolgs stehen paarweise: Ziehe sie einzeln.",

	-- Step 20: The southern beaches
	["The southern beaches"] = "Die südlichen Strände",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Folge der Küste nach Süden an {area:447} vorbei: Eine {quest:4728} liegt am Ufer westlich des Hains, eine weitere weiter südlich nahe {area:450}. Drei weitere Überreste liegen weiter südwestlich zwischen Orakeln und Gezeitenjägern der Grauflossen (18-20): Der Guide hebt sie für die letzte Runde auf, wenn du näher an ihrer Stufe bist.",

	-- Step 21: Onu
	-- {quest:952} Grove of the Ancients · {npc:3616} Onu · {npc:11218} Kerlonian Evershade
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["From the beached creature, head east to the {quest:952}. Watch for level 16 bears and level 17 Moonstalker Sires between the beach and the grove; go around them. {npc:3616} stands beside Arbal and the sleeping {npc:11218}."] = "Von der gestrandeten Kreatur aus geh nach Osten zum {quest:952}. Achte zwischen dem Strand und dem Hain auf Bären der Stufe 16 und Mondpirscherpatriarchen der Stufe 17; geh um sie herum. {npc:3616} steht neben Arbal und dem schlafenden {npc:11218}.",

	-- Step 22: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "Zurück nach Norden nach {area:447}: Die Flamme brennt im Süden der Ruinen.",

	-- Step 23: Anaya's Pendant
	-- {npc:3667} Anaya Dawnrunner · {npc:2184} Lady Moongazer
	["Careful: {npc:3667} (16) is over you: pull her on her own at full health. {npc:2184}, a rare (17), also walks the ruins: leave her be."] = "Vorsicht: {npc:3667} (16) ist dir überlegen: zieh sie alleine bei voller Gesundheit. {npc:2184}, ein seltener Mob (17), läuft ebenfalls durch die Ruinen: lass sie in Ruhe.",
	-- {item:5382} Anaya's Pendant · {npc:3667} Anaya Dawnrunner
	["{item:5382}: {npc:3667}'s ghost walks the ruins"] = "{item:5382}: {npc:3667}s Geist spukt in den Ruinen",

	-- Step 24: The red crystal
	["Back north-east into the mountains to the crystal."] = "Zurück nach Nordosten in die Berge zum Kristall.",

	-- Step 26: Bashal'Aran
	-- {npc:3650} Asterion · {area:456} Cliffspring River
	["North along the hills to {npc:3650}, then on north-east to the {area:456}."] = "Nach Norden entlang der Hügel bis {npc:3650}, dann weiter nach Nordosten zum {area:456}.",

	-- Step 27: Cliffspring Falls
	-- {area:456} Cliffspring River · {npc:6788} Den Mother
	-- plural, as words: Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["North-east up the {area:456} to the falls: fill the sampler at the water there. Moonstalkers (14-15) roam the hills around the river.\nCareful: Encrusted Tide Crawlers (17-20) line the shore below the falls and the {npc:6788}'s bears (18-19) lair in the hills south of them: keep to the river."] = "Nach Nordosten den {area:456} hinauf zu den Wasserfällen: Fülle den Probensammler an dem Wasser dort. Moonstalkers (14-15) streifen durch die Hügel um den Fluss.\nVorsicht: Verkrustete Gezeitenkriecher (17-20) säumen das Ufer unterhalb der Fälle und die Bären von {npc:6788} (18-19) hausen in den Hügeln südlich davon: Bleibe am Fluss.",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, am Wasserfall",

	-- Step 28: Buzzbox 323
	-- {quest:1002} Buzzbox 323 · {object:17185} Buzzbox 525 · {zone:1439} Darkshore
	["{quest:1002} stands on the hill above the falls. He offers {object:17185} next: its bears are far south, for your next {zone:1439} visit."] = "{quest:1002} steht auf dem Hügel über dem Wasserfall. Er bietet als Nächstes {object:17185} an: Dessen Bären sind weit im Süden, für deinen nächsten Besuch im {zone:1439}.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs: the Moonstalkers around the river"] = "Mondpirscher-Fangzähne: die Mondpirscher um den Fluss",

	-- Step 29: Beached Sea Turtle
	-- {quest:4725} Beached Sea Turtle · {quest:954} Bashal'Aran · {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Greymist Warriors = {npc:2205} Greymist Warrior
	["West along the north shore: the {quest:4725} lies on the beach north of {quest:954}, among Reef Crawlers and Greymist Warriors (15). Then south-west down to {area:442}."] = "Westlich entlang der Nordküste: Die {quest:4725} liegt am Strand nördlich von {quest:954}, zwischen Riffkriechern und Krieger der Grauflossen (15). Dann nach Südwesten hinab bis {area:442}.",

	-- Step 30: Auberdine
	-- {npc:3657} Sentinel Elissa Starbreeze · {npc:3693} Terenthis · {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3657}, beside {npc:3693}: for Balthule at the {area:444}, on your next {zone:1439} visit"] = "{npc:3657}, neben {npc:3693}: für Balthule am {area:444}, bei deinem nächsten Besuch in {zone:1439}",
	-- {npc:3701} Tharnariun Treetender · {npc:6788} Den Mother · {zone:1439} Darkshore
	["{npc:3701}: the {npc:6788}, on your next {zone:1439} visit"] = "{npc:3701}: der {npc:6788}, bei deinem nächsten Besuch in {zone:1439}",
	-- {npc:3583} Barithras Moonshade · {area:445} Cliffspring Falls · {zone:1439} Darkshore
	["{npc:3583}: the cave by the {area:445}, on your next {zone:1439} visit"] = "{npc:3583}: Die Höhle am {area:445}, bei deinem nächsten Besuch im {zone:1439}",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}, on the walk from the boat"] = "{npc:3649}: für {npc:1646} in {zone:1453}, auf dem Spaziergang vom Boot",

	-- Step 31: Elisa Steelhand
	["talk to the trainer"] = "sprich mit dem Lehrer",

	-- Step 32: Kurdram Stonehammer
	-- {npc:6297} Kurdram Stonehammer · {npc:6300} Elisa Steelhand · {quest:97948} Camping 101: Mining
	["{npc:6297}, beside {npc:6300}: {quest:97948}"] = "{npc:6297}, neben {npc:6300}: {quest:97948}",

	-- Step 33: Jenna Lemkenilli
	-- {npc:11037} Jenna Lemkenilli · {npc:6300} Elisa Steelhand · {quest:97941} Camping 101: Engineering
	["{npc:11037}, beside {npc:6300}: {quest:97941}"] = "{npc:11037}, neben {npc:6300}: {quest:97941}",

	-- Step 34: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {quest:4763} The Blackwood Corrupted · {zone:1439} Darkshore
	["From level 15 {npc:3649} also has {quest:4763}: its samples come from the northern Blackwood camp on your next {zone:1439} visit. Fill its bowl at the moonwell in the middle of the village now."] = "Ab Stufe 15 hat {npc:3649} auch {quest:4763}: Die Proben stammen aus dem nördlichen Blackwood-Lager bei deinem nächsten Besuch in {zone:1439}. Fülle seine Schale jetzt am Mondbrunnen in der Mitte des Dorfes.",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "{item:12347}: Fülle die {item:12346} an der {object:174795}",

	-- Step 35: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644} waits where the pier meets the shore, on the way to the boat."] = "{npc:3644} wartet dort, wo der Steg ans Ufer trifft, auf dem Weg zum Boot.",

	-- Step 36: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Boot nach {area:17203}",

	-- Step 37: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "Vom Boot runter steht {npc:268511} am Hafen: Seine Lieferung geht an {npc:483}s Käseladen im {object:2096}, neben dem Flugmeister.",

	-- Step 38: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}, in ihrem Käseladen",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "Die Treppe in ihrem Laden hinauf: Lass die Lieferung bei {object:460004}",

	-- Step 39: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way. His reply to {npc:3649} goes back to {area:442} with you."] = "{npc:1646} steht in {object:2098}, westlich von {object:2096}: Sein Kompass ist in seinem alten Haus in {zone:1436}, auf dem Weg. Seine Antwort an {npc:3649} nimmt dich zurück nach {area:442}.",
	-- {npc:1646} Baros Alexston · {npc:3649} Thundris Windweaver
	["{npc:1646}: {npc:3649}'s letter"] = "{npc:1646}: {npc:3649}s Brief",
	-- {npc:1646} Baros Alexston · {quest:97926} Making Do · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["{npc:1646}: {quest:97926}, for {npc:3649} on your next {zone:1439} visit"] = "{npc:1646}: {quest:97926}, für {npc:3649} bei deinem nächsten {zone:1439}-Besuch",

	-- Step 40: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Wenn du schon hier bist: Lerne {spell:202} bei {npc:11867} ({object:2096}, 10 Silber); Zweihandwaffen leveln einen Krieger am schnellsten.",

	-- Step 41: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Wenn du schon hier bist: Lerne Schwerter bei {npc:11867} ({object:2096}, 10 Silber); ein Schwert in der Haupthand levelt einen Schurken zuverlässig.",

	-- Step 42: Druid trainer
	["Druid trainer"] = "Druidenlehrer",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} in {zone:1453}; {area:87} hat keinen Druidenlehrer",

	-- Step 44: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 45: Shaman trainer
	["Shaman trainer"] = "Schamanenlehrer",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} in {zone:1426}; {area:87} hat keinen Schamanenlehrer",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Pfadfinder und Windsprecher der Schwarzfelle halten das Lager südöstlich von {area:442}.",
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "Pfadfinder und Windsprecher der Schwarzfelle halten das Lager südöstlich von {area:442}.\nVorsicht: Die Windsprecher (13-14) wirken aus der Ferne und die Furbolgs stehen paarweise: Zieh sie einzeln.",
	-- ["Into {area:148}"] = "Nach {area:148}",
	-- ["North along the hills to {npc:3650}, then west down to {area:442}."] = "Nördlich an den Hügeln entlang zu {npc:3650}, dann westlich hinunter nach {area:442}.",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Nördlich an den Hügeln entlang. {npc:3650} wartet in den Ruinen von {quest:954}; Wild Grells und Vile Sprites bevölkern sie, Deth'ryll Satyrs den Ostrand. {object:17183} steht an der Straße westlich der Ruinen; ein {quest:4723} liegt auf dem Weg zu ihm am Ufer.",
	-- ["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Rabid Thistle Bears streifen durch die Hügel südlich von {area:442}: Benutze {item:7586} an einem, um ihn einzufangen. Geh dann zum Furbolg-Lager direkt östlich von ihnen: Noch ist nichts zu töten.",
	-- ["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Das Boot legt westlich des Dorfes an. Der Flugmeister steht auf dem Hügel südlich des Gasthauses; die Questgeber sind entlang der Hauptstraße verteilt.",
	-- ["{item:5382}: {npc:3667}, level 16; pull her away from the Highborne"] = "{item:5382}: {npc:3667}, Stufe 16; zieh sie von den Hochgeborenen weg",
	-- ["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646} steht in {object:2098}, westlich von {object:2096}: Sein Kompass liegt in seinem alten Haus in {zone:1436}, auf dem Weg.",
	-- ["{npc:3644}, on the pier"] = "{npc:3644}, auf dem Steg",
	-- ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}, wo der Steg auf das Ufer trifft, auf dem Weg zum Boot",
}
