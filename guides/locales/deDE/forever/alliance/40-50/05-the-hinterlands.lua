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
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "",

	-- Step 2: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "",

	-- Step 3: Aerie Peak
	["Inside"] = "",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "für {quest:2990} in der {area:1438}, später",

	-- Step 4: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 5: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Reite am Südufer des Sees entlang nach Osten zu Ironbands Lager.",

	-- Step 7: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Die Ausgrabung bei {area:1517}",
	-- {area:3} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "",

	-- Step 8: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Reite zurück nach Norden zu Ironbands Lager.",

	-- Step 10: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 11: Class trainer
	["Class trainer"] = "",

	-- Step 12: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 16: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "",

	-- Step 17: Into Duskwood
	-- {area:10} Duskwood
	["Into {area:10}"] = "",

	-- Step 18: Into Deadwind Pass
	-- {zone:1430} Deadwind Pass
	["Into {zone:1430}"] = "",

	-- Step 19: Into Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into {zone:1435}"] = "",

	-- Step 20: Into Blasted Lands
	-- {zone:1419} Blasted Lands
	["Into {zone:1419}"] = "",

	-- Step 21: Nethergarde Keep flight master
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "",

	-- Step 22: The bloodmages
	["The bloodmages"] = "Die Blutmagier",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "",

	-- Step 23: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Reite zuerst weiter nach Osten auf der Straße zur Burg: Die {item:6091} verfällt eine Stunde nach {area:42}, und die Bestien für die Blutmagier dauern länger.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, oben in der Burg",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "Die nächste Aufgabe von {npc:8022}, {item:9471}, ist eine Quest für {area:978}: Überspring sie.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "",

	-- Step 26: The Captain's Chest
	-- {npc:1492} Gorlash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1492} is a level 51 elite: most classes solo it at level 53, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 27: The Captain's Chest
	-- {npc:1492} Gorlash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1492} is a level 47 elite: most classes solo it at level 49, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 30: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 31: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "",
	-- {npc:8301} Clack the Reaver
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use Venom Sting; {npc:8301} adds Knockdown."] = "",

	-- Step 32: Level 47.07
	["Level 47.07"] = "",
	-- {quest:614} The Captain's Chest
	["If you skipped {quest:614}, grind here to level 47.07 to stay on the route's plan."] = "",
	-- {npc:5992} Ashmane Boar
	["grind on {npc:5992}"] = "",

	-- Step 33: Dreadmaul Hold: kill these as you meet them
	-- {area:1437} Dreadmaul Hold
	["{area:1437}: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Reite nach Westen: Verhungernde Kicherfänge streifen durch die trockenen Hügel gleich südlich des Lagers der Blutmagier; Skorpokstecher (Stufe 50) krabbeln durch die Mitte des Nordens. Geier ({npc:5982}) kreisen über allem. Zieh einen nach dem anderen.",

	-- Step 34: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Die zweite Stufe der Blutmagier bezahlt dieselben Teile mit einem Buff-Gegenstand und ohne Erfahrung: Überspring sie.",

	-- Step 35: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",

	-- Step 37: Boat to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Boat to {area:702}"] = "",

	-- Step 38: Rut'theran Village
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: Behalte sie, die Federn kommen am Ende des Guides für {zone:1428}",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}s nächster Auftrag führt nach {zone:1446}: Überspring ihn.",
	["the book on her table"] = "das Buch auf ihrem Tisch",

	-- Step 39: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",

	-- Step 42: Temple of the Moon
	["Temple of the Moon"] = "Der Tempel des Mondes",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Geh durch das Portal nach {zone:1457}. Der Tempel des Mondes liegt im Süden der Stadt.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, neben ihr",

	-- Step 45: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, oben im Baum",

	-- Step 47: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "die Erde kommt später aus dem {zone:1449}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Aschmähneneber und Rotsteinbasilisken teilen sich die Hänge südwestlich der Burg. Halte dich von den Höllenebern weiter südlich fern: Sie sind Stufe 52.",
	-- ["Back to {area:144}"] = "Zurück nach {area:144}",
	-- ["Boars and basilisks"] = "Eber und Basilisken",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Flieg von {area:144} zum Ort {area:150}, nimm das Boot nach {area:442} und flieg nach {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Flieg von {area:348} nach {area:42}.",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Ruhestein nach {area:144}. Der Guide für {zone:1427} beginnt an der {area:1446}: Reite von hier nach Süden ins {zone:1418}, nach Westen an der Hordestadt {area:340} vorbei und den Pfad hinauf in die Schlucht.",
	-- ["Hearth to {area:348}."] = "Ruhestein nach {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "Ruhestein noch nicht bereit? Reite zurück nach Nordwesten.",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Reite zurück nach Osten zur {area:1438} und flieg nach {area:144}.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Reite nach Osten durch den {zone:1430} in die {zone:1435} und auf der Straße nach Süden ins Gebiet {zone:1419}. Das Lager der Blutmagier ist der erste Halt an der Straße.",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Reite nach Norden zum {area:351} in der Mitte des {zone:1425}. Grüne Schlämme und Jadegrüne Brühschlammer kriechen überall drumherum.",
	-- ["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Reite nach Süden durch den Pass zum Nordrand des Gebiets {zone:1418}: Dort graben die Steingrufttroggs vor {area:1517}. Die verzierten Urnen und die magentafarbenen Pilzbüschel liegen in ihren Höhlen und Tunneln, außerhalb des Dungeons selbst.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Reite nach Südosten zum Ort {area:355}, dem gestuften Tempel der Vilebranch im Süden des {zone:1425}, und steig ganz nach oben. Qiaga und {npc:8636} (Elite, 50) stehen dort oben: Berühre die Spitze und komm sofort wieder herunter.",
	-- ["Scorpoks and snickerfangs"] = "Skorpoks und Kicherfänge",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Die Druidenlehrer stehen in der Enklave; {zone:1455} hat keine",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
}
