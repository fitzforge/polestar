-- Chinese (simplified) (zhCN): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "学习{skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5, 1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "本阵营的任意{skill:356}训练师都教授初级{skill:356}（角色5级，1银）；箭头会选择最近的一位，每个初始地区的湖边或海岸都有训练师。向杂货商或钓鱼供应商购买一根{item:6256}（23铜）并装备（只有手持鱼竿才能钓鱼），再买两三个闪光的小珠（+25，每个50铜）：鱼饵可为技能提供持续十分钟的加成，减少刚开始钓鱼时的逃脱。如果你为“广阔天地”在初始地区的营火旁坐过，那里负责露营指引的NPC还会提供露营 101: {skill:356}任务；技能达到20时，向任务指定的钓鱼训练师交还，可获得{spell:1229745}配方。",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。技能低于 25 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "在这里钓到技能50，大约需钓起50条鱼：75以前每次钓起鱼都会提升技能。从法术书施放{skill:356}，鱼漂溅起水花时点击。把鱼留着：它们是你最初的{skill:185}材料。",
	-- {area:16638} Valanaar
	["{area:16638} shore"] = "{area:16638}湖岸",

	-- Step 6: Fishing: Durotar (1-50)
	["Sen'jin coast"] = "森金海岸",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "中级{skill:356}",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "中级{skill:356}将技能上限提高到150；需要技能50和角色10级（无限抓取到的训练师列表要求该等级），费用5银币。箭头指向本阵营最近的{skill:356}训练师。{spell:1229745}是无限的{skill:356}露营物品（需要技能20，1银币，也可通过“露营 101: {skill:356}”免费获得），就是把{item:6291}装在{item:3371}中：制作不涨技能，但放在营火旁后，营地里的所有人都能获得持续1小时的增益。",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "在这里的鱼群和普通水域钓到技能 125，约需钓起 120 次：75 起，每次钓起涨技能的概率会下降（100 时约二分之一，125 时约三分之一）。鱼群或漂浮残骸等水面钓鱼点还会产出额外战利品。{item:6530}（技能 50 起可用，+50，每个 1 银币）的加成是 {item:6529} 的两倍。{item:6365}（技能 10 起可用，+5，9 银 1 铜）在钓鱼商人处限量出售：看到就买。技能低于 75 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "{zone:1436}海岸",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "{zone:1439}海岸",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "{zone:1413}绿洲",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "高级{skill:356}",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "高级 {skill:356}（上限225）需要读书学习，不是训练师教授的等级：{npc:2626} 在 {zone:1434} 南端 {area:35} 最下层的码头出售 {item:16083}（1金币），双方阵营都能购买。买来阅读；需要技能125和角色20级。20级时，安全的前往方式是从 {zone:1413} 的 {area:392} 坐船，别沿路穿越荆棘谷。他还出售 {item:6532}（技能100起可用，+75，每个2银币50铜币），后续阶段可用它作鱼饵。",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "购买并阅读{item:16083}（高级{skill:356}）",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "在这里的水池钓到技能225，约需钓上500条鱼：技能125时每3次约涨一点，到225时每7次才涨一点，所以这一段较长。无限的第二种露营物品{item:279965}（需要技能140）来自{area:2797}的格里哈斯特掉落的蓝图。技能低于150时，这里的鱼会逃脱；给鱼竿装上鱼饵可提高技能10分钟，补足差距。",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "{zone:1437}海岸",

	-- Step 18: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "{zone:1440}水域",

	-- Step 20: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "{area:287}海岸",

	-- Step 21: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "专家级{skill:356}（上限300）由{zone:1445}的{npc:12919}传授。{zone:1455}的钓鱼训练师会让你去找他；任务需要技能225和35级。",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "专家级{skill:356}（上限300）由{zone:1445}的{npc:12919}传授。{zone:1454}的钓鱼训练师会让你去找他；任务需要技能225和35级。",

	-- Step 23: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919}在东海岸外、塞拉摩南面的一座小岛岸边钓鱼；从海岸游过去。",

	-- Step 24: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "沿 {zone:1443} 海岸钓鱼（西北面的 {area:598}，或 {area:2408} 西面的海岸），直到钓到 {item:16968}：那里每次上钩约有五分之一概率是它，其他地方钓不到。技能225时，这里不会有鱼逃脱。",

	-- Step 26: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "在 {zone:1444} 的 {area:2521} 沿岸垂钓（{area:2577} 东南方），直到钓到一条 {item:16967}：那里约每五次收获有一次能钓到，其他水域都钓不到。技能低于300时，这片水域的鱼会逃脱：225点时大多数都会跑掉，因此先给鱼竿装上 {item:6532}（+75）。",

	-- Step 27: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "沿 {zone:1434} 的 {area:301}（西海岸）钓鱼，直到钓到 {item:16969}：那里每次上钩约有五分之一概率是它，其他地方钓不到。技能225时，这里不会有鱼逃脱。",

	-- Step 29: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "沿{area:300}（{zone:1435}东海岸）钓鱼，直到钓起一个{item:16970}：在这里约每五次能钓起一个，其他地方则钓不到。技能225时，这里的鱼都不会逃脱。",

	-- Step 30: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "专家级{skill:356}",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "在此处沿海的鱼群和残骸处垂钓（鳗鱼、钳嘴鱼、残骸），直到技能300，约需650次收获（225点时约每七次提升一点，到300时约每十次提升一点）。难度更高的水域不会让技能提升更快：无论在哪里，每次成功垂钓的作用相同。技能225起，在这片水域的鱼就不会逃脱，因此无需鱼饵。{item:6533}（技能100起可用，+100，2银币50铜币）和 {item:6532} 用于更难的水域和稀有鱼，而非提升技能。",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "{area:35}海岸",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "本阵营任何{skill:356}训练师都能传授初级{skill:356}（角色等级5）；箭头会指向最近的一位。从商品商人或钓鱼商人处购买一根{item:6256}并装备。",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "高级{skill:356}（上限225）是一本书，不是训练师等级：{zone:1434}南端{area:35}的{npc:2626}向两个阵营出售{item:16083}。购买并阅读；需要技能125和20级。",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "在这里钓鱼直到技能50。鱼漂溅起水花时点击它；每次钓到东西都可能提升技能。",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "在{zone:1444}的{area:2521}钓鱼，直到钓到{item:16967}；它只在那里上钩。",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "在{zone:1435}东南岸的{area:300}钓鱼，直到钓到{item:16970}；它只在那里上钩。",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "在{zone:1434}西北岸的{area:301}钓鱼，直到钓到{item:16969}；它只在那里上钩。",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "在{zone:1443}西北海岸的{area:598}（滑刃纳迦所在的海岸）钓鱼，直到钓到{item:16968}；它只在那里上钩。",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "在这里沿海岸的鱼群（鳗鱼、鲷鱼、残骸）钓鱼直到技能300。{area:35}出售鱼饵和{item:6530}，可略微提升钓鱼技能。",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "在这里的鱼群和开阔水域钓鱼直到技能125。鱼群（漂浮的残骸、鱼群）还会给额外战利品。",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "在这里的鱼群钓鱼直到技能225。如果鱼总是跑掉，就先去容易些的水域钓，等技能跟上。",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "中级{skill:356}将上限提升到150；需要技能50和角色等级10。箭头会指向本阵营最近的{skill:356}训练师。",
	-- ["Vile Fin shore"] = "邪鳍鱼人的岸边",
	-- ["{area:442} shore"] = "{area:442}岸边",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919}在塞拉摩岛以南、东海岸外一座小岛的岸边钓鱼。",
	-- ["{zone:1411} coast"] = "{zone:1411}海岸",
	-- ["{zone:1413} oasis"] = "{zone:1413}绿洲",
}
