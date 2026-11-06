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

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 2: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {npc:270459} Alfina Nightgaze · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}; {npc:270459} by the Skyborne Portal does not give this quest. Cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 3: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler · {area:442} Auberdine · {zone:1450} Moonglade
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to {area:442} (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "",

	-- Step 4: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from {area:442} to {area:445}. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "",

	-- Step 5: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}, at the north end of the village."] = "",

	-- Step 6: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} und {item:2449}",
	-- {area:442} Auberdine · {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of {area:442}; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "",

	-- Step 7: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "",

	-- Step 8: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale · {area:442} Auberdine · {spell:339} Entangling Roots · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the {area:456} to the {zone:1440} border, many around the Blackwood furbolg camp north-east of {area:442}. Druid trick: root a deer with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "",

	-- Step 9: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}."] = "",

	-- Step 10: Power over Poison
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the {area:1658}, teaches you {spell:8946}."] = "",

	-- Step 11: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {area:380} Crossroads · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the {area:380} sells {item:2449} later, or buy five on the Auction House now."] = "",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "",

	-- Step 12: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "",

	-- Step 13: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the {area:380} head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "",

	-- Step 14: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}; Kräuterkundige pflücken es in den Ebenen",

	-- Step 15: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} und Kodohörner",
	-- {npc:3234} Lost Barrens Kodo · {area:382} Sludge Fen · {area:388} Stagnant Oasis · {area:380} Crossroads · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the {area:380}. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "",

	-- Step 16: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "",

	-- Step 17: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Kränkliche Gazellen",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads · {zone:1440} Ashenvale · {area:392} Ratchet · {spell:339} Entangling Roots · {npc:3448} Tonga Runetotem
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the {area:380} up to the {zone:1440} border, north-west of the {area:380} and west of {area:392}. Druid trick: root a gazelle with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "",
	-- {item:15826} Curative Animal Salve
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles"] = "",

	-- Step 18: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "",

	-- Step 19: Power over Poison
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:8946} Cure Poison
	["{npc:3033} on {area:1639} teaches you {spell:8946}."] = "",

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
