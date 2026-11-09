-- German (deDE): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "{spell:8946} wird in Forever nicht mehr gelehrt: Diese Questreihe bringt es dir bei, mit einem Medizinbeutel unterwegs.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217} steht oben im Druidengebäude der {area:1658}. Kein {skill:182}? Kauf zuerst fünf {item:2449} im Auktionshaus: Du brauchst sie später.",

	-- Step 3: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {npc:270459} Alfina Nightgaze · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}; {npc:270459} by the Skyborne Portal does not give this quest. Cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217} steht oben im Druidengebäude der {area:1658}; {npc:270459} am Portal der Himmelsgeborenen gibt diese Quest nicht. Wirke {spell:18960} und nimm den Flug von {npc:11800} aus der Mitte von {area:2361} (sie fliegt Druiden nach {area:702}, keine Flugroute nötig), dann das Portal nach oben. Kein {skill:182}? Kauf zuerst fünf {item:2449} im Auktionshaus: Du brauchst sie später.",

	-- Step 5: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler · {area:442} Auberdine · {zone:1450} Moonglade
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to {area:442} (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "Wirke {spell:18960}: {npc:11802} steht oben im Gebäude neben dir. Er gibt dir {item:15844}. Flieg dann nach {area:442} (lerne vorher die Flugroute {zone:1450} bei Sindrayl, falls du sie noch nicht hast).",

	-- Step 6: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from {area:442} to {area:445}. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "Geh von {area:442} nach Nordosten zu {area:445}. Stell dich an den Höhleneingang oben am Wasserfall, nicht in den Fluss darunter, und benutze {item:15844} (nicht {item:12350} einer anderen Quest). Naga säumen den Aufstieg, ein Zauberwirker wartet am anderen Ufer, und das Füllen der Probenflasche ruft zwei weitere (einen Wave Rider und einen Toxicologist, Stufe 15): Räum zuerst den Weg frei und sei kampfbereit.",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "{item:15844}, am Höhleneingang",

	-- Step 7: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}, at the north end of the village."] = "Zurück in {area:442}, am Nordende des Dorfes.",

	-- Step 8: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} und {item:2449}",
	-- {area:442} Auberdine · {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of {area:442}; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "Die Lunar Fungal Blooms sind winzige weiß gefleckte Pilze auf dem Boden und an den Wänden der kleinen Moonkin-Höhlen in den Hügeln östlich und südöstlich von {area:442}; jede gibt ein oder zwei Pilze, und jede Höhle hat nur wenige, also geh von Höhle zu Höhle (sie wachsen nach drei Minuten nach). Die Moonkin dort sind reizbar. Für die Blooms brauchst du kein {skill:182}. {item:2449} braucht {skill:182}: Kräuterkundler pflücken sie überall in {zone:1439}, alle anderen kaufen sie ({npc:1313} oder {npc:1302} in {zone:1453}, oder im Auktionshaus).",

	-- Step 9: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "Sie gibt dir {item:15826}: zehn Dosen, eine pro Hirsch. Zerstöre übrig gebliebenen {item:15851}.",

	-- Step 10: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale · {area:442} Auberdine · {spell:339} Entangling Roots · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the {area:456} to the {zone:1440} border, many around the Blackwood furbolg camp north-east of {area:442}. Druid trick: root a deer with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "Benutze {item:15826} an lebenden {npc:12298} (Stufe 5, eine grüne Wolke über ihnen): Sie streifen durch {zone:1439} vom {area:456} bis zur Grenze zu {zone:1440}, viele rund um das Blackwood-Furbolglager nordöstlich von {area:442}. Druidentrick: Wurzle einen Hirsch mit {spell:339}, trag die Salbe auf, bevor die Wurzeln ticken, und der Wurzel-Kill zählt ein zweites Mal. Eine Dosis an einem Hirsch verloren, der nicht gezählt hat? Brich die Quest ab und nimm sie bei {npc:3702} noch einmal an, um eine frische Salbe zu bekommen.",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "Benutze {item:15826} an {npc:12298}",

	-- Step 11: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Wirke {spell:18960} und besuche {npc:11802}, nimm dann den Flug von {npc:11800} aus der Mitte von {area:2361} (sie fliegt Druiden nach {area:702}, keine Flugroute nötig) und das Portal nach oben nach {zone:1457}. {npc:11802} steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 12: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the {area:1658}, teaches you {spell:8946}."] = "{npc:4217}, oben in der {area:1658}, bringt dir {spell:8946} bei.",

	-- Step 14: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the Crossroads sells {item:2449} later, or buy five on the Auction House now."] = "{npc:3033} steht in der Druidenhütte auf {area:1639}; {npc:262560}, der Druidenlehrer der Himmelsgeborenen, wo das Luftschiff von Zephras Isle im Norden von {zone:1412} landet, gibt dieselbe Quest. Kein {skill:182}? {npc:3490} in Crossroads verkauft später {item:2449}, oder kauf jetzt fünf im Auktionshaus.",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "{npc:3033}, oder {npc:262560} im Norden von {zone:1412}",

	-- Step 15: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the Crossroads from there."] = "Wirke {spell:18960}: {npc:11802} steht oben im Gebäude neben dir. Er gibt dir {item:15842}. {npc:11798} fliegt Druiden nach {area:1638}; flieg von dort weiter nach Crossroads.",

	-- Step 16: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the Crossroads head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "Geh von Crossroads nach Norden zu {area:384} und klettere zu dem sprudelnden {object:19464} auf dem Gipfel. Kultisten der Burning Blade lagern darum: Pull sie einzeln oder zu zweit. Stell dich ins Wasser und benutze {item:15842}: Drei Toxikologen der Burning Blade (Stufe 13-14, Flüche und Hexenmeisterzauber) erscheinen und greifen an. Du musst sie nicht töten: Sobald die Probenflasche voll ist, lauf weg.",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "{item:15842}, im Teich stehend",

	-- Step 17: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the Crossroads. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "{npc:3448} steht in Crossroads. Kein {skill:182}? {npc:3490}, ein paar Schritte entfernt beim Windreitermeister, verkauft {item:2449} für 80 Kupfer das Stück, je drei, bis er wieder Nachschub hat.",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}; Kräuterkundige pflücken es in den Ebenen",

	-- Step 18: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} und Kodohörner",
	-- {npc:3234} Lost Barrens Kodo · {area:382} Sludge Fen · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the Crossroads. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Jeder {npc:3234} (Stufe 14-15) lässt ein Horn fallen, aber sie sind selten und wandern umher: Such im hohen Norden nahe {area:382} und bei den Oasen, vor allem an der {area:388} südöstlich der Crossroads. Sie greifen aus der Entfernung an und trampeln. Kräuterkundler finden {item:2449} überall im Norden von {zone:1413}.",

	-- Step 19: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "Er gibt dir {item:15826}: zehn Dosen, eine pro Gazelle.",

	-- Step 20: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Kränkliche Gazellen",
	-- {item:15826} Curative Animal Salve · {zone:1440} Ashenvale · {area:392} Ratchet · {spell:339} Entangling Roots · {npc:3448} Tonga Runetotem
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the Crossroads up to the {zone:1440} border, north-west of the Crossroads and west of {area:392}. Druid trick: root a gazelle with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "Benutze {item:15826} an lebenden Sickly Gazelles (Stufe 3): Sie grasen auf beiden Seiten der Straße nördlich der Crossroads bis zur Grenze zu {zone:1440}, nordwestlich der Crossroads und westlich von {area:392}. Druidentrick: Wurzle eine Gazelle mit {spell:339}, trag die Salbe auf, bevor die Wurzeln ticken, und der Wurzel-Kill zählt ein zweites Mal, sodass fünf Gazellen reichen können. Eine Dosis verloren? Brich die Quest ab und nimm sie bei {npc:3448} noch einmal an, um eine frische Salbe zu bekommen.",
	-- {item:15826} Curative Animal Salve
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles"] = "Benutze {item:15826} an Sickly Gazelles",

	-- Step 21: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Wirke {spell:18960} und besuche {npc:11802}, nimm dann den Flug von {npc:11798} nach {area:1638}. {npc:11802} steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 22: Power over Poison
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:8946} Cure Poison
	["{npc:3033} on {area:1639} teaches you {spell:8946}."] = "{npc:3033} auf {area:1639} bringt dir {spell:8946} bei.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:442}."] = "Zurück in {area:442}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Wirke {spell:18960} und sprich mit {npc:11802}, flieg dann nach {area:702} und nimm das Portal hinauf nach {zone:1457}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Wirke {spell:18960} und sprich mit {npc:11802}, nimm dann den Flug von {npc:11798} nach {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}. Flieg dann nach {area:442}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}. {npc:11798} fliegt Druiden nach {area:1638}; flieg von dort weiter nach {area:380}.",
	-- ["From the {area:380} head north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Geh vom {area:380} nach Norden zum {area:384} und fülle {item:15842} am Teich am Glutnebelgipfel.",
	-- ["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Reite von {area:380} nach Norden zum {area:384} und fülle den {item:15842} am {object:19464}.",
	-- ["Head north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Geh von {area:442} nach Nordosten zu den {area:445} und fülle {item:15844} am Eingang der Höhle bei den Fällen.",
	-- ["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Verirrte Brachlandkodos streifen durch die Ebenen nördlich und westlich von {area:380} und um {area:388}; jeder lässt ein Horn fallen. Kräuterkundige finden {item:2449} überall im nördlichen {zone:1413}.",
	-- ["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Reite von {area:442} nach Nordosten zu den {area:445} und fülle den {item:15844} am Höhleneingang bei den Wasserfällen.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Die Lunarfungusblüten wachsen in den Mondkinhöhlen in den Hügeln gleich östlich von {area:442}; die Mondkin dort sind reizbar. {item:2449} erfordert {skill:182}: Kräuterkundige pflücken es überall in {zone:1439}, alle anderen kaufen es bei {npc:1313} (Alchemiebedarf) in {zone:1453} oder im Auktionshaus.",
	-- ["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Benutze die {item:15826} an Kränklichen Gazellen: Sie grasen nördlich der Straße, die von Ost nach West durch {area:380} führt.",
	-- ["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Benutze die {item:15826} an {npc:12298}. Sie streifen durch {zone:1439}, vom {area:456} im Norden bis zur Grenze von {zone:1440} im Süden.",
	-- ["{npc:12296}: use the salve on them"] = "{npc:12296}: Benutze die Salbe an ihnen",
	-- ["{npc:12298}: use the salve on them"] = "{npc:12298}: Benutze die Salbe an ihnen",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} steht auf der {area:1639}.",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} steht in {area:380}. Kein {skill:182}? {npc:3490}, ein paar Schritte entfernt, verkauft {item:2449}, je drei, bis er nachfüllt.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} steht im {area:1658}.",
}
