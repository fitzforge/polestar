-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用爐石把你送到這裡，所以這一步通常會立即完成",

	-- Step 2: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "從{area:144}向南騎進{zone:1418}，然後向西經過部落城鎮{area:340}（離它遠一點），再沿小徑上到{zone:1427}。{area:1446}是西北邊緣搭著鷹架的營地。",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827}告示板",

	-- Step 3: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "那名夜精靈獨自站在{area:1446}西邊。聽他的故事。",

	-- Step 4: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "卡拉然·溫布雷站在{area:1446}南邊的大熔爐邊緣。聆聽他的故事。",

	-- Step 5: Golems and elementals
	["Golems and elementals"] = "傀儡與元素",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "重型作戰傀儡在卡拉然下方的大熔爐底部巡邏；熔岩元素在牠們之間飄蕩。傀儡和元素會掉落油，元素會掉落核心。",

	-- Step 7: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "{object:147516}矮人",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "黑鐵工頭和黑鐵奴隸販子在大熔爐各處驅趕奴隸，任何一個都可能帶著{item:10551}。黑鐵鍛造師在中央的熔爐工作（{item:18959}），黑鐵哨兵站在南邊的山脊上（偵查員的望遠鏡）。任何{object:147516}都可能掉落{item:11818}：留著它。",

	-- Step 8: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "巨型熔岩蜘蛛",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "蜘蛛在峽谷西南部的高地和熔岩池間遊蕩。",

	-- Step 10: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443}的入口在大熔爐北部。秘密設計圖：熾熱助熔劑在上層平台；燻火龍在更深處的熔岩池中游動，把牠們拉到邊緣。遠離深處的{npc:14621}和他的精英守衛。",

	-- Step 12: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "煤渣挖掘場的庫房",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "向東騎過大熔爐，前往東南方的{area:247}。木製廁所裡的囚犯要15塊{item:4306}，以及擊殺周圍挖掘場的八名黑鐵地質學家。如果你找到了鑰匙，也能用它打開廁所。",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "囚犯的下一個任務「{zone:1446}的帳本」會派你去{zone:1435}和{zone:1445}：跳過它。",

	-- Step 13: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "杜里奧斯·裂石站在挖掘場旁的道路邊。跟著他沿道路向北，擊退{object:147516}的伏擊。結束後，閱讀他留在{area:1959}道路上的{object:175704}。",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "之後給{zone:1455}的{npc:8256}",
}
