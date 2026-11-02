-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Voar para o {area:378}",
	-- {area:380} Crossroads
	["{area:380} flight master"] = "",

	-- Step 3: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 5: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236}: Berserker Stance"] = "",

	-- Step 7: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "Pegue a estrada para o norte na bifurcação até a aldeia ogra de Muralha Verde.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, na borda sul da aldeia, onde chega a estrada",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 8: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} espera no {area:2302} a leste da aldeia. Siga-o até Reethe e mantenha-o vivo na luta que começa.",

	-- Step 9: Brackenwall Village flight master
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 10: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:496} Brackenwall Village
	["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and head west through {zone:1412}), then on to {area:496}."] = "",

	-- Step 11: Back to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Back to {area:496}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "Inácio \"Cascão\"",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Lamapina",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Os murlocs Lamapina lotam a costa a leste e a nordeste do {area:502}; todo tipo deixa cair cabeças.",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Zé \"Olho de Lama\"",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Zé mora no {area:497} a sudeste do {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, ao lado do solar",
	-- {quest:1218} Soothing Spices
	["{quest:1218}, for \"Swamp Eye\" Jarl"] = "",

	-- Step 15: Theramore Infiltrator on the way
	-- {npc:4834} Theramore Infiltrator
	["{npc:4834} on the way"] = "",
	-- {npc:4834} Theramore Infiltrator · {area:496} Brackenwall Village
	["{npc:4834} along the way to {area:496}"] = "",

	-- Step 16: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 18: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, agora que {npc:4791} leu o relatório",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "só se você tiver uma {item:3853} ({skill:164} ou a Casa de Leilões)",

	-- Step 19: The Theramore Docks
	["Underwater"] = "",

	-- Step 21: Nazeer Bloodpike
	["Head back west to Brackenwall with the head."] = "",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in the next guide"] = "Para {npc:2519} em {object:3202}, no próximo guia",

	-- Step 22: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 26: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Head north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 27: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} espera no acampamento goblin no lado oeste do {area:596}.",

	-- Step 28: Kormek's Hut
	["Head north up the road to the hut by the road north of the graveyard."] = "",

	-- Step 29: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane
	["{npc:5395} and {npc:5412} stand in the post just west of Smeed's camp."] = "",

	-- Step 30: Kodo bones
	["Kodo bones"] = "",
	["Pick up the kodo bones scattered across the graveyard."] = "",

	-- Step 32: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "",
	["On the top floor"] = "",

	-- Step 33: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Lâmina Ardente ocupa a fortaleza a noroeste de {area:2407}. Use a {item:14523} no {npc:11876} da fortaleza para obter a {item:13542}.",

	-- Step 34: Ethel Rethor
	["His next errand is not on this route."] = "",

	-- Step 35: Slitherblade coast
	["Slitherblade coast"] = "Costa dos Sibilâmina",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Os nagas Sibilâmina ocupam a costa ao norte de {area:2405}, até a {area:598}. {npc:12369} guarda o {quest:6027} na ponta norte.",
	-- {npc:4711} Slitherblade Naga · {area:598} Sar'theris Strand
	["{npc:4711} walks around {area:598}: look inside the circle on the map"] = "",
	-- {npc:4714} Slitherblade Myrmidon · {area:598} Sar'theris Strand
	["{npc:4714} walks around {area:598}: look inside the circle on the map"] = "",

	-- Step 37: Maraudine totems
	["Maraudine totems"] = "Totens Maraudinos",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Head south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "",

	-- Step 38: Shadowprey Village
	["Head on south-west to Shadowprey."] = "",

	-- Step 39: Portals of the Legion
	-- {area:602} Mannoroc Coven
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 40: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "",
	-- {area:2657} Valley of Bones · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east from the coven to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 41: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Head north to {npc:5412} at {area:597}."] = "",

	-- Step 43: Shadowprey
	["Shadowprey"] = "",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "O próximo guia leva você de volta à {zone:1434}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Aranhas Presanegra",
	-- ["Hearth to Shadowprey"] = "Regressar para a Aldeia Pescassombra",
	-- ["Hearth to {area:392}"] = "Regressar para {area:392}",
	-- ["Kodo bones and ghosts"] = "Ossos de kodo e fantasmas",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Pegue os Ossos de Kodo espalhados pelo cemitério e use o {item:15848} entre os ossos: os fantasmas que ele atrai deixam cair o fantasmoplasma.",
	-- ["Ride back west to Brackenwall with the head."] = "Cavalgue de volta para oeste até Muralha Verde com a cabeça.",
	-- ["Ride east back to the {area:497}."] = "Cavalgue para leste de volta ao {area:497}.",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Cavalgue para leste do {area:378} pela estrada até o pântano. A {area:403} queimada fica ao lado dela, logo depois da divisa; o escudo, o distintivo e as pegadas estão dentro e ao lado da ruína.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Cavalgue para leste até o {area:602}. Use o bastão de banimento junto a cada portal demoníaco para fechar seis deles.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Cavalgue para o norte do conciliábulo até {npc:5412} no {area:597}.",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Cavalgue para o norte até o {area:502}. Cascão fica ao pé do morro; escolte-o enquanto ele colhe folhas de feijão-do-brejo logo ao sul.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Cavalgue para o norte pela estrada até a cabana junto à estrada ao norte do cemitério.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Cavalgue para nordeste até o {area:607}. {npc:12277} está presa no acampamento dos centauros Maraudinos; liberte-a e escolte-a para fora, a leste do vale.",
	-- ["Ride on south-west to Shadowprey."] = "Siga cavalgando para sudoeste até a Aldeia Pescassombra.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Cavalgue para o sul de {area:2405} até o {area:607}. Os Batedores, Cavalgantes, Espancadores, Ventilhãs e Espoliadores Maraudinos (36-39) deixam cair os {quest:93225}.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Cavalgue para oeste atravessando o pântano. Os Cospeçonhas Presanegra nas cristas ao norte de Muralha Verde deixam cair as glândulas de veneno. Infiltradores de Theramore (35-36) se esgueiram pela mesma mata: estão furtivos, então olhe com atenção.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Cavalgue para oeste até a torre de {npc:11863} em {area:2405}, na costa noroeste.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "As aranhas Névoa Negra lotam a entrada da caverna a noroeste de Muralha Verde; todo tipo deixa cair olhos.",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "A caravana termina no acampamento de {npc:11596}, no lado leste do {area:596}.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "A caravana de {npc:11626} para na estrada na borda do {area:602}. Escolte-a para leste passando o conciliábulo; demônios a atacam duas vezes.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} e {npc:5412} ficam no posto logo a oeste do acampamento de {npc:11596}.",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
}
