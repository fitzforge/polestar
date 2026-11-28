-- Chinese (traditional) (zhTW): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "學習{skill:186}",
	-- {item:247840} Mining for Dummies
	["No character level needed. On Zephras Isle, {item:247840} from Harvesting Windstones teaches it too."] = "",

	-- Step 2: Buy a Mining Pick
	-- {item:2901} Mining Pick
	["Buy a {item:2901}"] = "",
	["A tool: it stays in your bags, and every vein needs it."] = "",

	-- Step 3: Turn on Find Minerals · Professions tab (K by default)
	-- {spell:2580} Find Minerals
	["Turn on {spell:2580} · Professions tab (K by default)"] = "",
	["Veins show on the minimap. Dying turns it off, and only one kind of tracking is on at a time."] = "",

	-- Step 4: Mine 140 Copper Ore
	-- {item:2770} Copper Ore
	["Mine 140 {item:2770}"] = "",
	-- {skill:186} Mining
	["{skill:186} it raises your skill too; enough to smelt your way to 65."] = "",

	-- Step 5: Go to a forge
	["Go to a forge"] = "",
	["Forge"] = "",

	-- Step 6: Smelt 140 Copper Bars · keep 70 for Bronze · Professions tab (K by default)
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["Smelt 140 Copper Bars · keep 70 for Bronze · Professions tab (K by default)"] = "",
	-- {spell:2659} Smelt Bronze · {item:2840} Copper Bar
	["Every bar gives a point up to 25; {spell:2659} takes a {item:2840} each."] = "",

	-- Step 7: Mine Chunk of Amber and Copper until 65
	["Mine Chunk of Amber and Copper until 65"] = "",
	["Only if the smelting left you short of 65."] = "",

	-- Step 8: Train Journeyman Mining
	-- {skill:186} Mining
	["Train Journeyman {skill:186}"] = "",
	-- {skill:186} Mining
	["Needs {skill:186} skill 50. The trainers in the starting areas teach only up to 75."] = "",

	-- Step 9: Learn Smelt Tin
	-- {spell:3304} Smelt Tin
	["Learn {spell:3304}"] = "",

	-- Step 10: Learn Smelt Bronze
	-- {spell:2659} Smelt Bronze
	["Learn {spell:2659}"] = "",

	-- Step 11: Mine 70 Tin Ore
	-- {item:2771} Tin Ore
	["Mine 70 {item:2771}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["Tin Veins need {skill:186} skill 65."] = "",

	-- Step 13: Smelt 70 Tin Bars · Professions tab (K by default)
	-- plural, as words: Tin Bars = {item:3576} Tin Bar
	["Smelt 70 Tin Bars · Professions tab (K by default)"] = "",
	["Tin stops giving points at 75, but Bronze needs all 70 bars."] = "",

	-- Step 14: Smelt 70 Bronze Bars · Professions tab (K by default)
	-- plural, as words: Bronze Bars = {item:2841} Bronze Bar
	["Smelt 70 Bronze Bars · Professions tab (K by default)"] = "",
	-- {item:2840} Copper Bar · {item:3576} Tin Bar
	["A {item:2840} and a {item:3576} each. You end up near 105."] = "",

	-- Step 15: Mine Copper and Tin until 125
	["Mine Copper and Tin until 125"] = "",
	["Cave mobs respawn fast: worth it only well above their level."] = "",

	-- Step 16: Train Expert Mining
	-- {skill:186} Mining
	["Train Expert {skill:186}"] = "",
	-- {skill:186} Mining
	["Needs {skill:186} skill 125."] = "",

	-- Step 17: Learn Smelt Iron
	-- {spell:3307} Smelt Iron
	["Learn {spell:3307}"] = "",

	-- Step 18: Mine 20 Iron Ore
	-- {item:2772} Iron Ore
	["Mine 20 {item:2772}"] = "",
	-- {skill:186} Mining
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit
	["Iron Deposits need {skill:186} skill 125."] = "",

	-- Step 20: Smelt 20 Iron Bars · Professions tab (K by default)
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Smelt 20 Iron Bars · Professions tab (K by default)"] = "",
	["Iron gives a point every time up to 130; you end up near 138."] = "",

	-- Step 21: Mine Tin, Silver and Iron until 155
	["Mine Tin, Silver and Iron until 155"] = "",
	["No smelt gives points from 140 to 155."] = "",

	-- Step 22: Mine Tin, Silver and Iron until 175
	["Mine Tin, Silver and Iron until 175"] = "",
	["Iron still gives points all the way to 175."] = "",

	-- Step 23: Mine Iron, Gold and Mithril until 200
	["Mine Iron, Gold and Mithril until 200"] = "",
	-- {skill:186} Mining
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["Mithril Deposits need {skill:186} skill 175."] = "",

	-- Step 24: Train Artisan Mining
	-- {skill:186} Mining
	["Train Artisan {skill:186}"] = "",
	-- {skill:186} Mining
	["Needs {skill:186} skill 200; past 225 nothing gives points without it."] = "",

	-- Step 25: Mine Iron, Gold and Mithril until 230
	["Mine Iron, Gold and Mithril until 230"] = "",

	-- Step 26: Mine Gold, Mithril and Truesilver until 245
	["Mine Gold, Mithril and Truesilver until 245"] = "",
	-- {skill:186} Mining
	-- plural, as words: Truesilver Deposits = {object:2047} Truesilver Deposit
	["Truesilver Deposits need {skill:186} skill 230."] = "",

	-- Step 27: Mine Mithril and Small Thorium until 275
	["Mine Mithril and Small Thorium until 275"] = "",
	-- {skill:186} Mining
	-- plural, as words: Small Thorium Veins = {object:324} Small Thorium Vein
	["Small Thorium Veins need {skill:186} skill 245."] = "",

	-- Step 28: Mine Dark Iron, Truesilver, Small Thorium and Rich Thorium until 300
	-- {object:147516} Dark Iron
	["Mine {object:147516}, Truesilver, Small Thorium and Rich Thorium until 300"] = "",
	-- {skill:186} Mining
	-- plural, as words: Rich Thorium Veins = {object:175404} Rich Thorium Vein
	["Rich Thorium Veins need {skill:186} skill 275."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "你陣營的任何{skill:186}訓練師都能教初級{skill:186}（角色等級5）；箭頭會指向最近的一位。向商業用品商或雜貨商購買{item:2901}：放在背包裡，沒有它就無法採礦。",
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "本陣營的任意{skill:186}訓練師都教授初級{skill:186}，沒有等級要求（10銅），每個初始地區的初級採礦訓練師也會教；箭頭會選擇最近的一位。向雜貨商或綜合商人購買一個{item:2901}：放在揹包裡，沒有它就無法採礦。開啟{spell:2580}（法術書的綜合頁），讓礦脈顯示在微縮地圖上。無限服初始地區還有貧瘠銅礦（產出{item:2770}和{item:2835}，技能1起）。每個初始地區最初一小時的任務（“鼠輩氾濫”、“寒脊山谷的送信任務”、“森林守護者”、戈加爾的{item:11584}、“一件瑣事”、“瑪拉的遺願”）都提供{item:247840}作為獎勵：閱讀後提升2點技能，最高提升到15。雜貨商和初級訓練師出售{item:277115}，一種裝礦石和石頭的四格包（25銅）。如果你為“廣闊天地”在初始地區的營火旁坐過，那裡負責露營指引的NPC還會提供露營 101: {skill:186}：技能達到20後，向任務指定的採礦訓練師交還，可獲得{spell:1230161}配方。",
	-- ["Artisan {skill:186}"] = "專家級{skill:186}",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:186} trainer of your faction."] = "專家級{skill:186}將上限提高至300；需要技能200，沒有角色等級要求，費用5金：一到200就去學。箭頭會指向你陣營最近的{skill:186}訓練師。",
	-- ["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "技能65時，{skill:186}訓練師會教{spell:2659}（2銀；115後變灰）和{spell:3304}（50銅；75後變灰）：在熔爐旁熔鍊也會提升{skill:186}，所以挖到的礦都熔掉。",
	-- ["Copper"] = "銅礦",
	-- ["Copper & Poor Copper: {zone:1411} (1-50)"] = "銅礦與劣質銅礦：{zone:1411}（1-50）",
	-- ["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "銅礦與劣質銅礦：{zone:1411}（50-65）（續）",
	-- ["Copper & Poor Copper: {zone:1420} (1-50)"] = "銅礦與劣質銅礦：{zone:1420}（1-50）",
	-- ["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "銅礦與劣質銅礦：{zone:1420}（50-65）（續）",
	-- ["Copper & Poor Copper: {zone:1426} (1-50)"] = "銅礦與劣質銅礦：{zone:1426}（1-50）",
	-- ["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "銅礦與劣質銅礦：{zone:1426}（50-65）（續）",
	-- ["Copper & Tin: {zone:1413} (65-125)"] = "銅礦與錫礦：{zone:1413}（65-125）",
	-- ["Copper, Poor Copper"] = "銅礦、劣質銅礦",
	-- ["Copper, Silver"] = "銅礦、銀礦",
	-- ["Copper, Tin"] = "銅礦、錫礦",
	-- ["Copper: {zone:1412} (1-50)"] = "銅礦：{zone:1412}（1-50）",
	-- ["Copper: {zone:1412} (50-65) cont."] = "銅礦：{zone:1412}（50-65）（續）",
	-- ["Copper: {zone:1429} (1-50)"] = "銅礦：{zone:1429}（1-50）",
	-- ["Copper: {zone:1429} (50-65) cont."] = "銅礦：{zone:1429}（50-65）（續）",
	-- ["Copper: {zone:1439} (1-50)"] = "銅礦：{zone:1439}（1-50）",
	-- ["Copper: {zone:1439} (50-65) cont."] = "銅礦：{zone:1439}（50-65）（續）",
	-- ["Copper: {zone:2521} (1-50)"] = "銅礦：{zone:2521}（1-50）",
	-- ["Copper: {zone:2521} (50-65) cont."] = "銅礦：{zone:2521}（50-65）續",
	-- ["Expert {skill:186}"] = "高級{skill:186}",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "高級{skill:186}將上限提高至225；需要技能125且角色等級20。箭頭會指向你陣營最近的{skill:186}訓練師。",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "高階{skill:186}把上限提高到225；需要技能125，不限角色等級，花費50銀：一到125就立刻學習。箭頭會指向本陣營最近的{skill:186}訓練師。同一次拜訪中學{spell:3307}（5銀；130前橙色，140後變灰）：在熔爐旁熔鍊也會提升{skill:186}，所以挖到的礦都熔掉。",
	-- ["Gold"] = "金礦脈",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "金礦脈與祕銀礦床：{zone:1435}（175-200）",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "金礦脈與祕銀礦床：{zone:1435}（200-230）（續）",
	-- ["Gold, Iron"] = "金礦脈、鐵礦床",
	-- ["Gold, Mithril"] = "金礦脈、祕銀礦床",
	-- ["Gold: {zone:1435} (155-175)"] = "金礦脈：{zone:1435}（155-175）",
	-- ["Incendicite & Tin: {zone:1437} (65-125)"] = "燃石與錫礦：{zone:1437}（65-125）",
	-- ["Incendicite, Tin"] = "燃石、錫礦",
	-- ["Iron, Mithril"] = "鐵礦、秘銀",
	-- ["Iron, Silver"] = "鐵礦床、銀礦",
	-- ["Iron, Tin"] = "鐵礦、錫礦",
	-- ["Iron: {zone:1416} (125-155)"] = "鐵礦床：{zone:1416}（125-155）",
	-- ["Iron: {zone:1417} (125-155)"] = "鐵礦：{zone:1417}（125-155）",
	-- ["Iron: {zone:1417} (155-175)"] = "鐵礦：{zone:1417}（155-175）",
	-- ["Iron: {zone:1431} (125-155)"] = "鐵礦床：{zone:1431}（125-155）",
	-- ["Journeyman {skill:186}"] = "中級{skill:186}",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "中級{skill:186}將上限提高至150；需要技能50且角色等級10。箭頭會指向你陣營最近的{skill:186}訓練師。",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "中級 {skill:186} 將上限提高到 150；要求技能 50，無角色等級要求，費用 5 銀幣：一到 50 就去學。箭頭會選擇本陣營最近的 {skill:186} 訓練師。無限的 {skill:186} 露營物品 {spell:1230161} 在技能 20 起可學（1 銀幣，或透過露營 101: {skill:186} 免費學習）：每次需要一個 {item:2835} 和一個 {item:2840}，製作可漲技能至 25；放在營火旁，會給予營地內所有人持續一小時的增益。",
	-- ["Lesser Bloodstone"] = "次級血石",
	-- ["Lesser Bloodstone, Iron"] = "次級血石、鐵礦床",
	-- ["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "路過每一處銅礦（1點，綠色）、燃石（65，橙色）、錫礦（65，橙色）、銀礦（75起，稀有）都採，並沿路徑點迴圈，直到{skill:186}達到125。揹包滿了就在熔爐熔鍊：{spell:2657}（25前橙色，70後變灰）、{spell:3304}（75後變灰）、{spell:2659}（115後變灰）也能漲點。{spell:2659}每次需要一塊{item:2840}和一塊{item:3576}：在學它之前，把熔鍊出的錠留著。區域等級20-30。這60點大約需要130個礦點。{spell:2658}（2銀；100前橙色，125後變灰）從75起可學：路過{skill:186}訓練師就學，不值得專門跑一趟。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-20。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-25。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級15-25。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級20-30。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "路過每一處銅礦（1點，綠色）、錫礦（65，橙色）、銀礦（75起，稀有）都採，並沿路徑點迴圈，直到{skill:186}達到125。揹包滿了就在熔爐熔鍊：{spell:2657}（25前橙色，70後變灰）、{spell:3304}（75後變灰）、{spell:2659}（115後變灰）也能漲點。{spell:2659}每次需要一塊{item:2840}和一塊{item:3576}：在學它之前，把熔鍊出的錠留著。區域等級10-25。這60點大約需要280個礦點。{spell:2658}（2銀；100前橙色，125後變灰）從75起可學：路過{skill:186}訓練師就學，不值得專門跑一趟。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "路過每一處銅礦（1點，綠色）、錫礦（65，橙色）、銀礦（75起，稀有）都採，並沿路徑點迴圈，直到{skill:186}達到125。揹包滿了就在熔爐熔鍊：{spell:2657}（25前橙色，70後變灰）、{spell:3304}（75後變灰）、{spell:2659}（115後變灰）也能漲點。{spell:2659}每次需要一塊{item:2840}和一塊{item:3576}：在學它之前，把熔鍊出的錠留著。區域等級18-30。這60點大約需要130個礦點。{spell:2658}（2銀；100前橙色，125後變灰）從75起可學：路過{skill:186}訓練師就學，不值得專門跑一趟。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "路過每一處銅礦（1點，綠色）、錫礦（65，橙色）、銀礦（75起，稀有）都採，並沿路徑點迴圈，直到{skill:186}達到125。揹包滿了就在熔爐熔鍊：{spell:2657}（25前橙色，70後變灰）、{spell:3304}（75後變灰）、{spell:2659}（115後變灰）也能漲點。{spell:2659}每次需要一塊{item:2840}和一塊{item:3576}：在學它之前，把熔鍊出的錠留著。區域等級20-30。這60點大約需要140個礦點。{spell:2658}（2銀；100前橙色，125後變灰）從75起可學：路過{skill:186}訓練師就學，不值得專門跑一趟。",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "採集沿途經過的每一個銅礦（1，橙色），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提供點數。地區等級1-15。這49點預計需要約60個礦點。",
	-- ["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "採集沿途經過的每一個銅礦（1，橙色）、劣質銅礦（1，橙色），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提供點數。地區等級1-10。這49點預計需要約60個礦點。",
	-- ["Mine every Copper (1, orange), Poor Copper (1, orange, rare) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "開採沿途經過的每一個銅礦（1，橙色）和貧瘠銅礦（1，橙色，稀有），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這49點預計要開採約60個礦點。",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "採集沿途經過的每一個銅礦（1，黃色），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提供點數。地區等級1-15。這15點預計需要約80個礦點。",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "採集沿途經過的每一個銅礦（1，黃色），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-20。",
	-- ["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "路過每一處銅礦（1點，黃色）、劣質銅礦（1點，黃色）都採，並沿路徑點迴圈，直到{skill:186}達到65。揹包滿了就在熔爐熔鍊：{spell:2657}（25前橙色，70後變灰）也能漲點。區域等級1-10。這15點大約需要80個礦點。",
	-- ["Mine every Copper (1, yellow), Poor Copper (1, yellow, rare) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "開採沿途經過的每一個銅礦（1，黃色）和貧瘠銅礦（1，黃色，稀有），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這15點預計要開採約80個礦點。",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "採集沿途經過的每一個金礦脈（155，綠色）、祕銀礦床（175，綠色）、真銀礦床（230，橙色）、瑟銀礦脈（245，橙色），並繞著路徑點循環，直到{skill:186}275。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級45-55。",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "採集沿途經過的每一個金礦脈（155，綠色）、祕銀礦床（175，綠色）、{object:147516}（230，橙色）、真銀礦床（230，橙色），並繞著路徑點循環，直到{skill:186}245。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級43-50。",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "路過每一處金礦（155，綠色）、秘銀（175，綠色）、{object:147516}（230，橙色）、真銀（230，橙色）都採，並沿路徑點迴圈，直到{skill:186}達到245。從這裡起熔鍊不再漲點（學會後更高階的熔鍊都變灰）：需要就熔鍊用於製作或出售，否則直接賣礦石。{item:11099}只能在{area:1584}的{object:174824}熔鍊（8塊礦石成一塊錠）。區域等級43-50。這15點大約需要40個礦點。",
	-- ["Mine every Gold (155, green, rare), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Quests here that need {skill:186}: Salve via {skill:186} (level 55, {npc:9528}; Alliance), Salve via {skill:186} (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 50 nodes for these 30 points."] = "路過每一處金礦（155，綠色，稀有）、秘銀（175，綠色）、真銀（230，橙色）、小瑟銀（245，橙色）都採，並沿路徑點迴圈，直到{skill:186}達到275。從這裡起熔鍊不再漲點（學會後更高階的熔鍊都變灰）：需要就熔鍊用於製作或出售，否則直接賣礦石。此處需要{skill:186}的任務：《以{skill:186}制膏》（55級，{npc:9528}；聯盟）、《以{skill:186}制膏》（55級，{npc:9529}；部落）。區域等級48-55。這30點大約需要50個礦點。",
	-- ["Mine every Gold (155, green, rare), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "開採經過的每個金礦（155，綠色，稀有）、秘銀礦（175，綠色）、{object:147516}（230，橙色）、真銀礦（230，橙色），並繞著路徑點轉，直到{skill:186}達到245。從這裡開始熔煉不再加點（較高的熔煉學會後就是灰色）：熔煉用於製作或出售，或者直接賣礦石。{item:11099}只能在{area:1584}的{object:174824}熔煉（8個礦石一個錠）。地區等級43-50。這15點大約需要40個礦點。",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "採集沿途經過的每一個鐵礦床（125，綠色）、金礦脈（155，橙色）、祕銀礦床（175，橙色），並繞著路徑點循環，直到{skill:186}200。背包滿了就到熔爐熔煉：{spell:3308}（170之前為橙色，185變灰）也會提供點數。地區等級35-45。這25點預計需要約40個礦點。",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "採集沿途經過的每一個鐵礦床（125，綠色）、金礦脈（155，黃色）、祕銀礦床（175，黃色），並繞著路徑點循環，直到{skill:186}230。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級35-45。",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 35-45. Expect about 90 nodes for these 30 points."] = "路過每一處鐵礦（125，綠色）、金礦（155，黃色）、秘銀（175，黃色）都採，並沿路徑點迴圈，直到{skill:186}達到230。從這裡起熔鍊不再漲點（學會後更高階的熔鍊都變灰）：需要就熔鍊用於製作或出售，否則直接賣礦石。區域等級35-45。這30點大約需要90個礦點。",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "採集沿途經過的每一個銀礦（75，綠色）、鐵礦床（125，黃色）、金礦脈（155，橙色），並繞著路徑點循環，直到{skill:186}175。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級35-45。",
	-- ["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "採集沿途經過的每一個錫礦（65，綠色）、次級血石礦（75，綠色）、銀礦（75，綠色，稀有）、鐵礦床（125，橙色），並繞著路徑點循環，直到{skill:186}155。背包滿了就到熔爐熔煉：{spell:3307}（130之前為橙色，140變灰）也會提供點數。地區等級30-40。這30點預計需要約50個礦點。",
	-- ["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. {spell:3308} (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "路過每一處錫礦（65，綠色）、次級血石（75，綠色）、銀礦（75，綠色，稀有）、鐵礦（125，黃色）、金礦（155，橙色，稀有）都採，並沿路徑點迴圈，直到{skill:186}達到175。揹包滿了就在熔爐熔鍊：{spell:3308}（170前橙色，185後變灰）也能漲點。區域等級30-40。這20點大約需要40個礦點。{spell:3308}（25銀；170前橙色，185後變灰）從155起可學：路過{skill:186}訓練師就學，不值得專門跑一趟。",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "採集沿途經過的每一個錫礦（65，綠色）、銀礦（75，綠色）、鐵礦床（125，橙色），並繞著路徑點循環，直到{skill:186}155。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級18-30。",
	-- ["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 53-60. Expect about 30 nodes for these 25 points."] = "開採經過的每個真銀礦（230，黃色）、瑟銀礦脈（245，黃色）、富瑟銀礦（275，橙色），並繞著路徑點轉，直到{skill:186}達到300。從這裡開始熔煉不再加點（較高的熔煉學會後就是灰色）：熔煉用於製作或出售，或者直接賣礦石。地區等級53-60。這25點大約需要30個礦點。",
	-- ["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 55-60. Expect about 40 nodes for these 25 points."] = "路過每一處真銀（230，黃色）、小瑟銀（245，黃色）、富瑟銀（275，橙色）都採，並沿路徑點迴圈，直到{skill:186}達到300。從這裡起熔鍊不再漲點（學會後更高階的熔鍊都變灰）：需要就熔鍊用於製作或出售，否則直接賣礦石。區域等級55-60。這25點大約需要40個礦點。",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "採集沿途經過的每一個{object:147516}（230，黃色）、真銀礦床（230，黃色）、瑟銀礦脈（245，黃色）、富瑟銀礦（275，橙色），並繞著路徑點循環，直到{skill:186}300。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級50-58。",
	-- ["Mine every {object:656332} (1, orange), {object:656333} (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "開採沿途經過的每一個琥珀塊（1，橙色）和大琥珀塊（1，橙色），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這49點預計要開採約60個礦點。",
	-- ["Mine every {object:656332} (1, yellow), {object:656333} (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "開採沿途經過的每一個琥珀塊（1，黃色）和大琥珀塊（1，黃色），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這15點預計要開採約80個礦點。",
	-- ["Mithril & {object:147516}: {zone:1427} (230-245)"] = "祕銀與{object:147516}：{zone:1427}（230-245）",
	-- ["Mithril, Iron"] = "祕銀礦床、鐵礦床",
	-- ["Mithril, Small Thorium"] = "秘銀、小瑟銀",
	-- ["Mithril, {object:147516}"] = "秘銀、{object:147516}",
	-- ["Mithril: {zone:1418} (175-200)"] = "秘銀：{zone:1418}（175-200）",
	-- ["Mithril: {zone:1418} (200-230) cont."] = "秘銀：{zone:1418}（200-230）續",
	-- ["Poor Copper"] = "劣質銅礦",
	-- ["Poor Copper, Copper"] = "劣質銅礦、銅礦",
	-- ["Rich Thorium"] = "富瑟銀",
	-- ["Rich Thorium, Small Thorium"] = "富瑟銀、小瑟銀",
	-- ["Rich Thorium, Truesilver"] = "富瑟銀、真銀",
	-- ["Silver, Tin"] = "銀礦、錫礦",
	-- ["Small Thorium & Rich Thorium: {zone:1423} (275-300)"] = "瑟銀礦脈和富瑟銀礦：{zone:1423}（275-300）",
	-- ["Small Thorium & Rich Thorium: {zone:1452} (275-300)"] = "小型瑟銀礦與富瑟銀礦：{zone:1452}（275-300）",
	-- ["Small Thorium, Rich Thorium"] = "小瑟銀、富瑟銀",
	-- ["Small Thorium, Truesilver"] = "小瑟銀、真銀",
	-- ["Small Thorium: {zone:1448} (245-275)"] = "小瑟銀：{zone:1448}（245-275）",
	-- ["Tin"] = "錫礦",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "錫礦與銀礦：{zone:1413}（65-125）",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "錫礦與銀礦：{zone:1433}（65-125）",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "錫礦與銀礦：{zone:1439}（65-125）",
	-- ["Tin, Copper"] = "錫礦、銅礦",
	-- ["Tin, Silver"] = "錫礦、銀礦",
	-- ["Tin: {zone:1424} (65-125)"] = "錫礦：{zone:1424}（65-125）",
	-- ["Tin: {zone:1440} (65-125)"] = "錫礦：{zone:1440}（65-125）",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "真銀礦床與瑟銀礦脈：{zone:1419}（245-275）",
	-- ["Truesilver, {object:147516}"] = "真銀礦床、{object:147516}",
	-- ["{object:147516}, Gold"] = "{object:147516}、金礦脈",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}、富瑟銀礦",
	-- ["{object:656332} & {object:656333}: {zone:1438} (50-65) cont."] = "琥珀塊和大琥珀塊：{zone:1438}（50-65）（續）",
}
