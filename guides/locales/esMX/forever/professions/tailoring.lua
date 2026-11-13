-- Spanish (Latin America) (esMX): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "Aprende {skill:197}",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 50c of recipes and 7s 20c of vendor goods, plus 144 {item:2589} to gather or buy."] = "Aprendiz de {skill:197} te deja fabricar hasta 75 por 10c, con cualquier nivel de personaje. Cualquier instructor de {skill:197} de tu facción lo enseña; la flecha elige el más cercano. Guarda cada {item:2589} que saquees: lo sueltan los humanoides de nivel 5-20. De 1 a 75 hacen falta unos 50c en recetas y 7s 20c en artículos de mercader, además de 144 {item:2589} que recolectar o comprar.",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "{skill:197} 1-75: artículos de mercader",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 72 {item:2320} (7s 20c); unos 7s 20c en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, Felika y {npc:5817}).",

	-- Step 3: Linen Cloth
	-- {item:2589} Linen Cloth · {spell:2387} Linen Cloak · {item:7026} Linen Belt
	["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "144 {item:2589} para {spell:2387} y {item:7026}: lo sueltan los humanoides de nivel 5-20. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",

	-- Step 4: Linen Cloak to 15
	-- {spell:2387} Linen Cloak
	["{spell:2387} to 15"] = "{spell:2387} hasta 15",
	-- {spell:2387} Linen Cloak · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{spell:2387} is orange at 1 (yellow 35, green 47, grey 60): about 7 crafts to 15, a point every craft. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 7 {spell:2963} first: it gives points too while not grey. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{spell:2387} es naranja a 1 (amarillo 35, verde 47, gris 60): unas 7 fabricaciones hasta 15, un punto por fabricación. Cada una lleva 1 {spell:2963} y 1 {item:2320}. Haz primero los 7 {spell:2963}: también da puntos mientras no sea gris. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos.",

	-- Step 5: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "Recetas de {skill:197} a 15",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "Vuelve con un instructor de {skill:197}: {spell:8776} (desde 15, 50c).",

	-- Step 6: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} hasta 75",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "{item:7026} es naranja a 15 (amarillo 50, verde 67, gris 85): unas 65 fabricaciones hasta 75. Cada una lleva 1 {spell:2963} y 1 {item:2320}. Haz primero los 65 {spell:2963}: también da puntos mientras no sea gris. Cada cinturón lleva un rollo; los cinturones se venden a los mercaderes.",

	-- Step 7: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} de oficial",
	-- {skill:197} Tailoring · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:5567} Sellandus · {zone:1453} Stormwind City · {npc:251991} Taleen Shimmerthread · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1458} Undercity · {npc:3004} Tepa · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), {npc:5567} ({zone:1453}) and {npc:251991} (Zephras Isle); Horde {npc:2627} ({zone:1434}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and {npc:3004} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "Oficial sube el límite de 75 a 150 por 5s; requiere {skill:197} 50 y nivel de personaje 10, así que puedes aprenderlo en cualquier visita a partir de 50. No todos los instructores de {skill:197} lo enseñan: Alianza: {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Isla Zephras), {npc:5567} ({zone:1453}) y {npc:251991} (Isla Zephras); Horda: {npc:2627} ({zone:1434}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Isla Zephras), {npc:11049} ({zone:1458}), {npc:251991} (Isla Zephras) y {npc:3004} ({zone:1456}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:2964} (desde 55, 1s) y {spell:2402} (desde 55, 2s 50c). Aprende también {spell:1229504} (1s): el objeto de campamento de {skill:197} de Forever, con un {spell:2963} y un {item:2320}; cada facción tiene el suyo. La misión “Campamento básico: {skill:197}” del guía de campamento de tu zona inicial (después de “Bendita naturaleza”) te envía a un instructor de sastrería que lo enseña gratis. De 75 a 150 hacen falta unos 11s en recetas y 1g 65s 50c en artículos de mercader, además de 567 {item:2592} y 204 {item:4306} que recolectar o comprar.",

	-- Step 8: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "{skill:197} 75-150: artículos de mercader",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) y 98 {item:2604} (49s); unos 1g 65s 50c en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, Felika y {npc:5817}).",

	-- Step 9: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "567 {item:2592} para {spell:2402} y {spell:3866}: lo sueltan los humanoides de nivel 15-30. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",

	-- Step 10: Silk Cloth
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "204 {item:4306} para {spell:3871}: lo sueltan los humanoides de nivel 25-45. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",

	-- Step 11: Woolen Cape to 104
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 104"] = "{spell:2402} hasta 104",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 42 crafts to 104. Each takes 1 {spell:2964} and 1 {item:2321}. Make the 42 {spell:2964} first: it gives points too while not grey. {spell:2964} is taught from 55 on Forever."] = "{spell:2402} es naranja a 75 (amarillo 80, verde 97, gris 115): unas 42 fabricaciones hasta 104. Cada una lleva 1 {spell:2964} y 1 {item:2321}. Haz primero los 42 {spell:2964}: también da puntos mientras no sea gris. En Forever, {spell:2964} se enseña desde 55.",

	-- Step 12: Tailoring recipes at 104
	-- {skill:197} Tailoring
	["{skill:197} recipes at 104"] = "Recetas de {skill:197} a 104",
	-- {skill:197} Tailoring · {spell:3866} Stylish Red Shirt
	["Back to a {skill:197} trainer: {spell:3866} (from 85, 2s 50c)."] = "Vuelve con un instructor de {skill:197}: {spell:3866} (desde 85, 2s 50c).",

	-- Step 13: Stylish Red Shirt to 135
	-- {spell:3866} Stylish Red Shirt
	["{spell:3866} to 135"] = "{spell:3866} hasta 135",
	-- {spell:3866} Stylish Red Shirt · {spell:2964} Bolt of Woolen Cloth · {item:2604} Red Dye · {item:2321} Fine Thread · {item:2592} Wool Cloth
	["{spell:3866} is orange at 104 (yellow 110, green 127, grey 145): about 49 crafts to 135. Each takes 3 {spell:2964}, 2 {item:2604} and 1 {item:2321}. Make the 147 {spell:2964} first. Three woolen bolts and two {item:2604} a shirt; {item:2592} drops from humanoids of level 15-30."] = "{spell:3866} es naranja a 104 (amarillo 110, verde 127, gris 145): unas 49 fabricaciones hasta 135. Cada una lleva 3 {spell:2964}, 2 {item:2604} y 1 {item:2321}. Haz primero los 147 {spell:2964}. Tres rollos de lana y dos {item:2604} por camisa; los humanoides de nivel 15-30 sueltan {item:2592}.",

	-- Step 14: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "Recetas de {skill:197} a 135",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s) and {spell:3871} (from 135)."] = "Vuelve con un instructor de {skill:197}: {spell:3839} (desde 100, 5s) y {spell:3871} (desde 135).",

	-- Step 15: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "{spell:3871} hasta 150",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {item:4306} Silk Cloth · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150. Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 51 {spell:3839} first. Silk bolts from here on: {item:4306} drops from humanoids of level 25-45. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "{spell:3871} es naranja a 135 (amarillo 145, verde 150, gris 155): unas 17 fabricaciones hasta 150. Cada una lleva 3 {spell:3839}, 2 {item:2324} y 1 {item:2321}. Haz primero los 51 {spell:3839}. Rollos de seda de aquí en adelante: los humanoides de nivel 25-45 sueltan {item:4306}. {item:2324}, de los mercaderes de sastrería y suministros de comercio. {skill:197} 150 es un hito del Sistema de Legado.",

	-- Step 16: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "{skill:197} 150-225: artículos de mercader",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) y 80 {item:8343} (16g); unos 21g 16s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, Felika y {npc:5817}).",

	-- Step 17: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "{item:7089} enseña {item:7053} ({skill:197} 140) por 15s. Lo venden: Alianza: {npc:6576} ({zone:1444}), existencias limitadas y {npc:251997} ({zone:1416}); Horda: {npc:6574} ({zone:1417}), existencias limitadas y {npc:251997} ({zone:1416}).",

	-- Step 18: Silk Cloth
	-- {item:4306} Silk Cloth · {item:7053} Azure Silk Cloak
	["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "264 {item:4306} para {item:7053}: lo sueltan los humanoides de nivel 25-45. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",

	-- Step 19: Mageweave Cloth
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "900 {item:4338} para {item:9998} y {item:10024}: lo sueltan los humanoides de nivel 35-50. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",

	-- Step 20: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "Experto de {skill:197}",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}); Horde {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Experto sube el límite de 150 a 225; requiere {skill:197} 125 y nivel de personaje 20, así que puedes aprenderlo en cualquier visita a partir de 125. Solo lo enseñan unos pocos instructores: Alianza: {npc:1346} ({zone:1453}); Horda: {npc:4576} ({zone:1458}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:3865} (desde 140). De 150 a 225 hacen falta unos 15s en recetas y 21g 16s en artículos de mercader, además de 264 {item:4306} y 900 {item:4338} que recolectar o comprar. Ven con todo en las bolsas (los pasos de arriba; el resto, de la casa de subastas): estos instructores también enseñan {item:9998} (desde 170) y {item:10024} (desde 190), y las fabricaciones no necesitan estación, así que fabrica aquí mismo y aprende cada receta al alcanzar su habilidad. Un viaje en lugar de 3.",

	-- Step 21: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "{item:7053} hasta 170",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "{item:7053} es naranja a 150 (amarillo 160, verde 175, gris 190): unas 22 fabricaciones hasta 170. Cada una lleva 3 {spell:3839}, 2 {item:6260} y 2 {item:2321}. Haz primero los 66 {spell:3839}. Su receta es la que compraste arriba; según los datos es la forma más barata de conseguir estos puntos.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 22: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "Recetas de {skill:197} a 170",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "Todavía con el instructor de Experto: {spell:12048} (desde 170).",

	-- Step 23: Black Mageweave Vest to 197
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 197"] = "{item:9998} hasta 197",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 30 crafts to 197. Each takes 2 {spell:3865} and 3 {item:4291}. Make the 60 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:9998} es naranja a 170 (amarillo 185, verde 200, gris 215): unas 30 fabricaciones hasta 197. Cada una lleva 2 {spell:3865} y 3 {item:4291}. Haz primero los 60 {spell:3865}. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos.",

	-- Step 24: Tailoring recipes at 197
	-- {skill:197} Tailoring
	["{skill:197} recipes at 197"] = "Recetas de {skill:197} a 197",
	-- {spell:12072} Black Mageweave Headband
	["Still at the Expert trainer: {spell:12072} (from 190)."] = "Todavía con el instructor de Experto: {spell:12072} (desde 190).",

	-- Step 25: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} hasta 225",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "{item:10024} es naranja a 197 (amarillo 205, verde 220, gris 235): unas 40 fabricaciones hasta 225. Cada una lleva 3 {spell:3865} y 2 {item:8343}. Haz primero los 120 {spell:3865}. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos. {skill:197} 225 es un hito del Sistema de Legado.",

	-- Step 26: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "Artesano de {skill:197}",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "Artesano sube el límite de 225 a 300; requiere {skill:197} 200 y nivel de personaje 35, así que puedes aprenderlo en cualquier visita a partir de 200. Solo lo enseñan unos pocos instructores: Alianza: {npc:11052} ({zone:1445}); Horda: {npc:2399} ({zone:1424}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:18401} (desde 205) y {spell:18402} (desde 210). De 225 a 300 hacen falta unos 1g 60s en recetas y 58g en artículos de mercader, además de 420 {item:8170}, 3195 {item:14047} y 124 {item:14227} que recolectar o comprar.",

	-- Step 27: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "{skill:197} 225-300: artículos de mercader",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, Felika and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 116 {item:14341} (58g); unos 58g en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1347}, {npc:1286} y {npc:5565}; {zone:1454}: {npc:3364}, Felika y {npc:5817}).",

	-- Step 28: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:14481} enseña {item:13863} ({skill:197} 230) por 1g 60s. Lo venden {npc:11189} ({zone:1452}), con existencias limitadas. Sus vendedores tienen una o dos en existencia, que se reponen un tiempo después de cada venta; se liga al recogerla, así que la casa de subastas nunca la tiene.",

	-- Step 29: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alianza)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:8598} Frenzied Plaguehound · {npc:8596} Plaguehound Runt
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} para {item:13863} y {item:13867}: {skill:393}: bestias de nivel 48-60; o la casa de subastas. Despelleja aquí a {npc:8598}, Can de peste y {npc:8596} (nivel 48-60); la guía de {skill:393} traza esta ruta.",

	-- Step 30: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} para {item:13863} y {item:13867}: {skill:393}: bestias de nivel 48-60; o la casa de subastas. Despelleja aquí a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} y {npc:6377} (nivel 48-60); la guía de {skill:393} traza esta ruta.",

	-- Step 31: Runecloth
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "3195 {item:14047} para {item:13856}, {item:13863} y {item:13867}: lo sueltan los humanoides de nivel 45-60. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",

	-- Step 32: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Alianza)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} para {item:13867}: lo suelta {npc:1824} (nivel 54-55) en el lugar marcado, o cómpralo en la casa de subastas.",

	-- Step 33: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horda)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:11739} Rock Stalker
	["124 {item:14227} for {item:13867}: it drops from {npc:11739} (level 57-59) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} para {item:13867}: lo suelta {npc:11739} (nivel 57-59) en el lugar marcado, o cómpralo en la casa de subastas.",

	-- Step 34: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "{item:13856} hasta 234",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234. Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "{item:13856} es amarillo a 225 (amarillo 225, verde 240, gris 255): unas 11 fabricaciones hasta 234. Cada una lleva 3 {item:14048} y 1 {item:14341}. Haz primero los 33 {item:14048}. {item:14341}, de los mercaderes de sastrería.",

	-- Step 35: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "{item:13863} hasta 265",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265. Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "{item:13863} es naranja a 234 (amarillo 245, verde 260, gris 275): unas 43 fabricaciones hasta 265. Cada una lleva 4 {item:14048}, 4 {item:8170} y 1 {item:14341}. Haz primero los 172 {item:14048}. {npc:11189} en {area:2255} tiene un patrón a la vez; el túnel de {area:1769} desde {zone:1448} es el camino de entrada, así que nunca mates fúrbolgs Fauces de Madera por el camino.",

	-- Step 36: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "{item:13867} hasta 300",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {item:13863} Runecloth Gloves · {item:13864} Runecloth Boots · {npc:7940} Darnall · {zone:1450} Moonglade · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:254123} Runecloth Cuffs · {zone:2482} Mount Hyjal · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300. Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. No pattern on the Auction House? {item:13863} still give a point now and then to 275, and {item:13864} ({npc:7940}, {zone:1450}) to 280, at 4 bolts a craft. {item:14342} (pattern from {npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}; the wheel's blueprint drops from the {npc:246017} in the City of Dalaran) and {item:254123} (Pexmit in {zone:2482}, 10g; we could not confirm that vendor yet) are the other ways on. {skill:197} 300 is a Legacy System milestone."] = "{item:13867} es naranja a 265 (amarillo 275, verde 290, gris 305): unas 62 fabricaciones hasta 300. Cada una lleva 7 {item:14048}, 2 {item:14227}, 4 {item:8170} y 1 {item:14341}. Haz primero los 434 {item:14048}. Su patrón ({item:14504}) lo sueltan enemigos de todo el mundo y no se liga: cómpralo en la casa de subastas. Siete rollos, dos {item:14227} y cuatro {item:8170} por fabricación: el tramo más caro. Las arañas de {zone:1422} y {zone:1451} sueltan la seda (los lugares marcados), o la casa de subastas. ¿No hay patrón en la casa de subastas? {item:13863} todavía da un punto de vez en cuando hasta 275, y {item:13864} ({npc:7940}, {zone:1450}) hasta 280, a 4 rollos por fabricación. {item:14342} (patrón de {npc:11189} o {npc:11188} en {area:2255}; 2 {item:14256} en un Pozo de la Luna) sigue naranja hasta 270 y amarillo hasta 285, pero se puede hacer una vez cada cuatro días. Los patrones de {item:279943} (sandalias y cordones del Favor del mercader de {npc:248202} o {npc:256735}; el plano de la rueda lo suelta {npc:246017} en la Ciudad de Dalaran) y {item:254123} (Pexmit en {zone:2482}, 10g; todavía no pudimos confirmar ese vendedor) son las otras formas de seguir. {skill:197} 300 es un hito del Sistema de Legado.",
	["from the pattern bought at the Auction House"] = "del patrón comprado en la casa de subastas",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:197}"] = "Aprendiz de {skill:197}",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Artesano requiere nivel de personaje 35 y {skill:197} 200; sube el límite a 300. Los materiales para 225-300 valen unos 845g en total.",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Vuelve con un instructor de {skill:197}: {spell:12048} se enseña a partir de {skill:197} 185.",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Vuelve con un instructor de {skill:197}: {spell:12072} se enseña a partir de {skill:197} 205.",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Vuelve con un instructor de {skill:197}: {spell:2402} se enseña a partir de {skill:197} 80.",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Vuelve con un instructor de {skill:197}: {spell:3848} se enseña a partir de {skill:197} 110.",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Vuelve con un instructor de {skill:197}: {spell:3852} se enseña a partir de {skill:197} 125.",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Vuelve con un instructor de {skill:197}: {spell:8776} se enseña a partir de {skill:197} 50.",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Vuelve con un instructor de {skill:197}: {spell:8799} se enseña a partir de {skill:197} 180.",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Experto requiere nivel de personaje 20 y {skill:197} 125; sube el límite a 225. Los materiales para 150-225 valen unos 135g en total.",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Oficial requiere nivel de personaje 10 y {skill:197} 50; sube el límite a 150. Los materiales para 75-150 valen unos 17g en total.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el lugar de farmeo que Polestar elige para tu nivel y facción. También sirve la casa de subastas.",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "En Forever ninguna receta que enseñe un instructor o vendan los mercaderes de ambas facciones da puntos de {skill:197} pasado 295, así que Polestar no tiene ruta para los últimos puntos. Recetas que sí dan: {item:14342} (requiere una Poza de la Luna), {item:14137} (requiere una {item:279943}), {item:14155} (la receta es botín), {item:14128} (la receta es botín), {item:19047} (requiere una {item:279943}).",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Naranja (un punto por creación) hasta 160, amarillo hasta 175, verde hasta 190.",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Naranja (un punto por creación) hasta 245, amarillo hasta 260, verde hasta 275.",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Naranja (un punto por creación) hasta 265, amarillo hasta 280, verde hasta 295.",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Naranja (un punto por creación) hasta 40, amarillo hasta 50, verde hasta 60.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:1815}, {npc:1816}, {npc:1817} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú mismo o cómpralos en la casa de subastas.",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "Enseña {item:13863} (requiere {skill:197} 230). Los mercaderes lo venden en existencias limitadas que se reponen.",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "Enseña {item:254123} (requiere {skill:197} 250).",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "Enseña {item:7053} (requiere {skill:197} 140). Los mercaderes lo venden en existencias limitadas que se reponen.",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "Amarillo hasta 127, verde hasta 145: no todas las creaciones dan un punto.",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Amarillo hasta 140, verde hasta 155: no todas las creaciones dan un punto. {skill:197} 150 es un hito del Sistema de Legado.",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "Amarillo hasta 190, verde hasta 200: no todas las creaciones dan un punto.",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "Amarillo hasta 200, verde hasta 215: no todas las creaciones dan un punto.",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Amarillo hasta 220, verde hasta 235: no todas las creaciones dan un punto. {skill:197} 225 es un hito del Sistema de Legado.",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "Amarillo hasta 240, verde hasta 255: no todas las creaciones dan un punto.",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "Amarillo hasta 67, verde hasta 85: no todas las creaciones dan un punto.",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarillo hasta 67, verde hasta 85: no todas las creaciones dan un punto. 75 es el límite de Aprendiz.",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "Amarillo hasta 97, verde hasta 115: no todas las creaciones dan un punto.",
	-- ["{item:10045} to 50"] = "{item:10045} hasta 50",
	-- ["{item:13856} to 236"] = "{item:13856} hasta 236",
	-- ["{item:13863} to 251"] = "{item:13863} hasta 251",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (Alianza)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- ["{item:254123} to 295"] = "{item:254123} hasta 295",
	-- ["{item:2592} (Alliance)"] = "{item:2592} (Alianza)",
	-- ["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- ["{item:4338} (Alliance)"] = "{item:4338} (Alianza)",
	-- ["{item:4338} (Horde)"] = "{item:4338} (Horda)",
	-- ["{item:7026} to 80"] = "{item:7026} hasta 80",
	-- ["{item:7053} to 180"] = "{item:7053} hasta 180",
	-- ["{item:7062} to 185"] = "{item:7062} hasta 185",
	-- ["{item:9998} to 205"] = "{item:9998} hasta 205",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "{npc:11739} (nivel 57-59) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "{npc:1824} (nivel 54-55) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "{npc:3263} (nivel 19-20) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "{npc:5472} (nivel 46-47) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "{npc:6006} (nivel 52-53) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "{npc:6189} (nivel 51-52) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "{npc:7027} (nivel 56-57) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "{npc:98} (nivel 17-18) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (o la casa de subastas)",
	-- ["{skill:197} materials for 75-150"] = "Materiales de {skill:197} para 75-150",
	-- ["{skill:197} recipes at 110"] = "Recetas de {skill:197} a 110",
	-- ["{skill:197} recipes at 125"] = "Recetas de {skill:197} a 125",
	-- ["{skill:197} recipes at 180"] = "Recetas de {skill:197} a 180",
	-- ["{skill:197} recipes at 185"] = "Recetas de {skill:197} a 185",
	-- ["{skill:197} recipes at 205"] = "Recetas de {skill:197} a 205",
	-- ["{skill:197} recipes at 50"] = "Recetas de {skill:197} a 50",
	-- ["{skill:197} recipes at 80"] = "Recetas de {skill:197} a 80",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} avanza junto con la subida de nivel. El Sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los límites de Oficial, Experto y Artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 1g 8s en total.",
	-- ["{spell:2402} to 110"] = "{spell:2402} hasta 110",
	-- ["{spell:3848} to 125"] = "{spell:3848} hasta 125",
	-- ["{spell:3852} to 150"] = "{spell:3852} hasta 150",
}
