-- Chinese (simplified) (zhCN): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "你的水中旅行形态：快速游泳、水下呼吸，另外还有一条腰带和一个神像。",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. Skyborne: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up."] = "",

	-- Step 3: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:29} Trial of the Lake · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. {quest:29} runs on a 30-minute timer. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，来自湖中的{object:177785}",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "在{area:2362}",

	-- Step 4: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:456} Cliffspring River
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Fly from {area:2361} to {area:442}. The {object:177792} lies far out on the sea floor off the north coast, between tall rocks west of where the {area:456} reaches the sea: it cannot be seen from the east side of the rocks. Watch your breath and the Darkshore Threshers; fight above water."] = "",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}, from the {object:177792}"] = "",

	-- Step 5: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Head west to the coast: the {object:177790} lies far out on the sea floor beside a bubbling fissure (air), west of a sunken anchor. Sharks roam here; do not swim on past the wreck beyond it, the deep water brings fatigue."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "",

	-- Step 6: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "施放{spell:18960}。两半都在背包里时，站在西北岸的{area:2362}旁，使用{item:15883}将其合成，然后再次施放{spell:18960}（在{zone:1450}内也可使用），传送到{npc:11802}身边。他站在自己建筑的楼上：从室内上楼，箭头无法区分楼层。之后，{area:2361}中央的{npc:11800}可以送德鲁伊直接飞往{area:702}。",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}：在神殿合成两半",

	-- Step 7: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:31} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:31}: swim fast and breathe underwater."] = "",

	-- Step 8: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:5061} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:5061}: swim fast and breathe underwater."] = "",

	-- Step 9: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands in the druids' hut on {area:1639}."] = "",

	-- Step 10: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:28} Trial of the Lake · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960}: {npc:11802} stands upstairs in the building beside you. {quest:28} runs on a 30-minute timer. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "",

	-- Step 11: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down."] = "",

	-- Step 12: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen
	["The {object:177792} lies underwater in the {area:382} pond north of the Crossroads, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "",

	-- Step 13: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:11798} flies druids to {area:1638}."] = "施放{spell:18960}。两半都在背包里时，站在西北岸的{area:2362}旁，使用{item:15883}将其合成，然后再次施放{spell:18960}（在{zone:1450}内也可使用），传送到{npc:11802}身边。他站在自己建筑的楼上：从室内上楼，箭头无法区分楼层。{npc:11798}可以送德鲁伊飞往{area:1638}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "施放传送：{zone:1450}。在湖西北岸的{area:2362}附近把两半合成{item:15885}，然后去{area:2361}找{npc:11802}。之后飞往{area:702}。",
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "施放传送：{zone:1450}。在湖西北岸的{area:2362}附近把两半合成{item:15885}，然后去{area:2361}找{npc:11802}。{npc:11798}可送德鲁伊飞往{area:1638}。",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放传送：{zone:1450}。{npc:11802}在{area:2361}。神殿灵珠在{area:2361}下方{area:656}湖底的容器里：拿一个到西北岸的{area:2362}，在那里使用，然后与{npc:11799}交谈。",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放传送：{zone:1450}。{npc:11802}在{area:2361}。神殿灵珠在{area:656}湖底，几分钟内就会消失：拿到后直接游到西北岸的{area:2362}，在那里使用，然后与{npc:11799}交谈。",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "施放{spell:18960}。在湖西北岸的{area:2362}附近把两半合成{item:15885}，然后去{area:2361}找{npc:11802}。之后飞往{area:702}。",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "施放{spell:18960}。在湖西北岸的{area:2362}附近把两半合成{item:15885}，然后去{area:2361}找{npc:11802}。{npc:11798}可以送德鲁伊飞往{area:1638}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{item:15877}放在{area:2361}下方{area:656}湖底的容器里：拿一个到西北岸的{area:2362}，在那里使用，然后与{npc:11799}交谈。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{item:15877}放在{area:656}湖底，几分钟内就会消失：拿到一个后直接游到西北岸的{area:2362}，在那里使用，然后与{npc:11799}交谈。",
	-- ["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "从{area:2361}飞往{area:442}。{object:177792}在北部海岸外的水下，{area:443}以西。",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "从{area:442}乘船前往{zone:1453}，再飞往{area:108}。向西北骑到海岸：{object:177790}在近岸的海底。",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "乘传送门上到{area:1658}找{npc:4217}。",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "乘{npc:11798}的飞行路线前往{zone:1456}，飞往{zone:1454}，再乘飞艇前往{zone:1420}；{zone:1421}在{zone:1458}以南。{object:177790}在{area:240}以西、{area:228}以北的海岸上。",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792}在{area:382}北缘，风险投资公司的塔旁，{area:380}以北。",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}上。",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",
}
