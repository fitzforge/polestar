-- Chinese (traditional) (zhTW): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "Forever 不再由訓練師教授{spell:8946}：這個任務鏈會教你，途中還有一個藥袋。",

	-- Step 1: Lessons Anew
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:442} Auberdine
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。然後飛往{area:442}。",

	-- Step 3: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler
	["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "從{area:442}向東北騎往{area:445}，在瀑布旁的洞口裝滿{item:15844}。",

	-- Step 4: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}."] = "回到{area:442}。",

	-- Step 5: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}與{item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "月光蘑菇花生長在{area:442}東邊不遠處山丘中的梟獸洞穴裡；那裡的梟獸脾氣暴躁。{item:2449}需要{skill:182}：草藥師在{zone:1439}各處都能採到，其他人可向{zone:1453}的{npc:1313}（煉金用品）或拍賣場購買。",

	-- Step 7: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale
	["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "對{npc:12298}使用{item:15826}。牠們在{zone:1439}從北邊的{area:456}到南邊的{zone:1440}邊界一帶遊蕩。",
	-- {npc:12298} Sickly Deer
	["{npc:12298}: use the salve on them"] = "{npc:12298}：對牠們使用藥膏",

	-- Step 8: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "施放{spell:18960}並找{npc:11802}，然後飛往{area:702}，走傳送門上到{zone:1457}。",

	-- Step 10: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",

	-- Step 11: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:380} Crossroads
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{npc:11798}會載德魯伊飛往{area:1638}；再從那裡飛往{area:380}。",

	-- Step 12: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool
	["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "從{area:380}向北騎往{area:384}，在{object:19464}裝滿{item:15842}。",

	-- Step 13: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {area:380} Crossroads · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448}站在{area:380}。沒有{skill:182}？幾步外的{npc:3490}販售{item:2449}，每次補貨前只有三個。",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}；草藥師可以在平原上採集",

	-- Step 14: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449}與科多獸角",
	-- {area:380} Crossroads · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "落單的草原科多獸在{area:380}北邊和西邊的平原以及{area:388}周圍遊蕩；每隻都會掉落一根角。草藥師在{zone:1413}北部各處都能找到{item:2449}。",

	-- Step 16: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "生病的瞪羚",
	-- {item:15826} Curative Animal Salve · {area:380} Crossroads
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "對生病的瞪羚使用{item:15826}：牠們在穿過{area:380}的東西向道路北邊覓食。",
	-- {npc:12296} Sickly Gazelle
	["{npc:12296}: use the salve on them"] = "{npc:12296}：對牠們使用藥膏",

	-- Step 17: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "施放{spell:18960}並找{npc:11802}，然後搭乘{npc:11798}的飛行路線前往{area:1638}。",
}
