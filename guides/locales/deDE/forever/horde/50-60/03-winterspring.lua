-- German (deDE): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} ist die Goblinstadt auf der Ostseite des Tals.",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "Gregors und Harlos Quests führen in andere Gebiete: Behalte sie.",

	-- Step 2: Ice Thistle yetis
	["Ice Thistle yetis"] = "Eisdistelyetis",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Die Yetihügel beginnen gleich südöstlich von {area:2255}. Jeder Yeti lässt Fell fallen; nur Matriarchinnen und Patriarchen lassen Hörner fallen, also heb die für nach der Abgabe auf.",

	-- Step 4: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Makellose Yetihörner",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Matriarchinnen und Patriarchen schlagen hart zu: Zieh sie einzeln.",

	-- Step 5: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "Umis dritter Streich gilt Goblins in {area:976} und Un'Goro: Behalte ihn für später.",

	-- Step 6: Chillwind chimaeras
	["Chillwind chimaeras"] = "Eiswindschimären",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Die Schimären streifen über die Schneefelder südlich und westlich von {area:2255}. Halte dich von der Höhle von {area:2245} fern: Ihre blauen Drachkin sind Elite.",

	-- Step 8: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Tobende Eulenbestien",
	-- {area:2251} Lake Kel'Theril
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Reite auf der Straße nach Westen am {area:2251} vorbei; Tobende Eulenbestien streifen durch die Hügel nördlich davon.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} lagert zwischen den dampfenden Becken von {area:2246}, im Westen des Tals.",
	["From Krakle in Un'Goro"] = "Von Krakle in Un'Goro",
	["Linken's letter"] = "Linkens Brief",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} kommt von {npc:7775} in {zone:1444}, später in diesem Guide.",

	-- Step 10: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} steht am Ausgang des Tunnels der {area:1769} nach {zone:1452}, nördlich der heißen Quellen.",

	-- Step 11: Frostfire Winterfall camps
	["Frostfire Winterfall camps"] = "Lager der Winterfelle an den Frostfeuerquellen",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Pfadfinder, Höhlenbehüter und Totemiker teilen sich die Furbolglager um die heißen Quellen; Struppige Eulenbestien streifen über die Hänge dazwischen. Töte zuerst die Totemiker. Heb jeden {item:14047}, den du plünderst, für Meilosh auf.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, eine seltene Beute der Winterfell-Furbolgs",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, eine seltene Beute der Winterfell-Furbolgs",

	-- Step 12: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} wird bei {object:176091} im {zone:1448} abgegeben, auf einer späteren Reise.",

	-- Step 13: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Reite nach Osten, dann nach Süden die {area:2249} hinunter. Die Frosthagelriesen dort sind Elite der Stufe 59: Halte dich in der Mitte und bleib in Bewegung. Die seltsame Quelle ist am Eingang von {area:2256}, am Südende.",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Das Furbolgdorf füllt das Tal nordöstlich von {area:2255}. Töte zuerst die Schamanen; sie heilen. {npc:10738} in der Höhle hinten ist Elite: Bleib draußen.",

	-- Step 15: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "Reite zurück nach Westen zu {area:2246}.",

	-- Step 17: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Jeder Furbolg der Winterfelle kann die Perlen tragen; die Lager gleich südlich von {npc:11556} sind am nächsten.",
	["Frostfire Winterfall camp"] = "Lager der Winterfelle an den Frostfeuerquellen",

	-- Step 19: Back to Everlook
	-- {area:2255} Everlook
	["Back to {area:2255}"] = "Zurück nach {area:2255}",

	-- Step 20: Grind to 55
	["Grind to 55"] = "Bis 55 grinden",
	-- {npc:7440} Winterfall Den Watcher · {area:2244} Winterfall Village · {zone:1452} Winterspring
	["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "grinde {npc:7440} in {area:2244}, {zone:1452}",

	-- Step 21: A Little Luck
	-- {npc:10307} Witch Doctor Mau'ari
	["{npc:10307}, beside him"] = "{npc:10307}, neben ihm",

	-- Step 22: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Flieg zum {area:1099}",

	-- Step 23: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, ein Zwerg, lagert in {area:1137} nordwestlich vom {area:1099}; er hat das Elixier.",

	-- Step 24: Talo Thornhoof
	-- {area:1099} Camp Mojache
	["Back at {area:1099}."] = "Zurück im {area:1099}.",

	-- Step 25: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",

	-- Step 26: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Er steht auf der {area:1641}. Jede Spende will Stoff aus deinen Taschen; gib sie ab, wenn du ihn hast, später auf der Route.",

	-- Step 28: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} auf der {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} wartet in {zone:1450}: Behalte sie für später.",

	-- Step 29: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil
	["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} kauft {item:11040}, das aus deiner {quest:3761} gewachsen ist.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Flieg nach {area:1637}",

	-- Step 31: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "Im {object:172961}.",

	-- Step 32: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Im {object:172958}.",
}
