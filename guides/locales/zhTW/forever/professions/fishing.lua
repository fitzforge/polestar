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
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients."] = "",
	-- {area:16638} Valanaar
	["{area:16638} shore"] = "",

	-- Step 6: Fishing: Durotar (1-50)
	["Sen'jin coast"] = "",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "中級{skill:356}",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "{zone:1436}海岸",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "{zone:1439}海岸",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "{zone:1413}綠洲",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "高級{skill:356}",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "購買並閱讀{item:16083}（高級{skill:356}）",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap."] = "",
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
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1455}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "專家級{skill:356}（上限300）來自{zone:1445}的{npc:12919}。{zone:1454}的釣魚訓練師會派你去找他；任務需要技能225和等級35。",

	-- Step 23: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast."] = "",

	-- Step 24: Sar'theris Striker
	-- {zone:1443} Desolace · {area:598} Sar'theris Strand · {area:2408} Shadowprey Village · {item:16968} Sar'theris Striker
	["Fish along the coast of {zone:1443} ({area:598} in the north-west, or the shore west of {area:2408}) until you catch a {item:16968}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "",

	-- Step 26: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {area:2577} Dire Maul · {item:16967} Feralas Ahi · {item:6532} Bright Baubles
	["Fish along the {area:2521} in {zone:1444} (south-east of {area:2577}) until you catch a {item:16967}: about one catch in five there brings it up, and it bites nowhere else. This water loses fish below skill 300: at 225 most get away, so put {item:6532} (+75) on the pole first."] = "",

	-- Step 27: Savage Coast Blue Sailfin
	-- {zone:1434} Stranglethorn Vale · {area:301} Savage Coast · {item:16969} Savage Coast Blue Sailfin
	["Fish along {zone:1434}'s {area:301} (the west shore) until you catch a {item:16969}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "",

	-- Step 29: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish along the {area:300} (the east shore of {zone:1435}) until you catch a {item:16970}: about one catch in five there brings it up, and it bites nowhere else. At skill 225 nothing gets away here."] = "",

	-- Step 30: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "專家級{skill:356}",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "{area:35}海岸",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "你陣營的任何{skill:356}訓練師都能教授初級{skill:356}（角色等級5）；箭頭會指向最近的一位。向商業用品或釣魚用品商人購買一根{item:6256}並裝備它。",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "高級{skill:356}（上限225）是一本書，不是訓練師的等級：{npc:2626}在{zone:1434}南端的{area:35}向雙方陣營販售{item:16083}。購買並閱讀它；需要技能125和等級20。",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "在這裡釣魚直到技能達到50。浮標濺起水花時點擊它；每次釣到東西都可能提升技能。",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "在{zone:1444}的{area:2521}釣魚，直到釣到{item:16967}；它只在那裡上鉤。",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "在{zone:1435}東南岸的{area:300}釣魚，直到釣到{item:16970}；它只在那裡上鉤。",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "在{zone:1434}西北岸的{area:301}釣魚，直到釣到{item:16969}；它只在那裡上鉤。",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "在{zone:1443}西北海岸的{area:598}（滑刃納迦的海岸）釣魚，直到釣到{item:16968}；它只在那裡上鉤。",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "在這裡沿岸的魚群（鰻魚、笛鯛、殘骸）釣魚，直到技能達到300。{area:35}販售魚餌和{item:6530}，可稍微提高釣魚加成。",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "在這裡的魚群和開闊水域釣魚，直到技能達到125。魚群（漂浮的殘骸、魚群）也會掉落額外的戰利品。",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "在這裡的魚群釣魚，直到技能達到225。如果魚一直脫鉤，就到較容易的水域釣，直到技能跟上。",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "中級{skill:356}將上限提高到150；需要技能50和角色等級10。箭頭會指向你陣營最近的{skill:356}訓練師。",
	-- ["Vile Fin shore"] = "邪鰭魚人海岸",
	-- ["{area:442} shore"] = "{area:442}海岸",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919}在塞拉摩南邊、東海岸外一座小島的岸邊釣魚。",
	-- ["{zone:1411} coast"] = "{zone:1411}海岸",
	-- ["{zone:1413} oasis"] = "{zone:1413}綠洲",
}
