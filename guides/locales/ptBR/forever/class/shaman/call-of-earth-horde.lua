-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-earth-horde (forever/class/shaman/call-of-earth-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1516} Call of Earth
	["{quest:1516} (Horde)"] = "{quest:1516} (Horda)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Seu {item:5175}: sem ele, nenhum totem de terra pode ser lançado. {spell:8071} vem junto, no nível 4.",

	-- Step 1: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {area:363} Valley of Trials
	["{npc:5887} stands just outside the Den, the cave in the middle of the {area:363}. The quest opens at level 4."] = "{npc:5887} fica logo fora da Toca, a caverna no meio de {area:363}. A missão abre no nível 4.",

	-- Step 2: Felstalker Hooves
	["Felstalker Hooves"] = "Cascos de Espreitador Vil",
	-- {area:365} Burning Blade Coven · {npc:3102} Felstalker
	-- plural, as words: Felstalkers = {npc:3102} Felstalker · Vile Familiars = {npc:3101} Vile Familiar
	["Felstalkers (level 3-4) prowl the slope below the {area:365}, the cave in the north of the valley, and just inside its mouth among the Vile Familiars. Nearly every {npc:3102} drops a hoof (four kills in five); they respawn in a little over three minutes."] = "Os Espreitadores Vis (nível 3-4) rondam a encosta embaixo de {area:365}, a caverna no norte do vale, e logo dentro da boca dela, entre os Familiares torpes. Quase todo {npc:3102} solta um casco (quatro mortes em cinco); voltam em pouco mais de três minutos.",

	-- Step 3: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {quest:1462} Earth Sapta
	["Back to {npc:5887} outside the Den. She hands you the {quest:1462}: do not drink it yet."] = "De volta a {npc:5887}, fora da Toca. Ela entrega {quest:1462} a você: não beba ainda.",

	-- Step 4: Lost the Earth Sapta?
	-- {quest:1463} Earth Sapta
	["Lost the {quest:1463}?"] = "Perdeu {quest:1463}?",
	-- {quest:1463} Earth Sapta · {npc:5887} Canaga Earthcaller
	["Only if the {quest:1463} is gone from your bags (drunk away from the rock, or sold): {npc:5887} gives you another."] = "Só se {quest:1463} sumiu das suas bolsas (bebida longe da pedra, ou vendida): {npc:5887} entrega outra.",
	-- {npc:5887} Canaga Earthcaller · {quest:1463} Earth Sapta
	["{npc:5887}: a new {quest:1463}"] = "{npc:5887}: uma nova {quest:1463}",

	-- Step 5: Spirit Rock
	-- {area:639} Spirit Rock · {area:638} Hidden Path · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:639} sits on a ledge in the hills just south of the Den. The {area:638} up starts at the foot of the hills south-west of the Den, between two idle peons; it climbs south-west into the hills, then bends back east to the rock. Stand right beside the stone and drink the {item:6635}: the {npc:5891} appears for a short while, so speak to it at once (walk almost under it if it does not answer). Coming back, you can drop down the ledge towards the Den instead of walking the path."] = "{area:639} fica numa saliência nas colinas, logo ao sul da Toca. A {area:638} começa ao pé das colinas, a sudoeste da Toca, entre dois peões parados; sobe para sudoeste pelas colinas e depois dobra de volta para leste até a pedra. Fique bem ao lado da pedra e beba {item:6635}: {npc:5891} aparece por pouco tempo, então fale com ele na hora (ande quase para debaixo dele se não responder). Na volta, você pode descer pela saliência em direção à Toca em vez de seguir a trilha.",
	-- {item:6635} Earth Sapta · {area:639} Spirit Rock
	["{item:6635}, beside {area:639}"] = "{item:6635}, ao lado de {area:639}",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "ele entrega {item:6656} a você: guarde",

	-- Step 6: Canaga Earthcaller
	-- {item:6656} Rough Quartz · {npc:5887} Canaga Earthcaller · {item:5175} Earth Totem
	["Bring the {item:6656} back to {npc:5887} outside the Den. Keep the {item:5175} she gives you in your bags for good: every earth totem needs it."] = "Leve {item:6656} de volta a {npc:5887}, fora da Toca. Guarde para sempre nas suas bolsas {item:5175}, que ela entrega: todo totem de terra precisa dele.",
	-- {npc:5887} Canaga Earthcaller · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {spell:8071} and your {item:5175}"] = "{npc:5887}: {spell:8071} e seu {item:5175}",
	["the level 4 shaman spells"] = "as magias de xamã do nível 4",

	-- Step 7: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache
	["{npc:5888} stands in {area:221}. She may show no quest mark over her head: speak to her anyway. The quest opens at level 4."] = "{npc:5888} fica em {area:221}. Pode não ter marca de missão sobre a cabeça: fale com ela mesmo assim. A missão abre no nível 4.",

	-- Step 8: Ritual Salve
	-- {area:358} Brambleblade Ravine · {spell:403} Lightning Bolt
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["The Bristleback Shamans (level 3-4) stand among the quilboar huts of {area:358}, east of the camp, and throw the odd {spell:403}. Four kills in five drop a salve; they respawn in about four minutes."] = "Os Xamãs Costagulha (nível 3-4) ficam entre as cabanas dos quilboar de {area:358}, a leste do acampamento, e jogam um {spell:403} de vez em quando. Quatro mortes em cinco soltam um ungüento; voltam em cerca de quatro minutos.",

	-- Step 9: Seer Ravenfeather
	-- {area:221} Camp Narache · {quest:1462} Earth Sapta
	["Back to the Seer in {area:221}. She hands you the {quest:1462}: do not drink it yet."] = "De volta à Vidente, em {area:221}. Ela entrega {quest:1462} a você: não beba ainda.",

	-- Step 10: Lost the Earth Sapta?
	-- {quest:1462} Earth Sapta
	["Lost the {quest:1462}?"] = "Perdeu {quest:1462}?",
	-- {quest:1462} Earth Sapta
	["Only if the {quest:1462} is gone from your bags: the Seer gives you another."] = "Só se {quest:1462} sumiu das suas bolsas: a Vidente entrega outra.",
	-- {npc:5888} Seer Ravenfeather · {quest:1462} Earth Sapta
	["{npc:5888}: a new {quest:1462}"] = "{npc:5888}: uma nova {quest:1462}",

	-- Step 11: Kodo Rock
	-- {area:637} Kodo Rock · {npc:2991} Greatmother Hawkwind · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:637} is a small pillar on a low mound due east of {npc:2991}'s well, east of the camp; it only shows from about fifteen yards away, and hostile boars graze around it. Stand beside it and drink the {item:6635}, then speak to the {npc:5891} before it fades (drink again if it does)."] = "{area:637} é um pilar pequeno num montículo baixo, bem a leste do poço de {npc:2991}, a leste do acampamento; só aparece a uns quinze metros, e javalis hostis pastam em volta. Fique ao lado dele, beba {item:6635} e fale com {npc:5891} antes que ele suma (beba de novo se sumir).",
	-- {item:6635} Earth Sapta · {area:637} Kodo Rock
	["{item:6635}, beside {area:637}"] = "{item:6635}, ao lado de {area:637}",

	-- Step 12: Seer Ravenfeather
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to the Seer. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Leve {item:6656} de volta à Vidente. Guarde {item:5175} nas suas bolsas para sempre: todo totem de terra precisa dele.",
	-- {npc:5888} Seer Ravenfeather · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {spell:8071} and your {item:5175}"] = "{npc:5888}: {spell:8071} e seu {item:5175}",

	-- Step 13: Windshaper Boro
	-- {npc:251374} Windshaper Boro · {area:16635} Thendal Village
	["{npc:251374}, the shaman trainer, stands in {area:16635}. The quest opens at level 3."] = "{npc:251374}, o instrutor de xamã, fica em {area:16635}. A missão abre no nível 3.",

	-- Step 14: Signet of Akir
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["Any Al'Aketh cultist can carry the {item:251924}: the Converts (level 2-3) around the standing stones just east of the village, or the Brutes and Neophytes (level 4) in the camp beyond {npc:252095}, south-west of the village. Keep killing until one drops it."] = "Qualquer cultista de Al'Aketh pode carregar {item:251924}: os Convertidos (nível 2-3) em volta das pedras erguidas logo a leste da vila, ou os Brutamontes e Neófitos (nível 4) no acampamento depois de {npc:252095}, a sudoeste da vila. Continue matando até um soltar.",

	-- Step 15: Windshaper Boro
	-- {area:16635} Thendal Village · {quest:1462} Earth Sapta
	["Back to Boro in {area:16635}. He hands you the {quest:1462}: do not drink it yet."] = "De volta a Boro, em {area:16635}. Ele entrega {quest:1462} a você: não beba ainda.",

	-- Step 16: The Rise of Spirits
	-- {area:16988} Rise of Spirits
	["The {area:16988}"] = "{area:16988}",
	-- {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth
	["The {area:16988} is the hilltop shrine north-east of Boro: the path up starts on the hill just above the clearing where the flies were. Drink the {item:6635} beside the shrine and speak to the {npc:251166} before it fades."] = "{area:16988} é o santuário no topo do morro a nordeste de Boro: a trilha para subir começa no morro, logo acima da clareira onde estavam as moscas. Beba {item:6635} ao lado do santuário e fale com {npc:251166} antes que ele suma.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the shrine"] = "{item:6635}, ao lado do santuário",

	-- Step 17: Windshaper Boro
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to Boro. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Leve {item:6656} de volta a Boro. Guarde {item:5175} nas suas bolsas para sempre: todo totem de terra precisa dele.",
	-- {npc:251374} Windshaper Boro · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {spell:8071} and your {item:5175}"] = "{npc:251374}: {spell:8071} e seu {item:5175}",
}
