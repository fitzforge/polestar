-- French (frFR): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "Réputation : centaures Gelkis et Magram",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "Les clans rivaux de {zone:1443}, remaniés dans Forever : choisissez-en un, achetez son amitié et échangez des totems contre des recettes.",
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "12 recettes contre des totems centaures sculptés chez les intendants des clans, sans réputation requise",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "La quête de {npc:5601} : un titre de clan et le choix entre trois armes rares de niveau 35",

	-- Step 1: Pick your clan
	["Pick your clan"] = "Choisissez votre clan",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Forever pays these quests in full at any level."] = "",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382} : Gelkis",
	["Take the quests of one clan"] = "Acceptez les quêtes d'un seul clan",

	-- Step 2: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606} : {npc:5397} et {npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} se trouve dans les collines du sud-ouest de {zone:1443} ; {npc:5397} se tient en son centre. {npc:253140}, l'intendant des Gelkis, est à l'extrémité sud du village. Buying Friendship seul vous fait passer de Neutre à Amical.",

	-- Step 3: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "Gelkis : les camps kolkar",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "Les centaures kolkar (niveau 30-33) tiennent les camps au sud de {area:608}, le long de la route de l'est. Environ un sur quatre laisse un {item:6079}.",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079} : centaures kolkar",

	-- Step 4: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "Gelkis : {area:604}",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "Les sacs de viande sont éparpillés dans {area:604}, au sud-est. Chaque Magram tué en chemin rapporte 20 aux Gelkis.",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "{item:6069} : sacs de viande",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "{npc:4640} : 20 Gelkis",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "{npc:4641} : 20 Gelkis",

	-- Step 5: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "Gelkis : {quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "Retournez voir {npc:5397}, puis allez à l'est dans le {zone:1435} : {quest:1373} (niveau 37) attend près d'un chaudron noir à {area:76}, au nord-est de {area:75}.",

	-- Step 6: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "Gelkis : totems et victimes jusqu'à Honoré",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 Carved Centaur Totems for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "D'Amical à Honoré, il faut 6 000 ; après les quêtes du clan, vous en avez environ 4 000, donc il en reste 2 000. {quest:92812} de {npc:253140} prend 5 totems centaures sculptés contre 750, encore et encore : trois remises, 15 totems. Les centaures maraudine (niveau 36-40) de l'ouest de {zone:1443} en laissent ; les totems ne sont pas liés, donc l'hôtel des ventes est l'autre source. Les Magram tués ajoutent 20 chacun, mais les données de victimes de Forever les arrêtent à la fin d'Amical, à 1 point d'Honoré. À Amical, le village a aussi trois commandes d'artisanat à 1 000 chacune : Halea veut 3 essences mystiques supérieures, {npc:253140} un {item:10008} (couture) et Talra un {item:5739} (travail du cuir). Diplomate de l'Héritage ajoute jusqu'à 10 %.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432} : centaures maraudine",

	-- Step 7: Gelkis: the Valley of Bones
	-- {quest:93034} Valley of Bones
	["Gelkis: the {quest:93034}"] = "Gelkis : {quest:93034}",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:2652} Shen'dralas · {quest:93035} Ravaging Ravagers · {quest:93037} Outing Outcasts · {quest:93041} Facing the Truth · {npc:5601} Khan Jehn · {quest:92811} Economic Warfare
	["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "À Honoré, {npc:5397} vous envoie à l'est auprès de {npc:253177}, à l'entrée sud de {quest:93034}, à {zone:2652}. Les quêtes de {npc:253177} (500 chacune) vous mènent parmi les morts-vivants et les exilés : {quest:93035}, {quest:93037} et {quest:93041}, puis A Cleansing Cry de {npc:5397}, et une seconde série (Saving Our Own, Bone Burying, Checking Things Out) qui se termine par {npc:5601} : tuez le khan des Magram dans son propre village pour 6 000, un titre et une arme rare de niveau 35. Toutes demandent de rester Honoré ou mieux. D'Honoré à Révéré, il faut 12 000 : les quêtes de la vallée en rapportent environ 10 600, deux ou trois remises de {quest:92811} le reste.",

	-- Step 8: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "Gelkis : {npc:5601}",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "{npc:5601} (niveau 37) dirige les Magram depuis le côté ouest de {area:604}, avec ses gardes du corps. Le tuer coûte 500 auprès des Magram. {npc:5397} paie 6 000, un titre et le choix entre trois armes rares de niveau 35 : {item:271801} (hache à deux mains : Force, Endurance, Agilité), {item:271802} (masse à une main : Force, Endurance, Agilité) ou {item:271805} (main gauche : Esprit, Intelligence, Endurance).",

	-- Step 9: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "Gelkis : totems jusqu'à Exalté",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "À partir de Révéré, il ne reste que {quest:92812} : de Révéré à Exalté, il faut 21 000, 28 remises, 140 totems. Rien n'est vendu contre de la réputation ; les recettes ci-dessous ne demandent que des totems.",

	-- Step 10: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604} : {npc:5398} et {npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} occupe la vallée du sud-est de {zone:1443} ; {npc:5398} se tient au nord, {npc:253139}, l'intendant des Magram, près du lac. Buying Friendship seul vous fait passer de Neutre à Amical.",

	-- Step 11: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "Magram : les camps kolkar",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "Les centaures kolkar (niveau 30-33) tiennent les camps au sud de {area:608}.",

	-- Step 12: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "Magram : {quest:1369}",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "Les Larmes de Theradras sont des cristaux dans la grotte derrière {area:606}, au sud-ouest. Chaque Gelkis tué en chemin rapporte 20 aux Magram.",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "{quest:1369} : les cristaux de {object:22246}",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "{npc:4648} : 20 Magram",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "{npc:4649} : 20 Magram",

	-- Step 13: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "Magram : {quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} veut un {item:4392} : les ingénieurs le fabriquent (4 {item:4234}, un {item:4389}, une {item:4382} et une {item:4387}) ; les autres en achètent un. Il rapporte 1 000 et le choix entre deux schémas d'ingénierie, le {item:269900} ou la {item:269902}.",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392} : fabriqué par les ingénieurs, ou acheté",

	-- Step 14: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "Magram : totems et victimes jusqu'à Honoré",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 Carved Centaur Totems for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "D'Amical à Honoré, il faut 6 000 ; après les quêtes du clan, vous en avez environ 3 000 (4 000 avec {quest:1371}), donc il en reste 2 000 à 3 000. {quest:92811} de {npc:253139} prend 5 totems centaures sculptés contre 750, encore et encore ; les centaures maraudine (niveau 36-40) de l'ouest de {zone:1443} en laissent, et les totems ne sont pas liés, donc l'hôtel des ventes est l'autre source. Les Gelkis tués ajoutent 20 chacun, mais les données de victimes de Forever les arrêtent à la fin d'Amical, à 1 point d'Honoré. À Amical, le village a deux commandes d'artisanat à 1 000 chacune : 3 potions de protection contre l'Ombre supérieure pour Mirda et 2 gigantesques haches en fer pour Grolkar (forge). {quest:92743} de {npc:5398} (1 000) n'est pas une commande d'artisanat : il veut un {item:254392} pris dans une crypte des {zone:1418}, et les pages de quêtes de Forever la placent dans sa suite avant {quest:92841} ; apportez-le donc avant d'atteindre Honoré. Diplomate de l'Héritage ajoute jusqu'à 10 %.",

	-- Step 15: Magram: the Valley of Bones
	-- {quest:92841} Valley of Bones
	["Magram: the {quest:92841}"] = "Magram : {quest:92841}",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {quest:92841} Valley of Bones · {zone:2652} Shen'dralas · {quest:92844} Mountain of Bones · {quest:92846} Outcast Necromancers · {area:16675} Magram Front · {area:16677} Bristleback Retreat · {npc:5601} Khan Jehn · {area:604} Magram Village · {quest:92811} Economic Warfare
	["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "À Honoré, et après {quest:92743}, {npc:5398} vous envoie auprès d'{npc:253136}, à l'entrée nord de {quest:92841}, à {zone:2652}. Les quêtes d'{npc:253136} (500 chacune : {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) et celles de Hagiak au {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) se terminent par {npc:5601} : relevez le khan mort avec le bâton d'{npc:253136} à la tente près du lac de {area:604}, pour 6 000, un titre et une arme rare de niveau 35. Toutes demandent de rester Honoré ou mieux. D'Honoré à Révéré, il faut 12 000 : les quêtes de la vallée en rapportent environ 11 000, deux remises de {quest:92811} le reste.",

	-- Step 16: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "Magram : {quest:93196}",
	-- {area:604} Magram Village · {npc:253136} Orgrul · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "Le site du rituel est une tente près du lac, au milieu de {area:604}. {npc:253136} paie 6 000, un titre et le choix entre trois armes rares de niveau 35 : {item:271800} (arme d'hast : Endurance, puissance d'attaque, Agilité), {item:271803} (bâton : Intelligence, Endurance, Esprit) ou {item:271804} (masse de main droite : Intelligence, Endurance, Esprit).",

	-- Step 17: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "Magram : totems jusqu'à Exalté",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "À partir de Révéré, il ne reste que {quest:92811} : de Révéré à Exalté, il faut 21 000, 28 remises, 140 totems.",

	-- Step 18: The totem recipes
	["The totem recipes"] = "Les recettes à totems",
	-- {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["Both quartermasters sell the same 12 recipes for Carved Centaur Totems, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Les deux intendants vendent les mêmes 12 recettes contre des totems centaures sculptés, sans réputation requise : {item:273613} et - Puissance de soins inférieure ; Explosion de sorts supérieure et {item:250941} ; les plans de {item:250538} et de {item:250606} ; les patrons de {item:252462}, {item:253973}, {item:10011} et {item:274490} ; les schémas du {item:269900} et de la {item:269902}. Gardez les totems dont vous avez besoin pour elles avant de rendre le reste.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Do the clan's quests by level 50 if you can: in Classic a quest pays less once it is 6 or more levels below you, down to a fifth."] = "Les Gelkis (sud-ouest de {zone:1443}) et les Magram (sud-est) sont en guerre : chaque victime d'un clan donne 20 à l'autre et coûte 100 à son propre clan, donc vous ne pouvez monter qu'avec un seul. Les deux commencent à Neutre. Dans Forever, les quêtes valent maintenant bien plus que les victimes, et les quêtes de choix ne coûtent plus rien à l'autre clan. Alliance : le {npc:5396} à {area:608} propose {quest:1382} (Gelkis) et {quest:1385} (Magram). Horde : {npc:5412}, à l'est de Proie-de-l'ombre, propose {quest:1368} et {quest:1367}. Acceptez celle de votre clan et son Buying Friendship (3 000 pour porter un sac de totems), puis cochez la tâche. Le guide continue avec les Gelkis ; acceptez plutôt les quêtes des Magram et il passe à la partie Magram. Faites les quêtes du clan avant le niveau 50 si possible : dans Classic, une quête rapporte moins une fois qu'elle est 6 niveaux ou plus sous le vôtre, jusqu'à un cinquième.",
}
