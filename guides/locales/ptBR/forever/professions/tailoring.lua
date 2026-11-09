-- Portuguese (Brazil) (ptBR): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "Aprender {skill:197}",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 50c of recipes and 7s 20c of vendor goods, plus 144 {item:2589} to gather or buy."] = "{skill:197} (Aprendiz) permite fabricar até 75 por 10c, em qualquer nível de personagem. Qualquer instrutor de {skill:197} da sua facção ensina; a seta indica o mais próximo. Guarde todo {item:2589} que saquear: humanoides de nível 5-20 o soltam. De 1 a 75 você gasta cerca de 50c em receitas e 7s 20c em itens de vendedor, além de 144 {item:2589} para coletar ou comprar.",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "{skill:197} 1-75: itens de vendedor",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 72 {item:2320} (7s 20c); cerca de 7s 20c no total. A seta indica o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 3: Linen Cloth
	-- {item:2589} Linen Cloth · {spell:2387} Linen Cloak · {item:7026} Linen Belt
	["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "144 {item:2589} para {spell:2387} e {item:7026}: humanoides de nível 5-20 o soltam; ou na Casa de Leilões. A seta indica um ponto de farm para o seu nível e facção.",

	-- Step 4: Linen Cloak to 15
	-- {spell:2387} Linen Cloak
	["{spell:2387} to 15"] = "{spell:2387} até 15",
	-- {spell:2387} Linen Cloak · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{spell:2387} is orange at 1 (yellow 35, green 47, grey 60): about 7 crafts to 15, a point every craft. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 7 {spell:2963} first: it gives points too while not grey. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{spell:2387} é laranja em 1 (amarelo 35, verde 47, cinza 60): cerca de 7 criações até 15, um ponto a cada criação. Cada uma usa 1 {spell:2963} e 1 {item:2320}. Faça primeiro as 7 {spell:2963}: elas também dão pontos enquanto não estão cinza. O instrutor ensina essa receita, e é o caminho mais barato por esses pontos nos dados.",

	-- Step 5: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "Receitas de {skill:197} aos 15",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "Volte a um instrutor de {skill:197}: {spell:8776} (a partir de 15, 50c).",

	-- Step 6: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} até 75",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "{item:7026} é laranja em 15 (amarelo 50, verde 67, cinza 85): cerca de 65 criações até 75. Cada uma usa 1 {spell:2963} e 1 {item:2320}. Faça primeiro as 65 {spell:2963}: elas também dão pontos enquanto não estão cinza. Cada cinto usa uma peça; os cintos podem ser vendidos a vendedores.",

	-- Step 7: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} (Profissional)",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:251991} Taleen Shimmerthread · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and Tepa ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s; exige {skill:197} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:197} ensina: na Aliança, {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Ilha de Zefras), Sellandus ({zone:1453}), {npc:251991} (Ilha de Zefras) e {npc:11052} ({zone:1445}); na Horda, {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Ilha de Zefras), {npc:11049} ({zone:1458}), {npc:251991} (Ilha de Zefras) e Thepa ({zone:1456}). A seta indica o mais próximo da sua facção. Aprenda agora: {spell:2964} (a partir de 55, 1s) e {spell:2402} (a partir de 55, 2s 50c). Aprenda também {spell:1229504} (1s): o item de acampamento do Forever para {skill:197}, uma {spell:2963} e um {item:2320}; cada facção tem o seu. A missão Introdução ao acampamento: {skill:197}, do guia de acampamento da sua área inicial (depois de Vida ao ar livre), leva você a um instrutor de alfaiataria que a ensina de graça. De 75 a 150 você gasta cerca de 11s em receitas e 1g 65s 50c em itens de vendedor, além de 567 {item:2592} e 204 {item:4306} para coletar ou comprar.",

	-- Step 8: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "{skill:197} 75-150: itens de vendedor",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) e 98 {item:2604} (49s); cerca de 1g 65s 50c no total. A seta indica o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 9: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Aliança)",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:98} Riverpaw Taskmaster
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:98} (level 17-18) here."] = "567 {item:2592} para {spell:2402} e {spell:3866}: humanoides de nível 15-30 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:98} (nível 17-18).",

	-- Step 10: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:3263} Bristleback Geomancer
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:3263} (level 19-20) here."] = "567 {item:2592} para {spell:2402} e {spell:3866}: humanoides de nível 15-30 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:3263} (nível 19-20).",

	-- Step 11: Silk Cloth (Alliance)
	-- {item:4306} Silk Cloth
	["{item:4306} (Alliance)"] = "{item:4306} (Aliança)",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:2240} Syndicate Footpad
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:2240} (level 32-33) here."] = "204 {item:4306} para {spell:3871}: humanoides de nível 25-45 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:2240} (nível 32-33).",

	-- Step 12: Silk Cloth (Horde)
	-- {item:4306} Silk Cloth
	["{item:4306} (Horde)"] = "{item:4306} (Horda)",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:11697} Mannoroc Lasher
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:11697} (level 29-30) here."] = "204 {item:4306} para {spell:3871}: humanoides de nível 25-45 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:11697} (nível 29-30).",

	-- Step 13: Woolen Cape to 104
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 104"] = "{spell:2402} até 104",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 42 crafts to 104. Each takes 1 {spell:2964} and 1 {item:2321}. Make the 42 {spell:2964} first: it gives points too while not grey. {spell:2964} is taught from 55 on Forever."] = "{spell:2402} é laranja em 75 (amarelo 80, verde 97, cinza 115): cerca de 42 criações até 104. Cada uma usa 1 {spell:2964} e 1 {item:2321}. Faça primeiro as 42 {spell:2964}: elas também dão pontos enquanto não estão cinza. {spell:2964} é ensinada a partir de 55 no Forever.",

	-- Step 14: Tailoring recipes at 104
	-- {skill:197} Tailoring
	["{skill:197} recipes at 104"] = "Receitas de {skill:197} aos 104",
	-- {skill:197} Tailoring · {spell:3866} Stylish Red Shirt
	["Back to a {skill:197} trainer: {spell:3866} (from 85, 2s 50c)."] = "Volte a um instrutor de {skill:197}: {spell:3866} (a partir de 85, 2s 50c).",

	-- Step 15: Stylish Red Shirt to 135
	-- {spell:3866} Stylish Red Shirt
	["{spell:3866} to 135"] = "{spell:3866} até 135",
	-- {spell:3866} Stylish Red Shirt · {spell:2964} Bolt of Woolen Cloth · {item:2604} Red Dye · {item:2321} Fine Thread · {item:2592} Wool Cloth
	["{spell:3866} is orange at 104 (yellow 110, green 127, grey 145): about 49 crafts to 135. Each takes 3 {spell:2964}, 2 {item:2604} and 1 {item:2321}. Make the 147 {spell:2964} first. Three woolen bolts and two {item:2604} a shirt; {item:2592} drops from humanoids of level 15-30."] = "{spell:3866} é laranja em 104 (amarelo 110, verde 127, cinza 145): cerca de 49 criações até 135. Cada uma usa 3 {spell:2964}, 2 {item:2604} e 1 {item:2321}. Faça primeiro as 147 {spell:2964}. Três peças de lã e dois {item:2604} por camisa; {item:2592} cai de humanoides de nível 15-30.",

	-- Step 16: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "Receitas de {skill:197} aos 135",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s) and {spell:3871} (from 135)."] = "Volte a um instrutor de {skill:197}: {spell:3839} (a partir de 100, 5s) e {spell:3871} (a partir de 135).",

	-- Step 17: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "{spell:3871} até 150",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {item:4306} Silk Cloth · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150. Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 51 {spell:3839} first. Silk bolts from here on: {item:4306} drops from humanoids of level 25-45. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "{spell:3871} é laranja em 135 (amarelo 145, verde 150, cinza 155): cerca de 17 criações até 150. Cada uma usa 3 {spell:3839}, 2 {item:2324} e 1 {item:2321}. Faça primeiro as 51 {spell:3839}. Daqui em diante, peças de seda: {item:4306} cai de humanoides de nível 25-45. {item:2324} vem de vendedores de alfaiataria e de suprimentos de comércio. {skill:197} 150 é um marco do Sistema de Legado.",

	-- Step 18: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "{skill:197} 150-225: itens de vendedor",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) e 80 {item:8343} (16g); cerca de 21g 16s no total. A seta indica o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "{item:7089} ensina {item:7053} ({skill:197} 140) por 15s. Vendido na Aliança por {npc:6576} ({zone:1444}), estoque limitado, e por {npc:251997} ({zone:1416}); na Horda por {npc:6574} ({zone:1417}), estoque limitado, e por {npc:251997} ({zone:1416}).",

	-- Step 20: Silk Cloth
	-- {item:4306} Silk Cloth · {item:7053} Azure Silk Cloak
	["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "264 {item:4306} para {item:7053}: humanoides de nível 25-45 o soltam; ou na Casa de Leilões. A seta indica um ponto de farm para o seu nível e facção.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Aliança)",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:4467} Vilebranch Soothsayer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:4467} (level 46-47) here."] = "900 {item:4338} para {item:9998} e {item:10024}: humanoides de nível 35-50 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:4467} (nível 46-47).",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Horda)",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:5472} Dunemaul Enforcer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:5472} (level 46-47) here."] = "900 {item:4338} para {item:9998} e {item:10024}: humanoides de nível 35-50 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:5472} (nível 46-47).",

	-- Step 23: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197} (Perito)",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}) and {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Perito eleva o limite de 150 para 225; exige {skill:197} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: na Aliança, {npc:1346} ({zone:1453}) e {npc:11052} ({zone:1445}); na Horda, {npc:2399} ({zone:1424}) e {npc:4576} ({zone:1458}). A seta indica o mais próximo da sua facção. Aprenda agora: {spell:3865} (a partir de 140). De 150 a 225 você gasta cerca de 15s em receitas e 21g 16s em itens de vendedor, além de 264 {item:4306} e 900 {item:4338} para coletar ou comprar. Venha com tudo na bolsa (os passos acima, o resto da Casa de Leilões): esses instrutores também ensinam {item:9998} (a partir de 170) e {item:10024} (a partir de 190), e as criações dispensam estação, então fabrique aqui mesmo e aprenda cada receita ao chegar à sua perícia. Uma viagem em vez de 3.",

	-- Step 24: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "{item:7053} até 170",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "{item:7053} é laranja em 150 (amarelo 160, verde 175, cinza 190): cerca de 22 criações até 170. Cada uma usa 3 {spell:3839}, 2 {item:6260} e 2 {item:2321}. Faça primeiro as 66 {spell:3839}. O padrão é o que foi comprado acima; é o caminho mais barato por esses pontos nos dados.",
	["from the recipe in your bags"] = "pela receita nas suas bolsas",

	-- Step 25: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "Receitas de {skill:197} aos 170",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "Ainda no instrutor de Perito: {spell:12048} (a partir de 170).",

	-- Step 26: Black Mageweave Vest to 197
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 197"] = "{item:9998} até 197",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 30 crafts to 197. Each takes 2 {spell:3865} and 3 {item:4291}. Make the 60 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:9998} é laranja em 170 (amarelo 185, verde 200, cinza 215): cerca de 30 criações até 197. Cada uma usa 2 {spell:3865} e 3 {item:4291}. Faça primeiro as 60 {spell:3865}. O instrutor ensina essa receita, e é o caminho mais barato por esses pontos nos dados.",

	-- Step 27: Tailoring recipes at 197
	-- {skill:197} Tailoring
	["{skill:197} recipes at 197"] = "Receitas de {skill:197} aos 197",
	-- {spell:12072} Black Mageweave Headband
	["Still at the Expert trainer: {spell:12072} (from 190)."] = "Ainda no instrutor de Perito: {spell:12072} (a partir de 190).",

	-- Step 28: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} até 225",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "{item:10024} é laranja em 197 (amarelo 205, verde 220, cinza 235): cerca de 40 criações até 225. Cada uma usa 3 {spell:3865} e 2 {item:8343}. Faça primeiro as 120 {spell:3865}. O instrutor ensina essa receita, e é o caminho mais barato por esses pontos nos dados. {skill:197} 225 é um marco do Sistema de Legado.",

	-- Step 29: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197} (Artífice)",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "Artífice eleva o limite de 225 para 300; exige {skill:197} 200 e nível de personagem 35, então você pode aprender em qualquer visita a partir de 200. Só alguns instrutores ensinam: na Aliança, {npc:11052} ({zone:1445}); na Horda, {npc:2399} ({zone:1424}). A seta indica o mais próximo da sua facção. Aprenda agora: {spell:18401} (a partir de 205) e {spell:18402} (a partir de 210). De 225 a 300 você gasta cerca de 1g 60s em receitas e 58g em itens de vendedor, além de 420 {item:8170}, 3195 {item:14047} e 124 {item:14227} para coletar ou comprar.",

	-- Step 30: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "{skill:197} 225-300: itens de vendedor",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 116 {item:14341} (58g); cerca de 58g no total. A seta indica o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:14481} ensina {item:13863} ({skill:197} 230) por 1g 60s. Vendido por {npc:11189} ({zone:1452}), estoque limitado. Os vendedores mantêm um ou dois em estoque, que voltam algum tempo depois de uma venda; ele é vinculado ao ser pego, então a Casa de Leilões nunca o tem.",

	-- Step 32: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Aliança)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} para {item:13863} e {item:13867}: {skill:393}: feras de nível 48-60; ou na Casa de Leilões. Esfole {npc:1815}, {npc:1816} e {npc:1817} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",

	-- Step 33: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} para {item:13863} e {item:13867}: {skill:393}: feras de nível 48-60; ou na Casa de Leilões. Esfole {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} e {npc:6377} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",

	-- Step 34: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Aliança)",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:7027} Blackrock Slayer
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "3195 {item:14047} para {item:13856}, {item:13863} e {item:13867}: humanoides de nível 45-60 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:7027} (nível 56-57).",

	-- Step 35: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:11880} Twilight Avenger
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "3195 {item:14047} para {item:13856}, {item:13863} e {item:13867}: humanoides de nível 45-60 o soltam; ou na Casa de Leilões. Aqui ele cai de {npc:11880} (nível 57-59).",

	-- Step 36: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Aliança)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} para {item:13867}: cai de {npc:1824} (nível 54-55) no ponto marcado, ou compre na Casa de Leilões.",

	-- Step 37: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horda)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:11739} Rock Stalker
	["124 {item:14227} for {item:13867}: it drops from {npc:11739} (level 57-59) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} para {item:13867}: cai de {npc:11739} (nível 57-59) no ponto marcado, ou compre na Casa de Leilões.",

	-- Step 38: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "{item:13856} até 234",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234. Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "{item:13856} é amarelo em 225 (amarelo 225, verde 240, cinza 255): cerca de 11 criações até 234. Cada uma usa 3 {item:14048} e 1 {item:14341}. Faça primeiro as 33 {item:14048}. {item:14341} vem de vendedores de alfaiataria.",

	-- Step 39: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "{item:13863} até 265",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265. Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "{item:13863} é laranja em 234 (amarelo 245, verde 260, cinza 275): cerca de 43 criações até 265. Cada uma usa 4 {item:14048}, 4 {item:8170} e 1 {item:14341}. Faça primeiro as 172 {item:14048}. {npc:11189} em {area:2255} mantém um padrão por vez; o túnel de {area:1769} saindo de {zone:1448} é o caminho de entrada, então nunca mate os furbolgs Presamatos pelo caminho.",

	-- Step 40: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "{item:13867} até 300",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {item:13863} Runecloth Gloves · {item:13864} Runecloth Boots · {npc:7940} Darnall · {zone:1450} Moonglade · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:254123} Runecloth Cuffs · {zone:2482} Mount Hyjal · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300. Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. No pattern on the Auction House? {item:13863} still give a point now and then to 275, and {item:13864} ({npc:7940}, {zone:1450}) to 280, at 4 bolts a craft. {item:14342} (pattern from {npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}; the wheel's blueprint drops from the {npc:246017} in the City of Dalaran) and {item:254123} (Pexmit in {zone:2482}, 10g; we could not confirm that vendor yet) are the other ways on. {skill:197} 300 is a Legacy System milestone."] = "{item:13867} é laranja em 265 (amarelo 275, verde 290, cinza 305): cerca de 62 criações até 300. Cada uma usa 7 {item:14048}, 2 {item:14227}, 4 {item:8170} e 1 {item:14341}. Faça primeiro as 434 {item:14048}. O padrão ({item:14504}) cai de monstros do mundo todo e não é vinculado: compre na Casa de Leilões. Sete peças, dois {item:14227} e quatro {item:8170} por criação: o trecho mais caro. As aranhas de {zone:1422} e {zone:1451} soltam a seda (os pontos marcados), ou compre na Casa de Leilões. Sem o padrão na Casa de Leilões? {item:13863} ainda dá um ponto de vez em quando até 275, e {item:13864} ({npc:7940}, {zone:1450}) até 280, com 4 peças por criação. {item:14342} (padrão com {npc:11189} ou {npc:11188} em {area:2255}; 2 {item:14256} em um Poço Lunar) fica laranja até 270 e amarelo até 285, mas só pode ser feito uma vez a cada quatro dias. Os padrões de {item:279943} (sandálias e cordões de cintura Merchant's Favor com {npc:248202} ou {npc:256735}; o esquema da roda cai do {npc:246017} na Cidade de Dalaran) e {item:254123} (Pexmit em {zone:2482}, 10g; ainda não conseguimos confirmar esse vendedor) são os outros caminhos. {skill:197} 300 é um marco do Sistema de Legado.",
	["from the pattern bought at the Auction House"] = "do padrão comprado na Casa de Leilões",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:197}"] = "{skill:197} (Aprendiz)",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Artífice exige nível de personagem 35 e {skill:197} 200; eleva o limite para 300. Os materiais de 225-300 valem cerca de 845g no total.",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Volte a um instrutor de {skill:197}: {spell:12048} é ensinado a partir de {skill:197} 185.",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Volte a um instrutor de {skill:197}: {spell:12072} é ensinado a partir de {skill:197} 205.",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Volte a um instrutor de {skill:197}: {spell:2402} é ensinado a partir de {skill:197} 80.",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Volte a um instrutor de {skill:197}: {spell:3848} é ensinado a partir de {skill:197} 110.",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Volte a um instrutor de {skill:197}: {spell:3852} é ensinado a partir de {skill:197} 125.",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Volte a um instrutor de {skill:197}: {spell:8776} é ensinado a partir de {skill:197} 50.",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Volte a um instrutor de {skill:197}: {spell:8799} é ensinado a partir de {skill:197} 180.",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Perito exige nível de personagem 20 e {skill:197} 125; eleva o limite para 225. Os materiais de 150-225 valem cerca de 135g no total.",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Profissional exige nível de personagem 10 e {skill:197} 50; eleva o limite para 150. Os materiais de 75-150 valem cerca de 17g no total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and Tepa ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s; exige {skill:197} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:197} ensina: na Aliança, {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Ilha de Zefras), Sellandus ({zone:1453}), {npc:251991} (Ilha de Zefras) e {npc:11052} ({zone:1445}); na Horda, {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Ilha de Zefras), {npc:11049} ({zone:1458}), {npc:251991} (Ilha de Zefras) e Thepa ({zone:1456}). A seta indica o mais próximo da sua facção. Aprenda agora: {spell:2964} (a partir de 55, 1s) e {spell:2402} (a partir de 55, 2s 50c). Aprenda também {spell:1229504} (1s): o item de acampamento do Forever para {skill:197}, uma {spell:2963} e um {item:2320}; cada facção tem o seu. A missão Introdução ao acampamento: {skill:197}, do guia de acampamento da sua área inicial (depois de Vida ao ar livre), leva você a um instrutor de alfaiataria que a ensina de graça. De 75 a 150 você gasta cerca de 11s em receitas e 1g 65s 50c em itens de vendedor, além de 567 {item:2592} e 204 {item:4306} para coletar ou comprar.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mate os monstros que o derrubam no local de coleta que o Polestar escolhe para seu nível e facção. A Casa de Leilões também serve.",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "No Forever, nenhuma receita ensinada por instrutores ou vendida por mercadores das duas facções dá pontos de {skill:197} além de 295, então o Polestar não tem rota para os últimos pontos. Receitas que ainda dão: {item:14342} (exige um Poço Lunar), {item:14137} (exige uma {item:279943}), {item:14155} (a receita é saque), {item:14128} (a receita é saque), {item:19047} (exige uma {item:279943}).",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Laranja (um ponto a cada criação) até 160, amarelo até 175, verde até 190.",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Laranja (um ponto a cada criação) até 245, amarelo até 260, verde até 275.",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Laranja (um ponto a cada criação) até 265, amarelo até 280, verde até 295.",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Laranja (um ponto a cada criação) até 40, amarelo até 50, verde até 60.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:1815}, {npc:1816}, {npc:1817} aqui (feras de nível 48-60 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aqui (feras de nível 48-60 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Vêm de esfolar, desencantar ou de outra profissão: colete você mesmo ou compre na Casa de Leilões.",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "Ensina {item:13863} (exige {skill:197} 230). Mercadores vendem em estoque limitado que se renova.",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "Ensina {item:254123} (exige {skill:197} 250).",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "Ensina {item:7053} (exige {skill:197} 140). Mercadores vendem em estoque limitado que se renova.",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "Amarelo até 127, verde até 145: nem toda criação dá ponto.",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Amarelo até 140, verde até 155: nem toda criação dá ponto. {skill:197} 150 é um marco do Sistema de Legado.",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "Amarelo até 190, verde até 200: nem toda criação dá ponto.",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "Amarelo até 200, verde até 215: nem toda criação dá ponto.",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Amarelo até 220, verde até 235: nem toda criação dá ponto. {skill:197} 225 é um marco do Sistema de Legado.",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "Amarelo até 240, verde até 255: nem toda criação dá ponto.",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "Amarelo até 67, verde até 85: nem toda criação dá ponto.",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarelo até 67, verde até 85: nem toda criação dá ponto. 75 é o limite de Aprendiz.",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "Amarelo até 97, verde até 115: nem toda criação dá ponto.",
	-- ["{item:10045} to 50"] = "{item:10045} até 50",
	-- ["{item:13856} to 236"] = "{item:13856} até 236",
	-- ["{item:13863} to 251"] = "{item:13863} até 251",
	-- ["{item:254123} to 295"] = "{item:254123} até 295",
	-- ["{item:7026} to 80"] = "{item:7026} até 80",
	-- ["{item:7053} to 180"] = "{item:7053} até 180",
	-- ["{item:7062} to 185"] = "{item:7062} até 185",
	-- ["{item:9998} to 205"] = "{item:9998} até 205",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Mate {npc:11739} (nível 57-59) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Mate {npc:1824} (nível 54-55) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Mate {npc:3263} (nível 19-20) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Mate {npc:5472} (nível 46-47) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Mate {npc:6006} (nível 52-53) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Mate {npc:6189} (nível 51-52) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Mate {npc:7027} (nível 56-57) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Mate {npc:98} (nível 17-18) aqui para obtê-lo. A Casa de Leilões também serve.",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (ou a Casa de Leilões)",
	-- ["{skill:197} materials for 75-150"] = "Materiais de {skill:197} para 75-150",
	-- ["{skill:197} recipes at 110"] = "Receitas de {skill:197} em 110",
	-- ["{skill:197} recipes at 125"] = "Receitas de {skill:197} em 125",
	-- ["{skill:197} recipes at 180"] = "Receitas de {skill:197} em 180",
	-- ["{skill:197} recipes at 185"] = "Receitas de {skill:197} em 185",
	-- ["{skill:197} recipes at 205"] = "Receitas de {skill:197} em 205",
	-- ["{skill:197} recipes at 50"] = "Receitas de {skill:197} em 50",
	-- ["{skill:197} recipes at 80"] = "Receitas de {skill:197} em 80",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} avança junto com o nivelamento. O Sistema de Legado do Forever recompensa profissões de criação nas perícias 150, 225 e 300 (os limites de Profissional, Perito e Artífice), então cada um desses marcos conta. Os materiais de 1-75 valem cerca de 1g 8s no total.",
	-- ["{spell:2402} to 110"] = "{spell:2402} até 110",
	-- ["{spell:3848} to 125"] = "{spell:3848} até 125",
	-- ["{spell:3852} to 150"] = "{spell:3852} até 150",
}
