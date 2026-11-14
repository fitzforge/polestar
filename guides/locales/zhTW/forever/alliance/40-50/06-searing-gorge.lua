-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "前往{zone:1455}",

	-- Step 2: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飛往{area:144}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飛行管理員",

	-- Step 3: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 4: Searing Gorge
	["The Grimesilt outhouse"] = "煤渣挖掘場的庫房",

	-- Step 5: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "從{area:144}向南騎進{zone:1418}，然後向西經過部落城鎮{area:340}（離它遠一點），再沿小徑上到{zone:1427}：{area:247}就在入口內的東南方。木製廁所裡的囚犯要15塊{item:4306}，以及擊殺周圍挖掘場的八名黑鐵地質學家。如果你找到了鑰匙，也能用它打開廁所。",

	-- Step 6: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "囚犯的下一個任務「{zone:1446}的帳本」會派你去{zone:1435}和{zone:1445}：跳過它。",

	-- Step 7: Level 48.27
	["Level 48.27"] = "",
	-- {item:3985} Monogrammed Sash
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "",

	-- Step 8: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "杜里奧斯站在{area:247}旁的道路邊。護送他向東北前往{area:1959}，並讓他活著；結束後，閱讀他留在道路上的{object:175704}。",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, at the end of this guide"] = "在本指南的最後，交給{zone:1455}的{npc:8256}",

	-- Step 9: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "沿著峽谷北側向西騎往{area:1446}，也就是西北邊緣搭著鷹架的營地。",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827}告示板",

	-- Step 11: Zamael Lunthistle
	-- {npc:8436} Zamael Lunthistle · {area:1442} Firewatch Ridge · {area:1446} Thorium Point · {npc:8282} Highlord Mastrogonde · {quest:3377} Prayer to Elune
	-- plural, as words: Twilight Fire Guards = {npc:5861} Twilight Fire Guard
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:8436} stands inside the Twilight camp at {area:1442}, west of {area:1446}, among Twilight Fire Guards, Idolaters and Geomancers (level 48-49 elites), with {npc:8282} (level 51, rare elite) beside him: {quest:3377} needs a group of 4. Skip it if you are alone."] = "這些是精英怪物：建議組隊，找人一起完成。{npc:8436}站在{area:1446}西邊{area:1442}的暮光營地裡，周圍是暮光火焰衛士、暮光崇拜者和暮光地占師（48-49級精英），旁邊還有{npc:8282}（51級稀有精英）：{quest:3377}需要4人隊伍。如果你是獨自一人就跳過。",

	-- Step 14: Searing Lava Spiders
	-- plural, as words: Searing Lava Spiders = {npc:5857} Searing Lava Spider
	["Searing Lava Spiders"] = "巨型熔岩蜘蛛",
	-- {npc:8436} Zamael Lunthistle
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to Velarok."] = "蜘蛛在{npc:8436}南邊的高地和熔岩池間遊蕩，就在前往Velarok的路上。",

	-- Step 15: Velarok Windblade
	["Velarok Windblade"] = "Velarok Windblade",
	-- {area:1446} Thorium Point
	["Velarok stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Velarok站在{area:1446}南邊的大熔爐邊緣。聆聽他的故事。",

	-- Step 18: Golems and elementals
	["Golems and elementals"] = "傀儡與元素",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Velarok; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "重型作戰傀儡在Velarok下方的大熔爐底部巡邏；熔岩元素在牠們之間飄蕩。傀儡和元素會掉落油，元素會掉落核心。",

	-- Step 20: Dark Iron dwarves: kill these as you meet them
	["Dark Iron dwarves: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "黑鐵工頭和黑鐵奴隸販子在大熔爐各處驅趕奴隸，任何一個都可能帶著{item:10551}。黑鐵鍛造師在中央的熔爐工作（{item:18959}），黑鐵哨兵站在南邊的山脊上（偵查員的望遠鏡）。任何{object:147516}都可能掉落{item:11818}：留著它。\n小心：黑鐵奴隸販子（45-46級）被拉時會向15碼內的同伴求援，會在15碼內施放網，近戰時會使用撕裂。",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443}的入口在大熔爐北部。秘密設計圖：熾熱助熔劑在上層平台；燻火龍在更深處的熔岩池中游動，把牠們拉到邊緣。遠離深處的{npc:14621}和他的精英守衛。",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "",

	-- Step 24: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 26: Level 48.66
	["Level 48.66"] = "",
	-- {quest:7701} WANTED: Overseer Maltorius
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "",

	-- Step 28: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 30: The Torch of Retribution
	["Listen to Velarok's story once more."] = "再聽一次Velarok的故事。",

	-- Step 31: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at Velarok's feet; {quest:3462} stands beside him."] = "{quest:3453}就放在Velarok腳邊的地上；{quest:3462}站在他旁邊。",
	-- {quest:3462} Squire Maltrake · {area:1446} Thorium Point
	["{quest:3462}: hand it in on the way back to {area:1446}"] = "{quest:3462}：在返回{area:1446}的路上交付",

	-- Step 32: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "哨兵火盆",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the south-east."] = "帶著{object:149047}沿大熔爐邊緣向南走，從西南方繞到東南方，點燃四座哨兵火盆。",

	-- Step 33: Level 48.98
	["Level 48.98"] = "",
	-- {quest:3452} The Flame's Casing
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "",

	-- Step 34: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "地下",

	-- Step 36: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {area:1446} Thorium Point
	["{npc:8509} and the dragonflight's hoard are beside Velarok, on the rim south of {area:1446}."] = "{npc:8509}和龍群的寶藏就在Velarok旁邊，位於{area:1446}南邊的邊緣上。",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} it gives holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "它給你的{object:149502}裡有一個{item:10575}：留著它，之後交給{zone:1428}的{npc:9459}",

	-- Step 38: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飛往{area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 39: Hall of Explorers
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}：軟泥怪在{zone:1448}，留著它",

	-- Step 40: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "{zone:1447}的四份符文拓印：留著它",

	-- Step 41: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 42: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "希克斯在{object:32359}等你。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["For {npc:8256} in {area:1537}, later"] = "之後給{area:1537}的{npc:8256}",
	-- ["Greater Lava Spiders"] = "巨型熔岩蜘蛛",
	-- ["The night elf stands alone west of {area:1446}. Hear his story."] = "那名夜精靈獨自站在{area:1446}西邊。聽他的故事。",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用爐石把你送到這裡，所以這一步通常會立即完成",
	-- ["{object:147516} dwarves"] = "{object:147516}矮人",
}
