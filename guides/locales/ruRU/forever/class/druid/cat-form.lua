-- Russian (ruRU): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "Ваш облик для скрытности и ближнего боя: в Forever {spell:768} на 20-м уровне дает эта цепочка, а не учитель.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:4217} stands in the {area:1658}. Skyborne far from {zone:1457}: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No Aquatic Form yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the Aquatic Form guide) is in the same {area:493}."] = "",

	-- Step 3: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "Примените {spell:18960}. {npc:11802} стоит наверху в своем доме, здесь: {area:2361}. Поднимитесь внутри: стрелка не различает этажи. Узнайте там маршрут полета, если его у вас нет.",

	-- Step 4: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Реликвии Келий Малфуриона",
	-- {quest:98394} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "",

	-- Step 5: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Назад к {npc:11802}",
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11800}'s flight to {area:702}: she stands in the middle of {area:2361} and flies druids there, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Примените {spell:18960}, чтобы оказаться рядом с {npc:11802} ({area:2361}) – на острове Зефрас задание небеснорожденных никто не принимает. Затем летите с помощью персонажа {npc:11800} сюда: {area:702}. Она стоит в центре локации {area:2361} и доставляет туда друидов, маршрут полета не нужен. {npc:11802} стоит наверху в своем доме: поднимитесь внутри, стрелка не различает этажи.",

	-- Step 6: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:768} Cat Form
	["Take the portal up to {npc:4217}, upstairs in the {area:1658}: he teaches you {spell:768}."] = "",

	-- Step 8: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}. No Aquatic Form yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the Aquatic Form guide) is in the same {area:493}."] = "",

	-- Step 9: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "Примените {spell:18960}. {npc:11802} стоит наверху в своем доме, здесь: {area:2361}. Поднимитесь внутри: стрелка не различает этажи.",

	-- Step 10: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {quest:98342} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98342} (Tauren) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "",

	-- Step 11: Back to Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Примените {spell:18960}, чтобы оказаться рядом с {npc:11802} ({area:2361}) – на острове Зефрас задание небеснорожденных никто не принимает. Затем летите с помощью персонажа {npc:11798} сюда: {area:1638}. {npc:11802} стоит наверху в своем доме: поднимитесь внутри, стрелка не различает этажи.",

	-- Step 12: To Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:768} Cat Form
	["{npc:3033} on {area:1639} teaches you {spell:768}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "Назад: {npc:11802} ({area:2361}), затем летите сюда: {area:702}.",
	-- ["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "Назад: {npc:11802} ({area:2361}), затем летите с помощью персонажа {npc:11798} сюда: {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}; узнайте там маршрут полета, если его у вас нет.",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "Поднимитесь через портал к {npc:4217} ({area:1658}).",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} стоит здесь: {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217} стоит здесь: {area:1658}. Небеснорожденным без маршрута полета в Деревню Рут'теран: плывите на корабле от места {area:442}.",
	-- ["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342} (таурены) ждет на южном холме над мостом, {npc:272054} (небеснорожденные) – к югу от двух мостов. Реликвии лежат здесь: {area:2363}, к востоку от озера. Выйдите из облика, щелкните по статуе у входа, чтобы получить пять минут скрытности, держитесь подальше от духов внутри и возьмите по одной реликвии каждого вида; {item:280680} лежит у подножия статуи белой кошки. Реликвия не дает добычи, пока ее обыскивает другой игрок: подождите немного и попробуйте снова.",
	-- ["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (ночные эльфы) ждет на южном холме над мостом, {npc:272054} (небеснорожденные) – к югу от двух мостов. Реликвии лежат здесь: {area:2363}, к востоку от озера. Выйдите из облика, щелкните по статуе у входа, чтобы получить пять минут скрытности, держитесь подальше от духов внутри и возьмите по одной реликвии каждого вида; {item:280680} лежит у подножия статуи белой кошки. Реликвия не дает добычи, пока ее обыскивает другой игрок: подождите немного и попробуйте снова.",
}
