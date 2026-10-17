-- German (deDE): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Nimm in {zone:1458} den Zeppelin am Turm vor der Stadt nach {zone:1454}.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Flieg zum {area:431} und reite auf der Straße nach Nordwesten aus {zone:1440} in den {zone:1448}. {area:2479} ist das Lager der Druiden gleich hinter der Grenze.",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}s Quest Silberherz braucht ein {item:11173} aus dem nördlichen {zone:1448} und einen Ritt zurück hierher. Überspringe sie.",

	-- Step 3: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Reite nach Nordwesten nach {area:1763}. Die vier Kohlenbecken stehen zwischen den Gebäuden des Schattenrats; benutze das gereinigte Wasser an jedem.",

	-- Step 4: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Zurück nach Süden zum Refugium, ein kurzer Ritt.",

	-- Step 5: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} und {npc:9517} warten hinten in der {area:1770}, der Höhle im Norden von {area:1763}. Räum den Tunnel auf dem Weg frei.",

	-- Step 6: Greta Mosshoof
	["South to the Sanctuary once more."] = "Noch einmal nach Süden zum Refugium.",

	-- Step 7: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Reite auf der Straße nach Norden an {area:1763} vorbei zum {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}s nächste Quest {quest:4741} würde dich aus {zone:1452} hierher zurückbringen. Überspringe sie.",

	-- Step 8: Toxic Horrors
	-- {npc:9298} Donova Snowden · {quest:5086} Toxic Horrors · {zone:1448} Felwood · {area:1767} Irontree Woods
	["Only if {npc:9298} gave you {quest:5086}: ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Nur wenn {npc:9298} dir {quest:5086} gegeben hat: Reite die Straße im {zone:1448} nach Norden zum Gebiet {area:1767}; die {quest:5086} kriechen zwischen den Bäumen.",

	-- Step 9: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Nur mit 30 {quest:6031} und nur bei Neutral mit der Holzschlundfeste: Folge der Straße nach Norden zur {area:1769}; {npc:11557} handelt gleich hinter dem Eingang.",

	-- Step 10: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Durch den Tunnel der Holzschlundfeste nach {zone:1450}. {npc:11939} liest in einem Haus in {area:2361}.",

	-- Step 11: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}s Die Splitter der Teufelsranke braucht {area:2577}. Überspringe sie.",

	-- Step 13: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Zurück in den Tunnel der Holzschlundfeste und nimm den Ausgang nach {zone:1452}; {npc:9298} lagert gleich draußen bei den heißen Quellen.",

	-- Step 14: Winterfall Runners
	-- {quest:5087} Winterfall Runners · {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden
	["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Nur wenn du {quest:5087} hast: Die Läufer gehen in kleinen Gruppen die Straße von der {area:1769} zum {area:2244}; warte an der Straße nahe {npc:9298} und töte sie im Vorbeigehen. Jeder trägt eine Kiste.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298} schickt dich als Nächstes zu {npc:10738}, einem Elite in seiner Höhle. Überspringe es.",

	-- Step 15: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Reite auf der Straße nach Osten nach {area:2255}.",

	-- Step 16: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "Dungeon statt Grinden",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Optional. {area:2279}, {area:2057}, die Untere Blackrockspitze oder {area:1584} mit einer Gruppe statt Grinden bringt dich schneller ans Ziel.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Optional: Mit einer Gruppe ersetzt ein Dungeon der Stufe 55-60 das Grinden unten.",

	-- Step 17: Grind to 60
	["Grind to 60"] = "Grinde bis 60",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Hier gehen die Quests aus. Tollwütige Splitterzähne streifen durch die {area:2249} im südlichen {zone:1452}, südlich der Straße von {area:2255}.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "Töte {npc:7446} in der {area:2249}, {zone:1452}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "In {zone:1454}: Flieg von {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "In {zone:1456}: Flieg von {area:2255}",
}
