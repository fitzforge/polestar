-- German (deDE): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "Ruf: Gelkis und Magram (Zentauren)",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "Die verfeindeten Clans von {zone:1443}, in Forever überarbeitet: Such dir einen aus, kaufe seine Freundschaft und tausche Totems gegen Rezepte.",
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "12 Rezepte für Geschnitzte Zentaurentotems bei den Clan-Rüstmeistern, kein Rufrang nötig",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "{npc:5601}s Quest: ein Clantitel und die Wahl aus drei seltenen Waffen der Stufe 35",

	-- Step 1: Pick your clan
	["Pick your clan"] = "Such dir deinen Clan aus",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Forever pays these quests in full at any level."] = "Die Gelkis (im Südwesten von {zone:1443}) und die Magram (im Südosten) sind im Krieg: Jeder Kill an einem Clan gibt dem anderen 20 und kostet den eigenen Clan 100, du kannst also nur bei einem aufsteigen. Beide beginnen bei Neutral. Forevers Quests sind jetzt weit mehr wert als Kills, und die Wahl-Quests kosten den anderen Clan nichts mehr. Allianz: {npc:5396} in {area:608} bietet {quest:1382} (Gelkis) und {quest:1385} (Magram) an. Horde: {npc:5412}, östlich von Shadowprey, bietet {quest:1368} und {quest:1367} an. Nimm die Quest deines Clans und dessen Buying Friendship (3.000 fürs Liefern eines Beutels voller Totems), dann hake die Aufgabe ab. Der Guide geht bei den Gelkis weiter; nimmst du stattdessen die Quests der Magram, springt er in die Magram-Hälfte. Forever zahlt diese Quests auf jeder Stufe voll aus.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382}: Gelkis",
	["Take the quests of one clan"] = "Nimm die Quests eines Clans an",

	-- Step 2: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606}: {npc:5397} und {npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} liegt in den Hügeln im Südwesten von {zone:1443}; {npc:5397} steht in seiner Mitte. {npc:253140}, der Rüstmeister der Gelkis, ist am Südende des Dorfes. Allein Buying Friendship bringt dich von Neutral auf Freundlich.",

	-- Step 3: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "Gelkis: die Lager der Kolkar",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "Die Kolkar-Zentauren (Stufe 30-33) halten die Lager südlich von {area:608}, entlang der östlichen Straße. Etwa jeder vierte lässt ein {item:6079} fallen.",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079}: Kolkar-Zentauren",

	-- Step 4: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "Gelkis: {area:604}",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "Die Sacks of Meat liegen rund um {area:604}, im Südosten. Jeder Magram, den du unterwegs tötest, bringt den Gelkis 20.",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "{item:6069}: von den Sacks of Meat",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "{npc:4640}: 20 Gelkis",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "{npc:4641}: 20 Gelkis",

	-- Step 5: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "Gelkis: {quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "Zurück zu {npc:5397}, dann nach Osten in den {zone:1435}: {quest:1373} (Stufe 37) wartet an einem schwarzen Kessel in {area:76}, nordöstlich von {area:75}.",

	-- Step 6: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "Gelkis: Totems und Kills bis Wohlwollend",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 Carved Centaur Totems for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "Von Freundlich bis Wohlwollend sind es 6.000; nach den Quests des Clans bist du etwa 4.000 darin, es fehlen also 2.000. {npc:253140}s {quest:92812} nimmt 5 Geschnitzte Zentaurentotems für 750 an, immer wieder: drei Abgaben, 15 Totems. Die Maraudine-Zentauren (Stufe 36-40) im Westen von {zone:1443} lassen sie fallen; die Totems werden nicht gebunden, das Auktionshaus ist also die andere Quelle. Kills an den Magram bringen je 20, aber Forevers Kill-Daten stoppen sie am Ende von Freundlich, 1 vor Wohlwollend. Bei Freundlich hat das Dorf außerdem drei Handwerksaufträge für je 1.000: Halea will 3 Große mystische Essenzen, {npc:253140} eine {item:10008} (Schneiderei) und Talra ein {item:5739} (Lederverarbeitung). Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432}: Maraudine-Zentauren",

	-- Step 7: Gelkis: the Valley of Bones
	-- {quest:93034} Valley of Bones
	["Gelkis: the {quest:93034}"] = "Gelkis: das {quest:93034}",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:2652} Shen'dralas · {quest:93035} Ravaging Ravagers · {quest:93037} Outing Outcasts · {quest:93041} Facing the Truth · {npc:5601} Khan Jehn · {quest:92811} Economic Warfare
	["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "Bei Wohlwollend schickt dich {npc:5397} nach Osten zu {npc:253177} am südlichen Eingang des {quest:93034} in {zone:2652}. {npc:253177}s Quests (je 500) führen dich zu den Untoten und Ausgestoßenen dort: {quest:93035}, {quest:93037} und {quest:93041}, dann A Cleansing Cry von {npc:5397}, und eine zweite Reihe (Saving Our Own, Bone Burying, Checking Things Out), die mit {npc:5601} endet: Töte den Khan der Magram in seinem eigenen Dorf für 6.000, einen Titel und eine seltene Waffe der Stufe 35. Für alle musst du Wohlwollend oder besser bleiben. Von Wohlwollend bis Respektvoll sind es 12.000: Die Quests des Tals bringen davon etwa 10.600, zwei oder drei Abgaben von {quest:92811} den Rest.",

	-- Step 8: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "Gelkis: {npc:5601}",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "{npc:5601} (Stufe 37) führt die Magram von der Westseite von {area:604} aus an, mit seinen Leibwächtern. Der Kill kostet die Magram 500. {npc:5397} zahlt 6.000, einen Titel und die Wahl aus drei seltenen Waffen der Stufe 35: {item:271801} (Zweihandaxt: Stärke, Ausdauer, Beweglichkeit), {item:271802} (Einhandstreitkolben: Stärke, Ausdauer, Beweglichkeit) oder {item:271805} (Nebenhand: Willenskraft, Intelligenz, Ausdauer).",

	-- Step 9: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "Gelkis: Totems bis Ehrfürchtig",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "Ab Respektvoll bleibt nur noch {quest:92812}: Von Respektvoll bis Ehrfürchtig sind es 21.000, 28 Abgaben, 140 Totems. Für Ruf wird nichts verkauft; die Rezepte unten brauchen nur Totems.",

	-- Step 10: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604}: {npc:5398} und {npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} füllt das Tal im Südosten von {zone:1443}; {npc:5398} steht an seiner Nordseite, {npc:253139}, der Rüstmeister der Magram, am See. Allein Buying Friendship bringt dich von Neutral auf Freundlich.",

	-- Step 11: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "Magram: die Lager der Kolkar",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "Die Kolkar-Zentauren (Stufe 30-33) halten die Lager südlich von {area:608}.",

	-- Step 12: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "Magram: {quest:1369}",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "Die Tears of Theradras sind Kristalle in der Höhle hinter {area:606}, im Südwesten. Jeder Gelkis, den du unterwegs tötest, bringt den Magram 20.",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "{quest:1369}: die Kristalle ({object:22246})",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "{npc:4648}: 20 Magram",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "{npc:4649}: 20 Magram",

	-- Step 13: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "Magram: {quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} will einen {item:4392}: Ingenieure stellen ihn her (4 {item:4234}, ein {item:4389}, ein {item:4382} und eine {item:4387}); alle anderen kaufen einen. Er zahlt 1.000 und die Wahl aus zwei Ingenieurskunst-Bauplänen, dem {item:269900} oder dem {item:269902}.",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392}: von Ingenieuren hergestellt oder gekauft",

	-- Step 14: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "Magram: Totems und Kills bis Wohlwollend",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 Carved Centaur Totems for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "Von Freundlich bis Wohlwollend sind es 6.000; nach den Quests des Clans bist du etwa 3.000 darin (4.000 mit {quest:1371}), es fehlen also 2.000 bis 3.000. {npc:253139}s {quest:92811} nimmt 5 Geschnitzte Zentaurentotems für 750 an, immer wieder; die Maraudine-Zentauren (Stufe 36-40) im Westen von {zone:1443} lassen sie fallen, und die Totems werden nicht gebunden, das Auktionshaus ist also die andere Quelle. Kills an den Gelkis bringen je 20, aber Forevers Kill-Daten stoppen sie am Ende von Freundlich, 1 vor Wohlwollend. Bei Freundlich hat das Dorf zwei Handwerksaufträge für je 1.000: Mirdas 3 Große Schattenschutztränke und Grolkars 2 Massive Eisenäxte (Schmiedekunst). {npc:5398}s {quest:92743} (1.000) ist kein Handwerksauftrag: Er will einen {item:254392} aus einer Gruft in den {zone:1418}, und Forevers Questseiten setzen ihn in seiner Reihe vor das {quest:92841}, bring ihn also mit, bevor du Wohlwollend erreichst. Vermächtnis-Vorteil „Diplomat“ gibt bis zu 10 % mehr.",

	-- Step 15: Magram: the Valley of Bones
	-- {quest:92841} Valley of Bones
	["Magram: the {quest:92841}"] = "Magram: das {quest:92841}",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {quest:92841} Valley of Bones · {zone:2652} Shen'dralas · {quest:92844} Mountain of Bones · {quest:92846} Outcast Necromancers · {area:16675} Magram Front · {area:16677} Bristleback Retreat · {npc:5601} Khan Jehn · {area:604} Magram Village · {quest:92811} Economic Warfare
	["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "Bei Wohlwollend und nach {quest:92743} schickt dich {npc:5398} zu {npc:253136} am nördlichen Eingang des {quest:92841} in {zone:2652}. {npc:253136}s Quests (je 500: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) und die von Hagiak an der {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) enden mit {npc:5601}: Erwecke den toten Khan mit {npc:253136}s Stab am Zelt beim See in {area:604}, für 6.000, einen Titel und eine seltene Waffe der Stufe 35. Für alle musst du Wohlwollend oder besser bleiben. Von Wohlwollend bis Respektvoll sind es 12.000: Die Quests des Tals bringen davon etwa 11.000, zwei Abgaben von {quest:92811} den Rest.",

	-- Step 16: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "Magram: {quest:93196}",
	-- {area:604} Magram Village · {npc:253136} Orgrul · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "Der Ritualplatz ist ein Zelt am See in der Mitte von {area:604}. {npc:253136} zahlt 6.000, einen Titel und die Wahl aus drei seltenen Waffen der Stufe 35: {item:271800} (Stangenwaffe: Ausdauer, Angriffskraft, Beweglichkeit), {item:271803} (Stab: Intelligenz, Ausdauer, Willenskraft) oder {item:271804} (Streitkolben, Haupthand: Intelligenz, Ausdauer, Willenskraft).",

	-- Step 17: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "Magram: Totems bis Ehrfürchtig",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "Ab Respektvoll bleibt nur noch {quest:92811}: Von Respektvoll bis Ehrfürchtig sind es 21.000, 28 Abgaben, 140 Totems.",

	-- Step 18: The totem recipes
	["The totem recipes"] = "Die Totem-Rezepte",
	-- {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["Both quartermasters sell the same 12 recipes for Carved Centaur Totems, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Beide Rüstmeister verkaufen dieselben 12 Rezepte für Geschnitzte Zentaurentotems, kein Rufrang nötig: {item:273613} und - Lesser Healing Power; Greater Spellblasting und {item:250941}; {item:250538}- und {item:250606}-Pläne; die Muster {item:252462}, {item:253973}, {item:10011} und {item:274490}; die Baupläne {item:269900} und {item:269902}. Behalte die Totems, die du dafür brauchst, bevor du den Rest abgibst.",
}
