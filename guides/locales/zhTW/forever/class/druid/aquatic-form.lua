-- Chinese (traditional) (zhTW): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "你的水中旅行形態：快速游泳並能在水下呼吸，另外還有一條腰帶和一個塑像。",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. Skyborne: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up."] = "",

	-- Step 3: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:29} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:29} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，來自湖中的{object:177785}",
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
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}：在神殿組合兩半",

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
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:28} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:28} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "",

	-- Step 11: Half Pendant of Aquatic Agility
	-- {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:1637} Orgrimmar · {object:177792} Strange Lockbox · {area:382} Sludge Fen
	["Take {npc:11798}'s flight to {area:1638} and fly on to {area:1637}. The {object:177792} lies underwater in the {area:382} pond, a short walk out of {area:1637}'s west gate, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["Back through {area:1637} to the zeppelin towers outside its main gate: the zeppelin to the {zone:1458} lands in {zone:1420}, and {zone:1421} is south of the {zone:1458}."] = "",

	-- Step 13: Half Pendant of Aquatic Endurance
	-- {object:177790} Strange Lockbox · {area:228} Sepulcher · {spell:18960} Teleport: Moonglade
	["The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down. Then {spell:18960} takes you straight back."] = "",

	-- Step 14: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:11798} flies druids to {area:1638}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "施放{spell:18960}。在湖的西北岸、{area:2362}附近把兩半組合成{item:15885}，然後去{area:2361}找{npc:11802}。之後飛往{area:702}。",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "施放{spell:18960}。在湖的西北岸、{area:2362}附近把兩半組合成{item:15885}，然後去{area:2361}找{npc:11802}。{npc:11798}會載德魯伊飛往{area:1638}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。神殿靈珠在{area:2361}下方{area:656}湖底的容器裡：拿一個到西北岸的{area:2362}，在那裡使用它，然後與{npc:11799}交談。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。神殿靈珠躺在{area:656}的湖底，幾分鐘內就會消失：拿到一個後直接游到西北岸的{area:2362}，在那裡使用它，然後與{npc:11799}交談。",
	-- ["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "從{area:2361}飛往{area:442}。{object:177792}在北岸外的水下，{area:443}西邊。",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "從{area:442}搭船前往{zone:1453}，再飛往{area:108}。向西北騎到海岸：{object:177790}在岸外的海底。",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "搭傳送門上去，到{area:1658}找{npc:4217}。",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "搭{npc:11798}的飛行路線前往{zone:1456}，飛往{zone:1454}，再搭飛艇前往{zone:1420}；{zone:1421}在{zone:1458}南邊。{object:177790}在{area:228}北邊、{area:240}西邊的海岸上。",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792}在{area:382}北緣、風險投資公司的塔旁，{area:380}北邊。",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",
}
