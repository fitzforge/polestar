-- Russian (ruRU): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "В Forever учитель больше не обучает заклинанию «{spell:8946}»: ему учит эта цепочка, а по пути вы получите сумку с лекарствами.",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} стоит здесь: {area:1658}.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:442} Auberdine
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}. Затем летите сюда: {area:442}.",

	-- Step 3: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler
	["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "Езжайте на северо-восток ({area:442} → {area:445}) и наполните {item:15844} у входа в пещеру у водопада.",

	-- Step 4: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}."] = "Снова здесь: {area:442}.",

	-- Step 5: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} и {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "Лунный Плеснецвет растет в пещерах лунных совухов на холмах чуть восточнее (ориентир: {area:442}); совухи там раздражительны. Для предмета {item:2449} нужен навык {skill:182}: травники собирают его по всей зоне {zone:1439}, остальные покупают его у NPC {npc:1313} (товары для алхимиков, {zone:1453}) или на аукционе.",

	-- Step 7: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale
	["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "Примените {item:15826} на них: {npc:12298}. Они бродят по зоне {zone:1439} от реки ({area:456}) на севере до границы зоны {zone:1440} на юге.",
	-- {npc:12298} Sickly Deer
	["{npc:12298}: use the salve on them"] = "{npc:12298}: примените на них мазь",

	-- Step 8: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "Примените {spell:18960} и поговорите: {npc:11802}. Затем летите сюда: {area:702} – и поднимитесь через портал: {zone:1457}.",

	-- Step 10: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} стоит здесь: {area:1639}.",

	-- Step 11: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}. {npc:11798} отвозит друидов сюда: {area:1638}; оттуда летите дальше: {area:380}.",

	-- Step 12: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool
	["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "Из места {area:380} езжайте на север: {area:384} – и наполните {item:15842} здесь: {object:19464}.",

	-- Step 13: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448} стоит здесь: {area:380}. Нет навыка {skill:182}? {npc:3490} в нескольких шагах продает {item:2449} – по три штуки, пока не пополнит запас.",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}; травники собирают его на равнинах",

	-- Step 14: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449} и рога кодо",
	-- {area:380} Crossroads · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "Потерявшиеся степные кодо бродят по равнинам к северу и западу от места {area:380} и вокруг места {area:388}; с каждого падает рог. Травники находят {item:2449} по всему северу зоны {zone:1413}.",

	-- Step 16: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "Больные газели",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "Примените {item:15826} на больных газелях: они пасутся к северу от дороги, идущей с востока на запад через место {area:380}.",
	-- {npc:12296} Sickly Gazelle
	["{npc:12296}: use the salve on them"] = "{npc:12296}: примените на них мазь",

	-- Step 17: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "Примените {spell:18960} и поговорите: {npc:11802}. Затем летите с помощью персонажа {npc:11798} сюда: {area:1638}.",
}
