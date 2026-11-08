-- Portuguese (Brazil) (ptBR): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "{spell:8946} não é mais ensinado no Forever: esta série o ensina, com uma bolsa de remédios no caminho.",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the Cenarion Enclave. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 2: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {npc:270459} Alfina Nightgaze · {zone:1450} Moonglade · {npc:11800} Silva Fil'naveth · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the Cenarion Enclave; {npc:270459} by the Skyborne Portal does not give this quest. Cast Teleport: {zone:1450} and take {npc:11800}'s flight from the middle of Nighthaven (she flies druids to Rut'theran Village, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 3: Dendrite Starblaze
	-- {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler
	["Cast Teleport: {zone:1450}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to Auberdine (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "",

	-- Step 4: Cliffspring Falls
	["Cliffspring Falls"] = "",
	-- {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from Auberdine to Cliffspring Falls. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "",

	-- Step 5: Alanndarian Nightsong
	["Back in Auberdine, at the north end of the village."] = "",

	-- Step 6: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} e {item:2449}",
	-- {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of Auberdine; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "",

	-- Step 7: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "",

	-- Step 8: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {zone:1440} Ashenvale · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the Cliffspring River to the {zone:1440} border, many around the Blackwood furbolg camp north-east of Auberdine. Druid trick: root a deer with Entangling Roots, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "",

	-- Step 9: Curing the Sick
	-- {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {zone:1457} Darnassus
	["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11800}'s flight from the middle of Nighthaven (she flies druids to Rut'theran Village, no flight path needed) and the portal up to {zone:1457}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 10: Power over Poison
	-- {npc:4217} Mathrengyl Bearwalker · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the Cenarion Enclave, teaches you {spell:8946}."] = "",

	-- Step 11: Lessons Anew
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {object:50507}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the Crossroads sells {item:2449} later, or buy five on the Auction House now."] = "",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "",

	-- Step 12: Dendrite Starblaze
	-- {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff
	["Cast Teleport: {zone:1450}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {zone:1456}; fly on to the Crossroads from there."] = "",

	-- Step 13: Dreadmist Peak
	["Dreadmist Peak"] = "",
	-- {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the Crossroads head north to Dreadmist Peak and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "",

	-- Step 14: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the Crossroads. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}; herbalistas a colhem nas planícies",

	-- Step 15: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} e Chifres de Kodo",
	-- {npc:3234} Lost Barrens Kodo · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the Sludge Fen and the oases, above all the Stagnant Oasis south-east of the Crossroads. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "",

	-- Step 16: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "",

	-- Step 17: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Gazelas Doentes",
	-- {item:15826} Curative Animal Salve · {zone:1440} Ashenvale · {npc:3448} Tonga Runetotem
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the Crossroads up to the {zone:1440} border, north-west of the Crossroads and west of Ratchet. Druid trick: root a gazelle with Entangling Roots, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "",
	-- {item:15826} Curative Animal Salve
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles"] = "",

	-- Step 18: Curing the Sick
	-- {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff
	["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11798}'s flight to {zone:1456}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 19: Power over Poison
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {spell:8946} Cure Poison
	["{npc:3033} on {object:50507} teaches you {spell:8946}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:442}."] = "De volta a {area:442}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Lance {spell:18960} e fale com {npc:11802}, depois voe para {area:702} e pegue o portal até {zone:1457}.",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Lance {spell:18960} e fale com {npc:11802}, depois pegue o voo de {npc:11798} para {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Depois voe para {area:442}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. {npc:11798} leva druidas voando a {area:1638}; de lá, siga voando até {area:380}.",
	-- ["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "De {area:380} cavalgue para o norte até {area:384} e encha o {item:15842} no {object:19464}.",
	-- ["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Kodos Perdidos dos Sertões vagam pelas planícies ao norte e a oeste de {area:380} e em volta de {area:388}; cada um deixa cair um chifre. Herbalistas encontram {item:2449} por todo o norte de {zone:1413}.",
	-- ["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Cavalgue para nordeste de {area:442} até {area:445} e encha o {item:15844} na boca da caverna junto às cascatas.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Os Brotos Fúngicos Lunares crescem nas cavernas dos luniscantes nas colinas logo a leste de {area:442}; os luniscantes de lá são irritadiços. {item:2449} exige {skill:182}: herbalistas a colhem por toda {zone:1439}, os demais a compram de {npc:1313} (Suprimentos de Alquimia) em {zone:1453} ou na Casa de Leilões.",
	-- ["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Use o {item:15826} nas Gazelas Doentes: elas pastam ao norte da estrada que corta {area:380} de leste a oeste.",
	-- ["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Use o {item:15826} em {npc:12298}. Eles vagam por {zone:1439}, do {area:456} ao norte até a fronteira de {zone:1440} ao sul.",
	-- ["{npc:12296}: use the salve on them"] = "{npc:12296}: use o unguento nelas",
	-- ["{npc:12298}: use the salve on them"] = "{npc:12298}: use o unguento neles",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} fica em {area:1639}.",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} fica em {area:380}. Sem {skill:182}? {npc:3490}, a poucos passos, vende {item:2449}, três de cada vez até repor o estoque.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} fica no {area:1658}.",
}
