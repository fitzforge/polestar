-- German (deDE): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "Reite nach Südosten zum {area:355}, dem Stufentempel der Vilebranch im Süden von {zone:1425}, und steig ganz nach oben. Qiaga und {npc:8636} (Elite, 50) stehen dort oben: Berühre die Spitze und komm direkt wieder herunter.\nVorsicht: Elite-Trolle bewachen die oberste Plattform, darunter {npc:7996} und {npc:8636}, zusammen mit mehreren Vilebranch Soothsayers. Die Soothsayers wirken Zauber und sind mit dem Rest der Gruppe verbunden.",

	-- Step 2: Vilebranch Soothsayers
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Vilebranch Soothsayers"] = "Sterndeuter der Vilebranch",
	-- {area:355} Altar of Zul · {npc:7996} Qiaga the Keeper · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer · Vilebranch Totems = {item:279225} Vilebranch Totem
	-- was: ["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "Die Sterndeuter der Vilebranch (46-47) laufen rund um den Fuß des {area:355}: Ihre Totems sind für Maret Firetend. Vorsicht: {npc:7996} und {npc:8636} (50, Elite) stehen an der Südostseite des Altars: Nimm dir die Sterndeuter auf seiner Westseite vor, weg von ihnen, und bleib vom Altar runter."
	["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend, and more Vilebranch Totems lie on the ground among them: pick those up too. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "Reite nach Norden zum {area:351} in der Mitte von {zone:1425}. Green Sludges und Jade Oozes kriechen rundherum.\nVorsicht: Panther bewegen sich getarnt durch das Gebiet.",

	-- Step 4: Wildkin feathers
	["Wildkin feathers"] = "Wildekinfedern",
	-- {npc:7916} Erelas Ambersky · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {area:351} Skulk Rock
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["{npc:7916}'s Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam: pick them up as you ride between the altar and {area:351}."] = "Die Wildekinfedern für {npc:7916} liegen überall im {zone:1425} am Boden, südlich und östlich von {area:348}, wo die Eulenbestien umherstreifen: Heb sie auf, während du zwischen dem Altar und {area:351} hin und her reitest.",

	-- Step 5: Lost Gryphon Eggs
	-- plural, as words: Lost Gryphon Eggs = {item:279229} Lost Gryphon Egg
	["Lost Gryphon Eggs"] = "Verlorene Greifeneier",
	-- {area:348} Aerie Peak
	["On the way back to {area:348}: the lost gryphon eggs lie in the hills just east of the aviary."] = "Auf dem Rückweg nach {area:348}: Die verlorenen Greifeneier liegen in den Hügeln gleich östlich des Greifenhorsts.",

	-- Step 6: Aerie Peak
	["Inside"] = "Drinnen",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "{npc:5636}, drinnen",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "für {quest:2990} in der {area:1438}, später",
	-- {npc:270263} Farseer Maret Firetend
	["{npc:270263}, just east of the aviary"] = "{npc:270263}, gleich östlich des Greifenhorsts",

	-- Step 7: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Flugmeister von {area:348}",

	-- Step 8: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 9: Ironforge inn
	-- {area:1537} Ironforge
	["{area:1537} inn"] = "Gasthaus von {area:1537}",
	-- {object:26486} Stonefire Tavern (no name in this language: may be words) · {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth at the {object:26486}: the {zone:1427} guide starts with the hearth back here and the gryphon to {area:144}."] = "Binde deinen Ruhestein bei {object:26486}: Der Guide für {zone:1427} beginnt mit dem Ruhestein zurück hierher und dem Greif nach {area:144}.",

	-- Step 10: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tiefenbahn nach {zone:1453}",

	-- Step 12: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 15: The bloodmages
	["The bloodmages"] = "Die Blutmagier",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "Das Lager der Blutmagier ist der erste Halt neben der Straße ins {zone:1419}, nordwestlich von {area:1438}.",
	-- {npc:7505} Bloodmage Drazial · {zone:1419} Blasted Lands
	["{npc:7505}: keep the five, their beasts (48-53) wait for the level-52 {zone:1419} stop"] = "{npc:7505}: Behalte die fünf, ihre Bestien (48-53) warten auf den Halt in {zone:1419} auf Stufe 52",

	-- Step 16: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}."] = "Reite zuerst weiter nach Osten auf der Straße zur Burg: Die {item:6091} verfällt eine Stunde nach {area:42}.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, oben in der Burg",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "Die nächste Aufgabe von {npc:8022}, {item:9471}, ist eine Quest für {area:978}: Überspring sie.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}, oben",

	-- Step 17: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Flieg nach {area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "Flugmeister von {area:1438}",

	-- Step 18: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",
	["\"Sea Wolf\" MacKinley, if the Stranglethorn guide didn't give it"] = "\"Seewolf\" MacKinley, falls der Schlingendorntal-Guide sie nicht gegeben hat",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor, if the Stranglethorn guide didn't give it"] = "{npc:2487}, oberstes Stockwerk, falls der Schlingendorntal-Guide sie nicht gegeben hat",
	-- {npc:2494} Privateer Bloads
	["{npc:2494}, if the Stranglethorn guide didn't give it"] = "{npc:2494}, falls der Schlingendorntal-Guide sie nicht gegeben hat",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, if the Stranglethorn guide didn't give it"] = "{npc:2498}, drinnen, falls der Schlingendorntal-Guide sie nicht gegeben hat",

	-- Step 19: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "{area:43}: Töte diese, sobald sie dir begegnen",
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["The charts and orders lie in the pirate camp on the {area:43}, just south of {area:35}; its Swashbucklers walk the shore. The Warlocks and Swashbucklers (41-43) are under you now."] = "Die Karten und Befehle liegen im Piratenlager an der {area:43}, gleich südlich von {area:35}; seine Säbelrassler laufen am Ufer entlang. Die Hexenmeister und Säbelrassler (41-43) liegen jetzt unter deiner Stufe.",

	-- Step 20: Booty Bay
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, oberstes Stockwerk",

	-- Step 21: The Bloodsail captains
	["The Bloodsail captains"] = "Die Kapitäne der Blutsegelbukaniere",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "Die drei Blutsegel-Schiffe liegen vor der Küste direkt südlich von {area:35} vor Anker: {npc:2550} (45) und {npc:2548} (46) auf den näheren Decks, {npc:2546} (48) auf dem Flaggschiff, jeweils mit einer Besatzung von 42-45 Piraten. Schwimm hinaus, räum jedes Deck vom Rand aus und zieh einzeln.",

	-- Step 23: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Forscher der Naga",
	["Leave town by the tunnel and ride north along the coast past the Bloodsail camp: the naga comb the beaches beyond it and drop the reeds."] = "Verlass die Stadt durch den Tunnel und reite an der Küste nach Norden am Lager der Blutsegel vorbei: Die Naga durchkämmen die Strände dahinter und lassen das Schilf fallen.",

	-- Step 24: Zanzil's village
	["Zanzil's village"] = "Zanzils Dorf",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Ride on north along the coast to Zanzil's village. Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Reite weiter an der Küste nach Norden zu Zanzils Dorf. Jeder Anhänger Zanzils kann die Mixtur fallen lassen; {npc:2537} läuft im Süden des Lagers umher.",

	-- Step 25: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} und {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536} stand together in the hills just north of Zanzil's village."] = "{npc:2535} und {npc:2536} stehen zusammen in den Hügeln gleich nördlich von Zanzils Dorf.",

	-- Step 26: Gorilla hills
	["Gorilla hills"] = "Gorillahügel",
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Gorilla Fangs = {item:2799} Gorilla Fang · Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride back south-east to the Mistvale gorilla hills above {area:35}. {npc:1449} sits among the gorillas: take ten Gorilla Fangs from the Elder Mistvale Gorillas first."] = "Reite zurück nach Südosten zu den Gorillahügeln des Nebeltals oberhalb von {area:35}. {npc:1449} sitzt zwischen den Gorillas: Hol dir zuerst zehn Gorillafangzähne von den Alten Nebeltalgorillas.",

	-- Step 27: Unbagwa's ritual
	["Unbagwa's ritual"] = "Unbagwas Ritual",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Gib die Fangzähne ab und bleib da: Drei Wellen Gorillas kommen, {npc:1514} zuletzt.\nVorsicht: Drei Wellen Gorillas kommen kurz hintereinander, danach {npc:1514}. Fang mit voller Gesundheit und vollem Mana an und bleib in Unbagwas Nähe. Manche Klassen tun sich allein schwer: Mit einem Freund ist es einfach.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "{npc:1449}, in {area:1742}",

	-- Step 29: Booty Bay
	["Ride back down to town."] = "Reite zurück hinunter in die Stadt.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it, the Un'Goro guide lands there"] = "für {npc:2616} in Theramore: Behalte es, der Un'Goro-Guide endet dort",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}s nächster Zanzil-Auftrag beginnt in {zone:1441}: Überspring ihn.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	["MacKinley's next task sends you after elite ogres: skip it."] = "MacKinleys nächster Auftrag schickt dich zu Elite-Ogern: Überspring ihn.",

	-- Step 30: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {quest:8552} braucht eine Gruppe von 2. Überspring sie, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- Step 34: Negolash's bait
	-- {npc:1494} Negolash
	["{npc:1494}'s bait"] = "",
	-- {npc:1494} Negolash · {quest:619} Enticing Negolash · {area:35} Booty Bay · {item:4595} Junglevine Wine · {npc:2832} Nixxrax Fillamug
	-- plural, as words: Barbecued Buzzard Wings = {item:4457} Barbecued Buzzard Wing
	["{npc:1494} comes only for his food: hand in {quest:619} at Captain Smotts' ruined lifeboat on the shore south-east of {area:35}, with 10 Barbecued Buzzard Wings and 5 {item:4595}, and he comes to the boat. {npc:2832}, the food and drink vendor at the inn, sells the wine. The wings are a cook's dish: if you don't cook, bring them from the Auction House."] = "",
	-- {item:4457} Barbecued Buzzard Wing
	["{item:4457}: in your bags already if you cook"] = "",
	-- {object:2289} Ruined Lifeboat · {npc:1494} Negolash
	["{object:2289}: the food goes in, {npc:1494} comes"] = "",

	-- Step 35: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:1494} (Elite der Stufe 52) braucht eine Gruppe von 2. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Aschmähneneber und Rotsteinbasilisken teilen sich die Hänge südwestlich der Burg. Halte dich von den Höllenebern weiter südlich fern: Sie sind Stufe 52.",
	-- ["Back to {area:144}"] = "Zurück nach {area:144}",
	-- ["Boars and basilisks"] = "Eber und Basilisken",
	-- ["Boat to {area:17203}"] = "Boot nach {area:17203}",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Flieg von {area:144} zum Ort {area:150}, nimm das Boot nach {area:442} und flieg nach {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Flieg von {area:348} nach {area:42}.",
	-- ["Fly to {area:144}"] = "Flieg nach {area:144}",
	-- ["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- ["Fly to {area:442}"] = "Flieg nach {area:442}",
	-- ["Fly to {area:69}"] = "Flieg nach {area:69}",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Ruhestein nach {area:144}. Der Guide für {zone:1427} beginnt an der {area:1446}: Reite von hier nach Süden ins {zone:1418}, nach Westen an der Hordestadt {area:340} vorbei und den Pfad hinauf in die Schlucht.",
	-- ["Hearth to {area:348}."] = "Ruhestein nach {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "Ruhestein noch nicht bereit? Reite zurück nach Nordwesten.",
	-- ["Portal to {zone:1438}"] = "Portal nach {zone:1438}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Reite zurück nach Osten zur {area:1438} und flieg nach {area:144}.",
	-- ["Ride back north to Ironband's camp."] = "Reite zurück nach Norden zu Ironbands Lager.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "Reite am Südufer des Sees entlang nach Osten zu Ironbands Lager.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Reite nach Osten durch den {zone:1430} in die {zone:1435} und auf der Straße nach Süden ins Gebiet {zone:1419}. Das Lager der Blutmagier ist der erste Halt an der Straße.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Reite nach Norden zum {area:351} in der Mitte des {zone:1425}. Grüne Schlämme und Jadegrüne Brühschlammer kriechen überall drumherum.",
	-- ["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Reite zuerst weiter nach Osten auf der Straße zur Burg: Die {item:6091} verfällt eine Stunde nach {area:42}, und die Bestien für die Blutmagier dauern länger.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Reite nach Süden durch den Pass zum Nordrand des Gebiets {area:3}: Dort graben die Steingrufttroggs vor {area:1517}. Die verzierten Urnen und die magentafarbenen Pilzbüschel liegen in ihren Höhlen und Tunneln, außerhalb des Dungeons selbst.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Reite nach Südosten zum Ort {area:355}, dem gestuften Tempel der Vilebranch im Süden des {zone:1425}, und steig ganz nach oben. Qiaga und {npc:8636} (Elite, 50) stehen dort oben: Berühre die Spitze und komm sofort wieder herunter.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Reite nach Westen: Verhungernde Kicherfänge streifen durch die trockenen Hügel gleich südlich des Lagers der Blutmagier; Skorpokstecher (Stufe 50) krabbeln durch die Mitte des Nordens. Geier ({npc:5982}) kreisen über allem. Zieh einen nach dem anderen.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time.\nAshmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "Reite nach Westen: Starving Snickerfangs streifen durch die trockenen Hügel direkt südlich des Lagers der Blutmagier; Scorpok Stingers (Stufe 50) huschen durch die Mitte des Nordens. {npc:5982}-Geier kreisen über allem. Zieh einzeln.\nAshmane Boars und Redstone Basilisks teilen sich die Hänge südwestlich der Festung. Halte dich von den Helboars weiter südlich fern: Sie sind Stufe 52.\nVorsicht: Scorpok Stingers benutzen {spell:5416}; {npc:8301} fügt Niederschlagen hinzu.\nVorsicht: Hier streifen zwei Elites umher: {npc:221740} (50) in der Mitte des Gebiets bei etwa 44,34 und {npc:247015} (55) auf dem Grat bei etwa 39,32. Wenn du einen siehst, jag woanders.",
	-- ["Scorpoks and snickerfangs"] = "Skorpoks und Kicherfänge",
	-- ["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Geh durch das Portal nach {zone:1457}. Der Tempel des Mondes liegt im Süden der Stadt.",
	-- ["Temple of the Moon"] = "Der Tempel des Mondes",
	-- ["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "Die Sterndeuter der Vilebranch (46-47) laufen rund um den Fuß des {area:355}: Ihre Totems sind für Maret Firetend. Vorsicht: {npc:7996} und {npc:8636} (50, Elite) stehen an der Südostseite des Altars: Nimm dir die Sterndeuter auf seiner Westseite vor, weg von ihnen, und bleib vom Altar runter.",
	-- ["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Die zweite Stufe der Blutmagier bezahlt dieselben Teile mit einem Buff-Gegenstand und ohne Erfahrung: Überspring sie.",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Die Druidenlehrer stehen in der Enklave; {zone:1455} hat keine",
	-- ["The {area:1517} dig"] = "Die Ausgrabung bei {area:1517}",
	-- ["the book on her table"] = "das Buch auf ihrem Tisch",
	-- ["the soil comes from {zone:1449}, later"] = "die Erde kommt später aus dem {zone:1449}",
	-- ["{area:144} flight master"] = "Flugmeister in {area:144}",
	-- ["{area:2418} flight master"] = "Flugmeister von {area:2418}",
	-- ["{area:702} flight master"] = "Flugmeister von {area:702}",
	-- ["{npc:3516}, at the top of the tree"] = "{npc:3516}, oben im Baum",
	-- ["{npc:7740}, beside her"] = "{npc:7740}, neben ihr",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} steht oben, über {npc:7916}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- ["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}s nächster Auftrag führt nach {zone:1446}: Überspring ihn.",
	-- ["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: Behalte sie, die Federn kommen am Ende des Guides für {zone:1428}",
	-- ["{zone:1419}: kill these as you meet them"] = "{zone:1419}: Töte diese, sobald sie dir begegnen",
}
