-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-water-alliance (forever/class/shaman/call-of-water-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94494} Call of Water
	["{quest:94494} (Alliance)"] = "{quest:94494} (Aliança)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "O {item:5177}, que permite colocar totens de água, e {spell:5394} junto.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:258043} Norric Lochthane · {zone:1432} Loch Modan
	["At 20 {npc:258098}, the shaman trainer in {zone:1455}'s {object:32362}, sends you to {npc:258043} in {zone:1432}."] = "No nível 20, {npc:258098}, o instrutor de xamãs na {object:32362} de {zone:1455}, envia você a {npc:258043} em {zone:1432}.",

	-- Step 2: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam · {area:144} Thelsamar
	["{npc:258043}'s burrow hut stands on the north-western shore of the loch, below {area:146}, north of {area:144}."] = "A cabana-toca de {npc:258043} fica na margem noroeste do lago, embaixo de {area:146}, ao norte de {area:144}.",

	-- Step 3: Hervdana Saegrund
	-- {npc:258203} Hervdana Saegrund · {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan
	["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}, east of {area:836}: not in a town. Through the Algaz tunnel north of {zone:1432}, then east off the road."] = "A família de {npc:258203} mora numa caverna embaixo das quedas-d'água do sul de {zone:1437}, a leste de {area:836}: não numa cidade. Pelo túnel de Algaz, ao norte de {zone:1432}, e depois para leste, saindo da estrada.",

	-- Step 4: The brown waterskin
	["The brown waterskin"] = "O odre marrom",
	-- {item:265732} Unfilled Brown Waterskin · {npc:258203} Hervdana Saegrund · {object:147516} Dark Iron (no name in this language: may be words)
	["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish. {object:147516} dwarves roam near the falls."] = "Encha o {item:265732} no pé das cachoeiras abaixo da caverna de {npc:258203}, onde a água doce encontra a salobra. Anões {object:147516} rondam perto das cachoeiras.",

	-- Step 6: The red waterskin
	["The red waterskin"] = "O odre vermelho",
	-- {area:71} Stonewatch Falls · {area:68} Lake Everstill · {zone:1455} Ironforge · {area:69} Lakeshire · {item:265747} Unfilled Red Waterskin · {npc:258203} Hervdana Saegrund
	-- plural, as words: Murloc Nightcrawlers = {npc:544} Murloc Nightcrawler
	["{area:71} pour out of {area:68} at the east end of Redridge (fly from {zone:1455} to {area:69}). Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather; pull the murlocs off the spot first. If the skin vanishes without counting, abandon the quest and take it again from {npc:258203} for a new one."] = "{area:71} jorram de {area:68}, no extremo leste de Cristarrubra (voe de {zone:1455} até {area:69}). Encha {item:265747} ao pé deles, onde se reúnem os Reptantes Murloc; tire os murlocs do ponto primeiro. Se o odre sumir sem contar, abandone a missão e pegue de novo com {npc:258203} para receber um novo.",

	-- Step 8: The blue waterskin
	["The blue waterskin"] = "O odre azul",
	-- {area:150} Menethil Harbor · {area:442} Auberdine · {area:271} Southshore · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {item:265772} Unfilled Blue Waterskin
	["Take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then fly or walk south through {zone:1439} to {area:415} in {zone:1440}. Fill the {item:265772} in the lake around the town, then the boat back to Menethil."] = "Pegue o barco de {area:150} até {area:442} (ele para em {area:271} no caminho), depois voe ou ande para o sul por {zone:1439} até {area:415}, em {zone:1440}. Encha {item:265772} no lago em volta da cidade, depois pegue o barco de volta a Menethil.",

	-- Step 9: Hervdana Saegrund
	-- {item:7810} Vial of Purest Water · {npc:258043} Norric Lochthane
	["the {item:7810}, for {npc:258043}"] = "o {item:7810}, para {npc:258043}",

	-- Step 10: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam · {item:7810} Vial of Purest Water · {item:6637} Water Sapta · {item:7811} Remaining Drops of Purest Water · {zone:1436} Westfall
	["Back to {npc:258043} by {area:146} with the {item:7810}. He hands you the {item:6637} and the {item:7811}: keep both for {zone:1436}."] = "De volta a {npc:258043}, perto de {area:146}, com {item:7810}. Ele entrega {item:6637} e {item:7811} a você: guarde os dois para {zone:1436}.",
	-- {npc:258043} Norric Lochthane · {item:6637} Water Sapta
	["{npc:258043}: your {item:6637}"] = "{npc:258043}: sua {item:6637}",

	-- Step 11: Lost the Water Sapta?
	-- {quest:94616} Water Sapta
	["Lost the {quest:94616}?"] = "Perdeu {quest:94616}?",
	-- {quest:94616} Water Sapta · {npc:258043} Norric Lochthane · {zone:1436} Westfall
	["Only if the {quest:94616} is gone from your bags: {npc:258043} gives you another before you leave for {zone:1436}."] = "Só se {quest:94616} sumiu das suas bolsas: {npc:258043} entrega outra antes de você partir para {zone:1436}.",
	-- {npc:258043} Norric Lochthane · {quest:94616} Water Sapta
	["{npc:258043}: a new {quest:94616}"] = "{npc:258043}: uma nova {quest:94616}",

	-- Step 12: Stendel's Pond
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:919} Stendel's Pond · {object:619896} Forgotten Shrine · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {spell:8056} Frost Shock · {spell:122} Frost Nova · {item:7811} Remaining Drops of Purest Water · {npc:258043} Norric Lochthane · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water
	["Fly to {area:108} and head south to {area:20}: {area:919} and the {object:619896} lie just north of it. Drink the {item:6637} by the shrine to see the {npc:5894} (level 22, {spell:8056} and {spell:122}; one spawn, back three minutes after a kill), defeat it for its bracers (always dropped), then place them and the {item:7811} on the {object:619896} (this, not {npc:258043}, ends the quest). Click the shrine again: the {npc:5895} rises beside it; speak to it before you walk off (if it is gone, abandon and take the quest again at the shrine). It gives you the {item:7813}."] = "Voe para {area:108} e siga para o sul até {area:20}: {area:919} e {object:619896} ficam logo ao norte dela. Beba {item:6637} ao lado do santuário para ver {npc:5894} (nível 22, {spell:8056} e {spell:122}; um único ponto de aparição, volta três minutos depois de morrer), derrote-o para pegar as braçadeiras dele (sempre caem), e então coloque-as e {item:7811} em {object:619896} (isso, e não {npc:258043}, termina a missão). Clique no santuário de novo: {npc:5895} se ergue ao lado dele; fale com ele antes de sair andando (se tiver sumido, abandone e pegue a missão de novo no santuário). Ele entrega {item:7813} a você.",
	-- {npc:5895} Minor Manifestation of Water
	["{npc:5895}, beside the shrine"] = "{npc:5895}, ao lado do santuário",

	-- Step 13: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {item:7813} Shard of Water · {item:5177} Water Totem
	["Back to {npc:258043} with the {item:7813}. Keep the {item:5177} in your bags for good: every water totem needs it."] = "De volta a {npc:258043}, com {item:7813}. Guarde {item:5177} nas suas bolsas para sempre: todo totem de água precisa dele.",
	-- {npc:258043} Norric Lochthane · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:258043}: {spell:5394} and your {item:5177}"] = "{npc:258043}: {spell:5394} e seu {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather."] = "{area:71} jorram de {area:68} no extremo leste de Cristarrubra. Encha o {item:265747} no pé delas, onde se reúnem os Reptantes Murloc.",
	-- ["{area:919} lies outside {area:20}. Drink the {item:6637} there and defeat the {npc:5894} for its bracers, then place them and the {item:7811} on the {object:619896}. The {npc:5895} it calls forth gives you the {item:7813}."] = "{area:919} fica nos arredores de {area:20}. Beba a {item:6637} lá e derrote a {npc:5894} para pegar as braçadeiras; depois coloque-as junto com as {item:7811} no {object:619896}. A {npc:5895} invocada dá a você o {item:7813}.",
	-- ["{npc:258043}'s burrow hut stands on the north-western edge of the loch, south of {area:146}."] = "A cabana-toca de {npc:258043} fica na margem noroeste do lago, ao sul de {area:146}.",
	-- ["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}."] = "A família de {npc:258203} mora numa caverna sob as cachoeiras do sul de {zone:1437}.",
	-- ["{npc:258203}: take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then go south to {area:415}. Fill the {item:265772} in the lake around the town."] = "{npc:258203}: pegue o Barco de {area:150} para {area:442} (ele para em {area:271} no caminho), depois vá para o sul até {area:415}. Encha o {item:265772} no lago em volta da cidade.",
	-- ["{npc:5895}, at the shrine"] = "{npc:5895}, no santuário",
}
