-- Portuguese (Brazil) (ptBR): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "Aprender {skill:171}",
	-- {skill:171} Alchemy · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Any {skill:171} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 82 {item:765} and 110 {item:2447} to gather or buy."] = "{skill:171} Aprendiz permite fabricar até 75 por 10c, em qualquer nível de personagem. Qualquer instrutor de {skill:171} da sua facção ensina; a seta escolhe o mais próximo. Combine com {skill:182}: {item:2447} e {item:765} crescem em todas as zonas iniciais, e Ampolas Vazias custam 4c em qualquer vendedor de alquimia ou de suprimentos. De 1 a 75 gasta cerca de 3s 28c em itens de vendedor, mais 82 {item:765} e 110 {item:2447} para coletar ou comprar.",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "{skill:171} 1-75: itens de vendedor",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Compre a parte de toda a faixa de uma vez: 82 {item:3371} (3s 28c); cerca de 3s 28c no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1286}, Eldraeith e {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} e {npc:3334}).",

	-- Step 3: Silverleaf (Elwynn Forest)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1429} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:1429} está marcado.",

	-- Step 4: Silverleaf (Dun Morogh)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1426} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:1426} está marcado.",

	-- Step 5: Silverleaf (Teldrassil)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1438} Teldrassil
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1438} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:1438} está marcado.",

	-- Step 6: Silverleaf (Zephras Isle)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:2521} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:2521} está marcado.",

	-- Step 7: Silverleaf (Durotar)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1411} Durotar
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1411} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:1411} está marcado.",

	-- Step 8: Silverleaf (Mulgore)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1412} Mulgore
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1412} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:1412} está marcado.",

	-- Step 9: Silverleaf (Tirisfal Glades)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1420} is marked."] = "82 {item:765} para {item:5997}: {skill:182}: {item:765} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:765} em {zone:1420} está marcado.",

	-- Step 10: Peacebloom (Elwynn Forest)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1429} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:1429} está marcado.",

	-- Step 11: Peacebloom (Dun Morogh)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1426} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:1426} está marcado.",

	-- Step 12: Peacebloom (Teldrassil)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1438} Teldrassil
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1438} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:1438} está marcado.",

	-- Step 13: Peacebloom (Zephras Isle)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:2521} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:2521} está marcado.",

	-- Step 14: Peacebloom (Durotar)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1411} Durotar
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1411} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:1411} está marcado.",

	-- Step 15: Peacebloom (Mulgore)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1412} Mulgore
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1412} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:1412} está marcado.",

	-- Step 16: Peacebloom (Tirisfal Glades)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1420} is marked."] = "110 {item:2447} para {item:5997} e {spell:2331} (28 deles para 75-150: colete todos agora): {skill:182}: {item:2447} (perícia 1); ou a Casa de Leilões. O maior aglomerado de {item:2447} em {zone:1420} está marcado.",

	-- Step 17: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997} até 75",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75. Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "{item:5997} é laranja em 1 (amarelo 55, verde 75, cinza 95): cerca de 82 criações até 75. Cada uma usa 1 {item:765}, 1 {item:2447} e 1 {item:3371}. Você já sabe desde o início e é o caminho mais barato pela faixa de Aprendiz. Guarde os elixires (armadura enquanto você sobe de nível) ou venda.",

	-- Step 18: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "{skill:171} (Profissional)",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {npc:4609} Doctor Marsh · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2331} Minor Mana Potion · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4160} ({zone:1457}), {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:7948} ({zone:1444}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4611} ({zone:1458}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:1386} ({zone:1435}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2331} (from 25, 1s). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 1s of recipes and 9s 8c of vendor goods, plus 77 {item:785}, 152 {item:2450} and 54 {item:2453} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 4s 50c (preço do Classic; o do Forever não consta nos dados); exige {skill:171} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:171} ensina: Aliança {npc:4160} ({zone:1457}), {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:7948} ({zone:1444}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) e {npc:5177} ({zone:1455}); Horda {npc:3009} ({zone:1456}), {npc:4611} ({zone:1458}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:1386} ({zone:1435}), {npc:2391} ({zone:1424}) e {npc:3347} ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:2331} (a partir de 25, 1s). Aprenda também {spell:1230564} (1s): o item de acampamento de {skill:171} do Forever, 1 {item:2447} e 1 {item:3371}, colocado num acampamento ao lado de uma fogueira para dar o benefício. A missão Introdução ao acampamento: {skill:171}, do guia de acampamento da sua área inicial (depois de Vida ao ar livre), manda você a um instrutor de alquimia que ensina de graça. De 75 a 150 gasta cerca de 1s em receitas e 9s 8c em itens de vendedor, mais 77 {item:785}, 152 {item:2450} e 54 {item:2453} para coletar ou comprar.",

	-- Step 19: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "{skill:171} 75-150: itens de vendedor",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Compre a parte de toda a faixa de uma vez: 77 {item:3371} (3s 8c) e 15 {item:3372} (6s); cerca de 9s 8c no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1286}, Eldraeith e {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} e {npc:3334}).",

	-- Step 20: Mageroyal (Westfall)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1436} Westfall
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1436} is marked."] = "77 {item:785} para {spell:2331} e {spell:3171}: {skill:182}: {item:785} (perícia 50); ou a Casa de Leilões. O maior aglomerado de {item:785} em {zone:1436} está marcado.",

	-- Step 21: Mageroyal (Loch Modan)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1432} Loch Modan
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1432} is marked."] = "77 {item:785} para {spell:2331} e {spell:3171}: {skill:182}: {item:785} (perícia 50); ou a Casa de Leilões. O maior aglomerado de {item:785} em {zone:1432} está marcado.",

	-- Step 22: Mageroyal (Teldrassil)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1438} Teldrassil
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1438} is marked."] = "77 {item:785} para {spell:2331} e {spell:3171}: {skill:182}: {item:785} (perícia 50); ou a Casa de Leilões. O maior aglomerado de {item:785} em {zone:1438} está marcado.",

	-- Step 23: Mageroyal (Zephras Isle)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:2521} is marked."] = "77 {item:785} para {spell:2331} e {spell:3171}: {skill:182}: {item:785} (perícia 50); ou a Casa de Leilões. O maior aglomerado de {item:785} em {zone:2521} está marcado.",

	-- Step 24: Mageroyal (The Barrens)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1413} The Barrens
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1413} is marked."] = "77 {item:785} para {spell:2331} e {spell:3171}: {skill:182}: {item:785} (perícia 50); ou a Casa de Leilões. O maior aglomerado de {item:785} em {zone:1413} está marcado.",

	-- Step 25: Mageroyal (Silverpine Forest)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1421} is marked."] = "77 {item:785} para {spell:2331} e {spell:3171}: {skill:182}: {item:785} (perícia 50); ou a Casa de Leilões. O maior aglomerado de {item:785} em {zone:1421} está marcado.",

	-- Step 26: Briarthorn (Westfall)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1436} is marked."] = "152 {item:2450} para {spell:3171} e {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2450} (perícia 70); ou a Casa de Leilões. O maior aglomerado de {item:2450} em {zone:1436} está marcado.",

	-- Step 27: Briarthorn (Loch Modan)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1432} is marked."] = "152 {item:2450} para {spell:3171} e {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2450} (perícia 70); ou a Casa de Leilões. O maior aglomerado de {item:2450} em {zone:1432} está marcado.",

	-- Step 28: Briarthorn (Darkshore)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1439} is marked."] = "152 {item:2450} para {spell:3171} e {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2450} (perícia 70); ou a Casa de Leilões. O maior aglomerado de {item:2450} em {zone:1439} está marcado.",

	-- Step 29: Briarthorn (The Barrens)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1413} is marked."] = "152 {item:2450} para {spell:3171} e {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2450} (perícia 70); ou a Casa de Leilões. O maior aglomerado de {item:2450} em {zone:1413} está marcado.",

	-- Step 30: Briarthorn (Silverpine Forest)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1421} is marked."] = "152 {item:2450} para {spell:3171} e {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2450} (perícia 70); ou a Casa de Leilões. O maior aglomerado de {item:2450} em {zone:1421} está marcado.",

	-- Step 31: Bruiseweed (Westfall)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1436} is marked."] = "54 {item:2453} para {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2453} (perícia 100); ou a Casa de Leilões. O maior aglomerado de {item:2453} em {zone:1436} está marcado.",

	-- Step 32: Bruiseweed (Loch Modan)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1432} is marked."] = "54 {item:2453} para {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2453} (perícia 100); ou a Casa de Leilões. O maior aglomerado de {item:2453} em {zone:1432} está marcado.",

	-- Step 33: Bruiseweed (Darkshore)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1439} is marked."] = "54 {item:2453} para {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2453} (perícia 100); ou a Casa de Leilões. O maior aglomerado de {item:2453} em {zone:1439} está marcado.",

	-- Step 34: Bruiseweed (The Barrens)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1413} is marked."] = "54 {item:2453} para {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2453} (perícia 100); ou a Casa de Leilões. O maior aglomerado de {item:2453} em {zone:1413} está marcado.",

	-- Step 35: Bruiseweed (Silverpine Forest)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1421} is marked."] = "54 {item:2453} para {spell:3176} (24 deles para 150-225: colete todos agora): {skill:182}: {item:2453} (perícia 100); ou a Casa de Leilões. O maior aglomerado de {item:2453} em {zone:1421} está marcado.",

	-- Step 36: Minor Mana Potion to 90
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 90"] = "{spell:2331} até 90",
	-- {spell:2331} Minor Mana Potion · {item:785} Mageroyal · {item:2447} Peacebloom · {item:3371} Empty Vial · {spell:3171} Elixir of Wisdom
	["{spell:2331} is yellow at 75 (yellow 65, green 85, grey 105): about 28 crafts to 90. Each takes 1 {item:785}, 1 {item:2447} and 1 {item:3371}. The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until {spell:3171} takes over at 90. {item:785} grows in the 10-25 zones."] = "{spell:2331} é amarela em 75 (amarelo 65, verde 85, cinza 105): cerca de 28 criações até 90. Cada uma usa 1 {item:785}, 1 {item:2447} e 1 {item:3371}. O instrutor ensina a partir de 25. Já é amarela, então conte com cerca de duas criações por ponto até {spell:3171} assumir em 90. {item:785} cresce nas zonas de 10 a 25.",

	-- Step 37: Alchemy recipes at 90
	-- {skill:171} Alchemy
	["{skill:171} recipes at 90"] = "Receitas de {skill:171} em 90",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "De volta a um instrutor de {skill:171}: {spell:3171} (a partir de 90).",

	-- Step 38: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "{spell:3171} até 135",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 90 (yellow 120, green 140, grey 160): about 49 crafts to 135. Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "{spell:3171} é laranja em 90 (amarelo 120, verde 140, cinza 160): cerca de 49 criações até 135. Cada uma usa 1 {item:785}, 2 {item:2450} e 1 {item:3371}. Dois {item:2450} e um {item:785} por criação, ambos das zonas de 10 a 25; laranja até 120.",

	-- Step 39: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "Receitas de {skill:171} em 135",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "De volta a um instrutor de {skill:171}: {spell:3176} (a partir de 125).",

	-- Step 40: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "{spell:3176} até 150",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "{spell:3176} é laranja em 135 (amarelo 150, verde 170, cinza 190): cerca de 15 criações até 150, um ponto a cada criação. Cada uma usa 2 {item:2453}, 2 {item:2450} e 1 {item:3372}. Dois {item:2453} e dois {item:2450} por criação; {item:2453} cresce nas zonas de 15 a 30. {skill:171} 150 é um marco do Sistema de Legado.",

	-- Step 41: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "{skill:171} 150-225: itens de vendedor",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Compre a parte de toda a faixa de uma vez: 83 {item:3372} (33s 20c); cerca de 33s 20c no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1286}, Eldraeith e {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} e {npc:3334}).",

	-- Step 42: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623} (Aliança)",
	-- {object:1623} Wild Steelbloom · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest patch of {object:1623} in {zone:1434} is marked."] = "40 {object:1623} para {item:8951} (8 deles para 225-300: colete todos agora): {skill:182}: {object:1623} (perícia 115) em {zone:1442} (15-27), {zone:1417} (30-40) e {zone:1434} (30-45); ou a Casa de Leilões. O maior aglomerado de {object:1623} em {zone:1434} está marcado.",

	-- Step 43: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623} (Horda)",
	-- {object:1623} Wild Steelbloom · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest patch of {object:1623} in {zone:1442} is marked."] = "40 {object:1623} para {item:8951} (8 deles para 225-300: colete todos agora): {skill:182}: {object:1623} (perícia 115) em {zone:1442} (15-27), {zone:1417} (30-40) e {zone:1434} (30-45); ou a Casa de Leilões. O maior aglomerado de {object:1623} em {zone:1442} está marcado.",

	-- Step 44: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356} (Aliança)",
	-- {item:3356} Kingsblood · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1440} Ashenvale · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale
	["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45); or the Auction House. The densest patch of {item:3356} in {zone:1434} is marked."] = "39 {item:3356} para {spell:3452}: {skill:182}: {item:3356} (perícia 125) em {zone:1440} (18-30), {zone:1437} (20-30) e {zone:1434} (30-45); ou a Casa de Leilões. O maior aglomerado de {item:3356} em {zone:1434} está marcado.",

	-- Step 45: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356} (Horda)",
	-- {item:3356} Kingsblood · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1434} Stranglethorn Vale
	["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45); or the Auction House. The densest patch of {item:3356} in {zone:1413} is marked."] = "39 {item:3356} para {spell:3452}: {skill:182}: {item:3356} (perícia 125) em {zone:1413} (10-25), {zone:1440} (18-30) e {zone:1434} (30-45); ou a Casa de Leilões. O maior aglomerado de {item:3356} em {zone:1413} está marcado.",

	-- Step 46: Stranglekelp (Alliance)
	-- {object:2045} Stranglekelp
	["{object:2045} (Alliance)"] = "{object:2045} (Aliança)",
	-- {object:2045} Stranglekelp · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50); or the Auction House. The densest patch of {object:2045} in {zone:1434} is marked."] = "39 {object:2045} para {spell:3452}: {skill:182}: {object:2045} (perícia 85) em {zone:1437} (20-30), {zone:1434} (30-45) e {zone:1425} (40-50); ou a Casa de Leilões. O maior aglomerado de {object:2045} em {zone:1434} está marcado.",

	-- Step 47: Stranglekelp (Horde)
	-- {object:2045} Stranglekelp
	["{object:2045} (Horde)"] = "{object:2045} (Horda)",
	-- {object:2045} Stranglekelp · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50); or the Auction House. The densest patch of {object:2045} in {zone:1413} is marked."] = "39 {object:2045} para {spell:3452}: {skill:182}: {object:2045} (perícia 85) em {zone:1413} (10-25), {zone:1434} (30-45) e {zone:1425} (40-50); ou a Casa de Leilões. O maior aglomerado de {object:2045} em {zone:1413} está marcado.",

	-- Step 48: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046} (Aliança)",
	-- {object:2046} Goldthorn · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest patch of {object:2046} in {zone:1417} is marked."] = "40 {object:2046} para {item:8951} (8 deles para 225-300: colete todos agora): {skill:182}: {object:2046} (perícia 170) em {zone:1417} (30-40), {zone:1425} (40-50) e {zone:1444} (40-50); ou a Casa de Leilões. O maior aglomerado de {object:2046} em {zone:1417} está marcado.",

	-- Step 49: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046} (Horda)",
	-- {object:2046} Goldthorn · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest patch of {object:2046} in {zone:1444} is marked."] = "40 {object:2046} para {item:8951} (8 deles para 225-300: colete todos agora): {skill:182}: {object:2046} (perícia 170) em {zone:1417} (30-40), {zone:1425} (40-50) e {zone:1444} (40-50); ou a Casa de Leilões. O maior aglomerado de {object:2046} em {zone:1444} está marcado.",

	-- Step 50: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "{skill:171} (Perito)",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn · {spell:3452} Mana Potion · {item:8951} Elixir of Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}) and {npc:7948} ({zone:1444}); Horde {npc:4611} ({zone:1458}) and {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 150-225 takes about 33s 20c of vendor goods, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} and 40 {object:2046} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:3452} (from 160) and {item:8951} (from 195), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Perito eleva o limite de 150 para 225 por 50s (preço do Classic; o do Forever não consta nos dados); exige {skill:171} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: Aliança {npc:4160} ({zone:1457}) e {npc:7948} ({zone:1444}); Horda {npc:4611} ({zone:1458}) e {npc:1386} ({zone:1435}). A seta escolhe o mais próximo da sua facção. De 150 a 225 gasta cerca de 33s 20c em itens de vendedor, mais 40 {object:1623}, 39 {item:3356}, 39 {object:2045} e 40 {object:2046} para coletar ou comprar. Venha com tudo nas bolsas (as etapas acima, o resto da Casa de Leilões): esses instrutores também ensinam {spell:3452} (a partir de 160) e {item:8951} (a partir de 195), e as criações não exigem estação, então crie aqui mesmo e aprenda cada receita ao chegar na habilidade dela. Uma viagem em vez de 3.",

	-- Step 51: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "{spell:3176} até 160",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones."] = "{spell:3176} é amarela em 150 (amarelo 150, verde 170, cinza 190): cerca de 12 criações até 160. Cada uma usa 2 {item:2453}, 2 {item:2450} e 1 {item:3372}. Dois {item:2453} e dois {item:2450} por criação; {item:2453} cresce nas zonas de 15 a 30.",

	-- Step 52: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "Receitas de {skill:171} em 160",
	-- {spell:3452} Mana Potion
	["Still at the Expert trainer: {spell:3452} (from 160)."] = "Ainda no instrutor Perito: {spell:3452} (a partir de 160).",

	-- Step 53: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "{spell:3452} até 195",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195. Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "{spell:3452} é laranja em 160 (amarelo 180, verde 200, cinza 220): cerca de 39 criações até 195. Cada uma usa 1 {item:3820}, 1 {item:3356} e 1 {item:3372}. {item:3820} cresce debaixo d'água ao longo das costas: leve um elixir de respiração aquática ou suba para respirar. {item:3356} cresce nas zonas de 20 a 40.",

	-- Step 54: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "Receitas de {skill:171} em 195",
	-- {spell:11450} Elixir of Defense
	["Still at the Expert trainer: {spell:11450} (from 195)."] = "Ainda no instrutor Perito: {spell:11450} (a partir de 195).",

	-- Step 55: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "{item:8951} até 225",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "{item:8951} é laranja em 195 (amarelo 215, verde 235, cinza 255): cerca de 32 criações até 225. Cada uma usa 1 {item:3355}, 1 {item:3821} e 1 {item:3372}. {item:3355} e {item:3821} são as ervas das zonas de 30 a 45 (Selva do Espinhaço, Arathi, as {zone:1418}). {skill:171} 225 é um marco do Sistema de Legado.",

	-- Step 56: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "{skill:171} 225-300: itens de vendedor",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Compre a parte de toda a faixa de uma vez: 51 {item:3372} (20s 40c) e 86 {item:8925} (4g 30s); cerca de 4g 50s 40c no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1286}, Eldraeith e {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} e {npc:3334}).",

	-- Step 57: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:13478} ensina {item:13445} ({skill:171} 265) por 1g 30s. Vendido pela Aliança: {npc:5178} ({zone:1455}), estoque limitado; pela Horda: {npc:3348} ({zone:1454}), estoque limitado. Os vendedores mantêm uma ou duas em estoque, que voltam algum tempo depois de uma venda; a Casa de Leilões também costuma ter.",

	-- Step 58: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836} (Aliança)",
	-- {item:8836} Arthas' Tears · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60); or the Auction House. The densest patch of {item:8836} in {zone:1422} is marked."] = "43 {item:8836} para {item:9154}: {skill:182}: {item:8836} (perícia 220) em {zone:1448} (48-55), {zone:1422} (51-58) e {zone:1423} (53-60); ou a Casa de Leilões. O maior aglomerado de {item:8836} em {zone:1422} está marcado.",

	-- Step 59: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836} (Horda)",
	-- {item:8836} Arthas' Tears · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60); or the Auction House. The densest patch of {item:8836} in {zone:1448} is marked."] = "43 {item:8836} para {item:9154}: {skill:182}: {item:8836} (perícia 220) em {zone:1448} (48-55), {zone:1422} (51-58) e {zone:1423} (53-60); ou a Casa de Leilões. O maior aglomerado de {item:8836} em {zone:1448} está marcado.",

	-- Step 60: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838} (Aliança)",
	-- {item:8838} Sungrass · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1425} is marked."] = "43 {item:8838} para {item:13445}: {skill:182}: {item:8838} (perícia 230) em {zone:1425} (40-50), {zone:1444} (40-50) e {zone:1447} (45-55); ou a Casa de Leilões. O maior aglomerado de {item:8838} em {zone:1425} está marcado.",

	-- Step 61: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838} (Horda)",
	-- {item:8838} Sungrass · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1444} is marked."] = "43 {item:8838} para {item:13445}: {skill:182}: {item:8838} (perícia 230) em {zone:1425} (40-50), {zone:1444} (40-50) e {zone:1447} (45-55); ou a Casa de Leilões. O maior aglomerado de {item:8838} em {zone:1444} está marcado.",

	-- Step 62: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422} (Aliança)",
	-- {item:13422} Stonescale Eel · {item:13445} Elixir of Greater Defense · {skill:356} Fishing · {object:180712} Stonescale Eel Swarm
	["43 {item:13422} for {item:13445}: {skill:356}; or the Auction House. Fish {object:180712} here."] = "43 {item:13422} para {item:13445}: {skill:356}; ou a Casa de Leilões. Pesque {object:180712} aqui.",

	-- Step 63: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422} (Horda)",

	-- Step 64: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "{skill:171} (Artífice)",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13422} Stonescale Eel · {item:9154} Draught of Detect Undead · {item:13423} Stonescale Oil
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}); Horde {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 43 {item:8836}, 43 {item:8838} and 43 {item:13422} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9154} (from 230) and {item:13423} (from 250), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Artífice eleva o limite de 225 para 300 por 4g 50s (preço do Classic; o do Forever não consta nos dados); exige {skill:171} 200 e nível de personagem 35, então você pode aprender em qualquer visita a partir de 200. Só alguns instrutores ensinam: Aliança {npc:7948} ({zone:1444}); Horda {npc:1386} ({zone:1435}). A seta escolhe o mais próximo da sua facção. De 225 a 300 gasta cerca de 1g 30s em receitas e 4g 50s 40c em itens de vendedor, mais 43 {item:8836}, 43 {item:8838} e 43 {item:13422} para coletar ou comprar. Venha com tudo nas bolsas (as etapas acima, o resto da Casa de Leilões): esses instrutores também ensinam {item:9154} (a partir de 230) e {item:13423} (a partir de 250), e as criações não exigem estação, então crie aqui mesmo e aprenda cada receita ao chegar na habilidade dela. Uma viagem em vez de 3.",

	-- Step 65: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "{item:8951} até 230",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418})."] = "{item:8951} é amarela em 225 (amarelo 215, verde 235, cinza 255): cerca de 8 criações até 230. Cada uma usa 1 {item:3355}, 1 {item:3821} e 1 {item:3372}. {item:3355} e {item:3821} são as ervas das zonas de 30 a 45 (Selva do Espinhaço, Arathi, as {zone:1418}).",

	-- Step 66: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "Receitas de {skill:171} no 230",
	-- {spell:11460} Draught of Detect Undead
	["Still at the Artisan trainer: {spell:11460} (from 230)."] = "Ainda no instrutor Artífice: {spell:11460} (a partir de 230).",

	-- Step 67: Draught of Detect Undead to 265
	-- {item:9154} Draught of Detect Undead
	["{item:9154} to 265"] = "{item:9154} até 265",
	-- {item:9154} Draught of Detect Undead · {item:8836} Arthas' Tears · {item:8925} Crystal Vial · {zone:1448} Felwood · {skill:182} Herbalism
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["{item:9154} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265. Each takes 1 {item:8836} and 1 {item:8925}. {item:8836} grow in the Plaguelands and {zone:1448} ({skill:182} 220); Crystal Vials come from alchemy vendors."] = "{item:9154} é laranja em 230 (amarelo 245, verde 265, cinza 285): cerca de 43 criações até 265. Cada uma usa 1 {item:8836} e 1 {item:8925}. {item:8836} cresce nas Terras Pestilentas e em {zone:1448} ({skill:182} 220); Ampolas de Cristal vêm de vendedores de alquimia.",

	-- Step 68: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "Receitas de {skill:171} em 265",
	-- {spell:17551} Stonescale Oil
	["Still at the Artisan trainer: {spell:17551} (from 250)."] = "Ainda no instrutor Artífice: {spell:17551} (a partir de 250).",

	-- Step 69: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "{item:13445} até 300",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300. Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "{item:13445} é laranja em 265 (amarelo 280, verde 300, cinza 320): cerca de 43 criações até 300. Cada uma usa 2 {item:13423}, 1 {item:8838} e 1 {item:8925}. Faça primeiro os 86 {item:13423} (43 criações). {item:13422} vem dos cardumes de {item:13422} nas costas das zonas de 40 a 55, ou da Casa de Leilões (pescadores vendem em pilhas). {item:8838} cresce nas zonas de 40 a 55. {skill:171} 300 é um marco do Sistema de Legado.",
	["from the recipe in your bags"] = "da receita nas suas bolsas",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:171}"] = "{skill:171} (Aprendiz)",
	-- ["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Artífice exige personagem nível 35 e {skill:171} 200; eleva o limite para 300. Os materiais de 225-300 valem cerca de 7g 80s no total.",
	-- ["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Volte a um instrutor de {skill:171}: {spell:11447} é ensinada a partir de {skill:171} 190.",
	-- ["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "Volte a um instrutor de {skill:171}: {spell:11450} é ensinada a partir de {skill:171} 215.",
	-- ["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "Volte a um instrutor de {skill:171}: {spell:11460} é ensinada a partir de {skill:171} 245.",
	-- ["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Volte a um instrutor de {skill:171}: {spell:1244645} é ensinada a partir de {skill:171} 85.",
	-- ["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Volte a um instrutor de {skill:171}: {spell:1244647} é ensinada a partir de {skill:171} 175.",
	-- ["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Volte a um instrutor de {skill:171}: {spell:1244648} é ensinada a partir de {skill:171} 230.",
	-- ["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "Volte a um instrutor de {skill:171}: {spell:17551} é ensinada a partir de {skill:171} 250.",
	-- ["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Volte a um instrutor de {skill:171}: {spell:7845} é ensinada a partir de {skill:171} 165.",
	-- ["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Perito exige personagem nível 20 e {skill:171} 125; eleva o limite para 225. Os materiais de 150-225 valem cerca de 3g 65s no total.",
	-- ["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Pesque em {object:180582}; é onde os dados mostram mais deles. A Casa de Leilões também serve.",
	-- ["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Pesque em {object:180657}; é onde os dados mostram mais deles. A Casa de Leilões também serve.",
	-- ["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Pesque em {object:180712}; é onde os dados mostram mais deles. A Casa de Leilões também serve.",
	-- ["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Profissional exige personagem nível 10 e {skill:171} 50; eleva o limite para 150. Os materiais de 75-150 valem cerca de 1g 44s no total.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mate os monstros que deixam cair o item no local que o Polestar escolhe para seu nível e facção. A Casa de Leilões também serve.",
	-- ["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Laranja (um ponto a cada produção) até 130, amarelo até 150, verde até 170. {skill:171} 150 é um marco do Sistema de Legado.",
	-- ["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Laranja (um ponto a cada produção) até 280, amarelo até 300, verde até 320. {skill:171} 300 é um marco do Sistema de Legado.",
	-- ["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Laranja (um ponto a cada produção) até 55, amarelo até 75, verde até 95. 75 é o limite de Aprendiz.",
	-- ["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:2447} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:2450} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:2453} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:3356} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:3357} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:765} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:785} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:8836} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {item:8838} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {object:1623} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Pegue {object:2046} com {skill:182}; este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "Ensina {item:6051} (exige {skill:171} 100). Vendedores têm estoque limitado que é reabastecido.",
	-- ["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Ensina {item:8951} (exige {skill:171} 265). Vendedores têm estoque limitado que é reabastecido; a Casa de Leilões também costuma ter.",
	-- ["Yellow until 105, green until 125: not every craft gives a point."] = "Amarelo até 105, verde até 125: nem toda produção dá ponto.",
	-- ["Yellow until 160, green until 170: not every craft gives a point."] = "Amarelo até 160, verde até 170: nem toda produção dá ponto.",
	-- ["Yellow until 185, green until 205: not every craft gives a point."] = "Amarelo até 185, verde até 205: nem toda produção dá ponto.",
	-- ["Yellow until 195, green until 215: not every craft gives a point."] = "Amarelo até 195, verde até 215: nem toda produção dá ponto.",
	-- ["Yellow until 210, green until 230: not every craft gives a point."] = "Amarelo até 210, verde até 230: nem toda produção dá ponto.",
	-- ["Yellow until 235, green until 255: not every craft gives a point."] = "Amarelo até 235, verde até 255: nem toda produção dá ponto.",
	-- ["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Amarelo até 235, verde até 255: nem toda produção dá ponto. {skill:171} 225 é um marco do Sistema de Legado.",
	-- ["Yellow until 250, green until 270: not every craft gives a point."] = "Amarelo até 250, verde até 270: nem toda produção dá ponto.",
	-- ["Yellow until 255, green until 260: not every craft gives a point."] = "Amarelo até 255, verde até 260: nem toda produção dá ponto.",
	-- ["Yellow until 265, green until 285: not every craft gives a point."] = "Amarelo até 265, verde até 285: nem toda produção dá ponto.",
	-- ["Yellow until 85, green until 105: not every craft gives a point."] = "Amarelo até 85, verde até 105: nem toda produção dá ponto.",
	-- ["{item:13423} to 259"] = "{item:13423} até 259",
	-- ["{item:2447} (Alliance)"] = "{item:2447} (Aliança)",
	-- ["{item:2447} (Horde)"] = "{item:2447} (Horda)",
	-- ["{item:2450} (Alliance)"] = "{item:2450} (Aliança)",
	-- ["{item:2450} (Horde)"] = "{item:2450} (Horda)",
	-- ["{item:2452} (Alliance)"] = "{item:2452} (Aliança)",
	-- ["{item:2452} (Horde)"] = "{item:2452} (Horda)",
	-- ["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} vem de pontos de {item:2450} ({skill:182}); este é o local mais denso nos dados. A Casa de Leilões também serve.",
	-- ["{item:2453} (Alliance)"] = "{item:2453} (Aliança)",
	-- ["{item:2453} (Horde)"] = "{item:2453} (Horda)",
	-- ["{item:247239} to 100"] = "{item:247239} até 100",
	-- ["{item:247241} to 200"] = "{item:247241} até 200",
	-- ["{item:247242} to 250"] = "{item:247242} até 250",
	-- ["{item:3357} (Alliance)"] = "{item:3357} (Aliança)",
	-- ["{item:3357} (Horde)"] = "{item:3357} (Horda)",
	-- ["{item:6051} to 150"] = "{item:6051} até 150",
	-- ["{item:6358} (Alliance)"] = "{item:6358} (Aliança)",
	-- ["{item:6358} (Horde)"] = "{item:6358} (Horda)",
	-- ["{item:6359} (Alliance)"] = "{item:6359} (Aliança)",
	-- ["{item:6359} (Horde)"] = "{item:6359} (Horda)",
	-- ["{item:6371} to 165"] = "{item:6371} até 165",
	-- ["{item:730} (Alliance)"] = "{item:730} (Aliança)",
	-- ["{item:730} (Horde)"] = "{item:730} (Horda)",
	-- ["{item:765} (Alliance)"] = "{item:765} (Aliança)",
	-- ["{item:765} (Horde)"] = "{item:765} (Horda)",
	-- ["{item:785} (Alliance)"] = "{item:785} (Aliança)",
	-- ["{item:785} (Horde)"] = "{item:785} (Horda)",
	-- ["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "{npc:1958} (nível 17-18) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "{npc:513} (nível 14-15) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{skill:171} recipes at 165"] = "Receitas de {skill:171} no 165",
	-- ["{skill:171} recipes at 175"] = "Receitas de {skill:171} no 175",
	-- ["{skill:171} recipes at 200"] = "Receitas de {skill:171} no 200",
	-- ["{skill:171} recipes at 215"] = "Receitas de {skill:171} no 215",
	-- ["{skill:171} recipes at 250"] = "Receitas de {skill:171} no 250",
	-- ["{skill:171} recipes at 259"] = "Receitas de {skill:171} no 259",
	-- ["{skill:171} recipes at 85"] = "Receitas de {skill:171} no 85",
	-- ["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171} acompanha a evolução do personagem. O Sistema de Legado do Forever recompensa profissões de produção nas perícias 150, 225 e 300 (os limites de Profissional, Perito e Artífice), então cada um desses marcos conta. Os materiais de 1-75 valem cerca de 68s no total.",
	-- ["{spell:11447} to 215"] = "{spell:11447} até 215",
	-- ["{spell:2331} to 85"] = "{spell:2331} até 85",
	-- ["{spell:7845} to 175"] = "{spell:7845} até 175",
}
