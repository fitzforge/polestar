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
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Vuelve con {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Vuelve con {npc:15395}",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Vuelve con {npc:11556}",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "",

	-- Step 12: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "",

	-- Step 13: Neutral to Friendly
	["Neutral to Friendly"] = "",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "",

	-- Step 14: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "",

	-- Step 15: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "",

	-- Step 16: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "",

	-- Step 17: Friendly to Honored
	["Friendly to Honored"] = "",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "",

	-- Step 18: Honored to Revered
	["Honored to Revered"] = "",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "",

	-- Step 19: Revered to Exalted
	["Revered to Exalted"] = "",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "",

	-- Step 20: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "",

	-- Step 21: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "",

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
