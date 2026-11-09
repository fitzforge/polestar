-- Portuguese (Brazil) (ptBR): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Engineering
	-- {skill:202} Engineering
	["Learn {skill:202}"] = "Aprender {skill:202}",
	-- {skill:202} Engineering · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2840} Copper Bar
	["Apprentice {skill:202} lets you craft up to 75 for 10c, at any character level. Any {skill:202} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} and pair it with {skill:186}: {item:2835} and {item:2770} are the first parts. 1-75 takes about 4s 15c of recipes and 18s 18c of vendor goods, plus 46 {item:2835} and 75 {item:2840} to gather or buy."] = "{skill:202} Aprendiz permite criar até 75 por 10c, em qualquer nível de personagem. Qualquer instrutor de {skill:202} da sua facção ensina; a seta escolhe o mais próximo. Compre um {item:5956} e combine com {skill:186}: {item:2835} e {item:2770} são as primeiras peças. De 1 a 75 gasta cerca de 4s 15c em receitas e 18s 18c em itens de vendedor, além de 46 {item:2835} e 75 {item:2840} para coletar ou comprar.",

	-- Step 2: Engineering 1-75: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 1-75: vendor goods"] = "{skill:202} 1-75: itens de vendedor",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 18 {item:2880} (18s) e {item:5956} (uma ferramenta: só um, guardado nas bolsas, 18c); cerca de 18s 18c no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:5519}, {npc:5514} e {npc:1286}; {zone:1454}: {npc:3367}, Gorina e {npc:5817}).",
	["a tool, keep it in your bags"] = "uma ferramenta, mantenha nas bolsas",

	-- Step 3: Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1429} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:1429} está marcado.",

	-- Step 4: Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1426} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:1426} está marcado.",

	-- Step 5: Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1439} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:1439} está marcado.",

	-- Step 6: Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:2521} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:2521} está marcado.",

	-- Step 7: Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1411} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:1411} está marcado.",

	-- Step 8: Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1412} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:1412} está marcado.",

	-- Step 9: Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1420} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (perícia 1); ou na Casa de Leilões. O maior aglomerado de {object:1731} em {zone:1420} está marcado.",

	-- Step 10: Rough Blasting Powder to 35
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 35"] = "{spell:3918} até 35",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 46 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "{spell:3918} é laranja em 1 (amarelo 20, verde 30, cinza 40): cerca de 46 criações até 35. Cada uma usa 1 {item:2835}. Uma {item:2835} por criação; {item:2835} vem junto com {item:2770} dos Veios de Cobre.",

	-- Step 11: Engineering recipes at 35
	-- {skill:202} Engineering
	["{skill:202} recipes at 35"] = "Receitas de {skill:202} em 35",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free."] = "Volte a um instrutor de {skill:202}: {spell:3922} (a partir de 30, 1s 15c). Aprenda também {spell:1230656} (1s): o item de acampamento do Forever para {skill:202}, colocado em um acampamento ao lado de uma fogueira. Exige uma {spell:3922} e uma {spell:3924}, que você aprende em 30 e 50, então não dá pontos. A missão Introdução ao acampamento: {skill:202} do guia de acampamento da sua área inicial (depois de Vida ao ar livre) leva você a um instrutor de engenharia que ensina de graça.",

	-- Step 12: Handful of Copper Bolts to 57
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 57"] = "{spell:3922} até 57",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2770} Copper Ore
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags. {item:2840} (75 for 1-75): {skill:186}: smelt {item:2770}; or the Auction House."] = "{spell:3922} é laranja em 35 (amarelo 45, verde 52, cinza 60): cerca de 33 criações até 57. Cada uma usa 1 {item:2840}. Uma {item:2840} por criação. Guarde os parafusos: Fechadura de Exercício e engenhocas futuras usam. Precisa de uma bigorna por perto. {item:5956} é uma ferramenta: mantenha nas bolsas. {item:2840} (75 para 1-75): {skill:186}: funda {item:2770}; ou na Casa de Leilões.",

	-- Step 13: Engineering recipes at 57
	-- {skill:202} Engineering
	["{skill:202} recipes at 57"] = "Receitas de {skill:202} em 57",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "Volte a um instrutor de {skill:202}: {spell:7430} (a partir de 50, 1s 50c) e {spell:3924} (a partir de 50, 1s 50c).",

	-- Step 14: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "{spell:3924} até 75",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 57 (yellow 80, green 95, grey 110): about 18 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "{spell:3924} é laranja em 57 (amarelo 80, verde 95, cinza 110): cerca de 18 criações até 75, um ponto por criação. Cada uma usa 2 {item:2840} e 1 {item:2880}. Duas Barras de Cobre e um {item:2880} por criação (vendedores de ferraria e engenharia). Precisa de uma bigorna por perto. Faça a {item:6219} agora, enquanto ainda dá ponto: uma receita futura precisa dele nas bolsas, então guarde.",
	["a tool: keep it in your bags"] = "uma ferramenta: mantenha-a nas bolsas",

	-- Step 15: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202} (Profissional)",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11029} Trixie Quikswitch · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {npc:3412} Nogg · {zone:1454} Orgrimmar · {spell:3929} Coarse Blasting Powder · {spell:3930} Crafted Heavy Shot · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) and {npc:11029} ({zone:1455}); Horde {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s (preço do Classic; o do Forever não está nos dados); exige {skill:202} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:202} ensina: Aliança {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) e {npc:11029} ({zone:1455}); Horda {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) e Roxxik ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:3929} (a partir de 75, 2s 50c) e {spell:3930} (a partir de 75, 2s 50c). De 75 a 150 gasta cerca de 5s em receitas e 45s em itens de vendedor, além de 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} e 2 {item:2842} para coletar ou comprar.",

	-- Step 16: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "{skill:202} 75-150: itens de vendedor",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 45 {item:2880} (45s); cerca de 45s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:5519}, {npc:5514} e {npc:1286}; {zone:1454}: {npc:3367}, Gorina e {npc:5817}).",

	-- Step 17: Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1436} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (perícia 65); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1436} está marcado.",

	-- Step 18: Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (perícia 65); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1432} está marcado.",

	-- Step 19: Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1439} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (perícia 65); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1439} está marcado.",

	-- Step 20: Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1413} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (perícia 65); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1413} está marcado.",

	-- Step 21: Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1421} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (perícia 65); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1421} está marcado.",

	-- Step 22: Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "27 {item:2838} para {spell:3945}: {skill:186}: {object:1735} (perícia 125); ou na Casa de Leilões. O maior aglomerado de {object:1735} em {zone:1417} está marcado.",

	-- Step 23: Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1440} is marked."] = "27 {item:2838} para {spell:3945}: {skill:186}: {object:1735} (perícia 125); ou na Casa de Leilões. O maior aglomerado de {object:1735} em {zone:1440} está marcado.",

	-- Step 24: Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1413} is marked."] = "27 {item:2838} para {spell:3945}: {skill:186}: {object:1735} (perícia 125); ou na Casa de Leilões. O maior aglomerado de {object:1735} em {zone:1413} está marcado.",

	-- Step 26: Crafted Heavy Shot to 94
	-- {spell:3930} Crafted Heavy Shot
	["{spell:3930} to 94"] = "{spell:3930} até 94",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar · {skill:186} Mining · {item:2770} Copper Ore
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor. {item:2840} (72 for 75-150): {skill:186}: smelt {item:2770}; or the Auction House."] = "{spell:3930} é laranja em 75 (amarelo 85, verde 90, cinza 95): cerca de 15 criações até 94. Cada uma usa 1 {spell:3929} e 1 {item:2840} e produz 200. Faça primeiro as 15 {spell:3929}: elas também dão pontos enquanto não estão cinza. A {spell:3929} de cada uma dá seu próprio ponto enquanto não está cinza: duas chances por criação. Venda a munição para caçadores ou para um vendedor. {item:2840} (72 para 75-150): {skill:186}: funda {item:2770}; ou na Casa de Leilões.",

	-- Step 27: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "{spell:3924} até 100",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby."] = "{spell:3924} é amarela em 94 (amarelo 80, verde 95, cinza 110): cerca de 14 criações até 100. Cada uma usa 2 {item:2840} e 1 {item:2880}. Duas Barras de Cobre e um {item:2880} por criação (vendedores de ferraria e engenharia). Precisa de uma bigorna por perto.",

	-- Step 28: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "Receitas de {skill:202} em 100",
	-- {skill:202} Engineering · {spell:8334} Practice Lock
	["Back to an {skill:202} trainer: {spell:8334} (from 100)."] = "Volte a um instrutor de {skill:202}: {spell:8334} (a partir de 100).",

	-- Step 29: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "{item:6712} até 125",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby. {item:2841} (61 for 75-150): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "{item:6712} é laranja em 100 (amarelo 115, verde 122, cinza 130): cerca de 31 criações até 125. Cada uma usa 1 {item:2841}, 2 {spell:3922} e 1 {item:2880}. Faça primeiro as 29 {spell:3922}. Use as 33 {spell:3922} que você fez antes; as contagens acima não as incluem. Fechaduras de Exercício vendem para ladinos, ou abra você mesmo. Precisa de uma bigorna por perto. {item:2841} (61 para 75-150): {skill:186}: funda {item:2840} e {item:3576}; ou na Casa de Leilões.",

	-- Step 30: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "Receitas de {skill:202} em 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "Volte a um instrutor de {skill:202}: {spell:3945} (a partir de 125).",

	-- Step 31: Heavy Blasting Powder to 140
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 140"] = "{spell:3945} até 140",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 27 crafts to 140. Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "{spell:3945} é amarela em 125 (amarelo 125, verde 135, cinza 145): cerca de 27 criações até 140. Cada uma usa 1 {item:2838}. Uma {item:2838} por criação (Depósitos de Ferro). Guarde algumas: cada Granada de Ferro usa uma.",

	-- Step 32: Engineering recipes at 140
	-- {skill:202} Engineering
	["{skill:202} recipes at 140"] = "Receitas de {skill:202} em 140",
	-- {skill:202} Engineering · {spell:3973} Silver Contact · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3973} (from 90) and {spell:3950} (from 140)."] = "Volte a um instrutor de {skill:202}: {spell:3973} (a partir de 90) e {spell:3950} (a partir de 140).",

	-- Step 33: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "{spell:3950} até 150",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {item:2842} Silver Bar · {skill:186} Mining · {item:2775} Silver Ore · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {item:2842} (2 for 75-150): {skill:186}: smelt {item:2775}; or the Auction House. {skill:202} 150 is a Legacy System milestone."] = "{spell:3950} é amarela em 140 (amarelo 140, verde 165, cinza 190): cerca de 10 criações até 150. Cada uma usa 2 {item:4377}, 3 {item:2841} e 1 {spell:3973} e produz 3. Faça primeiro as 10 {spell:3973} (2 criações). Use as 20 {item:4377} que você fez antes; as contagens acima não as incluem. O instrutor ensina, e é o jeito mais barato de passar por esses pontos nos dados. Precisa de uma bigorna por perto. {item:2842} (2 para 75-150): {skill:186}: funda {item:2775}; ou na Casa de Leilões. {skill:202} 150 é um marco do Sistema de Legado.",

	-- Step 34: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "{skill:202} (Perito)",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}) and {npc:5174} ({zone:1455}); Horde {npc:8736} ({zone:1446}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "Perito eleva o limite de 150 para 225 por 50s (preço do Classic; o do Forever não está nos dados); exige {skill:202} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: Aliança {npc:8736} ({zone:1446}) e {npc:5174} ({zone:1455}); Horda {npc:8736} ({zone:1446}) e Roxxik ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:9271} (a partir de 150) e {spell:3953} (a partir de 145). De 150 a 225 gasta cerca de 31s em itens de vendedor, além de 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} e 62 {item:7912} para coletar ou comprar.",

	-- Step 35: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "{skill:202} 150-225: itens de vendedor",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3333} Shankys · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286}; {zone:1454}: {npc:3367}, {npc:3333} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 31 {item:6530} (31s); cerca de 31s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:5494} e {npc:1286}; {zone:1454}: {npc:3367}, {npc:3333} e {npc:5817}).",

	-- Step 36: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Aliança)",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "19 {item:2319} para {spell:3953}: {skill:393}: feras de nível 18-30; ou na Casa de Leilões. Esfole {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Mordelisca, {npc:2384} e {npc:2354} aqui (nível 18-30); o guia de {skill:393} traça essa rota.",

	-- Step 37: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "19 {item:2319} para {spell:3953}: {skill:393}: feras de nível 18-30; ou na Casa de Leilões. Esfole {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} e {npc:3817} aqui (nível 18-30); o guia de {skill:393} traça essa rota.",

	-- Step 38: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:3953} Bronze Framework
	["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "19 {item:2592} para {spell:3953}: humanoides de nível 15-30 soltam; ou na Casa de Leilões. A seta escolhe um ponto de farm para seu nível e facção.",

	-- Step 39: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Aliança)",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "31 {item:2836} para {item:6533}: {skill:186}: {object:1732} (perícia 65) em {zone:1432} (10-20), {zone:1440} (18-30) e {zone:1424} (20-30); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1432} está marcado.",

	-- Step 40: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horda)",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1440} is marked."] = "31 {item:2836} para {item:6533}: {skill:186}: {object:1732} (perícia 65) em {zone:1413} (10-25), {zone:1440} (18-30) e {zone:1424} (20-30); ou na Casa de Leilões. O maior aglomerado de {object:1732} em {zone:1440} está marcado.",

	-- Step 41: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Aliança)",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "74 {item:2838} para {spell:3967}: {skill:186}: {object:1735} (perícia 125) em {zone:1417} (30-40), {zone:1434} (30-45) e {zone:1443} (30-40); ou na Casa de Leilões. O maior aglomerado de {object:1735} em {zone:1417} está marcado.",

	-- Step 42: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horda)",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest cluster of {object:1735} in {zone:1441} is marked."] = "74 {item:2838} para {spell:3967}: {skill:186}: {object:1735} (perícia 125) em {zone:1441} (25-35), {zone:1417} (30-40) e {zone:1434} (30-45); ou na Casa de Leilões. O maior aglomerado de {object:1735} em {zone:1441} está marcado.",

	-- Step 43: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Aliança)",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1434} is marked."] = "62 {item:7912} para {item:10505}: {skill:186}: {object:2040} (perícia 175) em {zone:1434} (30-45), {zone:1425} (40-50) e {zone:1444} (40-50); ou na Casa de Leilões. O maior aglomerado de {object:2040} em {zone:1434} está marcado.",

	-- Step 44: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horda)",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "62 {item:7912} para {item:10505}: {skill:186}: {object:2040} (perícia 175) em {zone:1443} (30-40), {zone:1425} (40-50) e {zone:1444} (40-50); ou na Casa de Leilões. O maior aglomerado de {object:2040} em {zone:1443} está marcado.",

	-- Step 45: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "{item:6533} até 166",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen. {item:2841} (100 for 150-225): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "{item:6533} é amarelo em 150 (amarelo 150, verde 160, cinza 170): cerca de 31 criações até 166. Cada uma usa 2 {item:2841}, 1 {item:6530} e 1 {spell:3929} e produz 3. Faça primeiro as 31 {spell:3929}. {item:6530} vêm de vendedores de mercadorias e de pesca; os atrativos são vendidos a pescadores. {item:2841} (100 para 150-225): {skill:186}: funda {item:2840} e {item:3576}; ou na Casa de Leilões.",

	-- Step 46: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} até 175",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175. Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "{spell:3953} é amarela em 166 (amarelo 145, verde 170, cinza 195): cerca de 19 criações até 175. Cada uma usa 2 {item:2841}, 1 {item:2319} e 1 {item:2592}. Estruturas de Bronze são peças para engenhocas futuras; as sobras vendem para vendedores.",

	-- Step 47: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "Receitas de {skill:202} em 175",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder
	["Back to an {skill:202} trainer: {spell:12585} (from 175)."] = "Volte a um instrutor de {skill:202}: {spell:12585} (a partir de 175).",

	-- Step 48: Solid Blasting Powder to 191
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 191"] = "{item:10505} até 191",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 31 crafts to 191. Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "{item:10505} é amarelo em 175 (amarelo 175, verde 185, cinza 195): cerca de 31 criações até 191. Cada uma usa 2 {item:7912}. Duas {item:7912} por criação (Depósitos de Mithril). Faça bastante: os gatilhos, as balas e os cartuchos giroscópicos usam.",

	-- Step 49: Engineering recipes at 191
	-- {skill:202} Engineering
	["{skill:202} recipes at 191"] = "Receitas de {skill:202} em 191",
	-- {skill:202} Engineering · {spell:3967} Big Iron Bomb
	["Back to an {skill:202} trainer: {spell:3967} (from 190)."] = "Volte a um instrutor de {skill:202}: {spell:3967} (a partir de 190).",

	-- Step 50: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "{spell:3967} até 210",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep · {skill:186} Mining · {item:2775} Silver Ore · {item:2772} Iron Ore
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. {item:2842} (6 for 150-225): {skill:186}: smelt {item:2775}; or the Auction House. {item:3575} (81 for 150-225): {skill:186}: smelt {item:2772}; or the Auction House."] = "{spell:3967} é amarela em 191 (amarelo 190, verde 210, cinza 230): cerca de 27 criações até 210. Cada uma usa 3 {item:3575}, 3 {spell:3945} e 1 {spell:3973} e produz 2. Faça primeiro as 74 {spell:3945} e as 30 {spell:3973} (6 criações). Use as 7 {spell:3945} que você fez antes; as contagens acima não as incluem. Uma {item:2842} produz cinco Contatos de Prata (já cinza: sem pontos, mas sem viagem a um vendedor); a {spell:3945} vem de {item:2838}. Cada criação produz duas bombas. Especialização (opcional): com 200 e nível de personagem 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) ou Guariba ({area:392}) manda você a {spell:20220} ({npc:7944}, {zone:1455}, ou {npc:7406}, {area:35}: 6 Tubos de Mithril, uma {item:4407} e 2 Bonecos-alvo Avançados) ou à Engenharia goblínica ({npc:8126}, {area:976}: 20 Bombas Grandes de Ferro, 20 {item:10507} e 5 {npc:2675}). O esquema da {item:4407} agora é vinculado ao pegar, mas a missão pede uma luneta feita por outra pessoa. O cartão de membro dura 14 dias de jogo; renovar custa 2g. Você só pode escolher uma; nenhuma é necessária para chegar a 300, e o beta nunca as testou (parou no nível 30). Precisa de uma bigorna por perto. {item:2842} (6 para 150-225): {skill:186}: funda {item:2775}; ou na Casa de Leilões. {item:3575} (81 para 150-225): {skill:186}: funda {item:2772}; ou na Casa de Leilões.",

	-- Step 51: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "Receitas de {skill:202} em 210",
	-- {skill:202} Engineering · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12596} (from 210)."] = "Volte a um instrutor de {skill:202}: {spell:12596} (a partir de 210).",

	-- Step 52: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} até 225",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (19 for 150-225): {skill:186}: smelt {item:3858}; or the Auction House. {skill:202} 225 is a Legacy System milestone."] = "{item:10512} é amarelo em 210 (amarelo 210, verde 230, cinza 250): cerca de 19 criações até 225. Cada uma usa 1 {item:3860} e 1 {item:10505} e produz 200. Use as 19 {item:10505} que você fez antes; as contagens acima não as incluem. Uma {item:3860} e um {item:10505} por criação; caçadores compram as balas. Precisa de uma bigorna por perto. {item:3860} (19 para 150-225): {skill:186}: funda {item:3858}; ou na Casa de Leilões. {skill:202} 225 é um marco do Sistema de Legado.",

	-- Step 53: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "{skill:202} (Artífice)",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). The arrow picks the nearest of your faction. 225-300 takes about 2g 80s of recipes, plus 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047} to gather or buy."] = "Artífice eleva o limite de 225 para 300 por 4g 50s (preço do Classic; o do Forever não está nos dados); exige {skill:202} 200 e nível de personagem 35, então você pode aprender em qualquer visita a partir de 200. Só alguns instrutores ensinam: Aliança {npc:8736} ({zone:1446}); Horda {npc:8736} ({zone:1446}). A seta escolhe o mais próximo da sua facção. De 225 a 300 gasta cerca de 2g 80s em receitas, além de 118 {item:3860}, 212 {item:7912}, 156 {item:12359} e 24 {item:14047} para coletar ou comprar.",

	-- Step 54: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:16042} ensina {item:15994} ({skill:202} 260) por 1g 20s. Vendido, na Aliança, por {npc:5175} ({zone:1455}), estoque limitado; na Horda, por {npc:3413} ({zone:1454}), estoque limitado. Os vendedores mantêm um ou dois em estoque, que voltam algum tempo depois de uma venda; a Casa de Leilões muitas vezes também tem.",

	-- Step 55: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by Alliance: {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock; Horde: {npc:11185} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:16047} ensina {item:16000} ({skill:202} 275) por 1g 60s. Vendido, na Aliança, por {npc:260565} ({zone:2548}) e {npc:11185} ({zone:1452}), estoque limitado; na Horda, por {npc:11185} ({zone:1452}), estoque limitado. Os vendedores mantêm um ou dois em estoque, que voltam algum tempo depois de uma venda; é vinculado ao pegar, então a Casa de Leilões nunca tem.",

	-- Step 56: Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest cluster of {object:2040} in {zone:1425} is marked."] = "212 {item:7912} para {item:10512} e {item:10513}: {skill:186}: {object:2040} (perícia 175) em {zone:1425} (40-50), {zone:1444} (40-50) e {zone:1447} (45-55); ou na Casa de Leilões. O maior aglomerado de {object:2040} em {zone:1425} está marcado.",

	-- Step 57: Solid Stone (Horde)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "212 {item:7912} para {item:10512} e {item:10513}: {skill:186}: {object:2040} (perícia 175) em {zone:1443} (30-40), {zone:1425} (40-50) e {zone:1444} (40-50); ou na Casa de Leilões. O maior aglomerado de {object:2040} em {zone:1443} está marcado.",

	-- Step 58: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Aliança)",
	-- {item:14047} Runecloth · {item:15994} Thorium Widget · {npc:7027} Blackrock Slayer
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "24 {item:14047} para {item:15994}: humanoides de nível 45-60 soltam; ou na Casa de Leilões. Vem de {npc:7027} (nível 56-57) aqui.",

	-- Step 59: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {item:14047} Runecloth · {item:15994} Thorium Widget · {npc:11880} Twilight Avenger
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "24 {item:14047} para {item:15994}: humanoides de nível 45-60 soltam; ou na Casa de Leilões. Vem de {npc:11880} (nível 57-59) aqui.",

	-- Step 60: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} até 245",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (118 for 225-300): {skill:186}: smelt {item:3858}; or the Auction House."] = "{item:10512} é amarelo em 225 (amarelo 210, verde 230, cinza 250): cerca de 62 criações até 245. Cada uma usa 1 {item:3860} e 1 {item:10505} e produz 200. Faça primeiro as 50 {item:10505}. Use as 12 {item:10505} que você fez antes; as contagens acima não as incluem. Uma {item:3860} e um {item:10505} por criação; caçadores compram as balas. Precisa de uma bigorna por perto. {item:3860} (118 para 225-300): {skill:186}: funda {item:3858}; ou na Casa de Leilões.",

	-- Step 61: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "Receitas de {skill:202} em 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} (from 245)."] = "Volte a um instrutor de {skill:202}: {spell:12621} (a partir de 245).",

	-- Step 62: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "{item:10513} até 265",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby."] = "{item:10513} é amarelo em 245 (amarelo 245, verde 265, cinza 285): cerca de 28 criações até 265. Cada uma usa 2 {item:3860} e 2 {item:10505} e produz 200. Faça primeiro as 56 {item:10505}. Duas Barras de Mithril e dois {item:10505} por criação. Precisa de uma bigorna por perto.",

	-- Step 63: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "{item:15994} até 287",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth · {skill:186} Mining · {item:10620} Thorium Ore
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby. {item:12359} (156 for 225-300): {skill:186}: smelt {item:10620}; or the Auction House."] = "{item:15994} é laranja em 265 (amarelo 280, verde 290, cinza 300): cerca de 24 criações até 287. Cada uma usa 3 {item:12359} e 1 {item:14047}. Três Barras de Tório e um {item:14047} por criação; as engenhocas são peças para as engenhocas de Tório futuras. Precisa de uma bigorna por perto. {item:12359} (156 para 225-300): {skill:186}: funda {item:10620}; ou na Casa de Leilões.",
	["from the recipe in your bags"] = "pela receita nas suas bolsas",

	-- Step 64: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} até 300",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300. Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "{item:16000} é laranja em 287 (amarelo 295, verde 305, cinza 315): cerca de 14 criações até 300. Cada uma usa 6 {item:12359}. O esquema é vinculado ao pegar; seis Barras de Tório por criação. Precisa de uma bigorna por perto. {skill:202} 300 é um marco do Sistema de Legado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:202}"] = "{skill:202} (Aprendiz)",
	-- ["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Artífice exige nível de personagem 35 e {skill:202} 200; eleva o limite para 300. Os materiais de 225-300 valem cerca de 67g no total.",
	-- ["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Volte a um instrutor de {skill:202}: {spell:12585}, {spell:12596} são ensinados a partir de {skill:202} 210.",
	-- ["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Volte a um instrutor de {skill:202}: {spell:12590} é ensinado a partir de {skill:202} 175.",
	-- ["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Volte a um instrutor de {skill:202}: {spell:12621} é ensinado a partir de {skill:202} 245.",
	-- ["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Volte a um instrutor de {skill:202}: {spell:3922} é ensinado a partir de {skill:202} 45.",
	-- ["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Volte a um instrutor de {skill:202}: {spell:3923} é ensinado a partir de {skill:202} 60.",
	-- ["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Volte a um instrutor de {skill:202}: {spell:3924} é ensinado a partir de {skill:202} 80.",
	-- ["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Volte a um instrutor de {skill:202}: {spell:3926} é ensinado a partir de {skill:202} 95.",
	-- ["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Volte a um instrutor de {skill:202}: {spell:3929} é ensinado a partir de {skill:202} 85.",
	-- ["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Volte a um instrutor de {skill:202}: {spell:3937} é ensinado a partir de {skill:202} 105.",
	-- ["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Volte a um instrutor de {skill:202}: {spell:3942} é ensinado a partir de {skill:202} 125.",
	-- ["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Volte a um instrutor de {skill:202}: {spell:3945} é ensinado a partir de {skill:202} 125.",
	-- ["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Perito exige nível de personagem 20 e {skill:202} 125; eleva o limite para 225. Os materiais de 150-225 valem cerca de 15g no total.",
	-- ["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}) and {npc:5174} ({zone:1455}); Horde {npc:8736} ({zone:1446}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "Perito eleva o limite de 150 para 225 por 50s (preço do Classic; o do Forever não está nos dados); exige {skill:202} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: Aliança {npc:8736} ({zone:1446}) e {npc:5174} ({zone:1455}); Horda {npc:8736} ({zone:1446}) e Roxxik ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:9271} (a partir de 150) e {spell:3953} (a partir de 145). De 150 a 225 gasta cerca de 31s em itens de vendedor, além de 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} e 62 {item:7912} para coletar ou comprar.",
	-- ["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Profissional exige nível de personagem 10 e {skill:202} 50; eleva o limite para 150. Os materiais de 75-150 valem cerca de 3g 23s no total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) and {npc:11029} ({zone:1455}); Horde {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s (preço do Classic; o do Forever não está nos dados); exige {skill:202} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:202} ensina: Aliança {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) e {npc:11029} ({zone:1455}); Horda {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) e Roxxik ({zone:1454}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:3929} (a partir de 75, 2s 50c) e {spell:3930} (a partir de 75, 2s 50c). De 75 a 150 gasta cerca de 5s em receitas e 45s em itens de vendedor, além de 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} e 2 {item:2842} para coletar ou comprar.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mate os monstros que o derrubam no local de coleta que o Polestar escolhe para seu nível e facção. A Casa de Leilões também serve.",
	-- ["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Laranja (um ponto a cada criação) até 20, amarelo até 30, verde até 40.",
	-- ["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Laranja (um ponto a cada criação) até 280, amarelo até 290, verde até 300. Exige uma bigorna por perto.",
	-- ["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Laranja (um ponto a cada criação) até 295, amarelo até 305, verde até 315. Exige uma bigorna por perto. {skill:202} 300 é um marco do Sistema de Legado.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Mordelisca, {npc:2384}, {npc:2354} aqui (feras de nível 18-30 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aqui (feras de nível 18-30 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Vêm de esfolar, desencantar ou de outra profissão: colete você mesmo ou compre na Casa de Leilões.",
	-- ["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Ensina {item:15994} (exige {skill:202} 260). Mercadores vendem em estoque limitado que se renova; a Casa de Leilões também costuma ter.",
	-- ["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Ensina {item:16000} (exige {skill:202} 275). Mercadores vendem em estoque limitado que se renova.",
	-- ["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 110, verde até 125: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 130, verde até 155: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 135, green until 145: not every craft gives a point."] = "Amarelo até 135, verde até 145: nem toda criação dá ponto.",
	-- ["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Amarelo até 150, verde até 175: nem toda criação dá ponto. Exige uma bigorna por perto. {skill:202} 150 é um marco do Sistema de Legado.",
	-- ["Yellow until 170, green until 195: not every craft gives a point."] = "Amarelo até 170, verde até 195: nem toda criação dá ponto.",
	-- ["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 195, verde até 215: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 230, verde até 250: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Amarelo até 230, verde até 250: nem toda criação dá ponto. Exige uma bigorna por perto. {skill:202} 225 é um marco do Sistema de Legado.",
	-- ["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 265, verde até 285: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 45, green until 60: not every craft gives a point."] = "Amarelo até 45, verde até 60: nem toda criação dá ponto.",
	-- ["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 52, verde até 60: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 75, verde até 90: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Amarelo até 75, verde até 90: nem toda criação dá ponto. Exige uma bigorna por perto. 75 é o limite de Aprendiz.",
	-- ["Yellow until 90, green until 95: not every craft gives a point."] = "Amarelo até 90, verde até 95: nem toda criação dá ponto.",
	-- ["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Amarelo até 95, verde até 110: nem toda criação dá ponto. Exige uma bigorna por perto.",
	-- ["{item:10498} to 210"] = "{item:10498} até 210",
	-- ["{item:10513} to 264"] = "{item:10513} até 264",
	-- ["{item:15994} to 288"] = "{item:15994} até 288",
	-- ["{item:2592} (Alliance)"] = "{item:2592} (Aliança)",
	-- ["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Aliança)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Horda)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} vem de jazidas de {object:1731} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} vem de jazidas de {object:1732} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} vem de jazidas de {object:1735} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: uma ferramenta, mantenha-a nas bolsas",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} vem de jazidas de {object:2040} ({skill:186}); este é o grupo mais denso nos dados. A Casa de Leilões também serve.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Mate {npc:3263} (nível 19-20) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Mate {npc:6189} (nível 51-52) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Mate {npc:7027} (nível 56-57) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Mate {npc:98} (nível 17-18) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funda {item:10620} (ou a Casa de Leilões)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funda {item:2770} (ou a Casa de Leilões)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funda {item:2840} (ou a Casa de Leilões)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funda {item:3575} (ou a Casa de Leilões)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funda {item:3858} (ou a Casa de Leilões)",
	-- ["{skill:202} materials for 1-75"] = "Materiais de {skill:202} para 1-75",
	-- ["{skill:202} materials for 150-225"] = "Materiais de {skill:202} para 150-225",
	-- ["{skill:202} materials for 225-300"] = "Materiais de {skill:202} para 225-300",
	-- ["{skill:202} materials for 75-150"] = "Materiais de {skill:202} para 75-150",
	-- ["{skill:202} recipes at 111"] = "Receitas de {skill:202} em 111",
	-- ["{skill:202} recipes at 139"] = "Receitas de {skill:202} em 139",
	-- ["{skill:202} recipes at 45"] = "Receitas de {skill:202} em 45",
	-- ["{skill:202} recipes at 60"] = "Receitas de {skill:202} em 60",
	-- ["{skill:202} recipes at 80"] = "Receitas de {skill:202} em 80",
	-- ["{skill:202} recipes at 85"] = "Receitas de {skill:202} em 85",
	-- ["{skill:202} recipes at 95"] = "Receitas de {skill:202} em 95",
	-- ["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} avança junto com o nivelamento. O Sistema de Legado do Forever recompensa profissões de criação nas perícias 150, 225 e 300 (os limites de Profissional, Perito e Artífice), então cada um desses marcos conta. Os materiais de 1-75 valem cerca de 62s no total.",
	-- ["{spell:3918} to 37"] = "{spell:3918} até 37",
	-- ["{spell:3920} to 45"] = "{spell:3920} até 45",
	-- ["{spell:3922} to 60"] = "{spell:3922} até 60",
	-- ["{spell:3923} to 75"] = "{spell:3923} até 75",
	-- ["{spell:3923} to 80"] = "{spell:3923} até 80",
	-- ["{spell:3924} to 85"] = "{spell:3924} até 85",
	-- ["{spell:3926} to 111"] = "{spell:3926} até 111",
	-- ["{spell:3929} to 95"] = "{spell:3929} até 95",
	-- ["{spell:3937} to 125"] = "{spell:3937} até 125",
	-- ["{spell:3942} to 150"] = "{spell:3942} até 150",
	-- ["{spell:3945} to 139"] = "{spell:3945} até 139",
}
