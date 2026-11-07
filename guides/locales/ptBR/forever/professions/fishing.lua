-- Portuguese (Brazil) (ptBR): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Aprenda {skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5, 1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "Qualquer instrutor de {skill:356} da sua facção ensina {skill:356} Aprendiz (nível de personagem 5, 1s); a seta escolhe o mais próximo, e toda área inicial tem um no lago ou na margem. Compre uma {item:6256} (23c) de um vendedor de mercadorias ou de pesca e equipe (só dá para pescar com uma vara nas mãos), e duas ou três Miçangas Brilhosas (+25, 50c cada): uma isca soma seu bônus à perícia por dez minutos, então menos peixes escapam no início. Se você ficou na fogueira da sua área inicial para Vida ao ar livre, o guia de acampamento de lá também oferece Introdução ao acampamento: {skill:356}, entregue ao instrutor de pesca que ele indica na perícia 20 pela receita {spell:1229745}.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Pesque aqui até a perícia 50, cerca de 50 capturas: abaixo de 75 toda captura aumenta a perícia. Lance {skill:356} pelo grimório e clique na boia quando espirrar água. Guarde os peixes: são seus primeiros ingredientes de {skill:185}. Aqui os peixes escapam abaixo da perícia 25; uma isca na vara soma à sua perícia por dez minutos e fecha a diferença.",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "Pesque aqui até a perícia 50, cerca de 50 capturas: abaixo de 75 toda captura aumenta a perícia. Lance {skill:356} pelo grimório e clique na boia quando espirrar água. Guarde os peixes: são seus primeiros ingredientes de {skill:185}.",
	-- {area:16638} Valanaar
	["{area:16638} shore"] = "Margem de {area:16638}",

	-- Step 6: Fishing: Durotar (1-50)
	["Sen'jin coast"] = "Costa de Sen'jin",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} (Profissional)",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "{skill:356} Profissional eleva o limite para 150; exige perícia 50 e nível de personagem 10 (as listas de instrutores farejadas do Forever pedem esse nível), e custa 5s. A seta escolhe o instrutor de {skill:356} mais próximo da sua facção. {spell:1229745}, o item de acampamento do Forever para {skill:356} (a partir da perícia 20, 1s ou de graça com Introdução ao acampamento: {skill:356}), é um {item:6291} em uma {item:3371}: não dá perícia, mas, colocado ao lado de uma fogueira, dá a todos no acampamento um bônus por uma hora.",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Pesque nos cardumes e em mar aberto aqui até a perícia 125, cerca de 120 capturas: a partir de 75 uma captura aumenta a perícia com menos frequência (cerca de uma em duas até 100, uma em três até 125). Cardumes (destroços flutuantes, bancos de peixes) também dão saque extra. {item:6530} (+50 a partir da perícia 50, 1s cada) são duas vezes mais fortes que uma {item:6529}. A {item:6365} (+5 a partir da perícia 10, 9s 1c) tem estoque limitado nos vendedores de pesca: compre quando vir. Aqui os peixes escapam abaixo da perícia 75; uma isca na vara soma à sua perícia por dez minutos e fecha a diferença.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Costa de {zone:1436}",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Costa de {zone:1439}",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Oásis dos {zone:1413}",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} (Perito)",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "{skill:356} Perito (limite 225) é um livro, não um nível de instrutor: {npc:2626} vende {item:16083} (1g) no cais mais baixo de {area:35}, na ponta sul de {zone:1434}, para as duas facções. Compre e leia; exige perícia 125 e nível 20. No nível 20 o caminho seguro é o barco de {area:392} em {zone:1413}, não a estrada pela Selva do Espinhaço. Ele também vende {item:6532} (+75 a partir da perícia 100, 2s 50c cada), a isca para o resto do caminho.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Compre e leia {item:16083} ({skill:356} (Perito))",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "Pesque nos cardumes aqui até a perícia 225, cerca de 500 capturas: uma em três aumenta a perícia em 125, uma em sete em 225, então este é o trecho longo. O segundo item de acampamento do Forever, o {item:279965} (a partir da perícia 140), é uma planta que cai de Gelihast em {area:2797}. Aqui os peixes escapam abaixo da perícia 150; uma isca na vara soma à sua perícia por dez minutos e fecha a diferença.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Costa de {zone:1437}",

	-- Step 18: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Águas de {zone:1440}",

	-- Step 20: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Costa de {area:287}",

	-- Step 21: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} Artífice (limite 300) vem de {npc:12919}, em {zone:1445}. O instrutor de pesca de {zone:1455} manda você até ele; a missão exige perícia 225 e nível 35.",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} Artífice (limite 300) vem de {npc:12919}, em {zone:1445}. O instrutor de pesca de {zone:1454} manda você até ele; a missão exige perícia 225 e nível 35.",

	-- Step 23: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919} pesca na margem de uma ilha pequena na costa leste, ao sul de Theramore; chegue a nado desde a costa.",

	-- Step 24: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pesque ao longo da costa de {zone:1443} ({area:598} no noroeste, ou a margem a oeste de {area:2408}) até pescar um {item:16968}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Na perícia 225 nenhum peixe escapa aqui.",

	-- Step 26: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "Pesque ao longo de {area:2521} em {zone:1444} (a sudeste de {area:2577}) até pescar um {item:16967}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Esta água perde peixes abaixo da perícia 300: em 225 a maioria escapa, então ponha {item:6532} (+75) na vara antes.",

	-- Step 27: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pesque ao longo de {area:301} de {zone:1434} (a margem oeste) até pescar um {item:16969}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Na perícia 225 nenhum peixe escapa aqui.",

	-- Step 29: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "Pesque ao longo de {area:300} (a margem leste de {zone:1435}) até pescar um {item:16970}: cerca de uma captura em cinco o traz, e ele não morde em nenhum outro lugar. Na perícia 225 nenhum peixe escapa aqui.",

	-- Step 30: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} (Artífice)",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "Pesque nos cardumes ao longo da costa aqui (enguias, pargos, destroços) até a perícia 300, cerca de 650 capturas (uma em sete aumenta a perícia em 225, uma em dez em 300). Água mais difícil não sobe mais rápido: uma captura vale o mesmo em qualquer lugar. A partir da perícia 225 esta água não perde peixes, então não precisa de isca. A {item:6533} (+100 a partir da perícia 100, 2s 50c) e a {item:6532} servem para água mais difícil e peixes raros, não para perícia.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Costa de {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Qualquer instrutor de {skill:356} da sua facção ensina {skill:356} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo. Compre uma {item:6256} de um fornecedor de mercadorias ou de pesca e equipe-a.",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356} (Perito) (limite 225) é um livro, não um nível de instrutor: {npc:2626} vende {item:16083} em {area:35}, na ponta sul de {zone:1434}, para as duas facções. Compre e leia; exige perícia 125 e nível 20.",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Pesque aqui até a perícia 50. Clique na boia quando ela espirrar água; toda pesca pode aumentar a perícia.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Pesque em {area:2521}, em {zone:1444}, até pegar um {item:16967}; ele só morde lá.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Pesque em {area:300}, a margem sudeste de {zone:1435}, até pegar um {item:16970}; ele só morde lá.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Pesque em {area:301}, a margem noroeste de {zone:1434}, até pegar uma {item:16969}; ela só morde lá.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Pesque em {area:598}, a costa noroeste de {zone:1443} (litoral das nagas Sibilâmina), até pegar uma {item:16968}; ela só morde lá.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Pesque nos cardumes ao longo da costa aqui (enguias, tartarugas, destroços) até a perícia 300. {area:35} vende iscas e {item:6530} para um pequeno bônus de pesca.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Pesque nos cardumes e em águas abertas aqui até a perícia 125. Os cardumes (destroços flutuantes, bancos de peixes) também dão saque extra.",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Pesque nos cardumes aqui até a perícia 225. Se os peixes continuarem escapando, pesque em águas mais fáceis até sua perícia alcançar.",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} Profissional eleva o limite para 150; exige perícia 50 e nível de personagem 10. A seta escolhe o instrutor de {skill:356} da sua facção mais próximo.",
	-- ["Vile Fin shore"] = "Costa dos Pinavil",
	-- ["{area:442} shore"] = "Costa de {area:442}",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} pesca da margem de uma pequena ilha na costa leste, ao sul de Theramore.",
	-- ["{zone:1411} coast"] = "Costa de {zone:1411}",
	-- ["{zone:1413} oasis"] = "Oásis de {zone:1413}",
}
