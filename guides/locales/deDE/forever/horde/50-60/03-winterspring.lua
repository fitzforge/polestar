-- German (deDE): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1452} Winterspring · {zone:1448} Felwood · {zone:1444} Feralas · {zone:1456} Thunder Bluff
	["{zone:1452} and {zone:1448}, then {zone:1444} and {zone:1456}."] = "{zone:1452} und {zone:1448}, dann {zone:1444} und {zone:1456}.",

	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Nach {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} steht direkt am Ausgang des Tunnels von {area:1769} nach {zone:1452}, wo du herauskommst.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "Reite südlich vom Tunnel: {npc:9298} lagert zwischen den dampfenden Becken von {area:2246}, im Westen des Tals.",
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "{quest:980}, von Krakle in Un'Goro",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "{quest:3909} kommt von {npc:7775} in {zone:1444}, später in diesem Guide. {npc:9298}s nächster Auftrag, Strange Sources, liegt an der Mündung von {area:2256} unter Elites der Stufen 59-60: Er wartet auf die {zone:1452}-Runde des letzten Guides.",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "Fahre Östen entlang der Straße vorbei an {area:2251} nach {area:2255}: die Ohren und Chimaera-Aufträge bringen dir etwa ein Viertel Level, was die Frostfire-Fuchskolben-Läger wollen; {npc:9298}'s Lager kommt auf der Rückfahrt nach Westen.",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} ist die Goblin-Stadt auf der Ostseite des Tals, hinter den Hügeln der Owlbeasts.",
	["Gregor's quests lead to other zones: keep them."] = "Gregors Quests führen in andere Gebiete: Behalte sie.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, drinnen",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "Eisdistelyetis",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Die Yeti-Hügel liegen direkt südöstlich von {area:2255}. Jeder Yeti lässt Pelz fallen. Vorsicht: die Eis-Tistel-Yetis sind Level 55-56: nimm die 55er eine nach der anderen, und lasse die Matriarchin und Patriarch (56-58), deren Hörner auf einem späteren Besuch kommen.",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "Eiswindschimären",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Die Chimaeras patrouillieren die Schneefelder südlich und westlich von {area:2255}. Vorsicht: Chillwind-Chimären sind Level 55-57: nimm nur die 55er sowie die Jungtiere (53-55) bei {area:2251}, die die Hörner ebenfalls tragen. Bleib von der Höhle von {area:2245} fern: deren Blaudrachen sind Elite.",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "Umi: behalte es, die ursprünglichen Yeti-Hörner kommen im {zone:1423}-Guide am {area:2255}-Stop bei ca. 56",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "Die Matriarchinnen und Patriarchen mit Umis Hörnern sind Stufe 56-58: Heb sie dir für diesen späteren Halt auf.",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Tobende Eulenbestien",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "Fahre Westen zurück: Raging-Eulwölfe patrouillieren die Hügel nördlich von {area:2251}, an der Straße zwischen {area:2255} und {area:2246}. Vorsicht: Die Grössten sind Level 56: jagde sie eine nach der anderen.",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: Töte sie, wenn du ihnen begegnest",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "Pfadfinder, Höhlenbehüter und Totemiker teilen sich die Furbolglager um die heißen Quellen; Struppige Eulenbestien streifen über die Hänge dazwischen. Töte zuerst die Totemiker. Heb jeden {item:14047}, den du plünderst, für Meilosh auf.\nVorsicht: Die Höhlenbehüter sind 55-56: Zieh die 55er, einen nach dem anderen, und halte dich von den Totems der Lager fern.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}: Etwa jeder zehnte Winterquell-Furbolg trägt einen; töte sie weiter, bis einer fallen gelassen wird",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, eine seltene Beute der Winterfell-Furbolgs",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} wird bei {object:176091} im {zone:1448} abgegeben, auf einer späteren Reise.",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Flieg nach {area:431}",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "Die südlichen Hand-ins von {zone:1448} folgen: fahre ostwärts zum Flugmeister von {area:2255}, fliege zu {area:431} (über {area:1237}) und fahr nordwärts in {zone:1448}, damit der Wald einmal von Süden nach Norden geritten wird.",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Flugmeister in {area:2255}",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "Fahre nordwestlich entlang der Straße in {zone:1448}. Ror steht am weitesten südlichen Ende von {area:1761}, direkt an der Grenze.",

	-- Step 14: Taronn Redfeather
	["North to the druids' camp."] = "Nördlich zum Druidentorps",

	-- Step 16: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, auf der Westseite des Refugiums",

	-- Step 18: Emerald Sanctuary
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "Behalte {quest:5158}: {npc:5901} ist bei {area:392}, im nächsten Guide.",

	-- Step 19: The Jadefire moonwell
	["The Jadefire moonwell"] = "Der Mondbrunnen der Jadefeuersatyrn",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Fahre nordwestlich vorbei an {area:1763} zum korrupten Mondbrunnen der Jadefire-Satyren und fülle {npc:9996}'s Schüssel dort.",

	-- Step 20: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "Nördlich die Straße zu {area:1997}.",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "{npc:10306}'s Mondbestrahlte Eulenbestien sind 57-58, in {zone:1452}: behalte es für den {zone:1452}-Stopp des {zone:1423}-Guides.",

	-- Step 21: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}s Kätzchen",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Nimm die Kätzchen zurück zum Jadefire-Mondbrunnen und setze es dort mit {item:12565} frei; sobald es sich zu einem {npc:10042} verwandelt hat, bring es zurück zu {npc:9996} und klicke darauf, um es abzuliefern.",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, am Mondbrunnen der Jadefeuersatyrn",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["Bring the {npc:10042} to {npc:9996} at {area:1997} and click on it to hand it over."] = "Bringe das {npc:10042} zu {npc:9996} in {area:1997} und klicke darauf, um es abzuliefern.",

	-- Step 23: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "{area:1997}-Flugmeister",

	-- Step 25: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "Die {item:11242} wächst in einem verfallenen Gebäude nördlich des Lagers von {npc:7775}, östlich der {area:1114} der Harpyien: Klettere durch die eingebrochene Stelle der Wand.\nOder durch die Vordertür: {npc:9467} bewacht sie, und der Köder, den Gregan verkauft, lockt ihn weg, wenn du ihn neben ihm benutzt. Die Hälfte der Spieler in unseren Aufzeichnungen ging so, die andere Hälfte durch die Wand.",

	-- Step 26: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "Zurück nach Süden zu {npc:7775}. Behalte das Elixier und trink es noch nicht: Es tötet dich, und so triffst du später Gaeriyan bei {area:976}.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, die Belohnung von {npc:7775}",

	-- Step 28: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Flugmeister: {area:2408}",

	-- Step 29: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on the central rise, not on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881} und {npc:14728} stehen auf der zentralen Anhöhe, nicht auf {area:1641}. Jede von Rumstags Spenden nimmt sechzig Wolle, Seide oder Magiestoff aus deinen Taschen: Gib ab, was du dabeihast, den Rest überspringe.",

	-- Step 30: Ghede
	-- {npc:9076} Ghede · {area:1639} Elder Rise
	["{npc:9076} stands on {area:1639}."] = "{npc:9076} steht auf {area:1639}.",

	-- Step 31: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} auf der {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} wartet in {zone:1450}: Behalte sie für später.",

	-- Step 32: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11103} Seed Voucher · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Hand {npc:9087} the {item:11103} for her packets of Tharlendris Seeds. {quest:3782} gives you the {item:11020}: use it with a seed packet and two {quest:3761} in your bags to grow a random herb, sometimes {item:11040}, once every ten minutes. She wants ten, so the quest is optional: take it if you have spare {quest:3761} and want to keep growing it over the next guides."] = "Gib {npc:9087} den {item:11103} für ihre Päckchen mit Tharlendris-Samen. {quest:3782} gibt dir den {item:11020}: Benutze ihn mit einem Samenpäckchen und zwei {quest:3761} in deinen Taschen, um alle zehn Minuten ein zufälliges Kraut zu ziehen, manchmal {item:11040}. Sie will zehn, die Quest ist also optional: Nimm sie, wenn du {quest:3761} übrig hast und in den nächsten Guides weiterziehen willst.",

	-- Step 34: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "{npc:4046} steht auf {area:1639}.",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "Überlassung an {npc:4046}, von Jediga in {zone:1447}",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "{npc:4046}'s Bezahlung geht zurück an Jediga in {zone:1447}, die Route passiert es nicht wieder: lass es.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Jeder Furbolg der Winterfelle kann die Perlen tragen; die Lager gleich südlich von {npc:11556} sind am nächsten.",
	-- ["Back at {area:1099}."] = "Zurück im {area:1099}.",
	-- ["Back to {area:2255}"] = "Zurück nach {area:2255}",
	-- ["Below ground"] = "Unter der Erde",
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Beide Spenden von {item:14047} gibst du später auf der Route ab: Spar dir sechzig {item:14047} für jede, wenn du sie willst.",
	-- ["Chillwind chimaeras"] = "Eiswindschimären",
	-- ["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- ["From Krakle in Un'Goro"] = "Von Krakle in Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Lager der Winterfelle an den Frostfeuerquellen",
	-- ["Frostfire Winterfall camps"] = "Lager der Winterfelle an den Frostfeuerquellen",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "Gregors und Harlos Quests führen in andere Gebiete: Behalte sie.",
	-- ["Grind to 55"] = "Bis 55 grinden",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Er steht auf der {area:1641}. Jede Spende will Stoff aus deinen Taschen; gib sie ab, wenn du ihn hast, später auf der Route.",
	-- ["In the {object:172958}."] = "Im {object:172958}.",
	-- ["In the {object:172961}."] = "Im {object:172961}.",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Im {object:172961}. Jede Spende nimmt sechzig Wolle, Seide oder Magiestoff aus deinen Taschen: Gib ab, was du dabeihast, den Rest überspringe.",
	-- ["Level 55.04"] = "Stufe 55,04",
	-- ["Linken's letter"] = "Linkens Brief",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Matriarchinnen und Patriarchen schlagen hart zu: Zieh sie einzeln.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Pfadfinder, Höhlenbehüter und Totemiker teilen sich die Furbolglager um die heißen Quellen; Struppige Eulenbestien streifen über die Hänge dazwischen. Töte zuerst die Totemiker. Heb jeden {item:14047}, den du plünderst, für Meilosh auf.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Pfadfinder, Höhlenbehüter und Totemiker teilen sich die Furbolglager um die heißen Quellen; Struppige Eulenbestien streifen über die Hänge dazwischen. Töte zuerst die Totemiker. Heb jeden {item:14047}, den du plünderst, für Meilosh auf.\nVorsicht: Die Höhlenbehüter sind bis Stufe 56: Zieh sie einzeln und halte dich von den Totems der Lager fern.",
	-- ["Pristine Yeti Horns"] = "Makellose Yetihörner",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "Raging Owlbeasts streifen durch die Hügel nördlich von {area:2251}, an der Straße zwischen {area:2246} und {area:2255}.",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Tobende Eulenbestien streifen durch die Hügel nördlich von {area:2251}, an der Straße zwischen {area:2246} und {area:2255}. Vorsicht: Die größten sind Stufe 56: Zieh sie einzeln.",
	-- ["Ride back west to {area:2246}."] = "Reite zurück nach Westen zu {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Reite nach Osten, dann nach Süden die {area:2249} hinunter. Die Frosthagelriesen dort sind Elite der Stufe 59: Halte dich in der Mitte und bleib in Bewegung. Die seltsame Quelle ist am Eingang von {area:2256}, am Südende.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Reite auf der Straße nach Westen am {area:2251} vorbei; Tobende Eulenbestien streifen durch die Hügel nördlich davon.",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Die Schimären streifen über die Schneefelder südlich und westlich von {area:2255}. Halte dich von der Höhle von {area:2245} fern: Ihre blauen Drachkin sind Elite.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Das Furbolgdorf füllt das Tal nordöstlich von {area:2255}. Töte zuerst die Schamanen; sie heilen. {npc:10738} in der Höhle hinten ist Elite: Bleib draußen.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Die Yetihügel beginnen gleich südöstlich von {area:2255}. Jeder Yeti lässt Fell fallen: Kümmere dich um die Eisdistelyetis (55-56) und lass die Matriarchinnen und Patriarchen (56-58) in Ruhe; ihre Hörner holst du bei einem späteren Besuch.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Die Yetihügel beginnen gleich südöstlich von {area:2255}. Jeder Yeti lässt Fell fallen; nur Matriarchinnen und Patriarchen lassen Hörner fallen, also heb die für nach der Abgabe auf.",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "Die {item:11242} wächst in einem zerfallenen Gebäude nördlich von {npc:7775}s Lager, östlich von {area:1114} der Harpyien: Kletter durch das zerbrochene Stück der Wand hinein.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Hol hier Stufe 55,04 auf, bevor du die Quests bei {area:2255} abgibst: Sie bringen dich auf Stufe 56. Die Eisdistelyetis (55-56) sind hier die niedrigsten; die Matriarchinnen und Patriarchen (56-58) schlagen härter zu. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1584} oder den Dungeon {area:1583} (Untere).",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "Umis dritter Streich gilt Goblins in {area:976} und Un'Goro: Behalte ihn für später.",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi: behalten, die Makellosen Yetihörner kommen beim Halt in {area:2255} im Guide für {zone:1423} mit etwa 57",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "grinde {npc:7440} in {area:2244}, {zone:1452}",
	-- ["grind on {npc:7458}"] = "grinde {npc:7458}",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} ist die Goblinstadt auf der Ostseite des Tals.",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, eine seltene Beute der Winterfell-Furbolgs",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, neben ihm",
	-- ["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881} und {npc:14728} stehen auf {area:1641}. Jede von Rumstags Spenden nimmt sechzig Wolle, Seide oder Magiestoff aus deinen Taschen: Gib ab, was du dabeihast, den Rest überspringe.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} steht am Ausgang des Tunnels der {area:1769} nach {zone:1452}, nördlich der heißen Quellen.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "{npc:7775}, ein Zwerg, lagert in {area:1137} nordwestlich vom {area:1099}. Er braut das {item:11243} nur aus einer {item:11242}, die du ihm bringst.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, ein Zwerg, lagert in {area:1137} nordwestlich vom {area:1099}; er hat das Elixier.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} kauft {item:11040}, das aus deiner {quest:3761} gewachsen ist.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087} kauft {item:11040}, das aus deinem {quest:3761} gewachsen ist. {quest:3782} will zehn, und {item:11020} gibt alle zehn Minuten einen Versuch: Nimm es nur mit, wenn du das Getreide schon hast.",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} lagert zwischen den dampfenden Becken von {area:2246}, im Westen des Tals.",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} kommt von {npc:7775} in {zone:1444}, später in diesem Guide.",
	-- ["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",
}
