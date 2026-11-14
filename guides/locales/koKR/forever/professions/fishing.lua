-- Korean (koKR): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "{skill:356} 배우기",
	-- {skill:356} Fishing · {item:6256} Fishing Pole · {spell:1229745} Fish Bowl
	-- plural, as words: Shiny Baubles = {item:6529} Shiny Bauble
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} at any character level (1s); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a {item:6256} (23c) from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles (+25, 50c each): a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:356}, handed in to the fishing trainer it names at skill 20 for the {spell:1229745} recipe."] = "진영의 모든 {skill:356} 상급자가 캐릭터 레벨에 관계없이 초급 {skill:356}을(를) 가르칩니다(1실버). 화살표가 가장 가까운 상급자를 가리키며, 시작 지역마다 호숫가나 해안에 한 명씩 있습니다. 잡화 상인이나 낚시 상인에게서 {item:6256}(23코퍼)을(를) 사서 장착하고(낚싯대를 손에 들어야 낚시할 수 있습니다), 반짝이는 미끼(+25, 개당 50코퍼)도 두세 개 사세요. 미끼는 10분 동안 숙련도에 보너스를 더해 주므로 처음에 놓치는 물고기가 줄어듭니다. '드넓은 야외' 때문에 시작 지역의 모닥불 옆에 앉았다면, 그곳 야영 안내인이 '야영 입문: {skill:356}'도 주며, 숙련도 20에 퀘스트에 적힌 낚시 상급자에게 제출하면 {spell:1229745} 제조법을 받습니다.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6325} Recipe: Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:5494} Catherine Leland · {zone:1453} Stormwind City · {item:6326} Recipe: Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {npc:4305} Kriggon Talsone · {zone:1436} Westfall · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:66} ({zone:1429}) or {npc:5494} ({zone:1453})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:4305} ({zone:1436}) or {npc:5162} ({zone:1455}))."] = "",

	-- Step 3: Fishing: Dun Morogh (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6325} Recipe: Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {npc:8508} Gretta Ganter · {zone:1426} Dun Morogh · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {item:6326} Recipe: Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {npc:4305} Kriggon Talsone · {zone:1436} Westfall
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:8508} ({zone:1426}) or {npc:1684} ({zone:1432})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5162} ({zone:1455}) or {npc:4305} ({zone:1436}))."] = "",

	-- Step 4: Fishing: Teldrassil (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6325} Recipe: Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {zone:1438} Teldrassil · {item:6326} Recipe: Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {npc:10118} Nessa Shadowsong
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: Nyoma ({zone:1438})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:10118} ({zone:1438}))."] = "",

	-- Step 5: Fishing: Zephras Isle (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6325} Recipe: Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {npc:257006} Nyalah Brightfire · {zone:2521} Zephras Isle · {item:6326} Recipe: Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:257006} ({zone:2521})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:257006} ({zone:2521}))."] = "",
	-- {area:16638} Valanaar
	["{area:16638} shore"] = "",

	-- Step 6: Fishing: Durotar (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6325} Recipe: Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {npc:5940} Harn Longcast · {zone:1412} Mulgore · {npc:3029} Sewa Mistrunner · {zone:1456} Thunder Bluff · {item:6326} Recipe: Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel · {npc:5942} Zansoa · {zone:1411} Durotar
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:5940} ({zone:1412}) or {npc:3029} ({zone:1456})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:5942} ({zone:1411}))."] = "",
	["Sen'jin coast"] = "",

	-- Step 8: Fishing: Tirisfal Glades (1-50)
	-- {skill:356} Fishing · {skill:185} Cooking · {item:6325} Recipe: Brilliant Smallfish · {item:6291} Raw Brilliant Smallfish · {npc:3550} Martine Tramblay · {zone:1420} Tirisfal Glades · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity · {item:6326} Recipe: Slitherskin Mackerel · {item:6303} Raw Slitherskin Mackerel
	["Fish here until skill 50, about 50 catches: below 75 every catch raises the skill. Cast {skill:356} from your spellbook, click the bobber when it splashes. Keep the fish: they are your first {skill:185} ingredients. Fish get away here below skill 25; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6325} for the {item:6291} of lakes and rivers ({skill:185} 1, 40c: {npc:3550} ({zone:1420}) or {npc:4574} ({zone:1458})); {item:6326} for the {item:6303} of the coast ({skill:185} 1, 40c: {npc:3550} ({zone:1420}))."] = "",

	-- Step 10: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "수습 {skill:356}",
	-- {skill:356} Fishing · {spell:1229745} Fish Bowl · {item:6291} Raw Brilliant Smallfish · {item:3371} Empty Vial
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10 (Forever's sniffed trainer lists ask for that level), and costs 5s. The arrow picks the nearest {skill:356} trainer of your faction. {spell:1229745}, Forever's camping item for {skill:356} (from skill 20, 1s or free from Camping 101: {skill:356}), is a {item:6291} in an {item:3371}: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour."] = "",

	-- Step 11: Fishing: Westfall (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole · {item:6328} Recipe: Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {npc:66} Tharynn Bouden · {zone:1429} Elwynn Forest · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {item:6368} Recipe: Rainbow Fin Albacore · {item:6361} Raw Rainbow Fin Albacore · {npc:5494} Catherine Leland · {zone:1453} Stormwind City · {npc:4305} Kriggon Talsone · {zone:1436} Westfall · {item:6358} Oily Blackmouth · {item:6370} Blackmouth Oil · {skill:171} Alchemy
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:66} ({zone:1429}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5494} ({zone:1453}) or {npc:4305} ({zone:1436})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "{zone:1436} 해안",

	-- Step 12: Fishing: Loch Modan (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole · {item:6328} Recipe: Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {npc:1684} Khara Deepwater · {zone:1432} Loch Modan · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {item:6368} Recipe: Rainbow Fin Albacore · {item:6361} Raw Rainbow Fin Albacore · {npc:3178} Stuart Fleming · {zone:1437} Wetlands · {npc:260487} Gritta Chumwater · {zone:2548} Riverglades
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:1684} ({zone:1432}) or {npc:5162} ({zone:1455})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:3178} ({zone:1437}) or {npc:260487} ({zone:2548}))."] = "",

	-- Step 13: Fishing: Darkshore (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole · {item:6328} Recipe: Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {zone:1438} Teldrassil · {item:6368} Recipe: Rainbow Fin Albacore · {item:6361} Raw Rainbow Fin Albacore · {npc:4307} Heldan Galesong · {zone:1439} Darkshore · {npc:10118} Nessa Shadowsong · {item:12238} Darkshore Grouper · {npc:10216} Gubber Blump · {item:6256} Fishing Pole · {item:12221} Blump Family Fishing Pole · {item:6358} Oily Blackmouth · {item:6370} Blackmouth Oil · {skill:171} Alchemy
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: Nyoma ({zone:1438})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4307} ({zone:1439}) or {npc:10118} ({zone:1438})). {item:12238} bites only here: eat it as it is. {npc:10216} ({zone:1439}) takes 6 for The Family and the {item:6256}, which gives the {item:12221}. {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "",
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "{zone:1439} 해안",

	-- Step 14: Fishing: The Barrens (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole · {item:6328} Recipe: Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {npc:5940} Harn Longcast · {zone:1412} Mulgore · {npc:3027} Naal Mistrunner · {zone:1456} Thunder Bluff · {item:6368} Recipe: Rainbow Fin Albacore · {item:6361} Raw Rainbow Fin Albacore · {npc:5942} Zansoa · {zone:1411} Durotar · {npc:3333} Shankys · {zone:1454} Orgrimmar · {item:6358} Oily Blackmouth · {item:6370} Blackmouth Oil · {skill:171} Alchemy
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5940} ({zone:1412}) or {npc:3027} ({zone:1456})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:5942} ({zone:1411}) or {npc:3333} ({zone:1454})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "",
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "{zone:1413} 오아시스",

	-- Step 15: Fishing: Silverpine Forest (50-125)
	-- {item:6530} Nightcrawlers · {item:6529} Shiny Bauble · {item:6365} Strong Fishing Pole · {item:6328} Recipe: Longjaw Mud Snapper · {item:6289} Raw Longjaw Mud Snapper · {skill:185} Cooking · {npc:5748} Killian Sanatha · {zone:1421} Silverpine Forest · {npc:4574} Lizbeth Cromwell · {zone:1458} Undercity · {item:6368} Recipe: Rainbow Fin Albacore · {item:6361} Raw Rainbow Fin Albacore · {npc:4553} Ronald Burch · {item:6358} Oily Blackmouth · {item:6370} Blackmouth Oil · {skill:171} Alchemy
	["Fish the pools and open water here until skill 125, about 120 catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. {item:6530} (+50 from skill 50, 1s each) are twice as strong as a {item:6529}. The {item:6365} (+5 from skill 10, 9s 1c) is in limited stock at fishing vendors: buy it when you see it. Fish get away here below skill 75; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6328} for the {item:6289} of lakes and rivers ({skill:185} 50, 4s: {npc:5748} ({zone:1421}) or {npc:4574} ({zone:1458})); {item:6368} for the {item:6361} of the coast ({skill:185} 50, 4s: {npc:4553} ({zone:1458}) or {npc:5748} ({zone:1421})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "",

	-- Step 16: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "숙련 {skill:356}",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale · {area:392} Ratchet · {zone:1413} The Barrens · {item:6532} Bright Baubles
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} (1g) on the lowest dock of {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20. At level 20 the safe way in is the boat from {area:392} in {zone:1413}, not the road through Stranglethorn. He also sells {item:6532} (+75 from skill 100, 2s 50c each), the lure for the rest of the way."] = "",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "{item:16083} 사서 읽기 (숙련 {skill:356})",

	-- Step 17: Fishing: Wetlands (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps · {item:6330} Recipe: Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {npc:2383} Lindea Rabonne · {zone:1424} Hillsbrad Foothills · {npc:5494} Catherine Leland · {zone:1453} Stormwind City · {item:6369} Recipe: Rockscale Cod · {item:6362} Raw Rockscale Cod · {npc:3178} Stuart Fleming · {zone:1437} Wetlands · {npc:5162} Tansy Puddlefizz · {zone:1455} Ironforge · {item:6358} Oily Blackmouth · {item:6370} Blackmouth Oil · {skill:171} Alchemy
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2383} ({zone:1424}) or {npc:5494} ({zone:1453})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:3178} ({zone:1437}) or {npc:5162} ({zone:1455})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "{zone:1437} 해안",

	-- Step 18: Fishing: Ashenvale (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps · {item:6369} Recipe: Rockscale Cod · {item:6362} Raw Rockscale Cod · {skill:185} Cooking · {npc:4307} Heldan Galesong · {zone:1439} Darkshore
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4307} ({zone:1439}))."] = "",
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "{zone:1440} 바다",

	-- Step 19: Fishing: Stonetalon Mountains (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps · {item:6330} Recipe: Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {npc:3029} Sewa Mistrunner · {zone:1456} Thunder Bluff · {npc:3027} Naal Mistrunner · {item:6369} Recipe: Rockscale Cod · {item:6362} Raw Rockscale Cod · {npc:12962} Wik'Tar · {zone:1440} Ashenvale · {zone:1443} Desolace
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:3029} ({zone:1456}) or {npc:3027} ({zone:1456})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:12962} ({zone:1440}) or Wulan ({zone:1443}))."] = "",

	-- Step 20: Fishing: Hillsbrad Foothills (125-225)
	-- {item:279965} Fishing Rack · {area:2797} Blackfathom Deeps · {item:6330} Recipe: Bristle Whisker Catfish · {item:6308} Raw Bristle Whisker Catfish · {skill:185} Cooking · {npc:2397} Derak Nightfall · {zone:1424} Hillsbrad Foothills · {npc:4553} Ronald Burch · {zone:1458} Undercity · {item:6369} Recipe: Rockscale Cod · {item:6362} Raw Rockscale Cod · {npc:4574} Lizbeth Cromwell · {item:6358} Oily Blackmouth · {item:6370} Blackmouth Oil · {skill:171} Alchemy
	["Fish the pools here until skill 225, about 500 catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch. Forever's second camping item, the {item:279965} (from skill 140), is a blueprint that drops from Gelihast in {area:2797}. Fish get away here below skill 150; a lure on the pole adds to your skill for ten minutes and closes the gap. To cook what you catch: {item:6330} for the {item:6308} of lakes and rivers ({skill:185} 100, 12s: {npc:2397} ({zone:1424}) or {npc:4553} ({zone:1458})); {item:6369} for the {item:6362} of the coast ({skill:185} 175, 22s: {npc:4574} ({zone:1458})). {item:6358} from the schools here is no food: alchemists make {item:6370} from it ({skill:171} 80); keep it to sell or trade."] = "",
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "{area:287} 해안",

	-- Step 21: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "전문 {skill:356}(최대 300)은(는) {zone:1445}의 {npc:12919}에게서 배웁니다. {zone:1455}의 낚시 상급자가 그에게 보내 줍니다. 퀘스트에는 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 22: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "전문 {skill:356}(최대 300)은(는) {zone:1445}의 {npc:12919}에게서 배웁니다. {zone:1454}의 낚시 상급자가 그에게 보내 줍니다. 퀘스트에는 숙련도 225, 레벨 35가 필요합니다.",

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
	["Artisan {skill:356}"] = "전문 {skill:356}",

	-- Step 31: Fishing: Stranglethorn Vale (225-300)
	-- {item:6533} Aquadynamic Fish Attractor · {item:6532} Bright Baubles
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, about 650 catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere. From skill 225 this water loses no fish, so no lure is needed. The {item:6533} (+100 from skill 100, 2s 50c) and {item:6532} are for harder water and rare fish, not for skill."] = "",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "{area:35} 해안",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "진영의 {skill:356} 상급자 누구에게서나 초급 {skill:356}을(를) 배울 수 있습니다(캐릭터 레벨 5). 화살표가 가장 가까운 상급자를 가리킵니다. 직업용품 상인이나 낚시 상인에게서 {item:6256}을(를) 사서 장착하세요.",
	-- ["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "숙련 {skill:356}(최대 225)은(는) 상급자가 아니라 책으로 배웁니다. {zone:1434} 남쪽 끝 {area:35}에서 {npc:2626}이(가) 양 진영 모두에게 {item:16083}을(를) 팝니다. 사서 읽으세요. 숙련도 125, 레벨 20이 필요합니다.",
	-- ["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "숙련도 50까지 이곳에서 낚시하세요. 찌가 첨벙이면 클릭하세요. 낚을 때마다 숙련도가 오를 수 있습니다.",
	-- ["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "{item:16967}을(를) 낚을 때까지 {zone:1444}의 {area:2521}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "{item:16970}을(를) 낚을 때까지 {zone:1435} 남동쪽 물가인 {area:300}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "{item:16969}을(를) 낚을 때까지 {zone:1434} 북서쪽 물가인 {area:301}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "{item:16968}을(를) 낚을 때까지 {zone:1443} 북서쪽 해안(뱀갈퀴일족 나가 해안)인 {area:598}에서 낚시하세요. 그곳에서만 낚입니다.",
	-- ["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "숙련도 300까지 이곳 해안의 낚시터(장어, 도미, 잔해)에서 낚시하세요. {area:35}에서 미끼와 {item:6530}을(를) 팔며, 낚시 숙련도가 조금 오릅니다.",
	-- ["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "숙련도 125까지 이곳의 낚시터와 탁 트인 물에서 낚시하세요. 낚시터(떠다니는 잔해, 물고기 떼)에서는 추가 전리품도 나옵니다.",
	-- ["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "숙련도 225까지 이곳의 낚시터에서 낚시하세요. 물고기가 자꾸 달아나면 숙련도가 오를 때까지 더 쉬운 곳에서 낚시하세요.",
	-- ["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "수습 {skill:356}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:356} 상급자를 가리킵니다.",
	-- ["Vile Fin shore"] = "썩은지느러미 물가",
	-- ["{area:442} shore"] = "{area:442} 물가",
	-- ["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919}은(는) 테라모어 섬 남쪽, 동쪽 해안 앞바다의 작은 섬 물가에서 낚시하고 있습니다.",
	-- ["{zone:1411} coast"] = "{zone:1411} 해안",
	-- ["{zone:1413} oasis"] = "{zone:1413} 오아시스",
}
