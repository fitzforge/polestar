-- German (deDE): the guide forever/class/hunter/taming-the-beast-alliance (forever/class/hunter/taming-the-beast-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6063} Taming the Beast
	["{quest:6063} (Alliance)"] = "{quest:6063} (Allianz)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Dein eigener Begleiter mit Stufe 10: Drei Übungszähmungen mit {item:15908} bringen dir {spell:1515} bei, dann {spell:5149}.",

	-- Step 1: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "Mit Stufe 10 schickt dich {npc:254084}, eine Jägerlehrerin auf {zone:2521}, womöglich mit {quest:94007} weiter nach {area:16638}. Es ist nur ein Hinweis: Überspring ihn, wenn du schon in {area:16638} bist.",

	-- Step 2: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} in {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} steht bei den Lehrern am Westtor von {area:16638}, {npc:254411} neben ihr.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}: der erste {item:15908}",

	-- Step 3: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges. Killing one does not count. Keep each rod: it goes back to {npc:252389}."] = "Windsong Crawlers leben nur am Wasser: Die nächsten huschen am Ufer südwestlich von {area:16638} entlang, zwischen den Krabben. So funktioniert der Stab: Wähle einen lebenden Crawler als Ziel, benutze {item:15908} und steh während des gesamten Kanalisierens still, während er dich schlägt; Bewegen, Zurückschlagen oder fremde Hilfe unterbricht es und kostet eine der wenigen Ladungen des Stabs. Ihn zu töten zählt nicht. Behalte jeden Stab: Er geht zurück an {npc:252389}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Benutze {item:15908} an einem lebenden Crawler",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Zähme {npc:254588}",

	-- Step 4: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Entlasse zuerst den Crawler (Rechtsklick auf das Begleiterportrait, {spell:2641}). Ornery Galestriders grasen in {area:16626}, den Feldern ein Stück westlich und südwestlich von {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Benutze {item:15908} an einem lebenden Galestrider",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Zähme {npc:251707}",

	-- Step 5: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Entlasse den Galestrider. Vuldren Alphas jagen im selben {area:16626}, ein Stück weiter südlich.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Benutze {item:15908} an einem lebenden Alpha",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Zähme {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, neben ihr: {spell:5149}",

	-- Step 6: Grif Wildheart in Kharanos
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos
	["{npc:1231} in {area:131}"] = "{npc:1231} in {area:131}",
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:11807} Tristane Shadowstone · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:1231}, the hunter trainer at the smithy in {area:131}. The Hunter's Path from {npc:5116} in {zone:1455}, {npc:11807} north-west of {area:131} or {npc:5515} in {zone:1453} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "Geh mit Stufe 10 zu {npc:1231}, dem Jägerlehrer bei der Schmiede in {area:131}. Auch der Weg des Jägers von {npc:5116} in {zone:1455}, {npc:11807} nordwestlich von {area:131} oder {npc:5515} in {zone:1453} führt hierher, für ein wenig Erfahrung; es ist nur ein Hinweis. Mit Stufe 10 stattdessen in Elwynn? Die Questreihe von {npc:251507} in {area:87} bringt dasselbe bei.",
	-- {npc:1231} Grif Wildheart · {item:15908} Taming Rod
	["{npc:1231}: the first {item:15908}"] = "{npc:1231}: der erste {item:15908}",

	-- Step 7: Large Crag Boar
	-- {area:131} Kharanos · {item:15908} Taming Rod · {npc:1231} Grif Wildheart · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar
	["Large Crag Boars (level 6-7) root around the fields west, south and north-west of {area:131} and respawn every 3 minutes. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, being out of range or anyone else's help breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:1231}. The boars use {spell:6268} from 25 yards, so start with the rod, not {spell:75}. Keep each rod: it goes back to {npc:1231}."] = "Large Crag Boars (Stufe 6-7) wühlen auf den Feldern westlich, südlich und nordwestlich von {area:131} und respawnen alle 3 Minuten. So funktioniert der Stab: Wähle ein lebendes Tier als Ziel, benutze {item:15908} und steh während des gesamten Kanalisierens still, während es dich schlägt. Bewegen, Zurückschlagen, außer Reichweite sein oder fremde Hilfe unterbricht es und kostet eine der wenigen Ladungen des Stabs; wenn sie aufgebraucht sind, zerstöre den Stab, brich die Quest ab und nimm sie bei {npc:1231} noch einmal an. Die Eber nutzen {spell:6268} aus 25 Metern, also fang mit dem Stab an, nicht mit {spell:75}. Behalte jeden Stab: Er geht zurück an {npc:1231}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Benutze {item:15908} an einem lebenden Eber",

	-- Step 8: Snow Leopard
	-- {spell:2641} Dismiss Pet · {area:131} Kharanos
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Juvenile Snow Leopards = {npc:1199} Juvenile Snow Leopard
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Snow Leopards (level 7-8) prowl the slopes south-east of {area:131}, more north-west and west of it; the smaller Juvenile Snow Leopards do not count."] = "Entlasse zuerst den Eber (Rechtsklick auf das Begleiterportrait, {spell:2641}): Ein freigelassener Übungsbegleiter kann sich gegen dich wenden. Schneeleoparden (Stufe 7-8) streifen über die Hänge südöstlich von {area:131}, mehr noch nordwestlich und westlich davon; die kleineren Juvenile Snow Leopards zählen nicht.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living leopard"] = "Benutze {item:15908} an einem lebenden Leoparden",

	-- Step 9: Ice Claw Bear
	-- {area:131} Kharanos · {area:77} Anvilmar · {spell:3130} Ice Claw
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Dismiss the leopard. Ice Claw Bears (level 7-8) roam the hills around {area:131}, many south-east of it and more north-west toward {area:77}; their {spell:3130} hits hard, so start at full health."] = "Entlasse den Leoparden. Eisklauenbären (Stufe 7-8) streifen durch die Hügel rund um {area:131}, viele südöstlich davon und mehr nordwestlich Richtung {area:77}; ihr {spell:3130} trifft hart, also fang mit voller Gesundheit an.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living bear"] = "Benutze {item:15908} an einem lebenden Bären",

	-- Step 10: Belia Thundergranite in Ironforge
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455}"] = "{npc:10090} in {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1455} Ironforge · {object:32359} Military Ward (no name in this language: may be words)
	["{npc:10090}, the pet trainer, stands in the {object:32390} in {zone:1455}'s {object:32359}, by the hunter trainers."] = "{npc:10090}, die Begleiterlehrerin, steht in {object:32390} in {object:32359} von {zone:1455}, bei den Jägerlehrern.",

	-- Step 11: Dazalar in Dolanaar
	-- {npc:3601} Dazalar · {area:186} Dolanaar
	["{npc:3601} in {area:186}"] = "{npc:3601} in {area:186}",
	-- {npc:3601} Dazalar · {area:186} Dolanaar · {npc:3596} Ayanna Everstride · {area:256} Aldrassil · {npc:4146} Jocaste · {zone:1457} Darnassus · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:3601}, the hunter trainer in {area:186}. The Hunter's Path from {npc:3596} at {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} or {npc:1231} in {area:131} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "Geh mit Stufe 10 zu {npc:3601}, dem Jägerlehrer in {area:186}. Auch der Weg des Jägers von {npc:3596} bei {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} oder {npc:1231} in {area:131} führt hierher, für ein wenig Erfahrung; es ist nur ein Hinweis. Mit Stufe 10 stattdessen in Elwynn? Die Questreihe von {npc:251507} in {area:87} bringt dasselbe bei.",
	-- {npc:3601} Dazalar · {item:15908} Taming Rod
	["{npc:3601}: the first {item:15908}"] = "{npc:3601}: der erste {item:15908}",

	-- Step 12: Webwood Lurker
	-- {area:186} Dolanaar · {item:15908} Taming Rod · {spell:1265843} Web · {npc:3601} Dazalar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers (level 5-6) creep through the woods just north-east, south-west and east of {area:186}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, attacking it or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). Their {spell:1265843} roots you but does not break the channel if you keep still. Keep each rod: it goes back to {npc:3601}."] = "Webwood Lurkers (Stufe 5-6) schleichen durch die Wälder nordöstlich, südwestlich und östlich von {area:186}. So funktioniert der Stab: Wähle ein lebendes Tier als Ziel, benutze {item:15908} und steh während des gesamten Kanalisierens still, während es dich schlägt; Bewegen, Angreifen oder fremde Hilfe unterbricht es und kostet eine der wenigen Ladungen des Stabs (keine Ladungen mehr: zerstöre den Stab, brich die Quest ab, nimm sie noch einmal an). Ihr {spell:1265843} wurzelt dich fest, unterbricht das Kanalisieren aber nicht, wenn du stillstehst. Behalte jeden Stab: Er geht zurück an {npc:3601}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living spider"] = "Benutze {item:15908} an einer lebenden Spinne",

	-- Step 13: Nightsaber Stalker
	-- {spell:2641} Dismiss Pet · {area:259} Lake Al'Ameth · {area:186} Dolanaar
	-- plural, as words: Nightsaber Stalkers = {npc:2043} Nightsaber Stalker
	["Dismiss the spider first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Nightsaber Stalkers (level 7-8) lie on the hillside south of {area:259}, south of {area:186}; the plain Nightsabers by the village do not count."] = "Entlasse zuerst die Spinne (Rechtsklick auf das Begleiterportrait, {spell:2641}): Ein freigelassener Übungsbegleiter kann sich gegen dich wenden. Nightsaber Stalkers (Stufe 7-8) liegen am Hang südlich von {area:259}, südlich von {area:186}; die einfachen Nachtsäbler beim Dorf zählen nicht.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Benutze {item:15908} an einem lebenden Stalker",

	-- Step 14: Strigid Screecher
	-- {area:186} Dolanaar
	-- plural, as words: Strigid Screechers = {npc:1996} Strigid Screecher
	["Dismiss the cat. Strigid Screechers (level 7-8), owls, perch in the woods south, south-west and west of {area:186}."] = "Entlasse die Katze. Strigid Screechers (Stufe 7-8), Eulen, sitzen in den Wäldern südlich, südwestlich und westlich von {area:186}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living owl"] = "Benutze {item:15908} an einer lebenden Eule",

	-- Step 15: Jocaste in Darnassus
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457}"] = "{npc:4146} in {zone:1457}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:4146} Jocaste · {area:1658} Cenarion Enclave
	["Take the road west from {area:186} to {zone:1457}. {npc:4146} stands inside the {area:1658} with the hunter trainers; Silvaria, the pet trainer, is up the ramp next to her."] = "Nimm die Straße von {area:186} nach Westen bis {zone:1457}. {npc:4146} steht in der {area:1658} bei den Jägerlehrern; Silvaria, die Begleiterlehrerin, ist die Rampe hinauf neben ihr.",

	-- Step 16: Josephine Carson in Goldshire
	-- {npc:251507} Josephine Carson · {area:87} Goldshire
	["{npc:251507} in {area:87}"] = "{npc:251507} in {area:87}",
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {npc:258930} Isaac Chan · {zone:2521} Zephras Isle
	["At 10 go to {npc:251507}, the hunter trainer who stands with the other trainers by the Lion's Pride Inn in {area:87}; {npc:258930}, the pet trainer, is beside her. Skyborne: this is for one who left {zone:2521} without taming; it teaches the same."] = "Geh mit Stufe 10 zu {npc:251507}, der Jägerlehrerin, die mit den anderen Lehrern beim Lion's Pride Inn in {area:87} steht; {npc:258930}, der Begleiterlehrer, ist neben ihr. Himmelsgeborene: Das ist für alle, die {zone:2521} ohne Zähmung verlassen haben; es bringt dasselbe bei.",
	-- {npc:251507} Josephine Carson · {item:15908} Taming Rod
	["{npc:251507}: the first {item:15908}"] = "{npc:251507}: der erste {item:15908}",

	-- Step 17: Rockhide Boar
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {item:15908} Taming Rod · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar
	["Rockhide Boars (level 7-8) graze in three herds south and south-east of {area:87}, toward the {area:64}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again. The boars use {spell:6268}, so start with the rod, not {spell:75}. Killing a boar does not count. Keep each rod: it goes back to Josephine. A Dwarf or Night Elf who took Josephine's rod instead of their home trainer's is led through {area:87} from here."] = "Rockhide Boars (Stufe 7-8) grasen in drei Herden südlich und südöstlich von {area:87}, Richtung {area:64}. So funktioniert der Stab: Wähle ein lebendes Tier als Ziel, benutze {item:15908} und steh während des gesamten Kanalisierens still, während es dich schlägt. Bewegen, Zurückschlagen, eine Heilung von jemand anderem oder fremde Treffer auf das Tier unterbrechen es und kosten eine der wenigen Ladungen des Stabs; wenn sie aufgebraucht sind, zerstöre den Stab, brich die Quest ab und nimm sie noch einmal an. Die Eber nutzen {spell:6268}, also fang mit dem Stab an, nicht mit {spell:75}. Einen Eber zu töten zählt nicht. Behalte jeden Stab: Er geht zurück an Josephine. Ein Zwerg oder Nachtelf, der Josephines Stab statt den seines Heimatlehrers genommen hat, wird von hier aus durch {area:87} geführt.",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "Zähme {npc:524}",

	-- Step 18: Gray Forest Wolf
	-- {spell:2641} Dismiss Pet · {area:87} Goldshire · {area:18} Crystal Lake
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Gray Forest Wolves (level 7-8) run in the woods east of {area:87}, east of {area:18}."] = "Entlasse zuerst den Eber (Rechtsklick auf das Begleiterportrait, {spell:2641}): Ein freigelassener Übungsbegleiter kann sich gegen dich wenden. Gray Forest Wolves (Stufe 7-8) laufen in den Wäldern östlich von {area:87}, östlich von {area:18}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living wolf"] = "Benutze {item:15908} an einem lebenden Wolf",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "Zähme {npc:1922}",

	-- Step 19: Young Forest Bear
	-- {area:87} Goldshire
	-- plural, as words: Young Forest Bears = {npc:822} Young Forest Bear
	["Dismiss the wolf. Young Forest Bears (level 8-9) roam the woods just south of {area:87}, with more south-west and south-east of town."] = "Entlasse den Wolf. Young Forest Bears (Stufe 8-9) streifen durch die Wälder direkt südlich von {area:87}, mehr noch südwestlich und südöstlich der Stadt.",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "Zähme {npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, neben ihr: {spell:5149}",

	-- Step 20: Your first pet
	["Your first pet"] = "Dein erster Begleiter",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} funktioniert wie der Stab: ein Tier deiner Stufe oder niedriger, ein Kanalisieren, bei dem du dich nicht bewegen darfst, und das Tier schlägt dich die ganze Zeit. Ein Begleiter behält die Stufe, auf der du ihn gezähmt hast, und steigt mit dir auf; er kann nie über deiner Stufe liegen, also zähme einen nahe an deiner. Jede Familie hat auf Forever ihre eigene Fähigkeit (zum Beispiel den Sturmangriff eines Ebers). Zum Leveln schlägt eine Katze am härtesten zu (Klaue und {spell:17253}), und ein Eber hält mehr aus.",
	["Tame a beast of your level to keep"] = "Zähme ein Tier deiner Stufe, das du behältst",
	-- {area:87} Goldshire · {zone:1436} Westfall
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Near {area:87} there are no cats: Prowlers (wolves, level 9-10) roam eastern Elwynn, Longsnouts (boars, 10-11) its far south-west by the {zone:1436} border; at 12-13, Young Goretusks (boars) graze the fields of northern {zone:1436}."] = "In der Nähe von {area:87} gibt es keine Katzen: Prowlers (Wölfe, Stufe 9-10) streifen durch das östliche Elwynn, Longsnouts (Eber, 10-11) durch den äußersten Südwesten an der Grenze zu {zone:1436}; mit 12-13 grasen Young Goretusks (Eber) auf den Feldern im Norden von {zone:1436}.",
	-- {area:131} Kharanos · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Scarred Crag Boars = {npc:1689} Scarred Crag Boar · Mountain Boars = {npc:1190} Mountain Boar
	["Near {area:131}: Snow Leopards (cats, level 7-8) prowl all over {zone:1426}, Scarred Crag Boars (9-10) its east toward {zone:1432}; at 10-11, Mountain Boars roam western {zone:1432}."] = "In der Nähe von {area:131}: Schneeleoparden (Katzen, Stufe 7-8) streifen überall durch {zone:1426}, Scarred Crag Boars (9-10) durch den Osten Richtung {zone:1432}; mit 10-11 streifen Bergeber durch den Westen von {zone:1432}.",
	-- {area:186} Dolanaar · {zone:1438} Teldrassil
	-- plural, as words: Elder Nightsabers = {npc:2033} Elder Nightsaber · Feral Nightsabers = {npc:2034} Feral Nightsaber
	["Near {area:186}: Elder Nightsabers (cats, level 8-9) and Feral Nightsabers (cats, 10-11) prowl the woods of north-western {zone:1438}."] = "In der Nähe von {area:186}: Elder Nightsabers (Katzen, Stufe 8-9) und Feral Nightsabers (Katzen, 10-11) streifen durch die Wälder im Nordwesten von {zone:1438}.",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "In der Nähe von {area:16638}: Vuldren Alphas (Stufe 10), das Tier deiner letzten Übungszähmung, jagen in {area:16626}; Shriekling Matriarchs (Raptoren, Stufe 9) nisten direkt westlich von {area:16638}; Shadowgale Urseras (Bären, 10-11) streifen durch den Norden von {zone:2521}.",
	-- {spell:1584} Feed Pet · {area:87} Goldshire · {zone:1457} Darnassus · {zone:2521} Zephras Isle · {area:131} Kharanos · {area:186} Dolanaar
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Toddrick the butcher in {area:87}, Jaeana in {zone:1457} and the innkeepers on {zone:2521} sell meat; the innkeepers of {area:131} and {area:186} sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}: Öffne dein Zauberbuch, wirke {spell:1584} und klicke auf ein Futter, das die Familie deines Begleiters frisst (der Tooltip des Begleiters listet sie auf: Katzen fressen Fleisch und Fisch, Eber fast alles). Rohes Fleisch, das du von Tieren plünderst, zählt. Zum Kaufen: Der Fleischer Toddrick in {area:87}, Jaeana in {zone:1457} und die Gastwirte auf {zone:2521} verkaufen Fleisch; die Gastwirte von {area:131} und {area:186} verkaufen Brot. Futter nahe der Stufe des Begleiters macht ihn am glücklichsten; deutlich niedrigeres gibt etwa die Hälfte. Im Kampf kannst du nicht füttern.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Zufriedenheit: das Gesicht im Begleiterfenster. Ein unzufriedener Begleiter richtet drei Viertel seines Schadens an, ein zufriedener ein Viertel mehr. Die Zufriedenheit sinkt langsam, schneller, wenn der Begleiter stirbt; ein zu lange unzufriedener Begleiter kann weglaufen.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "Die Loyalität wächst mit der Zeit und mit Kills. Jeder Loyalitätsrang erhöht die Trainingspunkte, die du in {spell:5149} ausgibst (Begleiterstufe mal Loyalitätsrang minus eins).",
	-- {spell:5149} Beast Training · {area:87} Goldshire · {npc:9980} Shelby Stoneflint · {area:131} Kharanos · {area:186} Dolanaar · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} on {zone:2521}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (Zauberbuch, Reiter Allgemein) bringt deinem aktuellen Begleiter die Fähigkeiten bei, die du kennst. Um eine neue Fähigkeit oder einen neuen Rang zu lernen: Lass deinen Begleiter bei einem Stallmeister (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} auf {zone:2521}), zähme ein Tier, das sie beherrscht (im Begleiter-Zauberbuch-Reiter siehst du, was es kann), benutze die Fähigkeit in Kämpfen, bis das Spiel meldet, dass du sie gelernt hast, hol dann deinen eigenen Begleiter zurück und bring sie ihm mit {spell:5149} bei. Ein Begleiter hat höchstens vier aktive Fähigkeiten.",
	-- {spell:1853} Growl · {npc:258930} Isaac Chan · {area:87} Goldshire · {npc:2879} Karrina Mekenda · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:2878} Peria Lamenur · {area:131} Kharanos · {npc:10090} Belia Thundergranite · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {area:186} Dolanaar · {zone:1457} Darnassus · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar
	["Pet trainers sell {spell:1853} ranks and resistances. Alliance: {npc:258930} in {area:87}, {npc:2879} by the hunter trainers in {zone:1453}'s {object:28027}, {npc:2878} in {area:131}, {npc:10090} in {zone:1455}'s {object:32390}, Keldas in {area:186}, Silvaria in {zone:1457}' Cenarion Enclave, {npc:254411} in {area:16638}."] = "Begleiterlehrer verkaufen Ränge von {spell:1853} und Widerstände. Allianz: {npc:258930} in {area:87}, {npc:2879} bei den Jägerlehrern im {object:28027} von {zone:1453}, {npc:2878} in {area:131}, {npc:10090} in {object:32390} von {zone:1455}, Keldas in {area:186}, Silvaria in der Cenarion-Enklave von {zone:1457}, {npc:254411} in {area:16638}.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} und {spell:982} sind jetzt in deinem Zauberbuch; {spell:136} bekommst du mit Stufe 12 von deinem Lehrer. Ein toter Begleiter braucht {spell:982}; einer, der mehr als etwa 100 Meter entfernt ist, wird entlassen und kommt mit {spell:883} zurück.",
}
