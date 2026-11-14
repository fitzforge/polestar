-- Spanish (Latin America) (esMX): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Reputación: Bastión Fauces de Madera",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "Paso seguro por los túneles, encantamientos de agilidad y recetas fúrbolg; el abalorio en Exaltado.",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "Recetas para peleteros, sastres, encantadores y alquimistas de Amistoso a Reverenciado",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "{faction:576} empieza en Hostil (2.500 de 3.000), así que sus fúrbolgs te atacan en sus túneles; {npc:11554}, {npc:15395} y {npc:11556} hablan con todos. {npc:11554} espera junto al camino en el sur de {zone:1448}, cerca de {area:2479}. Cada fúrbolg Muertobosque y Nevada que mates da 5 de reputación hasta el último punto de Honorable, así que las misiones de abajo pagan doble. La ventaja Diplomático del Legado suma hasta un 10% a cada ganancia.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "Los fúrbolgs Muertobosque (nivel 48-50) ocupan la aldea del extremo sur de {zone:1448}. Guarda cada {item:21377}: valen 10 de reputación cada una más adelante y nunca dejan de contar. {npc:9464} (15 de reputación) y el raro {npc:14342} (25) viven aquí y cuentan hasta Exaltado. Forever paga las misiones completas a cualquier nivel; en Classic los enemigos grises daban más o menos un quinto, alrededor de 1 por muerte para estos fúrbolgs a nivel 60. Hazlo mientras subes de nivel si puedes.",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "{npc:14342}, raro",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Vuelve con {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "{npc:15395} está en la boca del túnel de los Fauces de Madera del lado de {zone:1448}, en lo alto del camino del norte de {zone:1448}.",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "Los Muertobosque del norte (nivel 53-55) acampan justo al sur del túnel. Sueltan plumas más o menos la mitad de las veces: el mejor lugar para plumas. {npc:9462} da 15 hasta Exaltado.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Vuelve con {npc:15395}",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "Estas misiones y sus muertes te dejan justo por encima de Adverso (500 desde el inicio). Si {quest:8460} te pagó menos (a nivel 60 en Classic: 30), mata unos 40 Muertobosque del norte más. Desde Adverso, los Fauces de Madera del túnel te dejan en paz.",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "Cruza el túnel hasta su boca del lado de {zone:1452}; {npc:11556} está justo afuera. No ataques a ningún Fauces de Madera: cada uno cuesta 25 de reputación.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "{area:2244} está en el este de {zone:1452}, justo pasando {area:2255}. Guarda cada {item:21383} que saquees (10 de reputación cada una más adelante). Los chamanes, vigías del cubil y ursas comparten sus puntos de aparición, así que mata a todos los fúrbolgs de la aldea para que aparezcan los que necesitas; más ursas recorren la cresta justo al suroeste de la aldea. {npc:10199} (raro) y {npc:10738}, en la cueva del fondo, dan 25 hasta Exaltado. Alianza: Intrusión Nevada de los Entrenadores de sables de invierno pide los mismos chamanes y ursas.",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "{npc:10199}, raro",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "{npc:10738}, élite",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Vuelve con {npc:11556}",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "{quest:8466}, {quest:8467} y {quest:8469} ya están abiertas: 50 de reputación por 5 plumas o 5 cuentas, cuantas veces quieras. No las entregues todavía.",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "De Adverso a Neutral",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "De Adverso a Neutral son 3.000: unas 540 muertes más después de estas misiones. Tres campamentos: los Muertobosque del norte junto a la boca del túnel del lado de {zone:1448}; los campamentos Nevada alrededor de {area:2246} y {area:2243}, justo al sur y sureste de {npc:11556} (los exploradores dan 6 por muerte, los vigías del cubil y los totémicos 5, la caminata más corta hasta una entrega); y {area:2244} en el este. Elige el menos concurrido. Guarda todas las plumas y cuentas.",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "Plumas de tocado Muertobosque: guárdalas",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "{item:21383}: guárdalas",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "Exploradores Nevada, {area:2246}",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "Los Muertobosque del norte sueltan muy de vez en cuando un {quest:8470} (más o menos el 3%). Desde Neutral, {npc:11558} lo acepta en el túnel, del lado de {zone:1448}: 150 de reputación y dos pociones de sanación y de maná superiores.",

	-- Step 12: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "Los fúrbolgs Nevada sueltan muy de vez en cuando un {quest:8471} (3-4%). {npc:11558} también lo acepta en el túnel: 150 de reputación y tres pociones de sanación y de maná superiores.",

	-- Step 13: Neutral to Friendly
	["Neutral to Friendly"] = "De Neutral a Amistoso",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "De Neutral a Amistoso son 3.000: 600 muertes. Guarda todas las plumas y cuentas.",

	-- Step 14: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "{npc:11557} está en el túnel, cerca de su boca del lado de {zone:1448}. Desde Amistoso vende: {item:13484} (1 de oro 50 de plata), {item:22392} (2 de oro 50 de plata), {item:20253} (1 de oro 60 de plata) y {item:15065} (2 de oro). También acepta 30 {quest:6031} una vez por 100 de reputación y a elegir hombreras o guanteletes, y los sastres con 290 de habilidad pueden llevarle 2 {item:14342} por 100 más y el patrón de {item:15802}.",

	-- Step 15: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "{quest:6031} para {npc:11557}",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "{quest:6031} lo sueltan los humanoides de las zonas de nivel 50-60, entre ellos los fúrbolgs Muertobosque y Nevada.",

	-- Step 16: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "Sastres con 290 de habilidad: {npc:11557} acepta 2 {item:14342} una vez por 100 de reputación y enseña las {item:15802}.",

	-- Step 17: Friendly to Honored
	["Friendly to Honored"] = "De Amistoso a Honorable",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "De Amistoso a Honorable son 6.000: 1.200 muertes. Guarda todas las plumas y cuentas. Honorable abre con {npc:11557}: {item:19445} (3 de oro), y por 2 de oro 20 de plata cada uno {item:19202} y {item:19044} ({skill:165}) y {item:19047} ({skill:197}).",

	-- Step 18: Honored to Revered
	["Honored to Revered"] = "De Honorable a Reverenciado",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "De Honorable a Reverenciado son 12.000: 2.400 muertes, las últimas que cuentan. Las muertes dejan de contar en 11.999 de 12.000 en Honorable y nunca te hacen pasar a Reverenciado: cuando dejen de contar, entrega un juego de 5 plumas o cuentas para pasar. Guardar cada pluma y cuenta rinde ahora: unas 4.800 muertes desde el inicio hasta el final de Honorable te dejan con unas 2.100 plumas y cuentas, y eso es todo lo de Reverenciado a Exaltado. Entregarlas antes te costaría unas 2.400 muertes más.",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "{item:19445} ({skill:333}), 3 de oro",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "{quest:8467}: cuando dejen de contar las muertes, 5 plumas hasta Reverenciado",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "{quest:8469}: o 5 cuentas",

	-- Step 19: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "Las muertes dejaron de contar al final de Honorable. De Reverenciado a Exaltado son 21.000: 420 entregas, 2.100 plumas y cuentas. Entrega las plumas a {npc:15395} en el túnel o a {npc:11554} en el sur, y las cuentas a {npc:11556}, de cinco en cinco. Los fúrbolgs con nombre (Ror, Fauces Sangrientas, {npc:14342}, {npc:10199}, {npc:10738}) siguen contando. Reverenciado abre con {npc:11557}, por 4 de oro cada uno: {item:19204} y {item:19049} ({skill:165}) y {item:19050} ({skill:197}).",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "{quest:8467}: 5 plumas, 50 de reputación",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "{quest:8466}: 5 plumas, 50 de reputación",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "{quest:8469}: 5 cuentas, 50 de reputación",

	-- Step 20: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "En Exaltado, {npc:11555}, en el túnel junto a {npc:11557}, da {quest:8481}: coloca su {item:21144} en la entrada de la cueva de {npc:10738} y derrota al demonio {npc:15623} (nivel 62, élite: lleva un grupo). La recompensa es {item:21326}, un abalorio que invoca a un aliado Fauces de Madera, y 200 de reputación.",

	-- Step 21: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "{area:2244}, la cueva del fondo. Despeja primero los fúrbolgs de la entrada, coloca la antorcha, mata a {npc:15623} y saquea la Esencia de su bolsa demoníaca.",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "{npc:15623}, 25 de reputación",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Alterna entre plumas Muertobosque ({npc:15395}) y cuentas Nevada ({npc:11556}), según qué campamento esté menos concurrido.",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Los fúrbolgs Muertobosque (nivel 48-50) acampan en el extremo sur de {zone:1448}. Guarda cada {item:21377} que suelten: {npc:11554} y {npc:15395} los aceptan después.",
	-- ["Feathers and beads to Friendly"] = "Plumas y cuentas hasta Amistoso",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Plumas para {npc:11554}, Plumas para {npc:15395} (Plumas de penacho de Muertobosque) y Cuentas para {npc:11556} ({item:21383}) se repiten cuantas veces quieras; cada muerte de Muertobosque o Nevada también cuenta. {area:2244} es el mejor lugar para cuentas.",
	-- ["Feathers to Honored"] = "Plumas hasta Honorable",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Atraviesa {faction:576} hasta su salida a {zone:1452}; {npc:11556} está justo afuera. Las misiones y muertes hasta ahora suelen llegar a Adverso, y entonces los Fauces de Madera te dejan pasar. Si siguen en rojo, mata primero más Muertobosque junto al túnel.",
	-- ["Keep turning in feathers and beads until Exalted."] = "Sigue entregando plumas y cuentas hasta Exaltado.",
	-- ["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Los Muertobosque del norte (nivel 53-55) ocupan los campamentos justo al sur del túnel. Guarda también sus plumas.",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Los campamentos Muertobosque del norte junto al túnel son el mejor lugar para plumas (35% de probabilidad allí). Entrega las plumas a {npc:15395} en el túnel, o a {npc:11554} en el sur.",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244} está en el lado este de {zone:1452}. Guarda cada {item:21383} que obtengas: {npc:11556} los acepta.",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} empieza en Hostil, y sus fúrbolgs de los túneles atacan hasta que llegues a Adverso. Cada fúrbolg Muertobosque y Nevada que mates la sube, así que las misiones de abajo rinden el doble. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{faction:576} to Exalted"] = "{faction:576} hasta Exaltado",
	-- ["{faction:576} to Revered"] = "{faction:576} hasta Venerado",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: Cuentas para {npc:11556}",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} espera en el norte de {zone:1448}, en el túnel hacia {faction:576}.",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: Plumas para {npc:15395}",
}
