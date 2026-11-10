-- French (frFR): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "{spell:8946} ne s'apprend plus auprès du maître dans Forever : cette suite de quêtes l'enseigne, avec une sacoche de remèdes en chemin.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217} se tient à l'étage du bâtiment des druides, dans {area:1658}. Pas d'{skill:182} ? Achetez d'abord cinq {item:2449} à l'hôtel des ventes : il vous en faudra plus tard.",

	-- Step 3: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {npc:270459} Alfina Nightgaze · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}; {npc:270459} by the Skyborne Portal does not give this quest. Cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 5: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler · {area:442} Auberdine · {zone:1450} Moonglade
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to {area:442} (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "Lancez {spell:18960} : {npc:11802} se tient à l'étage du bâtiment à côté de vous. Il vous remet l'{item:15844}. Prenez ensuite un vol pour {area:442} (apprenez d'abord le trajet aérien de {zone:1450} auprès de Sindrayl si ce n'est pas fait).",

	-- Step 6: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from {area:442} to {area:445}. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "Partez vers le nord-est d'{area:442} jusqu'aux {area:445}. Placez-vous à l'entrée de la grotte, en haut de la cascade, pas dans la rivière en contrebas, et utilisez l'{item:15844} (pas le {item:12350} d'une autre quête). Des nagas bordent la montée, un lanceur de sorts attend sur l'autre rive, et remplir l'échantillonneur en appelle deux autres (un Chevaucheur des vagues et un Toxicologue, niveau 15) : dégagez d'abord le chemin et soyez prêt à combattre.",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "{item:15844}, à l'entrée de la grotte",

	-- Step 7: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}, at the north end of the village."] = "De retour à {area:442}, au bout nord du village.",

	-- Step 8: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} et {item:2449}",
	-- {area:442} Auberdine · {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of {area:442}; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "Les Floraisons fongiques lunaires sont de minuscules champignons tachetés de blanc, sur le sol et les parois des petites grottes de séléniens dans les collines juste à l'est et au sud-est d'{area:442} ; chacune donne un ou deux champignons, et chaque grotte n'en contient que quelques-unes, alors allez de grotte en grotte (elles repoussent en trois minutes). Les séléniens y sont irritables. Pas besoin d'{skill:182} pour les floraisons. La {item:2449} demande l'{skill:182} : les herboristes en cueillent partout en {zone:1439}, les autres en achètent ({npc:1313} ou {npc:1302} à {zone:1453}, ou l'hôtel des ventes).",

	-- Step 9: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "Elle vous remet le {item:15826} : dix doses, une par cerf. Détruisez les {item:15851} qui vous restent.",

	-- Step 10: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale · {area:442} Auberdine · {spell:339} Entangling Roots · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the {area:456} to the {zone:1440} border, many around the Blackwood furbolg camp north-east of {area:442}. Druid trick: root a deer with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "Utilisez le {item:15826} sur des {npc:12298} vivants (niveau 5, un nuage vert au-dessus d'eux) : ils errent en {zone:1439}, de la {area:456} jusqu'à la frontière d'{zone:1440}, nombreux autour du camp des furbolgs Noirbois au nord-est d'{area:442}. Astuce de druide : immobilisez un cerf avec {spell:339}, appliquez le baume avant que les racines ne fassent des dégâts, et la mort par les racines compte une seconde fois. Perdu une dose sur un cerf qui n'a pas compté ? Abandonnez la quête et reprenez-la auprès de {npc:3702} pour un baume neuf.",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "",

	-- Step 11: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 12: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the {area:1658}, teaches you {spell:8946}."] = "{npc:4217}, à l'étage de {area:1658}, vous apprend {spell:8946}.",

	-- Step 14: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the Crossroads sells {item:2449} later, or buy five on the Auction House now."] = "",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "{npc:3033}, ou {npc:262560} au nord de {zone:1412}",

	-- Step 15: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the Crossroads from there."] = "",

	-- Step 16: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the Crossroads head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "{item:15842}, debout dans le bassin",

	-- Step 17: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the Crossroads. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449} ; les herboristes en cueillent dans les plaines",

	-- Step 18: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} et Cornes de kodo",
	-- {npc:3234} Lost Barrens Kodo · {area:382} Sludge Fen · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the Crossroads. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "",

	-- Step 19: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "Il vous remet le {item:15826} : dix doses, une par gazelle.",

	-- Step 20: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Gazelles malades",
	-- {item:15826} Curative Animal Salve · {zone:1440} Ashenvale · {area:392} Ratchet · {spell:339} Entangling Roots · {npc:3448} Tonga Runetotem
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the Crossroads up to the {zone:1440} border, north-west of the Crossroads and west of {area:392}. Druid trick: root a gazelle with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "",
	-- {item:15826} Curative Animal Salve
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles"] = "",

	-- Step 21: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 22: Power over Poison
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:8946} Cure Poison
	["{npc:3033} on {area:1639} teaches you {spell:8946}."] = "{npc:3033}, sur {area:1639}, vous apprend {spell:8946}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:442}."] = "De retour à {area:442}.",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lancez Téléportation : {zone:1450} et parlez à {npc:11802}, puis prenez un vol pour {area:702} et le portail pour monter à {zone:1457}.",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lancez Téléportation : {zone:1450} et parlez à {npc:11802}, puis prenez le vol de {npc:11798} pour {area:1638}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. Prenez ensuite un vol pour {area:442}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. {npc:11798} emmène les druides à {area:1638} ; de là, prenez un vol pour {area:380}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lancez {spell:18960} et allez voir {npc:11802}, puis volez jusqu'à {area:702} et prenez le portail pour monter à {zone:1457}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lancez {spell:18960} et allez voir {npc:11802}, puis prenez le vol de {npc:11798} pour {area:1638}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}."] = "Lancez {spell:18960} et allez voir {npc:11802}, puis prenez le vol de {npc:11800} au milieu de {area:2361} (elle emmène les druides au {area:702}, pas besoin du trajet aérien) et le portail pour monter à {zone:1457}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Volez ensuite jusqu'à {area:442}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. {npc:11798} transporte les druides jusqu'à {area:1638} ; de là, volez jusqu'à {area:380}.",
	-- ["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lancez {spell:18960} : {npc:11802} se tient à l'étage du bâtiment à côté de vous. Il vous remet l'{item:15842}. {npc:11798} emmène les druides à {area:1638} ; de là, prenez un vol pour {area:380}.",
	-- ["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the {area:380}. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Chaque {npc:3234} (niveau 14-15) laisse tomber une corne, mais ils sont rares et errent : cherchez à l'extrême nord près du {area:382} et des oasis, surtout l'{area:388} au sud-est de {area:380}. Ils chargent à distance et piétinent. Les herboristes trouvent de la {item:2449} partout dans le nord de {zone:1413}.",
	-- ["From the {area:380} head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "Depuis {area:380}, partez vers le nord jusqu'au {area:384} et grimpez jusqu'au bassin bouillonnant à son sommet. Des cultistes de la Lame ardente campent autour : attirez-les un ou deux à la fois. Placez-vous dans l'eau et utilisez l'{item:15842} : trois Toxicologues de la Lame ardente (niveau 13-14, malédictions et sorts de démoniste) apparaissent et attaquent. Inutile de les tuer : une fois l'échantillonneur plein, fuyez.",
	-- ["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Depuis {area:380}, chevauchez vers le nord jusqu'à {area:384} et remplissez l'{item:15842} au {object:19464}.",
	-- ["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Des Kodos égarés des Tarides ({npc:3234}) errent dans les plaines au nord et à l'ouest de {area:380} et autour de {area:388} ; chacun lâche une corne. Les herboristes trouvent {item:2449} partout dans le nord de {zone:1413}.",
	-- ["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Chevauchez vers le nord-est depuis {area:442} jusqu'à {area:445} et remplissez l'{item:15844} à l'entrée de la grotte près des chutes.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Les Floraisons fongiques lunaires ({object:177750}) poussent dans les grottes des séléniens dans les collines juste à l'est d'{area:442} ; les séléniens y sont irritables. {item:2449} requiert {skill:182} : les herboristes la cueillent partout à {zone:1439}, les autres l'achètent à {npc:1313} (Fournitures d'alchimie) à {zone:1453} ou à l'hôtel des ventes.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} ({skill:171} Supplies) in {zone:1453} or on the Auction House."] = "Les Floraisons fongiques lunaires poussent dans les grottes des séléniens dans les collines juste à l'est de {area:442} ; les séléniens y sont irritables. {item:2449} demande {skill:182} : les herboristes en cueillent partout en {zone:1439}, les autres l'achètent à {npc:1313} (fournitures d'{skill:171}) à {zone:1453} ou à l'hôtel des ventes.",
	-- ["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Utilisez le {item:15826} sur les Gazelles malades : elles paissent au nord de la route qui traverse {area:380} d'est en ouest.",
	-- ["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the {area:380} up to the {zone:1440} border, north-west of the {area:380} and west of {area:392}. Druid trick: root a gazelle with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "Utilisez le {item:15826} sur des Gazelles malades vivantes (niveau 3) : elles broutent des deux côtés de la route au nord de {area:380} jusqu'à la frontière d'{zone:1440}, au nord-ouest de {area:380} et à l'ouest de {area:392}. Astuce de druide : immobilisez une gazelle avec {spell:339}, appliquez le baume avant que les racines ne fassent des dégâts, et la mort par les racines compte une seconde fois : cinq gazelles peuvent donc suffire. Perdu une dose ? Abandonnez la quête et reprenez-la auprès de {npc:3448} pour un baume neuf.",
	-- ["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Utilisez le {item:15826} sur les {npc:12298}. Ils parcourent {zone:1439}, de {area:456} au nord jusqu'à la frontière d'{zone:1440} au sud.",
	-- ["{npc:12296}: use the salve on them"] = "{npc:12296} : utilisez le baume sur elles",
	-- ["{npc:12298}: use the salve on them"] = "{npc:12298} : utilisez le baume sur eux",
	-- ["{npc:270459}, the Skyborne druid trainer, stands beside the Skyborne Portal west of {area:279} ({npc:4217} in {zone:1457} gives the same quest). No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:270459}, la maîtresse des druides éolides, se tient à côté du portail éolide, à l'ouest de {area:279} ({npc:4217} à {zone:1457} donne la même quête). Pas d'{skill:182} ? Achetez d'abord cinq {item:2449} à l'hôtel des ventes : il vous en faudra plus tard.",
	-- ["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the {area:380} sells {item:2449} later, or buy five on the Auction House now."] = "{npc:3033} se tient dans la hutte des druides, sur {area:1639} ; {npc:262560}, la maîtresse des druides éolides, là où se pose l'aéronef venu de l'Île de Zéphras au nord de {zone:1412}, donne la même quête. Pas d'{skill:182} ? {npc:3490}, à {area:380}, vend de la {item:2449} plus tard, ou achetez-en cinq à l'hôtel des ventes dès maintenant.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} se trouve sur {area:1639}.",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "{npc:3448} se tient à {area:380}. Pas d'{skill:182} ? {npc:3490}, à quelques pas près du maître des coursiers du vent, vend de la {item:2449} 80 pièces de cuivre l'unité, trois à la fois jusqu'à son réapprovisionnement.",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} se trouve à {area:380}. Pas d'{skill:182} ? {npc:3490}, à quelques pas, vend de la {item:2449}, trois à la fois jusqu'à son réapprovisionnement.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} se trouve dans {area:1658}.",
}
