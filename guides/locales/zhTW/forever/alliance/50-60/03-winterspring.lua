-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- {npc:11629} Jessica Redpath · {area:2262} Darrowshire
	["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}：保留給{area:2262}",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}：兩個都保留給瘟疫之地",

	-- Step 2: Starfall Village
	["Ride west along the road to the night elf village."] = "沿著道路向西騎往夜精靈村莊。",

	-- Step 3: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "遺跡位於{area:2253}南邊結冰湖泊的周圍。拾取散落在遺跡中的四塊遺物碎片，以及梟獸遊蕩處地上的月光羽毛。",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "沿著道路向西前往溫泉旁{npc:9298}的營地。",
	-- {zone:1444} Feralas
	["Keep it: Gregan in {zone:1444} brews the elixir later"] = "保留此任務：{zone:1444}的格雷甘稍後會調製藥劑",

	-- Step 5: Salfa
	-- {npc:11556} Salfa · {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556}守衛著{npc:9298}西北方的{area:1769}入口。",

	-- Step 6: The Winterfall camp
	["The Winterfall camp"] = "冬泉營地",
	-- {npc:11556} Salfa · {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {quest:8471} Winterfall Ritual Totem · {quest:6031} Runecloth
	["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "冬泉西部營地位於{npc:11556}和{npc:9298}之間的山丘上。這裡的任何熊怪都可能掉落{item:12771}（約十分之一），極少數會掉落{quest:8471}：掉了哪個就右鍵點擊它。保留熊怪掉落的{quest:6031}給梅羅什。",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop"] = "{item:12771}，稀有掉落",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop"] = "{quest:8471}，稀有掉落",
	-- {area:1769} Timbermaw Hold
	["For Kernda in {area:1769}: keep it"] = "給{area:1769}的克爾達：保留此任務",
	-- {quest:6031} Runecloth
	["{quest:6031}, for Meilosh later"] = "{quest:6031}，稍後給梅羅什",

	-- Step 7: Donova Snowden
	-- {zone:1448} Felwood
	["The Deadwood cauldron in {zone:1448}: keep it"] = "{zone:1448}的死木大鍋：保留此任務",

	-- Step 8: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "冬泉熊怪的村莊位於{area:2255}東邊：冬泉薩滿（56-57級）、冬泉巢穴守衛（55-56級）和冬泉巨熊怪（57-58級），都比你高。先殺薩滿，他們會治療，並從邊緣開始拉。後方洞穴裡的{npc:10738}是精英：不要進去。",

	-- Step 9: The Ice Thistle Hills
	-- {area:2247} Ice Thistle Hills
	["The {area:2247}"] = "{area:2247}",
	-- {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "冰薊雪人住在{area:2244}南邊的山丘上，冰風奇美拉在往{area:2255}方向的山谷裡。",

	-- Step 11: Optional: Sunken Temple
	-- {area:1417} Sunken Temple
	["Optional: {area:1417}"] = "可選：{area:1417}",
	-- {area:1417} Sunken Temple · {area:2255} Everlook
	["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "打完雪人後還不到54級？組隊打{area:1417}（50-54級）代替練等能更快達到目標。之後回到{area:2255}。",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "回到山丘：只有冰薊雪人女王和冰薊雪人王身上帶著角。繼續擊殺雪人直到54級：在那之前哈魯的梟獸任務是紅色的。",
	-- {npc:7460} Ice Thistle Patriarch · {area:2247} Ice Thistle Hills · {zone:1452} Winterspring
	["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "在{zone:1452}的{area:2247}擊殺{npc:7460}練等",

	-- Step 13: Everlook
	-- {npc:10978} Legacki
	["On {npc:10978}, by the inn"] = "在旅店旁的{npc:10978}處",
	-- {npc:10978} Legacki · {npc:7583} Sprinkle · {npc:10977} Quixxil
	["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}：{npc:7583}和{npc:10977}稍後再找",

	-- Step 14: Starfall Village
	-- {npc:10301} Jaron Stoneshaper
	["Ride west along the road to {npc:10301}."] = "沿著道路向西騎往{npc:10301}處。",

	-- Step 15: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}的營地",
	-- {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "沿著山谷向東南騎往{area:2245}雪地中{npc:10301}的受損箱子，他的馬車殘骸就在它東邊。",

	-- Step 16: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}的補給物資",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "撿起馬車周圍的補給物資，並從附近的梟獸身上奪回{npc:10301}的護符。",

	-- Step 17: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "依照{npc:9298}的指示前往{area:2256}入口，途中經過霜槌巨人：一次通過一個。",

	-- Step 18: Starfall Village
	["Ride north-west back to the village."] = "向西北騎回村莊。",

	-- Step 21: Winterfall Spirit Beads
	["The western Winterfall furbolgs drop the beads."] = "西部的冬泉熊怪會掉落珠串。",

	-- Step 23: Chillwind Camp
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood · {area:442} Auberdine · {area:150} Menethil Harbor · {area:271} Southshore · {area:3197} Chillwind Camp
	["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "穿過{area:1769}前往{zone:1448}，再飛往東部王國（{area:442}，搭船到{area:150}）。飛往{area:271}，沿著道路向北穿過奧特蘭克前往{area:3197}。",

	-- Step 24: Pamela Redpath
	-- {zone:1423} Eastern Plaguelands · {area:2262} Darrowshire · {npc:10926} Pamela Redpath
	["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "沿著南邊的道路向東進入{zone:1423}；{area:2262}的廢墟在道路南邊。{npc:10926}的鬼魂在南端的廢屋旁玩耍。",

	-- Step 25: Pamela Redpath's doll
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s doll"] = "{npc:10926}的洋娃娃",
	-- {area:2262} Darrowshire
	["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "洋娃娃的三個部分在{area:2262}的廢屋裡；撿起其中一個可能會引出鬼魂。把它們組合成洋娃娃。",

	-- Step 26: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {zone:1422} Western Plaguelands
	["{quest:5152}, in the {zone:1422}: keep it"] = "{zone:1422}的{quest:5152}：保留此任務",

	-- Step 27: Light's Hope Chapel
	["Follow the road east across the zone to the chapel."] = "沿著道路向東穿過本區前往禮拜堂。",
	-- {npc:11038} Caretaker Alen · {npc:12250} Zaeldarr the Outcast
	["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}：{npc:12250}是54級精英",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "禮拜堂西邊{area:2264}周圍的天譴軍會掉落兩種天譴石；達隆郡居民的靈魂會從牠們身上升起：與每一個交談以解放它。",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "解放達隆郡居民的靈魂：與他們交談",

	-- Step 30: The Undercroft
	-- {npc:12250} Zaeldarr the Outcast · {area:2261} The Undercroft
	["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250}是精英：建議組隊。他在本區西南部的地穴{area:2261}最底層等著。",

	-- Step 31: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "向北騎往{area:2627}。{npc:12384}住在廢棄的小屋裡，他的收據冊在附近的旅店廢墟中。",

	-- Step 32: Light's Hope Chapel
	-- {area:3197} Chillwind Camp
	["The next guide starts here and flies to {area:3197}."] = "下一份指南從這裡開始，然後飛往{area:3197}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "塞達爾是精英：建議組隊。他在本區西南部的地穴{area:2261}最底層等著。",
}
