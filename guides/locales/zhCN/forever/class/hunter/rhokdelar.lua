-- Chinese (simplified) (zhCN): the guide forever/class/hunter/rhokdelar (forever/class/hunter/rhokdelar.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Rhok'delar and Lok'delar"] = "伦鲁迪洛尔和罗克迪洛尔",
	["The hunter's epic bow chain: in Classic the stave and sinew became Rhok'delar and Lok'delar (unconfirmed in Forever)."] = "猎人史诗弓任务线：在经典版中，手杖和肌腱会变成伦鲁迪洛尔和罗克迪洛尔（无限中未确认）。",

	-- Step 1: The Ancient Petrified Leaf
	-- {item:18703} Ancient Petrified Leaf
	["The {item:18703}"] = "{item:18703}",
	-- {area:2717} Molten Core · {area:254} Blackrock Mountain · {npc:12018} Majordomo Executus · {object:179703} Cache of the Firelord · {item:18703} Ancient Petrified Leaf
	["{area:2717} is a 40-player raid inside {area:254}. When {npc:12018} yields, the {object:179703} appears; it holds the {item:18703} about half the time, one per kill, so it may take several weeks of raids. Right-click the leaf to start the quest."] = "{area:2717} 是位于 {area:254} 内的40人团队副本。{npc:12018} 投降后会出现 {object:179703}；其中约有一半概率开出 {item:18703}，每次击败首领最多一片，因此可能要打好几周。右键点击叶子开始任务。",
	-- {item:18703} Ancient Petrified Leaf
	["from the {item:18703}"] = "来自{item:18703}",

	-- Step 2: Vartrus the Ancient
	-- {npc:14526} Hastat the Ancient · {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {area:1997} Bloodvenom Post · {quest:7636} Stave of the Ancients
	["Vartrus, Stoma and {npc:14526} are petrified trees on a small island in a ring-shaped lake in {area:1767}, north {zone:1448}. Their spirits only appear when someone carrying the leaf climbs the island's little hill to its east edge. Alliance: fly to {area:1998}; Horde: fly to {area:1997}. Vartrus gives {quest:7636}, Stoma A Proper String, Hastat the quiver; each can be handed in on its own."] = "古树瓦特鲁斯、古树斯托玛和{npc:14526}是{zone:1448}北部{area:1767}一处环形湖中央小岛上的石化树木。只有携带叶子的人登上岛上小丘的东缘时，他们的灵魂才会出现。联盟：飞往{area:1998}；部落：飞往{area:1997}。古树瓦特鲁斯提供{quest:7636}，古树斯托玛提供“合适的弓弦”，古树哈斯塔特提供箭袋任务；每个任务都可以单独交还。",
	-- {npc:14526} Hastat the Ancient
	["{npc:14526}: the quiver, last in this guide"] = "{npc:14526}：箭袋，本指南最后一步",

	-- Step 3: Before the demons
	["Before the demons"] = "对付恶魔之前",
	-- {item:9224} Potion of Demon Slaying · {skill:171} Alchemy · {spell:19878} Track Demons
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["The four demons are level 60 elites disguised as friendly travellers; talk to one and say you know what it is, and it turns into its demon form. Fight every one alone: no pet (dismiss it), no other player's heal, buff or attack once the fight starts, or the demon calls you a coward and vanishes, with a 3 hour wait for it to return (also after it dies). Buffs and potions you take before the pull are fine, and a friend may stand by to kill wandering monsters or enemy players, as long as they never touch the demon or you. Bring a {item:9224} ({skill:171} or the auction house), Major Mana Potions for the long kites, and a melee weapon with the Demonslaying enchant if you can. {spell:19878}, from your trainer, shows the disguised demons on the minimap. In a group, set loot to free for all so you can loot the head."] = "",
	-- {spell:19878} Track Demons
	["Learn {spell:19878} and get demon-slaying potions"] = "学习 {spell:19878}，并准备屠魔药剂。",

	-- Step 4: Simone the Inconspicuous
	-- {npc:14527} Simone the Inconspicuous · {spell:19878} Track Demons · {npc:14533} Simone the Seductress · {spell:421} Chain Lightning · {spell:3034} Viper Sting · {spell:23205} Temptress' Kiss
	["{npc:14527}, a troll with a wolf, walks a long path that starts at the lake in western Un'Goro and can reach the south of the crater; use {spell:19878}. Talk to her and she becomes {npc:14533}, and her wolf Precious a Felstalker. The hardest of the four: Freezing Trap Precious and pull Simone well away from it, or kite Precious away and kill it first, let Simone reset and come back for her alone. Her {spell:421} hits hard, so drain her mana with {spell:3034} (a 15-second cooldown on Forever) and keep her busy; her {spell:23205} cuts your ranged attack power, so finish her in melee. Loot her head before Precious breaks free."] = "{npc:14527}是带着狼的巨魔，她的巡逻路线很长，从安戈洛西部的湖泊出发，最远可到环形山南部；使用{spell:19878}追踪。与她交谈后，她会变成{npc:14533}，她的狼普莱瑟斯则变成地狱猎犬。这是四场挑战中最难的一场：用冰冻陷阱困住普莱瑟斯，把平凡的西蒙妮引到远处；或者将普莱瑟斯风筝拉远后先击杀，再让平凡的西蒙妮脱战重置，回来单独对付她。她的{spell:421}伤害很高，用{spell:3034}耗光她的法力值（无限中冷却时间为15秒），持续牵制她；她的{spell:23205}会降低你的远程攻击强度，因此最后用近战解决她。在普莱瑟斯挣脱前拾取她的头颅。",

	-- Step 5: Franklin the Friendly
	-- {npc:14529} Franklin the Friendly · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14534} Klinfran the Crazed · {spell:3043} Scorpid Sting · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot · {spell:2974} Wing Clip · {spell:2973} Raptor Strike
	["{npc:14529}, a human, wanders the western {zone:1428} south of {area:254}. Talk to him and he becomes {npc:14534}, the easiest of the four. Keep {spell:3043} on him the whole fight: while it lasts he barely hurts you. When he goes into {spell:23257}, remove it with {spell:19801} and never stand in melee while it is up; between frenzies you can fight him in melee with {spell:2974} and {spell:2973}. He cannot leave the {zone:1428}, so kite him around the trees if needed."] = "{npc:14529} 是一名人类，在 {zone:1428} 西部、{area:254} 南侧游荡。与他交谈后，他会变成 {npc:14534}，是四只恶魔中最容易的一只。全程保持他身上的 {spell:3043}：效果持续期间，他对你的伤害很低。他进入 {spell:23257} 状态时，用 {spell:19801} 驱散；该状态仍在时绝不要进入近战范围。两次狂暴之间可以用 {spell:2974} 和 {spell:2973} 与他近战。他无法离开 {zone:1428}，必要时可绕着树木风筝他。",

	-- Step 6: Nelson the Nice
	-- {npc:14536} Nelson the Nice · {area:3428} Ahn'Qiraj · {zone:1451} Silithus · {npc:14530} Solenor the Slayer · {spell:23272} Soul Flame · {object:164639} Frost Trap (no name in this language: may be words) · {spell:5384} Feign Death · {spell:2974} Wing Clip · {npc:14761} Creeping Doom · {spell:2643} Multi-Shot
	["{npc:14536}, a gnome, walks around the gates of {area:3428} in the far south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. He enrages with {spell:23272} as he turns: drop a {object:164639}, {spell:5384}, and he resets without the enrage. {spell:2974} roots him for a long time; while rooted he fears you and sends beetles ({npc:14761}): kill them fast with traps and {spell:2643} before they wear you down."] = "{npc:14536} 是个侏儒，在 {zone:1451} 最西南方的 {area:3428} 大门附近走动。与他交谈，他会变成 {npc:14530}。变身时他会施放 {spell:23272} 进入狂暴：放下一个 {object:164639}，再用 {spell:5384}，即可让他重置并消除狂暴。{spell:2974} 能长时间将他定身；被定身时，他会恐惧你并召来甲虫（{npc:14761}）：用陷阱和 {spell:2643} 迅速消灭它们，以免被持续消耗。",

	-- Step 7: Artorius the Amiable
	-- {npc:14531} Artorius the Amiable · {zone:1452} Winterspring · {area:2255} Everlook · {npc:14535} Artorius the Doombringer · {spell:23298} Demonic Doom · {spell:5118} Aspect of the Cheetah · {spell:1978} Serpent Sting · {spell:23299} Stinging Trauma · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot
	["{npc:14531}, a tauren, walks a loop in the rocks of northern {zone:1452}, north of {area:2255}. Talk to him and he becomes {npc:14535}. Within 30 yards of him {spell:23298} hits hard: keep your distance and kite him the whole fight, {spell:5118} on, south down the road. {spell:1978} on him adds {spell:23299}, extra Nature damage, so keep it ticking while you run; his {spell:23257} can be removed with {spell:19801}, but distance matters more. It is a long fight: bring mana potions and plan your kiting path."] = "{npc:14531} 是一名牛头人，在 {zone:1452} 北部、{area:2255} 以北的岩石间循环巡逻。与他交谈后，他会变成 {npc:14535}。在他 30 码以内，{spell:23298} 会造成很高的伤害：全程拉开距离，开启 {spell:5118}，沿道路向南风筝。他身上的 {spell:1978} 会附加 {spell:23299}，造成额外自然伤害，因此跑动时要保持它持续生效；可以用 {spell:19801} 驱除他的 {spell:23257}，但保持距离更重要。这场战斗很漫长：带上法力药水，并提前规划风筝路线。",

	-- Step 8: Onyxia
	["Onyxia"] = "奥妮克希亚",
	-- {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18705} Mature Black Dragon Sinew
	["Onyxia is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. She drops one {item:18705} in about two kills of five, lootable without the quest, so only one hunter per kill gets it: settle who first."] = "奥妮克希亚是 {area:2159} 的 40 人团队首领，巢穴入口位于 {zone:1445} 南部的 {area:511}，每周刷新一次。她大约每五次击杀有两次掉落一件 {item:18705}，没有任务也能拾取，因此每次击杀最多只有一名猎人拿到：提前商量好分配顺序。",
	-- {item:18705} Mature Black Dragon Sinew
	["{item:18705}, from Onyxia"] = "{item:18705}，来自奥妮克希亚",

	-- Step 9: Back to the Ancients
	["Back to the Ancients"] = "回到古树处",

	-- Step 10: Rhok'delar and Lok'delar
	-- {item:18707} Ancient Rune Etched Stave · {item:18724} Enchanted Black Dragon Sinew · {item:18715} Lok'delar, Stave of the Ancient Keepers
	["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and talking to Vartrus once more then gave {item:18715}, at no extra cost."] = "尚未在无限确认。在经典怀旧服中，背包里带着 {item:18724} 使用 {item:18707} 可以制成伦鲁迪洛尔，之后再与瓦特鲁斯交谈一次，就能免费获得 {item:18715}。",
	-- {item:18707} Ancient Rune Etched Stave
	["{item:18707}, by Vartrus"] = "{item:18707}，在古树瓦特鲁斯旁",
	-- {npc:14524} Vartrus the Ancient
	["{npc:14524}: Lok'delar in Classic"] = "{npc:14524}：经典版中的罗克迪洛尔",

	-- Step 11: Azuregos
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos · {zone:1447} Azshara · {area:2245} Mazthoril · {area:2255} Everlook · {zone:1452} Winterspring
	["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, stands in southern {zone:1447}, returns only every two to four days and drops it nearly every kill. The elite Cobalt dragonkin in and around {area:2245}, the cave south of {area:2255} in {zone:1452}, drop it about once in 200 kills; Manaclaw there a little more often. Skip the rest of this guide if you do not want the quiver."] = "古树哈斯塔特的箭袋需要 {item:18704}。{npc:6109} 是需要团队挑战的世界首领，位于 {zone:1447} 南部，每两到四天才刷新一次，几乎每次击杀都会掉落。在 {zone:1452} 的 {area:2255} 南边洞穴 {area:2245} 内外，精英深蓝龙人约每 200 次击杀掉落一件；那里的魔法利爪掉率稍高。如果不想要箭袋，就跳过本指南的剩余部分。",
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos
	["{item:18704}, from {npc:6109}"] = "{item:18704}，来自{npc:6109}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azuregos"] = "艾索雷葛斯",
	-- ["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, roams the south of {zone:1447} and drops it most of the time; the Cobalt dragonkin of {zone:1452} drop it very rarely. Skip the rest of this guide if you do not want the quiver."] = "古树哈斯塔特的箭袋需要{item:18704}。{npc:6109}是需要团队的世界首领，在{zone:1447}南部游荡，大多数时候会掉落它；{zone:1452}的深蓝龙族极少掉落。如果不要箭袋，跳过本指南的剩余部分。",
	-- ["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and Vartrus then gave {item:18715} ({spell:425121})."] = "Forever 尚未确认。在经典版中，背包里有{item:18724}时使用{item:18707}会做出伦鲁迪洛尔，随后古树瓦特鲁斯会给你{item:18715}（{spell:425121}）。",
	-- ["Onyxia drops the {item:18705}; she is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}."] = "奥妮克希亚掉落{item:18705}；她是{area:2159}的40人团队首领，那是{zone:1445}南部{area:511}中的一个洞穴。",
	-- ["The four demons are level 60 elites disguised as friendly travellers; talk to one and say you know what it is, and it turns into its demon form. Fight every one alone: no pet (dismiss it), no other player's heal, buff or attack once the fight starts, or the demon calls you a coward and vanishes, with a 3 hour wait for it to return (also after it dies). Buffs and potions you take before the pull are fine, and a friend may stand by to kill wandering monsters or enemy players, as long as they never touch the demon or you. Bring an Elixir of Demonslaying ({skill:171} or the auction house), Major Mana Potions for the long kites, and a melee weapon with the Demonslaying enchant if you can. {spell:19878}, from your trainer, shows the disguised demons on the minimap. In a group, set loot to free for all so you can loot the head."] = "这四只恶魔都是60级精英，伪装成友善的旅人；与其中一只交谈，表示你知道它的真实身份，它就会变成恶魔形态。每只都必须独自击败：先解散宠物；战斗开始后，其他玩家不能对你治疗或施加增益，也不能攻击恶魔，否则它会骂你胆小鬼并消失，要等3小时才会再出现（被击杀后也一样）。开怪前使用的增益和药水不受影响。朋友可以在旁清理游荡怪物或敌对玩家，但绝不能碰你或恶魔。带上屠魔药水（通过{skill:171}制作或从拍卖行购买），以及长时间风筝所需的特效法力药水；条件允许时，再准备一把附有屠魔附魔的近战武器。向训练师学习的{spell:19878}可在小地图上显示伪装的恶魔。处于队伍中时，把拾取方式设为自由拾取，确保能拾取头颅。",
	-- ["The {object:179703} appears in {area:2717} when {npc:12018} yields; it holds the {item:18703} about half the time. {area:2717} is a 40-player raid inside {area:254}. Right-click the leaf to start the quest."] = "{npc:12018}投降后，{object:179703}会出现在{area:2717}中；约一半几率装有{item:18703}。{area:2717}是{area:254}内的40人团队副本。右键点击石叶开始任务。",
	-- ["Vartrus, Stoma and {npc:14526} stand together in the north of {zone:1448}. Alliance: {area:1998} is the nearest flight point; Horde: {area:1997}."] = "古树瓦特鲁斯、古树斯托玛和{npc:14526}一起站在{zone:1448}北部。联盟：最近的飞行点是{area:1998}；部落：{area:1997}。",
	-- ["{npc:14527}, a troll, stands in the west of {zone:1449}. Talk to her and she becomes {npc:14533}, with a pet of her own. Alone, without your pet."] = "{npc:14527}是一名巨魔，站在{zone:1449}西部。与她交谈后她会变成{npc:14533}，并带着自己的宠物。独自作战，不带宠物。",
	-- ["{npc:14529}, a human, stands in the west of the {zone:1428}. Talk to him and he becomes {npc:14534}. Alone, without your pet."] = "{npc:14529}是一名人类，站在{zone:1428}西部。与他交谈后他会变成{npc:14534}。独自作战，不带宠物。",
	-- ["{npc:14531}, a tauren, waits in the north-east of {zone:1452}. Talk to him and he becomes {npc:14535}. Fight every demon alone and without your pet: help of any kind makes it vanish. Loot the head."] = "{npc:14531}是一名牛头人，在{zone:1452}东北部等候。与他交谈后他会变成{npc:14535}。每个恶魔都要独自作战，不带宠物：任何帮助都会让它消失。拾取头颅。",
	-- ["{npc:14536}, a gnome, stands in the south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. Alone, without your pet; keep away from the beetles he calls."] = "{npc:14536}是一名侏儒，站在{zone:1451}西南部。与他交谈后他会变成{npc:14530}。独自作战，不带宠物；远离他召唤的甲虫。",
}
