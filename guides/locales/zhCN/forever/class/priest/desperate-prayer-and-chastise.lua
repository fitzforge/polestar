-- Chinese (simplified) (zhCN): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634}与{quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Dwarf priest spells: {quest:5634} at 10, {quest:5641} (new in Forever) at 20. Free, no objectives."] = "矮人牧师的法术：10级的{quest:5634}，20级的{quest:5641}（无限 新增）。免费，无目标。",

	-- Step 1: Desperate Prayer: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:5634} letter for {npc:11406}. {area:131} is on the road up to {zone:1455}."] = "10级时，{area:131}的{area:2102}内的牧师训练师{npc:1226}会给你一封{quest:5634}的信，让你交给{npc:11406}。{area:131}就在通往{zone:1455}的上行道路上。",
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer
	["{npc:1226}: take his {quest:5634} letter"] = "{npc:1226}：领取他的{quest:5634}信件",

	-- Step 2: Desperate Prayer: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455} (the {area:2257} from {zone:1453}'s {object:28027})."] = "达到 10 级后，{zone:1429} 的 {area:87} 狮王之傲旅店楼上的 {npc:377} 会给你一封 {quest:5634} 信件，让你交给 {zone:1455} 的 {npc:11406}（从 {zone:1453} 的 {object:28027} 乘坐 {area:2257} 前往）。",
	-- {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer
	["{npc:377}: take her {quest:5634} letter"] = "{npc:377}：领取她的{quest:5634}信件",

	-- Step 3: Desperate Prayer: Nara Meideros
	-- {zone:1453} Stormwind · {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:376} High Priestess Laurena
	["At 10 in {zone:1453}, {npc:11397}, the priest trainer in the Park (the night elf quarter on the city's west side), hands you a {quest:5634} letter for {npc:11406} in {zone:1455}. {npc:376} in the Cathedral has none for Dwarves."] = "达到 10 级后，{zone:1453} 花园区（城市西侧的暗夜精灵区）的牧师训练师 {npc:11397} 会给你一封 {quest:5634} 信件，让你交给 {zone:1455} 的 {npc:11406}。大教堂中的 {npc:376} 不会给矮人这封信。",
	-- {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer
	["{npc:11397}: take her {quest:5634} letter"] = "{npc:11397}：领取她的{quest:5634}信件",

	-- Step 4: Desperate Prayer: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1438}, {npc:3600}, in the building at the north edge of {area:186}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "在 {zone:1438} 达到10级后，{npc:3600} 会在 {area:186} 北侧建筑中给你一封 {quest:5634} 的信，要你送给 {zone:1455} 的 {npc:11406}。",
	-- {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer
	["{npc:3600}: take her {quest:5634} letter"] = "{npc:3600}：领取她的{quest:5634}信件",

	-- Step 5: Desperate Prayer: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "在{zone:1457}达到10级时，月神殿上层阳台、{npc:7999}旁的{npc:11401}会交给你一封{quest:5634}信件，让你送给{zone:1455}的{npc:11406}。",
	-- {npc:11401} Priestess Alathea · {quest:5634} Desperate Prayer
	["{npc:11401}: take her {quest:5634} letter"] = "{npc:11401}：领取她的{quest:5634}信件",

	-- Step 6: Desperate Prayer: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {quest:5634} Desperate Prayer
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362} (north-west of the city): he gives {quest:5634} and takes it back at once. No letter needed. {quest:5634} heals you instantly, costs no mana and has a long cooldown: keep it for emergencies."] = "达到 10 级后，前往 {zone:1455} 西北部 {object:32362} 的 {object:32386} 找 {npc:11406}：他会给予 {quest:5634}，并立即接受交还。不需要信件。{quest:5634} 能瞬间治疗你，不消耗法力，但冷却时间很长：留到紧急时刻再用。",

	-- Step 7: Desperate Prayer: Maxan Anvol's letter
	-- {quest:5637} Desperate Prayer · {npc:1226} Maxan Anvol
	["{quest:5637}: {npc:1226}'s letter"] = "{quest:5637}：{npc:1226}的信",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {quest:5637} Desperate Prayer · {zone:1453} Stormwind
	["Follow the road up from {area:131} into {zone:1455} and west to the {object:32362}: {npc:11406} in the {object:32386} takes the letter and teaches {quest:5637}. The letter tells you to head to {zone:1453}, but the one who wants you is Rohan in {zone:1455}."] = "从 {area:131} 沿道路上山进入 {zone:1455}，再向西前往 {object:32362}：{object:32386} 中的 {npc:11406} 会收下信件，并教你 {quest:5637}。虽然信里让你去 {zone:1453}，但真正要找你的是 {zone:1455} 的洛汉。",

	-- Step 8: Desperate Prayer: Josetta's letter
	-- {quest:5635} Desperate Prayer
	["{quest:5635}: Josetta's letter"] = "{quest:5635}：女牧师洁塞塔的信",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "将信交给{zone:1455}的{object:32362}内、{object:32386}中的{npc:11406}：从{zone:1453}的{object:28027}搭乘{area:2257}前往。",

	-- Step 9: Desperate Prayer: Nara's letter
	-- {quest:5638} Desperate Prayer
	["{quest:5638}: Nara's letter"] = "{quest:5638}：娜拉·梅德隆的信",

	-- Step 10: Desperate Prayer: Laurna Morninglight's letter
	-- {quest:5636} Desperate Prayer · {npc:3600} Laurna Morninglight
	["{quest:5636}: {npc:3600}'s letter"] = "{quest:5636}：{npc:3600}的信",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1438}, the boat from {area:702} to {area:442}, the boat to {area:150} and the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "把信交给 {zone:1455} 的 {object:32362} 中、{object:32386} 内的 {npc:11406}：从 {zone:1438} 出发，在 {area:702} 坐船到 {area:442}，再坐船到 {area:150}，然后沿路向北穿过 {zone:1437} 和 {zone:1432}（也可以坐船到 {area:17203}，再搭乘 {area:2257}）。",

	-- Step 11: Desperate Prayer: Alathea's letter
	-- {quest:5640} Desperate Prayer
	["{quest:5640}: Alathea's letter"] = "{quest:5640}：女祭司阿兰希雅的信",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: its text says {zone:1453}, but Rohan is in {zone:1455}. From {zone:1457}, the portal down to {area:702}, the boat to {area:442}, then {area:150} and the road north (or {area:17203} and the {area:2257})."] = "将信交给{npc:11406}，他在{zone:1455}的{object:32362}内的{object:32386}：信上虽然写着{zone:1453}，但杀手洛汗实际在{zone:1455}。从{zone:1457}出发，先通过传送门下到{area:702}，乘船到{area:442}，再去{area:150}沿路向北（或经{area:17203}乘坐{area:2257}）。",

	-- Step 12: Desperate Prayer: an old letter
	-- {quest:5634} Desperate Prayer
	["{quest:5634}: an old letter"] = "{quest:5634}：一封旧信",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["This letter also goes to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}."] = "这封信同样要交给 {zone:1455} 的 {object:32362} 中、{object:32386} 内的 {npc:11406}。",

	-- Step 13: Chastise: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:5641} letter for {npc:11406} in {zone:1455} (the {area:2257} from the {object:28027})."] = "达到 20 级后，在 {zone:1453} 圣光大教堂祭坛旁的 {npc:376} 会给你一封 {quest:5641} 信件，让你交给 {zone:1455} 的 {npc:11406}（从 {object:28027} 乘坐 {area:2257} 前往）。",
	-- {npc:376} High Priestess Laurena · {quest:5641} Chastise
	["{npc:376}: take her {quest:5641} letter"] = "{npc:376}：领取她的{quest:5641}信件",

	-- Step 14: Chastise: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5641} letter for {npc:11406} in {zone:1455}."] = "在 {zone:1457} 达到20级后，{npc:11401} 会在月神殿上层露台、{npc:7999} 身旁给你一封 {quest:5641} 的信，要你送给 {zone:1455} 的 {npc:11406}。",
	-- {npc:11401} Priestess Alathea · {quest:5641} Chastise
	["{npc:11401}: take her {quest:5641} letter"] = "{npc:11401}：领取她的{quest:5641}信件",

	-- Step 15: Chastise: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {quest:5641} Chastise · {spell:6346} Fear Ward
	["At 20, {npc:11406} in the {object:32386} teaches {quest:5641} with a quest he gives and takes back at once. Forever renamed it from A Lack of Fear: {quest:5641} damages a humanoid and roots it for 2 seconds (instant, 2-minute cooldown), and every priest now trains {spell:6346}."] = "20 级时，{object:32386} 内的 {npc:11406} 会通过一个当场接受并交还的任务教你 {quest:5641}。无限将它从“无所畏惧”改名为现在的名称：{quest:5641} 会对一名人型生物造成伤害并定身 2 秒（瞬发，冷却 2 分钟），而且现在所有牧师都能学习 {spell:6346}。",

	-- Step 16: Chastise: Laurena's letter
	-- {quest:5645} Chastise
	["{quest:5645}: Laurena's letter"] = "{quest:5645}：高阶牧师劳瑞娜的信",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {quest:5645} Chastise
	["Hand Laurena's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: he teaches {quest:5645}."] = "将劳瑞娜的信交给 {zone:1455} 的 {object:32362} 中、位于 {object:32386} 的 {npc:11406}：他会教你 {quest:5645}。",

	-- Step 17: Chastise: Alathea's letter
	-- {quest:5647} Chastise
	["{quest:5647}: Alathea's letter"] = "{quest:5647}：女祭司阿兰希雅的信",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand Alathea's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1457}, the boats via {area:702} and {area:442} to {area:150}, then the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "将阿兰希亚的信交给 {zone:1455} 的 {object:32362} 中、位于 {object:32386} 的 {npc:11406}：从 {zone:1457} 出发，经 {area:702} 和 {area:442} 乘船到 {area:150}，然后沿道路向北穿过 {zone:1437} 和 {zone:1432}（也可以乘船到 {area:17203}，再乘坐 {area:2257}）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "10级时，去{zone:1455}{object:32362}的{object:32386}找{npc:11406}。Forever 的任务文本写的是洛汉，但任务数据显示由{zone:1453}光明大教堂的{npc:376}接收：先试洛汉，再试劳瑞娜（{area:2257}连接两座城市）。",
	-- ["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "20级时，{npc:11406}教授{quest:5641}。{zone:1453}的{npc:376}和{zone:1457}的{npc:11401}会用同名任务让你去找他。",
	-- ["At 20, {npc:11406} teaches {spell:1277331}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "20级时，{npc:11406}教授{spell:1277331}。{zone:1453}的{npc:376}和{zone:1457}的{npc:11401}会用同名任务让你去找他。",
	-- ["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "如果洛汉没有接收：{npc:376}在光明大教堂。从{object:171524}乘{area:2257}。",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "人类和矮人牧师的法术：10级的{quest:5634}，矮人20级的{quest:5641}。",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {spell:1277331} for Dwarves at 20."] = "人类和矮人牧师的法术：10级的{quest:5634}，矮人20级的{spell:1277331}。",
	-- ["{quest:5634} and {quest:5641}"] = "{quest:5634}与{quest:5641}",
	-- ["{quest:5634} and {spell:1277331}"] = "{quest:5634}与{spell:1277331}",
}
