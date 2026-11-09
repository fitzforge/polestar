-- French (frFR): the guide forever/reputation/nightclaw-druids (forever/reputation/nightclaw-druids.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Nightclaw Druids = {npc:254152} Nightclaw Druid
	["Nightclaw Druids Reputation"] = "Réputation : druides de la Noctegriffe",
	-- {zone:2521} Zephras Isle
	["{zone:2521}'s hidden druids: five cultist ears pay 1000 reputation, best done before you outlevel the isle."] = "Les druides cachés de {zone:2521} : cinq oreilles de sectateurs rapportent 1000 de réputation, à faire de préférence avant de dépasser le niveau de l'île.",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["48 {skill:164}, {skill:165} and {skill:197} patterns"] = "48 patrons de {skill:164}, de {skill:165} et de {skill:197}",

	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Aéronef depuis {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the north side of {area:279} about every five minutes; another flies from north of {zone:1456}, and either faction may take either."] = "{zone:2521} est l'île de départ des Éolides, ouverte à tous. Un navire céleste part du côté nord de {area:279} environ toutes les cinq minutes ; un autre vole depuis le nord des {zone:1456}, et chaque faction peut prendre l'un ou l'autre.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Navire céleste vers {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Aéronef depuis {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island, open to everyone. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes; another flies from {area:279}, and either faction may take either."] = "{zone:2521} est l'île de départ des Éolides, ouverte à tous. Un navire céleste part des falaises au sud du {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes ; un autre vole depuis {area:279}, et chaque faction peut prendre l'un ou l'autre.",

	-- Step 3: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Players' turn-ins paid their full reputation well above these quests' level."] = "",

	-- Step 4: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into the {area:16631}. {npc:257944} holds the druids' camp in its north-east."] = "Allez au nord dans la {area:16631}. {npc:257944} tient le camp des druides au nord-est de la forêt.",

	-- Step 5: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:257944} Elegael Thornpaw · {area:16720} Nightclaw Cavern
	["{npc:254151}, the druids' quartermaster, waits inside their den: the cave just across the clearing north-east of {npc:257944} ({area:16720} on the map; {npc:257944} calls it the Nightfang Den). Take his ear quest now: the cultists you fight for {npc:257944} drop ears for it."] = "{npc:254151}, l'intendant des druides, attend dans leur antre : la grotte juste de l'autre côté de la clairière, au nord-est de {npc:257944} ({area:16720} sur la carte ; {npc:257944} l'appelle le Nightfang Den). Acceptez maintenant sa quête d'oreilles : les sectateurs que vous combattez pour {npc:257944} en laissent pour elle.",

	-- Step 6: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Footsoldiers = {npc:252665} Al'Aketh Footsoldier · Bloody Heirlooms = {item:265141} Bloody Heirloom · Shadowgale Shrieklings = {npc:256092} Shadowgale Shriekling
	["The Al'Aketh Footsoldiers and Stormchasers camp just north of {npc:257944} and drop the Bloody Heirlooms (and ears, about one kill in four). The Shadowgale Shrieklings flying west of her drop the feathers; the {item:265105} grows on the trees along the stream west of her."] = "Les Fantassins al'aketh et les Chasseurs de tempêtes campent juste au nord de {npc:257944} et laissent les Héritages ensanglantés (et des oreilles, environ une victime sur quatre). Les Criailleuses trombenoires qui volent à l'ouest de celle-ci laissent les plumes ; la {item:265105} pousse sur les arbres le long du ruisseau à l'ouest de celle-ci.",
	-- {npc:254151} Vayn Moongaze
	["ears for {npc:254151}: keep every one"] = "oreilles pour {npc:254151} : gardez-les toutes",

	-- Step 7: Elegael Thornpaw's next tasks
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}'s next tasks"] = "Les tâches suivantes de {npc:257944}",
	["500 reputation"] = "500 de réputation",

	-- Step 8: The Nightfang Den and Commander Haalien
	-- {npc:253622} Commander Haalien
	["The Nightfang Den and {npc:253622}"] = "Le Nightfang Den et {npc:253622}",
	-- {npc:257944} Elegael Thornpaw · {npc:258134} Naaleos Leafwhisper · {npc:258130} Jorel Windsinger · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["The Nightfang Den is the cave north across the clearing from {npc:257944}. Heal the seven injured druids inside ({npc:258134} among them) and find {npc:258130}. {npc:253622} stands east of the den: he drops his head and a {quest:94490}; right-click the missive to start its quest."] = "Le Nightfang Den est la grotte au nord, de l'autre côté de la clairière de {npc:257944}. Soignez les sept druides blessés à l'intérieur ({npc:258134} parmi eux) et trouvez {npc:258130}. Le {npc:253622} se tient à l'est de l'antre : il laisse sa tête et une {quest:94490} ; faites un clic droit sur la missive pour lancer sa quête.",
	-- {npc:253622} Commander Haalien
	["from {npc:253622}"] = "sur le {npc:253622}",

	-- Step 9: Elegael Thornpaw, the den's fate
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the den's fate"] = "{npc:257944}, le sort de l'antre",
	["1000 reputation"] = "1000 de réputation",

	-- Step 10: Ears at the Shrine of Akir
	-- {area:16629} Shrine of Akir
	["Ears at the {area:16629}"] = "Oreilles au {area:16629}",
	-- {area:16629} Shrine of Akir · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Honor Guards = {npc:3083} Honor Guard
	["The best ears are south of the forest at the {area:16629}: Skypriests drop one in more than half their kills, Guardians in four of ten, Spiritcallers and Honor Guards in a third. The {area:16626} just north-west of {area:16638} are next best (Brawlers and Pillagers, about four in ten). All cultists are level 8 to 10."] = "Les meilleures oreilles sont au sud de la forêt, au {area:16629} : les prêtres du ciel en laissent une sur plus de la moitié de leurs victimes, les gardiens quatre sur dix, les implorateurs d'esprits et les gardes d'honneur une sur trois. Les {area:16626}, juste au nord-ouest de {area:16638}, viennent ensuite (bagarreurs et pillards, environ quatre sur dix). Tous les sectateurs sont de niveau 8 à 10.",

	-- Step 11: Mercy Falls on Deaf Ears
	-- {npc:254151} Vayn Moongaze
	["Back to {npc:254151} inside the den. Ten ears for 1000 reputation and a green piece: leather gloves, cloth pants or mail boots. {npc:254151} then takes ears five at a time, for 1000 each, as often as you like, up to level 18; in Classic the pay drops from level 19 and is 200 from level 22. The Legacy perk Diplomat adds up to 10% to every gain."] = "Retournez voir {npc:254151} dans l'antre. Dix oreilles contre 1000 de réputation et une pièce verte : gants en cuir, pantalon en tissu ou bottes en mailles. {npc:254151} prend ensuite les oreilles cinq par cinq, pour 1000 chaque fois, aussi souvent que vous le voulez, jusqu'au niveau 18 ; dans Classic, le gain baisse dès le niveau 19 et tombe à 200 à partir du niveau 22. L'atout Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain.",

	-- Step 12: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "Retour à {area:16638}",
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["{npc:252359} waits in {area:16638}. Hand in on your way to a skyboat or to the {area:16626}."] = "{npc:252359} attend à {area:16638}. Rendez la quête en allant vers un navire céleste ou vers les {area:16626}.",

	-- Step 13: Friendly to Honored
	["Friendly to Honored"] = "D'Amical à Honoré",
	-- {npc:254151} Vayn Moongaze
	["The storyline and {npc:254151}'s first quest leave you at Friendly with 2100 to spare. Honored is 3900 more: four turn-ins of five ears up to level 18, twenty from level 22. Friendly opens 32 of {npc:254151}'s patterns, in two colours, Cloudy and Azure: Blacksmithing Skyforged Wristguards and Chain (skill 50, 9s 50c), Gauntlets and Greaves (55, 11s); Leatherworking Gustwoven and Windraveled bracers and belts (50) and gloves and boots (55); Tailoring Stormsewn Cuffs and Cord (50), Handwraps and Shoes (55). They bind when you buy them, so buy them on the crafter."] = "L'histoire et la première quête de {npc:254151} vous laissent à Amical avec 2100 d'avance. Honoré est à 3900 de plus : quatre remises de cinq oreilles jusqu'au niveau 18, vingt à partir du niveau 22. Amical ouvre 32 des patrons de {npc:254151}, en deux coloris, Cloudy et Azure : forge, Skyforged Wristguards et Chain (compétence 50, 9 pa 50 pc), Gauntlets et Greaves (55, 11 pa) ; travail du cuir, brassards et ceintures Gustwoven et Windraveled (50) et gants et bottes (55) ; couture, Stormsewn Cuffs et Cord (50), Handwraps et Shoes (55). Ils sont liés quand vous les achetez : achetez-les donc avec l'artisan.",
	["five ears per turn-in"] = "cinq oreilles par remise",
	-- {quest:93459} More Al'Aketh Ears
	["{quest:93459}: 1000 reputation"] = "{quest:93459} : 1000 de réputation",
	-- {npc:254151} Vayn Moongaze
	["{npc:254151}'s patterns"] = "Les patrons de {npc:254151}",

	-- Step 14: Honored to Revered
	["Honored to Revered"] = "D'Honoré à Révéré",
	["Honored opens the chest and leg patterns (skill 60, 12s 50c): Skyforged chainmail and legguards, Gustwoven harness and trousers, Windraveled jerkin and pants, Stormsewn vest and leggings. Revered is 12000 more: 12 turn-ins (60 ears, about 160 cultist kills at the Shrine) up to level 18, 60 turn-ins (300 ears) from level 22."] = "Honoré ouvre les patrons de torse et de jambes (compétence 60, 12 pa 50 pc) : cotte de mailles et jambières Skyforged, harnais et pantalon Gustwoven, pourpoint et pantalon Windraveled, gilet et jambières Stormsewn. Révéré est à 12000 de plus : 12 remises (60 oreilles, environ 160 sectateurs tués au Sanctuaire) jusqu'au niveau 18, 60 remises (300 oreilles) à partir du niveau 22.",

	-- Step 15: Revered to Exalted
	["Revered to Exalted"] = "De Révéré à Exalté",
	-- {item:280347} Shadowgale Squirrel
	["Revered opens the {item:280347}, a companion pet, for 50s. Exalted is 21000 more: 21 turn-ins (105 ears, about 280 kills) up to level 18, 105 turn-ins (525 ears) from level 22."] = "Révéré ouvre l'{item:280347}, une mascotte, pour 50 pa. Exalté est à 21000 de plus : 21 remises (105 oreilles, environ 280 victimes) jusqu'au niveau 18, 105 remises (525 oreilles) à partir du niveau 22.",
	-- {item:280347} Shadowgale Squirrel
	["{item:280347}, 50s"] = "{item:280347}, 50 pa",

	-- Step 16: The Nightclaw Mantle
	-- {item:280363} Nightclaw Mantle
	["The {item:280363}"] = "Le {item:280363}",
	-- {item:280363} Nightclaw Mantle
	["Exalted opens the {item:280363}, green cloth shoulders for level 15, for 8s 16c."] = "Exalté ouvre le {item:280363}, des épaulières vertes en tissu de niveau 15, pour 8 pa 16 pc.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:252359} stands in {area:16638}, the Skyborne town in the south of the isle, and has heard nothing from the druids up north. His errand is the start of the Nightclaw storyline (level 8 and up, any race). Every quest of it pays Nightclaw reputation: 4100 in all, enough for Friendly. Come early: in Classic a quest pays less once you are 6 levels above it, a fifth at most from 9 levels up, and these are level 11 to 13 quests."] = "{npc:252359} se tient à {area:16638}, la ville des Éolides au sud de l'île, et n'a aucune nouvelle des druides du nord. Sa course lance l'histoire de la Noctegriffe (niveau 8 et plus, toutes races). Chacune de ses quêtes rapporte de la réputation auprès de la Noctegriffe : 4100 en tout, assez pour Amical. Venez tôt : dans Classic, une quête rapporte moins une fois que vous la dépassez de 6 niveaux, un cinquième au plus à partir de 9 niveaux, et ce sont des quêtes de niveau 11 à 13.",
}
