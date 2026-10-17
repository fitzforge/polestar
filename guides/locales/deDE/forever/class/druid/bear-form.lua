-- German (deDE): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["{spell:5487} and {area:493}"] = "{spell:5487} und {area:493}",
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "Deine Tankgestalt: Forever lehrt {spell:5487} nicht mehr beim Lehrer, diese Quests geben sie dir. Schaltet auch {area:493} frei.",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {area:186} Dolanaar · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "Mit Stufe 10 erreicht dich der Ruf eines Druiden: {npc:3602} in {area:186}, Denatharion in {zone:1457} oder Theridran in {zone:1453}. Jeder von ihnen schickt dich zu {npc:4217} in der Enklave des Cenarius in Darnassus.",
	-- {npc:3602} Kal · {area:186} Dolanaar
	["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}, {area:186}; die Briefe von Denatharion und Theridran führen zum selben Ort",

	-- Step 2: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} steht im Gebiet {area:1658}.",
	["or whichever of the three letters you carry"] = "oder welchen der drei Briefe du auch hast",

	-- Step 3: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village · {area:442} Auberdine · {zone:1457} Darnassus
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}; {quest:5929} sitzt im Wald im Nordwesten. Hol dir die Flugroute von {area:493}, flieg dann nach {area:702} (über {area:442}) und nimm das Portal hinauf nach {zone:1457}.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Sprich mit dem {quest:5929}",

	-- Step 5: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "Der {object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Flieg von {area:702} nach {area:442}. Der {object:177525} steht in den Hügeln direkt östlich des Dorfes: Benutze dort den {item:15208}, besiege Mondklaue und sprich mit dem {npc:12144}.",

	-- Step 6: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "Flieg zurück nach {area:702} und nimm das Portal hinauf zu {npc:4217}.",

	-- Step 7: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "Mit Stufe 10 erreicht dich der Ruf eines Druiden: {npc:3064} in {area:222} oder {npc:6746} in {zone:1456} (der Brief von {npc:6929} in {zone:1454} geht auch). Jeder von ihnen schickt dich zu {npc:3033} im Gebiet {area:1639} in {zone:1456}.",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}, {area:222}; die Briefe von Pala und Gryshka führen zum selben Ort",

	-- Step 8: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} steht im Gebiet {area:1639}.",

	-- Step 9: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}; {quest:5930} sitzt im Wald im Nordwesten. {npc:11798} in {area:2361} fliegt Druiden nach {area:1638}.",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "Sprich mit dem {quest:5930}",

	-- Step 11: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1412} Mulgore · {zone:1413} Barrens · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Der {object:177525} steht im Pass von {zone:1412} ins {zone:1413}. Benutze dort den {item:15710}, besiege Mondklaue und sprich mit dem {npc:12144}.",

	-- Step 12: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "Zurück zu {npc:3033} im Gebiet {area:1639}.",

	-- Step 13: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Himmelsboot ab {area:279}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487} wird auf {zone:2521} gelehrt. Überspring das, wenn du noch auf der Insel bist; sonst nimm das Himmelsboot an der Nordseite von {area:279}.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Himmelsboot nach {zone:2521}",

	-- Step 14: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Himmelsboot ab {zone:1456}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487} wird auf {zone:2521} gelehrt. Überspring das, wenn du noch auf der Insel bist; sonst nimm das Himmelsboot an den Klippen südlich des {area:17045}, nördlich von {zone:1456}.",

	-- Step 15: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359} steht in {area:16638}.",

	-- Step 16: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853} und {npc:258443}",
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853} wartet an den Wasserfällen nordöstlich von {area:16638}. {npc:258443} streift durchs {area:16623}, westlich von {area:16638}.",

	-- Step 17: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "Zurück zu {npc:255853} an den Wasserfällen.",

	-- Step 18: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118} wartet dort, wo das Luftschiff von {zone:2521} landet, im Norden von {zone:1412} neben {zone:1456}.",

	-- Step 19: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} trains druids on {area:1639}."] = "{npc:3033} bildet Druiden im Gebiet {area:1639} aus.",

	-- Step 20: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459} steht neben {npc:259084} und dem Portal der Himmelsgeborenen, westlich von {area:279}, wo der Himmelssegler von {zone:2521} landet. {npc:2543} bietet dieselbe Quest an.",

	-- Step 21: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "Das Portal der Himmelsgeborenen bringt dich nach {zone:1453}. {npc:5504} ist der Druidenlehrer der Stadt.",

	-- Step 22: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}. Hol dir hier gleich die Flugroute von {area:493}.",
}
