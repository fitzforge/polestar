-- Portuguese (Brazil) (ptBR): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Leatherworking
	-- {skill:165} Leatherworking
	["Learn {skill:165}"] = "Aprender {skill:165}",
	-- {skill:165} Leatherworking · {skill:393} Skinning · {item:2318} Light Leather · {item:2320} Coarse Thread
	["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Any {skill:165} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "{skill:165} Aprendiz permite criar até 75 por 10c, em qualquer nível de personagem. Qualquer instrutor de {skill:165} da sua facção ensina; a seta escolhe o mais próximo. Combine com {skill:393}: {item:2318} vem das feras de todas as zonas iniciais. {item:2320} e Sal são vendidos por vendedores de couraria e de suprimentos de comércio. De 1 a 75 gasta cerca de 1s 50c em receitas e 5s em itens de vendedor, além de 349 {item:2318} para coletar ou comprar.",

	-- Step 2: Leatherworking 1-75: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 1-75: vendor goods"] = "{skill:165} 1-75: itens de vendedor",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 50 {item:2320} (5s); cerca de 5s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 3: Light Leather (Elwynn Forest)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1922} Gray Forest Wolf · {npc:525} Mangy Wolf · {npc:524} Rockhide Boar · {npc:113} Stonetusk Boar · {npc:822} Young Forest Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole {npc:1922}, {npc:525}, Predador, {npc:524}, {npc:113} e {npc:822} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 4: Light Leather (Dun Morogh)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} e {npc:1128} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 5: Light Leather (Teldrassil)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2033} Elder Nightsaber · {npc:2043} Nightsaber Stalker
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole {npc:2033}, Sabre-da-noite e {npc:2043} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 6: Light Leather (Zephras Isle)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:250928} Highlands Ursera · {npc:251284} Hippogryph Protector · {npc:251291} Hippogryph Youth · {npc:251707} Ornery Galestrider · {npc:256092} Shadowgale Shriekling · {npc:253282} Shriekling Fledgling · {npc:250874} Vuldren Alpha · {npc:254588} Windsong Crawler
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole Correnuvens, Vagaventos, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Garraltiva, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} e {npc:254588} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 7: Light Leather (Durotar)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} e {npc:3127} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 8: Light Leather (Mulgore)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2956} Adult Plainstrider · {npc:2957} Elder Plainstrider · {npc:3035} Flatland Cougar · {npc:3566} Flatland Prowler · {npc:2972} Kodo Calf · {npc:2959} Prairie Stalker · {npc:2958} Prairie Wolf · {npc:2960} Prairie Wolf Alpha
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} e {npc:2960} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 9: Light Leather (Tirisfal Glades)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1548} Cursed Darkhound · {npc:1547} Decrepit Darkhound · {npc:1553} Greater Duskbat · {npc:1549} Ravenous Darkhound · {npc:1554} Vampiric Duskbat
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} para {spell:2152}, {spell:3756} e {spell:3763} (210 delas para 75-150: pegue todas agora): {skill:393}: feras de nível 5-20; ou na Casa de Leilões. Esfole {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} e {npc:1554} aqui (nível 5-20); o guia de {skill:393} traça essa rota.",

	-- Step 10: Light Armor Kit to 51
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 51"] = "{spell:2152} até 51",
	-- {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["{spell:2152} is orange at 1 (yellow 30, green 45, grey 60): about 64 crafts to 51. Each takes 1 {item:2318}. One {item:2318} a craft; the kits sell to vendors."] = "{spell:2152} é laranja em 1 (amarelo 30, verde 45, cinza 60): cerca de 64 criações até 51. Cada uma usa 1 {item:2318}. Um {item:2318} por criação; os kits vendem para vendedores.",

	-- Step 11: Leatherworking recipes at 51
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 51"] = "Receitas de {skill:165} em 51",
	-- {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {spell:1229432} Camp Tent · {item:2318} Light Leather
	["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "Volte a um instrutor de {skill:165}: {spell:3756} (a partir de 40, 1s 50c). Aprenda também {spell:1229432} (1s): o item de acampamento do Forever para {skill:165}, 5 {item:2318}, colocado em um acampamento ao lado de uma fogueira. A missão Introdução ao acampamento: {skill:165} do guia de acampamento da sua área inicial (depois de Vida ao ar livre) leva você a um instrutor de couraria que ensina de graça.",

	-- Step 12: Embossed Leather Gloves to 75
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 75"] = "{spell:3756} até 75",
	-- {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75. Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "{spell:3756} é laranja em 51 (amarelo 70, verde 85, cinza 100): cerca de 25 criações até 75. Cada uma usa 3 {item:2318} e 2 {item:2320}. O Forever ensina {spell:3756} a partir de 40.",

	-- Step 13: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "{skill:165} (Profissional)",
	-- {skill:165} Leatherworking · {npc:3967} Aayndia Floralwind · {zone:1440} Ashenvale · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {zone:1457} Darnassus · {npc:5127} Fimble Finespindle · {zone:1455} Ironforge · {npc:5564} Simon Tanner · {zone:1453} Stormwind City · {npc:4212} Telonis · {npc:4588} Arthur Moore · {zone:1458} Undercity · {npc:1385} Brawn · {zone:1434} Stranglethorn Vale · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {npc:3365} Karolek · {zone:1454} Orgrimmar · {npc:3703} Krulmoo Fullmoon · {zone:1413} The Barrens · {npc:8153} Narv Hidecrafter · {zone:1443} Desolace · {zone:1456} Thunder Bluff · {npc:3007} Una · {spell:3763} Fine Leather Belt · {item:2319} Medium Leather · {item:2457} Elixir of Minor Agility · {item:4234} Heavy Leather
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) and {npc:4212} ({zone:1457}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 308 {item:4234} to gather or buy."] = "Profissional eleva o limite de 75 para 150 por 5s; exige {skill:165} 50 e nível de personagem 10, então você pode aprender em qualquer visita a partir de 50. Nem todo instrutor de {skill:165} ensina: Aliança {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) e {npc:4212} ({zone:1457}); Horda {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) e {npc:3007} ({zone:1456}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:3763} (a partir de 55, 3s). De 75 a 150 gasta cerca de 15s 50c em receitas e 57s em itens de vendedor, além de 144 {item:2319}, 24 {item:2457} e 308 {item:4234} para coletar ou comprar.",

	-- Step 14: Leatherworking 75-150: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 75-150: vendor goods"] = "{skill:165} 75-150: itens de vendedor",
	-- {item:2320} Coarse Thread · {item:2321} Fine Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 70 {item:2320} (7s) and 50 {item:2321} (50s); about 57s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 70 {item:2320} (7s) e 50 {item:2321} (50s); cerca de 57s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 15: Medium Leather (Hillsbrad Foothills)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} para {item:7285}: {skill:393}: feras de nível 18-30; ou na Casa de Leilões. Esfole {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Mordelisca, {npc:2384} e {npc:2354} aqui (nível 18-30); o guia de {skill:393} traça essa rota.",

	-- Step 16: Medium Leather (Darkshore)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3823} Ghostpaw Runner · {npc:2071} Moonstalker Matriarch
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} para {item:7285}: {skill:393}: feras de nível 18-30; ou na Casa de Leilões. Esfole {npc:3823} e {npc:2071} aqui (nível 18-30); o guia de {skill:393} traça essa rota.",

	-- Step 17: Medium Leather (The Barrens)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3236} Barrens Kodo
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} para {item:7285}: {skill:393}: feras de nível 18-30; ou na Casa de Leilões. Esfole {npc:3236} e Cabeça-de-trovão aqui (nível 18-30); o guia de {skill:393} traça essa rota.",

	-- Step 19: Heavy Leather (Alterac Mountains)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:4304} Thick Leather · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "308 {item:4234} para {spell:3780} e {item:4304} (178 delas para 150-225: pegue todas agora): {skill:393}: feras de nível 28-40; ou na Casa de Leilões. Esfole {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} e Mordelisca aqui (nível 28-40); o guia de {skill:393} traça essa rota.",

	-- Step 20: Heavy Leather (Thousand Needles)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:4304} Thick Leather · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "308 {item:4234} para {spell:3780} e {item:4304} (178 delas para 150-225: pegue todas agora): {skill:393}: feras de nível 28-40; ou na Casa de Leilões. Esfole {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} e {npc:4142} aqui (nível 28-40); o guia de {skill:393} traça essa rota.",

	-- Step 23: Fine Leather Belt to 102
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 102"] = "{spell:3763} até 102",
	-- {spell:3763} Fine Leather Belt · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102. Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "{spell:3763} é laranja em 75 (amarelo 85, verde 100, cinza 115): cerca de 35 criações até 102. Cada uma usa 6 {item:2318} e 2 {item:2320}. O Forever ensina {spell:3763} a partir de 55.",

	-- Step 24: Leatherworking recipes at 102
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 102"] = "Receitas de {skill:165} em 102",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s)."] = "Volte a um instrutor de {skill:165}: {spell:9074} (a partir de 95, 5s).",

	-- Step 25: Nimble Leather Gloves to 125
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 125"] = "{item:7285} até 125",
	-- {item:7285} Nimble Leather Gloves · {item:2457} Elixir of Minor Agility · {item:2319} Medium Leather · {item:2321} Fine Thread · {item:2452} Swiftthistle · {item:765} Silverleaf · {spell:3763} Fine Leather Belt · {item:2316} Dark Leather Cloak · {item:4340} Gray Dye · {skill:171} Alchemy
	["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125. Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all. {item:2457} (24 for 75-150): {skill:171}: {item:2457}; or the Auction House."] = "{item:7285} é laranja em 102 (amarelo 120, verde 132, cinza 145): cerca de 24 criações até 125. Cada uma usa 1 {item:2457}, 6 {item:2319} e 1 {item:2321}. Cada uma usa um {item:2457}: um alquimista faz com uma {item:2452} e uma {item:765}, e a Casa de Leilões vende barato. Sem elixires, continue {spell:3763} até 105 e {item:2316} (a partir de 85: 8 {item:2319}, um {item:4340} e um {item:2321}) até 125: cerca de 28 capas, 224 {item:2319} no total. {item:2457} (24 para 75-150): {skill:171}: {item:2457}; ou na Casa de Leilões.",

	-- Step 26: Leatherworking recipes at 125
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 125"] = "Receitas de {skill:165} em 125",
	-- {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit
	["Back to a {skill:165} trainer: {spell:3780} (from 125, 7s 50c)."] = "Volte a um instrutor de {skill:165}: {spell:3780} (a partir de 125, 7s 50c).",

	-- Step 27: Heavy Armor Kit to 150
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 150"] = "{spell:3780} até 150",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread · {skill:165} Leatherworking
	["{spell:3780} is orange at 125 (yellow 145, green 155, grey 165): about 26 crafts to 150. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "{spell:3780} é laranja em 125 (amarelo 145, verde 155, cinza 165): cerca de 26 criações até 150. Cada uma usa 5 {item:4234} e 1 {item:2321}. Cinco {item:4234} por criação (feras de nível 28-40); os kits vendem para vendedores. {skill:165} 150 é um marco do Sistema de Legado.",

	-- Step 28: Leatherworking 150-225: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 150-225: vendor goods"] = "{skill:165} 150-225: itens de vendedor",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 8 {item:2321} (8s) and 32 {item:4291} (1g 60s); about 1g 68s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 8 {item:2321} (8s) e 32 {item:4291} (1g 60s); cerca de 1g 68s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 29: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Aliança)",
	-- {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather · {skill:393} Skinning · {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch
	["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "257 {item:4304} para {item:8173} e {item:8170}: {skill:393}: feras de nível 38-50; ou na Casa de Leilões. Esfole {npc:2729}, {npc:2730}, {npc:2732} e {npc:2734} aqui (nível 38-50); o guia de {skill:393} traça essa rota.",

	-- Step 30: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horda)",
	-- {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather · {skill:393} Skinning · {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti
	["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "257 {item:4304} para {item:8173} e {item:8170}: {skill:393}: feras de nível 38-50; ou na Casa de Leilões. Esfole {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} e {npc:5296} aqui (nível 38-50); o guia de {skill:393} traça essa rota.",

	-- Step 31: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "{skill:165} (Perito)",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:4212} Telonis · {zone:1457} Darnassus · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {npc:3007} Una · {zone:1456} Thunder Bluff · {item:4304} Thick Leather · {item:8173} Thick Armor Kit · {item:8170} Rugged Leather
	["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}) and {npc:4212} ({zone:1457}); Horde {npc:11098} ({zone:1444}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. 150-225 takes about 1g 68s of vendor goods, plus 257 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:4304} (from 155) and {item:8173} (from 175), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3. {item:8170} (from 205) takes a second trip, to other trainers (below)."] = "Perito eleva o limite de 150 para 225; exige {skill:165} 125 e nível de personagem 20, então você pode aprender em qualquer visita a partir de 125. Só alguns instrutores ensinam: Aliança {npc:11097} ({zone:1425}) e {npc:4212} ({zone:1457}); Horda {npc:11098} ({zone:1444}) e {npc:3007} ({zone:1456}). A seta escolhe o mais próximo da sua facção. De 150 a 225 gasta cerca de 1g 68s em itens de vendedor, além de 257 {item:4304} para coletar ou comprar. Venha com tudo nas bolsas (os passos acima, o resto da Casa de Leilões): esses instrutores também ensinam {item:4304} (a partir de 155) e {item:8173} (a partir de 175), e as criações não precisam de estação, então crie aqui mesmo e aprenda cada receita ao chegar na perícia dela. Uma viagem em vez de 3. {item:8170} (a partir de 205) exige uma segunda viagem, a outros instrutores (abaixo).",

	-- Step 32: Heavy Armor Kit to 155
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 155"] = "{spell:3780} até 155",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread
	["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 8 crafts to 155. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "{spell:3780} é amarela em 150 (amarelo 145, verde 155, cinza 165): cerca de 8 criações até 155. Cada uma usa 5 {item:4234} e 1 {item:2321}. Cinco {item:4234} por criação (feras de nível 28-40); os kits vendem para vendedores.",

	-- Step 33: Leatherworking recipes at 155
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 155"] = "Receitas de {skill:165} em 155",
	-- {spell:20650} Thick Leather
	["Still at the Expert trainer: {spell:20650} (from 155)."] = "Ainda no instrutor Perito: {spell:20650} (a partir de 155).",

	-- Step 34: Thick Leather to 177
	-- {item:4304} Thick Leather
	["{item:4304} to 177"] = "{item:4304} até 177",
	-- {item:4304} Thick Leather · {item:4234} Heavy Leather
	-- plural, as words: Thick Armor Kits = {item:8173} Thick Armor Kit
	["{item:4304} is orange at 155 (yellow 175, green 177, grey 180): about 23 crafts to 177. Each takes 6 {item:4234}. Six {item:4234} make one {item:4304}, orange until 175: keep them, the Thick Armor Kits next use them."] = "{item:4304} é laranja em 155 (amarelo 175, verde 177, cinza 180): cerca de 23 criações até 177. Cada uma usa 6 {item:4234}. Seis {item:4234} fazem um {item:4304}, laranja até 175: guarde, os Kits de Armadura Grossa usam em seguida.",

	-- Step 35: Leatherworking recipes at 177
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 177"] = "Receitas de {skill:165} em 177",
	-- {spell:10487} Thick Armor Kit
	["Still at the Expert trainer: {spell:10487} (from 175)."] = "Ainda no instrutor Perito: {spell:10487} (a partir de 175).",

	-- Step 36: Thick Armor Kit to 205
	-- {item:8173} Thick Armor Kit
	["{item:8173} to 205"] = "{item:8173} até 205",
	-- {item:8173} Thick Armor Kit · {item:4304} Thick Leather · {item:4291} Silken Thread
	["{item:8173} is orange at 177 (yellow 195, green 205, grey 215): about 32 crafts to 205. Each takes 5 {item:4304} and 1 {item:4291}. Use the 23 {item:4304} you made earlier; the counts above leave them out. Five {item:4304} a craft; the kits sell to vendors."] = "{item:8173} é laranja em 177 (amarelo 195, verde 205, cinza 215): cerca de 32 criações até 205. Cada uma usa 5 {item:4304} e 1 {item:4291}. Use os 23 {item:4304} que você fez antes; as contagens acima não os incluem. Cinco {item:4304} por criação; os kits vendem para vendedores.",

	-- Step 37: Leatherworking recipes at 205
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 205"] = "Receitas de {skill:165} em 205",
	-- {spell:22331} Rugged Leather · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {skill:165} Leatherworking
	["{spell:22331} (from 205) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "{spell:22331} (a partir de 205) só é ensinada pelos instrutores Artífice: Aliança {npc:11097} ({zone:1425}); Horda {npc:11098} ({zone:1444}). Você pode treinar Artífice lá agora se estiver no nível 35 (exige {skill:165} 200), o que poupa a viagem em 225.",

	-- Step 38: Rugged Leather to 225
	-- {item:8170} Rugged Leather
	["{item:8170} to 225"] = "{item:8170} até 225",
	-- {item:8170} Rugged Leather · {item:4304} Thick Leather · {skill:165} Leatherworking
	["{item:8170} is orange at 205 (yellow 225, green 225, grey 225): about 20 crafts to 225, a point every craft. Each takes 6 {item:4304}. {item:8170} from {item:4304}: the points come cheap and you need the {item:8170} next. {skill:165} 225 is a Legacy System milestone."] = "{item:8170} é laranja em 205 (amarelo 225, verde 225, cinza 225): cerca de 20 criações até 225, um ponto por criação. Cada uma usa 6 {item:4304}. {item:8170} a partir de {item:4304}: os pontos saem baratos e você precisa do {item:8170} em seguida. {skill:165} 225 é um marco do Sistema de Legado.",

	-- Step 39: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "{skill:165} (Artífice)",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {spell:19058} Rugged Armor Kit · {item:8170} Rugged Leather · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 205). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1009 {item:8170} and 430 {item:14047} to gather or buy."] = "Artífice eleva o limite de 225 para 300; exige {skill:165} 200 e nível de personagem 35, então você pode aprender em qualquer visita a partir de 200. Só alguns instrutores ensinam: Aliança {npc:11097} ({zone:1425}); Horda {npc:11098} ({zone:1444}). A seta escolhe o mais próximo da sua facção. Aprenda agora: {spell:19058} (a partir de 205). De 225 a 300 gasta cerca de 3g 40s em receitas e 44g 90s em itens de vendedor, além de 1009 {item:8170} e 430 {item:14047} para coletar ou comprar.",

	-- Step 40: Leatherworking 225-300: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 225-300: vendor goods"] = "{skill:165} 225-300: itens de vendedor",
	-- {item:2325} Black Dye · {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Compre de uma vez a parte desta faixa: 39 {item:2325} (3g 90s) e 82 {item:14341} (41g); cerca de 44g 90s no total. A seta escolhe o vendedor mais próximo da sua facção ({zone:1453}: {npc:1347}, {npc:1286} e {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} e {npc:5817}).",

	-- Step 41: Pattern: Wicked Leather Gauntlets
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking · {npc:12942} Leonard Porter · {zone:1422} Western Plaguelands · {npc:12943} Werg Thickblade
	["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15725} ensina {item:15083} ({skill:165} 235) por 1g 20s. Vendido, na Aliança, por {npc:12942} ({zone:1422}), estoque limitado; na Horda, por {npc:12943} ({zone:1422}), estoque limitado. Os vendedores mantêm um ou dois em estoque, que voltam algum tempo depois de uma venda; é vinculado ao pegar, então a Casa de Leilões nunca tem.",

	-- Step 42: Pattern: Runic Leather Headband
	-- {item:15756} Pattern: Runic Leather Headband · {item:15094} Runic Leather Headband · {skill:165} Leatherworking · {npc:12941} Jase Farlane · {zone:1423} Eastern Plaguelands
	["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15756} ensina {item:15094} ({skill:165} 265) por 2g 20s. Vendido por {npc:12941} ({zone:1423}), estoque limitado. Os vendedores mantêm um ou dois em estoque, que voltam algum tempo depois de uma venda; é vinculado ao pegar, então a Casa de Leilões nunca tem.",

	-- Step 43: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Aliança)",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "1009 {item:8170} para {item:15564}, {item:15083} e {item:15094}: {skill:393}: feras de nível 48-60; ou na Casa de Leilões. Esfole {npc:1815}, {npc:1816} e {npc:1817} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",

	-- Step 44: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "1009 {item:8170} para {item:15564}, {item:15083} e {item:15094}: {skill:393}: feras de nível 48-60; ou na Casa de Leilões. Esfole {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} e {npc:6377} aqui (nível 48-60); o guia de {skill:393} traça essa rota.",

	-- Step 45: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Aliança)",
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband · {npc:7027} Blackrock Slayer
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "430 {item:14047} para {item:15094}: humanoides de nível 45-60 soltam; ou na Casa de Leilões. Vem de {npc:7027} (nível 56-57) aqui.",

	-- Step 46: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband · {npc:11880} Twilight Avenger
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "430 {item:14047} para {item:15094}: humanoides de nível 45-60 soltam; ou na Casa de Leilões. Vem de {npc:11880} (nível 57-59) aqui.",

	-- Step 47: Rugged Armor Kit to 239
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 239"] = "{item:15564} até 239",
	-- {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather · {npc:7866} Peter Galen · {zone:1447} Azshara · {npc:7867} Thorkaf Dragoneye · {zone:1418} Badlands · {item:8204} Tough Scorpid Gloves · {zone:1446} Tanaris · {item:8165} Worn Dragonscale · {npc:7868} Sarah Tanner · {zone:1427} Searing Gorge · {npc:7869} Brumn Winterhoof · {zone:1417} Arathi Highlands · {item:7077} Heart of Fire · {item:7079} Globe of Water · {item:7075} Core of Earth · {item:7081} Breath of Wind · {npc:7870} Caryssia Moonhunter · {zone:1444} Feralas · {npc:7871} Se'Jib · {zone:1434} Stranglethorn Vale · {item:8211} Wild Leather Vest · {npc:7852} Pratt McGrubben · {npc:7854} Jangdor Swiftstrider · {item:279941} Tanning Rack
	-- plural, as words: Tough Scorpid Breastplates = {item:8203} Tough Scorpid Breastplate
	["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Use the 20 {item:8170} you made earlier; the counts above leave them out. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "{item:15564} é amarelo em 225 (amarelo 225, verde 235, cinza 245): cerca de 23 criações até 239. Cada uma usa 5 {item:8170}. Use os 20 {item:8170} que você fez antes; as contagens acima não os incluem. Cinco {item:8170} por criação. Especialização (opcional): em 225 e nível de personagem 40. Couraria Dragônica: {npc:7866} ({zone:1447}) ou {npc:7867} ({zone:1418}) quer 2 Peitorais Escorpídeos Resistentes, 2 {item:8204} (os moldes caem dos bandidos errantes em {zone:1446}) e 10 {item:8165}. Couraria Elemental: {npc:7868} ({zone:1427}) ou {npc:7869} ({zone:1417}) quer 2 de cada: {item:7077}, {item:7079}, {item:7075} e {item:7081}. Couraria Tribal (a partir de 235): {npc:7870} ({zone:1444}) ou {npc:7871} ({zone:1434}) quer um {item:8211} e um Capacete, depois das missões de Couro Silvestre de {npc:7852} ou {npc:7854} em {zone:1444}. No Forever os moldes de especialização precisam de um {item:279941}. Você só pode escolher uma; nenhuma é necessária para chegar a 300, e o beta nunca as testou (parou no nível 30).",

	-- Step 48: Wicked Leather Gauntlets to 269
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 269"] = "{item:15083} até 269",
	-- {item:15083} Wicked Leather Gauntlets · {item:8170} Rugged Leather · {item:2325} Black Dye · {item:14341} Rune Thread
	["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269. Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "{item:15083} é laranja em 239 (amarelo 255, verde 265, cinza 275): cerca de 39 criações até 269. Cada uma usa 8 {item:8170}, 1 {item:2325} e 1 {item:14341}. Oito {item:8170} por criação; {item:2325} e {item:14341} de vendedores de couraria ou alfaiataria.",
	["from the recipe in your bags"] = "da receita nas suas bolsas",

	-- Step 49: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094} até 300",
	-- {item:15094} Runic Leather Headband · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14341} Rune Thread · {skill:165} Leatherworking
	["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300. Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "{item:15094} é laranja em 269 (amarelo 285, verde 295, cinza 305): cerca de 43 criações até 300. Cada uma usa 14 {item:8170}, 10 {item:14047} e 1 {item:14341}. 14 {item:8170} e 10 {item:14047} por criação: o trecho mais caro. {skill:165} 300 é um marco do Sistema de Legado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:165}"] = "{skill:165} (Aprendiz)",
	-- ["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "Artífice exige nível de personagem 35 e {skill:165} 200; eleva o limite para 300. Os materiais de 225-300 valem cerca de 312o no total.",
	-- ["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:10482} e {spell:14932} a partir de {skill:165} 220.",
	-- ["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:10487} a partir de {skill:165} 195.",
	-- ["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:3763} a partir de {skill:165} 85.",
	-- ["Back to a {skill:165} trainer: {spell:3776} is taught from {skill:165} 175."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:3776} a partir de {skill:165} 175.",
	-- ["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:3817} e {spell:3768} a partir de {skill:165} 130.",
	-- ["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:7151} a partir de {skill:165} 170.",
	-- ["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:7156} a partir de {skill:165} 185.",
	-- ["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:9062} a partir de {skill:165} 55.",
	-- ["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:9068} a partir de {skill:165} 100.",
	-- ["Back to a {skill:165} trainer: {spell:9074} is taught from {skill:165} 120."] = "Volte a um instrutor de {skill:165}: ele ensina {spell:9074} a partir de {skill:165} 120.",
	-- ["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "Perito exige nível de personagem 20 e {skill:165} 125; eleva o limite para 225. Os materiais de 150-225 valem cerca de 61o no total.",
	-- ["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "Profissional exige nível de personagem 10 e {skill:165} 50; eleva o limite para 150. Os materiais de 75-150 valem cerca de 11o no total.",
	-- ["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "Laranja (um ponto a cada produção) até 155, amarelo até 165, verde até 175.",
	-- ["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "Laranja (um ponto a cada produção) até 205, amarelo até 215, verde até 225.",
	-- ["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "Laranja (um ponto a cada produção) até 255, amarelo até 265, verde até 275.",
	-- ["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "Laranja (um ponto a cada produção) até 285, amarelo até 295, verde até 305. {skill:165} 300 é um marco do Sistema de Legado.",
	-- ["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "Laranja (um ponto a cada produção) até 30, amarelo até 45, verde até 60.",
	-- ["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} aqui (feras de nível 5-20 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:1815}, {npc:1816}, {npc:1817} aqui (feras de nível 48-60 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Mordelisca aqui (feras de nível 28-40 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Mordelisca, {npc:2384}, {npc:2354} aqui (feras de nível 18-30 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} aqui (feras de nível 38-50 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} aqui (feras de nível 5-20 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aqui (feras de nível 18-30 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} aqui (feras de nível 28-40 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} aqui (feras de nível 38-50 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Esfole {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aqui (feras de nível 48-60 o fornecem); o guia de {skill:393} traça essa rota. A Casa de Leilões também serve.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Esfolados, desencantados ou produzidos por outra profissão: colete-os você mesmo ou compre-os na Casa de Leilões.",
	-- ["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks."] = "Ensina {item:15083} (exige {skill:165} 235). Vendedores têm estoque limitado que é reabastecido.",
	-- ["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks."] = "Ensina {item:15094} (exige {skill:165} 265). Vendedores têm estoque limitado que é reabastecido.",
	-- ["Teaches {item:252452} (needs {skill:165} 135)."] = "Ensina {item:252452} (exige {skill:165} 135).",
	-- ["Teaches {item:252463} (needs {skill:165} 185)."] = "Ensina {item:252463} (exige {skill:165} 185).",
	-- ["Yellow until 100, green until 115: not every craft gives a point."] = "Amarelo até 100, verde até 115: nem toda produção dá ponto.",
	-- ["Yellow until 115, green until 130: not every craft gives a point."] = "Amarelo até 115, verde até 130: nem toda produção dá ponto.",
	-- ["Yellow until 132, green until 145: not every craft gives a point."] = "Amarelo até 132, verde até 145: nem toda produção dá ponto.",
	-- ["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "Amarelo até 142, verde até 155: nem toda produção dá ponto. {skill:165} 150 é um marco do Sistema de Legado.",
	-- ["Yellow until 180, green until 190: not every craft gives a point."] = "Amarelo até 180, verde até 190: nem toda produção dá ponto.",
	-- ["Yellow until 185, green until 195: not every craft gives a point."] = "Amarelo até 185, verde até 195: nem toda produção dá ponto.",
	-- ["Yellow until 195, green until 205: not every craft gives a point."] = "Amarelo até 195, verde até 205: nem toda produção dá ponto.",
	-- ["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "Amarelo até 230, verde até 240: nem toda produção dá ponto. {skill:165} 225 é um marco do Sistema de Legado.",
	-- ["Yellow until 235, green until 245: not every craft gives a point."] = "Amarelo até 235, verde até 245: nem toda produção dá ponto.",
	-- ["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarelo até 70, verde até 85: nem toda produção dá ponto. 75 é o limite de Aprendiz.",
	-- ["Yellow until 85, green until 100: not every craft gives a point."] = "Amarelo até 85, verde até 100: nem toda produção dá ponto.",
	-- ["{item:15083} to 267"] = "{item:15083} até 267",
	-- ["{item:15564} to 236"] = "{item:15564} até 236",
	-- ["{item:2318} (Alliance)"] = "{item:2318} (Aliança)",
	-- ["{item:2318} (Horde)"] = "{item:2318} (Horda)",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Aliança)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- ["{item:252452} to 170"] = "{item:252452} até 170",
	-- ["{item:252463} to 220"] = "{item:252463} até 220",
	-- ["{item:4232} (Alliance)"] = "{item:4232} (Aliança)",
	-- ["{item:4232} (Horde)"] = "{item:4232} (Horda)",
	-- ["{item:4234} (Alliance)"] = "{item:4234} (Aliança)",
	-- ["{item:4234} (Horde)"] = "{item:4234} (Horda)",
	-- ["{item:4235} (Alliance)"] = "{item:4235} (Aliança)",
	-- ["{item:4235} (Horde)"] = "{item:4235} (Horda)",
	-- ["{item:5964} to 175"] = "{item:5964} até 175",
	-- ["{item:5966} to 195"] = "{item:5966} até 195",
	-- ["{item:7279} to 75"] = "{item:7279} até 75",
	-- ["{item:7282} to 120"] = "{item:7282} até 120",
	-- ["{item:7285} to 130"] = "{item:7285} até 130",
	-- ["{item:783} (Alliance)"] = "{item:783} (Aliança)",
	-- ["{item:783} (Horde)"] = "{item:783} (Horda)",
	-- ["{item:8150} (Alliance)"] = "{item:8150} (Aliança)",
	-- ["{item:8150} (Horde)"] = "{item:8150} (Horda)",
	-- ["{item:8169} (Alliance)"] = "{item:8169} (Aliança)",
	-- ["{item:8169} (Horde)"] = "{item:8169} (Horda)",
	-- ["{item:8218} to 225"] = "{item:8218} até 225",
	-- ["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "{npc:11746} (nível 56-58) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "{npc:6189} (nível 51-52) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "{npc:7027} (nível 56-57) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "{npc:92} (nível 39-40) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{skill:165} materials for 150-225"] = "Materiais de {skill:165} para 150-225",
	-- ["{skill:165} materials for 75-150"] = "Materiais de {skill:165} para 75-150",
	-- ["{skill:165} recipes at 105"] = "Receitas de {skill:165} em 105",
	-- ["{skill:165} recipes at 120"] = "Receitas de {skill:165} em 120",
	-- ["{skill:165} recipes at 130"] = "Receitas de {skill:165} em 130",
	-- ["{skill:165} recipes at 170"] = "Receitas de {skill:165} em 170",
	-- ["{skill:165} recipes at 175"] = "Receitas de {skill:165} em 175",
	-- ["{skill:165} recipes at 185"] = "Receitas de {skill:165} em 185",
	-- ["{skill:165} recipes at 195"] = "Receitas de {skill:165} em 195",
	-- ["{skill:165} recipes at 220"] = "Receitas de {skill:165} em 220",
	-- ["{skill:165} recipes at 55"] = "Receitas de {skill:165} em 55",
	-- ["{skill:165} recipes at 85"] = "Receitas de {skill:165} em 85",
	-- ["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165} acompanha a evolução do personagem. O Sistema de Legado do Forever recompensa profissões de produção nas perícias 150, 225 e 300 (os limites de Profissional, Perito e Artífice), então cada um desses marcos conta. Os materiais de 1-75 valem cerca de 1o 18p no total.",
	-- ["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}: {item:2457} (ou a Casa de Leilões)",
	-- ["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}: {item:3389} (ou a Casa de Leilões)",
	-- ["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}: {spell:3188} (ou a Casa de Leilões)",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: desencante equipamentos incomuns (verdes) (ou a Casa de Leilões)",
	-- ["{spell:2152} to 55"] = "{spell:2152} até 55",
	-- ["{spell:3756} to 85"] = "{spell:3756} até 85",
	-- ["{spell:3763} to 105"] = "{spell:3763} até 105",
	-- ["{spell:3768} to 150"] = "{spell:3768} até 150",
	-- ["{spell:3776} to 185"] = "{spell:3776} até 185",
}
