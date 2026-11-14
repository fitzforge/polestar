-- Spanish (Latin America) (esMX): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Enchanting
	-- {skill:333} Enchanting
	["Learn {skill:333}"] = "Aprende {skill:333}",
	-- {skill:333} Enchanting · {npc:3606} Alanna Raveneye · {zone:1438} Teldrassil · {npc:11068} Betty Quin · {zone:1453} Stormwind City · {npc:257004} Eaysaa Brightgust · {npc:11070} Lalina Summermoon · {zone:1457} Darnassus · {npc:257020} Nasalanna Windsinger · {npc:11065} Thonys Pillarstone · {zone:1455} Ironforge · {npc:11066} Jhag · {zone:1454} Orgrimmar · {npc:11067} Malcomb Wynn · {zone:1458} Undercity · {npc:11071} Mot Dawnstrider · {zone:1456} Thunder Bluff · {npc:266881} Pa'zula · {zone:1411} Durotar · {npc:5695} Vance Undergloom · {zone:1420} Tirisfal Glades · {item:6217} Copper Rod · {item:247786} Mote of Magic · {npc:11072} Kitta Firewind · {area:91} Tower of Azora · {zone:1429} Elwynn Forest · {area:367} Sen'jin Village · {item:10940} Strange Dust
	["Apprentice {skill:333} lets you craft up to 75 for 10c, at any character level. Not every {skill:333} trainer teaches it: Alliance {npc:3606} ({zone:1438}), {npc:11068} ({zone:1453}), {npc:257004} (Zephras Isle), {npc:11070} ({zone:1457}), {npc:257020} (Zephras Isle) and {npc:11065} ({zone:1455}); Horde {npc:257004} (Zephras Isle), {npc:11066} ({zone:1454}), {npc:11067} ({zone:1458}), {npc:11071} ({zone:1456}), {npc:257020} (Zephras Isle), {npc:266881} ({zone:1411}) and {npc:5695} ({zone:1420}). The arrow picks the nearest of your faction. Buy a {item:6217} and {item:247786} from an enchanting supplies vendor (in the capitals and on Zephras Isle; the starting-area trainers have none beside them, and the next step's arrow picks the nearest). From now on, disenchant every green you do not wear: that is where the dust and essences come from. Two starter quests teach Disenchant on a quest item: An Enchanting Lesson from {npc:11072} ({area:91}, {zone:1429}) and A Pain in the Neck from {npc:266881} ({area:367}, {zone:1411}). 1-75 takes about 50c of recipes and 4s 44c of vendor goods, plus 51 {item:10940} to gather or buy."] = "Aprendiz de {skill:333} te permite fabricar hasta 75 por 10c, a cualquier nivel de personaje. No todos los instructores de {skill:333} lo enseñan: Alianza: {npc:3606} ({zone:1438}), {npc:11068} ({zone:1453}), {npc:257004} (Isla Zephras), {npc:11070} ({zone:1457}), {npc:257020} (Isla Zephras) y {npc:11065} ({zone:1455}); Horda: {npc:257004} (Isla Zephras), {npc:11066} ({zone:1454}), {npc:11067} ({zone:1458}), {npc:11071} ({zone:1456}), {npc:257020} (Isla Zephras), {npc:266881} ({zone:1411}) y {npc:5695} ({zone:1420}). La flecha elige el más cercano de tu facción. Compra una {item:6217} y {item:247786} a un mercader de suministros de encantamiento (en las capitales y en la Isla Zephras; los instructores de las zonas iniciales no tienen ninguno al lado, y la flecha del siguiente paso elige el más cercano). A partir de ahora, desencanta cada objeto verde que no uses: de ahí salen el polvo y las esencias. Dos misiones iniciales enseñan Desencantar con un objeto de misión: “An Enchanting Lesson”, de {npc:11072} ({area:91}, {zone:1429}), y “Un dolor de cuello”, de {npc:266881} ({area:367}, {zone:1411}). De 1 a 75 hacen falta unos 50c en recetas y 4s 44c en artículos de mercader, además de 51 {item:10940} que recolectar o comprar.",

	-- Step 2: Enchanting 1-75: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 1-75: vendor goods"] = "{skill:333} 1-75: artículos de mercader",
	-- {item:6217} Copper Rod · {item:247786} Mote of Magic · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1318} Jessara Cordell · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3346} Kithas · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 1 {item:6217} (1s 24c) and 32 {item:247786} (3s 20c); about 4s 44c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346} and {npc:5817})."] = "Compra de una vez todo lo de este tramo: 1 {item:6217} (1s 24c) y 32 {item:247786} (3s 20c); unos 4s 44c en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1286} y {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346} y {npc:5817}).",

	-- Step 3: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418} hasta 25",
	-- {spell:7418} Enchant Bracer - Inferior Stamina · {item:247786} Mote of Magic · {item:6218} Runed Copper Rod
	["{spell:7418} is orange at 1 (yellow 20, green 22, grey 25): about 31 crafts to 25. Each takes 1 {item:247786}. One {item:247786} (10c) a craft; grey at 25 on Forever. Make the {item:6218} first: the recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7418} es naranja a 1 (amarillo 20, verde 22, gris 25): unas 31 fabricaciones hasta 25. Cada una lleva 1 {item:247786}. Una {item:247786} (10c) por fabricación; gris a 25 en Forever. Haz primero {item:6218}: la receta lo necesita en tus bolsas, así que guárdalo ahí. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",
	["a tool: keep it in your bags"] = "una herramienta: guárdala en tus bolsas",

	-- Step 4: Enchanting recipes at 25
	-- {skill:333} Enchanting
	["{skill:333} recipes at 25"] = "Recetas de {skill:333} a 25",
	-- {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina · {spell:1230643} Enchanted Lute · {item:4470} Simple Wood · {item:10940} Strange Dust
	["Back to an {skill:333} trainer: {spell:7420} (from 15, 50c). Also learn {spell:1230643} (1s): Forever's {skill:333} camp item, 1 {item:4470} and 1 {item:10940}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:333} quest from your starting area's camping guide (after The Great Outdoors) sends you to an enchanting trainer who teaches it free."] = "Vuelve con un instructor de {skill:333}: {spell:7420} (desde 15, 50c). Aprende también {spell:1230643} (1s): el objeto de campamento de {skill:333} de Forever, con 1 {item:4470} y 1 {item:10940}, que se coloca en un campamento junto a una hoguera para obtener su beneficio. La misión “Campamento básico: {skill:333}” del guía de campamento de tu zona inicial (después de “Bendita naturaleza”) te envía a un instructor de encantamiento que lo enseña gratis.",

	-- Step 5: Enchant Chest - Inferior Stamina to 75
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 75"] = "{spell:7420} hasta 75",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption · {skill:333} Enchanting
	["{spell:7420} is orange at 25 (yellow 70, green 90, grey 110): about 51 crafts to 75. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. {item:10940} (51 for 1-75): {skill:333}: disenchant green items of item level 5-20; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7420} es naranja a 25 (amarillo 70, verde 90, gris 110): unas 51 fabricaciones hasta 75. Cada una lleva 1 {item:10940}. Un {item:10940} por fabricación: el polvo en que se desencantan la mayoría de los verdes de nivel 5-20, sobre todo las armaduras. {item:10938} (de las armas) sirve igual a través de Brazal: desvío menor o Pechera: {spell:7423}, si tienes más de ella. {item:10940} (51 para 1-75): {skill:333}: desencanta objetos verdes de nivel de objeto 5-20; o la casa de subastas. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",

	-- Step 6: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "{skill:333} de oficial",
	-- {skill:333} Enchanting · {npc:5157} Gimble Thistlefuzz · {zone:1455} Ironforge · {npc:1317} Lucan Cordell · {zone:1453} Stormwind City · {npc:4213} Taladan · {zone:1457} Darnassus · {npc:7949} Xylinnia Starshine · {zone:1444} Feralas · {npc:3345} Godan · {zone:1454} Orgrimmar · {npc:4616} Lavinia Crowe · {zone:1458} Undercity · {npc:3011} Teg Dawnstrider · {zone:1456} Thunder Bluff · {spell:7771} Enchant Cloak - Minor Protection · {item:1210} Shadowgem · {item:6338} Silver Rod · {item:10938} Lesser Magic Essence · {item:10940} Strange Dust · {item:11083} Soul Dust
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:333} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:333} trainer teaches it: Alliance {npc:5157} ({zone:1455}), {npc:1317} ({zone:1453}), {npc:4213} ({zone:1457}) and {npc:7949} ({zone:1444}); Horde {npc:3345} ({zone:1454}), {npc:4616} ({zone:1458}) and {npc:3011} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:7771} (from 70, 2s). 75-150 takes about 2s of recipes, plus 1 {item:1210}, 1 {item:6338}, 4 {item:10938}, 121 {item:10940} and 20 {item:11083} to gather or buy."] = "Oficial sube el límite de 75 a 150 por 5s (precio de Classic; el de Forever no está en los datos); requiere {skill:333} 50 y nivel de personaje 10, así que puedes aprenderlo en cualquier visita a partir de 50. No todos los instructores de {skill:333} lo enseñan: Alianza: {npc:5157} ({zone:1455}), {npc:1317} ({zone:1453}), {npc:4213} ({zone:1457}) y {npc:7949} ({zone:1444}); Horda: {npc:3345} ({zone:1454}), {npc:4616} ({zone:1458}) y {npc:3011} ({zone:1456}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:7771} (desde 70, 2s). De 75 a 150 hacen falta unos 2s en recetas, además de 1 {item:1210}, 1 {item:6338}, 4 {item:10938}, 121 {item:10940} y 20 {item:11083} que recolectar o comprar.",

	-- Step 7: Enchant Chest - Inferior Stamina to 90
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 90"] = "{spell:7420} hasta 90",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption · {skill:333} Enchanting
	["{spell:7420} is yellow at 75 (yellow 70, green 90, grey 110): about 22 crafts to 90. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. {item:10940} (121 for 75-150): {skill:333}: disenchant green items of item level 5-20; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7420} es amarillo a 75 (amarillo 70, verde 90, gris 110): unas 22 fabricaciones hasta 90. Cada una lleva 1 {item:10940}. Un {item:10940} por fabricación: el polvo en que se desencantan la mayoría de los verdes de nivel 5-20, sobre todo las armaduras. {item:10938} (de las armas) sirve igual a través de Brazal: desvío menor o Pechera: {spell:7423}, si tienes más de ella. {item:10940} (121 para 75-150): {skill:333}: desencanta objetos verdes de nivel de objeto 5-20; o la casa de subastas. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",

	-- Step 8: Enchant Cloak - Minor Protection to 130
	-- {spell:7771} Enchant Cloak - Minor Protection
	["{spell:7771} to 130"] = "{spell:7771} hasta 130",
	-- {spell:7771} Enchant Cloak - Minor Protection · {item:10940} Strange Dust
	["{spell:7771} is orange at 90 (yellow 110, green 130, grey 150): about 48 crafts to 130. Each takes 2 {item:10940}. Two {item:10940} a craft (the trainer teaches it from 70 for 2s); keep disenchanting the greens of the 10-20 zones. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7771} es naranja a 90 (amarillo 110, verde 130, gris 150): unas 48 fabricaciones hasta 130. Cada una lleva 2 {item:10940}. Dos {item:10940} por fabricación (el instructor lo enseña desde 70 por 2s); sigue desencantando los verdes de las zonas de nivel 10-20. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",

	-- Step 9: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "Recetas de {skill:333} a 130",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:7795} (from 100) and {spell:13501} (from 130)."] = "Vuelve con un instructor de {skill:333}: {spell:7795} (desde 100) y {spell:13501} (desde 130).",

	-- Step 10: Enchant Bracer - Lesser Stamina to 150
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 150"] = "{spell:13501} hasta 150",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:6339} Runed Silver Rod · {item:1210} Shadowgem · {object:1731} Copper Vein · {object:1732} Tin Vein · {object:1733} Silver Vein · {item:6338} Silver Rod · {skill:164} Blacksmithing · {item:10938} Lesser Magic Essence · {skill:333} Enchanting
	["{spell:13501} is orange at 130 (yellow 155, green 175, grey 195): about 20 crafts to 150, a point every craft. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:6339} first: the recipe needs it in your bags, so keep it there. {item:1210} (1 for 75-150): {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: buy it at the Auction House, or keep the ones you find while mining. {item:6338} (1 for 75-150): {skill:164}: {item:6338}; or the Auction House. {item:10938} (4 for 75-150): {skill:333}: disenchant green items of item level 5-15; or the Auction House. {item:11083} (20 for 75-150): {skill:333}: disenchant green items of item level 21-30; or the Auction House. Enchant any item for that slot in your bags, even a grey one. {skill:333} 150 is a Legacy System milestone."] = "{spell:13501} es naranja a 130 (amarillo 155, verde 175, gris 195): unas 20 fabricaciones hasta 150, un punto por fabricación. Cada una lleva 1 {item:11083}. Una {item:11083} por fabricación (verdes de nivel 21-30). Haz primero {item:6339}: la receta lo necesita en tus bolsas, así que guárdalo ahí. {item:1210} (1 para 75-150): {item:1210} aparece más o menos en uno de cada 100 {object:1731}, {object:1732} o {object:1733}: cómpralo en la casa de subastas, o guarda los que encuentres al minar. {item:6338} (1 para 75-150): {skill:164}: {item:6338}; o la casa de subastas. {item:10938} (4 para 75-150): {skill:333}: desencanta objetos verdes de nivel de objeto 5-15; o la casa de subastas. {item:11083} (20 para 75-150): {skill:333}: desencanta objetos verdes de nivel de objeto 21-30; o la casa de subastas. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris. {skill:333} 150 es un hito del Sistema de Legado.",

	-- Step 11: Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Alliance)"] = "{item:5500} (Alianza)",
	-- {item:5500} Iridescent Pearl · {item:11130} Runed Golden Rod
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["1 {item:5500} for {item:11130}: open the Giant Clams at the marked spot, or buy it at the Auction House."] = "1 {item:5500} para {item:11130}: abre las almejas gigantes en el lugar marcado, o cómprala en la casa de subastas.",

	-- Step 12: Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Horde)"] = "{item:5500} (Horda)",

	-- Step 13: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "Experto de {skill:333}",
	-- {skill:333} Enchanting · {npc:11072} Kitta Firewind · {zone:1429} Elwynn Forest · {npc:11074} Hgarth · {zone:1442} Stonetalon Mountains · {spell:13628} Runed Golden Rod · {item:5500} Iridescent Pearl · {item:7971} Black Pearl · {item:11082} Greater Astral Essence · {item:11083} Soul Dust · {item:11128} Golden Rod · {item:11135} Greater Mystic Essence · {item:11137} Vision Dust · {item:11144} Truesilver Rod · {spell:13637} Enchant Boots - Lesser Agility · {item:11145} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:333} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11072} ({zone:1429}); Horde {npc:11074} ({zone:1442}). The arrow picks the nearest of your faction. Learn now: {spell:13628} (from 150). 150-225 takes 1 {item:5500}, 1 {item:7971}, 1 {item:11082}, 71 {item:11083}, 1 {item:11128}, 1 {item:11135}, 21 {item:11137} and 1 {item:11144} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:13637} (from 160), {item:11145} (from 200) and {spell:13746} (from 205), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Experto sube el límite de 150 a 225 por 50s (precio de Classic; el de Forever no está en los datos); requiere {skill:333} 125 y nivel de personaje 20, así que puedes aprenderlo en cualquier visita a partir de 125. Solo lo enseñan unos pocos instructores: Alianza: {npc:11072} ({zone:1429}); Horda: {npc:11074} ({zone:1442}). La flecha elige el más cercano de tu facción. Aprende ahora: {spell:13628} (desde 150). De 150 a 225 hacen falta 1 {item:5500}, 1 {item:7971}, 1 {item:11082}, 71 {item:11083}, 1 {item:11128}, 1 {item:11135}, 21 {item:11137} y 1 {item:11144} que recolectar o comprar. Ven con todo en las bolsas (los pasos de arriba; el resto, de la casa de subastas): estos instructores también enseñan {spell:13637} (desde 160), {item:11145} (desde 200) y {spell:13746} (desde 205), y las fabricaciones no necesitan estación, así que fabrica aquí mismo y aprende cada receta al alcanzar su habilidad. Un viaje en lugar de 3.",

	-- Step 14: Enchant Bracer - Lesser Stamina to 160
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 160"] = "{spell:13501} hasta 160",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:11130} Runed Golden Rod · {item:11082} Greater Astral Essence · {skill:333} Enchanting · {item:11128} Golden Rod · {skill:164} Blacksmithing
	["{spell:13501} is orange at 150 (yellow 155, green 175, grey 195): about 11 crafts to 160. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:11130} now, while it still gives a point: a later recipe needs it in your bags, so keep it there. {item:11082} (1 for 150-225): {skill:333}: disenchant green items of item level 16-25; or the Auction House. {item:11083} (71 for 150-225): {skill:333}: disenchant green items of item level 21-30; or the Auction House. {item:11128} (1 for 150-225): {skill:164}: {item:11128}; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "{spell:13501} es naranja a 150 (amarillo 155, verde 175, gris 195): unas 11 fabricaciones hasta 160. Cada una lleva 1 {item:11083}. Una {item:11083} por fabricación (verdes de nivel 21-30). Haz ahora {item:11130}, mientras todavía da un punto: una receta posterior lo necesita en tus bolsas, así que guárdalo ahí. {item:11082} (1 para 150-225): {skill:333}: desencanta objetos verdes de nivel de objeto 16-25; o la casa de subastas. {item:11083} (71 para 150-225): {skill:333}: desencanta objetos verdes de nivel de objeto 21-30; o la casa de subastas. {item:11128} (1 para 150-225): {skill:164}: {item:11128}; o la casa de subastas. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",

	-- Step 15: Enchanting recipes at 160
	-- {skill:333} Enchanting
	["{skill:333} recipes at 160"] = "Recetas de {skill:333} a 160",
	-- {spell:13637} Enchant Boots - Lesser Agility
	["Still at the Expert trainer: {spell:13637} (from 160)."] = "Todavía con el instructor de Experto: {spell:13637} (desde 160).",

	-- Step 16: Enchant Boots - Lesser Agility to 205
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 205"] = "{spell:13637} hasta 205",
	-- {spell:13637} Enchant Boots - Lesser Agility · {item:11083} Soul Dust
	["{spell:13637} is orange at 160 (yellow 180, green 200, grey 220): about 59 crafts to 205. Each takes 1 {item:11083}. {item:11083} again. Enchant any item for that slot in your bags, even a grey one."] = "{spell:13637} es naranja a 160 (amarillo 180, verde 200, gris 220): unas 59 fabricaciones hasta 205. Cada una lleva 1 {item:11083}. {item:11083} otra vez. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",

	-- Step 17: Enchanting recipes at 205
	-- {skill:333} Enchanting
	["{skill:333} recipes at 205"] = "Recetas de {skill:333} a 205",
	-- {spell:13702} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Still at the Expert trainer: {spell:13702} (from 200) and {spell:13746} (from 205)."] = "Todavía con el instructor de Experto: {spell:13702} (desde 200) y {spell:13746} (desde 205).",

	-- Step 18: Enchant Cloak - Greater Defense to 225
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 225"] = "{spell:13746} hasta 225",
	-- {spell:13746} Enchant Cloak - Greater Defense · {item:11137} Vision Dust · {item:11145} Runed Truesilver Rod · {item:7971} Black Pearl · {item:11135} Greater Mystic Essence · {skill:333} Enchanting · {item:11144} Truesilver Rod · {skill:164} Blacksmithing
	["{spell:13746} is orange at 205 (yellow 225, green 245, grey 265): about 20 crafts to 225, a point every craft. Each takes 1 {item:11137}. One {item:11137} a craft (level 31-40 greens). Make the {item:11145} first: the recipe needs it in your bags, so keep it there. {item:7971} (1 for 150-225): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find. {item:11135} (1 for 150-225): {skill:333}: disenchant green items of item level 26-35; or the Auction House. {item:11137} (21 for 150-225): {skill:333}: disenchant green items of item level 31-40; or the Auction House. {item:11144} (1 for 150-225): {skill:164}: {item:11144}; or the Auction House. Enchant any item for that slot in your bags, even a grey one. {skill:333} 225 is a Legacy System milestone."] = "{spell:13746} es naranja a 205 (amarillo 225, verde 245, gris 265): unas 20 fabricaciones hasta 225, un punto por fabricación. Cada una lleva 1 {item:11137}. Una {item:11137} por fabricación (verdes de nivel 31-40). Haz primero {item:11145}: la receta lo necesita en tus bolsas, así que guárdalo ahí. {item:7971} (1 para 150-225): {item:7971} es un botín raro (ningún enemigo lo suelta ni una vez de cada 50): cómpralo en la casa de subastas, o guarda los que encuentres. {item:11135} (1 para 150-225): {skill:333}: desencanta objetos verdes de nivel de objeto 26-35; o la casa de subastas. {item:11137} (21 para 150-225): {skill:333}: desencanta objetos verdes de nivel de objeto 31-40; o la casa de subastas. {item:11144} (1 para 150-225): {skill:164}: {item:11144}; o la casa de subastas. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris. {skill:333} 225 es un hito del Sistema de Legado.",

	-- Step 19: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "Artesano de {skill:333}",
	-- {skill:333} Enchanting · {npc:11073} Annora · {area:1517} Uldaman · {zone:1418} Badlands · {spell:13815} Enchant Gloves - Agility · {item:8831} Purple Lotus · {item:11137} Vision Dust · {item:11176} Dream Dust
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:333} 200 and character level 35, so you can take it on any visit from 200. {npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group. Learn now: {spell:13815} (from 210). 225-300 takes about 2g 20s of recipes and 1g 70s of vendor goods, plus 34 {item:8831}, 39 {item:11137} and 208 {item:11176} to gather or buy."] = "Artesano sube el límite de 225 a 300 por 5g (precio de Classic; el de Forever no está en los datos); requiere {skill:333} 200 y nivel de personaje 35, así que puedes aprenderlo en cualquier visita a partir de 200. {npc:11073} enseña Artesano de {skill:333} dentro de la mazmorra {area:1517} ({zone:1418}); ve con un grupo. Aprende ahora: {spell:13815} (desde 210). De 225 a 300 hacen falta unos 2g 20s en recetas y 1g 70s en artículos de mercader, además de 34 {item:8831}, 39 {item:11137} y 208 {item:11176} que recolectar o comprar.",

	-- Step 20: Enchanting 225-300: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 225-300: vendor goods"] = "{skill:333} 225-300: artículos de mercader",
	-- {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 34 {item:8925} (1g 70s); about 1g 70s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Compra de una vez todo lo de este tramo: 34 {item:8925} (1g 70s); unos 1g 70s en total. La flecha elige el vendedor más cercano de tu facción ({zone:1453}: {npc:1286}, Eldraeith y {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} y {npc:3334}).",

	-- Step 21: Formula: Lesser Mana Oil
	-- {item:20754} Formula: Lesser Mana Oil · {item:20747} Lesser Mana Oil · {skill:333} Enchanting · {npc:15419} Kania · {zone:1451} Silithus
	["{item:20754} teaches {item:20747} ({skill:333} 250) for 1g. Sold by {npc:15419} ({zone:1451})."] = "{item:20754} enseña {item:20747} ({skill:333} 250) por 1g. Lo venden {npc:15419} ({zone:1451}).",

	-- Step 22: Formula: Enchant Shield - Greater Stamina
	-- {item:16217} Formula: Enchant Shield - Greater Stamina · {spell:20017} Enchant Shield - Greater Stamina · {skill:333} Enchanting · {npc:4229} Mythrin'dir · {zone:1457} Darnassus · {npc:4561} Daniel Bartlett · {zone:1458} Undercity
	["{item:16217} teaches {spell:20017} ({skill:333} 265) for 1g 20s. Sold by Alliance: {npc:4229} ({zone:1457}), limited stock; Horde: {npc:4561} ({zone:1458}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:16217} enseña {spell:20017} ({skill:333} 265) por 1g 20s. Lo venden: Alianza: {npc:4229} ({zone:1457}), existencias limitadas; Horda: {npc:4561} ({zone:1458}), existencias limitadas. Sus vendedores tienen una o dos en existencia, que se reponen un tiempo después de cada venta; se liga al recogerla, así que la casa de subastas nunca la tiene.",

	-- Step 23: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831} (Alianza)",
	-- {item:8831} Purple Lotus · {item:20747} Lesser Mana Oil · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8831} in {zone:1425} is marked."] = "34 {item:8831} para {item:20747}: {skill:182}: {item:8831} (habilidad 210) en {zone:1425} (40-50), {zone:1444} (40-50) y {zone:1447} (45-55); o la casa de subastas. Está marcada la zona más densa de {item:8831} en {zone:1425}.",

	-- Step 24: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831} (Horda)",
	-- {item:8831} Purple Lotus · {item:20747} Lesser Mana Oil · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8831} in {zone:1444} is marked."] = "34 {item:8831} para {item:20747}: {skill:182}: {item:8831} (habilidad 210) en {zone:1425} (40-50), {zone:1444} (40-50) y {zone:1447} (45-55); o la casa de subastas. Está marcada la zona más densa de {item:8831} en {zone:1444}.",

	-- Step 25: Enchant Gloves - Agility to 253
	-- {spell:13815} Enchant Gloves - Agility
	["{spell:13815} to 253"] = "{spell:13815} hasta 253",
	-- {spell:13815} Enchant Gloves - Agility · {item:11137} Vision Dust · {npc:11073} Annora · {skill:333} Enchanting
	["{spell:13815} is orange at 225 (yellow 230, green 250, grey 270): about 39 crafts to 253. Each takes 1 {item:11137}. {npc:11073} teaches it with Artisan: learn it on that visit. {item:11137} again; bring about 40. {item:11137} (39 for 225-300): {skill:333}: disenchant green items of item level 31-40; or the Auction House. Enchant any item for that slot in your bags, even a grey one."] = "{spell:13815} es naranja a 225 (amarillo 230, verde 250, gris 270): unas 39 fabricaciones hasta 253. Cada una lleva 1 {item:11137}. {npc:11073} la enseña junto con Artesano: apréndela en esa visita. {item:11137} otra vez; lleva unas 40. {item:11137} (39 para 225-300): {skill:333}: desencanta objetos verdes de nivel de objeto 31-40; o la casa de subastas. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris.",

	-- Step 26: Lesser Mana Oil to 275
	-- {item:20747} Lesser Mana Oil
	["{item:20747} to 275"] = "{item:20747} hasta 275",
	-- {item:20747} Lesser Mana Oil · {item:11176} Dream Dust · {item:8831} Purple Lotus · {item:8925} Crystal Vial · {npc:15419} Kania · {area:3425} Cenarion Hold · {zone:1451} Silithus · {skill:333} Enchanting
	["{item:20747} is orange at 253 (yellow 260, green 270, grey 280): about 34 crafts to 275. Each takes 1 {item:11176}, 1 {item:8831} and 1 {item:8925}. One {item:11176} (level 41-50 greens) and one {item:8831} (herbalists) a craft; the oil sells well. {npc:15419} sells the formula at the inn of {area:3425} ({zone:1451}): fly there, the mobs around it are level 55 and up. {item:11176} (208 for 225-300): {skill:333}: disenchant green items of item level 41-50; or the Auction House."] = "{item:20747} es naranja a 253 (amarillo 260, verde 270, gris 280): unas 34 fabricaciones hasta 275. Cada una lleva 1 {item:11176}, 1 {item:8831} y 1 {item:8925}. Un {item:11176} (verdes de nivel 41-50) y una {item:8831} (herboristas) por fabricación; el aceite se vende bien. {npc:15419} vende la fórmula en la posada de {area:3425} ({zone:1451}): ve volando, los enemigos de alrededor son de nivel 55 o más. {item:11176} (208 para 225-300): {skill:333}: desencanta objetos verdes de nivel de objeto 41-50; o la casa de subastas.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 27: Enchant Shield - Greater Stamina to 300
	-- {spell:20017} Enchant Shield - Greater Stamina
	["{spell:20017} to 300"] = "{spell:20017} hasta 300",
	-- {spell:20017} Enchant Shield - Greater Stamina · {item:11176} Dream Dust · {skill:333} Enchanting
	["{spell:20017} is orange at 275 (yellow 285, green 305, grey 325): about 29 crafts to 300. Each takes 6 {item:11176}. Six {item:11176} a craft: the dearest stretch, so disenchant every level 41-50 green you find. Enchant any item for that slot in your bags, even a grey one. {skill:333} 300 is a Legacy System milestone."] = "{spell:20017} es naranja a 275 (amarillo 285, verde 305, gris 325): unas 29 fabricaciones hasta 300. Cada una lleva 6 {item:11176}. Seis {item:11176} por fabricación: el tramo más caro, así que desencanta cada verde de nivel 41-50 que encuentres. Encanta cualquier objeto de esa ranura que tengas en las bolsas, aunque sea gris. {skill:333} 300 es un hito del Sistema de Legado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:333}"] = "Aprendiz de {skill:333}",
	-- ["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "Artesano requiere nivel de personaje 35 y {skill:333} 200; sube el límite a 300. Los materiales para 225-300 valen unos 30s en total.",
	-- ["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "Vuelve con un instructor de {skill:333}: {spell:13501} se enseña a partir de {skill:333} 155.",
	-- ["Back to an {skill:333} trainer: {spell:13628}, {spell:13637} are taught from {skill:333} 180."] = "Vuelve con un instructor de {skill:333}: {spell:13628}, {spell:13637} se enseñan a partir de {skill:333} 180.",
	-- ["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "Vuelve con un instructor de {skill:333}: {spell:13661} se enseña a partir de {skill:333} 200.",
	-- ["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "Vuelve con un instructor de {skill:333}: {spell:13935} se enseña a partir de {skill:333} 255.",
	-- ["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "Vuelve con un instructor de {skill:333}: {spell:13948} se enseña a partir de {skill:333} 270.",
	-- ["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "Vuelve con un instructor de {skill:333}: {spell:7426} se enseña a partir de {skill:333} 90.",
	-- ["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "Vuelve con un instructor de {skill:333}: {spell:7788} se enseña a partir de {skill:333} 120.",
	-- ["Back to an {skill:333} trainer: {spell:7795} is taught from {skill:333} 130."] = "Vuelve con un instructor de {skill:333}: {spell:7795} se enseña a partir de {skill:333} 130.",
	-- ["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "Experto requiere nivel de personaje 20 y {skill:333} 125; sube el límite a 225. Los materiales para 150-225 valen unos 13s en total.",
	-- ["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "Oficial requiere nivel de personaje 10 y {skill:333} 50; sube el límite a 150. Los materiales para 75-150 valen unos 7g 51s en total.",
	-- ["Open Giant Clams here. The Auction House works too."] = "Abre almejas gigantes ({object:2744}) aquí. También sirve la casa de subastas.",
	-- ["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 135, amarillo hasta 155, verde hasta 175. Encanta tu propio equipo: sirve cualquier objeto para esa ranura. {skill:333} 150 es un hito del Sistema de Legado.",
	-- ["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "Naranja (un punto por creación) hasta 20, amarillo hasta 22, verde hasta 25. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "Naranja (un punto por creación) hasta 80, amarillo hasta 100, verde hasta 120. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "Naranja (un punto por creación) hasta 80, amarillo hasta 100, verde hasta 120. Encanta tu propio equipo: sirve cualquier objeto para esa ranura. 75 es el límite de Aprendiz.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú mismo o cómpralos en la casa de subastas.",
	-- ["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks."] = "Enseña {spell:13419} (requiere {skill:333} 110). Los mercaderes lo venden en existencias limitadas que se reponen.",
	-- ["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 110, verde hasta 130: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 140, verde hasta 160: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 170, verde hasta 190: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 175, verde hasta 195: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 200, verde hasta 220: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "Amarillo hasta 220, verde hasta 240: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura. {skill:333} 225 es un hito del Sistema de Legado.",
	-- ["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 245, verde hasta 265: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "Amarillo hasta 275, verde hasta 295: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura.",
	-- ["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "Amarillo hasta 290, verde hasta 310: no todas las creaciones dan un punto. Encanta tu propio equipo: sirve cualquier objeto para esa ranura. {skill:333} 300 es un hito del Sistema de Legado.",
	-- ["{item:1210} (Alliance)"] = "{item:1210} (Alianza)",
	-- ["{item:1210} (Horde)"] = "{item:1210} (Horda)",
	-- ["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210} se obtiene de nodos de {object:1731} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",
	-- ["{item:7971} (Alliance)"] = "{item:7971} (Alianza)",
	-- ["{item:7971} (Horde)"] = "{item:7971} (Horda)",
	-- ["{item:8153} (Alliance)"] = "{item:8153} (Alianza)",
	-- ["{item:8153} (Horde)"] = "{item:8153} (Horda)",
	-- ["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153} se obtiene de los nodos de {item:8831} ({skill:182}); esta es la zona más densa según los datos. También sirve la casa de subastas.",
	-- ["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073} enseña Artesano de {skill:333} dentro del calabozo {area:1517} ({zone:1418}); lleva un grupo",
	-- ["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "{npc:5431} (nivel 48-50) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "{npc:922} (nivel 40-41) lo sueltan aquí. También sirve la casa de subastas.",
	-- ["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164}: {item:11128} (o la casa de subastas)",
	-- ["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164}: {item:11144} (o la casa de subastas)",
	-- ["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164}: {item:6338} (o la casa de subastas)",
	-- ["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171}: {item:6371} (o la casa de subastas)",
	-- ["{skill:333} materials for 150-225"] = "Materiales de {skill:333} para 150-225",
	-- ["{skill:333} materials for 225-300"] = "Materiales de {skill:333} para 225-300",
	-- ["{skill:333} materials for 75-150"] = "Materiales de {skill:333} para 75-150",
	-- ["{skill:333} recipes at 120"] = "Recetas de {skill:333} a 120",
	-- ["{skill:333} recipes at 155"] = "Recetas de {skill:333} a 155",
	-- ["{skill:333} recipes at 180"] = "Recetas de {skill:333} a 180",
	-- ["{skill:333} recipes at 200"] = "Recetas de {skill:333} a 200",
	-- ["{skill:333} recipes at 255"] = "Recetas de {skill:333} a 255",
	-- ["{skill:333} recipes at 292"] = "Recetas de {skill:333} a 292",
	-- ["{skill:333} recipes at 90"] = "Recetas de {skill:333} a 90",
	-- ["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333} avanza junto con la subida de nivel. El Sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los límites de Oficial, Experto y Artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 4g 3s en total.",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: desencanta equipo poco común (verde) (o la casa de subastas)",
	-- ["{spell:13419} to 150"] = "{spell:13419} hasta 150",
	-- ["{spell:13501} to 180"] = "{spell:13501} hasta 180",
	-- ["{spell:13637} to 200"] = "{spell:13637} hasta 200",
	-- ["{spell:13661} to 225"] = "{spell:13661} hasta 225",
	-- ["{spell:13746} to 255"] = "{spell:13746} hasta 255",
	-- ["{spell:13935} to 292"] = "{spell:13935} hasta 292",
	-- ["{spell:13948} to 300"] = "{spell:13948} hasta 300",
	-- ["{spell:7426} to 120"] = "{spell:7426} hasta 120",
	-- ["{spell:7428} to 75"] = "{spell:7428} hasta 75",
	-- ["{spell:7428} to 90"] = "{spell:7428} hasta 90",
	-- ["{spell:7788} to 130"] = "{spell:7788} hasta 130",
	-- ["{spell:7861} to 155"] = "{spell:7861} hasta 155",
}
