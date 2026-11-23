-- Spanish (Latin America) (esMX): the guide forever/40-50/shendralas (forever/40-50/shendralas.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1444} Feralas
	["About a dozen quests on a short trip into Forever's new zone (about 45-46 for the Alliance, 47 for the Horde), then on to {zone:1444}."] = "Unas doce misiones en una breve visita a la nueva zona de Forever (nivel 45-46 para la Alianza, 47 para la Horda), y luego a {zone:1444}.",

	-- Step 1: North into Desolace
	-- {area:405} Desolace
	["North into {area:405}"] = "Al norte hacia {area:405}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:1099} Camp Mojache · {area:2577} Dire Maul
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. From {area:1099} ride north-west on the road past {area:2577} and on north into {area:405}: the road comes out on {area:405}'s southern edge."] = "Nuevo en Forever: esta guía sigue lo que hicieron los jugadores en {zone:2652}. Si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\n{zone:2652} está al sur de {area:405}, pasando por {area:2657}, y no tiene ruta de vuelo propia. Desde {area:1099}, ve al noroeste por el camino pasando {area:2577} y sigue al norte hasta {area:405}: el camino sale en el borde sur de {area:405}.",
	-- {area:405} Desolace · {zone:1444} Feralas
	["{area:405}, where the road from {zone:1444} comes in"] = "{area:405}, donde entra el camino desde {zone:1444}",

	-- Step 2: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Vuela a {area:2408}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the zeppelin to {zone:1454} first (from {object:3202} or the {zone:1458})."] = "Nuevo en Forever: esta guía sigue lo que hicieron los jugadores en {zone:2652}. Si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\n{zone:2652} está al sur de {area:405}, pasando por {area:2657}, y no tiene ruta de vuelo propia. Sus misiones son de nivel 41-45. Si vienes de los Reinos del Este, toma primero el zepelín a {zone:1454} (desde {object:3202} o desde {zone:1458}).",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 3: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "Vuela a {area:608}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:150} Menethil Harbor
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the boat from {area:150} to Theramore first."] = "Nuevo en Forever: esta guía sigue lo que hicieron los jugadores en {zone:2652}. Si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\n{zone:2652} está al sur de {area:405}, pasando por {area:2657}, y no tiene ruta de vuelo propia. Sus misiones son de nivel 41-45. Si vienes de los Reinos del Este, toma primero el barco de {area:150} a Theramore.",

	-- Step 4: Into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Into the {area:2657}"] = "Hacia {area:2657}",
	-- {area:405} Desolace · {area:2408} Shadowprey Village · {area:606} Gelkis Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride east along {area:405}'s southern edge (from {area:2408}: past {area:606}): the {area:2657} opens there into {area:16651}."] = "Ve al este por el borde sur de {area:405} (desde {area:2408}: pasando {area:606}): allí {area:2657} se abre hacia {area:16651}.",

	-- Step 5: Into the Valley of Bones
	-- {area:608} Nijel's Point · {area:405} Desolace · {area:604} Magram Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride south from {area:608} down the road through eastern {area:405} to {area:604}: just past its western edge the path climbs into the {area:2657} and {area:16651}."] = "Ve al sur desde {area:608} por el camino del este de {area:405} hasta {area:604}: justo pasando su borde oeste, el sendero sube hacia {area:2657} y {area:16651}.",

	-- Step 6: The Valley of Bones: a Tattered Journal
	-- {area:2657} Valley of Bones · {quest:93644} Tattered Journal
	["The {area:2657}: a {quest:93644}"] = "{area:2657}: {quest:93644}",
	-- {quest:93644} Tattered Journal · {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	-- plural, as words: Outcast Necromancers = {npc:11559} Outcast Necromancer · Magram Necromancers = {npc:253272} Magram Necromancer
	-- was: ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Nuevo en Forever: si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\nLos Necrománticos parias y los Necrománticos Magram del valle sueltan {quest:93644}, cuyo autor vive en {zone:2652}: los jugadores lo obtuvieron tras pocas muertes. Los centauros Magram no te atacan a menos que los ataques; los Necrokhans Magram entre ellos (nivel 45) son élite: déjalos en paz.\nLos centauros Gelkis y Magram tienen sus propias cadenas de misiones en {area:2657}, que dan unos 20,000 a 30,000 de experiencia más, pero cada cadena pide Honorable con su clan. Los dos clanes son rivales, así que trabaja para uno: la guía de Reputación de los centauros Gelkis y Magram, en Reputación, explica cómo."
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. Take it from the Outcast Necromancers and leave the Magram alone: the Magram centaurs leave you be until you attack, but once you have killed Magram the whole clan turns on you, and their Necrokhans (level 45, elites) stand around the western pylon you repair later.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "",

	-- Step 7: The western pylon
	["The western pylon"] = "El pilón del oeste",
	-- {quest:92914} Strange Pylons
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here.\nCareful: click the crystal from the road on its west side and move on: the Protectors stand two and three together east and north-east of it, where Corpsefeeders and the Magram Necrokhans (elites, 45) walk too."] = "",

	-- Step 8: Bristleback Retreat: the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: the eastern pylon"] = "{area:16677}: el pilón del este",
	-- {area:16677} Bristleback Retreat · {npc:253527} Kog'thug the Brave
	["East along the valley road to the quilboar of {area:16677}: the second pylon stands at the eastern end of their camp. A Corpsefeeder (level 45, elite) walks this road: let it pass. The Bristlebacks (levels 42-43) attack on sight; {npc:253527} (level 43, elite) and his bodyguards hold the south side of the camp."] = "Ve al este por el camino del valle hasta los jabaespines de {area:16677}: el segundo pilón está en el extremo este de su campamento. Un Devoracadáveres (élite de nivel 45) recorre este camino: déjalo pasar. Los Erizapúas (nivel 42-43) atacan al verte; {npc:253527} (élite de nivel 43) y sus guardaespaldas ocupan el lado sur del campamento.",
	["the eastern pylon"] = "el pilón del este",

	-- Step 9: The temple of Shen'dralas: the third pylon
	-- {zone:2652} Shen'dralas
	["The temple of {zone:2652}: the third pylon"] = "El templo de {zone:2652}: el tercer pilón",
	["South to the Shen'dralar temple at the zone's heart, keeping west of Kog'thug's bodyguards: the third pylon stands inside. The temple's guards are neutral: leave them be."] = "Ve al sur hasta el templo Shen'dralar en el corazón de la zona, manteniéndote al oeste de los guardaespaldas de Kog'thug: el tercer pilón está dentro. Los guardias del templo son neutrales: déjalos en paz.",

	-- Step 10: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93644} Tattered Journal
	["North-west from the temple to {npc:253471}'s camp on the overlook, beside the spirit healer: the {quest:93644} is his, and he wants to hear about the pylons."] = "Ve al noroeste desde el templo hasta el campamento de {npc:253471} en el mirador, junto al ángel de la resurrección: {quest:93644} es suyo, y quiere saber de los pilones.",

	-- Step 11: North into Desolace
	-- {npc:253471} Mordent Evenshade · {area:405} Desolace · {area:604} Magram Village
	["{npc:253471} wants a fragment and a shard of the pylons back from {area:405}'s two centaur villages: {area:604} lies just beyond the valley's northern way out.\nCareful: if you have killed Magram or Gelkis centaurs, that clan's guards may attack you when you walk into its village."] = "{npc:253471} quiere recuperar un fragmento y una esquirla de los pilares de las dos aldeas centauro de {area:405}: {area:604} está justo después de la salida norte del valle.\nCuidado: si has matado centauros Magram o Gelkis, los guardias de ese clan pueden atacarte al entrar en su aldea.",

	-- Step 12: Magram Village
	-- {item:255656} Pylon Fragment
	-- plural, as words: Magram Guardians = {npc:255560} Magram Guardian
	["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it. They leave you be unless you have fought the Magram: pick the fragment up without a fight. Every Magram you kill turns the clan against you, and back in the valley that means the Necrokhans (level 45, elites) at the western pylon as well."] = "",

	-- Step 13: Gelkis Village
	-- {area:405} Desolace · {area:606} Gelkis Village · {item:255657} Pylon Shard
	-- plural, as words: Gelkis Guardians = {npc:255561} Gelkis Guardian
	["West along {area:405}'s southern edge to {area:606}: the {item:255657} lies at its southern end, watched by Gelkis Guardians (levels 39-41)."] = "Al oeste por el borde sur de {area:405} hasta {area:606}: el {item:255657} está en su extremo sur, vigilado por Guardianes Gelkis (niveles 39-41).",

	-- Step 14: Back into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Back into the {area:2657}"] = "De vuelta a {area:2657}",
	-- {area:405} Desolace · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["East again along {area:405}'s southern edge: the {area:2657} opens into {area:16651}."] = "De nuevo al este por el borde sur de {area:405}: {area:2657} desemboca en {area:16651}.",

	-- Step 16: The temple: the Mana Sieve
	-- {item:255662} Mana Sieve
	["The temple: the {item:255662}"] = "El templo: la {item:255662}",
	-- {npc:253471} Mordent Evenshade · {item:255662} Mana Sieve · {npc:255486} Historian Biraxas · {quest:96018} Powering the Pylons
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{npc:253471} sends you for the {item:255662}, kept inside the temple beside {npc:255486}. {quest:96018} asks you to gather mana with the Sieve before you repair the pylons: with it in your bags you can handle the Unstable Mana Rifts, the floating sparks of mana all along the road north."] = "{npc:253471} te envía por la {item:255662}, guardada dentro del templo junto a {npc:255486}. {quest:96018} te pide recolectar maná con la criba antes de reparar los pilares: con ella en tus bolsas puedes manipular las Fisuras de maná inestables, las chispas de maná flotantes a lo largo del camino hacia el norte.",

	-- Step 17: Unstable Mana Rifts: mana for the western pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Unstable Mana Rifts: mana for the western pylon"] = "",
	-- {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["Use the {item:255662} on the Unstable Mana Rifts, the floating sparks along the road north: each pylon takes four Coalesced Mana Crystals, and the repair uses them up."] = "",
	-- {item:255667} Coalesced Mana Crystal · {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{item:255667}, from the Unstable Mana Rifts with the {item:255662}"] = "",

	-- Step 18: The road south of the western pylon
	["The road south of the western pylon"] = "",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Magram Necrokhans = {npc:253274} Magram Necrokhan · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Stop where the arrow points, on the road just south of the pylon, keeping to its west edge: the quiet side, with no Protectors behind you. Pull one {npc:252711} at a time down to that spot, the one nearest the pylon's south side first, and kill it there; then step up to the pylon's west side and use {spell:1289727}, as players did to repair it.\nCareful: stay off the pylon's east and north-east side. The Protectors stand there two and three together, a Corpsefeeder (level 45, elite) walks among them and the Magram Necrokhans (elites, 45) stand just beyond: nearly every recorded death at this pylon happened east of it. If the Magram attack you (they do once you have killed Magram), wait at the arrow until any Necrokhan by the pylon walks off before you pull. Nascent Pylon Protectors (elites, 43) wander the road south of it: let them pass.\nIf you die here, walk your ghost back to the arrow before you come back to life: players who rose beside the pylon died again within seconds."] = "",
	["the road just south of the western pylon"] = "",

	-- Step 19: The western pylon: repair it
	["The western pylon: repair it"] = "El pilar occidental: repáralo",
	["Pull a single Protector down to the road, then repair the pylon from its west side."] = "",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	["{npc:252711}, pulled to the arrow's spot, then {spell:1289727} on the pylon's west side"] = "",

	-- Step 20: Unstable Mana Rifts: mana for the eastern pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Unstable Mana Rifts: mana for the eastern pylon"] = "",
	-- {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["The western repair used up your crystals: on the way east, use the {item:255662} on the Unstable Mana Rifts again for four more Coalesced Mana Crystals."] = "",

	-- Step 21: Bristleback Retreat: repair the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: repair the eastern pylon"] = "{area:16677}: repara el pilar oriental",
	-- {npc:252711} Decrepit Pylon Protector · {npc:253527} Kog'thug the Brave
	["East along the valley road to the eastern pylon and repair it the same way, a {npc:252711} first, coming in from the west: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "Ve al este por el camino del valle hasta el pilar oriental y repáralo igual, primero un {npc:252711}, entrando desde el oeste: {npc:253527} (élite de nivel 43) y sus guardaespaldas ocupan el lado sur del campamento de jabaespines, y un Devoracadáveres (élite de nivel 45) recorre el camino.",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	["{npc:252711}, then {spell:1289727} on it"] = "{npc:252711}, luego {spell:1289727} sobre él",

	-- Step 22: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93016} A Brief History Lesson
	["Back west along the valley road and south to {npc:253471}. {quest:93016} asks you to hear him out: talk to him once more, then hand it in."] = "Vuelve al oeste por el camino del valle y luego al sur hasta {npc:253471}. {quest:93016} te pide escucharlo: habla con él una vez más y luego entrégala.",
	-- {npc:253471} Mordent Evenshade
	["{npc:253471}: hear him out"] = "{npc:253471}: escúchalo",

	-- Step 23: Liranne
	-- {quest:93568} Partially Digested Collar · {npc:255385} Liranne
	["A Prowler gave up a {quest:93568}: {npc:255385}, north of the temple, knows whose it was."] = "Un merodeador soltó un {quest:93568}: {npc:255385}, al norte del templo, sabe de quién era.",

	-- Step 24: The temple: Magister Kirandis
	-- {npc:254656} Magister Kirandis
	["The temple: {npc:254656}"] = "El templo: {npc:254656}",
	-- {npc:254656} Magister Kirandis · {npc:254578} Mithera · {quest:93341} Forlorn Gardens
	["{npc:254656} waits inside the temple. Then {npc:254578}, on the temple's eastern side, has work in the {quest:93341}."] = "{npc:254656} espera dentro del templo. Luego {npc:254578}, en el lado este del templo, tiene trabajo en {quest:93341}.",

	-- Step 25: The Forlorn Gardens: the pedestal
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}: the pedestal"] = "{quest:93341}: el pedestal",
	-- {quest:93341} Forlorn Gardens
	["East of the temple the {quest:93341} have run wild, and their plants attack on sight. Examine the pedestal at the gardens' southern end."] = "Al este del templo, {quest:93341} se han vuelto salvajes y sus plantas atacan a la vista. Examina el pedestal en el extremo sur de los jardines.",

	-- Step 27: The Forlorn Gardens
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}"] = "{quest:93341}",
	-- {npc:254674} Woodwyrd · {area:2100} Maraudon
	-- plural, as words: Rowdy Roses = {npc:254566} Rowdy Rose · Terrible Tulips = {npc:254567} Terrible Tulip · Malevolent Marigolds = {npc:254572} Malevolent Marigold · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Rowdy Roses and Terrible Tulips grow all over the gardens; the Malevolent Marigolds keep to the northern part. {npc:254674}, the treant in the middle of the gardens, has a request of his own that needs water from {area:2100}, a dungeon: this guide leaves it.\nThe Shen'dralar who wander the gardens are neutral, like the temple's guards: leave them be and pull the flowers away from them. Careful: Nascent Pylon Protectors (elites, 43) wander the zone's middle, the gardens too: keep clear of them."] = "Las rosas alborotadoras y los tulipanes terribles crecen por todos los jardines; las caléndulas malévolas se quedan en la parte norte. {npc:254674}, el antárbol en el centro de los jardines, tiene un encargo propio que necesita agua de {area:2100}, un calabozo: esta guía lo omite.\nLos Shen'dralar que deambulan por los jardines son neutrales, como los guardias del templo: déjalos en paz y aleja a las flores de ellos. Cuidado: los protectores de pilar nacientes (élites, 43) deambulan por el centro de la zona, también por los jardines: mantente lejos de ellos.",

	-- Step 28: Mithera
	-- {npc:255486} Historian Biraxas · {npc:254656} Magister Kirandis · {npc:252711} Decrepit Pylon Protector
	["{npc:255486}, inside the temple, has a task for you now that you have met {npc:254656}: the heart of a {npc:252711} (42-43, not elite), a short ride back up the road north."] = "{npc:255486}, dentro del templo, tiene una tarea para ti ahora que conociste a {npc:254656}: el corazón de un {npc:252711} (42-43, no élite), a poca distancia de vuelta por el camino al norte.",

	-- Step 29: A Heart of Crystal
	-- {npc:252711} Decrepit Pylon Protector
	["Use the west face of the western pylon, where you repaired it. Approach on the road from the south and pull one {npc:252711} back to you. Wait for the elite patrols to pass; do not follow a Protector around the east side."] = "",

	-- Step 31: Mana Mania
	-- {item:286647} Depleted Crystal Heart · {npc:264149} Unstable Mana Rift · {npc:276401} Nascent Pylon Protector
	["Take the {item:286647} to an {npc:264149} on the road north of the temple and throw it into the rift. The {npc:276401} is elite: grouping up is advised."] = "",

	-- Step 32: Shadowprey Village
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:2408} Shadowprey Village · {area:1637} Orgrimmar · {zone:1444} Feralas · {area:1099} Camp Mojache
	["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408} and fly to {area:1637}: the next guide picks up there, with the {zone:1444} guide's hand-ins. Keep your hearthstone (bound at {area:1099}): the next guide uses it to get from {area:1637} back to {area:1099}."] = "",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 33: Back to your route
	["Back to your route"] = "De vuelta a tu ruta",
	-- {zone:2652} Shen'dralas · {zone:1444} Feralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["{zone:2652} is done. Your {zone:1444} guide picks up from here: ride back north through the {area:2657}, west along {area:405}'s southern edge and south into {zone:1444}, to the dock on the {area:1108} where the boat crosses to {area:1116}."] = "{zone:2652} está terminado. Tu guía de {zone:1444} continúa desde aquí: regresa al norte por {area:2657}, al oeste por el borde sur de {area:405} y al sur hacia {zone:1444}, hasta el muelle de {area:1108} donde el barco cruza a {area:1116}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here."] = "Ve al este por el valle hasta el extraño cristal en su pedestal: al hacer clic en él empieza {quest:92914}. Los Protectores de pilón decrépitos (nivel 42-43) a su alrededor son los elementales de maná que lo vigilan. Los Devoracadáveres (élite de nivel 45) deambulan por el valle al este de aquí.",
	-- ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Nuevo en Forever: si un paso está mal, avísanos en el Discord o GitHub de Polestar e indica el paso.\nLos Necrománticos parias y los Necrománticos Magram del valle sueltan {quest:93644}, cuyo autor vive en {zone:2652}: los jugadores lo obtuvieron tras pocas muertes. Los centauros Magram no te atacan a menos que los ataques; los Necrokhans Magram entre ellos (nivel 45) son élite: déjalos en paz.\nLos centauros Gelkis y Magram tienen sus propias cadenas de misiones en {area:2657}, que dan unos 20,000 a 30,000 de experiencia más, pero cada cadena pide Honorable con su clan. Los dos clanes son rivales, así que trabaja para uno: la guía de Reputación de los centauros Gelkis y Magram, en Reputación, explica cómo.",
	-- ["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Decrepit Pylon Protectors guard it: kill one beside the pylon, then use {spell:1289727} on it, as players did to repair it.\nCareful: the pylon stands at the edge of the {area:2657}, where Magram Necrokhans and Corpsefeeders (elites, level 45) walk, and Nascent Pylon Protectors (elites, 43) wander the road. Pull the Decrepit Pylon Protectors away from them before you repair it."] = "Ve al norte por el camino hasta el primer pilar, recolectando maná de las Fisuras de maná inestables por el camino. Lo protegen Protectores de pilar decrépitos: mata uno junto al pilar y luego usa {spell:1289727} sobre él, como hicieron los jugadores para repararlo.\nCuidado: el pilar está en el borde de {area:2657}, donde rondan Necrokhans Magram y Devoracadáveres (élites, nivel 45), y Protectores de pilar nacientes (élites, 43) deambulan por el camino. Aleja a los Protectores de pilar decrépitos de ellos antes de repararlo.",
	-- ["The nearest Decrepit Pylon Protectors stand by the road north, from the middle of the zone up to the western pylon, and around {npc:253471}'s overlook: one of them carries the heart Biraxas wants."] = "Los protectores de pilar decrépitos más cercanos están junto al camino del norte, desde el centro de la zona hasta el pilar del oeste, y alrededor del mirador de {npc:253471}: uno de ellos lleva el corazón que quiere Biraxas.",
	-- ["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it."] = "El {item:255656} está en el extremo oeste de la aldea; lo vigilan Guardianes Magram (niveles 39-41).",
	-- ["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408}: the next guide picks up in {area:1637}, with the {zone:1444} guide's hand-ins. Your hearthstone is bound at {area:1099}: if it is ready, hearth there and fly to {area:1637} from {area:1099} instead."] = "{zone:2652} está terminado. Regresa al norte por {area:2657} y al oeste por el borde sur de {area:405} hasta {area:2408}: la siguiente guía continúa en {area:1637}, con las entregas de la guía de {zone:1444}. Tu piedra de hogar está vinculada en {area:1099}: si está lista, úsala para ir ahí y vuela a {area:1637} desde {area:1099}.",
	-- ["{zone:2652} is done: ride back north through the {area:2657}; the next step says where your route goes on from there."] = "{zone:2652} está terminado: regresa al norte por {area:2657}; el siguiente paso indica por dónde sigue tu ruta desde ahí.",
}
