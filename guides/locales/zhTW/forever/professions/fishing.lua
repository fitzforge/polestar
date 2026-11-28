-- Chinese (traditional) (zhTW): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "學習{skill:356}",
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
	-- was: ["Buy and read {item:16083} (Expert {skill:356})"] = "購買並閱讀{item:16083}（高級{skill:356}）"
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
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "你陣營的任何{skill:356}訓練師都能教授初級{skill:356}（角色等級5）；箭頭會指向最近的一位。向商業用品或釣魚用品商人購買一根{item:6256}並裝備它。",
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "你陣營的任何{skill:356}訓練師都會教初級{skill:356}，不限角色等級（1銀）；箭頭會指向最近的一位，每個起始地區的湖邊或海岸都有一位。向雜貨商或釣魚供應商購買一根{item:6256}（23銅）並裝備（手上拿著魚竿才能釣魚），再買兩三個閃光的小珠（+25，每個50銅）：魚餌能在十分鐘內為技能提供加成，讓剛開始釣魚時少跑掉幾條魚。如果你為了「戶外真好」在起始地區的營火旁坐過，那裡的紮營嚮導也會提供「紮營入門指南：{skill:356}」，技能達到20時繳交給任務指定的釣魚訓練師，可獲得{spell:1229745}配方。",
	-- ["Artisan {skill:356}"] = "專家級{skill:356}",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1454}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",
	-- ["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1455}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",
	-- ["Buy and read {item:16083} (Expert {skill:356})"] = "購買並閱讀{item:16083}（高級{skill:356}）",
	-- ["Expert {skill:356}"] = "高級{skill:356}",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "高級{skill:356}（上限225）是一本書，不是訓練師的等級：{npc:2626}在{zone:1434}南端{area:35}最低層的碼頭上向雙方陣營販售{item:16083}（1金）。購買並閱讀它；需要技能125和等級20。20級時，安全的走法是從{zone:1413}的{area:392}搭船過去，而不是走穿過荊棘谷的道路。他也販售{item:6532}（技能100起+75，每個2銀50銅），這是之後一路要用的魚餌。",
	-- ["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{zone:1443}海岸（西北的{area:598}，或{area:2408}以西的岸邊）釣魚，直到釣上{item:16968}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",
	-- ["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "在{zone:1444}的{area:2521}（{area:2577}東南）釣魚，直到釣上{item:16967}：那裡約每五竿出一竿，別處不會咬鉤。這片水域在技能300以下會跑魚：225時大部分會跑掉，所以先給魚竿裝上{item:6532}（+75）。",
	-- ["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{area:300}（{zone:1435}東岸）釣魚，直到釣上{item:16970}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",
	-- ["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "在{zone:1434}的{area:301}（西岸）釣魚，直到釣上{item:16969}：那裡約每五竿出一竿，別處不會咬鉤。技能225時這裡不會跑魚。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:3550} ({zone:1420}) or {npc:4574} ({zone:1458})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:3550} ({zone:1420}))."] = "在這裡釣魚直到技能50，約需釣50次：75以下每釣到一次都會提升技能。從法術書施放{skill:356}，浮標濺起水花時點擊它。留著釣到的魚：牠們是你最早的{skill:185}材料。技能低於25時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40銅：{zone:1420}的{npc:3550}或{zone:1458}的{npc:4574}）；海岸的{item:6303}用{item:6326}（{skill:185} 1，40銅：{zone:1420}的{npc:3550}）。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}) or {npc:3029} ({zone:1456})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}))."] = "在這裡釣魚直到技能50，約需釣50次：75以下每釣到一次都會提升技能。從法術書施放{skill:356}，浮標濺起水花時點擊它。留著釣到的魚：牠們是你最早的{skill:185}材料。技能低於25時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40銅：{zone:1412}的{npc:5940}或{zone:1456}的{npc:3029}）；海岸的{item:6303}用{item:6326}（{skill:185} 1，40銅：{zone:1411}的{npc:5942}）。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}) or {npc:5494} ({zone:1453})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}) or {npc:5162} ({zone:1455}))."] = "在這裡釣魚直到技能50，約需釣50次：75以下每釣到一次都會提升技能。從法術書施放{skill:356}，浮標濺起水花時點擊它。留著釣到的魚：牠們是你最早的{skill:185}材料。技能低於25時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40銅：{zone:1429}的{npc:66}或{zone:1453}的{npc:5494}）；海岸的{item:6303}用{item:6326}（{skill:185} 1，40銅：{zone:1436}的{npc:4305}或{zone:1455}的{npc:5162}）。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:8508} ({zone:1426}) or {npc:1684} ({zone:1432})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5162} ({zone:1455}) or {npc:4305} ({zone:1436}))."] = "在這裡釣魚直到技能50，約需釣50次：75以下每釣到一次都會提升技能。從法術書施放{skill:356}，浮標濺起水花時點擊它。留著釣到的魚：牠們是你最早的{skill:185}材料。技能低於25時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40銅：{zone:1426}的{npc:8508}或{zone:1432}的{npc:1684}）；海岸的{item:6303}用{item:6326}（{skill:185} 1，40銅：{zone:1455}的{npc:5162}或{zone:1436}的{npc:4305}）。",
	-- ["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:257006} ({zone:2521})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:257006} ({zone:2521}))."] = "在這裡釣魚直到技能50，約需釣50次：75以下每釣到一次都會提升技能。從法術書施放{skill:356}，浮標濺起水花時點擊它。留著釣到的魚：牠們是你最早的{skill:185}材料。烹飪你釣到的魚：湖泊和河流的{item:6291}用{item:6325}（{skill:185} 1，40銅：{zone:2521}的{npc:257006}）；海岸的{item:6303}用{item:6326}（{skill:185} 1，40銅：{zone:2521}的{npc:257006}）。",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "在這裡釣魚直到技能達到50。浮標濺起水花時點擊它；每次釣到東西都可能提升技能。",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "在{zone:1444}的{area:2521}釣魚，直到釣到{item:16967}；它只在那裡上鉤。",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "在{zone:1435}東南岸的{area:300}釣魚，直到釣到{item:16970}；它只在那裡上鉤。",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "在{zone:1434}西北岸的{area:301}釣魚，直到釣到{item:16969}；它只在那裡上鉤。",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "在{zone:1443}西北海岸的{area:598}（滑刃納迦的海岸）釣魚，直到釣到{item:16968}；它只在那裡上鉤。",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "在此沿岸的魚群（鰻魚、鯛魚、殘骸）中釣魚，直到技能300，約650竿（225時約七竿漲一點，300時約十竿一點）。更高階的水域並不會更快：任何地方一竿的收益都一樣。技能225起這片水域不會跑魚，所以不需要魚餌。{item:6533}（技能100起可用，+100，2銀50銅）和{item:6532}是用於更高階水域和稀有魚的，不是用來練技能的。",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "在這裡沿岸的魚群（鰻魚、笛鯛、殘骸）釣魚，直到技能達到300。{area:35}販售魚餌和{item:6530}，可稍微提高釣魚加成。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: Nyoma ({zone:1438})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4307} ({zone:1439}) or {npc:10118} ({zone:1438})). {item:12238} bites only here: eat it as it is. {npc:10216} ({zone:1439}) takes 6 for The Family and the {item:6256}, which gives the {item:12221}. {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在這裡的釣魚點和開闊水域釣魚直到技能125，約需釣120次：從75起，釣到魚提升技能的機率變低（100時約二分之一，125時約三分之一）。釣魚點（漂浮的殘骸、魚群）也會給額外的戰利品。{item:6530}（技能50起+50，每個1銀）的效果是{item:6529}的兩倍。{item:6365}（技能10起+5，9銀1銅）在釣魚供應商處限量供應：看到就買。技能低於75時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4銀：{zone:1438}的妮歐瑪）；海岸的{item:6361}用{item:6368}（{skill:185} 50，4銀：{zone:1439}的{npc:4307}或{zone:1438}的{npc:10118}）。{item:12238}只在這裡上鉤：直接食用即可。{zone:1439}的{npc:10216}會為了「家族與{item:6256}」收下6條，獎勵是{item:12221}。這裡魚群釣到的{item:6358}不能吃：鍊金術師可以用它製作{item:6370}（{skill:171} 80）；留著賣掉或交易。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:1684} ({zone:1432}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:3178} ({zone:1437}) or {npc:260487} ({zone:2548}))."] = "在這裡的魚群和普通水域釣到技能 125，約需釣起 120 次：75 起，每次釣起漲技能的機率會下降（100 時約二分之一，125 時約三分之一）。魚群或漂浮殘骸等水面釣魚點還會產出額外戰利品。{item:6530}（技能 50 起可用，+50，每個 1 銀幣）的加成是 {item:6529} 的兩倍。{item:6365}（技能 10 起可用，+5，9 銀 1 銅）在釣魚商人處限量出售：看到就買。技能低於 75 時，這裡的魚會逃脫；給魚竿裝上魚餌可以提高技能，持續十分鐘，彌補差距。烹飪釣到的魚：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4 銀幣：{npc:1684}（{zone:1432}）或 {npc:5162}（{zone:1455}））；海岸的{item:6361}用{item:6368}（{skill:185} 50，4 銀幣：{npc:3178}（{zone:1437}）或 {npc:260487}（{zone:2548}））。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5748} ({zone:1421}) or {npc:4574} ({zone:1458})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4553} ({zone:1458}) or {npc:5748} ({zone:1421})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在這裡的釣魚點和開闊水域釣魚直到技能125，約需釣120次：從75起，釣到魚提升技能的機率變低（100時約二分之一，125時約三分之一）。釣魚點（漂浮的殘骸、魚群）也會給額外的戰利品。{item:6530}（技能50起+50，每個1銀）的效果是{item:6529}的兩倍。{item:6365}（技能10起+5，9銀1銅）在釣魚供應商處限量供應：看到就買。技能低於75時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4銀：{zone:1421}的{npc:5748}或{zone:1458}的{npc:4574}）；海岸的{item:6361}用{item:6368}（{skill:185} 50，4銀：{zone:1458}的{npc:4553}或{zone:1421}的{npc:5748}）。這裡魚群釣到的{item:6358}不能吃：鍊金術師可以用它製作{item:6370}（{skill:171} 80）；留著賣掉或交易。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5940} ({zone:1412}) or {npc:3027} ({zone:1456})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5942} ({zone:1411}) or {npc:3333} ({zone:1454})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在這裡的釣魚點和開闊水域釣魚直到技能125，約需釣120次：從75起，釣到魚提升技能的機率變低（100時約二分之一，125時約三分之一）。釣魚點（漂浮的殘骸、魚群）也會給額外的戰利品。{item:6530}（技能50起+50，每個1銀）的效果是{item:6529}的兩倍。{item:6365}（技能10起+5，9銀1銅）在釣魚供應商處限量供應：看到就買。技能低於75時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4銀：{zone:1412}的{npc:5940}或{zone:1456}的{npc:3027}）；海岸的{item:6361}用{item:6368}（{skill:185} 50，4銀：{zone:1411}的{npc:5942}或{zone:1454}的{npc:3333}）。這裡魚群釣到的{item:6358}不能吃：鍊金術師可以用它製作{item:6370}（{skill:171} 80）；留著賣掉或交易。",
	-- ["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:66} ({zone:1429}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5494} ({zone:1453}) or {npc:4305} ({zone:1436})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在這裡的釣魚點和開闊水域釣魚直到技能125，約需釣120次：從75起，釣到魚提升技能的機率變低（100時約二分之一，125時約三分之一）。釣魚點（漂浮的殘骸、魚群）也會給額外的戰利品。{item:6530}（技能50起+50，每個1銀）的效果是{item:6529}的兩倍。{item:6365}（技能10起+5，9銀1銅）在釣魚供應商處限量供應：看到就買。技能低於75時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6289}用{item:6328}（{skill:185} 50，4銀：{zone:1429}的{npc:66}或{zone:1455}的{npc:5162}）；海岸的{item:6361}用{item:6368}（{skill:185} 50，4銀：{zone:1453}的{npc:5494}或{zone:1436}的{npc:4305}）。這裡魚群釣到的{item:6358}不能吃：鍊金術師可以用它製作{item:6370}（{skill:171} 80）；留著賣掉或交易。",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "在這裡的魚群和開闊水域釣魚，直到技能達到125。魚群（漂浮的殘骸、魚群）也會掉落額外的戰利品。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2383} ({zone:1424}) or {npc:5494} ({zone:1453})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:3178} ({zone:1437}) or {npc:5162} ({zone:1455})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在這裡的釣魚點釣魚直到技能225，約需釣500次：125時約三次提升一次，到225時約七次一次，所以這是最漫長的一段。Forever的第二件露營物品{item:279965}（技能140起）是一張藍圖，由{area:2797}的格里哈斯特掉落。技能低於150時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6308}用{item:6330}（{skill:185} 100，12銀：{zone:1424}的{npc:2383}或{zone:1453}的{npc:5494}）；海岸的{item:6362}用{item:6369}（{skill:185} 175，22銀：{zone:1437}的{npc:3178}或{zone:1455}的{npc:5162}）。這裡魚群釣到的{item:6358}不能吃：鍊金術師可以用它製作{item:6370}（{skill:171} 80）；留著賣掉或交易。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2397} ({zone:1424}) or {npc:4553} ({zone:1458})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4574} ({zone:1458})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "在這裡的釣魚點釣魚直到技能225，約需釣500次：125時約三次提升一次，到225時約七次一次，所以這是最漫長的一段。Forever的第二件露營物品{item:279965}（技能140起）是一張藍圖，由{area:2797}的格里哈斯特掉落。技能低於150時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6308}用{item:6330}（{skill:185} 100，12銀：{zone:1424}的{npc:2397}或{zone:1458}的{npc:4553}）；海岸的{item:6362}用{item:6369}（{skill:185} 175，22銀：{zone:1458}的{npc:4574}）。這裡魚群釣到的{item:6358}不能吃：鍊金術師可以用它製作{item:6370}（{skill:171} 80）；留著賣掉或交易。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:3029} ({zone:1456}) or {npc:3027} ({zone:1456})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:12962} ({zone:1440}) or Wulan ({zone:1443}))."] = "在這裡的釣魚點釣魚直到技能225，約需釣500次：125時約三次提升一次，到225時約七次一次，所以這是最漫長的一段。Forever的第二件露營物品{item:279965}（技能140起）是一張藍圖，由{area:2797}的格里哈斯特掉落。技能低於150時，這裡的魚會脫鉤跑掉；在魚竿上裝魚餌可在十分鐘內提高技能，補上差距。烹飪你釣到的魚：湖泊和河流的{item:6308}用{item:6330}（{skill:185} 100，12銀：{zone:1456}的{npc:3029}或{zone:1456}的{npc:3027}）；海岸的{item:6362}用{item:6369}（{skill:185} 175，22銀：{zone:1440}的{npc:12962}或{zone:1443}的烏蘭）。",
	-- ["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4307} ({zone:1439}))."] = "在這裡的水池釣到技能225，約需釣上500條魚：技能125時每3次約漲一點，到225時每7次才漲一點，所以這一段較長。無限的第二種露營物品{item:279965}（需要技能140）來自{area:2797}的格里哈斯特掉落的藍圖。技能低於150時，這裡的魚會逃脫；給魚竿裝上魚餌可提高技能10分鐘，補足差距。烹飪釣到的魚：海岸的{item:6362}用{item:6369}（{skill:185} 175，22銀幣：{npc:4307}（{zone:1439}））。",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "在這裡的魚群釣魚，直到技能達到225。如果魚一直脫鉤，就到較容易的水域釣，直到技能跟上。",
	-- ["Fish until skill 50, about 50 catches: below 75 every catch raises the skill, so any of your faction's starting-area shores will do and the arrow leads to the nearest: Sen'jin coast ({zone:1411}), {area:223} ({zone:1412}) and {area:162} ({zone:1420}), and for Skyborne also {area:16638} shore (Zephras Isle). Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away at these shores below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}), {npc:3550} ({zone:1420}) and {npc:257006} (Zephras Isle)); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}), {npc:3550} ({zone:1420}) and {npc:257006} (Zephras Isle))."] = "釣到技能50點，約50條魚：75點以下每次捕獲都會提升技能，所以你陣營出生區域的任何海岸都行，箭頭會指向最近的：森金村海岸（{zone:1411}）、{area:223}（{zone:1412}）和{area:162}（{zone:1420}），天行者還可以去{area:16638}海岸（澤菲拉斯島）。從法術書中施放{skill:356}，浮標濺水時點選它。留下魚：它們是你最早的{skill:185}材料。在這些海岸，技能低於25時魚會逃走；魚竿上的魚餌能在十分鐘內增加你的技能，彌補差距。烹飪你的漁獲：{item:6325}用於湖泊與河流的{item:6291}（{skill:185} 1，40c：{npc:5940}（{zone:1412}）、{npc:3550}（{zone:1420}）和{npc:257006}（澤菲拉斯島））；{item:6326}用於海岸的{item:6303}（{skill:185} 1，40c：{npc:5942}（{zone:1411}）、{npc:3550}（{zone:1420}）和{npc:257006}（澤菲拉斯島））。",
	-- ["Fish until skill 50, about 50 catches: below 75 every catch raises the skill, so any of your faction's starting-area shores will do and the arrow leads to the nearest: {area:18} ({zone:1429}), {area:211} ({zone:1426}) and {area:702} ({zone:1438}), and for Skyborne also {area:16638} shore (Zephras Isle). Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away at these shores below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}), {npc:8508} ({zone:1426}), Nyoma ({zone:1438}) and {npc:257006} (Zephras Isle)); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}), {npc:5162} ({zone:1455}), {npc:10118} ({zone:1438}) and {npc:257006} (Zephras Isle))."] = "釣到技能50點，約50條魚：75點以下每次捕獲都會提升技能，所以你陣營出生區域的任何海岸都行，箭頭會指向最近的：{area:18}（{zone:1429}）、{area:211}（{zone:1426}）和{area:702}（{zone:1438}），天行者還可以去{area:16638}海岸（澤菲拉斯島）。從法術書中施放{skill:356}，浮標濺水時點選它。留下魚：它們是你最早的{skill:185}材料。在這些海岸，技能低於25時魚會逃走；魚竿上的魚餌能在十分鐘內增加你的技能，彌補差距。烹飪你的漁獲：{item:6325}用於湖泊與河流的{item:6291}（{skill:185} 1，40c：{npc:66}（{zone:1429}）、{npc:8508}（{zone:1426}）、Nyoma（{zone:1438}）和{npc:257006}（澤菲拉斯島））；{item:6326}用於海岸的{item:6303}（{skill:185} 1，40c：{npc:4305}（{zone:1436}）、{npc:5162}（{zone:1455}）、{npc:10118}（{zone:1438}）和{npc:257006}（澤菲拉斯島））。",
	-- ["Journeyman {skill:356}"] = "中級{skill:356}",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "中級{skill:356}將技能上限提高到150；需要技能50和角色10級（無限抓取到的訓練師列表要求該等級），費用5銀幣。箭頭指向本陣營最近的{skill:356}訓練師。{spell:1229745}是無限的{skill:356}露營物品（需要技能20，1銀幣，也可透過“露營 101: {skill:356}”免費獲得），就是把{item:6291}裝在{item:3371}中：製作不漲技能，但放在營火旁後，營地裡的所有人都能獲得持續1小時的增益。",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "中級{skill:356}將上限提高到150；需要技能50和角色等級10。箭頭會指向你陣營最近的{skill:356}訓練師。",
	-- ["Sen'jin coast"] = "森金海岸",
	-- ["Vile Fin shore"] = "邪鰭魚人海岸",
	-- ["{area:16638} shore"] = "{area:16638}岸邊",
	-- ["{area:287} coast"] = "{area:287}海岸",
	-- ["{area:35} coast"] = "{area:35}海岸",
	-- ["{area:442} shore"] = "{area:442}海岸",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "{npc:12919}在塞拉摩南邊、東海岸外一座小島的岸邊釣魚；從海岸游過去。",
	-- ["{zone:1411} coast"] = "{zone:1411}海岸",
	-- ["{zone:1413} oasis"] = "{zone:1413}綠洲",
	-- ["{zone:1436} coast"] = "{zone:1436}海岸",
	-- ["{zone:1437} coast"] = "{zone:1437}海岸",
	-- ["{zone:1439} coast"] = "{zone:1439}海岸",
	-- ["{zone:1440} waters"] = "{zone:1440}水域",
}
