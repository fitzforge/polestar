-- Chinese (simplified) (zhCN): the guide forever/class/hunter/taming-the-beast-horde (forever/class/hunter/taming-the-beast-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6061} Taming the Beast
	["{quest:6061} (Horde)"] = "{quest:6061}（部落）",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "10级获得自己的宠物：用{item:15908}练习驯服三次，学会{spell:1515}，然后学会{spell:5149}。",

	-- Step 1: Thotar in Razor Hill
	-- {npc:3171} Thotar · {area:362} Razor Hill
	["{npc:3171} in {area:362}"] = "{area:362}的{npc:3171}",
	-- {npc:3171} Thotar · {area:362} Razor Hill · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:11814} Kali Remik · {area:367} Sen'jin Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff
	["At 10 go to {npc:3171}, the hunter trainer inside the barracks in {area:362}. If {npc:3407} in {zone:1454}, {npc:11814} in {area:367} or {npc:3038} in {zone:1456} hands you The Hunter's Path, take it and hand it to {npc:3171} for a little experience; it is only a pointer, and you can take the first rod without it."] = "10级时，找 {area:362} 兵营里的猎人训练师 {npc:3171}。如果 {zone:1454} 的 {npc:3407}、{area:367} 的 {npc:11814} 或 {zone:1456} 的 {npc:3038} 给你“猎人之道”，就接下并交给 {npc:3171}，获得少量经验；这只是引导任务，不做也能拿到第一根驯兽棒。",
	-- {npc:3171} Thotar · {item:15908} Taming Rod
	["{npc:3171}: the first {item:15908}"] = "{npc:3171}：第一份{item:15908}",

	-- Step 2: Dire Mottled Boar
	-- {area:362} Razor Hill · {item:15908} Taming Rod · {npc:3171} Thotar · {spell:75} Auto Shot
	-- plural, as words: Dire Mottled Boars = {npc:3099} Dire Mottled Boar
	["Dire Mottled Boars (level 6-7) roam just north and west of {area:362}. How the rod works: target a living beast, use the {item:15908} from inside its range and stand still for the whole channel while the beast hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:3171}. The boars charge from 20 yards, so start with the rod, not {spell:75}. The tamed boar becomes your pet for practice. Keep each rod: it goes back to {npc:3171}."] = "可怕的杂斑野猪（6-7 级）在 {area:362} 正北和西边游荡。驯兽棒用法：选中一只活着的野兽，在使用范围内施放 {item:15908}，任由野兽攻击，并在整个引导期间保持不动。移动、还击、接受其他人的治疗，或任何其他人攻击野兽，都会打断引导，并消耗驯兽棒本就不多的使用次数；次数耗尽后，摧毁驯兽棒、放弃任务，再找 {npc:3171} 重新接受任务。野猪会从 20 码外冲锋，所以要用驯兽棒起手，不要用 {spell:75}。驯服的野猪会成为供你练习的宠物。每根驯兽棒都要留着：需要交回给 {npc:3171}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "对一头活着的野猪使用{item:15908}",

	-- Step 3: Surf Crawler
	-- {spell:2641} Dismiss Pet · {area:367} Sen'jin Village · {area:368} Echo Isles
	-- plural, as words: Surf Crawlers = {npc:3107} Surf Crawler · Pygmy Surf Crawlers = {npc:3106} Pygmy Surf Crawler
	["First dismiss the boar (right-click your pet's portrait, {spell:2641}): a released practice pet can turn on you. Surf Crawlers (level 7-8) walk the beaches around {area:367} and the {area:368}; the small Pygmy Surf Crawlers do not count. A crawler runs for help at 15% health, so do not hurt it."] = "先解散野猪（右键点击宠物头像，选择 {spell:2641}）：放走的练习宠物可能会反过来攻击你。海浪蟹（7-8 级）在 {area:367} 和 {area:368} 周围的海滩活动；体型较小的小海浪蟹不算。海浪蟹生命值降到 15% 时会逃跑求援，因此不要伤害它。",
	-- {item:15908} Taming Rod · {npc:3107} Surf Crawler
	["Use the {item:15908} on a living {npc:3107}"] = "对一只活着的 {npc:3107} 使用 {item:15908}。",

	-- Step 4: Armored Scorpid
	-- {area:362} Razor Hill · {spell:1494} Track Beasts
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Dismiss the crawler. Armored Scorpids (level 7-8) crawl the dry plains west and south-west of {area:362}, some just south of the road west out of town; {spell:1494} shows them. Their hits can break the channel: start at full health and keep still."] = "解散爬行蟹。硬甲蝎（7-8 级）在 {area:362} 西边和西南的干燥平原爬行，有些就在出镇向西的道路南侧；用 {spell:1494} 可以找到它们。它们的攻击可能打断引导：满血开始，并保持不动。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living scorpid"] = "对一只活蝎子使用 {item:15908}",

	-- Step 5: Ormak Grimshot in Orgrimmar
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar
	["{npc:3352} in {zone:1454}"] = "{zone:1454}的{npc:3352}",
	-- {zone:1454} Orgrimmar · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor · {npc:10088} Xao'tsu
	["Follow the road north to {zone:1454}'s gate. {npc:3352} stands with the hunter trainers in the {object:172958}, up the ramp at the city's east side; {npc:10088}, the pet trainer, is a few steps north of him."] = "沿路向北前往 {zone:1454} 的城门。{npc:3352} 与其他猎人训练师一起站在 {object:172958} 内，从城市东侧的坡道上去即可找到；宠物训练师 {npc:10088} 就在他北边几步远处。",

	-- Step 6: Yaw Sharpmane at Bloodhoof
	-- {npc:3065} Yaw Sharpmane
	["{npc:3065} at Bloodhoof"] = "血蹄村的 {npc:3065}",
	-- {npc:3065} Yaw Sharpmane · {area:222} Bloodhoof Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:3171} Thotar · {area:362} Razor Hill
	["At 10 go to {npc:3065}, who stands at the north edge of {area:222}. The Hunter's Path from {npc:3038} in {zone:1456}, {npc:3407} in {zone:1454} or {npc:3171} in {area:362} also leads here, for a little experience; it is only a pointer."] = "10级时，找站在 {area:222} 北缘的 {npc:3065}。{zone:1456} 的 {npc:3038}、{zone:1454} 的 {npc:3407} 或 {area:362} 的 {npc:3171} 提供的“猎人之道”也会指引你来这里，并奖励少量经验；它只是引导任务。",
	-- {npc:3065} Yaw Sharpmane · {item:15908} Taming Rod
	["{npc:3065}: the first {item:15908}"] = "{npc:3065}：第一份{item:15908}",

	-- Step 7: Adult Plainstrider
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Adult Plainstriders (level 6-7) walk the plains south-west and north-west of {area:222}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). A plainstrider flees at 25% health, so do not damage it first. Keep each rod: it goes back to Yaw."] = "成年平原陆行鸟（6-7级）在{area:222}西南和西北方的平原上活动。驯服棒用法：选中一只活着的野兽，使用{item:15908}，在整个引导期间站着不动，任由它攻击你；移动、还击或其他人帮忙都会打断引导，并消耗驯服棒本就不多的使用次数（次数用完后：摧毁驯服棒，放弃任务，再重新接受）。陆行鸟在生命值降至25%时会逃跑，所以不要先攻击它。保留每根驯服棒：要交还给雅文·刺鬃。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living plainstrider"] = "对一只活着的陆行鸟使用{item:15908}",

	-- Step 8: Prairie Stalker
	-- {spell:2641} Dismiss Pet · {area:222} Bloodhoof Village
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker
	["Dismiss the plainstrider first (right-click the pet portrait, {spell:2641}): a released practice pet may attack you. Prairie Stalkers (level 7-8) roam the grass north of {area:222}."] = "先解散陆行鸟（右键点击宠物头像，选择{spell:2641}）：被释放的练习宠物可能会攻击你。草原捕食者（7-8级）在{area:222}北面的草地游荡。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "对一只活着的捕食者使用{item:15908}",

	-- Step 9: Swoop
	-- {npc:2970} Swoop
	-- plural, as words: Swoops = {npc:2970} Swoop · Taloned Swoops = {npc:2971} Taloned Swoop
	["Dismiss the stalker. Swoops (level 7-9) glide over the plains north-west and north-east of Bloodhoof; the Taloned Swoops do not count. A {npc:2970}'s knockdown breaks the channel, but it lands only once per channel: start the rod just after it has used it."] = "解散捕猎者。猛鹫（7—9级）在血蹄村西北和东北的平原上空滑翔；长爪猛鹫不计数。{npc:2970} 的击倒会打断引导，但每次引导期间只会击中一次：等它刚用过击倒后再使用驯兽棒。",
	-- {item:15908} Taming Rod · {npc:2970} Swoop
	["Use the {item:15908} on a living {npc:2970}"] = "对一只活着的 {npc:2970} 使用 {item:15908}。",

	-- Step 10: Holt Thunderhorn in Thunder Bluff
	-- {npc:3039} Holt Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:3039} in {zone:1456}"] = "{zone:1456}的{npc:3039}",
	-- {zone:1456} Thunder Bluff · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {npc:10086} Hesuwa Thunderhorn
	["Head north to {zone:1456} and take a lift up. {npc:3039} stands with the hunter trainers on {area:1641}; {npc:10086}, the pet trainer, is nearby."] = "向北前往 {zone:1456}，搭乘升降梯上去。{npc:3039} 与猎人训练师们一起站在 {area:1641}；宠物训练师 {npc:10086} 就在附近。",

	-- Step 11: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "10 级时，{zone:2521} 上的猎人训练师 {npc:254084} 可能会给你 {quest:94007}，让你前往 {area:16638}。这只是引导任务：如果已经在 {area:16638}，可以跳过。",

	-- Step 12: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{area:16638}的{npc:252389}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} 与训练师们一起站在 {area:16638} 西门旁，{npc:254411} 就在她身边。",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}：第一份{item:15908}",

	-- Step 13: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs a charge. Killing one does not count."] = "风歌爬行者只生活在水边：最近的在 {area:16638} 西南面海岸，混在螃蟹中爬行。驯兽棒的用法：选中活着的爬行者，使用 {item:15908}，在整个引导过程中站着不动，任它攻击你；移动、还击或其他人的协助都会打断引导并消耗一次使用次数。击杀不计入进度。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "对一只活着的爬行者使用{item:15908}",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "驯服{npc:254588}",

	-- Step 14: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "先解散爬行者（右键点击宠物头像，选择{spell:2641}）。暴躁的疾风陆行鸟在{area:16626}觅食，那片田野位于{area:16638}以西及西南不远处。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "对一只活着的风行者使用 {item:15908}。",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "驯服{npc:251707}",

	-- Step 15: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "解散疾风陆行鸟。瓦尔德伦头狼也在{area:16626}猎食，位置稍靠南。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "对一只活着的头狼使用{item:15908}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "驯服{npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}，在她旁边：{spell:5149}",

	-- Step 16: Your first pet
	["Your first pet"] = "你的第一只宠物",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} 的用法与驯兽棒相同：目标必须是等级不高于你的野兽，引导期间不能移动，而野兽会一直攻击你。宠物在驯服后保留原有等级，并随你一起升级；它的等级永远不能超过你，因此尽量驯服等级接近自己的野兽。在无限服，每个宠物家族都有专属技能（例如野猪的冲锋）。练级时，猫科伤害最高（爪击和 {spell:17253}），野猪则更耐打。",
	["Tame a beast of your level to keep"] = "驯服一只与你同级的野兽，作为长期宠物。",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger · Venomtail Scorpids = {npc:3127} Venomtail Scorpid
	["Near {area:362}: Durotar Tigers (cats, level 7-8) roam the south of {zone:1411}, from {area:367} down the coast; Venomtail Scorpids (9-10) the north-west toward {zone:1454}; at 11-12, Savannah Huntresses (cats) prowl the plains around the Crossroads in the {zone:1413}."] = "{area:362}附近：杜隆塔尔猛虎（猫科，7-8级）游荡在{zone:1411}南部，从{area:367}向南沿海岸分布；毒尾蝎（9-10）位于西北边、通往{zone:1454}的方向。到11-12级时，可找{zone:1413}十字路口周围平原上的雌性草原狮（猫科）。",
	-- {zone:1412} Mulgore · {zone:1413} Barrens
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler · Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Near Bloodhoof: Flatland Prowlers (cats, level 9) and Prairie Wolf Alphas (wolves, 9-10) roam the plains of northern {zone:1412}; at 11-12, Savannah Huntresses (cats) prowl around the Crossroads in the {zone:1413}."] = "血蹄村附近：平原徘徊者（猫科，9级）和草原狼前锋（狼，9-10）游荡在{zone:1412}北部平原；到11-12级时，可找{zone:1413}十字路口周围的雌性草原狮（猫科）。",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "{area:16638} 附近：瓦尔德伦头狼（10级）在 {area:16626} 觅食，它们就是你最后一次练习驯服的野兽；尖啸幼兽主母（迅猛龙，9级）在 {area:16638} 西侧筑巢；影风乌萨拉（熊，10—11级）在 {zone:2521} 北部游荡。",
	-- {spell:1584} Feed Pet · {npc:6928} Innkeeper Grosk · {area:362} Razor Hill · {npc:3025} Kaga Mistrunner · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Grimtak the butcher and {npc:6928} in {area:362} sell meat, {npc:3025} in {zone:1456} and the innkeepers on {zone:2521} too; Bloodhoof's innkeeper and bakers sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}：打开法术书，施放{spell:1584}，再点击一种你的宠物所属家族能吃的食物（宠物的鼠标提示会列出食谱：猫科吃肉和鱼，野猪几乎什么都吃）。从野兽身上拾取的生肉也可以。购买地点：{area:362}的屠夫格瑞姆塔克和{npc:6928}出售肉类，{zone:1456}的{npc:3025}以及{zone:2521}的旅店老板也有出售；血蹄村的旅店老板和面包师出售面包。等级接近宠物的食物提供的快乐值最多；等级低很多的食物大约只有一半效果。战斗中无法喂食。",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "快乐度：看宠物头像框上的表情。宠物不高兴时只造成正常伤害的四分之三，高兴时则额外造成四分之一伤害。快乐度会缓慢降低，宠物死亡后降得更快；宠物长期不高兴可能会逃跑。",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "忠诚度会随相处时间和击杀增长。每提升一级忠诚等级，都能增加可用于{spell:5149}的训练点数（宠物等级乘以“忠诚等级减一”）。",
	-- {spell:5149} Beast Training · {npc:9987} Shoja'my · {area:362} Razor Hill · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle · {npc:9988} Xon'cha · {zone:1454} Orgrimmar
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master ({npc:9987} in {area:362}, Seikwa at Bloodhoof, {npc:265756} on {zone:2521}, {npc:9988} in {zone:1454}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149}（法术书的综合分页）可以将你已掌握的技能教给当前宠物。要学习新技能或更高等级：先将宠物寄放在兽栏管理员处（{area:362}的{npc:9987}、血蹄村的希克瓦、{zone:2521}的{npc:265756}或{zone:1454}的{npc:9988}），驯服一只拥有该技能的野兽（宠物法术书分页会显示它的技能），在战斗中使用该技能，直到游戏提示你已经学会，再领回自己的宠物，用{spell:5149}教给它。一只宠物最多拥有4个主动技能。",
	-- {spell:1853} Growl · {area:362} Razor Hill · {npc:3688} Reban Freerunner · {npc:10088} Xao'tsu · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:10086} Hesuwa Thunderhorn · {zone:1456} Thunder Bluff · {area:1641} Hunter Rise · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar · {area:75} Stonard · {object:3202} Grom'gol
	["Pet trainers sell {spell:1853} ranks and resistances. Horde: Harruk in {area:362}, {npc:3688} at Bloodhoof, {npc:10088} in {zone:1454}'s {object:172958}, {npc:10086} on {zone:1456}'s {area:1641}, {npc:254411} in {area:16638}, later Grokor in {area:75} and Zudd at {object:3202}."] = "宠物训练师出售各等级的 {spell:1853} 和抗性技能。部落：{area:362} 的哈鲁克、血蹄村的 {npc:3688}、{zone:1454} 的 {object:172958} 内的 {npc:10088}、{zone:1456} 的 {area:1641} 上的 {npc:10086}、{area:16638} 的 {npc:254411}，之后还有 {area:75} 的格罗科尔和 {object:3202} 处的祖德。",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "现在你的法术书中已有 {spell:883}、{spell:2641} 和 {spell:982}；到12级时，可以找训练师学习 {spell:136}。宠物死亡后需要用 {spell:982}；离你超过约100码时，宠物会被解散，可用 {spell:883} 再次召回。",
}
