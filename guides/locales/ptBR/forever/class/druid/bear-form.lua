-- Portuguese (Brazil) (ptBR): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["{spell:5487} and {area:493}"] = "{spell:5487} e {area:493}",
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "Sua forma de tanque: o Forever não ensina mais {spell:5487} no instrutor; estas missões a concedem. Também liberam {area:493}.",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {area:186} Dolanaar · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "No nível 10, o chamado dos druidas chega até você: {npc:3602} em {area:186}, Denatharion em {zone:1457} ou Theridran em {zone:1453}. Qualquer um deles envia você a {npc:4217} no Enclave Cenariano de Darnassus.",
	-- {npc:3602} Kal · {area:186} Dolanaar
	["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}, {area:186}; as cartas de Denatharion e Theridran levam ao mesmo lugar",

	-- Step 2: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} fica no {area:1658}.",
	["or whichever of the three letters you carry"] = "ou qualquer uma das três cartas que você tiver",

	-- Step 3: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village · {area:442} Auberdine · {zone:1457} Darnassus
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5929} fica na mata a noroeste. Aprenda a rota de voo de {area:493}, depois voe até {area:702} (passando por {area:442}) e pegue o portal até {zone:1457}.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Fale com o {quest:5929}",

	-- Step 5: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "A {object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Voe de {area:702} até {area:442}. A {object:177525} fica nas colinas logo a leste da vila: use a {item:15208} lá, derrote Lunagarra e fale com o {npc:12144}.",

	-- Step 6: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "Volte voando para {area:702} e pegue o portal até {npc:4217}.",

	-- Step 7: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "No nível 10, o chamado dos druidas chega até você: {npc:3064} em {area:222} ou {npc:6746} em {zone:1456} (a carta de {npc:6929} em {zone:1454} também serve). Qualquer um deles envia você a {npc:3033} no {area:1639}, em {zone:1456}.",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}, {area:222}; as cartas de Pala e Gryshka levam ao mesmo lugar",

	-- Step 8: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} fica no {area:1639}.",

	-- Step 9: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5930} fica na mata a noroeste. {npc:11798}, em {area:2361}, leva druidas voando até {area:1638}.",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "Fale com o {quest:5930}",

	-- Step 11: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1412} Mulgore · {zone:1413} Barrens · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "A {object:177525} fica na passagem de {zone:1412} para {zone:1413}. Use a {item:15710} lá, derrote Lunagarra e fale com o {npc:12144}.",

	-- Step 12: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "Volte a {npc:3033} no {area:1639}.",

	-- Step 13: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste de {area:279}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487} é ensinada na {zone:2521}. Pule isto se ainda estiver na ilha; senão, pegue o barco celeste no lado norte de {area:279}.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste para a {zone:2521}",

	-- Step 14: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste de {zone:1456}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487} é ensinada na {zone:2521}. Pule isto se ainda estiver na ilha; senão, pegue o barco celeste nos penhascos ao sul de {area:17045}, ao norte de {zone:1456}.",

	-- Step 15: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359} fica em {area:16638}.",

	-- Step 16: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853} e {npc:258443}",
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853} espera junto às cachoeiras a nordeste de {area:16638}. {npc:258443} ronda {area:16623}, a oeste de {area:16638}.",

	-- Step 17: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "Volte a {npc:255853}, junto às cachoeiras.",

	-- Step 18: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118} espera onde a aeronave vinda da {zone:2521} pousa, no norte de {zone:1412}, junto a {zone:1456}.",

	-- Step 19: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} trains druids on {area:1639}."] = "{npc:3033} treina druidas no {area:1639}.",

	-- Step 20: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459} fica ao lado de {npc:259084} e do Portal Celonato, a oeste de {area:279}, onde pousa a nave celeste vinda da {zone:2521}. {npc:2543} oferece a mesma missão.",

	-- Step 21: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "O Portal Celonato leva você a {zone:1453}. {npc:5504} é o instrutor de druidas da cidade.",

	-- Step 22: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Aprenda a rota de voo de {area:493} enquanto estiver lá.",
}
