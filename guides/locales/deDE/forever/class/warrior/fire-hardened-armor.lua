-- German (deDE): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "Feuergehärtete Rüstung",
	["Starts now at 20 with a shield; a hauberk at 28, then a coif, leggings and gauntlets from three smiths."] = "Beginnt jetzt mit Stufe 20 mit einem Schild; ein Brustpanzer mit 28, dann eine Kettenhaube, Beinschienen und Handschuhe von drei Schmieden.",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:5479}, neben {npc:5480} im Gebäude der Kriegerlehrer von {object:2100}, zu {quest:1698} in Redridge.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:5113}, der Kriegerlehrer von {zone:1455}, zu {quest:1698} ins Rotkammgebirge.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:7315}, der Kriegerlehrer von {zone:1457}, zu {quest:1698} ins Rotkammgebirge.",

	-- Step 4: Yorus Barleybrew
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} sits in the inn at {area:69}. His test is timed: before you take it, clear the Redridge gnolls on the path to the {area:98} in the hills north-west of {area:69}, including the two on the rock by the cave mouth (climb it from its right side)."] = "{quest:1698} sitzt im Gasthaus von {area:69}. Seine Prüfung ist zeitlich begrenzt: Bevor du sie annimmst, räum die Gnolle von Redridge auf dem Weg zu {area:98} in den Hügeln nordwestlich von {area:69}, einschließlich der zwei auf dem Felsen am Höhleneingang (klettere von seiner rechten Seite hinauf).",

	-- Step 5: The Rethban Gauntlet
	-- {npc:6166} Yorus Barleybrew · {spell:8553} Barleybrew Scalder · {area:98} Rethban Caverns · {area:69} Lakeshire
	["You have one hour, and {npc:6166}'s {spell:8553} leaves you drunk for 8-10 minutes. Run north-west into the {area:98}, keeping close to the cliff wall to miss most gnoll packs, and go in as far as the first fork; then come back to {npc:6166} (from the ridge you can jump down into {area:69}). Dying and releasing your spirit fails the quest: abandon it and {npc:6166} gives it again."] = "Du hast eine Stunde, und {spell:8553} von {npc:6166} macht dich 8-10 Minuten betrunken. Lauf nordwestlich in {area:98} hinein, halte dich dicht an der Felswand, um die meisten Gnoll-Packs zu umgehen, und geh bis zur ersten Gabelung hinein; komm dann zurück zu {npc:6166} (vom Grat aus kannst du nach {area:69} hinunterspringen). Wenn du stirbst und deinen Geist freilässt, scheitert die Quest: Brich sie ab, und {npc:6166} gibt sie dir erneut.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "Betritt die {area:98} und komm zurück",

	-- Step 6: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {npc:6166} Yorus Barleybrew · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail · {item:6842} Furen's Instructions
	["{npc:5413} works in the Dwarven District of Stormwind. He takes the {item:6843} (lost it? abandon the quest and {npc:6166} gives a new one) and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest, with {item:6842} listing what it needs."] = "{npc:5413} arbeitet im Zwergenviertel von Sturmwind. Er nimmt {item:6843} (verloren? Brich die Quest ab, und {npc:6166} gibt dir ein neues) und gibt dir {item:6970}, einen Schild; {quest:1701} ist eine Quest der Stufe 28, {item:6842} führt auf, was sie braucht.",

	-- Step 7: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "Versengte Spinnenfangzähne",
	-- {zone:1437} Wetlands · {area:836} Dun Algaz
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["You need 50 fangs. The Leech Stalkers and Cave Stalkers (level 21-22) crawl in the middle of the {zone:1437}, north of {area:836}; every one drops a fang. They poison; back in 5 minutes."] = "Du brauchst 50 Fangzähne. Die Leech Stalkers und Cave Stalkers (Stufe 21-22) kriechen mitten in der {zone:1437}, nördlich von {area:836}; jeder lässt einen Fangzahn fallen. Sie vergiften; nach 5 Minuten wieder da.",

	-- Step 8: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "Verkohlte und Galvanisierte Hörner",
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch · {spell:3396} Corrosive Poison · {spell:403} Lightning Bolt · {area:467} Stonetalon Peak
	-- plural, as words: Charred Horns = {item:6839} Charred Horn · Young Chimaeras = {npc:4032} Young Chimaera
	["The chimaeras live south-west of {area:460} in the {area:465}: you need 12 Charred Horns from the Fledgling (level 25-27) and Young Chimaeras (23-25), four kills in five, and the {item:6840} from the {npc:6167} (28, the big one), also four in five. Only three Fledglings, two Young and one Matriarch live there, each back in 5 minutes, so expect to wait. Fledglings and the Matriarch spit {spell:3396}, the Young cast {spell:403}. Alliance: fly to {area:467} and head south."] = "Die Chimären leben südwestlich von {area:460} in {area:465}: Du brauchst 12 Charred Horns von den Fledgling Chimaeras (Stufe 25-27) und Young Chimaeras (23-25), bei vier von fünf Kills, und {item:6840} von {npc:6167} (28, die große), ebenfalls vier von fünf. Es leben dort nur drei Fledglings, zwei Young und eine Matriarch, jede nach 5 Minuten zurück, rechne also mit Warten. Fledglings und die Matriarch spucken {spell:3396}, die Young wirken {spell:403}. Allianz: Flieg nach {area:467} und geh nach Süden.",
	-- {item:6839} Charred Horn
	["{item:6839}, from the young chimaeras"] = "{item:6839}, von den jungen Chimären",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, von {npc:6167}",

	-- Step 9: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug im Gebiet {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, and his guards come with him. Inside take the left path at the first fork, cross the root bridge, go past the big empty cauldron: he is in a dead end on the right, with about ten elites on the way. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Roogug ist ein Elite-Stacheleber (Stufe 28) in {area:1717}, dem Dungeon am Südende des {zone:1413}; ein Dungeon für fünf Spieler: Du brauchst eine Gruppe aus fünf, und seine Wachen kommen mit ihm. Nimm drinnen an der ersten Gabelung den linken Weg, überquere die Wurzelbrücke, geh am großen leeren Kessel vorbei: Er steht in einer Sackgasse rechts, mit etwa zehn Elites auf dem Weg. Er wirkt {spell:403} und ruft Earth Rumblers. Das Fläschchen fällt immer.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, von Roogug",

	-- Step 10: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027} for the hauberk. He then sends you to the smith of your race; the other two smiths' pieces are open to you as well: talk to them directly."] = "Zurück zu {npc:5413} im {object:28027} für den Brustpanzer. Er schickt dich dann zum Schmied deines Volkes; auch die Teile der anderen zwei Schmiede stehen dir offen: Sprich sie direkt an.",

	-- Step 11: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {object:28027} Dwarven District · {npc:5413} Furen Longbeard · {quest:1705} Burning Blood · {item:6845} Burning Rock
	["{npc:1416} keeps the weapon shop in the north-west of the {object:28027}, a short walk from {npc:5413}. He wants 20 {quest:1705} and the {item:6845}."] = "{npc:1416} führt den Waffenladen im Nordwesten des {object:28027}, ein kurzer Weg von {npc:5413}. Er will 20 {quest:1705} und {item:6845}.",

	-- Step 12: Burning Blood
	-- {zone:1431} Duskwood · {area:42} Darkshire · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock · {area:2161} Roland's Doom · {spell:3427} Infected Wound
	["The Nightbane worgen of {zone:1431} (Dark Runners, Vile Fangs, Shadow Weavers, Worgen and Tainted Ones, level 26-31) south and west of {area:42} drop the {quest:1705} four kills in five. {npc:6170} (level 32, not elite) carries the {item:6845} (also four in five): he walks between the inside and the mouth of the {area:2161} mine south-east of {area:42}, so wait at the entrance and pull him outside. {npc:6170} and the Tainted Ones poison and howl; Vile Fangs cause {spell:3427}."] = "Die Nightbane-Worgen von {zone:1431} (Dark Runners, Vile Fangs, Shadow Weavers, Worgen und Tainted Ones, Stufe 26-31) südlich und westlich von {area:42} lassen {quest:1705} bei vier von fünf Kills fallen. {npc:6170} (Stufe 32, kein Elite) trägt {item:6845} (ebenfalls vier von fünf): Er läuft zwischen dem Inneren und dem Eingang der Mine {area:2161} südöstlich von {area:42} hin und her, warte also am Eingang und zieh ihn nach draußen. {npc:6170} und die Tainted Ones vergiften und heulen; Vile Fangs verursachen {spell:3427}.",
	-- {quest:1705} Burning Blood
	["{quest:1705}, from the Nightbane worgen"] = "{quest:1705}, von den Nightbane-Worgen",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845}, from {npc:6170}"] = "{item:6845}, von {npc:6170}",

	-- Step 14: Mathiel
	-- {quest:1703} Mathiel · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {quest:1710} Sunscorched Shells
	["{quest:1703} works on the south side of the {area:1660} in {zone:1457}. He wants 20 {quest:1710}."] = "{quest:1703} arbeitet an der Südseite von {area:1660} in {zone:1457}. Er will 20 {quest:1710}.",

	-- Step 15: Sunscorched Shells
	-- {area:482} Highperch · {zone:1441} Thousand Needles
	-- plural, as words: Highperch Wyverns = {npc:4107} Highperch Wyvern
	["The shells lie on the ground under the wyvern nests at {area:482} in western {zone:1441}, deeper into the gorge. Only nine exist and each returns 3 minutes after you pick it, so you will wait; some shell-like things there cannot be looted. Highperch Wyverns (level 28-31) guard them and sometimes come several at once."] = "Die Panzer liegen auf dem Boden unter den Wyvernnestern bei {area:482} im westlichen {zone:1441}, tiefer in der Schlucht. Es gibt nur neun, und jeder kehrt 3 Minuten nach dem Aufheben zurück, du wirst also warten; einige panzerähnliche Dinge dort lassen sich nicht plündern. Highperch Wyverns (Stufe 28-31) bewachen sie und kommen manchmal zu mehreren.",

	-- Step 17: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge · {quest:1704} Klockmort Spannerspan · {object:171524} Tinker Town · {item:6848} Searing Coral
	["Ride the {area:2257} from {zone:1453} to {zone:1455}. {quest:1704}, a gnome smith, works in {object:171524} near the engineering trainers. He wants 20 {item:6848}."] = "Fahr mit der {area:2257} von {zone:1453} nach {zone:1455}. {quest:1704}, ein Gnomenschmied, arbeitet in {object:171524} nahe den Ingenieurlehrern. Er will 20 {item:6848}.",

	-- Step 18: Iron Coral
	-- {quest:1708} Iron Coral · {area:150} Menethil Harbor · {item:5996} Draught of Water Breathing
	["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and a {item:5996} removes the risk."] = "{quest:1708} wächst auf dem Meeresboden direkt südlich von {area:150}, bei den Murloc-Hütten und einem Schiffswrack: acht dort und zwei südöstlich des Hafens, jede nach 3 Minuten zurück, du wirst also auf Respawns warten, um 20 zu erreichen. Die Murlocs können dich unter Wasser einnetzen: Achte auf deinen Atem, und {item:5996} beseitigt das Risiko.",
	-- {item:6848} Searing Coral · {quest:1708} Iron Coral
	["{item:6848}, from {quest:1708}"] = "{item:6848}, von {quest:1708}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "Eine Halsberge mit Stufe 28, je nach Volk eine Kettenhaube, Gamaschen oder Stulpen, und unterwegs ein Schild.",
	-- ["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "Mit Stufe 20 schickt dich {npc:5479} in der {object:2100}, neben dem Pig and Whistle, zu {quest:1698} ins Rotkammgebirge.",
	-- ["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "Zurück zu {npc:5413} im {object:28027}. Er schickt dich weiter zu einem Schmied deines eigenen Volkes.",
	-- ["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "Fahr mit der Bahn {area:2257} von {zone:1453} nach {zone:1455}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug ist ein Elite-Stacheleber im Gebiet {area:1717}, dem Dungeon am Südende von {zone:1413}; er lässt die {item:6841} fallen. {area:1717} ist ein Dungeon: Eine Gruppe wird empfohlen.",
	-- ["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "Schimärenjunge und Junge Schimären streifen durch den Südwesten des Steinkrallengebirges, mit der {npc:6167} unter ihnen: Die jungen lassen das {item:6839} fallen, die Matriarchin das {item:6840}.",
	-- ["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "Die Egelpirscher und Höhlenpirscher krabbeln bei 46,61 in der Mitte von {zone:1437}; sie lassen den {item:6838} fallen.",
	-- ["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "Die Worgen der Nachtheuler in {zone:1431} lassen das {quest:1705} fallen. {npc:6170} streift im äußersten Südosten von {zone:1431} umher und trägt den {item:6845}.",
	-- ["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "Die {quest:1708} wächst an der Westküste von {zone:1437}, südlich des Gebiets {area:150}.",
	-- ["The {quest:1710} lie along the western edge of {zone:1441}."] = "Die {quest:1710} liegen am Westrand von {zone:1441}.",
	-- ["{item:6839} from the young chimaeras"] = "{item:6839} von den jungen Schimären",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} von der {npc:6167}",
	-- ["{item:6845} from {npc:6170}"] = "{item:6845} von {npc:6170}",
	-- ["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416} ist in {zone:1453}, ein kurzes Stück von {npc:5413} entfernt.",
	-- ["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413} arbeitet im Zwergendistrikt von Sturmwind. Er hat {item:6843} und gibt dir {item:6970}, einen Schild; {quest:1701} ist eine Quest der Stufe 28.",
	-- ["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698} ist in {area:69}, im Gasthaus. Seine Prüfung läuft auf Zeit: Lauf nach Nordwesten in die {area:98}, erreiche die erste Gabelung und komm zurück zu ihm, bevor die Zeit abläuft. Stirb nicht und lass deinen Geist nicht frei.",
	-- ["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703} ist ein Schmied in {zone:1457}.",
	-- ["{quest:1705} from the Nightbane worgen"] = "{quest:1705} von den Worgen der Nachtheuler",
}
