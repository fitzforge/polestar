-- Chinese (simplified) (zhCN): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "奥特兰克山谷声望",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "一次性任务可获得2,000点声望，加上大胜奖励，使其成为四者中最快的；达到崇拜可获得1点传承点数。",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "奥特兰克山谷大师：达到崇拜可获得1点传承点数",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} 是供 51 级及以上玩家参加的 40 对 40 战场，也是四种战场声望中提升最快的：一次性任务合计提供约 2,000 点声望，完整获胜一场可获得数百点。同一批一次性任务还会提供 1,870 点 {zone:1455} 声望。{npc:13843} 在 {object:32372} 外招募玩家。无限的传承天赋“外交家” 特权可让本指南中每个数值最多提高 10%。",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {area:287} Hillsbrad
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "雷矛营地位于 {zone:1459} 大门外、{zone:1416} 一侧，在 {area:287} 上方。接受这里所有任务：每个都一次性提供至少 100 点声望。",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner · {area:3058} Icewing Cavern
	["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162}：{area:3058} 的 {item:17849}，100 点声望",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777}：突袭一座墓地，100",
	["destroy a tower or bunker banner, 100"] = "摧毁一面塔楼或碉堡旗帜，100",
	["capture a mine, 100"] = "占领一座矿洞，100",

	-- Step 3: Dun Baldar
	-- {area:2959} Dun Baldar
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "可在入口、任意战场军官处或战场界面排队；你会从北面的 {area:2959} 进入。大门开启前先接下镇内任务：这些任务可在战斗过程中完成。",

	-- Step 4: Icewing Cavern
	-- {area:3058} Icewing Cavern · {area:2959} Dun Baldar · {item:17849} Stormpike Banner
	["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "{area:3058}在{area:2959}西南面。{item:17849}位于洞穴深处，需经过雪人和鹰身人。",

	-- Step 5: The battle
	["The battle"] = "战斗",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2963} Coldtooth Mine · {npc:13154} Commander Louis Philips · {area:2962} Tower Point · {npc:13597} Frostwolf Explosives Expert · {area:2961} Frostwolf Village · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "其中大多数都能在前往{npc:11946}的路上完成。从击杀的部落玩家和守卫身上拾取{quest:7223}。突袭{area:3301}或任意部落墓地，烧毁一座部落塔楼（点击旗帜），并占领{area:2963}。{npc:13154}在{area:2962}；{npc:13597}在{area:2961}。{quest:7301}要求找到三位空军指挥官的降落地点。经典版中每座塔楼、墓地或矿洞奖励12声望，{npc:11947}奖励125，{npc:11946}约300。",
	["assault a graveyard"] = "突袭一座墓地",
	["Iceblood Tower banner"] = "冰血哨塔旗帜",
	-- {npc:13437} Wing Commander Ichman
	["{npc:13437}'s spot"] = "{npc:13437}的位置",
	-- {npc:13439} Wing Commander Vipore
	["{npc:13439}'s spot"] = "{npc:13439}的位置",
	-- {npc:13438} Wing Commander Slidore
	["{npc:13438}'s spot"] = "{npc:13438}的位置",

	-- Step 6: Back in Dun Baldar
	-- {area:2959} Dun Baldar
	["Back in {area:2959}"] = "回到{area:2959}",

	-- Step 7: Back at the gate
	["Back at the gate"] = "返回大门处。",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "把首批奥特兰克山谷荣誉奖章交给 {npc:13841} 旁边的 {npc:15351}：首次150点声望（{quest:8375}），此后每额外3枚兑换100点。无限服的PvP装备除了荣誉外，也需要荣誉奖章：交还前先决定想买什么。最多只能携带30枚 {zone:1459} 奖章：达到上限前先交还或消费。",
	["Alterac Valley Marks of Honor: play games"] = "奥特兰克山谷荣誉奖章：参加战场",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730}刷到友善",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "门旁的{npc:13816}要你杀死{npc:11946}：赢下一场由己方击杀他的战斗。之后可选择一件武器（{quest:8271}）。",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}：10 点声望和一把武器。",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "友善后，可让 {npc:13841} 升级徽记：获得 100 点声望。从友善到尊敬需要 6000 点声望。经典旧世中，完整获胜加上 3 枚奖章可获得 300 至 700 点；准将仍会持续接受每 3 枚奖章换取 100 点。战场内的 {item:17354}（75 点，来自冬斧洞穴）每场都能重复完成；{npc:12159}（200 点，在山谷中央出现时）需要带回这里的 {npc:13841} 处。友善后，旁边的 {npc:13217} 会出售 {item:19032}（1 金）以及优质治疗和法力饮剂（5 银）。",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}，1金",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351}：再次交还 {quest:8375}，3枚奖章换100",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "尊敬：3级徽记，奖励100声望。尊敬到崇敬需要12000声望。{npc:13841}旁的{npc:13217}出售雷矛士兵披风、雷矛贤者披风及对应坠饰（各约7金币）、雷矛腰带（4金74银到7金12银），以及特效治疗和法力饮剂（10银）。",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351}：3枚奖章兑换100点",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "崇敬：4 级徽记，150 点声望。崇敬到崇拜需要 21000 点声望，占全部进度的一半。崇敬后可向 {npc:13217} 购买武器：{item:19100}、{item:19102} 和 {item:19104}（31 金 65 银至 39 金 85 银），以及 {npc:14752}（5 金币）。51 级起，“共同的努力”（{zone:1459}、{zone:1461} 和 {zone:1460} 的奖章各 3 枚）首次奖励 200 点，之后每次 150 点，还会给予另外两个战场的声望。",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351}：共同的努力",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217}：崇敬奖励",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "崇拜可获得传承点数“奥特兰克山谷大师”和最后两级徽记，奖励的400声望除了用于徽记外已无其他意义。{npc:13217}出售{item:19030}（200金币，60级；有单独指南）、{item:19325}和{item:21563}（75金56银）、{item:19323}（156金49银）、{item:19321}（79金53银）、{item:19324}（125金66银），以及50金币的典籍和副手物品。",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217}：崇拜奖励",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459} 是51级及以上玩家参与的40对40战场，也是四种战场声望中提升最快的一种：一次性任务约可获得2,000点声望，完整获胜一次可获得数百点。这些一次性任务还能获得1,870点 {zone:1454} 声望。{npc:13842} 站在 {object:172982} 内。无限服的传承天赋“外交家” 特长可让本指南中的所有声望数值最多提高10%。",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "霜狼营地位于{zone:1416}的{zone:1459}大门外。接下这里所有任务：每个都一次性奖励至少100声望。",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner · {area:3337} Wildpaw Cavern
	["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161}：{area:3337} 的 {item:17850}，100 点声望",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776}：突袭一座墓地，100",
	["capture a tower or bunker, 100"] = "占领一座哨塔或碉堡，100 点声望。",

	-- Step 15: Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "可在入口、任意战场军官处或战场界面排队；进入后会在南方的 {area:2961} 出现。开门前接好村里的任务：战斗期间就能完成。",

	-- Step 16: Wildpaw Cavern
	-- {area:3337} Wildpaw Cavern · {area:2978} Frostwolf Keep · {item:17850} Frostwolf Banner
	["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "{area:3337} 位于 {area:2978} 南边。{item:17850} 在洞穴深处，越过豺狼人即可找到。",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2957} Irondeep Mine · {npc:13320} Commander Karl Philips · {area:3304} Icewing Bunker · {npc:13598} Stormpike Explosives Expert · {area:2959} Dun Baldar · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "其中大多数都能在前往{npc:11948}的路上完成。从击杀的联盟玩家和守卫身上拾取{item:17422}。突袭{area:3301}或任意联盟墓地，烧毁一座联盟碉堡（点击旗帜），并占领{area:2957}。{npc:13320}在{area:3304}；{npc:13598}在{area:2959}。{quest:7302}要求找到三位空军指挥官的降落地点。经典版中每座塔楼、墓地或矿洞奖励12声望，{npc:11949}奖励125，范达尔约300。",
	-- {area:3305} Stonehearth Bunker
	["{area:3305} banner"] = "{area:3305} 的旗帜",
	-- {npc:13179} Wing Commander Guse
	["{npc:13179}'s spot"] = "{npc:13179}的位置",
	-- {npc:13180} Wing Commander Jeztor
	["{npc:13180}'s spot"] = "{npc:13180}的位置",
	-- {npc:13181} Wing Commander Mulverick
	["{npc:13181}'s spot"] = "{npc:13181}的位置",

	-- Step 18: Back in Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Back in {area:2961}"] = "回到{area:2961}",

	-- Step 19: Back at the gate
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "将首批奥特兰克山谷荣誉奖章交给大门旁的{npc:15350}：首次150（{quest:8369}），之后每再交3枚得100。无限的 PvP 装备除了荣誉，也需要荣誉奖章：交还前先想好要买什么。最多携带30枚{zone:1459}奖章：达到上限前先交还或花掉。",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729}刷到友善",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "门旁的{npc:13817}要你杀死{npc:11948}：赢下一场由己方击杀他的战斗。之后可选择一件武器（{quest:8272}）。",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}：10 点声望和一把武器。",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "达到友善后，可让 {npc:13840} 升级徽记：获得100点声望。从友善到尊敬需要6000点声望。经典版中，完整获胜一次连同3枚奖章可获得300到700点；战争使者会持续接受每3枚奖章兑换100点。在战场内，{item:17354}（75点，来自冬斧洞穴）每局都能重复；“科尔拉克的传说”（200点，需他在山谷中央出现时完成）则交还给这里的 {npc:13840}。友善后可向其身旁的 {npc:13219} 购买 {item:19031}（1金币）以及优质治疗和法力药膏（5银币）。",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}，1金",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350}：再次交还 {quest:8369}，3枚奖章换100",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "尊敬：徽记升至等级3，获得100点声望。从尊敬到崇敬需要12000点声望。{npc:13840} 身旁的 {npc:13219} 出售 {npc:12051} 和顾问的披风及坠饰（每件约7金币）、霜狼腰带（5金币9银币至7金币66银币），以及特效治疗和法力药膏（10银币）。",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350}：3枚奖章兑换100点",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "崇敬：徽记等级 4，150 点声望。从崇敬到崇拜需要 21000 点声望，占整个提升过程的一半。崇敬后，{npc:13219} 会出售武器 {item:19099}、{item:19101} 和霜寒刺骨（31 金 53 银至 39 金 71 银），以及 {npc:14751}（5 金）。51 级及以上可完成“无上的荣耀”（{zone:1459}、{zone:1461} 和 {zone:1460} 的奖章各 3 枚），首次提供 200 点，之后每次 150 点，另有其余两个战场的声望。",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350}：无上的荣耀",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219}：崇敬奖励",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "崇拜可获得传承点数“奥特兰克山谷大师”和最后两级徽记，奖励的400声望除了用于徽记外已无其他意义。{npc:13219}出售{item:19029}（200金币，60级；有单独指南）、{item:19325}和{item:21563}（75金56银）、{item:19323}（156金49银）、{item:19321}（79金53银）、{item:19324}（125金66银），以及50金币的典籍和副手物品。",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219}：崇拜奖励",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "{faction:729}达到崇拜可获得1点传承点数。",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "{faction:730}达到崇拜可获得1点传承点数。",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "在哨塔被摧毁后击杀{npc:11946}的完整对局给得最多。",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "在哨塔被摧毁后击杀{npc:11948}的完整对局给得最多。",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "继续赢得{zone:1459}。“取之于敌”（{npc:13176}）、交给{npc:13236}的{item:17306}（用来召唤{npc:13256}）以及交给{npc:13441}的{item:17642}都可重复。",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "继续赢得{zone:1459}。更多的{quest:7223}（{npc:13257}）、交给{npc:13442}的{item:17423}（用来召唤{npc:13419}）以及交给{npc:13577}的{item:17643}都可重复。",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729}占据着{zone:1459}南部的{area:2978}。摧毁哨塔、占领墓地和矿洞、击杀队长和将军都会给全队声望。从倒下的敌人身上拾取{item:17422}交给{npc:13176}。Forever的传承外交官特权可提高声望获取。",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730}占据着{zone:1459}北部的{area:2959}。摧毁哨塔、占领墓地和矿洞、击杀队长和将军都会给全队声望。从倒下的敌人身上拾取{quest:7223}交给{npc:13257}。Forever的传承外交官特权可提高声望获取。",
	-- ["{faction:729} to Exalted"] = "{faction:729}刷到崇拜",
	-- ["{faction:729} to Honored"] = "{faction:729}刷到尊敬",
	-- ["{faction:729} to Revered"] = "{faction:729}刷到崇敬",
	-- ["{faction:730} to Exalted"] = "{faction:730}刷到崇拜",
	-- ["{faction:730} to Honored"] = "{faction:730}刷到尊敬",
	-- ["{faction:730} to Revered"] = "{faction:730}刷到崇敬",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}：深铁矿洞和来自矿洞的{item:17542}",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}：冷齿矿洞和来自矿洞的{item:17522}",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176}：取之于敌",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236}：联盟之血",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257}：护甲碎片（{quest:7223}）",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442}：水晶簇",
}
