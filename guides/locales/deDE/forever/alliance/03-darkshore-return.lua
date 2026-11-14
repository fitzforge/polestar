-- German (deDE): the guide forever/alliance/03-darkshore-return (forever/alliance/03-darkshore-return.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {npc:3649} Thundris Windweaver · {npc:3702} Alanndarian Nightsong · {npc:2913} Archaeologist Hollee · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin
	["From the dock (or the inn, if you used your Hearthstone), up to the north end of the village first ({npc:3649}, {npc:3702} by the moonwell, {npc:2913}), then down the main street: the WANTED poster outside the inn, {npc:3693} at its east end, where the road leaves south. {npc:3694} stands beside {npc:3693} by the flight master; if she isn't there, she has been killed and respawns shortly: wait a moment."] = "Vom Dock aus (oder vom Gasthaus, falls du deinen Ruhestein benutzt hast) zuerst hoch zum Nordende des Dorfes ({npc:3649}, {npc:3702} am Mondbrunnen, {npc:2913}), dann die Hauptstraße hinunter: das Steckbrief-Plakat vor dem Gasthaus, {npc:3693} an ihrem Ostende, wo die Straße nach Süden aus dem Dorf führt. {npc:3694} steht neben {npc:3693} beim Flugmeister; wenn sie nicht da ist, wurde sie getötet und erscheint gleich wieder: Warte einen Moment.",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston
	["{npc:3649}, north end of the village: {npc:1646}'s reply"] = "{npc:3649}, Nordende des Dorfes: die Antwort an {npc:1646}",
	["The WANTED poster"] = "Der Steckbrief",
	-- {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, beside {npc:3693}: for {npc:3691} in {area:415}, in the next guide"] = "{npc:3694}, neben {npc:3693}: für {npc:3691} in {area:415}, im nächsten Guide",

	-- Step 2: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} und {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["On the way south to the Grove: the Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}, a short way off the road; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Auf dem Weg nach Süden zum Hain: Die Lunarfungusblüten wachsen in den Moonkinhöhlen in den Hügeln gleich östlich von {area:442}, ein kurzes Stück abseits der Straße; die Moonkin dort sind reizbar. {item:2449} erfordert {skill:182}: Kräuterkundige pflücken es überall in {zone:1439}, alle anderen bringen es aus {zone:1453} ({npc:1313}) oder aus dem Auktionshaus mit.",

	-- Step 4: Onu
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["{quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "{quest:948} ist der Uralte am Hain; {npc:270269} und {npc:11218} schlafen neben ihm.",

	-- Step 5: The Grove of the Ancients
	-- {quest:952} Grove of the Ancients
	["The {quest:952}"] = "Die Quest {quest:952}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Ergraute Distelbären streifen durch die Hügel rund um den Hain; {quest:1003} steht westlich davon zwischen ihnen.",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "Ergraute Skalpe",

	-- Step 6: The Master's Glaive
	-- {object:12666} Twilight Tome · {npc:3584} Therylune · {quest:948} Onu · {item:5251} Phial of Scrying · {object:10076} Scrying Bowl
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:12666} sits at the bottom of the crater; {npc:3584} stands on its north side. For {quest:948}'s quest, use the {item:5251} at the bottom of the crater: it makes the {object:10076}, and you hand the quest in to the bowl."] = "Mondpirscherpatriarchen streifen durch die Wälder rund um die Gleve. Der {object:12666} steht am Grund des Kraters; {npc:3584} steht an seiner Nordseite. Für die Quest von {quest:948} benutzt du die {item:5251} am Grund des Kraters: Sie erzeugt die {object:10076}, und du gibst die Quest an der Schale ab.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "Feine Mondpirscherpelze",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Eskortiere sie aus der Gleve; Therysil nimmt die Abgabe in {zone:1440} entgegen",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Nur falls ein Jünger oder Rohling {item:5352} gedroppt hat: Rechtsklicke darauf",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "Die {object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "Der {object:12666}",
	-- {object:12666} Twilight Tome · {quest:949} The Twilight Camp
	["The {object:12666}, once it has {quest:949}"] = "Der {object:12666}, sobald du {quest:949} hast",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: Twilight-Jünger und -Rohlinge",

	-- Step 7: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil.\nCareful: Ambushers appear as he passes certain spots: a scout comes out from under the board ramp, and more scouts come out when he checks the tent."] = "{area:450} liegt an der Küste südlich vom Strand von {npc:10323}. Beschütze den Prospektor, während er nach dem Fossil sucht.\nVorsicht: Hinterhalte tauchen auf, wenn er bestimmte Stellen passiert: Ein Späher kommt unter der Bretterrampe hervor, und weitere Späher kommen heraus, wenn er das Zelt untersucht.",

	-- Step 8: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "Der Strand von {npc:10323}",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Four beached remains lie on the beaches west and south-west of {area:450}: take them on the way north to his camp."] = "{npc:10323} lagert am Strand westlich der Glefe: Töte die Murlocs am Lagerfeuer; er kommt in der dritten Welle mit seinem Hund. Vier angespülte Überreste liegen an den Stränden westlich und südwestlich von {area:450}: Nimm sie auf dem Weg nach Norden zu seinem Lager mit.",

	-- Step 11: The shore west of the Grove
	["The shore west of the Grove"] = "Das Ufer westlich des Hains",
	-- {area:442} Auberdine · {quest:4728} Beached Sea Creature
	["On the way north to {area:442}, the last {quest:4728} lies on the shore west of the Grove."] = "Auf dem Weg nach Norden nach {area:442} liegt die letzte {quest:4728} am Ufer westlich des Hains.",

	-- Step 12: Auberdine
	["Follow the road north."] = "Folge der Straße nach Norden.",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}: {npc:10219} bietet sie an, sobald alle neun gestrandeten Überreste abgegeben sind",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "Sie gibt dir die {item:15826}",

	-- Step 13: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {area:414} Zoram Strand · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["For your {area:2797} run, on the {area:414} in the next guide: {npc:8997} stands a short walk west of {npc:3693}."] = "Für deinen Run durch {area:2797}, am {area:414} im nächsten Guide: {npc:8997} steht ein kurzes Stück westlich von {npc:3693}.",

	-- Step 14: On the way
	["On the way"] = "Auf dem Weg",

	-- Step 15: The naga
	["The naga"] = "Die Naga",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics · {npc:270294} Baron Marinous
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore. Careful: {npc:270294}, an elite naga (21), walks the ruins among them: pull the naga away from him, or fight him at full health."] = "Folge der Küste nach Nordosten zum Gebiet {area:443}. {quest:951} liegen in den Ruinen; Myrmidonen, Zauberhexerinnen und Krieger der Sturmschuppen halten sie, und Tierbändigerinnen der Sturmschuppen laufen am Ufer entlang. Vorsicht: {npc:270294}, ein Elite-Naga (21), läuft zwischen ihnen durch die Ruinen: Zieh die Naga von ihm weg oder kämpfe mit voller Gesundheit gegen ihn.",

	-- Step 16: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "Zum Gebiet {area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} versteckt sich auf der kleinen Insel vor den Ruinen. Die Schlüsselteile droppen Riesige Waldschreiter (oben), Murlocs der Grauflossen (Mitte) und Tobende Riffkriecher (unten).",
	["Underwater"] = "Unter Wasser",

	-- Step 17: Strange Lockbox
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: die {object:177792} unter Wasser vor der Nordküste, westlich der Ruinen",

	-- Step 18: Mist's Edge: kill these as you meet them
	-- {area:452} Mist's Edge
	["{area:452}: kill these as you meet them"] = "{area:452}: Töte diese, wenn sie dir begegnen",

	-- Step 19: Back south
	["Back south"] = "Zurück nach Süden",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}, am Hain",

	-- Step 20: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive · {npc:3693} Terenthis · {area:442} Auberdine
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out. {npc:3693} takes the escort in {area:442} on the next visit there."] = "{npc:3692} versteckt sich in den Hügeln östlich von {area:449}. Hilf ihm zurück zur Straße; er kämpft sich unterwegs durch. {npc:3693} übernimmt die Eskorte in {area:442} bei deinem nächsten Besuch dort.",
	-- {npc:3692} Volcor · {area:455} Blackwood Den
	["{npc:3692}, inside {area:455}"] = "{npc:3692}, in {area:455}",
	["His walk ends at the road, where Grimclaw waits"] = "Sein Weg endet an der Straße, wo Grimclaw wartet",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: Benutze die {item:15826} an ihnen; sie streifen durch ganz {zone:1439}",
	-- {npc:12298} Sickly Deer
	["Cure {npc:12298}"] = "Heile {npc:12298}",

	-- Step 22: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Flugmeister von {area:442}",

	-- Step 23: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Nachtelfen fliegen von {area:442} nach {area:702}; Himmelsgeborene nehmen das Boot von der Anlegestelle in {area:442} und holen sich dort die Flugroute von Rut'theran. Nimm das Portal hinauf zu {npc:4217} im Gebiet {area:1658}.",

	-- Step 26: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Wirke {spell:18960}",

	-- Step 27: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "Wirke {spell:18960}. {npc:11802} steht oben in seinem Gebäude in {area:2361}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden. Lerne dort die Flugroute, falls du sie noch nicht hast.",

	-- Step 28: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} steht oben in seinem Gebäude in {area:2361}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:11802} Dendrite Starblaze · {npc:5504} Sheldras Moontree
	["{npc:11802}: the welcome from {npc:5504}"] = "{npc:11802}: der Willkommensgruß von {npc:5504}",

	-- Step 30: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Die Relikte der Grabhügel",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Nachtelfen) und der {npc:272054} (Himmelsgeborene) warten im Süden von {area:493}. Die drei Relikte liegen östlich davon in {area:2363}. Berichten aus den ersten Wochen zufolge gibt ein Relikt keine Beute, während ein anderer Spieler es plündert: Warte einen Moment und versuch es erneut.",

	-- Step 31: Trial of the Sea Lion
	-- {zone:1436} Westfall · {zone:1439} Darkshore · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["Both half pendants in your bags (the {zone:1436} half from your last {zone:1436} visit, the {zone:1439} half from the north coast): stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then take the pendant to {npc:11802} with the {spell:499} hand-in. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Beide Anhängerhälften in deinen Taschen (die Hälfte aus {zone:1436} von deinem letzten Besuch in {zone:1436}, die Hälfte aus {zone:1439} von der Nordküste): Stell dich an {area:2362} am Nordwestufer des Sees und benutze eine Hälfte, um sie zusammenzufügen; bring den Anhänger dann zusammen mit der Abgabe für {spell:499} zu {npc:11802}. {npc:11802} steht oben in seinem Gebäude: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: Füge die Hälften bei {area:2362} zusammen",
	-- {npc:11802} Dendrite Starblaze · {quest:5061} Aquatic Form · {npc:4217} Mathrengyl Bearwalker
	["{npc:11802}: {quest:5061}, for {npc:4217}"] = "{npc:11802}: {quest:5061}, für {npc:4217}",

	-- Step 32: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Zurück zu {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then {npc:11800} there flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Zurück zu {npc:11802} in {area:2361}, dann fliegt {npc:11800} dort Druiden direkt nach {area:702}. {npc:11802} steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 35: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1440} Ashenvale
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the road south to {zone:1440}. {npc:4217} is a Druid trainer: learn your new spells from him."] = "Nimm das Portal nach oben zu {npc:4217}, flieg dann zurück nach {area:442} für die Straße nach Süden in den {zone:1440}. {npc:4217} ist ein Druidenlehrer: Lerne deine neuen Zauber bei ihm.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Mondpirscherpatriarchen streifen durch die Wälder rund um die Gleve. Die {object:10076} und der {object:12666} stehen am Grund des Kraters; {npc:3584} steht an seiner Nordseite.",
	-- ["{npc:4217}: Cat Form"] = "{npc:4217}: Katzengestalt",
	-- ["{npc:4217}: Cure Poison"] = "{npc:4217}: Vergiftung heilen",
}
