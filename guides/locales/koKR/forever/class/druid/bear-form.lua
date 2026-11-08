-- Korean (koKR): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["{spell:5487} and {area:493}"] = "{spell:5487}와(과) {area:493}",
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "방어 전담 변신: Forever에서는 더 이상 {spell:5487}을(를) 훈련으로 배울 수 없고, 이 퀘스트들로 얻습니다. {area:493}도 열립니다.",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {area:186} Dolanaar · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "10레벨이 되면 드루이드의 부름이 옵니다: {area:186}의 {npc:3602}, {zone:1457}의 데나타리온, {zone:1453}의 테리드란. 누구든 다르나서스 세나리온 자치령의 {npc:4217}에게 보냅니다.",
	-- {npc:3602} Kal · {area:186} Dolanaar
	["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}, {area:186}. 데나타리온과 테리드란의 편지도 같은 곳으로 안내합니다",

	-- Step 2: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 3: Mathrengyl Bearwalker
	["or whichever of the three letters you carry"] = "또는 가지고 있는 세 편지 중 하나",

	-- Step 4: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5929} Great Bear Spirit · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, past the armor vendor. The {quest:5929} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {area:493} flight path ({npc:10897}, south of the lake) for later, then take {npc:11800}'s flight from the middle of {area:2361}: she flies druids straight to {area:702}, no flight path needed. Take the portal up to {zone:1457}."] = "",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "{quest:5929}와(과) 대화하세요",

	-- Step 7: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands inside the nearest moonkin cave east of the village: the northern of two small rock-pile caves where the {area:442} road meets the main north-south road. Moonkin (level 11-13) stand outside, the cave is empty: slip past them. Use the {item:15208} by the stone: Lunaclaw (level 12-13) walks in towards you and stays three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Another druid's Lunaclaw gives you the spirit too."] = "",

	-- Step 8: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "{area:702}(으)로 날아가 차원문을 타고 {npc:4217}에게 올라가세요.",

	-- Step 9: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "10레벨에 드루이드의 부름이 옵니다: {area:222}의 {npc:3064} 또는 {zone:1456}의 {npc:6746}({zone:1454}의 {npc:6929}이(가) 보낸 편지도 됩니다). 누구든 {zone:1456} {area:1639}의 {npc:3033}에게 보냅니다.",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}, {area:222}. 팔라와 그리쉬카의 편지도 같은 곳으로 안내합니다",

	-- Step 10: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 11: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5930} Great Bear Spirit · {area:2361} Nighthaven · {quest:5922} Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs. The {quest:5930} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {quest:5922} flight path (Faustron, south-west of the lake); {npc:11798} in {area:2361} flies druids to {area:1638}."] = "",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "{quest:5930}와(과) 대화하세요",

	-- Step 13: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1413} Barrens · {area:378} Camp Taurajo · {zone:1412} Mulgore · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the {zone:1413} just south-west of {area:378}, by the road out of {zone:1412}. Level 20 Thunderheads roam close by: clear the way first. Use the {item:15710} by the stone: Lunaclaw (level 12-13) appears for three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Die in the fight? Lunaclaw stays by the stone: run back and finish her."] = "",

	-- Step 14: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "{area:1639}의 {npc:3033}에게 돌아가세요.",

	-- Step 15: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "{area:279}에서 하늘배 타기",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487}은(는) {zone:2521}에서 배웁니다. 아직 섬에 있다면 건너뛰세요. 아니면 {area:279} 북쪽에서 하늘배를 타세요.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "하늘배로 {zone:2521}에 가기",

	-- Step 16: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "{zone:1456}에서 하늘배 타기",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487}은(는) {zone:2521}에서 배웁니다. 아직 섬에 있다면 건너뛰세요. 아니면 {zone:1456} 북쪽, {area:17045} 남쪽 절벽에서 하늘배를 타세요.",

	-- Step 17: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359}은(는) {area:16638}에 있습니다.",

	-- Step 18: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853}와(과) {npc:258443}",
	-- {npc:255853} Urs'endris · {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:255853} waits by the waterfall below the {area:16629}, north-east of {area:16638}. {npc:258443} (the bear you must defeat) lairs in an unmarked cave high on the cliff face west of him, where the {area:16623} meet the {area:16626}: take the path west out of {area:16638} (not north), cross the river on the log bridge and reach the cave from the cliff's upper, northern side. The cave at the foot of the cliffs and the foggy cave are the wrong ones."] = "",

	-- Step 19: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "폭포 옆의 {npc:255853}에게 돌아가세요.",

	-- Step 20: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118}은(는) {zone:2521}에서 오는 비행선이 내리는 곳, {zone:1456} 옆 {zone:1412} 북부에서 기다립니다.",

	-- Step 21: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} trains druids in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 22: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459}은(는) {area:279} 서쪽, {zone:2521}에서 오는 비행정이 내리는 곳에 {npc:259084}, 스카이본 차원문과 함께 있습니다. {npc:2543}도 같은 퀘스트를 줍니다.",

	-- Step 23: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree · {spell:18960} Teleport: Moonglade
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer (the arrow points at him); he teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 24: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, in {area:2361}. Learn the {area:493} flight path while you are here (Faustron for the Horde, south-west of the lake; {npc:10897} for the Alliance, south of it)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. 여기 있는 동안 {area:493} 비행 경로를 배우세요.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {quest:5929}은(는) 북서쪽 숲에 있습니다. {area:493} 비행 경로를 배운 뒤 ({area:442}을(를) 거쳐) {area:702}(으)로 날아가 차원문을 타고 {zone:1457}(으)로 올라가세요.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "{spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. {quest:5930}은(는) 북서쪽 숲에 있습니다. {area:2361}의 {npc:11798}이(가) 드루이드를 {area:1638}(으)로 태워 줍니다.",
	-- ["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{area:702}에서 {area:442}(으)로 날아가세요. {object:177525}은(는) 마을 바로 동쪽 언덕에 있습니다. 그곳에서 {item:15208}을(를) 사용하고, 초승달발톱을 쓰러뜨린 뒤 {npc:12144}와(과) 대화하세요.",
	-- ["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "스카이본 차원문은 {zone:1453}(으)로 연결됩니다. {npc:5504}은(는) 이 도시의 드루이드 상급자입니다.",
	-- ["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{object:177525}은(는) {zone:1412}에서 {zone:1413}(으)로 이어지는 고갯길에 있습니다. 그곳에서 {item:15710}을(를) 사용하고, 초승달발톱을 쓰러뜨린 뒤 {npc:12144}와(과) 대화하세요.",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853}은(는) {area:16638} 북동쪽 폭포 옆에서 기다립니다. {npc:258443}은(는) {area:16638} 서쪽 {area:16623}을(를) 배회합니다.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033}은(는) {area:1639}에 있습니다.",
	-- ["{npc:3033} trains druids on {area:1639}."] = "{npc:3033}은(는) {area:1639}에서 드루이드를 훈련합니다.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217}은(는) {area:1658}에 있습니다.",
}
