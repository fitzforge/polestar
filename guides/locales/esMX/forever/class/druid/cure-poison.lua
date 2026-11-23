-- Spanish (Latin America) (esMX): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "{spell:8946} ya no se aprende con el instructor en Forever: esta cadena te lo enseña, con una bolsa de medicinas por el camino.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217} está en el piso de arriba del edificio de los druidas de {area:1658}. ¿No tienes {skill:182}? Compra antes cinco {item:2449} en la casa de subastas: las necesitas más adelante.",

	-- Step 3: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {npc:270459} Alfina Nightgaze · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}; {npc:270459} by the Skyborne Portal does not give this quest. Cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217} está en el piso de arriba del edificio de los druidas de {area:1658}; {npc:270459}, junto al portal Skyborne, no da esta misión. Lanza {spell:18960} y toma el vuelo de {npc:11800} desde el centro de {area:2361} (lleva a los druidas a {area:702}, no hace falta ruta de vuelo), luego el portal hacia arriba. ¿No tienes {skill:182}? Compra antes cinco {item:2449} en la casa de subastas: las necesitas más adelante.",

	-- Step 5: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler · {area:442} Auberdine · {zone:1450} Moonglade
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to {area:442} (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "Lanza {spell:18960}: {npc:11802} está en el piso de arriba del edificio a tu lado. Te da {item:15844}. Luego vuela a {area:442} (aprende antes la ruta de vuelo de {zone:1450} con Sindrayl si no la tienes).",

	-- Step 6: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from {area:442} to {area:445}. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "Ve al noreste desde {area:442} hasta {area:445}. Párate en la entrada de la cueva arriba de la cascada, no en el río de abajo, y usa {item:15844} (no {item:12350} de otra misión). Hay nagas a lo largo de la subida, un lanzador de hechizos espera en la orilla opuesta, y llenar el muestreador llama a dos más (un jinete de las olas y un toxicólogo, nivel 15): despeja el camino antes y prepárate para pelear.",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "{item:15844}, en la entrada de la cueva",

	-- Step 7: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}, at the north end of the village."] = "De vuelta en {area:442}, en el extremo norte del pueblo.",

	-- Step 8: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} y {item:2449}",
	-- {area:442} Auberdine · {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of {area:442}; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "Las flores fúngicas lunares son hongos diminutos con puntos blancos en el suelo y las paredes de las pequeñas cuevas de lechúcicos lunares en las colinas justo al este y sureste de {area:442}; cada una da uno o dos hongos, y cada cueva tiene solo unas pocas, así que ve de cueva en cueva (vuelven a crecer en tres minutos). Los lechúcicos lunares de ahí son irritables. No hace falta {skill:182} para las flores. {item:2449} necesita {skill:182}: los herboristas la recogen por todo {zone:1439}, los demás la compran ({npc:1313} o {npc:1302} en {zone:1453}, o la casa de subastas).",

	-- Step 9: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "Te da {item:15826}: diez dosis, una por ciervo. Destruye los {item:15851} que te sobren.",

	-- Step 10: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale · {area:442} Auberdine · {spell:339} Entangling Roots · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the {area:456} to the {zone:1440} border, many around the Blackwood furbolg camp north-east of {area:442}. Druid trick: root a deer with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "Usa {item:15826} sobre {npc:12298} vivos (nivel 5, con una nube verde encima): recorren {zone:1439} desde {area:456} hasta la frontera con {zone:1440}, muchos alrededor del campamento fúrbolg Bosque Negro al noreste de {area:442}. Truco de druida: enraíza a un ciervo con {spell:339}, aplica el ungüento antes de que las raíces hagan daño, y la muerte por raíces cuenta una segunda vez. ¿Perdiste una dosis en un ciervo que no contó? Abandona la misión y vuelve a tomarla con {npc:3702} para un ungüento nuevo.",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "Usa {item:15826} sobre {npc:12298}",

	-- Step 11: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lanza {spell:18960} y ve a {npc:11802}, luego toma el vuelo de {npc:11800} desde el centro de {area:2361} (lleva a los druidas a {area:702}, no hace falta ruta de vuelo) y el portal hacia arriba a {zone:1457}. {npc:11802} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 12: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the {area:1658}, teaches you {spell:8946}."] = "{npc:4217}, en el piso de arriba de {area:1658}, te enseña {spell:8946}.",

	-- Step 14: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the Crossroads sells {item:2449} later, or buy five on the Auction House now."] = "{npc:3033} está en la choza de los druidas en {area:1639}; {npc:262560}, la instructora de druidas Skyborne donde aterriza el barco aéreo desde la isla Zephras, en el norte de {zone:1412}, da la misma misión. ¿No tienes {skill:182}? {npc:3490}, en el Cruce, vende {item:2449} más adelante, o compra cinco ahora en la casa de subastas.",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "{npc:3033}, o {npc:262560} en el norte de {zone:1412}",

	-- Step 15: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the Crossroads from there."] = "Lanza {spell:18960}: {npc:11802} está en el piso de arriba del edificio a tu lado. Te da {item:15842}. {npc:11798} lleva a los druidas a {area:1638}; desde ahí sigue volando al Cruce.",

	-- Step 16: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the Crossroads head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "Desde el Cruce ve al norte hasta {area:384} y sube hasta {object:19464}, que burbujea en la cima. Sectarios del Filo Ardiente acampan alrededor: atráelos de a uno o dos. Párate en el agua y usa {item:15842}: aparecen tres toxicólogos del Filo Ardiente (nivel 13-14, maldiciones y hechizos de brujo) y atacan. No hace falta matarlos: cuando el muestreador esté lleno, corre.",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "{item:15842}, parado en la poza",

	-- Step 17: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the Crossroads. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "{npc:3448} está en el Cruce. ¿No tienes {skill:182}? {npc:3490}, a pocos pasos junto al maestro de jinetes del viento, vende {item:2449} a 80 de cobre cada una, de a tres hasta que repone.",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}; los herboristas la recogen en las llanuras",

	-- Step 18: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} y cuernos de kodo",
	-- {npc:3234} Lost Barrens Kodo · {area:382} Sludge Fen · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the Crossroads. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Todos los {npc:3234} (nivel 14-15) sueltan un cuerno, pero son pocos y deambulan: busca en el extremo norte cerca de {area:382} y en los oasis, sobre todo {area:388}, al sureste del Cruce. Cargan desde lejos y pisotean. Los herboristas encuentran {item:2449} por todo el norte de {zone:1413}.",

	-- Step 19: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "Te da {item:15826}: diez dosis, una por gacela.",

	-- Step 20: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Gacelas enfermas",
	-- {item:15826} Curative Animal Salve · {zone:1440} Ashenvale · {area:392} Ratchet · {spell:339} Entangling Roots · {npc:3448} Tonga Runetotem
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the Crossroads up to the {zone:1440} border, north-west of the Crossroads and west of {area:392}. Druid trick: root a gazelle with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "Usa {item:15826} sobre gacelas enfermizas vivas (nivel 3): pastan a ambos lados del camino al norte del Cruce hasta la frontera con {zone:1440}, al noroeste del Cruce y al oeste de {area:392}. Truco de druida: enraíza a una gacela con {spell:339}, aplica el ungüento antes de que las raíces hagan daño, y la muerte por raíces cuenta una segunda vez, así que alcanza con cinco gacelas. ¿Perdiste una dosis? Abandona y vuelve a tomar la misión con {npc:3448} para un ungüento nuevo.",
	-- {item:15826} Curative Animal Salve
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles"] = "Usa {item:15826} sobre gacelas enfermizas",

	-- Step 21: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lanza {spell:18960} y ve a {npc:11802}, luego toma el vuelo de {npc:11798} a {area:1638}. {npc:11802} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 22: Power over Poison
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:8946} Cure Poison
	["{npc:3033} on {area:1639} teaches you {spell:8946}."] = "{npc:3033}, en {area:1639}, te enseña {spell:8946}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:442}."] = "De vuelta en {area:442}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lanza {spell:18960} y habla con {npc:11802}; luego vuela a {area:702} y toma el portal para subir a {zone:1457}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lanza {spell:18960} y habla con {npc:11802}; luego toma el vuelo de {npc:11798} a {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. Luego vuela a {area:442}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. {npc:11798} lleva a los druidas a {area:1638}; desde allí sigue volando a {area:380}.",
	-- ["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Desde {area:380}, cabalga al norte hasta {area:384} y llena {item:15842} en {object:19464}.",
	-- ["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Los Kodos de Los Baldíos perdidos ({npc:3234}) deambulan por las llanuras al norte y al oeste de {area:380} y alrededor de {area:388}; cada uno suelta un cuerno. Los herboristas encuentran {item:2449} por todo el norte de {zone:1413}.",
	-- ["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Cabalga al noreste desde {area:442} hasta {area:445} y llena {item:15844} en la boca de la cueva junto a la cascada.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Las Flores de hongo lunar ({object:177750}) crecen en las cuevas de lechúcicos lunares de las colinas justo al este de {area:442}; los lechúcicos lunares de allí son irritables. {item:2449} requiere {skill:182}: los herboristas la recogen por todo {zone:1439}; los demás la compran a {npc:1313} (suministros de alquimia) en {zone:1453} o en la casa de subastas.",
	-- ["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Usa {item:15826} en las gacelas enfermas: pastan al norte del camino que cruza {area:380} de este a oeste.",
	-- ["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Usa {item:15826} en {npc:12298}. Deambulan por {zone:1439} desde {area:456} en el norte hasta la frontera de {zone:1440} en el sur.",
	-- ["{npc:12296}: use the salve on them"] = "{npc:12296}: usa el ungüento en ellas",
	-- ["{npc:12298}: use the salve on them"] = "{npc:12298}: usa el ungüento en ellos",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} está en {area:1639}.",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} está en {area:380}. ¿No tienes {skill:182}? {npc:3490}, a pocos pasos, vende {item:2449}, de tres en tres hasta que reponga.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} está en {area:1658}.",
}
