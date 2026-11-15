-- Portuguese (Brazil) (ptBR): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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

	-- Step 2: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "{npc:4217} fica no andar de cima do prédio dos druidas em {area:1658}. Ele ensina {spell:18960} junto com a missão (fica no seu grimório, aba Equilíbrio).",

	-- Step 3: Mathrengyl Bearwalker
	["or whichever of the three letters you carry"] = "ou qualquer uma das três cartas que você tiver",

	-- Step 4: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5929} Great Bear Spirit · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, past the armor vendor. The {quest:5929} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {area:493} flight path ({npc:10897}, south of the lake) for later, then take {npc:11800}'s flight from the middle of {area:2361}: she flies druids straight to {area:702}, no flight path needed. Take the portal up to {zone:1457}."] = "Use {spell:18960}: você pousa ao lado do prédio onde {npc:11802} fica no andar de cima, depois do mercador de armaduras. O {quest:5929} fica na mata a noroeste. Fale com ele e passe por todas as falas (o que ele representa, a força do corpo, a força do coração, e por fim peça a bênção): a conversa é o objetivo, não tem luta. Ele se confunde com o chão, não tem marcador de missão e solta um brilho cinza-azulado fraquinho perto de um grupo de três árvores: de {area:2361}, siga para oeste pelo pé das montanhas do norte, pela brecha entre as árvores e as colinas. Se {npc:11802} não estiver lá quando você voltar, saia do prédio e use {spell:18960} de novo. Aprenda a rota de voo de {area:493} ({npc:10897}, ao sul do lago) para depois e pegue o voo de {npc:11800} no meio de {area:2361}: ela leva druidas direto para {area:702}, sem precisar de rota de voo. Suba pelo portal até {zone:1457}.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Fale com o {quest:5929}",

	-- Step 7: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "A {object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands inside the nearest moonkin cave east of the village: the northern of two small rock-pile caves where the {area:442} road meets the main north-south road. Moonkin (level 11-13) stand outside, the cave is empty: slip past them. Use the {item:15208} by the stone: Lunaclaw (level 12-13) walks in towards you and stays three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Another druid's Lunaclaw gives you the spirit too."] = "Voe de {area:702} para {area:442}. A {object:177525} fica dentro da caverna luniscante mais perto, a leste da vila: a do norte, entre duas cavernas pequenas de pedras empilhadas onde a estrada de {area:442} encontra a estrada principal norte-sul. Luniscantes (nível 11-13) ficam do lado de fora e a caverna está vazia: passe de fininho por eles. Use a {item:15208} junto à pedra: Lunagarra (nível 12-13) vem andando até você e fica três minutos. Mate-a, depois fale com o {npc:12144} que aparece e peça a força do corpo e do coração dela: a conversa é que conta. A Lunagarra de outro druida também dá o espírito para você.",

	-- Step 8: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "Volte voando para {area:702} e pegue o portal até {npc:4217}.",

	-- Step 9: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "No nível 10, o chamado dos druidas chega até você: {npc:3064} em {area:222} ou {npc:6746} em {zone:1456} (a carta de {npc:6929} em {zone:1454} também serve). Qualquer um deles envia você a {npc:3033} no {area:1639}, em {zone:1456}.",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}, {area:222}; as cartas de Pala e Gryshka levam ao mesmo lugar",

	-- Step 10: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "{npc:3033} fica na cabana dos druidas em {area:1639}, depois das pontes de corda a leste dos elevadores. Ele ensina {spell:18960} junto com a missão (fica no seu grimório, aba Equilíbrio).",

	-- Step 11: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5930} Great Bear Spirit · {area:2361} Nighthaven · {quest:5922} Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs. The {quest:5930} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {quest:5922} flight path (Faustron, south-west of the lake); {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Use {spell:18960}: você pousa ao lado do prédio onde {npc:11802} fica no andar de cima. O {quest:5930} fica na mata a noroeste. Fale com ele e passe por todas as falas (o que ele representa, a força do corpo, a força do coração, e por fim peça a bênção): a conversa é o objetivo, não tem luta. Ele se confunde com o chão, não tem marcador de missão e solta um brilho cinza-azulado fraquinho perto de um grupo de três árvores: de {area:2361}, siga para oeste pelo pé das montanhas do norte, pela brecha entre as árvores e as colinas. Se {npc:11802} não estiver lá quando você voltar, saia do prédio e use {spell:18960} de novo. Aprenda a rota de voo de {quest:5922} (Faustron, a sudoeste do lago); {npc:11798}, em {area:2361}, leva druidas voando para {area:1638}.",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "Fale com o {quest:5930}",

	-- Step 13: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1413} Barrens · {area:378} Camp Taurajo · {zone:1412} Mulgore · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the {zone:1413} just south-west of {area:378}, by the road out of {zone:1412}. Level 20 Thunderheads roam close by: clear the way first. Use the {item:15710} by the stone: Lunaclaw (level 12-13) appears for three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Die in the fight? Lunaclaw stays by the stone: run back and finish her."] = "A {object:177525} fica em {zone:1413}, logo a sudoeste de {area:378}, junto à estrada que sai de {zone:1412}. Cabeças-de-trovão de nível 20 andam por perto: limpe o caminho antes. Use o {item:15710} junto à pedra: Lunagarra (nível 12-13) aparece por três minutos. Mate-a, depois fale com o {npc:12144} que aparece e peça a força do corpo e do coração dela: a conversa é que conta. Morreu na luta? A Lunagarra fica junto à pedra: volte correndo e termine o serviço.",

	-- Step 14: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "Volte a {npc:3033} no {area:1639}.",

	-- Step 15: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste de {area:279}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487} é ensinada na {zone:2521}. Pule isto se ainda estiver na ilha; senão, pegue o barco celeste no lado norte de {area:279}.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste para a {zone:2521}",

	-- Step 16: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste de {zone:1456}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487} é ensinada na {zone:2521}. Pule isto se ainda estiver na ilha; senão, pegue o barco celeste nos penhascos ao sul de {area:17045}, ao norte de {zone:1456}.",

	-- Step 17: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359} fica em {area:16638}.",

	-- Step 18: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853} e {npc:258443}",
	-- {npc:255853} Urs'endris · {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:255853} waits by the waterfall below the {area:16629}, north-east of {area:16638}. {npc:258443} (the bear you must defeat) lairs in an unmarked cave high on the cliff face west of him, where the {area:16623} meet the {area:16626}: take the path west out of {area:16638} (not north), cross the river on the log bridge and reach the cave from the cliff's upper, northern side. The cave at the foot of the cliffs and the foggy cave are the wrong ones."] = "{npc:255853} espera junto à cachoeira abaixo de {area:16629}, a nordeste de {area:16638}. {npc:258443} (a ursa que você precisa derrotar) tem o covil numa caverna sem marcação no alto do paredão a oeste dele, onde {area:16623} encontra {area:16626}: pegue a trilha que sai de {area:16638} para oeste (não para o norte), atravesse o rio pela ponte de tronco e chegue à caverna pelo lado de cima, o norte do penhasco. A caverna no pé do penhasco e a caverna da neblina são as erradas.",

	-- Step 19: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "Volte a {npc:255853}, junto às cachoeiras.",

	-- Step 20: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118} espera onde a aeronave vinda da {zone:2521} pousa, no norte de {zone:1412}, junto a {zone:1456}.",

	-- Step 21: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} trains druids in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "{npc:3033} treina druidas na cabana dos druidas em {area:1639}, depois das pontes de corda a leste dos elevadores. Ele ensina {spell:18960} junto com a próxima missão (fica no seu grimório, aba Equilíbrio).",

	-- Step 22: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459} fica ao lado de {npc:259084} e do Portal Celonato, a oeste de {area:279}, onde pousa o barco celeste vindo da {zone:2521}. {npc:2543} oferece a mesma missão.",

	-- Step 23: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree · {spell:18960} Teleport: Moonglade
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer (the arrow points at him); he teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "O Portal Celonato leva você a {zone:1453}. {npc:5504} é o instrutor de druida da cidade (a seta aponta para ele); ele ensina {spell:18960} junto com a próxima missão (fica no seu grimório, aba Equilíbrio).",

	-- Step 24: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, in {area:2361}. Learn the {area:493} flight path while you are here (Faustron for the Horde, south-west of the lake; {npc:10897} for the Alliance, south of it)."] = "Use {spell:18960}: você pousa ao lado do prédio onde {npc:11802} fica no andar de cima, em {area:2361}. Aprenda a rota de voo de {area:493} já que está aqui (Faustron para a Horda, a sudoeste do lago; {npc:10897} para a Aliança, ao sul dele).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}. Aprenda a rota de voo de {area:493} enquanto estiver lá.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5929} fica na mata a noroeste. Aprenda a rota de voo de {area:493}, depois voe até {area:702} (passando por {area:442}) e pegue o portal até {zone:1457}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Lance {spell:18960}. {npc:11802} está em {area:2361}; {quest:5930} fica na mata a noroeste. {npc:11798}, em {area:2361}, leva druidas voando até {area:1638}.",
	-- ["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Voe de {area:702} até {area:442}. A {object:177525} fica nas colinas logo a leste da vila: use a {item:15208} lá, derrote Lunagarra e fale com o {npc:12144}.",
	-- ["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "O Portal Celonato leva você a {zone:1453}. {npc:5504} é o instrutor de druidas da cidade.",
	-- ["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "A {object:177525} fica na passagem de {zone:1412} para {zone:1413}. Use a {item:15710} lá, derrote Lunagarra e fale com o {npc:12144}.",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853} espera junto às cachoeiras a nordeste de {area:16638}. {npc:258443} ronda {area:16623}, a oeste de {area:16638}.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} fica no {area:1639}.",
	-- ["{npc:3033} trains druids on {area:1639}."] = "{npc:3033} treina druidas no {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} fica no {area:1658}.",
}
