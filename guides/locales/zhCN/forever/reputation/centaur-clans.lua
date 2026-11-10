-- Chinese (simplified) (zhCN): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "吉尔吉斯和玛格拉姆半人马声望",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "{zone:1443}的敌对部族，在无限中经过重制：选择其一，换取其友谊，并用图腾交换配方。",
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["12 recipes for Carved Centaur Totems at the clan quartermasters, no standing needed"] = "部族军需官处可用{item:254432}兑换12种配方，无需声望",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "{npc:5601}的任务：一个部族头衔，以及三把35级稀有武器任选其一",

	-- Step 1: Pick your clan
	["Pick your clan"] = "选择氏族",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Forever pays these quests in full at any level."] = "",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "{quest:1382}：吉尔吉斯",
	["Take the quests of one clan"] = "接取一个氏族的任务",

	-- Step 2: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "{area:606}：{npc:5397}和{npc:253140}",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:606} 位于 {zone:1443} 西南的山中；{npc:5397} 站在村子中心。吉尔吉斯军需官 {npc:253140} 在村子南端。仅完成“收买友谊：吉尔吉斯”就能从中立升到友善。",

	-- Step 3: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "吉尔吉斯：科卡尔营地",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "科尔卡半人马（30-33级）占据了{area:608}南面、东侧道路沿线的营地。约四分之一会掉落{item:6079}。",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "{item:6079}：科尔卡半人马",

	-- Step 4: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "吉尔吉斯：{area:604}",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "肉袋散落在东南方的{area:604}。沿途每杀一个玛格拉姆半人马，都会获得20吉尔吉斯声望。",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "{item:6069}：一袋肉",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "{npc:4640}：20 点吉尔吉斯声望",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "{npc:4641}：20 点吉尔吉斯声望",

	-- Step 5: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "吉尔吉斯：{quest:1373}",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "回到{npc:5397}处，然后向东前往{zone:1435}：{quest:1373}（37级）在{area:75}东北方的{area:76}，一口黑色大锅旁等候。",

	-- Step 6: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "吉尔吉斯：交还图腾并击杀敌人至尊敬",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 Carved Centaur Totems for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "友善到尊敬需要6,000；完成氏族任务后约已有4,000，还差2,000。{npc:253140}的{quest:92812}每次收取5个雕刻半人马图腾，奖励750声望，可反复交还：共需三次、15个图腾。{zone:1443}西部的玛洛迪半人马（36-40级）会掉落；图腾不绑定，因此也可从拍卖行购买。每杀一个玛格拉姆半人马增加20，但无限服的击杀数据将上限设在友善末尾，距尊敬还差1点。友善时，村里还会开放三项制作订单，每项奖励1,000：Halea需要3个强效秘法精华，{npc:253140}需要一件{item:10008}（裁缝），Talra需要一件{item:5739}（制皮）。传承的外交家最多增加10%。",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "{item:254432}：玛洛迪半人马。",

	-- Step 7: Gelkis: the Valley of Bones
	-- {quest:93034} Valley of Bones
	["Gelkis: the {quest:93034}"] = "吉尔吉斯：{quest:93034}",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:2652} Shen'dralas · {quest:93035} Ravaging Ravagers · {quest:93037} Outing Outcasts · {quest:93041} Facing the Truth · {npc:5601} Khan Jehn · {quest:92811} Economic Warfare
	["At Honored, {npc:5397} sends you east to {npc:253177} at the southern entrance of the {quest:93034}, in {zone:2652}. {npc:253177}'s quests (500 each) take you among the undead and the outcasts there: {quest:93035}, {quest:93037} and {quest:93041}, then A Cleansing Cry from {npc:5397}, and a second line (Saving Our Own, Bone Burying, Checking Things Out) that ends with {npc:5601}: kill the Magram khan in his own village for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 10,600 of it, two or three {quest:92811} turn-ins the rest."] = "尊敬后，{npc:5397} 会让你向东，去 {zone:2652} 的 {quest:93034} 南入口找 {npc:253177}。{npc:253177} 的任务（每个 500 点）会让你深入当地亡灵和流放者之间：{quest:93035}、{quest:93037} 和 {quest:93041}，然后是 {npc:5397} 的 A Cleansing Cry，以及另一条任务线（Saving Our Own、Bone Burying、Checking Things Out），最后要对付 {npc:5601}：在玛格拉姆村内杀死他们的可汗，奖励 6,000 点声望、一个头衔和一件 35 级稀有武器。所有任务都要求保持尊敬或更高声望。尊敬到崇敬需要 12,000 点：山谷任务共奖励约 10,600 点，其余通过交还两三次 {quest:92811} 补足。",

	-- Step 8: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "吉尔吉斯：{npc:5601}。",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	["{npc:5601} (level 37) leads the Magram from the west side of {area:604}, with his bodyguards. The kill costs the Magram 500. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina)."] = "{npc:5601}（37级）带着保镖，在 {area:604} 西侧统领玛格拉姆。击杀他会降低500点玛格拉姆声望。{npc:5397} 会奖励6,000点声望、一个头衔，以及三件35级稀有武器中的一件：{item:271801}（双手斧：力量、耐力、敏捷）、{item:271802}（单手锤：力量、耐力、敏捷）或 {item:271805}（副手：精神、智力、耐力）。",

	-- Step 9: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "吉尔吉斯：交图腾到崇拜",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "达到崇敬后，只剩{quest:92812}：崇敬到崇拜需要21,000，即交还28次、140个图腾。声望等级不会解锁商品；下方配方仅需图腾。",

	-- Step 10: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "{area:604}：{npc:5398}和{npc:253139}",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "{area:604} 占据了 {zone:1443} 东南部的山谷；{npc:5398} 站在北侧，玛格拉姆军需官 {npc:253139} 则在湖边。单靠“收买友谊：玛格拉姆”就能从中立升到友善。",

	-- Step 11: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "玛格拉姆：科尔卡营地",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "科尔卡半人马（30—33级）占据着 {area:608} 南边的营地。",

	-- Step 12: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "玛格拉姆：{quest:1369}",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "瑟莱德丝之泪是西南部 {area:606} 后方洞穴中的水晶。沿途每击杀一名吉尔吉斯半人马，可获得 20 点玛格拉姆声望。",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "{quest:1369}：{object:22246}水晶",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "{npc:4648}：20名玛格拉姆半人马",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "{npc:4649}：20名玛格拉姆半人马",

	-- Step 13: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "玛格拉姆：{quest:1371}",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "{npc:5398} 需要一个 {item:4392}：工程师可以制作（4 个 {item:4234}、一个 {item:4389}、一个 {item:4382} 和一个 {item:4387}）；其他人则购买一个。奖励 1,000 点声望，还可在两张工程学结构图中选择一张：{item:269900} 或 {item:269902}。",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "{item:4392}：工程师制造，或购买",

	-- Step 14: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "玛格拉姆：交图腾并击杀敌人至尊敬",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem · Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 Carved Centaur Totems for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "友善到尊敬需要 6,000 点；完成部族任务后大约已有 3,000 点（做了 {quest:1371} 则有 4,000 点），还差 2,000 至 3,000 点。{npc:253139} 的 {quest:92811} 可反复交还，每次收取 5 个雕刻半人马图腾，奖励 750 点；图腾由 {zone:1443} 西部的玛洛迪半人马（36-40 级）掉落，不绑定，也可以从拍卖行购买。击杀吉尔吉斯每名增加 20 点，但无限的击杀数据表明，到友善末尾、差 1 点尊敬时就会停止。友善后村里有两个制造订单，每个奖励 1,000 点：Mirda 要 3 瓶强效暗影防护药水，Grolkar 要 2 把巨型铁斧（锻造）。{npc:5398} 的 {quest:92743}（1,000 点）不是制造订单：他需要 {zone:1418} 一处墓穴里的 {item:254392}，无限任务页面将它放在 {quest:92841} 之前的任务链中，所以尊敬前就带来。传承天赋“外交家”最多额外提高 10%。",

	-- Step 15: Magram: the Valley of Bones
	-- {quest:92841} Valley of Bones
	["Magram: the {quest:92841}"] = "玛格拉姆：{quest:92841}",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {quest:92841} Valley of Bones · {zone:2652} Shen'dralas · {quest:92844} Mountain of Bones · {quest:92846} Outcast Necromancers · {area:16675} Magram Front · {area:16677} Bristleback Retreat · {npc:5601} Khan Jehn · {area:604} Magram Village · {quest:92811} Economic Warfare
	["At Honored, and after {quest:92743}, {npc:5398} sends you to {npc:253136} at the northern entrance of the {quest:92841}, in {zone:2652}. {npc:253136}'s quests (500 each: {quest:92844}, {quest:92846}, Corrupting Tears, Proof of Concept, No Mercy for the Weak, Bone Raising) and Hagiak's at the {area:16675} ({area:16677}, Long-Term Solutions, Threat of Starvation, Return to {npc:253136}) end with {npc:5601}: raise the dead khan with {npc:253136}'s staff at the tent by the lake in {area:604}, for 6,000, a title and a rare level 35 weapon. They all ask you to stay Honored or better. Honored to Revered is 12,000: the valley's quests pay about 11,000 of it, two {quest:92811} turn-ins the rest."] = "达到尊敬并完成{quest:92743}后，{npc:5398}会派你去找{zone:2652}的{quest:92841}北部入口处的{npc:253136}。{npc:253136}的任务（每个500声望：{quest:92844}、{quest:92846}、Corrupting Tears、Proof of Concept、No Mercy for the Weak、Bone Raising），以及{area:16675}的Hagiak提供的任务（{area:16677}、长远之计、断粮之危、返回{npc:253136}），最终都通向{npc:5601}：在{area:604}湖边帐篷旁，用{npc:253136}的法杖复活死去的可汗，获得6,000声望、一个头衔和一件35级精良武器。这些任务都要求保持尊敬或更高声望。尊敬到崇敬需要12,000：山谷任务约奖励11,000，其余通过交还两次{quest:92811}补足。",

	-- Step 16: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "玛格拉姆：{quest:93196}",
	-- {area:604} Magram Village · {npc:253136} Orgrul · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["The ritual site is a tent by the lake in the middle of {area:604}. {npc:253136} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit)."] = "仪式地点是{area:604}中央湖边的一顶帐篷。{npc:253136}奖励6,000声望、一个头衔，以及三件35级精良武器任选一件：{item:271800}（长柄武器：耐力、攻击强度、敏捷）、{item:271803}（法杖：智力、耐力、精神）或{item:271804}（主手锤：智力、耐力、精神）。",

	-- Step 17: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "玛格拉姆：交图腾至崇拜",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "崇敬后只剩 {quest:92811}：崇敬到崇拜需要 21,000 点，即交还 28 次，共 140 个图腾。",

	-- Step 18: The totem recipes
	["The totem recipes"] = "图腾配方",
	-- {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	-- plural, as words: Carved Centaur Totems = {item:254432} Carved Centaur Totem
	["Both quartermasters sell the same 12 recipes for Carved Centaur Totems, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "两名军需官都出售相同的12种配方，用雕刻半人马图腾兑换，无声望等级要求：{item:273613}和 次级治疗强度；强效法术爆破 和{item:250941}；{item:250538}和{item:250606}图纸；{item:252462}、{item:253973}、{item:10011}和{item:274490}图样；以及{item:269900}和{item:269902}结构图。先留足兑换所需图腾，再交还其余的。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now, and the choice quests no longer cost the other clan anything. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412}, east of Shadowprey, offers {quest:1368} and {quest:1367}. Take the one of your clan and its Buying Friendship (3,000 for carrying a tote of totems), then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it jumps to the Magram half. Do the clan's quests by level 50 if you can: in Classic a quest pays less once it is 6 or more levels below you, down to a fifth."] = "吉尔吉斯（{zone:1443} 西南）与玛格拉姆（东南）正在交战：每杀一名某部族成员，会给另一部族增加 20 点声望，同时扣除被杀部族 100 点，因此只能提升其中一方。两者初始都是中立。现在无限的任务奖励远高于击杀，而且选择部族的任务已不会扣除另一方声望。联盟：{area:608} 的 {npc:5396} 提供 {quest:1382}（吉尔吉斯）和 {quest:1385}（玛格拉姆）。部落：葬影村东边的 {npc:5412} 提供 {quest:1368} 和 {quest:1367}。接受所选部族的任务及其“收买友谊”任务（携带一袋图腾，奖励 3,000 点），然后勾选此项。指南接下来按吉尔吉斯路线进行；改接玛格拉姆任务，就会跳到玛格拉姆部分。尽量在 50 级之前完成部族任务：经典怀旧服中，任务等级比你低 6 级及以上时，奖励会减少，最低只有五分之一。",
}
