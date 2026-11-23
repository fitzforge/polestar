-- Chinese (simplified) (zhCN): the guide forever/class/druid/cure-poison (forever/class/druid/cure-poison.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:8946} Cure Poison
	["{spell:8946} is no longer trained in Forever: this chain teaches it, with a medicine bag on the way."] = "无限 中训练师不再教授{spell:8946}：这条任务线会教你，途中还会获得一个药袋。",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217} 站在 {area:1658} 德鲁伊建筑的楼上。没有 {skill:182}？先去拍卖行买五份 {item:2449}，后面会用到。",

	-- Step 3: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {npc:270459} Alfina Nightgaze · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {skill:182} Herbalism · {item:2449} Earthroot
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}; {npc:270459} by the Skyborne Portal does not give this quest. Cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {skill:182}? Buy five {item:2449} on the Auction House first: you need them later."] = "{npc:4217}站在{area:1658}德鲁伊建筑的楼上；天裔传送门旁的{npc:270459}不提供这个任务。施放{spell:18960}，到{area:2361}中央搭乘{npc:11800}提供的航班（她会把德鲁伊送到{area:702}，无需开通飞行路线），然后通过传送门上去。没有{skill:182}？先在拍卖行买五个{item:2449}：后面会用到。",

	-- Step 5: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15844} Empty Cliffspring Falls Sampler · {area:442} Auberdine · {zone:1450} Moonglade
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15844}. Then fly to {area:442} (learn the {zone:1450} flight path at Sindrayl first if you have not)."] = "施放 {spell:18960}：{npc:11802} 就在你旁边建筑的楼上。他会给你 {item:15844}。然后飞往 {area:442}（如果还没学会 {zone:1450} 的飞行路线，先找辛德拉尔学习）。",

	-- Step 6: Cliffspring Falls
	-- {area:442} Auberdine · {area:445} Cliffspring Falls · {item:15844} Empty Cliffspring Falls Sampler · {item:12350} Empty Sampling Tube
	["Head north-east from {area:442} to {area:445}. Stand at the cave mouth at the top of the waterfall, not in the river below, and use the {item:15844} (not the {item:12350} of another quest). Naga line the climb, a caster waits on the far bank, and filling the sampler calls two more (a Wave Rider and a Toxicologist, level 15): clear the way first and be ready to fight."] = "从 {area:442} 向东北前往 {area:445}。站在瀑布顶部的洞口，而非下方的河里，使用 {item:15844}（别用另一个任务的 {item:12350}）。上坡沿途都有纳迦，对岸有一名施法者，装满取样器还会召来两个敌人（一名踏浪者和一名毒性学家，15级）：先清路，并做好战斗准备。",
	-- {item:15844} Empty Cliffspring Falls Sampler
	["{item:15844}, at the cave mouth"] = "{item:15844}，在洞口",

	-- Step 7: Alanndarian Nightsong
	-- {area:442} Auberdine
	["Back in {area:442}, at the north end of the village."] = "回到{area:442}，在村庄北端。",

	-- Step 8: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}和{item:2449}",
	-- {area:442} Auberdine · {skill:182} Herbalism · {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere · {npc:1302} Bernard Gump · {zone:1453} Stormwind
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms are tiny white-spotted mushrooms on the floors and walls of the small moonkin caves in the hills just east and south-east of {area:442}; each gives one or two fungus, and each cave holds only a few, so go from cave to cave (they regrow in three minutes). The moonkin there are irritable. No {skill:182} needed for the blooms. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it ({npc:1313} or {npc:1302} in {zone:1453}, or the Auction House)."] = "月光蘑菇花是带白色斑点的小蘑菇，长在 {area:442} 正东及东南方山丘中小型枭兽洞穴的地面和洞壁上；每处可采到一两个蘑菇，每个洞穴只有几处，因此需要逐个洞穴寻找（三分钟刷新）。那里的枭兽脾气暴躁。采集蘑菇花不需要 {skill:182}。{item:2449} 则需要 {skill:182}：草药师可以在 {zone:1439} 各处采集，其他人需购买（可找 {zone:1453} 的 {npc:1313} 或 {npc:1302}，或在拍卖行购买）。",

	-- Step 9: Alanndarian Nightsong
	-- {item:15826} Curative Animal Salve · {item:15851} Lunar Fungus
	["She hands you the {item:15826}: ten doses, one per deer. Destroy any leftover {item:15851}."] = "她会给你 {item:15826}：共十剂，每只鹿用一剂。销毁剩余的 {item:15851}。",

	-- Step 10: Sickly Deer
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer · {zone:1439} Darkshore · {area:456} Cliffspring River · {zone:1440} Ashenvale · {area:442} Auberdine · {spell:339} Entangling Roots · {npc:3702} Alanndarian Nightsong
	["Use the {item:15826} on living {npc:12298} (level 5, a green cloud over them): they roam {zone:1439} from the {area:456} to the {zone:1440} border, many around the Blackwood furbolg camp north-east of {area:442}. Druid trick: root a deer with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time. Lost a dose on a deer that did not count? Abandon the quest and take it again from {npc:3702} for a fresh salve."] = "对活着的 {npc:12298} 使用 {item:15826}（5级，身上有绿色云雾）：它们在 {zone:1439} 的 {area:456} 到 {zone:1440} 边界之间游荡，{area:442} 东北方的黑木熊怪营地周围尤其多。德鲁伊技巧：用 {spell:339} 缠住一只鹿，在缠绕伤害生效前涂上药膏，之后缠绕将其击杀时还会再计数一次。如果药膏用在一只鹿上却没计数，浪费了一次剂量，可以放弃任务，再从 {npc:3702} 处重接以获得一份新药膏。",
	-- {item:15826} Curative Animal Salve · {npc:12298} Sickly Deer
	["Use the {item:15826} on {npc:12298}"] = "对{npc:12298}使用{item:15826}",

	-- Step 11: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed) and the portal up to {zone:1457}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}并找{npc:11802}，然后在{area:2361}中央乘{npc:11800}的飞行坐骑（她会载德鲁伊飞往{area:702}，无需飞行路线），再乘传送门上到{zone:1457}。{npc:11802}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",

	-- Step 12: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:8946} Cure Poison
	["{npc:4217}, upstairs in the {area:1658}, teaches you {spell:8946}."] = "{npc:4217} 在 {area:1658} 楼上，可教你 {spell:8946}。",

	-- Step 14: Lessons Anew
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3033} stands in the druids' hut on {area:1639}; {npc:262560}, the Skyborne druid trainer where the airship from Zephras Isle lands in northern {zone:1412}, gives the same quest. No {skill:182}? {npc:3490} at the Crossroads sells {item:2449} later, or buy five on the Auction House now."] = "{npc:3033}在{area:1639}的德鲁伊小屋中；{zone:1412}北部、来自泽风岛的飞艇停靠处，天裔德鲁伊训练师{npc:262560}也提供同一任务。没有{skill:182}？稍后可在十字路口向{npc:3490}购买{item:2449}，也可以现在就在拍卖行买五个。",
	-- {npc:3033} Turak Runetotem · {npc:262560} Hana Lighthoof · {zone:1412} Mulgore
	["{npc:3033}, or {npc:262560} in northern {zone:1412}"] = "{npc:3033}，或 {zone:1412} 北部的 {npc:262560}。",

	-- Step 15: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {item:15842} Empty Dreadmist Peak Sampler · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. He hands you the {item:15842}. {npc:11798} flies druids to {area:1638}; fly on to the Crossroads from there."] = "施放{spell:18960}：{npc:11802}就在你身旁建筑的楼上。他会给你{item:15842}。{npc:11798}会将德鲁伊送到{area:1638}；从那里继续飞往十字路口。",

	-- Step 16: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {object:19464} Dreadmist Peak Pool · {item:15842} Empty Dreadmist Peak Sampler
	-- plural, as words: Burning Blade Toxicologists = {npc:12319} Burning Blade Toxicologist
	["From the Crossroads head north to {area:384} and climb to the bubbling {object:19464} on its summit. Burning Blade cultists camp around it: pull them one or two at a time. Stand in the water and use the {item:15842}: three Burning Blade Toxicologists (level 13-14, curses and warlock spells) appear and attack. You need not kill them: once the sampler is full, run."] = "从十字路口向北前往{area:384}，爬到山顶冒泡的{object:19464}。周围有火刃教徒扎营：每次引一两个来打。站到水里使用{item:15842}：会出现三名火刃毒药师（13-14级，会施放诅咒和术士法术）并攻击你。不必击杀他们：采样器装满后就跑。",
	-- {item:15842} Empty Dreadmist Peak Sampler
	["{item:15842}, standing in the pool"] = "站在水池中使用 {item:15842}",

	-- Step 17: Tonga Runetotem
	-- {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["{npc:3448} stands in the Crossroads. No {skill:182}? {npc:3490}, a few steps away by the wind rider master, sells {item:2449} for 80 copper each, three at a time until he restocks."] = "{npc:3448}站在十字路口。没有{skill:182}？几步之外、双足飞龙管理员旁的{npc:3490}出售{item:2449}，每个80铜币，每次补货前有三个存货。",
	-- {item:2449} Earthroot
	["{item:2449}; herbalists pick it on the plains"] = "{item:2449}；草药师可在平原上采集",

	-- Step 18: Earthroot and Kodo Horns
	-- {item:2449} Earthroot
	-- plural, as words: Kodo Horns = {item:15852} Kodo Horn
	["{item:2449} and Kodo Horns"] = "{item:2449}和科多兽角",
	-- {npc:3234} Lost Barrens Kodo · {area:382} Sludge Fen · {area:388} Stagnant Oasis · {item:2449} Earthroot · {zone:1413} Barrens
	["Every {npc:3234} (level 14-15) drops a horn, but they are few and wander: search the far north near the {area:382} and the oases, above all the {area:388} south-east of the Crossroads. They charge from range and stomp. Herbalists find {item:2449} all over the northern {zone:1413}."] = "每只{npc:3234}（14-15级）都会掉落一只角，但数量少且四处游荡：搜索最北面的{area:382}及各绿洲附近，尤其是十字路口东南方的{area:388}。它们会从远处冲锋并践踏。草药师可在{zone:1413}北部各处找到{item:2449}。",

	-- Step 19: Tonga Runetotem
	-- {item:15826} Curative Animal Salve
	["He hands you the {item:15826}: ten doses, one per gazelle."] = "他会给你{item:15826}：共10剂，每只瞪羚用一剂。",

	-- Step 20: Sickly Gazelles
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Sickly Gazelles"] = "生病的瞪羚",
	-- {item:15826} Curative Animal Salve · {zone:1440} Ashenvale · {area:392} Ratchet · {spell:339} Entangling Roots · {npc:3448} Tonga Runetotem
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on living Sickly Gazelles (level 3): they graze on both sides of the road north of the Crossroads up to the {zone:1440} border, north-west of the Crossroads and west of {area:392}. Druid trick: root a gazelle with {spell:339}, apply the salve before the roots tick, and the root kill counts a second time, so five gazelles can do. Lost a dose? Abandon and retake the quest from {npc:3448} for a fresh salve."] = "对活着的生病的瞪羚（3级）使用{item:15826}：它们在十字路口以北、直到{zone:1440}交界处的道路两侧，以及十字路口西北方和{area:392}西侧吃草。德鲁伊技巧：先用{spell:339}缠住瞪羚，在缠绕造成伤害前涂上药膏；随后缠绕击杀它时还会再计数一次，因此五只瞪羚就可能够了。浪费了一剂？放弃任务，再从{npc:3448}处重接，即可获得新的药膏。",
	-- {item:15826} Curative Animal Salve
	-- plural, as words: Sickly Gazelles = {npc:12296} Sickly Gazelle
	["Use the {item:15826} on Sickly Gazelles"] = "对生病的瞪羚使用{item:15826}",

	-- Step 21: Curing the Sick
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}并找{npc:11802}，然后乘{npc:11798}的飞行坐骑前往{area:1638}。{npc:11802}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",

	-- Step 22: Power over Poison
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:8946} Cure Poison
	["{npc:3033} on {area:1639} teaches you {spell:8946}."] = "{area:1639}的{npc:3033}会教你{spell:8946}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back in {area:442}."] = "回到{area:442}。",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "施放传送：{zone:1450}，找{npc:11802}，然后飞往{area:702}，乘传送门上到{zone:1457}。",
	-- ["Cast Teleport: {zone:1450} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "施放传送：{zone:1450}，找{npc:11802}，然后乘{npc:11798}的飞行前往{area:1638}。",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "施放传送：{zone:1450}。{npc:11802}在{area:2361}。然后飞往{area:442}。",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "施放传送：{zone:1450}。{npc:11802}在{area:2361}。{npc:11798}会载德鲁伊飞往{area:1638}；再从那里飞往{area:380}。",
	-- ["Cast {spell:18960} and see {npc:11802}, then fly to {area:702} and take the portal up to {zone:1457}."] = "施放{spell:18960}并找{npc:11802}，然后飞往{area:702}，乘传送门上到{zone:1457}。",
	-- ["Cast {spell:18960} and see {npc:11802}, then take {npc:11798}'s flight to {area:1638}."] = "施放{spell:18960}并找{npc:11802}，然后乘{npc:11798}的飞行坐骑前往{area:1638}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Then fly to {area:442}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。然后飞往{area:442}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. {npc:11798} flies druids to {area:1638}; fly on to the {area:380} from there."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{npc:11798}可以送德鲁伊飞往{area:1638}；再从那里飞往{area:380}。",
	-- ["From the {area:380} ride north to {area:384} and fill the {item:15842} at the {object:19464}."] = "从{area:380}向北骑行到{area:384}，在{object:19464}装满{item:15842}。",
	-- ["Lost Barrens Kodos roam the plains north and west of the {area:380} and around the {area:388}; each drops a horn. Herbalists find {item:2449} all over the northern {zone:1413}."] = "{npc:3234}在{area:380}北边和西边的平原上以及{area:388}周围游荡；每只掉落一只角。草药师在{zone:1413}北部各处都能找到{item:2449}。",
	-- ["Ride north-east from {area:442} to {area:445} and fill the {item:15844} at the mouth of the cave by the falls."] = "从{area:442}向东北骑行到{area:445}，在瀑布旁的洞口装满{item:15844}。",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} (Alchemy Supplies) in {zone:1453} or on the Auction House."] = "{object:177750}长在{area:442}东边山丘里的枭兽洞穴中；那里的枭兽脾气暴躁。{item:2449}需要{skill:182}：草药师在{zone:1439}各处都能采到，其他人可以在{zone:1453}向{npc:1313}（炼金用品）购买，或去拍卖行买。",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else buys it from {npc:1313} ({skill:171} Supplies) in {zone:1453} or on the Auction House."] = "月光蘑菇花生长在{area:442}东边山丘的枭兽洞穴里；那里的枭兽很暴躁。{item:2449}需要{skill:182}：草药师在{zone:1439}各处都能采到，其他人可以在{zone:1453}向{npc:1313}（{skill:171}用品）购买，或在拍卖行购买。",
	-- ["Use the {item:15826} on Sickly Gazelles: they graze north of the road that runs east and west through the {area:380}."] = "对生病的瞪羚使用{item:15826}：它们在贯穿{area:380}东西向道路的北边吃草。",
	-- ["Use the {item:15826} on {npc:12298}. They roam {zone:1439} from the {area:456} in the north to the {zone:1440} border in the south."] = "对{npc:12298}使用{item:15826}。它们在{zone:1439}游荡，北起{area:456}，南至{zone:1440}边界。",
	-- ["{npc:12296}: use the salve on them"] = "{npc:12296}：对它们使用药膏",
	-- ["{npc:12298}: use the salve on them"] = "{npc:12298}：对它们使用药膏",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",
	-- ["{npc:3448} stands in the {area:380}. No {skill:182}? {npc:3490}, a few steps away, sells {item:2449}, three at a time until he restocks."] = "{npc:3448}站在{area:380}。没有{skill:182}？几步外的{npc:3490}出售{item:2449}，每次三个，直到补货。",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",
}
