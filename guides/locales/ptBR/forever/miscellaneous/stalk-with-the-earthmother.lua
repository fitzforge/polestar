-- Portuguese (Brazil) (ptBR): the guide forever/miscellaneous/stalk-with-the-earthmother (forever/miscellaneous/stalk-with-the-earthmother.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff
	["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}, for a Tauren of any class."] = "Uma lâmina ou maça de uma mão no nível 11, vinda dos três testes de {npc:205729} em {zone:1456} e arredores, para um Tauren de qualquer classe.",

	-- Step 1: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206159} Venture Co Disguise · {npc:3051} Supervisor Fizsprocket
	-- plural, as words: Venture Co. Workers = {npc:2978} Venture Co. Worker
	["{npc:205729} hides in stealth on the main mesa of {zone:1456}, south of its pool: walk to where the arrow points until his outline shows. He hands you the {item:206159}. The quest opens at level 4, but the mine holds Venture Co. Workers (level 8-9), Supervisors (9-10) and {npc:3051} (12): go at 9 or 10."] = "{npc:205729} se esconde em furtividade na mesa principal de {zone:1456}, ao sul da lagoa: ande até onde a seta aponta até aparecer o contorno dele. Ele entrega o {item:206159}. A missão abre no nível 4, mas a mina tem Operários da Empreendimentos S.A. (nível 8-9), Supervisores (9-10) e {npc:3051} (12): vá no 9 ou 10.",

	-- Step 2: The Venture Co. Mine
	-- {zone:1412} Mulgore · {area:360} The Venture Co. Mine · {object:403041} Blasting Supplies (no name in this language: may be words)
	["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of {object:403041} inside the mine and on the slope outside it; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "Desça pelo elevador e siga para sudeste por {zone:1412} até {area:360}. Vista o disfarce, depois abra os carrinhos de {object:403041} dentro da mina e na encosta do lado de fora; fique nos níveis de cima sempre que puder, os túneis de baixo estão lotados. Cinco cargas.",
	-- {item:206157} Seaforium Mining Charge · {object:403041} Blasting Supplies (no name in this language: may be words)
	["{item:206157}, from the {object:403041}"] = "{item:206157}, de {object:403041}",

	-- Step 3: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	["Back to {npc:205729} in {zone:1456}. He gives you the {item:206176} for his next test."] = "De volta a {npc:205729}, em {zone:1456}. Ele entrega {item:206176} a você para o próximo teste dele.",

	-- Step 4: Windfury Cones
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones"] = "Cones de Fúria do Vento",
	-- {area:819} Windfury Ridge · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones lie on the ground under the harpies' nest trees on {area:819}, north-west of {zone:1456}; the harpies do not drop them. The Windfury Sorceresses (level 9-10) and Matriarchs (10-11) there stand close together: pick the cones from the edges. Once you have eight, use the {item:206176} to grind them."] = "Os Cones de Fúria do Vento ficam no chão, embaixo das árvores dos ninhos das harpias em {area:819}, a noroeste de {zone:1456}; as harpias não os soltam. As Feiticeiras Ventofúria (nível 9-10) e Matriarcas (10-11) de lá ficam juntas: pegue os cones pelas bordas. Com oito, use {item:206176} para moê-los.",
	["the mortar takes all eight"] = "o pilão aceita os oito",
	-- {item:206175} Pine Salve
	["grind the eight cones into the {item:206175}"] = "moa os oito cones até virar {item:206175}",

	-- Step 5: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:206344} Knife Set
	["Back to {npc:205729}. He hands you the {item:206344} for the last test."] = "De volta a {npc:205729}. Ele entrega {item:206344} a você para o último teste.",

	-- Step 6: Raw Brilliant Smallfish
	-- {item:6291} Raw Brilliant Smallfish · {npc:8674} Auctioneer Stampi · {npc:3028} Kah Mistrunner · {skill:356} Fishing · {npc:3029} Sewa Mistrunner · {item:6256} Fishing Pole · {item:6529} Shiny Bauble · {item:206344} Knife Set
	["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill. Then use the {item:206344} on it, wherever you are."] = "Compre {item:6291} na Casa de Leilões ({npc:8674}, ao norte da lagoa), ou pesque um: {npc:3028} ensina {skill:356} e {npc:3029}, ao lado dele, vende {item:6256} e {item:6529}; a lagoa na mesa principal dá peixinhos em qualquer nível de perícia. Depois use {item:206344} nele, onde você estiver.",
	-- {item:6291} Raw Brilliant Smallfish
	["{item:6291}: the Auction House, or the pool; the knife takes it"] = "{item:6291}: a Casa de Leilões ou a lagoa; a faca aceita",
	-- {item:206345} Fish Chunks · {npc:205729} Boarton Shadetotem
	["fillet the smallfish into {item:206345} (where players did it, on the way back to {npc:205729})"] = "filete o peixinho em {item:206345} (onde os jogadores fizeram, no caminho de volta a {npc:205729})",

	-- Step 7: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:277988} Hoof-Holstered Blade · {item:278002} Valley Cosh
	["Take your weapon from {npc:205729}: the {item:277988} or the {item:278002}."] = "Pegue sua arma com {npc:205729}: {item:277988} ou {item:278002}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}."] = "Uma lâmina ou maça de uma mão no nível 11, pelos três testes de {npc:205729} em {zone:1456} e arredores.",
	-- ["Back to {npc:205729}. He hands you the {item:206344}: the fish must be filleted in front of him."] = "De volta a {npc:205729}. Ele entrega {item:206344} a você: o peixe precisa ser filetado na frente dele.",
	-- ["Fish Chunks"] = "Pedaços de Peixe",
	-- ["Loot 5 Seaforium Mining Charges from the {object:403041}"] = "Saqueie 5 Seaforium Mining Charges dos {object:403041}",
	-- ["Stand beside {npc:205729} and use the {item:206344} on the smallfish: it only counts next to him. Then take your weapon: the {item:277988} or the {item:278002}."] = "Fique ao lado de {npc:205729} e use {item:206344} no peixinho: só conta ao lado dele. Depois pegue sua arma: {item:277988} ou {item:278002}.",
	-- ["Venture Co. Mine"] = "Mina da Empreendimentos S.A.",
	-- ["grind the eight cones"] = "moa os oito cones",
	-- ["in front of {npc:205729}"] = "na frente de {npc:205729}",
}
