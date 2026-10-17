-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Do cais de {area:1108}, pegue o barco para Plumaluna e voe para {area:489}; depois cavalgue para o leste por {zone:1441} até a {area:2240} em {area:439}. {npc:4454} e {npc:4630} estão nos acampamentos ao lado da pista; {npc:4709} fica junto ao acampamento goblin.",
	["He runs off to keep Rizzle busy"] = "Ele sai correndo para distrair o Rebu",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "Projetos do Rebu",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Enquanto {npc:4709} distrai o Rebu, os projetos dele ficam desprotegidos no acampamento gnomo do outro lado da pista.",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Saia de {area:439} para o sudeste, rumo a {zone:1446}. {area:976} fica logo depois da fronteira.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, no lado norte da cidade",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, junto à torre d'água",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, ao lado dele",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Cavalgue para o leste pelas dunas até o porto goblin na costa nordeste.",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}, na taverna do porto",
	["The Wanted poster beside him"] = "O cartaz de Procurado ao lado dele",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Siga a costa para o sul até a enseada dos piratas. Os Piratas dos Mares do Sul lotam a praia e os barcos: avance pela borda e puxe um de cada vez. {npc:7883} fica do outro lado; a carga roubada de {npc:7881} está no acampamento.",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "A próxima entrega de {npc:7881} volta para {area:35}: pule.",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "Bandidos Errantes",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Cavalgue de volta para o oeste rumo a {area:976}. Os Bandidos Errantes e os Ladrões Errantes dominam as dunas no caminho; qualquer um deles pode carregar um cantil de água.",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Os Ladinos Errantes, Magos das Sombras Errantes e Assassinos Errantes, mais fortes, acampam a sudeste de {area:976}, ao sul dos bandidos. Deixe {npc:7847}, no meio do acampamento do sul, para depois.",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: o caixote dele vai para {area:702}, depois",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "A lagoa junto a {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Cavalgue para o noroeste até o acampamento dos trolls Zangareia em {area:979}. Use o {item:8584} na beira da lagoa; os trolls ficam perto, então puxe o mais próximo primeiro.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Dá o {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Lagoa junto a {area:979}",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Cavalgue para o sul até o acampamento de escavação em {area:1938}. {npc:7771} lhe entrega um elmo detector: use-o para ver os montes de {quest:3161}, espalhados pela areia ao redor do acampamento e a sudoeste, rumo aos ogros.",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Cavalgue para o sudoeste até o complexo dos ogros. Brutamontes Dunamalho e Impositores Dunamalho (46-48) o enchem; {npc:12046} (49) fica no meio, cercado de guardas: elimine-os primeiro.",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Cavalgue para o noroeste até a colmeia Centiparte nas dunas. Qualquer Centiparte pode deixar cair partes de inseto.",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Cavalgue para o sul até {quest:3362}. Os Coletores de Orvalho Moitagulhas deixam cair as glândulas; só algumas estão cheias, então guarde a Glândula de Orvalho Cheia. Moitagulhas Rotos e Fazraízes Moitaguhas dividem o vale. Os Moitagulhas Rotos são nível 48-50, acima de você: puxe um de cada vez.",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Escolta de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "A tartaruguinha {npc:5955} se esconde no extremo norte do vale. Leve-o para casa, até a esposa {npc:6015}, junto à água logo a leste de {area:977}: ele anda devagar e as feras do deserto vão atrás dele, então mantenha-o vivo.",

	-- Step 19: Steamwheedle Port
	-- {npc:7882} Security Chief Bilgewhizzle
	["The Wanted poster by {npc:7882}"] = "O cartaz de Procurado junto a {npc:7882}",

	-- Step 20: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Cavalgue de volta para o oeste até {area:976}.",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}, no lado leste da cidade",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "O próximo ingrediente de {npc:7583} cresce em {zone:1425}, e a rota nunca o traz de volta: pule.",

	-- Step 21: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Cavalgue para o sudeste até {area:985}. O {npc:7847} fica no meio do acampamento Errante do sul: limpe ao redor dele primeiro.",

	-- Step 22: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Cavalgue para o sul, passando por {area:1938}, até a {area:981}, os túneis Hazzali; o Aparelho de Inspeção do Anilhacido está bem no fundo.",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "Use a Pedra de Regresso para {area:976}.",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "para {zone:1457}: a rota leva você lá no nível 47",

	-- Step 24: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Voe de {area:976} para Theramore, pegue o barco para {area:150} e voe para {area:1537}. Treine.",

	-- Step 25: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "Voe para {area:348}. O guia de {zone:1425} começa aqui.",
}
