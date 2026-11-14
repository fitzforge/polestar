-- Spanish (Latin America) (esMX): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Engineering
	-- {skill:202} Engineering
	["Learn {skill:202}"] = "Aprende {skill:202}",
	-- {skill:202} Engineering · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2840} Copper Bar
	["Apprentice {skill:202} lets you craft up to 75 for 10c, at any character level. Any {skill:202} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} and pair it with {skill:186}: {item:2835} and {item:2770} are the first parts. 1-75 takes about 4s 15c of recipes and 18s 18c of vendor goods, plus 46 {item:2835} and 75 {item:2840} to gather or buy."] = "Aprendiz de {skill:202} te deja fabricar hasta 75 por 10c, con cualquier nivel de personaje. Cualquier instructor de {skill:202} de tu facción lo enseña; la flecha elige el más cercano. Compra un {item:5956} y combínala con {skill:186}: {item:2835} y {item:2770} son las primeras piezas. De 1 a 75 hacen falta unos 4s 15c en recetas y 18s 18c en artículos de mercader, además de 46 {item:2835} y 75 {item:2840} que recolectar o comprar.",

	-- Step 2: Engineering 1-75: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 1-75: vendor goods"] = "{skill:202} 1-75: artículos de mercader",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 18 {item:2880} (18s) y {item:5956} (una herramienta: uno, guárdalo en tus bolsas, 18c); unos 18s 18c en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:5519}, {npc:5514} y {npc:1286}; {zone:1454}: {npc:3367}, Gorina y {npc:5817}).",
	["a tool, keep it in your bags"] = "una herramienta, guárdala en tus bolsas",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "",

	-- Step 3: Engineering 1-75: Auction House
	-- {skill:202} Engineering
	["{skill:202} 1-75: Auction House"] = "",
	-- {item:2835} Rough Stone · {item:2840} Copper Bar
	["What 1-75 takes that the Auction House sells: 46 {item:2835} and 75 {item:2840}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 4: Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1429} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:1429}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1429} is marked."] = "",

	-- Step 5: Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1426} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:1426}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1426} is marked."] = "",

	-- Step 6: Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1439} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:1439}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1439} is marked."] = "",

	-- Step 7: Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:2521} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:2521}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:2521} is marked."] = "",

	-- Step 8: Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1411} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:1411}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1411} is marked."] = "",

	-- Step 9: Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1412} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:1412}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1412} is marked."] = "",

	-- Step 10: Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1420} is marked."] = "46 {item:2835} para {spell:3918}: {skill:186}: {object:1731} (habilidad 1); o la casa de subastas. Está marcado el grupo más denso de {object:1731} en {zone:1420}.",
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1). The densest cluster of {object:1731} in {zone:1420} is marked."] = "",

	-- Step 11: Copper Bar
	-- {item:2840} Copper Bar · {spell:3922} Handful of Copper Bolts · {item:6219} Arclight Spanner · {spell:3924} Copper Tube · {skill:186} Mining · {item:2770} Copper Ore
	["75 {item:2840} for {spell:3922}, {item:6219} and {spell:3924}: {skill:186}: smelt {item:2770}."] = "",

	-- Step 12: Rough Blasting Powder to 35
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 35"] = "{spell:3918} hasta 35",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 46 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "{spell:3918} es naranja a 1 (amarillo 20, verde 30, gris 40): unas 46 fabricaciones hasta 35. Cada una lleva 1 {item:2835}. Una {item:2835} por fabricación; {item:2835} sale con el {item:2770} de las vetas de cobre.",

	-- Step 13: Engineering recipes at 35
	-- {skill:202} Engineering
	["{skill:202} recipes at 35"] = "Recetas de {skill:202} a 35",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free."] = "Vuelve con un instructor de {skill:202}: {spell:3922} (desde 30, 1s 15c). Aprende también {spell:1230656} (1s): el objeto de campamento de {skill:202} de Forever, que se coloca en un campamento junto a una hoguera. Lleva un {spell:3922} y un {spell:3924}, que aprendes a 30 y 50, así que no da puntos. La misión “Campamento básico: {skill:202}” del guía de campamento de tu zona inicial (después de “Bendita naturaleza”) te envía a un instructor de ingeniería que lo enseña gratis.",

	-- Step 14: Handful of Copper Bolts to 57
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 57"] = "{spell:3922} hasta 57",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2770} Copper Ore
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags. {item:2840} (75 for 1-75): {skill:186}: smelt {item:2770}; or the Auction House."] = "{spell:3922} es naranja a 35 (amarillo 45, verde 52, gris 60): unas 33 fabricaciones hasta 57. Cada una lleva 1 {item:2840}. Una {item:2840} por fabricación. Guarda los pernos: las cerraduras de práctica y los artilugios posteriores los usan. Requiere un yunque cerca. {item:5956} es una herramienta: guárdalo en tus bolsas. {item:2840} (75 para 1-75): {skill:186}: funde {item:2770}; o la casa de subastas.",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags."] = "",

	-- Step 15: Engineering recipes at 57
	-- {skill:202} Engineering
	["{skill:202} recipes at 57"] = "Recetas de {skill:202} a 57",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "Vuelve con un instructor de {skill:202}: {spell:7430} (desde 50, 1s 50c) y {spell:3924} (desde 50, 1s 50c).",

	-- Step 16: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "{spell:3924} hasta 75",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 57 (yellow 80, green 95, grey 110): about 18 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "{spell:3924} es naranja a 57 (amarillo 80, verde 95, gris 110): unas 18 fabricaciones hasta 75, un punto por fabricación. Cada una lleva 2 {item:2840} y 1 {item:2880}. Dos barras de cobre y un {item:2880} por fabricación (proveedores de herrería e ingeniería). Requiere un yunque cerca. Haz ahora {item:6219}, mientras todavía da un punto: una receta posterior lo necesita en tus bolsas, así que guárdalo ahí.",
	["a tool: keep it in your bags"] = "una herramienta: guárdala en tus bolsas",

	-- Step 17: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202} de oficial",
	-- {skill:202} Engineering · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:11029} Trixie Quikswitch · {zone:1455} Ironforge · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {spell:3929} Coarse Blasting Powder · {spell:3930} Crafted Heavy Shot · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}) and {npc:11029} ({zone:1455}); Horde {npc:11031} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "",

	-- Step 18: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "{skill:202} 75-150: artículos de mercader",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 45 {item:2880} (45s); unos 45s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:5519}, {npc:5514} y {npc:1286}; {zone:1454}: {npc:3367}, Gorina y {npc:5817}).",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286})."] = "",

	-- Step 19: Engineering 75-150: Auction House
	-- {skill:202} Engineering
	["{skill:202} 75-150: Auction House"] = "",
	-- {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["What 75-150 takes that the Auction House sells: 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 20: Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1436} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (habilidad 65); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1436}.",
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1436} is marked."] = "",

	-- Step 21: Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (habilidad 65); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1432}.",
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 22: Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1439} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (habilidad 65); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1439}.",
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1439} is marked."] = "",

	-- Step 23: Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1413} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (habilidad 65); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1413}.",
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1413} is marked."] = "",

	-- Step 24: Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1421} is marked."] = "15 {item:2836} para {spell:3930}: {skill:186}: {object:1732} (habilidad 65); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1421}.",
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65). The densest cluster of {object:1732} in {zone:1421} is marked."] = "",

	-- Step 25: Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "27 {item:2838} para {spell:3945}: {skill:186}: {object:1735} (habilidad 125); o la casa de subastas. Está marcado el grupo más denso de {object:1735} en {zone:1417}.",
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 26: Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1440} is marked."] = "27 {item:2838} para {spell:3945}: {skill:186}: {object:1735} (habilidad 125); o la casa de subastas. Está marcado el grupo más denso de {object:1735} en {zone:1440}.",
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1440} is marked."] = "",

	-- Step 27: Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1413} is marked."] = "27 {item:2838} para {spell:3945}: {skill:186}: {object:1735} (habilidad 125); o la casa de subastas. Está marcado el grupo más denso de {object:1735} en {zone:1413}.",
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125). The densest cluster of {object:1735} in {zone:1413} is marked."] = "",

	-- Step 29: Copper Bar
	-- {item:2840} Copper Bar · {spell:3930} Crafted Heavy Shot · {spell:3924} Copper Tube · {item:6712} Practice Lock · {skill:186} Mining · {item:2770} Copper Ore
	["72 {item:2840} for {spell:3930}, {spell:3924} and {item:6712}: {skill:186}: smelt {item:2770}."] = "",

	-- Step 30: Bronze Bar
	-- {item:2841} Bronze Bar · {item:6712} Practice Lock · {spell:3950} Big Bronze Bomb · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["61 {item:2841} for {item:6712} and {spell:3950}: {skill:186}: smelt {item:2840} and {item:3576}."] = "",

	-- Step 31: Silver Bar
	-- {item:2842} Silver Bar · {spell:3950} Big Bronze Bomb · {skill:186} Mining · {item:2775} Silver Ore
	["2 {item:2842} for {spell:3950}: {skill:186}: smelt {item:2775}."] = "",

	-- Step 32: Crafted Heavy Shot to 94
	-- {spell:3930} Crafted Heavy Shot
	["{spell:3930} to 94"] = "{spell:3930} hasta 94",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar · {skill:186} Mining · {item:2770} Copper Ore
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor. {item:2840} (72 for 75-150): {skill:186}: smelt {item:2770}; or the Auction House."] = "{spell:3930} es naranja a 75 (amarillo 85, verde 90, gris 95): unas 15 fabricaciones hasta 94. Cada una lleva 1 {spell:3929} y 1 {item:2840} y da 200. Haz primero los 15 {spell:3929}: también da puntos mientras no sea gris. El {spell:3929} de cada uno da su propio punto mientras no sea gris: dos oportunidades por fabricación. Vende la munición a los cazadores o a un mercader. {item:2840} (72 para 75-150): {skill:186}: funde {item:2770}; o la casa de subastas.",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor."] = "",

	-- Step 33: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "{spell:3924} hasta 100",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby."] = "{spell:3924} es amarillo a 94 (amarillo 80, verde 95, gris 110): unas 14 fabricaciones hasta 100. Cada una lleva 2 {item:2840} y 1 {item:2880}. Dos barras de cobre y un {item:2880} por fabricación (proveedores de herrería e ingeniería). Requiere un yunque cerca.",

	-- Step 34: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "Recetas de {skill:202} a 100",
	-- {skill:202} Engineering · {spell:8334} Practice Lock
	["Back to an {skill:202} trainer: {spell:8334} (from 100)."] = "Vuelve con un instructor de {skill:202}: {spell:8334} (desde 100).",

	-- Step 35: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "{item:6712} hasta 125",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby. {item:2841} (61 for 75-150): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "{item:6712} es naranja a 100 (amarillo 115, verde 122, gris 130): unas 31 fabricaciones hasta 125. Cada una lleva 1 {item:2841}, 2 {spell:3922} y 1 {item:2880}. Haz primero los 29 {spell:3922}. Usa los 33 {spell:3922} que hiciste antes; las cantidades de arriba no los incluyen. Las cerraduras de práctica se venden a los pícaros, o ábrelas tú mismo. Requiere un yunque cerca. {item:2841} (61 para 75-150): {skill:186}: funde {item:2840} y {item:3576}; o la casa de subastas.",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby."] = "",

	-- Step 36: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "Recetas de {skill:202} a 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "Vuelve con un instructor de {skill:202}: {spell:3945} (desde 125).",

	-- Step 37: Heavy Blasting Powder to 140
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 140"] = "{spell:3945} hasta 140",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 27 crafts to 140. Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "{spell:3945} es amarillo a 125 (amarillo 125, verde 135, gris 145): unas 27 fabricaciones hasta 140. Cada una lleva 1 {item:2838}. Una {item:2838} por fabricación (depósitos de hierro). Guarda algunos: las granadas de hierro llevan uno cada una.",

	-- Step 38: Engineering recipes at 140
	-- {skill:202} Engineering
	["{skill:202} recipes at 140"] = "Recetas de {skill:202} a 140",
	-- {skill:202} Engineering · {spell:3973} Silver Contact · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3973} (from 90) and {spell:3950} (from 140)."] = "Vuelve con un instructor de {skill:202}: {spell:3973} (desde 90) y {spell:3950} (desde 140).",

	-- Step 39: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "{spell:3950} hasta 150",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {item:2842} Silver Bar · {skill:186} Mining · {item:2775} Silver Ore · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {item:2842} (2 for 75-150): {skill:186}: smelt {item:2775}; or the Auction House. {skill:202} 150 is a Legacy System milestone."] = "{spell:3950} es amarillo a 140 (amarillo 140, verde 165, gris 190): unas 10 fabricaciones hasta 150. Cada una lleva 2 {item:4377}, 3 {item:2841} y 1 {spell:3973} y da 3. Haz primero los 10 {spell:3973} (2 fabricaciones). Usa los 20 {item:4377} que hiciste antes; las cantidades de arriba no los incluyen. Lo enseña el instructor, y según los datos es la forma más barata de conseguir estos puntos. Requiere un yunque cerca. {item:2842} (2 para 75-150): {skill:186}: funde {item:2775}; o la casa de subastas. {skill:202} 150 es un hito del Sistema de Legado.",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "",

	-- Step 40: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "Experto de {skill:202}",
	-- {skill:202} Engineering · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11017} Roxxik · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:5174} ({zone:1455}); Horde {npc:11017} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "Experto sube el límite de 150 a 225 por 50s (precio de Classic; el de Forever no está en los datos); requiere {skill:202} 125 y nivel de personaje 20, así que puedes aprenderlo en cualquier visita a partir de 125. Solo lo enseñan unos pocos instructores: Alianza: {npc:5174} ({zone:1455}); Horda: {npc:11017} ({zone:1454}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:9271} (desde 150) y {spell:3953} (desde 145). De 150 a 225 hacen falta unos 31s en artículos de mercader, además de 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} y 62 {item:7912} que recolectar o comprar.",

	-- Step 41: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "{skill:202} 150-225: artículos de mercader",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3333} Shankys · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286}; {zone:1454}: {npc:3367}, {npc:3333} and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 31 {item:6530} (31s); unos 31s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:5494} y {npc:1286}; {zone:1454}: {npc:3367}, {npc:3333} y {npc:5817}).",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286})."] = "",

	-- Step 42: Engineering 150-225: Auction House
	-- {skill:202} Engineering
	["{skill:202} 150-225: Auction House"] = "",
	-- {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["What 150-225 takes that the Auction House sells: 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 43: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Alianza)",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "19 {item:2319} para {spell:3953}: {skill:393}: bestias de nivel 18-30; o la casa de subastas. Despelleja aquí a {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384} y {npc:2354} (nivel 18-30); la guía de {skill:393} traza esta ruta.",
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 44: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "19 {item:2319} para {spell:3953}: {skill:393}: bestias de nivel 18-30; o la casa de subastas. Despelleja aquí a {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} y {npc:3817} (nivel 18-30); la guía de {skill:393} traza esta ruta.",
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "",

	-- Step 45: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:3953} Bronze Framework
	["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 46: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Alianza)",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "31 {item:2836} para {item:6533}: {skill:186}: {object:1732} (habilidad 65) en {zone:1432} (10-20), {zone:1440} (18-30) y {zone:1424} (20-30); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1432}.",
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1432} is marked."] = "",

	-- Step 47: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horda)",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1440} is marked."] = "31 {item:2836} para {item:6533}: {skill:186}: {object:1732} (habilidad 65) en {zone:1413} (10-25), {zone:1440} (18-30) y {zone:1424} (20-30); o la casa de subastas. Está marcado el grupo más denso de {object:1732} en {zone:1440}.",
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30). The densest cluster of {object:1732} in {zone:1440} is marked."] = "",

	-- Step 48: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Alianza)",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "74 {item:2838} para {spell:3967}: {skill:186}: {object:1735} (habilidad 125) en {zone:1417} (30-40), {zone:1434} (30-45) y {zone:1443} (30-40); o la casa de subastas. Está marcado el grupo más denso de {object:1735} en {zone:1417}.",
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40). The densest cluster of {object:1735} in {zone:1417} is marked."] = "",

	-- Step 49: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horda)",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest cluster of {object:1735} in {zone:1441} is marked."] = "74 {item:2838} para {spell:3967}: {skill:186}: {object:1735} (habilidad 125) en {zone:1441} (25-35), {zone:1417} (30-40) y {zone:1434} (30-45); o la casa de subastas. Está marcado el grupo más denso de {object:1735} en {zone:1441}.",
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45). The densest cluster of {object:1735} in {zone:1441} is marked."] = "",

	-- Step 50: Bronze Bar
	-- {item:2841} Bronze Bar · {item:6533} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["100 {item:2841} for {item:6533} and {spell:3953}: {skill:186}: smelt {item:2840} and {item:3576}."] = "",

	-- Step 51: Silver Bar
	-- {item:2842} Silver Bar · {spell:3967} Big Iron Bomb · {skill:186} Mining · {item:2775} Silver Ore
	["6 {item:2842} for {spell:3967}: {skill:186}: smelt {item:2775}."] = "",

	-- Step 52: Iron Bar
	-- {item:3575} Iron Bar · {spell:3967} Big Iron Bomb · {skill:186} Mining · {item:2772} Iron Ore
	["81 {item:3575} for {spell:3967}: {skill:186}: smelt {item:2772}."] = "",

	-- Step 53: Mithril Bar
	-- {item:3860} Mithril Bar · {item:10512} Hi-Impact Mithril Slugs · {skill:186} Mining · {item:3858} Mithril Ore
	["19 {item:3860} for {item:10512}: {skill:186}: smelt {item:3858}."] = "",

	-- Step 54: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Alianza)",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1434} is marked."] = "62 {item:7912} para {item:10505}: {skill:186}: {object:2040} (habilidad 175) en {zone:1434} (30-45), {zone:1425} (40-50) y {zone:1444} (40-50); o la casa de subastas. Está marcado el grupo más denso de {object:2040} en {zone:1434}.",
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1434} is marked."] = "",

	-- Step 55: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horda)",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "62 {item:7912} para {item:10505}: {skill:186}: {object:2040} (habilidad 175) en {zone:1443} (30-40), {zone:1425} (40-50) y {zone:1444} (40-50); o la casa de subastas. Está marcado el grupo más denso de {object:2040} en {zone:1443}.",
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 56: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "{item:6533} hasta 166",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen. {item:2841} (100 for 150-225): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "{item:6533} es amarillo a 150 (amarillo 150, verde 160, gris 170): unas 31 fabricaciones hasta 166. Cada una lleva 2 {item:2841}, 1 {item:6530} y 1 {spell:3929} y da 3. Haz primero los 31 {spell:3929}. {item:6530} se compra a los proveedores de comercio y de pesca; los atrayentes se venden a los pescadores. {item:2841} (100 para 150-225): {skill:186}: funde {item:2840} y {item:3576}; o la casa de subastas.",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen."] = "",

	-- Step 57: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} hasta 175",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175. Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "{spell:3953} es amarillo a 166 (amarillo 145, verde 170, gris 195): unas 19 fabricaciones hasta 175. Cada una lleva 2 {item:2841}, 1 {item:2319} y 1 {item:2592}. Los armazones de bronce son piezas para artilugios posteriores; los que sobren se venden a los mercaderes.",

	-- Step 58: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "Recetas de {skill:202} a 175",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder
	["Back to an {skill:202} trainer: {spell:12585} (from 175)."] = "Vuelve con un instructor de {skill:202}: {spell:12585} (desde 175).",

	-- Step 59: Solid Blasting Powder to 191
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 191"] = "{item:10505} hasta 191",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 31 crafts to 191. Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "{item:10505} es amarillo a 175 (amarillo 175, verde 185, gris 195): unas 31 fabricaciones hasta 191. Cada una lleva 2 {item:7912}. Dos {item:7912} por fabricación (depósitos de mitril). Haz muchos: los gatillos, las balas y el Giroproyectil lo usan.",

	-- Step 60: Engineering recipes at 191
	-- {skill:202} Engineering
	["{skill:202} recipes at 191"] = "Recetas de {skill:202} a 191",
	-- {skill:202} Engineering · {spell:3967} Big Iron Bomb
	["Back to an {skill:202} trainer: {spell:3967} (from 190)."] = "Vuelve con un instructor de {skill:202}: {spell:3967} (desde 190).",

	-- Step 61: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "{spell:3967} hasta 210",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep · {skill:186} Mining · {item:2775} Silver Ore · {item:2772} Iron Ore
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. {item:2842} (6 for 150-225): {skill:186}: smelt {item:2775}; or the Auction House. {item:3575} (81 for 150-225): {skill:186}: smelt {item:2772}; or the Auction House."] = "{spell:3967} es amarillo a 191 (amarillo 190, verde 210, gris 230): unas 27 fabricaciones hasta 210. Cada una lleva 3 {item:3575}, 3 {spell:3945} y 1 {spell:3973} y da 2. Haz primero los 74 {spell:3945} y los 30 {spell:3973} (6 fabricaciones). Usa los 7 {spell:3945} que hiciste antes; las cantidades de arriba no los incluyen. Una {item:2842} da cinco contactos de plata (ya grises: no dan puntos, pero tampoco hace falta ir a un mercader); el {spell:3945} sale de {item:2838}. Cada fabricación da dos bombas. Especialización (opcional): a 200 y nivel de personaje 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) o Tinkerwiz ({area:392}) te envía a {spell:20220} ({npc:7944}, {zone:1455}, o {npc:7406}, {area:35}: 6 tubos de mitril, un {item:4407} y 2 muñecos de tiro avanzados) o a Ingeniería goblin ({npc:8126}, {area:976}: 20 bombas de hierro grandes, 20 {item:10507} y 5 {npc:2675}). El esquema de {item:4407} ahora se liga al recogerlo, pero la misión acepta una mira que haya hecho otro. La tarjeta de socio dura 14 días de juego; renovarla cuesta 2g. Solo puedes elegir una; ninguna hace falta para llegar a 300, y la beta nunca las probó (se detuvo en el nivel 30). Requiere un yunque cerca. {item:2842} (6 para 150-225): {skill:186}: funde {item:2775}; o la casa de subastas. {item:3575} (81 para 150-225): {skill:186}: funde {item:2772}; o la casa de subastas.",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby."] = "",

	-- Step 62: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "Recetas de {skill:202} a 210",
	-- {skill:202} Engineering · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12596} (from 210)."] = "Vuelve con un instructor de {skill:202}: {spell:12596} (desde 210).",

	-- Step 63: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} hasta 225",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (19 for 150-225): {skill:186}: smelt {item:3858}; or the Auction House. {skill:202} 225 is a Legacy System milestone."] = "{item:10512} es amarillo a 210 (amarillo 210, verde 230, gris 250): unas 19 fabricaciones hasta 225. Cada una lleva 1 {item:3860} y 1 {item:10505} y da 200. Usa los 19 {item:10505} que hiciste antes; las cantidades de arriba no los incluyen. Una {item:3860} y un {item:10505} por fabricación; los cazadores compran las balas. Requiere un yunque cerca. {item:3860} (19 para 150-225): {skill:186}: funde {item:3858}; o la casa de subastas. {skill:202} 225 es un hito del Sistema de Legado.",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "",

	-- Step 64: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "Artesano de {skill:202}",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). The arrow picks the nearest of your faction. 225-300 takes about 2g 80s of recipes, plus 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047} to gather or buy."] = "Artesano sube el límite de 225 a 300 por 4g 50s (precio de Classic; el de Forever no está en los datos); requiere {skill:202} 200 y nivel de personaje 35, así que puedes aprenderlo en cualquier visita a partir de 200. Solo lo enseñan unos pocos instructores: Alianza: {npc:8736} ({zone:1446}); Horda: {npc:8736} ({zone:1446}). La flecha elige el más cercano de tu facción. De 225 a 300 hacen falta unos 2g 80s en recetas, además de 118 {item:3860}, 212 {item:7912}, 156 {item:12359} y 24 {item:14047} que recolectar o comprar.",

	-- Step 65: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:16042} enseña {item:15994} ({skill:202} 260) por 1g 20s. Lo venden: Alianza: {npc:5175} ({zone:1455}), existencias limitadas; Horda: {npc:3413} ({zone:1454}), existencias limitadas. Sus vendedores tienen una o dos en existencia, que se reponen un tiempo después de cada venta; la casa de subastas también suele tenerla.",

	-- Step 66: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock."] = "{item:16047} enseña {item:16000} ({skill:202} 275) por 1g 60s. Lo venden {npc:260565} ({zone:2548}) y {npc:11185} ({zone:1452}), con existencias limitadas.",

	-- Step 67: Engineering 225-300: Auction House
	-- {skill:202} Engineering
	["{skill:202} 225-300: Auction House"] = "",
	-- {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["What 225-300 takes that the Auction House sells: 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 68: Mithril Bar
	-- {item:3860} Mithril Bar · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {item:3858} Mithril Ore
	["118 {item:3860} for {item:10512} and {item:10513}: {skill:186}: smelt {item:3858}."] = "",

	-- Step 69: Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest cluster of {object:2040} in {zone:1425} is marked."] = "212 {item:7912} para {item:10512} y {item:10513}: {skill:186}: {object:2040} (habilidad 175) en {zone:1425} (40-50), {zone:1444} (40-50) y {zone:1447} (45-55); o la casa de subastas. Está marcado el grupo más denso de {object:2040} en {zone:1425}.",
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest cluster of {object:2040} in {zone:1425} is marked."] = "",

	-- Step 70: Solid Stone (Horde)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "212 {item:7912} para {item:10512} y {item:10513}: {skill:186}: {object:2040} (habilidad 175) en {zone:1443} (30-40), {zone:1425} (40-50) y {zone:1444} (40-50); o la casa de subastas. Está marcado el grupo más denso de {object:2040} en {zone:1443}.",
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest cluster of {object:2040} in {zone:1443} is marked."] = "",

	-- Step 71: Thorium Bar
	-- {item:12359} Thorium Bar · {item:15994} Thorium Widget · {item:16000} Thorium Tube · {skill:186} Mining · {item:10620} Thorium Ore
	["156 {item:12359} for {item:15994} and {item:16000}: {skill:186}: smelt {item:10620}."] = "",

	-- Step 72: Runecloth
	-- {item:14047} Runecloth · {item:15994} Thorium Widget
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it. Keep what you loot as you level, or take it from your bank."] = "",

	-- Step 73: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} hasta 245",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (118 for 225-300): {skill:186}: smelt {item:3858}; or the Auction House."] = "{item:10512} es amarillo a 225 (amarillo 210, verde 230, gris 250): unas 62 fabricaciones hasta 245. Cada una lleva 1 {item:3860} y 1 {item:10505} y da 200. Haz primero los 50 {item:10505}. Usa los 12 {item:10505} que hiciste antes; las cantidades de arriba no los incluyen. Una {item:3860} y un {item:10505} por fabricación; los cazadores compran las balas. Requiere un yunque cerca. {item:3860} (118 para 225-300): {skill:186}: funde {item:3858}; o la casa de subastas.",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby."] = "",

	-- Step 74: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "Recetas de {skill:202} a 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} (from 245)."] = "Vuelve con un instructor de {skill:202}: {spell:12621} (desde 245).",

	-- Step 75: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "{item:10513} hasta 265",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby."] = "{item:10513} es amarillo a 245 (amarillo 245, verde 265, gris 285): unas 28 fabricaciones hasta 265. Cada una lleva 2 {item:3860} y 2 {item:10505} y da 200. Haz primero los 56 {item:10505}. Dos barras de mitril y dos {item:10505} por fabricación. Requiere un yunque cerca.",

	-- Step 76: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "{item:15994} hasta 287",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth · {skill:186} Mining · {item:10620} Thorium Ore
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby. {item:12359} (156 for 225-300): {skill:186}: smelt {item:10620}; or the Auction House."] = "{item:15994} es naranja a 265 (amarillo 280, verde 290, gris 300): unas 24 fabricaciones hasta 287. Cada una lleva 3 {item:12359} y 1 {item:14047}. Tres barras de torio y un {item:14047} por fabricación; los artefactos son piezas para los artilugios de torio posteriores. Requiere un yunque cerca. {item:12359} (156 para 225-300): {skill:186}: funde {item:10620}; o la casa de subastas.",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby."] = "",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 77: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} hasta 300",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300. Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "{item:16000} es naranja a 287 (amarillo 295, verde 305, gris 315): unas 14 fabricaciones hasta 300. Cada una lleva 6 {item:12359}. El esquema se liga al recogerlo; seis barras de torio por fabricación. Requiere un yunque cerca. {skill:202} 300 es un hito del Sistema de Legado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "19 {item:2592} para {spell:3953}: lo sueltan los humanoides de nivel 15-30. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",
	-- ["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "24 {item:14047} para {item:15994}: lo sueltan los humanoides de nivel 45-60. Guarda lo que saquees mientras subes de nivel, sácalo de tu banco o cómpralo en la casa de subastas.",
	-- ["Apprentice {skill:202}"] = "Aprendiz de {skill:202}",
	-- ["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Artesano requiere nivel de personaje 35 y {skill:202} 200; sube el límite a 300. Los materiales para 225-300 valen unos 67g en total.",
	-- ["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Vuelve con un instructor de {skill:202}: {spell:12585}, {spell:12596} se enseñan a partir de {skill:202} 210.",
	-- ["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Vuelve con un instructor de {skill:202}: {spell:12590} se enseña a partir de {skill:202} 175.",
	-- ["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Vuelve con un instructor de {skill:202}: {spell:12621} se enseña a partir de {skill:202} 245.",
	-- ["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Vuelve con un instructor de {skill:202}: {spell:3922} se enseña a partir de {skill:202} 45.",
	-- ["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Vuelve con un instructor de {skill:202}: {spell:3923} se enseña a partir de {skill:202} 60.",
	-- ["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Vuelve con un instructor de {skill:202}: {spell:3924} se enseña a partir de {skill:202} 80.",
	-- ["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Vuelve con un instructor de {skill:202}: {spell:3926} se enseña a partir de {skill:202} 95.",
	-- ["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Vuelve con un instructor de {skill:202}: {spell:3929} se enseña a partir de {skill:202} 85.",
	-- ["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Vuelve con un instructor de {skill:202}: {spell:3937} se enseña a partir de {skill:202} 105.",
	-- ["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Vuelve con un instructor de {skill:202}: {spell:3942} se enseña a partir de {skill:202} 125.",
	-- ["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Vuelve con un instructor de {skill:202}: {spell:3945} se enseña a partir de {skill:202} 125.",
	-- ["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Experto requiere nivel de personaje 20 y {skill:202} 125; sube el límite a 225. Los materiales para 150-225 valen unos 15g en total.",
	-- ["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Oficial requiere nivel de personaje 10 y {skill:202} 50; sube el límite a 150. Los materiales para 75-150 valen unos 3g 23s en total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}) and {npc:11029} ({zone:1455}); Horde {npc:11031} ({zone:1458}) and {npc:3412} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "Oficial sube el límite de 75 a 150 por 5s (precio de Classic; el de Forever no está en los datos); requiere {skill:202} 50 y nivel de personaje 10, así que puedes aprenderlo en cualquier visita a partir de 50. No todos los instructores de {skill:202} lo enseñan: Alianza: {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}) y {npc:11029} ({zone:1455}); Horda: {npc:11031} ({zone:1458}) y {npc:3412} ({zone:1454}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:3929} (desde 75, 2s 50c) y {spell:3930} (desde 75, 2s 50c). De 75 a 150 hacen falta unos 5s en recetas y 45s en artículos de mercader, además de 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} y 2 {item:2842} que recolectar o comprar.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el lugar de farmeo que Polestar elige para tu nivel y facción. También sirve la casa de subastas.",
	-- ["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Naranja (un punto por creación) hasta 20, amarillo hasta 30, verde hasta 40.",
	-- ["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Naranja (un punto por creación) hasta 280, amarillo hasta 290, verde hasta 300. Requiere un yunque cerca.",
	-- ["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 295, amarillo hasta 305, verde hasta 315. Requiere un yunque cerca. {skill:202} 300 es un hito del Sistema de Legado.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384}, {npc:2354} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú mismo o cómpralos en la casa de subastas.",
	-- ["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:15994} (requiere {skill:202} 260). Los mercaderes lo venden en existencias limitadas que se reponen; la casa de subastas también suele tenerlo.",
	-- ["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Enseña {item:16000} (requiere {skill:202} 275). Los mercaderes lo venden en existencias limitadas que se reponen.",
	-- ["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 110, verde hasta 125: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 130, verde hasta 155: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 135, green until 145: not every craft gives a point."] = "Amarillo hasta 135, verde hasta 145: no todas las creaciones dan un punto.",
	-- ["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Amarillo hasta 150, verde hasta 175: no todas las creaciones dan un punto. Requiere un yunque cerca. {skill:202} 150 es un hito del Sistema de Legado.",
	-- ["Yellow until 170, green until 195: not every craft gives a point."] = "Amarillo hasta 170, verde hasta 195: no todas las creaciones dan un punto.",
	-- ["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 195, verde hasta 215: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 230, verde hasta 250: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Amarillo hasta 230, verde hasta 250: no todas las creaciones dan un punto. Requiere un yunque cerca. {skill:202} 225 es un hito del Sistema de Legado.",
	-- ["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 265, verde hasta 285: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 45, green until 60: not every craft gives a point."] = "Amarillo hasta 45, verde hasta 60: no todas las creaciones dan un punto.",
	-- ["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 52, verde hasta 60: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 75, verde hasta 90: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Amarillo hasta 75, verde hasta 90: no todas las creaciones dan un punto. Requiere un yunque cerca. 75 es el límite de Aprendiz.",
	-- ["Yellow until 90, green until 95: not every craft gives a point."] = "Amarillo hasta 90, verde hasta 95: no todas las creaciones dan un punto.",
	-- ["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 95, verde hasta 110: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	-- ["{item:10498} to 210"] = "{item:10498} hasta 210",
	-- ["{item:10513} to 264"] = "{item:10513} hasta 264",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (Alianza)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- ["{item:15994} to 288"] = "{item:15994} hasta 288",
	-- ["{item:2592} (Alliance)"] = "{item:2592} (Alianza)",
	-- ["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- ["{item:2835} (Alliance)"] = "{item:2835} (Alianza)",
	-- ["{item:2835} (Horde)"] = "{item:2835} (Horda)",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} se obtiene de nodos de {object:1731} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} se obtiene de nodos de {object:1732} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} se obtiene de nodos de {object:1735} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: una herramienta, guárdala en tus bolsas",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} se obtiene de nodos de {object:2040} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "{npc:3263} (nivel 19-20) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "{npc:6189} (nivel 51-52) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "{npc:7027} (nivel 56-57) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "{npc:98} (nivel 17-18) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funde {item:10620} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funde {item:2770} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funde {item:2840} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funde {item:3575} (o la casa de subastas)",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funde {item:3858} (o la casa de subastas)",
	-- ["{skill:202} materials for 1-75"] = "Materiales de {skill:202} para 1-75",
	-- ["{skill:202} materials for 150-225"] = "Materiales de {skill:202} para 150-225",
	-- ["{skill:202} materials for 225-300"] = "Materiales de {skill:202} para 225-300",
	-- ["{skill:202} materials for 75-150"] = "Materiales de {skill:202} para 75-150",
	-- ["{skill:202} recipes at 111"] = "Recetas de {skill:202} a 111",
	-- ["{skill:202} recipes at 139"] = "Recetas de {skill:202} a 139",
	-- ["{skill:202} recipes at 45"] = "Recetas de {skill:202} a 45",
	-- ["{skill:202} recipes at 60"] = "Recetas de {skill:202} a 60",
	-- ["{skill:202} recipes at 80"] = "Recetas de {skill:202} a 80",
	-- ["{skill:202} recipes at 85"] = "Recetas de {skill:202} a 85",
	-- ["{skill:202} recipes at 95"] = "Recetas de {skill:202} a 95",
	-- ["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} avanza junto con la subida de nivel. El Sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los límites de Oficial, Experto y Artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 62s en total.",
	-- ["{spell:3918} to 37"] = "{spell:3918} hasta 37",
	-- ["{spell:3920} to 45"] = "{spell:3920} hasta 45",
	-- ["{spell:3922} to 60"] = "{spell:3922} hasta 60",
	-- ["{spell:3923} to 75"] = "{spell:3923} hasta 75",
	-- ["{spell:3923} to 80"] = "{spell:3923} hasta 80",
	-- ["{spell:3924} to 85"] = "{spell:3924} hasta 85",
	-- ["{spell:3926} to 111"] = "{spell:3926} hasta 111",
	-- ["{spell:3929} to 95"] = "{spell:3929} hasta 95",
	-- ["{spell:3937} to 125"] = "{spell:3937} hasta 125",
	-- ["{spell:3942} to 150"] = "{spell:3942} hasta 150",
	-- ["{spell:3945} to 139"] = "{spell:3945} hasta 139",
}
