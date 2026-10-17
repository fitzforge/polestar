-- Chinese (simplified) (zhCN): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "Forever 中训练师不再教授{spell:8946}：这条任务线会教你，途中还会获得一个药袋。",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:442} Auberdine
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。然后飞往{area:442}。",

	-- Step 3: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler
	["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "从{area:442}向东北骑行到{area:445}，在瀑布旁的洞口装满{item:15844}。",

	-- Step 4: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}."] = "回到{area:442}。",

	-- Step 5: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}和{item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "{object:177750}长在{area:442}东边山丘里的枭兽洞穴中；那里的枭兽脾气暴躁。{item:2449}需要{skill:182}：草药师在{zone:1439}各处都能采到，其他人可以在{zone:1453}向{npc:1313}（炼金用品）购买，或去拍卖行买。",

	-- Step 7: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale
	["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "对{npc:12298}使用{item:15826}。它们在{zone:1439}游荡，北起{area:456}，南至{zone:1440}边界。",
	-- {npc:12298} Sickly Deer
	["{npc:12298}: use the salve on them"] = "{npc:12298}：对它们使用药膏",

	-- Step 8: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "施放{spell:18960}并找{npc:11802}，然后飞往{area:702}，乘传送门上到{zone:1457}。",

	-- Step 10: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",

	-- Step 11: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{npc:11798}可以送德鲁伊飞往{area:1638}；再从那里飞往{area:380}。",

	-- Step 12: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool
	["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "从{area:380}向北骑行到{area:384}，在{object:19464}装满{item:15842}。",

	-- Step 13: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448}站在{area:380}。没有{skill:182}？几步外的{npc:3490}出售{item:2449}，每次三个，直到补货。",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}；草药师可在平原上采集",

	-- Step 14: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449}和科多兽角",
	-- {area:380} Crossroads · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "{npc:3234}在{area:380}北边和西边的平原上以及{area:388}周围游荡；每只掉落一只角。草药师在{zone:1413}北部各处都能找到{item:2449}。",

	-- Step 16: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "生病的瞪羚",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "对生病的瞪羚使用{item:15826}：它们在贯穿{area:380}东西向道路的北边吃草。",
	-- {npc:12296} Sickly Gazelle
	["{npc:12296}: use the salve on them"] = "{npc:12296}：对它们使用药膏",

	-- Step 17: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "施放{spell:18960}并找{npc:11802}，然后乘{npc:11798}的飞行坐骑前往{area:1638}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "施放传送：{zone:1450}，找{npc:11802}，然后飞往{area:702}，乘传送门上到{zone:1457}。",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "施放传送：{zone:1450}，找{npc:11802}，然后乘{npc:11798}的飞行前往{area:1638}。",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "施放传送：{zone:1450}。{npc:11802}在{area:2361}。然后飞往{area:442}。",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "施放传送：{zone:1450}。{npc:11802}在{area:2361}。{npc:11798}会载德鲁伊飞往{area:1638}；再从那里飞往{area:380}。",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} ({skill:171} Supplies) in {zone:1453} or on the Auction House."] = "月光蘑菇花生长在{area:442}东边山丘的枭兽洞穴里；那里的枭兽很暴躁。{item:2449}需要{skill:182}：草药师在{zone:1439}各处都能采到，其他人可以在{zone:1453}向{npc:1313}（{skill:171}用品）购买，或在拍卖行购买。",
}
