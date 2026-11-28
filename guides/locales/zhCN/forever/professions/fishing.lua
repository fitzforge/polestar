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
	["No character level needed."] = "",

	-- Step 2: Buy a Fishing Pole
	-- {item:6256} Fishing Pole
	["Buy a {item:6256}"] = "",
	["Equipped like a weapon while you fish."] = "",

	-- Step 3: Buy 2 Shiny Baubles
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Buy 2 Shiny Baubles"] = "",
	-- {skill:356} Fishing
	["A lure: +25 {skill:356} for ten minutes, so fewer fish get away."] = "",

	-- Step 4: Equip the Fishing Pole
	-- {item:6256} Fishing Pole
	["Equip the {item:6256}"] = "",
	-- {skill:356} Fishing
	["{skill:356} needs the pole in your hands; your weapon goes back on after."] = "",

	-- Step 5: Put a Shiny Bauble on the pole
	-- {item:6529} Shiny Bauble
	["Put a {item:6529} on the pole"] = "",
	["It lasts ten minutes."] = "",

	-- Step 6: Fish near your starting area until 75 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish near your starting area until 75 · {skill:356}: Professions tab (K by default)"] = "",
	["Every catch gives a point."] = "",
	["Cast, then right-click the bobber when it splashes."] = "",

	-- Step 8: Reach level 10
	["Reach level 10"] = "",
	-- {skill:356} Fishing
	["Journeyman {skill:356} needs level 10."] = "",

	-- Step 9: Train Journeyman Fishing
	-- {skill:356} Fishing
	["Train Journeyman {skill:356}"] = "",
	-- {skill:356} Fishing
	["Needs {skill:356} skill 50 and level 10."] = "",

	-- Step 10: Fish in a capital or a nearby lake until 150 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in a capital or a nearby lake until 150 · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:6530} Nightcrawlers
	["{item:6530} on the pole help when fish keep getting away."] = "",

	-- Step 11: Reach level 20
	["Reach level 20"] = "",
	-- {skill:356} Fishing
	["Expert {skill:356} needs level 20."] = "",

	-- Step 12: Buy Expert Fishing - The Bass and You · Old Man Heming, Booty Bay
	-- {item:16083} Expert Fishing - The Bass and You · {npc:2626} Old Man Heming · {area:35} Booty Bay
	["Buy {item:16083} · {npc:2626}, {area:35}"] = "",
	["Sold there only, or at the Auction House."] = "",

	-- Step 13: Read Expert Fishing - The Bass and You
	-- {item:16083} Expert Fishing - The Bass and You
	-- was: ["Buy and read {item:16083} (Expert {skill:356})"] = "购买并阅读{item:16083}（高级{skill:356}）"
	["Read {item:16083}"] = "",
	-- {skill:356} Fishing
	["It teaches Expert {skill:356}: needs {skill:356} skill 125 and level 20."] = "",

	-- Step 14: Buy 11 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 11 {item:6532}"] = "",
	["For the water that loses fish below 225: ten minutes each, about 11 to 225."] = "",

	-- Step 15: Fish in the mid-level waters until 225 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in the mid-level waters until 225 · {skill:356}: Professions tab (K by default)"] = "",
	-- {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["{npc:12919}, who teaches Artisan, fishes in {zone:1445}."] = "",

	-- Step 16: Reach level 35
	["Reach level 35"] = "",
	-- {npc:12919} Nat Pagle
	["{npc:12919}'s quests need level 35."] = "",

	-- Step 17: Accept I Got Nothin' Left! · Grimnur Stonebrand, Ironforge
	-- {quest:6609} I Got Nothin' Left! · {npc:5161} Grimnur Stonebrand · {zone:1455} Ironforge
	["Accept {quest:6609} · {npc:5161}, {zone:1455}"] = "",
	-- {npc:12919} Nat Pagle
	["The fishing trainer sends you to {npc:12919}, who teaches Artisan."] = "",

	-- Step 18: Accept You Too Good. · Lumak, Orgrimmar
	-- {quest:6608} You Too Good. · {npc:3332} Lumak · {zone:1454} Orgrimmar
	["Accept {quest:6608} · {npc:3332}, {zone:1454}"] = "",

	-- Step 19: Hand in I Got Nothin' Left! · Nat Pagle, island off Dustwallow Marsh
	-- {quest:6609} I Got Nothin' Left! · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["Hand in {quest:6609} · {npc:12919}, island off {zone:1445}"] = "",
	["His island lies off the east coast, south of Theramore."] = "",

	-- Step 20: Hand in You Too Good. · Nat Pagle, island off Dustwallow Marsh
	-- {quest:6608} You Too Good. · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh
	["Hand in {quest:6608} · {npc:12919}, island off {zone:1445}"] = "",

	-- Step 21: Accept Nat Pagle, Angler Extreme · Nat Pagle
	-- {quest:6607} Nat Pagle, Angler Extreme · {npc:12919} Nat Pagle
	["Accept {quest:6607} · {npc:12919}"] = "",
	["Four fish, each from its own water; about one catch in five brings it up there."] = "",

	-- Step 22: Catch a Sar'theris Striker · Desolace's northern coast, by the tower · Fishing: Professions tab (K by default)
	-- {item:16968} Sar'theris Striker · {zone:1443} Desolace · {skill:356} Fishing
	["Catch a {item:16968} · {zone:1443}'s northern coast, by the tower · {skill:356}: Professions tab (K by default)"] = "",
	["It bites nowhere else."] = "",

	-- Step 23: Catch a Sar'theris Striker · Desolace coast by Shadowprey Village · Fishing: Professions tab (K by default)
	-- {item:16968} Sar'theris Striker · {zone:1443} Desolace · {area:2408} Shadowprey Village · {skill:356} Fishing
	["Catch a {item:16968} · {zone:1443} coast by {area:2408} · {skill:356}: Professions tab (K by default)"] = "",

	-- Step 24: Buy 2 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 2 {item:6532}"] = "",
	-- {zone:1444} Feralas
	["Fish get away in {zone:1444} below skill 300; a lure adds 75 for ten minutes."] = "",

	-- Step 25: Catch a Feralas Ahi · Verdantis River, west of the road bridge · Fishing: Professions tab (K by default)
	-- {item:16967} Feralas Ahi · {area:2521} Verdantis River · {skill:356} Fishing
	["Catch a {item:16967} · {area:2521}, west of the road bridge · {skill:356}: Professions tab (K by default)"] = "",

	-- Step 26: Catch a Savage Coast Blue Sailfin · Savage Coast, Stranglethorn Vale · Fishing: Professions tab (K by default)
	-- {item:16969} Savage Coast Blue Sailfin · {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {skill:356} Fishing
	["Catch a {item:16969} · {area:301}, {zone:1434} · {skill:356}: Professions tab (K by default)"] = "",
	-- {item:8364} Mithril Head Trout
	["Only {item:8364} and Catfish biting means another spot."] = "",

	-- Step 28: Catch a Misty Reed Mahi Mahi · Misty Reed Strand, Swamp of Sorrows · Fishing: Professions tab (K by default)
	-- {item:16970} Misty Reed Mahi Mahi · {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {skill:356} Fishing
	["Catch a {item:16970} · {area:300}, {zone:1435} · {skill:356}: Professions tab (K by default)"] = "",
	["The small islands keep you clear of the murlocs."] = "",

	-- Step 29: Hand in Nat Pagle, Angler Extreme
	-- {quest:6607} Nat Pagle, Angler Extreme
	["Hand in {quest:6607}"] = "",

	-- Step 30: Train Artisan Fishing
	-- {skill:356} Fishing
	["Train Artisan {skill:356}"] = "",
	-- {npc:12919} Nat Pagle · {skill:356} Fishing
	["{npc:12919} teaches it once his quest is done: needs {skill:356} skill 225 and level 35."] = "",

	-- Step 31: Buy 16 Bright Baubles
	-- {item:6532} Bright Baubles
	["Buy 16 {item:6532}"] = "",
	["For the water that loses fish below 300: ten minutes each, about 16 to 300."] = "",

	-- Step 32: Fish in the high-level waters until 300 · Fishing: Professions tab (K by default)
	-- {skill:356} Fishing
	["Fish in the high-level waters until 300 · {skill:356}: Professions tab (K by default)"] = "",
	["Fish get away here without a lure."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "本阵营任何{skill:356}训练师都能传授初级{skill:356}（角色等级5）；箭头会指向最近的一位。从商品商人或钓鱼商人处购买一根{item:6256}并装备。",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5, 1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "本阵营的任意{skill:356}训练师都教授初级{skill:356}（角色5级，1银）；箭头会选择最近的一位，每个初始地区的湖边或海岸都有训练师。向杂货商或钓鱼供应商购买一根{item:6256}（23铜）并装备（只有手持鱼竿才能钓鱼），再买两三个闪光的小珠（+25，每个50铜）：鱼饵可为技能提供持续十分钟的加成，减少刚开始钓鱼时的逃脱。如果你为“广阔天地”在初始地区的营火旁坐过，那里负责露营指引的NPC还会提供露营 101: {skill:356}任务；技能达到20时，向任务指定的钓鱼训练师交还，可获得{spell:1229745}配方。",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "本阵营的任意{skill:356}训练师都教授初级{skill:356}，没有角色等级要求（1银）；箭头会选择最近的一位，每个初始地区的湖边或海岸都有训练师。向杂货商或钓鱼供应商购买一根{item:6256}（23铜）并装备（只有手持鱼竿才能钓鱼），再买两三个闪光的小珠（+25，每个50铜）：鱼饵可为技能提供持续十分钟的加成，减少刚开始钓鱼时的逃脱。如果你为“广阔天地”在初始地区的营火旁坐过，那里负责露营指引的NPC还会提供“露营基础：{skill:356}”任务；技能达到20时，向任务指定的钓鱼训练师交还，可获得{spell:1229745}配方。",
	-- ["Artisan {skill:356}"] = "专家级{skill:356}",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "专家级{skill:356}（上限300）由{zone:1445}的{npc:12919}传授。{zone:1454}的钓鱼训练师会让你去找他；任务需要技能225和35级。",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "专家级{skill:356}（上限300）由{zone:1445}的{npc:12919}传授。{zone:1455}的钓鱼训练师会让你去找他；任务需要技能225和35级。",
	-- ["Buy and read {item:16083} (Expert {skill:356})"] = "购买并阅读{item:16083}（高级{skill:356}）",
	-- ["Expert {skill:356}"] = "高级{skill:356}",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "高级 {skill:356}（上限225）需要读书学习，不是训练师教授的等级：{npc:2626} 在 {zone:1434} 南端 {area:35} 最下层的码头出售 {item:16083}（1金币），双方阵营都能购买。买来阅读；需要技能125和角色20级。20级时，安全的前往方式是从 {zone:1413} 的 {area:392} 坐船，别沿路穿越荆棘谷。他还出售 {item:6532}（技能100起可用，+75，每个2银币50铜币），后续阶段可用它作鱼饵。",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "高级{skill:356}（上限225）是一本书，不是训练师等级：{zone:1434}南端{area:35}的{npc:2626}向两个阵营出售{item:16083}。购买并阅读；需要技能125和20级。",
	-- ["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "沿 {zone:1443} 海岸钓鱼（西北面的 {area:598}，或 {area:2408} 西面的海岸），直到钓到 {item:16968}：那里每次上钩约有五分之一概率是它，其他地方钓不到。技能225时，这里不会有鱼逃脱。",
	-- ["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "在 {zone:1444} 的 {area:2521} 沿岸垂钓（{area:2577} 东南方），直到钓到一条 {item:16967}：那里约每五次收获有一次能钓到，其他水域都钓不到。技能低于300时，这片水域的鱼会逃脱：225点时大多数都会跑掉，因此先给鱼竿装上 {item:6532}（+75）。",
	-- ["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "沿{area:300}（{zone:1435}东海岸）钓鱼，直到钓起一个{item:16970}：在这里约每五次能钓起一个，其他地方则钓不到。技能225时，这里的鱼都不会逃脱。",
	-- ["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "沿 {zone:1434} 的 {area:301}（西海岸）钓鱼，直到钓到 {item:16969}：那里每次上钩约有五分之一概率是它，其他地方钓不到。技能225时，这里不会有鱼逃脱。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "在这里钓到技能50，大约需钓起50条鱼：75以前每次钓起鱼都会提升技能。从法术书施放{skill:356}，鱼漂溅起水花时点击。把鱼留着：它们是你最初的{skill:185}材料。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: Nyoma ({zone:1438})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:10118} ({zone:1438}))."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。技能低于 25 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的 {item:6291} 用 {item:6325}（{skill:185} 1，40 铜币：Nyoma（{zone:1438}））；海岸的 {item:6303} 用 {item:6326}（{skill:185} 1，40 铜币：{npc:10118}（{zone:1438}））。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:3550} ({zone:1420}) or {npc:4574} ({zone:1458})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:3550} ({zone:1420}))."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。技能低于 25 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40 铜币：{npc:3550}（{zone:1420}）或{npc:4574}（{zone:1458}））；海岸的{item:6303}用{item:6326}（{skill:185} 1，40 铜币：{npc:3550}（{zone:1420}））。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}) or {npc:3029} ({zone:1456})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}))."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。技能低于 25 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40 铜币：{npc:5940}（{zone:1412}）或{npc:3029}（{zone:1456}））；海岸的{item:6303}用{item:6326}（{skill:185} 1，40 铜币：{npc:5942}（{zone:1411}））。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}) or {npc:5494} ({zone:1453})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}) or {npc:5162} ({zone:1455}))."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。技能低于 25 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40 铜币：{npc:66}（{zone:1429}）或{npc:5494}（{zone:1453}））；海岸的{item:6303}用{item:6326}（{skill:185} 1，40 铜币：{npc:4305}（{zone:1436}）或{npc:5162}（{zone:1455}））。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:8508} ({zone:1426}) or {npc:1684} ({zone:1432})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5162} ({zone:1455}) or {npc:4305} ({zone:1436}))."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。技能低于 25 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40 铜币：{npc:8508}（{zone:1426}）或{npc:1684}（{zone:1432}））；海岸的{item:6303}用{item:6326}（{skill:185} 1，40 铜币：{npc:5162}（{zone:1455}）或{npc:4305}（{zone:1436}））。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:257006} ({zone:2521})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:257006} ({zone:2521}))."] = "在这里钓到技能 50，约需钓起 50 条：75 以下每次成功钓起都会涨技能。从法术书施放 {skill:356}，浮漂溅水时点击。鱼留着：它们是你最初的 {skill:185} 材料。烹饪钓到的鱼：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40 铜币：{npc:257006}（{zone:2521}））；海岸的{item:6303}用{item:6326}（{skill:185} 1，40 铜币：{npc:257006}（{zone:2521}））。",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "在这里钓鱼直到技能50。鱼漂溅起水花时点击它；每次钓到东西都可能提升技能。",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "在{zone:1444}的{area:2521}钓鱼，直到钓到{item:16967}；它只在那里上钩。",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "在{zone:1435}东南岸的{area:300}钓鱼，直到钓到{item:16970}；它只在那里上钩。",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "在{zone:1434}西北岸的{area:301}钓鱼，直到钓到{item:16969}；它只在那里上钩。",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "在{zone:1443}西北海岸的{area:598}（滑刃纳迦所在的海岸）钓鱼，直到钓到{item:16968}；它只在那里上钩。",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "在此处沿海的鱼群和残骸处垂钓（鳗鱼、钳嘴鱼、残骸），直到技能300，约需650次收获（225点时约每七次提升一点，到300时约每十次提升一点）。难度更高的水域不会让技能提升更快：无论在哪里，每次成功垂钓的作用相同。技能225起，在这片水域的鱼就不会逃脱，因此无需鱼饵。{item:6533}（技能100起可用，+100，2银币50铜币）和 {item:6532} 用于更难的水域和稀有鱼，而非提升技能。",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "在这里沿海岸的鱼群（鳗鱼、鲷鱼、残骸）钓鱼直到技能300。{area:35}出售鱼饵和{item:6530}，可略微提升钓鱼技能。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: Nyoma ({zone:1438})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4307} ({zone:1439}) or {npc:10118} ({zone:1438})). {item:12238} bites only here: eat it as it is. {npc:10216} ({zone:1439}) takes 6 for The Family and the {item:6256}, which gives the {item:12221}. {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在这里的鱼群和普通水域钓到技能 125，约需钓起 120 次：75 起，每次钓起涨技能的概率会下降（100 时约二分之一，125 时约三分之一）。鱼群或漂浮残骸等水面钓鱼点还会产出额外战利品。{item:6530}（技能 50 起可用，+50，每个 1 银币）的加成是 {item:6529} 的两倍。{item:6365}（技能 10 起可用，+5，9 银 1 铜）在钓鱼商人处限量出售：看到就买。技能低于 75 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4 银币：奈欧玛（{zone:1438}））；海岸的{item:6361}用{item:6368}（{skill:185} 50，4 银币：{npc:4307}（{zone:1439}）或{npc:10118}（{zone:1438}））。{item:12238}只在这里上钩：可直接食用。{npc:10216}（{zone:1439}）收6条，用于任务“家人和{item:6256}”，该任务奖励{item:12221}。这里鱼群中的{item:6358}不能食用：炼金师用它制作{item:6370}（{skill:171} 80）；留着出售或交易。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:1684} ({zone:1432}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:3178} ({zone:1437}) or {npc:260487} ({zone:2548}))."] = "在这里的鱼群和普通水域钓到技能 125，约需钓起 120 次：75 起，每次钓起涨技能的概率会下降（100 时约二分之一，125 时约三分之一）。鱼群或漂浮残骸等水面钓鱼点还会产出额外战利品。{item:6530}（技能 50 起可用，+50，每个 1 银币）的加成是 {item:6529} 的两倍。{item:6365}（技能 10 起可用，+5，9 银 1 铜）在钓鱼商人处限量出售：看到就买。技能低于 75 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4 银币：{npc:1684}（{zone:1432}）或 {npc:5162}（{zone:1455}））；海岸的{item:6361}用{item:6368}（{skill:185} 50，4 银币：{npc:3178}（{zone:1437}）或 {npc:260487}（{zone:2548}））。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5748} ({zone:1421}) or {npc:4574} ({zone:1458})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4553} ({zone:1458}) or {npc:5748} ({zone:1421})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在这里的鱼群和普通水域钓到技能 125，约需钓起 120 次：75 起，每次钓起涨技能的概率会下降（100 时约二分之一，125 时约三分之一）。鱼群或漂浮残骸等水面钓鱼点还会产出额外战利品。{item:6530}（技能 50 起可用，+50，每个 1 银币）的加成是 {item:6529} 的两倍。{item:6365}（技能 10 起可用，+5，9 银 1 铜）在钓鱼商人处限量出售：看到就买。技能低于 75 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4 银币：{npc:5748}（{zone:1421}）或{npc:4574}（{zone:1458}））；海岸的{item:6361}用{item:6368}（{skill:185} 50，4 银币：{npc:4553}（{zone:1458}）或{npc:5748}（{zone:1421}））。这里鱼群中的{item:6358}不能食用：炼金师用它制作{item:6370}（{skill:171} 80）；留着出售或交易。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5940} ({zone:1412}) or {npc:3027} ({zone:1456})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5942} ({zone:1411}) or {npc:3333} ({zone:1454})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在这里的鱼群和普通水域钓到技能 125，约需钓起 120 次：75 起，每次钓起涨技能的概率会下降（100 时约二分之一，125 时约三分之一）。鱼群或漂浮残骸等水面钓鱼点还会产出额外战利品。{item:6530}（技能 50 起可用，+50，每个 1 银币）的加成是 {item:6529} 的两倍。{item:6365}（技能 10 起可用，+5，9 银 1 铜）在钓鱼商人处限量出售：看到就买。技能低于 75 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4 银币：{npc:5940}（{zone:1412}）或{npc:3027}（{zone:1456}））；海岸的{item:6361}用{item:6368}（{skill:185} 50，4 银币：{npc:5942}（{zone:1411}）或{npc:3333}（{zone:1454}））。这里鱼群中的{item:6358}不能食用：炼金师用它制作{item:6370}（{skill:171} 80）；留着出售或交易。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:66} ({zone:1429}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5494} ({zone:1453}) or {npc:4305} ({zone:1436})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在这里的鱼群和普通水域钓到技能 125，约需钓起 120 次：75 起，每次钓起涨技能的概率会下降（100 时约二分之一，125 时约三分之一）。鱼群或漂浮残骸等水面钓鱼点还会产出额外战利品。{item:6530}（技能 50 起可用，+50，每个 1 银币）的加成是 {item:6529} 的两倍。{item:6365}（技能 10 起可用，+5，9 银 1 铜）在钓鱼商人处限量出售：看到就买。技能低于 75 时，这里的鱼会逃脱；给鱼竿装上鱼饵可以提高技能，持续十分钟，弥补差距。烹饪钓到的鱼：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4 银币：{npc:66}（{zone:1429}）或{npc:5162}（{zone:1455}））；海岸的{item:6361}用{item:6368}（{skill:185} 50，4 银币：{npc:5494}（{zone:1453}）或{npc:4305}（{zone:1436}））。这里鱼群中的{item:6358}不能食用：炼金师用它制作{item:6370}（{skill:171} 80）；留着出售或交易。",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "在这里的鱼群和开阔水域钓鱼直到技能125。鱼群（漂浮的残骸、鱼群）还会给额外战利品。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2383} ({zone:1424}) or {npc:5494} ({zone:1453})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:3178} ({zone:1437}) or {npc:5162} ({zone:1455})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在这里的水池钓到技能225，约需钓上500条鱼：技能125时每3次约涨一点，到225时每7次才涨一点，所以这一段较长。无限的第二种露营物品{item:279965}（需要技能140）来自{area:2797}的格里哈斯特掉落的蓝图。技能低于150时，这里的鱼会逃脱；给鱼竿装上鱼饵可提高技能10分钟，补足差距。烹饪钓到的鱼：湖泊和河流的{item:6308}用{item:6330}（{skill:185} 100，12 银币：{npc:2383}（{zone:1424}）或{npc:5494}（{zone:1453}））；海岸的{item:6362}用{item:6369}（{skill:185} 175，22 银币：{npc:3178}（{zone:1437}）或{npc:5162}（{zone:1455}））。这里鱼群中的{item:6358}不能食用：炼金师用它制作{item:6370}（{skill:171} 80）；留着出售或交易。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2397} ({zone:1424}) or {npc:4553} ({zone:1458})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4574} ({zone:1458})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在这里的水池钓到技能225，约需钓上500条鱼：技能125时每3次约涨一点，到225时每7次才涨一点，所以这一段较长。无限的第二种露营物品{item:279965}（需要技能140）来自{area:2797}的格里哈斯特掉落的蓝图。技能低于150时，这里的鱼会逃脱；给鱼竿装上鱼饵可提高技能10分钟，补足差距。烹饪钓到的鱼：湖泊和河流的{item:6308}用{item:6330}（{skill:185} 100，12 银币：{npc:2397}（{zone:1424}）或{npc:4553}（{zone:1458}））；海岸的{item:6362}用{item:6369}（{skill:185} 175，22 银币：{npc:4574}（{zone:1458}））。这里鱼群中的{item:6358}不能食用：炼金师用它制作{item:6370}（{skill:171} 80）；留着出售或交易。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:3029} ({zone:1456}) or {npc:3027} ({zone:1456})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:12962} ({zone:1440}) or Wulan ({zone:1443}))."] = "在这里的水池钓到技能225，约需钓上500条鱼：技能125时每3次约涨一点，到225时每7次才涨一点，所以这一段较长。无限的第二种露营物品{item:279965}（需要技能140）来自{area:2797}的格里哈斯特掉落的蓝图。技能低于150时，这里的鱼会逃脱；给鱼竿装上鱼饵可提高技能10分钟，补足差距。烹饪钓到的鱼：湖泊和河流的{item:6308}用{item:6330}（{skill:185} 100，12 银币：{npc:3029}（{zone:1456}）或{npc:3027}（{zone:1456}））；海岸的{item:6362}用{item:6369}（{skill:185} 175，22 银币：{npc:12962}（{zone:1440}）或乌兰（{zone:1443}））。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4307} ({zone:1439}))."] = "在这里的水池钓到技能225，约需钓上500条鱼：技能125时每3次约涨一点，到225时每7次才涨一点，所以这一段较长。无限的第二种露营物品{item:279965}（需要技能140）来自{area:2797}的格里哈斯特掉落的蓝图。技能低于150时，这里的鱼会逃脱；给鱼竿装上鱼饵可提高技能10分钟，补足差距。烹饪钓到的鱼：海岸的{item:6362}用{item:6369}（{skill:185} 175，22银币：{npc:4307}（{zone:1439}））。",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "在这里的鱼群钓鱼直到技能225。如果鱼总是跑掉，就先去容易些的水域钓，等技能跟上。",
	-- ["Fish until skill 50, about 50 catches: below 75 every catch raises the skill, so any of your faction's starting-area shores will do and the arrow leads to the nearest: Sen'jin coast ({zone:1411}), {area:223} ({zone:1412}) and {area:162} ({zone:1420}), and for Skyborne also {area:16638} shore (Zephras Isle). Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away at these shores below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}), {npc:3550} ({zone:1420}) and {npc:257006} (Zephras Isle)); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}), {npc:3550} ({zone:1420}) and {npc:257006} (Zephras Isle))."] = "钓到技能50点，约50条鱼：75点以下每次捕获都会提升技能，所以你阵营出生区域的任何海岸都行，箭头会指向最近的：森金村海岸（{zone:1411}）、{area:223}（{zone:1412}）和{area:162}（{zone:1420}），天裔还可以去{area:16638}海岸（泽风岛）。从法术书中施放{skill:356}，浮标溅水时点击它。留下鱼：它们是你最早的{skill:185}材料。在这些海岸，技能低于25时鱼会逃走；鱼竿上的鱼饵能在十分钟内增加你的技能，弥补差距。烹饪你的渔获：{item:6325}用于湖泊与河流的{item:6291}（{skill:185} 1，40c：{npc:5940}（{zone:1412}）、{npc:3550}（{zone:1420}）和{npc:257006}（泽风岛））；{item:6326}用于海岸的{item:6303}（{skill:185} 1，40c：{npc:5942}（{zone:1411}）、{npc:3550}（{zone:1420}）和{npc:257006}（泽风岛））。",
	-- ["Fish until skill 50, about 50 catches: below 75 every catch raises the skill, so any of your faction's starting-area shores will do and the arrow leads to the nearest: {area:18} ({zone:1429}), {area:211} ({zone:1426}) and {area:702} ({zone:1438}), and for Skyborne also {area:16638} shore (Zephras Isle). Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away at these shores below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}), {npc:8508} ({zone:1426}), Nyoma ({zone:1438}) and {npc:257006} (Zephras Isle)); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}), {npc:5162} ({zone:1455}), {npc:10118} ({zone:1438}) and {npc:257006} (Zephras Isle))."] = "钓到技能50点，约50条鱼：75点以下每次捕获都会提升技能，所以你阵营出生区域的任何海岸都行，箭头会指向最近的：{area:18}（{zone:1429}）、{area:211}（{zone:1426}）和{area:702}（{zone:1438}），天裔还可以去{area:16638}海岸（泽风岛）。从法术书中施放{skill:356}，浮标溅水时点击它。留下鱼：它们是你最早的{skill:185}材料。在这些海岸，技能低于25时鱼会逃走；鱼竿上的鱼饵能在十分钟内增加你的技能，弥补差距。烹饪你的渔获：{item:6325}用于湖泊与河流的{item:6291}（{skill:185} 1，40c：{npc:66}（{zone:1429}）、{npc:8508}（{zone:1426}）、奈欧玛（{zone:1438}）和{npc:257006}（泽风岛））；{item:6326}用于海岸的{item:6303}（{skill:185} 1，40c：{npc:4305}（{zone:1436}）、{npc:5162}（{zone:1455}）、{npc:10118}（{zone:1438}）和{npc:257006}（泽风岛））。",
	-- ["Journeyman {skill:356}"] = "中级{skill:356}",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "中级{skill:356}将技能上限提高到150；需要技能50和角色10级（无限抓取到的训练师列表要求该等级），费用5银币。箭头指向本阵营最近的{skill:356}训练师。{spell:1229745}是无限的{skill:356}露营物品（需要技能20，1银币，也可通过“露营 101: {skill:356}”免费获得），就是把{item:6291}装在{item:3371}中：制作不涨技能，但放在营火旁后，营地里的所有人都能获得持续1小时的增益。",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "中级{skill:356}将上限提升到150；需要技能50和角色等级10。箭头会指向本阵营最近的{skill:356}训练师。",
	-- ["Sen'jin coast"] = "森金海岸",
	-- ["Vile Fin shore"] = "邪鳍鱼人的岸边",
	-- ["{area:16638} shore"] = "{area:16638}湖岸",
	-- ["{area:287} coast"] = "{area:287}海岸",
	-- ["{area:35} coast"] = "{area:35}海岸",
	-- ["{area:442} shore"] = "{area:442}岸边",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919}在塞拉摩岛以南、东海岸外一座小岛的岸边钓鱼。",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919}在东海岸外、塞拉摩南面的一座小岛岸边钓鱼；从海岸游过去。",
	-- ["{zone:1411} coast"] = "{zone:1411}海岸",
	-- ["{zone:1413} oasis"] = "{zone:1413}绿洲",
	-- ["{zone:1436} coast"] = "{zone:1436}海岸",
	-- ["{zone:1437} coast"] = "{zone:1437}海岸",
	-- ["{zone:1439} coast"] = "{zone:1439}海岸",
	-- ["{zone:1440} waters"] = "{zone:1440}水域",
}
