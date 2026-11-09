-- Chinese (simplified) (zhCN): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328} (Forsaken)"] = "提尔之望与{spell:7328}（被遗忘者）",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328}可复活倒下的盟友，另有一把武器和一面盾牌，给新的被遗忘者圣骑士。",

	-- Step 1: Aramis Hammerhand
	-- {npc:1569} Shadow Priest Sarvis · {item:282423} Consecrated Scroll · {quest:364} The Mindless Ones · {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard · {area:154} Deathknell · {spell:635} Holy Light
	["{npc:1569} gives you a {item:282423} after {quest:364}: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "完成{quest:364}后，{npc:1569}会给你一份{item:282423}：阅读它，然后交给教堂旁的{npc:244808}。他要你治疗躺在{area:154}周围的五名{npc:259377}。被遗忘者圣骑士每次施放{spell:635}都会受到少量伤害：注意你的生命值。",
	-- {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Heal 5 {npc:259377} with {spell:635}"] = "用 {spell:635} 治疗 5 名 {npc:259377}。",

	-- Step 2: Coming to Terms
	-- {npc:244808} Aramis Hammerhand · {npc:246143} Frightened Paladin
	["At 4 {npc:244808} sends you after a {npc:246143} who fled into the hills west of the church, just south of the bat cave. Talk to her to offer aid: she turns on you, and you have to put her down (level 3, easy)."] = "4级时，{npc:244808} 会派你寻找逃进教堂西边山丘的 {npc:246143}，位置就在蝙蝠洞南边。与她交谈表示愿意援助：她会转而攻击你，你必须将她击杀（3级，很容易）。",
	-- {npc:246143} Frightened Paladin
	["Talk to the {npc:246143}, then defeat her"] = "与 {npc:246143} 交谈，然后击败她",

	-- Step 3: Shari Stilwell
	-- {area:154} Deathknell · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road east out of {area:154} to {area:159}. {npc:246152}, the paladin trainer, stands in town; she trains you from here on."] = "沿道路向东离开 {area:154}，前往 {area:159}。圣骑士训练师 {npc:246152} 站在镇内；从这里开始由她教你技能。",

	-- Step 4: A Second Home
	-- {npc:246152} Shari Stilwell · {area:159} Brill · {quest:91317} The Tarnished · {area:16881} Shadowvale
	["At 8 {npc:246152} in {area:159} sends you to the order's keep on the west coast. {quest:91317} in {area:16881} and the crypt under it hit hard at 8-9: come at 10 or later."] = "8级时，{area:159}的{npc:246152}会让你去西海岸的教团要塞。{area:16881}及其下方墓穴里的{quest:91317}对8-9级角色威胁很大：建议10级或更高再来。",

	-- Step 5: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {npc:267009} Hadric Harlson · {area:159} Brill
	["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after {quest:96896} from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "{area:16602}位于{area:156}西北的悬崖上（向西的道路始于29,46附近）。{npc:246349}在大门口等候。要塞的训练师{npc:246389}和兽栏管理员{npc:259190}站在他南边不远处的森林边缘。他们要到你10级、并完成要塞中列奥尼德的{quest:96896}之后才有任务给你，该任务是{npc:267009}任务链的最后一环，任务链起始于{area:159}东南；看到他们的任务就接受。",

	-- Step 6: Murlocs at the Gates
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs (level 9-11) lurk on the bluffs along the road east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "邪鳍鱼人（9-11级）潜伏在城堡东侧道路沿线的高地上，以及西南方湖泊周围的营地中，就在下行前往{area:16881}的途中。",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers x8"] = "邪鳍攻击者 x8",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers x8"] = "邪鳍先知 x8",

	-- Step 7: Touring the Grounds
	-- {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:246394} Ander Solliden · {npc:246393} Jorin Croge · {npc:246378} Danitha Morr
	["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246394}, the lookout, who walks the road south-east of the keep, then {npc:246393} and {npc:246378} inside the keep. Pick the conversation option with each."] = "",
	-- {npc:246349} Breton Samuels · {item:246164} Skullthumper · {item:246165} Driftwood Smasher
	["{npc:246349}: {item:246164} or {item:246165}"] = "{npc:246349}：{item:246164}或{item:246165}",

	-- Step 8: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge · {quest:91317} The Tarnished
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it. {quest:91317} need level 9."] = "{npc:246378}在城堡内领导教团；{npc:246393}站在城堡旁。{quest:91317}需要9级。",

	-- Step 9: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {npc:259431} Rudolph Gelhardt
	["{quest:91317} (level 8-9) hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. Commander {npc:259431} (level 10) stands on the upper floor of a house, with Drudges below him: clear the ground floor first."] = "{quest:91317}（8-9级）占据了要塞西南面{area:16616}中的废弃村庄{area:16881}。指挥官{npc:259431}（10级）站在一栋房子的楼上，楼下有苦工：先清掉一楼。",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges x8"] = "黯淡的苦工 x8",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots x6"] = "黯淡的狂热者 x6",

	-- Step 10: The crypt under Shadowvale
	-- {area:16881} Shadowvale
	["The crypt under {area:16881}"] = "{area:16881}下方的墓穴",
	-- {item:246213} Sturdy Lumber · {npc:260396} Whispering Horror
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["The cellar is under the village, not on the surface: the way down is inside a burned-out house, where the arrow points. Twelve Lumber Piles (stacked beams) lie in the cellar, each good for one {item:246213}. {npc:260396}, an elite (level 11-13), sits at the far end: leave it alone."] = "地窖在村庄下方，不在地面上：下去的入口位于箭头所指的一间烧毁的房屋内。地窖里有十二堆木材（堆叠的木梁），每堆可取得一个 {item:246213}。最深处有精英 {npc:260396}（11—13级）：不要招惹它。",
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["Lumber Piles, in the cellar: the way down is here"] = "木材堆在地窖里：下去的入口就在这里",

	-- Step 11: Hilda the Breaker's bones
	-- {npc:246389} Hilda the Breaker
	["{npc:246389}'s bones"] = "{npc:246389} 的骸骨",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher · Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["The Shadowvale Lurchers and Mystics (level 8-10) in the crypt drop the Faintly Glowing Bones: about one in two from Lurchers, more from one kind of Mystic, less from the other."] = "墓穴里的影谷潜伏者和秘法师雅尔金（8—10级）会掉落散发微光的骸骨：潜伏者掉率约为二分之一，其中一种秘法师雅尔金的掉率更高，另一种则更低。",
	-- plural, as words: Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["Faintly Glowing Bones x6"] = "散发微光的骸骨 x6",

	-- Step 12: Ephram Barbaro's crystal
	-- {npc:259190} Ephram Barbaro
	["{npc:259190}'s crystal"] = "{npc:259190}的水晶",
	-- {item:286269} Glowing Crystal Fragment
	["The {item:286269}, a green crystal, lies on the floor in the left-hand part of the crypt."] = "{item:286269}是一块绿色水晶，就在墓穴左侧区域的地面上。",

	-- Step 13: Back to the keep
	["Back to the keep"] = "回到要塞",
	-- {npc:246378} Danitha Morr · {npc:259431} Rudolph Gelhardt
	["{npc:246378} hands you {npc:259431}'s head for Sylvanas: keep it in your bags, it is what you hand in."] = "{npc:246378} 会给你 {npc:259431} 的头颅，让你交给希尔瓦娜斯：把它留在背包里，这是交还任务需要的物品。",

	-- Step 14: Hilda the Breaker
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190} wait at the forest's edge south of the gate."] = "{npc:246389}和{npc:259190}在大门南方的森林边缘等候。",

	-- Step 15: Ephram Barbaro
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker
	["{npc:259190} waits at the forest's edge south of the gate, a few steps west of {npc:246389}."] = "",

	-- Step 16: A Lesson in Divinity
	-- {npc:246378} Danitha Morr · {item:2589} Linen Cloth · {zone:1458} Undercity
	["{npc:246378} offers the first Lesson in Divinity at level 12. Bring 10 {item:2589} if you have it: the {zone:1458} asks for it next."] = "{npc:246378}在12级时提供第一个神性一课任务。如果有，带上10块{item:2589}：接下来{zone:1458}会用到。",

	-- Step 17: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "从{area:159}向南走到{area:153}，再下到{zone:1458}。{npc:10181}在{object:36126}接见臣民；{npc:257648}在{object:36078}乞讨。",

	-- Step 18: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["{npc:257648} needs 10 {item:2589}. Humanoids drop it: the Scarlet Zealots and Friars of the glades about three kills in ten. The Undercity Auction House sells it too."] = "{npc:257648}需要10块{item:2589}。人型生物会掉落：林地里的血色狂热者和修士约每击杀10个掉3次。幽暗城拍卖行也有出售。",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} × 10",

	-- Step 20: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep. If you lose the symbol, {npc:246378} gives you another."] = "返回{area:16602}。{npc:246378}会给你{item:6866}；{npc:257655}在要塞楼下等候。如果弄丢了符记，{npc:246378}会再给你一个。",
	-- {npc:257655} Deathguard Billmuth
	["{npc:257655}, downstairs"] = "{npc:257655}，在楼下",

	-- Step 21: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["{area:812} is at the far east end of the glades, a long walk. Falgan lies dead among the Scarlet Crusaders there: target his body and use the {item:6866}, then talk to him at once, as he does not stay alive long. If he is already up (another player), just talk to him; if he died again, raise him again."] = "{area:812} 位于林地最东端，路途很远。亡灵卫兵法尔甘的尸体躺在那里的血色十字军中：选中尸体使用 {item:6866}，随后立刻与他交谈，因为他活不了多久。如果他已经被其他玩家复活，直接交谈即可；如果又死了，就再复活一次。",

	-- Step 22: The Scarlet attack plans
	["The Scarlet attack plans"] = "血色十字军的进攻计划",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["The Scarlet Zealots (level 8-9), Friars (9-10) and Tarnished around {area:812} carry the attack plans. They run for help at low health and respawn in five minutes."] = "{area:812} 周围的血色狂热者（8-9 级）、血色修士（9-10 级）和黯淡者携带进攻计划。它们在生命值低时会逃跑求援，每五分钟刷新。",

	-- Step 23: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, then {npc:246378}, back upstairs in the keep, teaches you {spell:7328}."] = "穿过整片林地，回到 {area:16602}：先把计划交给楼下的亡灵卫兵比尔穆斯，再回城堡楼上找 {npc:246378} 学习 {spell:7328}。",
	-- {npc:246378} Danitha Morr · {spell:7328} Redemption
	["{npc:246378}, back upstairs: {spell:7328}"] = "回到楼上找 {npc:246378}：{spell:7328}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "回到{area:16602}。{npc:246378}会给你{item:6866}；{npc:257655}在要塞楼下等候。",
	-- ["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "回到{area:16602}：比尔穆斯收下计划，{npc:246378}教你{spell:7328}。",
	-- ["Tarnished Drudges"] = "{npc:259434}",
	-- ["Tarnished Zealots"] = "{npc:259433}",
	-- ["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "在{area:812}周围扎营的{npc:239036}身上带着进攻计划。",
	-- ["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "邪鳍鱼人潜伏在要塞东边道路沿线的悬崖上，以及西边湖泊周围的营地里。",
	-- ["Tyr's Watch and {spell:7328}"] = "Tyr's Watch与{spell:7328}",
	-- ["Vile Fin Attackers"] = "{npc:250283}",
	-- ["Vile Fin Seers"] = "{npc:250282}",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602}位于{area:156}西北的悬崖上。{npc:246349}在大门口等候。",
	-- ["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812}位于林地的最东端。对{npc:257663}使用{item:6866}，然后与他交谈。如果弄丢了圣物，{npc:246378}会再给你一个。",
	-- ["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "在{area:159}训练圣骑士的{npc:246152}会让你去西海岸的修会要塞。",
	-- ["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246393} and {npc:246378} inside the keep, and {npc:246394}, the lookout, who walks the road south-east of the keep. Pick the conversation option with each."] = "{npc:246349} 会给你一件武器，然后让你绕城堡与四个人交谈：城门正南的 {npc:246389}、城堡内的 {npc:246393} 和 {npc:246378}，以及在城堡东南道路上巡逻的哨兵 {npc:246394}。与每个人交谈时都要选择对话选项。",
	-- ["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378}在要塞内领导修会；{npc:246393}站在一旁。",
	-- ["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378}在12级时提供第一堂神圣课程。",
	-- ["{npc:246389} and {npc:259190}"] = "{npc:246389}和{npc:259190}",
	-- ["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648}需要10块{item:2589}。{npc:1537}和{npc:1538}大约十次掉落三次；如果你身上已经有一些，带上即可。",
	-- ["{object:181686}, in the root cellar"] = "{object:181686}，在地窖里",
	-- ["{object:554626}, in the root cellar"] = "{object:554626}，在地窖里",
	-- ["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317}占据着要塞西南方{area:16616}中的废弃村庄{area:16881}。{item:246213}堆放在其中一座房屋的地窖里；{npc:259431}指挥官在他的部下之间走动。",
}
