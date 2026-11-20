-- German (deDE): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Nach {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} steht direkt am Ausgang des Tunnels von {area:1769} nach {zone:1452}, wo du herauskommst.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "Reite südlich vom Tunnel: {npc:9298} lagert zwischen den dampfenden Becken von {area:2246}, im Westen des Tals.",
	["Linken's letter"] = "Linkens Brief",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} kommt von {npc:7775} in {zone:1444}, später in diesem Guide.",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: Töte sie, wenn du ihnen begegnest",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Pfadfinder, Höhlenbehüter und Totemiker teilen sich die Furbolglager um die heißen Quellen; Struppige Eulenbestien streifen über die Hänge dazwischen. Töte zuerst die Totemiker. Heb jeden {item:14047}, den du plünderst, für Meilosh auf.\nVorsicht: Die Höhlenbehüter sind bis Stufe 56: Zieh sie einzeln und halte dich von den Totems der Lager fern."
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems.\nIf you are 54, take the level 55 Den Watchers and leave the 56s."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}: Etwa jeder zehnte Winterquell-Furbolg trägt einen; töte sie weiter, bis einer fallen gelassen wird",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, eine seltene Beute der Winterfell-Furbolgs",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} wird bei {object:176091} im {zone:1448} abgegeben, auf einer späteren Reise.",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Tobende Eulenbestien",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Tobende Eulenbestien streifen durch die Hügel nördlich von {area:2251}, an der Straße zwischen {area:2246} und {area:2255}. Vorsicht: Die größten sind Stufe 56: Zieh sie einzeln."
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time.\nAt 54, take owlbeasts no higher than 55."] = "",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} ist die Goblin-Stadt auf der Ostseite des Tals, hinter den Hügeln der Owlbeasts.",
	["Gregor's quests lead to other zones: keep them."] = "Gregors Quests führen in andere Gebiete: Behalte sie.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, drinnen",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "Eisdistelyetis",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	-- was: ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Die Yetihügel beginnen gleich südöstlich von {area:2255}. Jeder Yeti lässt Fell fallen: Kümmere dich um die Eisdistelyetis (55-56) und lass die Matriarchinnen und Patriarchen (56-58) in Ruhe; ihre Hörner holst du bei einem späteren Besuch."
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit.\nAt 54, take level 55 Ice Thistle Yetis; leave the 56s and the larger Matriarchs and Patriarchs."] = "",

	-- Step 10: Chillwind chimaeras
	["Chillwind chimaeras"] = "Eiswindschimären",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	-- plural, as words: Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite.\nAt 54, take the Fledgling Chillwinds (53-55). They carry the same horns; leave the larger chimaeras alone."] = "",

	-- Step 11: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi: behalten, die Makellosen Yetihörner kommen beim Halt in {area:2255} im Guide für {zone:1423} mit etwa 57",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "Die Matriarchinnen und Patriarchen mit Umis Hörnern sind Stufe 56-58: Heb sie dir für diesen späteren Halt auf.",

	-- Step 12: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Flugmeister in {area:2255}",

	-- Step 14: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "Die {item:11242} wächst in einem zerfallenen Gebäude nördlich von {npc:7775}s Lager, östlich von {area:1114} der Harpyien: Kletter durch das zerbrochene Stück der Wand hinein.",

	-- Step 15: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "Zurück nach Süden zu {npc:7775}. Behalte das Elixier und trink es noch nicht: Es tötet dich, und so triffst du später Gaeriyan bei {area:976}.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, die Belohnung von {npc:7775}",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Flugmeister: {area:2408}",

	-- Step 18: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881} und {npc:14728} stehen auf {area:1641}. Jede von Rumstags Spenden nimmt sechzig Wolle, Seide oder Magiestoff aus deinen Taschen: Gib ab, was du dabeihast, den Rest überspringe.",

	-- Step 19: Elder Rise
	-- {area:1237} Valormok
	["Take the payment to Jediga on the next {area:1237} stop"] = "",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} auf der {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} wartet in {zone:1450}: Behalte sie für später.",

	-- Step 20: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087} kauft {item:11040}, das aus deinem {quest:3761} gewachsen ist. {quest:3782} will zehn, und {item:11020} gibt alle zehn Minuten einen Versuch: Nimm es nur mit, wenn du das Getreide schon hast.",

	-- Step 22: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 23: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "Im {object:172961}. Jede Spende nimmt sechzig Wolle, Seide oder Magiestoff aus deinen Taschen: Gib ab, was du dabeihast, den Rest überspringe.",

	-- Step 24: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Im {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "Beide Spenden von {item:14047} gibst du später auf der Route ab: Spar dir sechzig {item:14047} für jede, wenn du sie willst.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Jeder Furbolg der Winterfelle kann die Perlen tragen; die Lager gleich südlich von {npc:11556} sind am nächsten.",
	-- ["Back at {area:1099}."] = "Zurück im {area:1099}.",
	-- ["Back to {area:2255}"] = "Zurück nach {area:2255}",
	-- ["Below ground"] = "Unter der Erde",
	-- ["Chillwind chimaeras"] = "Eiswindschimären",
	-- ["From Krakle in Un'Goro"] = "Von Krakle in Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Lager der Winterfelle an den Frostfeuerquellen",
	-- ["Frostfire Winterfall camps"] = "Lager der Winterfelle an den Frostfeuerquellen",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "Gregors und Harlos Quests führen in andere Gebiete: Behalte sie.",
	-- ["Grind to 55"] = "Bis 55 grinden",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Er steht auf der {area:1641}. Jede Spende will Stoff aus deinen Taschen; gib sie ab, wenn du ihn hast, später auf der Route.",
	-- ["In the {object:172961}."] = "Im {object:172961}.",
	-- ["Level 55.04"] = "Stufe 55,04",
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
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Hol hier Stufe 55,04 auf, bevor du die Quests bei {area:2255} abgibst: Sie bringen dich auf Stufe 56. Die Eisdistelyetis (55-56) sind hier die niedrigsten; die Matriarchinnen und Patriarchen (56-58) schlagen härter zu. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1584} oder den Dungeon {area:1583} (Untere).",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "Umis dritter Streich gilt Goblins in {area:976} und Un'Goro: Behalte ihn für später.",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "grinde {npc:7440} in {area:2244}, {zone:1452}",
	-- ["grind on {npc:7458}"] = "grinde {npc:7458}",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} ist die Goblinstadt auf der Ostseite des Tals.",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, eine seltene Beute der Winterfell-Furbolgs",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, neben ihm",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} steht am Ausgang des Tunnels der {area:1769} nach {zone:1452}, nördlich der heißen Quellen.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "{npc:7775}, ein Zwerg, lagert in {area:1137} nordwestlich vom {area:1099}. Er braut das {item:11243} nur aus einer {item:11242}, die du ihm bringst.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, ein Zwerg, lagert in {area:1137} nordwestlich vom {area:1099}; er hat das Elixier.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} kauft {item:11040}, das aus deiner {quest:3761} gewachsen ist.",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} lagert zwischen den dampfenden Becken von {area:2246}, im Westen des Tals.",
}
