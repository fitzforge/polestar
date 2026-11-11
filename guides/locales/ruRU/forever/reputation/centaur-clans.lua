-- Russian (ruRU): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "Репутация с кентаврами Гелкис и Маграм",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "Враждующие кланы зоны {zone:1443}, переработанные в Forever: выберите один, купите его дружбу и обменивайте тотемы на рецепты.",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "12 рецептов за {quest:93224} у интендантов племен, репутация не требуется",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "Задание NPC {npc:5601}: звание клана и выбор одного из трех редких видов оружия 35-го уровня",

	-- Step 1: Pick your clan
	["Pick your clan"] = "",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "Гелкис (юго-запад зоны {zone:1443}) и Маграм (юго-восток) воюют: каждое убийство члена одного племени дает другому 20 и отнимает 100 у его собственного, так что подниматься можно только с одним. Оба начинают с «Равнодушия». Задания Forever теперь дают гораздо больше, чем убийства, а задания выбора больше ничего не стоят другому племени. Альянс: {npc:5396} ({area:608}) предлагает {quest:1382} (Гелкис) и {quest:1385} (Маграм). Орда: {npc:5412} предлагает {quest:1368} и {quest:1367}. Возьмите задание своего племени и {quest:93224}: «Buying Friendship» каждого племени (3000) предлагается, когда вы принесете тотемы. Затем отметьте задачу. Гайд продолжает с Гелкис; если взять вместо этого задания Маграм, он перейдет к половине Маграм. Forever платит за эти задания полностью на любом уровне.",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "",
	["Take the quests of one clan"] = "",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "Кентавры из племени Колкар (30-33 уровень) в лагерях вдоль восточной дороги, к югу от места {area:608}, роняют тотемы, как и Маграм и Мародин. Принесите пять, затем возьмите «Buying Friendship» своего племени (Гелкис – ниже; для Маграм – их задание).",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}: кентавры из племени Колкар",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "Гелкис или Маграм",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "В журнале нет заданий племени: гайд продолжает с Гелкис. Для Маграм возьмите их задание выбора и «Buying Friendship», и гайд перейдет к половине Маграм.",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "Гелкис: задание выбора",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "Половина Гелкис начинается с задания выбора племени у того, кому вы только что сдали тотемы: из него вытекают задания NPC {npc:5397} ({area:606}), а одно «Buying Friendship» их не открывает.",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "От «Дружелюбия» до «Уважения» – 6000; после заданий племени у вас около 4000 из них, так что осталось 2000. {quest:92812} от NPC {npc:253140} принимает 5 {quest:93224} за 750, снова и снова: три сдачи, 15 тотемов. Их роняют кентавры из племени Мародин (36-40 уровень) на западе зоны {zone:1443}; тотемы не становятся персональными, так что другой источник – аукцион. Убийства Маграм дают по 20, но по данным Forever об убийствах они перестают засчитываться в конце «Дружелюбия», за 1 до «Уважения». При «Дружелюбии» в деревне есть еще три заказа на изготовление по 1000: Halea просит 3 великие таинственные субстанции, {npc:253140} – {item:10008} (портняжное дело), а Talra – {item:5739} (кожевничество). «Дипломат» из Наследия добавляет до 10%.",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "",

	-- Step 10: Gelkis: the Valley of Bones
	-- {quest:93034} Valley of Bones
	["Gelkis: the {quest:93034}"] = "",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:2652} Shen'dralas · {quest:93035} Ravaging Ravagers · {quest:93037} Outing Outcasts · {quest:93041} Facing the Truth · {npc:5601} Khan Jehn · {quest:92811} Economic Warfare
	["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "",

	-- Step 11: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "",

	-- Step 12: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "",

	-- Step 13: Gelkis done
	["Gelkis done"] = "Гелкис: готово",
	["No Gelkis quests done: on to the Magram, south-east."] = "Задания Гелкис не выполнены: переходим к Маграм, на юго-восток.",

	-- Step 14: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 15: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "",

	-- Step 16: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "",

	-- Step 17: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "",

	-- Step 18: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "От «Дружелюбия» до «Уважения» – 6000; после заданий племени у вас около 3000 из них (4000 с заданием {quest:1371}), так что осталось от 2000 до 3000. {quest:92811} от NPC {npc:253139} принимает 5 {quest:93224} за 750, снова и снова; их роняют кентавры из племени Мародин (36-40 уровень) на западе зоны {zone:1443}, а тотемы не становятся персональными, так что другой источник – аукцион. Убийства Гелкис дают по 20, но по данным Forever об убийствах они перестают засчитываться в конце «Дружелюбия», за 1 до «Уважения». При «Дружелюбии» в деревне есть два заказа на изготовление по 1000: 3 сильных зелья защиты от темной магии для Mirda и 2 массивных железных топора для Grolkar (кузнечное дело). {quest:92743} от NPC {npc:5398} (1000) – не заказ на изготовление: ему нужен {item:254392} из склепа в зоне {zone:1418}, и по страницам заданий Forever он стоит в его цепочке перед заданием {quest:92841}, так что принесите его до «Уважения». «Дипломат» из Наследия добавляет до 10%.",

	-- Step 19: Magram: the Valley of Bones
	-- {quest:92841} Valley of Bones
	["Magram: the {quest:92841}"] = "",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {quest:92841} Valley of Bones · {zone:2652} Shen'dralas · {quest:92844} Mountain of Bones · {quest:92846} Outcast Necromancers · {area:16675} Magram Front · {area:16677} Bristleback Retreat · {npc:5601} Khan Jehn · {area:604} Magram Village · {quest:92811} Economic Warfare
	["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "",

	-- Step 20: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "",
	-- {area:604} Magram Village · {npc:253136} Orgrul · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "",

	-- Step 21: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "",

	-- Step 22: The totem recipes
	["The totem recipes"] = "",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "Оба интенданта продают одни и те же 12 рецептов за {quest:93224}, репутация не требуется: {item:273613} и малая целительная сила; сильное зелье взрывных чар и {item:250941}; чертежи: {item:250538} и {item:250606}; выкройки: {item:252462}, {item:253973}, {item:10011} и {item:274490}; схемы: {item:269900} и {item:269902}. Оставьте нужные для них тотемы, прежде чем сдавать остальные.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "12 рецептов резных тотемов кентавров ({item:254432}) у интендантов кланов, репутация не требуется",
}
