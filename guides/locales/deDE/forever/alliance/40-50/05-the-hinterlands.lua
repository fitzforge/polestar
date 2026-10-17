-- German (deDE): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Reite nach Südosten zum Ort {area:355}, dem gestuften Tempel der Vilebranch im Süden des {zone:1425}, und steig ganz nach oben. Qiaga und {npc:8636} (Elite, 50) stehen dort oben: Berühre die Spitze und komm sofort wieder herunter.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Reite nach Norden zum {area:351} in der Mitte des {zone:1425}. Grüne Schlämme und Jadegrüne Brühschlammer kriechen überall drumherum.",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "Ruhestein nach {area:348}.",
	["Hearthstone on cooldown? Ride back north-west."] = "Ruhestein noch nicht bereit? Reite zurück nach Nordwesten.",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "für {quest:2990} in der {area:1438}, später",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "Flieg von {area:348} nach {area:42}.",

	-- Step 6: The bloodmages
	["The bloodmages"] = "Die Blutmagier",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Reite nach Osten durch den {zone:1430} in die {zone:1435} und auf der Straße nach Süden ins Gebiet {zone:1419}. Das Lager der Blutmagier ist der erste Halt an der Straße.",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Reite zuerst weiter nach Osten auf der Straße zur Burg: Die {item:6091} verfällt eine Stunde nach {area:42}, und die Bestien für die Blutmagier dauern länger.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, oben in der Burg",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "Die nächste Aufgabe von {npc:8022}, {item:9471}, ist eine Quest für {area:978}: Überspring sie.",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "Eber und Basilisken",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Aschmähneneber und Rotsteinbasilisken teilen sich die Hänge südwestlich der Burg. Halte dich von den Höllenebern weiter südlich fern: Sie sind Stufe 52.",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "Skorpoks und Kicherfänge",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Reite nach Westen: Verhungernde Kicherfänge streifen durch die trockenen Hügel gleich südlich des Lagers der Blutmagier; Skorpokstecher (Stufe 50) krabbeln durch die Mitte des Nordens. Geier ({npc:5982}) kreisen über allem. Zieh einen nach dem anderen.",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Die zweite Stufe der Blutmagier bezahlt dieselben Teile mit einem Buff-Gegenstand und ohne Erfahrung: Überspring sie.",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "Reite zurück nach Osten zur {area:1438} und flieg nach {area:144}.",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Reite am Südufer des Sees entlang nach Osten zu Ironbands Lager.",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Die Ausgrabung bei {area:1517}",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Reite nach Süden durch den Pass zum Nordrand des Gebiets {zone:1418}: Dort graben die Steingrufttroggs vor {area:1517}. Die verzierten Urnen und die magentafarbenen Pilzbüschel liegen in ihren Höhlen und Tunneln, außerhalb des Dungeons selbst.",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Reite zurück nach Norden zu Ironbands Lager.",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Flieg von {area:144} zum Ort {area:150}, nimm das Boot nach {area:442} und flieg nach {area:702}.",
	["the book on her table"] = "das Buch auf ihrem Tisch",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}s nächster Auftrag führt nach {zone:1446}: Überspring ihn.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: Behalte sie, die Federn kommen am Ende des Guides für {zone:1428}",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Der Tempel des Mondes",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Geh durch das Portal nach {zone:1457}. Der Tempel des Mondes liegt im Süden der Stadt.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, neben ihr",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, oben im Baum",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "die Erde kommt später aus dem {zone:1449}",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Die Druidenlehrer stehen in der Enklave; {zone:1455} hat keine",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "Zurück nach {area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Ruhestein nach {area:144}. Der Guide für {zone:1427} beginnt an der {area:1446}: Reite von hier nach Süden ins {zone:1418}, nach Westen an der Hordestadt {area:340} vorbei und den Pfad hinauf in die Schlucht.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Reite nach Norden zum {area:351} in der Mitte des {zone:1425}. Grüne Schlämme und Jadegrüne Brühschlammer kriechen überall drumherum.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Reite nach Südosten zum Ort {area:355}, dem gestuften Tempel der Vilebranch im Süden des Gebiets {zone:1425}, und steig ganz nach oben. Qiaga und {npc:8636} (Elite, 50) stehen dort oben: Berühre die Spitze und komm sofort wieder herunter.",
}
