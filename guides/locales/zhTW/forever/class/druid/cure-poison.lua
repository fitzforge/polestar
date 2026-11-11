-- Chinese (traditional) (zhTW): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "Forever 不再由訓練師教授{spell:8946}：這個任務鏈會教你，途中還有一個藥袋。",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 3: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {npc:270459} Alfina Nightgaze · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}; {npc:270459} by the Skyborne Portal does not give this quest. Cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "",

	-- Step 5: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler · {area:442} Auberdine · {zone:1450} Moonglade
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to {area:442} (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "",

	-- Step 6: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from {area:442} to {area:445}. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "",

	-- Step 7: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}, at the north end of the village."] = "",

	-- Step 8: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}與{item:2449}",
	-- {area:442} Auberdine · {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of {area:442}; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "",

	-- Step 9: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "",

	-- Step 10: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale · {area:442} Auberdine · {spell:339} Entangling Roots · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the {area:456} to the {zone:1440} border, many around the Blackwood furbolg camp north-east of {area:442}. Druid trick: root a deer with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "",

	-- Step 11: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 12: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the {area:1658}, teaches you {spell:8946}."] = "",

	-- Step 14: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the Crossroads sells {item:2449} later, or buy five on the Auction House now."] = "",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "",

	-- Step 15: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the Crossroads from there."] = "",

	-- Step 16: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {object:19464} Dreadmist Peak Pool · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the Crossroads head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "",

	-- Step 17: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the Crossroads. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}；草藥師可以在平原上採集",

	-- Step 18: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449}與科多獸角",
	-- {npc:3234} Lost Barrens Kodo · {area:382} Sludge Fen · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the Crossroads. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "",

	-- Step 19: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "",

	-- Step 20: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "生病的瞪羚",
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
	["{npc:3033} on {area:1639} teaches you {spell:8946}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:442}."] = "回到{area:442}。",
	-- ["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "施放{spell:18960}並找{npc:11802}，然後飛往{area:702}，走傳送門上到{zone:1457}。",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "施放{spell:18960}並找{npc:11802}，然後搭乘{npc:11798}的飛行路線前往{area:1638}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。然後飛往{area:442}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{npc:11798}會載德魯伊飛往{area:1638}；再從那裡飛往{area:380}。",
	-- ["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "從{area:380}向北騎往{area:384}，在{object:19464}裝滿{item:15842}。",
	-- ["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "落單的草原科多獸在{area:380}北邊和西邊的平原以及{area:388}周圍遊蕩；每隻都會掉落一根角。草藥師在{zone:1413}北部各處都能找到{item:2449}。",
	-- ["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "從{area:442}向東北騎往{area:445}，在瀑布旁的洞口裝滿{item:15844}。",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "月光蘑菇花生長在{area:442}東邊不遠處山丘中的梟獸洞穴裡；那裡的梟獸脾氣暴躁。{item:2449}需要{skill:182}：草藥師在{zone:1439}各處都能採到，其他人可向{zone:1453}的{npc:1313}（煉金用品）或拍賣場購買。",
	-- ["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "對生病的瞪羚使用{item:15826}：牠們在穿過{area:380}的東西向道路北邊覓食。",
	-- ["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "對{npc:12298}使用{item:15826}。牠們在{zone:1439}從北邊的{area:456}到南邊的{zone:1440}邊界一帶遊蕩。",
	-- ["{npc:12296}: use the salve on them"] = "{npc:12296}：對牠們使用藥膏",
	-- ["{npc:12298}: use the salve on them"] = "{npc:12298}：對牠們使用藥膏",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448}站在{area:380}。沒有{skill:182}？幾步外的{npc:3490}販售{item:2449}，每次補貨前只有三個。",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",
}
