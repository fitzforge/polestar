-- French (frFR): the guide forever/miscellaneous/stalk-with-the-earthmother (forever/miscellaneous/stalk-with-the-earthmother.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff
	["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}, for a Tauren of any class."] = "",

	-- Step 1: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206159} Venture Co Disguise · {npc:3051} Supervisor Fizsprocket
	-- plural, as words: Venture Co. Workers = {npc:2978} Venture Co. Worker
	["{npc:205729} hides in stealth on the main mesa of {zone:1456}, south of its pool: walk to where the arrow points until his outline shows. He hands you the {item:206159}. The quest opens at level 4, but the mine holds Venture Co. Workers (level 8-9), Supervisors (9-10) and {npc:3051} (12): go at 9 or 10."] = "",

	-- Step 2: The Venture Co. Mine
	-- {zone:1412} Mulgore · {area:360} The Venture Co. Mine · {object:403041} Blasting Supplies (no name in this language: may be words)
	["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of {object:403041} inside the mine and on the slope outside it; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "",
	-- {item:206157} Seaforium Mining Charge · {object:403041} Blasting Supplies (no name in this language: may be words)
	["{item:206157}, from the {object:403041}"] = "",

	-- Step 3: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	["Back to {npc:205729} in {zone:1456}. He gives you the {item:206176} for his next test."] = "Retournez voir {npc:205729} aux {zone:1456}. Il vous donne le {item:206176} pour son épreuve suivante.",

	-- Step 4: Windfury Cones
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones"] = "Cônes Furie-des-vents",
	-- {area:819} Windfury Ridge · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones lie on the ground under the harpies' nest trees on {area:819}, north-west of {zone:1456}; the harpies do not drop them. The Windfury Sorceresses (level 9-10) and Matriarchs (10-11) there stand close together: pick the cones from the edges. Once you have eight, use the {item:206176} to grind them."] = "Les Cônes Furie-des-vents gisent au sol sous les arbres à nids des harpies, sur la {area:819}, au nord-ouest des {zone:1456} ; les harpies n'en lâchent pas. Les Ensorceleuses (niveau 9-10) et les Matriarches (10-11) Furie-des-vents s'y tiennent serrées : ramassez les cônes sur les bords. Une fois que vous en avez huit, utilisez le {item:206176} pour les broyer.",
	["the mortar takes all eight"] = "",
	-- {item:206175} Pine Salve
	["grind the eight cones into the {item:206175}"] = "",

	-- Step 5: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:206344} Knife Set
	["Back to {npc:205729}. He hands you the {item:206344} for the last test."] = "",

	-- Step 6: Raw Brilliant Smallfish
	-- {item:6291} Raw Brilliant Smallfish · {npc:8674} Auctioneer Stampi · {npc:3028} Kah Mistrunner · {skill:356} Fishing · {npc:3029} Sewa Mistrunner · {item:6256} Fishing Pole · {item:6529} Shiny Bauble · {item:206344} Knife Set
	["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill. Then use the {item:206344} on it, wherever you are."] = "",
	-- {item:6291} Raw Brilliant Smallfish
	["{item:6291}: the Auction House, or the pool; the knife takes it"] = "",
	-- {item:206345} Fish Chunks · {npc:205729} Boarton Shadetotem
	["fillet the smallfish into {item:206345} (where players did it, on the way back to {npc:205729})"] = "",

	-- Step 7: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:277988} Hoof-Holstered Blade · {item:278002} Valley Cosh
	["Take your weapon from {npc:205729}: the {item:277988} or the {item:278002}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}."] = "Une lame ou une masse à une main au niveau 11, grâce aux trois épreuves de {npc:205729} dans et autour des {zone:1456}.",
	-- ["Back to {npc:205729}. He hands you the {item:206344}: the fish must be filleted in front of him."] = "Retournez voir {npc:205729}. Il vous remet le {item:206344} : le poisson doit être fileté devant lui.",
	-- ["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill."] = "Achetez un {item:6291} à l'hôtel des ventes ({npc:8674}, au nord du bassin), ou pêchez-en un vous-même : {npc:3028} enseigne la {skill:356} et {npc:3029}, à côté de lui, vend la {item:6256} et une {item:6529} ; le bassin de la mesa principale donne des petits poissons à n'importe quel niveau de compétence.",
	-- ["Fish Chunks"] = "Morceaux de poisson",
	-- ["Loot 5 Seaforium Mining Charges from the Blasting Supplies"] = "Ramassez 5 charges de mine en seaforium dans les fournitures d'explosifs",
	-- ["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of Blasting Supplies inside the mine and on the slope outside its far side; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "Descendez par l'ascenseur et traversez {zone:1412} vers le sud-est jusqu'à la {area:360}. Mettez le déguisement, puis ouvrez les chariots de fournitures d'explosifs dans la mine et sur la pente à l'extérieur, de l'autre côté ; restez si possible dans les niveaux supérieurs, les tunnels du bas sont bondés. Cinq charges.",
	-- ["Stand beside {npc:205729} and use the {item:206344} on the smallfish: it only counts next to him. Then take your weapon: the {item:277988} or the {item:278002}."] = "Placez-vous à côté de {npc:205729} et utilisez le {item:206344} sur le petit poisson : cela ne compte qu'à côté de lui. Prenez ensuite votre arme : la {item:277988} ou le {item:278002}.",
	-- ["Venture Co. Mine"] = "Mine de la KapitalRisk",
	-- ["grind the eight cones"] = "broyez les huit cônes",
	-- ["in front of {npc:205729}"] = "devant {npc:205729}",
	-- ["{item:6291}: the Auction House, or the pool"] = "{item:6291} : l'hôtel des ventes, ou le bassin",
	-- ["{npc:205729} hides in stealth on the main mesa of {zone:1456}, south of its pool: walk to where the arrow points until his outline shows. He hands you the Venture Co Disguise. The quest opens at level 4, but the mine holds Venture Co. Workers (level 8-9), Supervisors (9-10) and {npc:3051} (12): go at 9 or 10."] = "{npc:205729} se cache, camouflé, sur la mesa principale des {zone:1456}, au sud de son bassin : marchez là où pointe la flèche jusqu'à voir sa silhouette. Il vous remet le déguisement de la KapitalRisk. La quête s'ouvre au niveau 4, mais la mine abrite des Ouvriers de la KapitalRisk (niveau 8-9), des Contremaîtres (9-10) et {npc:3051} (12) : allez-y au niveau 9 ou 10.",
}
