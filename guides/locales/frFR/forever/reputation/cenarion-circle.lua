-- French (frFR): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Réputation : Cercle cénarien",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "Enchantements et patrons de résistance à la nature, équipement à insignes et nouveaux patrons de {zone:1451} propres à Forever, depuis les camps de {zone:1451}.",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "Nouveaux patrons de {zone:1451} de Forever pour tailleurs, travailleurs du cuir et forgerons, à Amical et Honoré",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "L'émissaire à {zone:1455}",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Facultatif, et utile seulement pour les quêtes des térébrants plus tard : {npc:15187} vous envoie à {zone:1451} avec {quest:8275}, une lettre à 10 de réputation. Passez-la si vous êtes déjà à {zone:1451}.",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "L'émissaire à {zone:1454}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Facultatif, et utile seulement pour les quêtes des térébrants plus tard : {npc:15188} vous envoie à {zone:1451} avec {quest:8275}, une lettre à 10 de réputation. Passez-la si vous êtes déjà à {zone:1451}.",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425} est le camp druidique fortifié du centre-nord de {zone:1451}, avec des points de vol pour les deux camps. Tout le monde commence à Neutre avec le {faction:609} (les druides à 2 000 sur 3 000). Bor et {npc:15270} se tiennent ensemble dans le bâtiment principal. {quest:8318} ouvre pour de bon les remises de {item:20404}. L'atout Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain ; les chiffres de ce guide sont sans lui.",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}, niveau 60",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "Le camp de sectateurs à l'ouest de {area:3425}",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "Le camp du Marteau du crépuscule le plus proche se trouve juste au sud-ouest du Fort. Les Vengeurs, Géoseigneurs et Invocateurs des pierres (niveau 57 à 59) laissent chacun un {item:20404} environ une fois sur trois, et chaque sectateur tué rapporte 1 de réputation. {npc:11804} arpente le bord du camp. Gardez chaque robe, capuche et mantelet de sectateur ramassés : c'est la tenue du crépuscule pour les Pierres des vents plus tard.",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Retour à {area:3425}",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "Sectateurs jusqu'au sommet d'Amical, textes gardés",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "De Neutre à Honoré, il faut 9 000 de réputation (7 000 pour les druides). Chaque {npc:11880}, Géoseigneur, Invocateur des pierres, Maître et Suzerain donne 1 de réputation jusqu'à 5 999 sur 6 000 d'Amical, à un point d'Honoré ; là, ils s'arrêtent. Gardez chaque {item:20404} et laissez pour plus tard les quêtes des étapes suivantes : chaque victime sous ce seuil est un point gratuit en plus de son texte, et les textes et quêtes rapportent autant à n'importe quel niveau de réputation. Un texte tombe environ une victime sur trois, donc 30 victimes font 30 de réputation et 10 textes (100 de réputation plus tard). Quatre camps : au sud-ouest du Fort (39,44), à l'extrême ouest (26,34), à l'extrême sud-ouest (19,84) et au nord-est sous {area:2742} (66,18 : Suzerains, et Flammes ravageuses qui comptent jusqu'au sommet d'Honoré). Le {npc:15308} (texte à 87 %) marche entre 18,31 et 23,69. Les textes se vendent à l'hôtel des ventes si vous préférez acheter. À 5 999 d'Amical, le dernier point vers Honoré vient d'une Flamme ravageuse, d'un Gardien du crépuscule ou d'un Maraudeur, ou de vos 10 premiers textes rendus à {npc:15306}.",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "Les victimes seules jusqu'au sommet d'Amical, c'est 8 999 victimes (6 999 pour les druides), mais les textes qu'elles laissent (environ 3 000) valent 30 000 de plus : l'essentiel du chemin vers Exalté.",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "Amical (3 000) ouvre la {item:20732} de Kania (10 po), le {item:22251} de Mishta (2 po) et les {item:22758} (5 po), ainsi que les nouveaux patrons de gants Amical de Forever (7 po 50 pa).",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404} : gardez-les",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201} : compte encore à 5 999 d'Amical",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306} : 10 textes, 100, pour le dernier point",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321} (niveau 61, non élite) attend au fond de {area:3446}, la grotte du nord-est de {zone:1451}. Des Flammes ravageuses et des Maîtres du crépuscule gardent le chemin : les Flammes ravageuses comptent jusqu'au sommet d'Honoré, les Maîtres s'arrêtent au sommet d'Amical comme les autres sectateurs.",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "Quêtes de {zone:1451} à {area:3425}",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}, après {quest:8275}",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "Avis de recherche : {npc:15196}, élite",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}, pour les cuisiniers",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "Autour de {area:3425}",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "Les Scorpides Cinglepierre et les Glisseuses du sable rôdent dans les sables autour du Fort ; les Frappeurs térébrants creusent au nord-est. Le {object:180503} se trouve dans le camp de sectateurs au sud-ouest du Fort.",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "De retour au Fort",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "Cinglepierre et Écraseurs térébrants",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "Les Écorcheurs Cinglepierre, les Pinceurs et les Traqueuses des rochers vivent au sud et au sud-ouest du Fort ; leurs dards et crocs tombent environ une fois sur dix. Les Écraseurs térébrants creusent au sud et à l'ouest du Fort.",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}, grâce au {object:180503}",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}, avec {item:20424} et {item:3713}",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190} et Proudhorn",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "Le {area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "Le camp dévasté à l'extrême nord-ouest de {zone:1451} : les fragments de la Tablette du crépuscule sont posés au sol parmi les ruines.",

	-- Step 14: Larksbane
	["Larksbane"] = "Larksbane",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194} se cache dans les collines de l'est de {zone:1451}. Il décode aussi {quest:8319} pour une chance d'obtenir un parchemin d'appel, mais {quest:8349} rapporte la réputation : gardez les textes pour Bor.",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "Les trois Gardiens du crépuscule",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "Chaque Gardien est de niveau 60, non élite, seul au bord d'un camp, et laisse toujours son chapitre : Mayna dans le camp de l'extrême ouest, Havunth dans le camp au sud-ouest du Fort, Exeter dans le camp de l'extrême sud-ouest, à côté du Seigneur du crépuscule.",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "Retour auprès d'Ortell",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Le campement de Bronzebeard",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "Le camp des nains au sud de {zone:1451}. Écoutez {npc:15171} et {npc:15170} raconter toute leur histoire pour {quest:8304}. La {item:20379} se trouve sur la montagne au sud-est du camp. {npc:15196} vit en haut du sentier à l'est du camp : un élite, et son {spell:10101} peut vous projeter du haut de la falaise.",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171} et {npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}, élite : groupe de 2 ou 3",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "Retour à {area:3425} avec des nouvelles",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	["Natalia, elite: group up"] = "Natalia, élite : formez un groupe",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "Décalques et cerveaux",
	-- {object:210337} Glyphed Crystal (no name in this language: may be words) · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "Rutgar et Frankal donnent les deux quêtes suivantes à leur camp. Chaque ruche a un cristal gravé de glyphes à décalquer avec le {item:20453}, et ses silithides laissent les cerveaux : {area:2742} au nord du Fort, {area:2743} à l'ouest, {area:2744} au sud. Au fond de {area:2744} attend Maîtresse Natalia (élite de niveau 62, contrôle mental et peur ; groupe de 3 à 5). De temps en temps, un silithide des ruches laisse {quest:8308} : elle lance une quête pour Rutgar qui vaut 100.",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}, au fond de {area:2744}",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "{quest:8308}, butin rare",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "Maîtresse Natalia",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "Facultatif : Natalia attend au fond de {area:2744}, la ruche du sud de {zone:1451}. C'est une élite de niveau 62 qui contrôle les esprits, fait fuir de peur et se soigne sous la moitié de sa vie : venez en groupe de 3 à 5 et interrompez ses soins.",
	["Mistress Natalia: group of 3 to 5"] = "Maîtresse Natalia : groupe de 3 à 5",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314} mène à {quest:8315} : le {npc:15183} vous envoie aux {area:3257} invoquer {npc:14862}, un boss de niveau 63 pour un raid d'environ 20. Ne la prenez qu'avec un raid.",
	["raid of 20"] = "raid de 20",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}, {npc:14862} : raid de 20",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "Facultatif : la suite de {quest:1123} rapporte 525 de réputation cénarienne en sept quêtes de niveau 55 à 57, entières au niveau 60. {npc:10881} vous envoie auprès de l'{npc:5769} sur {area:1639}, qui vous envoie auprès de {quest:1123} à {area:2361}, {zone:1450}.",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "Facultatif : la suite de {quest:6762} rapporte 525 de réputation cénarienne en sept quêtes de niveau 55 à 57, entières au niveau 60. {npc:10878} vous envoie auprès de l'{npc:3516}, qui vous envoie auprès de {npc:4217}, qui vous envoie auprès de {quest:6762} à {area:2361}, {zone:1450}.",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123} vit à {area:2361}. Elle vous envoie auprès de {npc:13220} à {area:3077}, le camp dans le coin nord-est de {zone:1451}.",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "Les Druides torturés et les Sentinelles errent dans les ruines de {area:2738}, au sud-est de {area:3425} ; la {object:178553} se trouve au dernier étage de sa tour entourée de guêpes.",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{npc:11939} à {area:2361}",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "Quêtes ailleurs",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "Faites les quêtes de {zone:1422} et de {area:2100} pendant que vous montez de niveau ; au niveau 60, elles ne rapportent peut-être qu'une fraction.",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319} jusqu'à Révéré",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "D'Honoré à Révéré, il faut 12 000 de réputation. {npc:15306} prend 10 {quest:8319} contre 100 de réputation, encore et encore, jusqu'à Exalté : 120 remises (1 200 textes) jusqu'à Révéré sans les quêtes, ou environ 950 textes après elles. Rendez maintenant les textes gardés. Les sectateurs ne comptent plus, mais les Flammes ravageuses, Gardiens du crépuscule, Maraudeurs et Templiers comptent jusqu'à 11 999 sur 12 000 d'Honoré, et le {npc:14479} et le Prophète jusqu'à Exalté. Honoré ouvre la {item:20733} de Kania (10 po), le {item:22773} de Mishta (5 po) et les nouveaux patrons Honoré de Forever (7 po 50 pa chacun).",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306} : 10 textes, 100",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}, niveau 60",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "L'{npc:15540} se tient près du puits de lune de {area:3425}. {quest:8507} (25 de réputation, répétable) vous envoie avec des papiers non signés auprès du capitaine de votre camp : la Brigade de Forgefer du {npc:15440} devant {area:2743} (Alliance) ou la Légion d'Orgrimmar de {npc:15612} devant {area:2744} (Horde). Utilisez d'abord les papiers, puis parlez au capitaine : un silithide élite de niveau 60 attaque ; gardez le capitaine en vie et il signe. Kaldon vous laisse ensuite choisir une Affectation de combat, une Affectation logistique ou une {item:20809}, chacune contenant un ordre de mission aléatoire qui vaut 50 de réputation et un insigne : 30 silithides des ruches tués (élites), des marchandises comme 30 bandages épais en étoffe runique ou 3 {item:7936}, ou un Templier, un {npc:15542} ou un rapport d'éclaireur. Un insigne de chaque sorte achète {quest:9338} auprès de Kaldon : 200 de réputation, répétable. Un tour complet rapporte environ 375 de réputation.",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "Allégeance : un insigne de combat, de logistique et tactique, 200",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800} : l'équipement à insignes de {npc:15176}",

	-- Step 31: Silithyst
	["Silithyst"] = "Silithyste",
	-- {quest:9419} Scouring the Desert · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {npc:17079} General Kirika · {area:2744} Hive'Regal
	["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "Facultatif, 100 de réputation une fois : {quest:9419}. Le camp de votre faction se trouve près d'une ruche : celui du {npc:17080} près de {area:2743} (Alliance), celui du {npc:17079} près de {area:2744} (Horde). Le silithyste jaillit de geysers lumineux dans tout le désert : traversez-en un, portez le silithyste jusqu'à l'extracteur de silithyste de votre camp, puis parlez au chef du camp. C'est un objectif JcJ sauvage : les joueurs de l'autre faction peuvent vous le prendre.",
	["deliver Silithyst at the extractor"] = "livrez le silithyste à l'extracteur",

	-- Step 32: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "Templiers et Conseil abyssal",
	-- {object:180456} Lesser Wind Stone (no name in this language: may be words) · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "Porter une tenue du crépuscule complète (capuche, mantelet et robe de sectateur, environ 8 %, 8 % et 6 % par sectateur) permet d'utiliser une pierre des vents inférieure : il y en a deux dans chacun des trois camps de l'ouest. Un Templier abyssal aléatoire apparaît : un élite de niveau 60 pour 1 à 3 joueurs, 5 de réputation jusqu'au sommet d'Honoré et un {item:20513} 93 % du temps. L'invocation consomme la tenue (et plus tard aussi le médaillon et l'anneau), et si l'élémentaire s'échappe, ils sont perdus : n'invoquez que si vous pouvez gagner. {quest:8361} rapporte 100 pour le premier blason ; ensuite, Bor prend 3 blasons contre 50. Dès Amical, {npc:15270} vous envoie à {quest:8331} : 3 blasons et un {item:14344} achètent le Médaillon de statut qui, porté avec une tenue, ouvre la {object:180461} plus grande pour un Duc (élite de niveau 62, groupe de 5 ; 25 de réputation, {item:20514} à 85 %).",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513} : Templier, groupe de 1 à 3",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}, Amical",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "3 blasons et un {item:14344} : le Médaillon de statut",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514} : Duc, groupe de 5",

	-- Step 33: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "Chevalières et sceptres jusqu'à Exalté",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone (no name in this language: may be words) · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "De Révéré à Exalté, il faut 21 000 de réputation : 210 remises de textes (2 100 textes), ou moins avec le reste. Dès Honoré, Bor prend 3 {quest:8363} contre 100 (chaque Duc donne aussi 25, jusqu'à Exalté), et {npc:15282} prend un {item:20515} pour {quest:9248} (200, une fois). Dès Révéré, {quest:8343} mène à {quest:8341} : 3 chevalières et 5 grands éclats brillants achètent l'Anneau d'autorité, et tenue, médaillon et anneau ouvrent la grande pierre des vents pour un Seigneur abyssal : un boss de niveau 63 pour un raid d'environ 20, 50 de réputation, et un {item:20515}. Bor paie 200 pour le premier sceptre et 150 pour chaque lot de 3 ensuite. Révéré ouvre la {item:22252} de Mishta (5 po), l'{item:22660} (9 po) et le {item:22756} (5 po) ; Exalté est le niveau requis pour la tenue de combat de champion auprès de {npc:15176}.",
	["10 texts: 100"] = "10 textes : 100",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "3 {quest:8363} : 100, Honoré",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515} : Seigneur, raid de 20",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}, Révéré",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "3 chevalières et 5 grands éclats brillants : l'Anneau d'autorité",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "3 {quest:8364} : 150, Révéré",

	-- Step 34: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "Les {area:3454}, à leur ouverture",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "Un raid à 20 joueurs derrière le {area:2737}, à l'extrême sud-ouest de {zone:1451}. Un nettoyage complet rapporte environ 1 600 de réputation cénarienne : les monstres ordinaires 3 chacun jusqu'à 20 999 sur 21 000 de Révéré, Kurinnaxx, Moam, Buru et Ayamiss 150 chacun et Ossirian 300, jusqu'à Exalté. La tête d'Ossirian lance {quest:8791} (200 ici et 200 {npc:15185}). Leurs butins achètent les quêtes d'anneau (Honoré), de cape (Révéré) et d'arme (Exalté) de {npc:15498}, {npc:15500} et {npc:15499} au Fort, 100 de réputation chacune. {npc:16091}, au Fort, paie 100 une fois pour {quest:9023} : la {item:22217} d'ici et celle de Venoxis à {area:19}. Le {npc:15471} vend les {item:22219} (Révéré, 5 po) et la {item:22191} (Exalté, 8 po) à l'intérieur.",

	-- Step 35: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "Facultatif, pour {quest:9023} : le {npc:14507} est le premier boss de {area:19}, un raid à 20 joueurs au nord-est de {zone:1434}.",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216} : raid de 20",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "Les blasons abyssaux, Les chevalières abyssales et Les sceptres abyssaux se répètent auprès de {npc:15306} une fois leurs quêtes d'ouverture terminées.",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Les textes du crépuscule cryptés se répète : {npc:15306} reprend des textes encore et encore. Les camps de sectateurs sont l'endroit où les farmer.",
	-- ["Encrypted Twilight Texts to Friendly"] = "Les textes du crépuscule cryptés jusqu'à Amical",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "À partir d'ici, le raid {area:3454} et les remises du Conseil abyssal (blasons, chevalières, sceptres) apportent l'essentiel de la réputation.",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Continuez à farmer les camps du crépuscule. Porter la tenue du crépuscule (l'ensemble de sectateur du crépuscule plus un Médaillon de statut de sectateur du crépuscule, de la quête Le médaillon de statut de {npc:15282}) permet d'invoquer des Templiers abyssaux aux Pierres des vents ; leurs Blasons abyssaux vont à {npc:15306}.",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Continuez les {area:3454} et les remises d'insignes du Conseil abyssal jusqu'à Exalté.",
	-- ["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants."] = "Encaissez maintenant les quêtes uniques : environ 1 700 de réputation seul, 2 400 avec les quêtes de groupe. Elles sont de niveau 55 à 60 et rapportent donc tout au niveau 60. {quest:8280} demande d'abord {quest:8275}. {npc:15196} est un scorpide élite avec deux gardes (groupe de 2 ou 3). {quest:8307} de {npc:15174} est pour les cuisiniers : sa recette fait les {item:20452} qu'il demande.",
	-- ["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. In Classic a quest pays less once it is 6 or more levels below you (a fifth less per level, down to a fifth): at 60, The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) would pay 60 and 75 instead of 75 and 75, and Corruption of Earth and Seed ({area:2100}, level 51) 30 instead of 150. Your first turn-in shows which rule Forever uses. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "Les autres quêtes du {faction:609} sont réparties sur {zone:1414} et les Maleterres. Dans Classic, une quête rapporte moins une fois qu'elle est 6 niveaux ou plus sous le vôtre (un cinquième de moins par niveau, jusqu'à un cinquième) : au niveau 60, La faune et la flore souffrent aussi ({npc:10739}, {zone:1422}, niveaux 54 et 56) rapporterait 60 et 75 au lieu de 75 et 75, et Corruption de la terre et de la graine ({area:2100}, niveau 51) 30 au lieu de 150. Votre première remise montre quelle règle Forever applique. Fragment de la Gangrevigne ({quest:1123}, niveau 60, le {item:18501} d'Alzzin dans {area:2577}) rapporte 150 et son Reliquaire 100 à n'importe quel niveau.",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Les sectateurs du Marteau du crépuscule tiennent les camps de l'ouest de {zone:1451}. {quest:8320} et Invocateurs des pierres s'y mêlent ; tout sectateur peut laisser un {item:20404}. Chaque sectateur tué compte aussi pour le {faction:609}. Les Géoseigneurs ne comptent pour {quest:8320} que si vous êtes niveau 60 et avez pris la quête.",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} est la ville fortifiée au centre-nord de {zone:1451}. Bor et {npc:15270} se tiennent ensemble à l'intérieur. Le {faction:609} commence à Neutre. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{faction:609} to Exalted"] = "{faction:609} jusqu'à Exalté",
	-- ["{faction:609} to Honored"] = "{faction:609} jusqu'à Honoré",
	-- ["{faction:609} to Revered"] = "{faction:609} jusqu'à Révéré",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306} : Les textes du crépuscule cryptés",
	-- ["{quest:8320} needs level 60"] = "{quest:8320} demande le niveau 60",
}
