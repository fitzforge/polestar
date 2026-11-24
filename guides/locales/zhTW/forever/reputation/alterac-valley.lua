-- Chinese (traditional) (zhTW): the guide forever/reputation/alterac-valley (forever/reputation/alterac-valley.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Alterac Valley Reputation"] = "奧特蘭克山谷聲望",
	["One-time quests worth 2,000 and big wins make it the quickest of the four; Exalted gives a Legacy Point."] = "一次性任務可獲得2,000點聲望，加上大勝獎勵，使其成為四者中最快的；達到崇拜可獲得1點傳承點數。",
	["Master of Alterac Valley: a Legacy Point at Exalted"] = "奧特蘭克山谷大師：達到崇拜可獲得1點傳承點數",

	-- Step 1: Lieutenant Rotimer
	-- {zone:1459} Alterac Valley · {zone:1455} Ironforge · {npc:13843} Lieutenant Rotimer · {object:32372} Great Forge
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1455} reputation. {npc:13843} recruits outside the {object:32372}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459}是51級及以上的40對40戰場，也是四個戰場聲望中最快的：一次性任務約值2,000聲望，一場全勝還能給幾百點。同樣的一次性任務還會給1,870點{zone:1455}聲望。{npc:13843}在{object:32372}外招募。Forever 的傳承特長“外交家”可使本篇攻略中的每個數字最多提高10%。",

	-- Step 2: Lieutenant Haggerdin
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains · {area:287} Hillsbrad
	["The Stormpike camp stands outside the {zone:1459} gate, on the {zone:1416} side above {area:287}. Take every quest here: they all pay 100 or more, once."] = "雷矛營地設在{zone:1459}大門外，{area:287}上方{zone:1416}一側。把這裡的任務全接了：每個都給100點以上，但只能做一次。",
	-- {quest:7162} Proving Grounds · {item:17849} Stormpike Banner · {area:3058} Icewing Cavern
	["{quest:7162}: the {item:17849} in {area:3058}, 100"] = "{quest:7162}：{area:3058}的{item:17849}，100",
	-- {npc:13777} Sergeant Durgen Stormpike
	["{npc:13777}: assault a graveyard, 100"] = "{npc:13777}：突襲墓地，100",
	["destroy a tower or bunker banner, 100"] = "摧毀哨塔或碉堡旗幟，100",
	["capture a mine, 100"] = "佔領礦坑，100",

	-- Step 3: Dun Baldar
	-- {area:2959} Dun Baldar
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2959} in the north. Before the gates open, take the quests in the town: they are done during the battle."] = "在大門處、任意戰場軍官處或戰場介面排隊；你會在北部的{area:2959}進入。開戰前先在鎮裡接任務：它們在戰鬥中完成。",

	-- Step 4: Icewing Cavern
	-- {area:3058} Icewing Cavern · {area:2959} Dun Baldar · {item:17849} Stormpike Banner
	["{area:3058} lies southwest of {area:2959}. The {item:17849} stands at the back of the cave, past the yetis and harpies."] = "{area:3058}位於{area:2959}西南。{item:17849}在洞穴深處，穿過雪人和鷹身女妖之後。",

	-- Step 5: The battle
	["The battle"] = "戰鬥",
	-- {npc:11946} Drek'Thar · {quest:7223} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2963} Coldtooth Mine · {npc:13154} Commander Louis Philips · {area:2962} Tower Point · {npc:13597} Frostwolf Explosives Expert · {area:2961} Frostwolf Village · {quest:7301} Fallen Sky Lords · {npc:11947} Captain Galvangar
	["Most of this happens on the way to {npc:11946}. Loot {quest:7223} from Horde players and guards you kill. Assault the {area:3301} or any Horde graveyard, burn a Horde tower (click its banner), and take {area:2963}. {npc:13154} stands at {area:2962}; the {npc:13597} at {area:2961}. {quest:7301} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11947} 125 and {npc:11946} about 300."] = "這些大多是在前往{npc:11946}的路上完成的。從你殺死的部落玩家和衛兵身上拾取{quest:7223}。突襲{area:3301}或任意部落墓地，燒掉一座部落哨塔（點選其旗幟），並佔領{area:2963}。{npc:13154}站在{area:2962}；{npc:13597}在{area:2961}。{quest:7301}要你查明三位空軍指揮官降落在何處。原版中每座哨塔、墓地或礦坑給12點聲望，{npc:11947}給125，{npc:11946}約300。",
	["assault a graveyard"] = "突襲墓地",
	["Iceblood Tower banner"] = "冰血哨塔旗幟",
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
	["Back at the gate"] = "回到大門處",
	-- {npc:15351} Alliance Brigadier General · {npc:13841} Lieutenant Haggerdin · {quest:8375} Remember Alterac Valley! · {zone:1459} Alterac Valley
	["Your first Alterac Valley Marks of Honor go to the {npc:15351} beside {npc:13841}: 150 the first time ({quest:8375}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "你的第一批奧特蘭克山谷榮譽徽記交給{npc:13841}旁的{npc:15351}：第一次150點（{quest:8375}），之後每3枚100點。Forever 的PvP裝備除了榮譽還要花榮譽徽記：交之前先想好想要什麼。你最多隻能攜帶30枚{zone:1459}徽記：在達到上限前交掉或用掉。",
	["Alterac Valley Marks of Honor: play games"] = "奧特蘭克山谷榮譽徽記：打戰場",

	-- Step 8: Stormpike Guard to Friendly
	-- {faction:730} Stormpike Guard
	["{faction:730} to Friendly"] = "{faction:730}到友好",
	-- {npc:13816} Prospector Stonehewer · {npc:11946} Drek'Thar · {quest:8271} Hero of the Stormpike
	["{npc:13816} by the gate wants {npc:11946} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8271})."] = "大門旁的{npc:13816}要{npc:11946}死：贏下一場你的隊伍殺死他的戰鬥。之後他讓你挑選一件武器（{quest:8271}）。",
	-- {quest:8271} Hero of the Stormpike
	["{quest:8271}, 10 and a weapon"] = "{quest:8271}，10和一件武器",

	-- Step 9: Rise and Be Recognized
	-- {npc:13841} Lieutenant Haggerdin · {item:17354} Master Ryson's All Seeing Eye · {npc:12159} Korrak the Bloodrager · {item:19032} Stormpike Battle Tabard · {npc:13217} Thanthaldis Snowgleam
	["Friendly lets {npc:13841} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Brigadier General keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; {npc:12159} (200, when he appears in the middle of the valley) goes back to {npc:13841} here. Friendly opens the {item:19032} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13217} beside him."] = "友善時{npc:13841}可以升級你的徽記：100聲望。友善到尊敬需要6000聲望。原版中一場全勝連同3枚徽記共付300到700；准將會一直以3枚徽記換100。在戰場內，{item:17354}（75點，來自冰斧洞穴）每場可重複；{npc:12159}（200點，他在山谷中央出現時）交回給這裡的{npc:13841}。友善會在旁邊的{npc:13217}處解鎖{item:19032}（1金）和強效治療藥水、法力藥水（5銀）。",
	-- {item:19032} Stormpike Battle Tabard
	["{item:19032}, 1g"] = "{item:19032}，1金",
	-- {npc:15351} Alliance Brigadier General · {quest:8375} Remember Alterac Valley!
	["{npc:15351}: {quest:8375} again, 100 for 3 marks"] = "{npc:15351}：再次{quest:8375}，3枚徽記換100",

	-- Step 10: Honored Amongst the Guard
	-- {npc:13217} Thanthaldis Snowgleam · {npc:13841} Lieutenant Haggerdin
	-- plural, as words: Sage's Cloaks = {item:6614} Sage's Cloak
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13217} beside {npc:13841} sells the Stormpike Soldier's and Sage's Cloaks and Pendants (about 7g each), the Stormpike belts (4g74s to 7g12s) and the Major Healing and Mana Draughts (10s)."] = "尊敬：徽記3級，100聲望。尊敬到崇敬需要12000聲望。{npc:13841}旁的{npc:13217}出售雷矛士兵和賢者的披風與墜飾（每件約7金）、雷矛腰帶（4金74銀到7金12銀），以及特效治療藥水和法力藥水（10銀）。",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: 100 for 3 marks"] = "{npc:15351}：3枚徽記換100",

	-- Step 11: Earned Reverence
	-- {npc:13217} Thanthaldis Snowgleam · {item:19100} Electrified Dagger · {item:19102} Crackling Staff · {item:19104} Stormstrike Hammer · {npc:14752} Stormpike Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13217}: {item:19100}, {item:19102} and {item:19104} (31g65s to 39g85s), and the {npc:14752} (5g). At 51 and up Concerted Efforts (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "崇敬：徽記4級，150聲望。崇敬到崇拜需要21000聲望，佔爬升的一半。崇敬會在{npc:13217}處解鎖武器：{item:19100}、{item:19102}和{item:19104}（31金65銀到39金85銀），以及{npc:14752}（5金）。51級及以上時，“共同努力”（各交3枚{zone:1459}、{zone:1461}和{zone:1460}徽記）第一次付200、之後150，並另給另外兩個戰場的聲望。",
	-- {npc:15351} Alliance Brigadier General
	["{npc:15351}: Concerted Efforts"] = "{npc:15351}：共同努力",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Revered rewards"] = "{npc:13217}：崇敬獎勵",

	-- Step 12: Legendary Heroes
	-- {npc:13217} Thanthaldis Snowgleam · {item:19030} Stormpike Battle Charger · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13217} sells the {item:19030} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "崇拜會給予傳承點數“奧特蘭克山谷大師”，以及最後兩枚徽記——那400點聲望除了換徽記之外已無用處。{npc:13217}出售{item:19030}（200金，60級；另有專門攻略）、{item:19325}和{item:21563}（75金56銀）、{item:19323}（156金49銀）、{item:19321}（79金53銀）、{item:19324}（125金66銀），以及50金的典籍和副手物品。",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}: Exalted rewards"] = "{npc:13217}：崇拜獎勵",

	-- Step 13: Frostwolf Ambassador Rokhstrom
	-- {zone:1459} Alterac Valley · {zone:1454} Orgrimmar · {npc:13842} Frostwolf Ambassador Rokhstrom · {object:172982} Valley of Strength
	["{zone:1459} is a 40 against 40 battle for level 51 and up, and the fastest of the four battleground reputations: it has about 2,000 reputation of one-time quests, and a full win pays several hundred. The same one-time quests also pay 1,870 {zone:1454} reputation. {npc:13842} stands in the {object:172982}. Forever's Legacy Diplomat perk adds up to 10% to every number in this guide."] = "{zone:1459}是51級及以上的40對40戰場，也是四個戰場聲望中最快的：一次性任務約值2,000聲望，一場全勝還能給幾百點。同樣的一次性任務還會給1,870點{zone:1454}聲望。{npc:13842}站在{object:172982}裡。Forever 的傳承特長“外交家”可使本篇攻略中的每個數字最多提高10%。",

	-- Step 14: Warmaster Laggrond
	-- {zone:1459} Alterac Valley · {zone:1416} Alterac Mountains
	["The Frostwolf camp stands outside the {zone:1459} gate in the {zone:1416}. Take every quest here: they all pay 100 or more, once."] = "霜狼營地設在{zone:1416}內{zone:1459}大門外。把這裡的任務全接了：每個都給100點以上，但只能做一次。",
	-- {quest:7161} Proving Grounds · {item:17850} Frostwolf Banner · {area:3337} Wildpaw Cavern
	["{quest:7161}: the {item:17850} in {area:3337}, 100"] = "{quest:7161}：{area:3337}的{item:17850}，100",
	-- {npc:13776} Corporal Teeka Bloodsnarl
	["{npc:13776}: assault a graveyard, 100"] = "{npc:13776}：突襲墓地，100",
	["capture a tower or bunker, 100"] = "佔領哨塔或碉堡，100",

	-- Step 15: Frostwolf Village
	-- {area:2961} Frostwolf Village
	["Queue at the gate, at any battlemaster or from the battleground screen; you enter at {area:2961} in the south. Before the gates open, take the quests in the village: they are done during the battle."] = "在大門處、任意戰場軍官處或戰場介面排隊；你會在南部的{area:2961}進入。開戰前先在村裡接任務：它們在戰鬥中完成。",

	-- Step 16: Wildpaw Cavern
	-- {area:3337} Wildpaw Cavern · {area:2978} Frostwolf Keep · {item:17850} Frostwolf Banner
	["{area:3337} lies south of {area:2978}. The {item:17850} stands at the back of the cave, past the gnolls."] = "{area:3337}位於{area:2978}以南。{item:17850}在洞穴深處，穿過豺狼人之後。",

	-- Step 17: The battle
	-- {npc:11948} Vanndar Stormpike · {item:17422} Armor Scraps · {area:3301} Snowfall Graveyard · {area:2957} Irondeep Mine · {npc:13320} Commander Karl Philips · {area:3304} Icewing Bunker · {npc:13598} Stormpike Explosives Expert · {area:2959} Dun Baldar · {quest:7302} Fallen Sky Lords · {npc:11949} Captain Balinda Stonehearth
	["Most of this happens on the way to {npc:11948}. Loot {item:17422} from Alliance players and guards you kill. Assault the {area:3301} or any Alliance graveyard, burn an Alliance bunker (click its banner), and take {area:2957}. {npc:13320} stands at {area:3304}; the {npc:13598} in {area:2959}. {quest:7302} asks you to find where the three wing commanders landed. In Classic every tower, graveyard or mine paid 12 reputation, {npc:11949} 125 and Vanndar about 300."] = "這些大多是在前往{npc:11948}的路上完成的。從你殺死的聯盟玩家和衛兵身上拾取{item:17422}。突襲{area:3301}或任意聯盟墓地，燒掉一座聯盟碉堡（點選其旗幟），並佔領{area:2957}。{npc:13320}站在{area:3304}；{npc:13598}在{area:2959}。{quest:7302}要你查明三位空軍指揮官降落在何處。原版中每座哨塔、墓地或礦坑給12點聲望，{npc:11949}給125，範達爾約300。",
	-- {area:3305} Stonehearth Bunker
	["{area:3305} banner"] = "{area:3305}旗幟",
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
	["Your first Alterac Valley Marks of Honor go to the {npc:15350} by the gate: 150 the first time ({quest:8369}), then 100 for every 3 more. Forever's PvP gear also costs Marks of Honor along with honor: decide what you want before you hand them in. You can carry at most 30 {zone:1459} marks: hand in or spend them before you reach that."] = "你的第一批奧特蘭克山谷榮譽徽記交給大門旁的{npc:15350}：第一次150點（{quest:8369}），之後每3枚100點。Forever 的PvP裝備除了榮譽還要花榮譽徽記：交之前先想好想要什麼。你最多隻能攜帶30枚{zone:1459}徽記：在達到上限前交掉或用掉。",

	-- Step 20: Frostwolf Clan to Friendly
	-- {faction:729} Frostwolf Clan
	["{faction:729} to Friendly"] = "{faction:729}到友好",
	-- {npc:13817} Voggah Deathgrip · {npc:11948} Vanndar Stormpike · {quest:8272} Hero of the Frostwolf
	["{npc:13817} by the gate wants {npc:11948} dead: win a game in which your team kills him. Then he lets you pick a weapon ({quest:8272})."] = "大門旁的{npc:13817}要{npc:11948}死：贏下一場你的隊伍殺死他的戰鬥。之後他讓你挑選一件武器（{quest:8272}）。",
	-- {quest:8272} Hero of the Frostwolf
	["{quest:8272}, 10 and a weapon"] = "{quest:8272}，10和一件武器",

	-- Step 21: Rise and Be Recognized
	-- {npc:13840} Warmaster Laggrond · {item:17354} Master Ryson's All Seeing Eye · {item:19031} Frostwolf Battle Tabard · {npc:13219} Jekyll Flandring
	["Friendly lets {npc:13840} upgrade your insignia: 100 reputation. Friendly to Honored is 6000 reputation. In Classic a full win paid 300 to 700 with its 3 marks; the Warbringer keeps taking 3 marks for 100. Inside, {item:17354} (75, from the Winterax caves) repeats every game; The Legend of Korrak (200, when he appears in the middle of the valley) goes back to {npc:13840} here. Friendly opens the {item:19031} (1g) and the Superior Healing and Mana Draughts (5s) at {npc:13219} beside him."] = "友善時{npc:13840}可以升級你的徽記：100聲望。友善到尊敬需要6000聲望。原版中一場全勝連同3枚徽記共付300到700；戰爭使者會一直以3枚徽記換100。在戰場內，{item:17354}（75點，來自冰斧洞穴）每場可重複；“科拉克的傳說”（200點，他在山谷中央出現時）交回給這裡的{npc:13840}。友善會在旁邊的{npc:13219}處解鎖{item:19031}（1金）和強效治療藥水、法力藥水（5銀）。",
	-- {item:19031} Frostwolf Battle Tabard
	["{item:19031}, 1g"] = "{item:19031}，1金",
	-- {npc:15350} Horde Warbringer · {quest:8369} Invaders of Alterac Valley
	["{npc:15350}: {quest:8369} again, 100 for 3 marks"] = "{npc:15350}：再次{quest:8369}，3枚徽記換100",

	-- Step 22: Honored Amongst the Clan
	-- {npc:13219} Jekyll Flandring · {npc:13840} Warmaster Laggrond · {npc:12051} Frostwolf Legionnaire
	["Honored: insignia rank 3, 100 reputation. Honored to Revered is 12000 reputation. {npc:13219} beside {npc:13840} sells the {npc:12051}'s and Advisor's Cloaks and Pendants (about 7g each), the Frostwolf belts (5g9s to 7g66s) and the Major Healing and Mana Draughts (10s)."] = "尊敬：徽記3級，100聲望。尊敬到崇敬需要12000聲望。{npc:13840}旁的{npc:13219}出售{npc:12051}和顧問的披風與墜飾（每件約7金）、霜狼腰帶（5金9銀到7金66銀），以及特效治療藥水和法力藥水（10銀）。",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: 100 for 3 marks"] = "{npc:15350}：3枚徽記換100",

	-- Step 23: Earned Reverence
	-- {npc:13219} Jekyll Flandring · {item:19099} Glacial Blade · {item:19101} Whiteout Staff · {npc:14751} Frostwolf Battle Standard · {zone:1459} Alterac Valley · {zone:1461} Arathi Basin · {zone:1460} Warsong Gulch
	["Revered: insignia rank 4, 150 reputation. Revered to Exalted is 21000 reputation, half the climb. Revered opens the weapons at {npc:13219}: {item:19099}, {item:19101} and Frostbite (31g53s to 39g71s), and the {npc:14751} (5g). At 51 and up For Great Honor (3 marks each from {zone:1459}, {zone:1461} and {zone:1460}) pays 200 the first time and 150 after, plus reputation for the other two battlegrounds."] = "崇敬：徽記4級，150聲望。崇敬到崇拜需要21000聲望，佔爬升的一半。崇敬會在{npc:13219}處解鎖武器：{item:19099}、{item:19101}和霜咬（31金53銀到39金71銀），以及{npc:14751}（5金）。51級及以上時，“為了偉大的榮譽”（各交3枚{zone:1459}、{zone:1461}和{zone:1460}徽記）第一次付200、之後150，並另給另外兩個戰場的聲望。",
	-- {npc:15350} Horde Warbringer
	["{npc:15350}: For Great Honor"] = "{npc:15350}：為了偉大的榮譽",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Revered rewards"] = "{npc:13219}：崇敬獎勵",

	-- Step 24: Legendary Heroes
	-- {npc:13219} Jekyll Flandring · {item:19029} Horn of the Frostwolf Howler · {item:19325} Don Julio's Band · {item:21563} Don Rodrigo's Band · {item:19323} The Unstoppable Force · {item:19321} The Immovable Object · {item:19324} The Lobotomizer
	["Exalted gives the Legacy Point \"Master of Alterac Valley\" and the last two insignia, 400 reputation that no longer counts for anything but the insignia. {npc:13219} sells the {item:19029} (200g, level 60; its own guide), {item:19325} and {item:21563} (75g56s), {item:19323} (156g49s), {item:19321} (79g53s), {item:19324} (125g66s) and the 50g tomes and off-hands."] = "崇拜會給予傳承點數“奧特蘭克山谷大師”，以及最後兩枚徽記——那400點聲望除了換徽記之外已無用處。{npc:13219}出售{item:19029}（200金，60級；另有專門攻略）、{item:19325}和{item:21563}（75金56銀）、{item:19323}（156金49銀）、{item:19321}（79金53銀）、{item:19324}（125金66銀），以及50金的典籍和副手物品。",
	-- {npc:13219} Jekyll Flandring
	["{npc:13219}: Exalted rewards"] = "{npc:13219}：崇拜獎勵",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Exalted with the {faction:729} earns a Legacy Point."] = "與{faction:729}達到崇拜可獲得1點傳承點數。",
	-- ["Exalted with the {faction:730} earns a Legacy Point."] = "與{faction:730}達到崇拜可獲得1點傳承點數。",
	-- ["Full games that kill {npc:11946} after the towers fall pay the most."] = "在哨塔倒下後擊殺{npc:11946}的完整對戰給的聲望最多。",
	-- ["Full games that kill {npc:11948} after the towers fall pay the most."] = "在哨塔倒下後擊殺{npc:11948}的完整對戰給的聲望最多。",
	-- ["Keep winning {zone:1459}. More Booty! ({npc:13176}), {item:17306} for {npc:13236} (it summons {npc:13256}) and Alterac Ram Hides for the {npc:13441} all repeat."] = "持續贏得{zone:1459}。「取之於敵」（{npc:13176}）、交給{npc:13236}的{item:17306}（可召喚{npc:13256}），以及交給{npc:13441}的奧特蘭克山羊皮都可重複。",
	-- ["Keep winning {zone:1459}. More {quest:7223} ({npc:13257}), Storm Crystals for {npc:13442} (they summon {npc:13419}) and Frostwolf Hides for the {npc:13577} all repeat."] = "持續贏得{zone:1459}。更多的{quest:7223}（{npc:13257}）、交給{npc:13442}的風暴水晶（可召喚{npc:13419}），以及交給{npc:13577}的霜狼毛皮都可重複。",
	-- ["The {faction:729} holds {area:2978} in the south of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {item:17422} from fallen enemies for {npc:13176}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:729}佔據{zone:1459}南部的{area:2978}。摧毀哨塔、佔領墓地和礦坑，以及擊殺隊長和將軍，都會給整個隊伍聲望。從倒下的敵人身上拾取{item:17422}交給{npc:13176}。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["The {faction:730} holds {area:2959} in the north of {zone:1459}. Destroying towers, taking graveyards and mines, and killing captains and generals all pay reputation to the whole team. Loot {quest:7223} from fallen enemies for {npc:13257}. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:730}佔據{zone:1459}北部的{area:2959}。摧毀哨塔、佔領墓地和礦坑，以及擊殺隊長和將軍，都會給整個隊伍聲望。從倒下的敵人身上拾取{quest:7223}交給{npc:13257}。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{faction:729} to Exalted"] = "{faction:729}到崇拜",
	-- ["{faction:729} to Honored"] = "{faction:729}到尊敬",
	-- ["{faction:729} to Revered"] = "{faction:729}到崇敬",
	-- ["{faction:730} to Exalted"] = "{faction:730}到崇拜",
	-- ["{faction:730} to Honored"] = "{faction:730}到尊敬",
	-- ["{faction:730} to Revered"] = "{faction:730}到崇敬",
	-- ["{npc:12096}: Irondeep and {item:17542} from the mines"] = "{npc:12096}：礦坑的深鐵礦坑補給品和{item:17542}",
	-- ["{npc:12097}: Coldtooth and {item:17522} from the mines"] = "{npc:12097}：礦坑的冷齒礦坑補給品和{item:17522}",
	-- ["{npc:13176}: More Booty!"] = "{npc:13176}：取之於敵",
	-- ["{npc:13236}: A Gallon of Blood"] = "{npc:13236}：聯盟之血",
	-- ["{npc:13257}: More {quest:7223}"] = "{npc:13257}：更多的{quest:7223}",
	-- ["{npc:13442}: Crystal Cluster"] = "{npc:13442}：水晶簇",
}
