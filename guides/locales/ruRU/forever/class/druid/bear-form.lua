-- Russian (ruRU): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5487} Bear Form · {zone:1450} Moonglade
	["{spell:5487} and {zone:1450}"] = "",
	-- {spell:5487} Bear Form · {zone:1450} Moonglade
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {zone:1450} too."] = "",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in Dolanaar, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "",
	-- {npc:3602} Kal
	["{npc:3602}, Dolanaar; Denatharion's and Theridran's letters lead to the same place"] = "",

	-- Step 2: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {quest:5921} Moonglade
	["{npc:4217} stands upstairs in the druids' building of the Cenarion Enclave. He teaches you Teleport: {quest:5921} with the quest (it stays in your spellbook, Balance tab)."] = "",
	["or whichever of the three letters you carry"] = "или любое из трех писем, что у вас есть",

	-- Step 3: Moonglade
	-- {quest:5921} Moonglade · {npc:11802} Dendrite Starblaze · {quest:5929} Great Bear Spirit · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {zone:1457} Darnassus
	["Cast Teleport: {quest:5921}: it lands you beside the building where {npc:11802} stands upstairs, past the armor vendor. The {quest:5929} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from Nighthaven go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast Teleport: {quest:5921} again. Learn the {quest:5921} flight path ({npc:10897}, south of the lake) for later, then take {npc:11800}'s flight from the middle of Nighthaven: she flies druids straight to Rut'theran Village, no flight path needed. Take the portal up to {zone:1457}."] = "",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Поговорите: {quest:5929}",

	-- Step 5: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "Объект: {object:177525}",
	-- {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from Rut'theran Village to Auberdine. The {object:177525} stands inside the nearest moonkin cave east of the village: the northern of two small rock-pile caves where the Auberdine road meets the main north-south road. Moonkin (level 11-13) stand outside, the cave is empty: slip past them. Use the {item:15208} by the stone: Lunaclaw (level 12-13) walks in towards you and stays three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Another druid's Lunaclaw gives you the spirit too."] = "",

	-- Step 6: Body and Heart
	-- {npc:4217} Mathrengyl Bearwalker
	["Fly back to Rut'theran Village and take the portal up to {npc:4217}."] = "",

	-- Step 7: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {object:2968} Bloodhoof Village (no name in this language: may be words) · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words)
	["At 10 a druid's call reaches you: {npc:3064} in {object:2968} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {object:50507} in {zone:1456}."] = "",
	-- {npc:3064} Gennia Runetotem · {object:2968} Bloodhoof Village (no name in this language: may be words)
	["{npc:3064}, {object:2968}; Pala's and Gryshka's letters lead to the same place"] = "",

	-- Step 8: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {quest:5922} Moonglade
	["{npc:3033} stands in the druids' hut on {object:50507}, over the rope bridges east of the lifts. He teaches you Teleport: {quest:5922} with the quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 9: Moonglade
	-- {quest:5922} Moonglade · {npc:11802} Dendrite Starblaze · {quest:5930} Great Bear Spirit · {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff
	["Cast Teleport: {quest:5922}: it lands you beside the building where {npc:11802} stands upstairs. The {quest:5930} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from Nighthaven go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast Teleport: {quest:5922} again. Learn the {quest:5922} flight path (Faustron, south-west of the lake); {npc:11798} in Nighthaven flies druids to {zone:1456}."] = "",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "Поговорите: {quest:5930}",

	-- Step 11: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1413} Barrens · {zone:1412} Mulgore · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the {zone:1413} just south-west of Camp Taurajo, by the road out of {zone:1412}. Level 20 Thunderheads roam close by: clear the way first. Use the {item:15710} by the stone: Lunaclaw (level 12-13) appears for three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Die in the fight? Lunaclaw stays by the stone: run back and finish her."] = "",

	-- Step 12: Body and Heart
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words)
	["Back to {npc:3033} on {object:50507}."] = "",

	-- Step 13: Skyboat from Dalaran
	["Skyboat from Dalaran"] = "",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of Dalaran."] = "",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Небесный корабль: {zone:2521}",

	-- Step 14: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Небесный корабль: {zone:1456}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of Skywatcher Plateau, north of {zone:1456}."] = "",

	-- Step 15: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze
	["{npc:252359} stands in Valanaar."] = "",

	-- Step 16: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853} и {npc:258443}",
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} waits by the waterfall below the Shrine of Akir, north-east of Valanaar. {npc:258443} (the bear you must defeat) lairs in an unmarked cave high on the cliff face west of him, where the Shen'dar Highlands meet the Gustberry Lowlands: take the path west out of Valanaar (not north), cross the river on the log bridge and reach the cave from the cliff's upper, northern side. The cave at the foot of the cliffs and the foggy cave are the wrong ones."] = "",

	-- Step 17: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "Вернитесь: {npc:255853}, у водопада.",

	-- Step 18: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118} ждет там, где приземляется воздушный корабль с острова ({zone:2521}): север зоны {zone:1412}, рядом с {zone:1456}.",

	-- Step 19: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {quest:94913} Moonglade
	["{npc:3033} trains druids in the druids' hut on {object:50507}, over the rope bridges east of the lifts. He teaches you Teleport: {quest:94913} with the next quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 20: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of Dalaran, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "",

	-- Step 21: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree · {quest:94914} Moonglade
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer (the arrow points at him); he teaches you Teleport: {quest:94914} with the next quest (it stays in your spellbook, Balance tab)."] = "",

	-- Step 22: Dendrite Starblaze
	-- {quest:94913} Moonglade · {npc:11802} Dendrite Starblaze · {npc:10897} Sindrayl
	["Cast Teleport: {quest:94913}: it lands you beside the building where {npc:11802} stands upstairs, in Nighthaven. Learn the {quest:94913} flight path while you are here (Faustron for the Horde, south-west of the lake; {npc:10897} for the Alliance, south of it)."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "На 10-м уровне вас зовет друид: {npc:3064} ({area:222}) или {npc:6746} ({zone:1456}; подойдет и письмо: {npc:6929}, {zone:1454}). Любой из них отправляет вас к NPC {npc:3033} ({area:1639}, {zone:1456}).",
	-- ["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "На 10-м уровне вас зовет друид: {npc:3602} ({area:186}), Денатарион ({zone:1457}) или Теридан ({zone:1453}). Любой из них отправляет вас к NPC {npc:4217} (Анклав Кенария, Дарнасс).",
	-- ["Back to {npc:3033} on {area:1639}."] = "Вернитесь: {npc:3033} ({area:1639}).",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}. Заодно узнайте маршрут полета: {area:493}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}; {quest:5929} – в лесу к северо-западу. Узнайте маршрут полета ({area:493}), затем летите сюда: {area:702} (через {area:442}) – и поднимитесь через портал: {zone:1457}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}; {quest:5930} – в лесу к северо-западу. {npc:11798} ({area:2361}) отвозит друидов сюда: {area:1638}.",
	-- ["Fly back to {area:702} and take the portal up to {npc:4217}."] = "Летите обратно в {area:702} и поднимитесь через портал к {npc:4217}.",
	-- ["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Летите из места {area:702} в {area:442}. {object:177525} стоит на холмах чуть восточнее деревни: используйте там {item:15208}, победите Лунокогтя и поговорите: {npc:12144}.",
	-- ["Skyboat from {area:279}"] = "Небесный корабль: {area:279}",
	-- ["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "Портал Небеснорожденных ведет сюда: {zone:1453}. {npc:5504} — городской учитель друидов.",
	-- ["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{object:177525} стоит в ущелье на пути из зоны {zone:1412} в {zone:1413}. Используйте там {item:15710}, победите Лунокогтя и поговорите: {npc:12144}.",
	-- ["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "Ваш облик танка: в Forever {spell:5487} больше не изучают у учителя, его дают эти задания. Также открывает {area:493}.",
	-- ["{npc:252359} stands in {area:16638}."] = "{npc:252359} стоит здесь: {area:16638}.",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853} ждет у водопада к северо-востоку от места {area:16638}. {npc:258443} рыщет здесь: {area:16623}, к западу от {area:16638}.",
	-- ["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459} стоит рядом с NPC {npc:259084} и порталом Небеснорожденных к западу от места {area:279}, где приземляется небесный катер с острова ({zone:2521}). {npc:2543} дает то же задание.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} стоит здесь: {area:1639}.",
	-- ["{npc:3033} trains druids on {area:1639}."] = "{npc:3033} обучает друидов здесь: {area:1639}.",
	-- ["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}, {area:222}; письма Палы и Гришки ведут туда же",
	-- ["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}, {area:186}; письма Денатариона и Теридана ведут туда же",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} стоит здесь: {area:1658}.",
	-- ["{spell:5487} and {area:493}"] = "{spell:5487} и {area:493}",
	-- ["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487} обучают здесь: {zone:2521}. Пропустите, если вы еще на острове; иначе сядьте на небесный корабль со скал к югу от места {area:17045}, к северу от {zone:1456}.",
	-- ["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487} обучают здесь: {zone:2521}. Пропустите, если вы еще на острове; иначе сядьте на небесный корабль с северной стороны места {area:279}.",
}
