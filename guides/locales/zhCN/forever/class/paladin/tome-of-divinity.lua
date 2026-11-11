-- Chinese (simplified) (zhCN): the guide forever/class/paladin/tome-of-divinity (forever/class/paladin/tome-of-divinity.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["{spell:7328} (Alliance)"] = "{spell:7328}（联盟）",
	-- {spell:7328} Redemption
	["{spell:7328} at 12, the paladin's resurrection: an easy chain through your capital and its home zone."] = "12级学习{spell:7328}，圣骑士的复活技能：一条简单的任务链，途经你的主城及其所在地区。",

	-- Step 1: The summons (Human)
	["The summons (Human)"] = "召唤（人类）",
	-- {npc:927} Brother Wilhelm · {area:87} Goldshire · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 12 {npc:927}, the paladin trainer in {area:87}, sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. The errand is optional, a little XP: {npc:5149} in {zone:1455} gives the same one (taking one closes the other), and {npc:6171} starts the chain without it."] = "12级时，{area:87} 的圣骑士训练师 {npc:927} 会派你去找 {zone:1453} 圣光大教堂里的 {npc:6171}。这个跑腿任务可选，只给少量经验：{zone:1455} 的 {npc:5149} 也提供相同任务（接了其中一个就无法接另一个），即使不做也能直接找 {npc:6171} 开始后续任务链。",

	-- Step 2: The summons (Dwarf)
	["The summons (Dwarf)"] = "召唤（矮人）",
	-- {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:6179} Tiza Battleforge · {npc:1232} Azar Stronghammer · {area:131} Kharanos · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 12 {npc:5149}, the paladin trainer in {zone:1455}'s {object:32362}, sends you upstairs to {npc:6179}. The errand is optional, a little XP: {npc:1232} in {area:131} and {npc:928} in {zone:1453} give the same one (taking one closes the others), and {npc:6179} starts the chain without it."] = "12级时，{zone:1455}的{object:32362}内的圣骑士训练师{npc:5149}会派你上楼找{npc:6179}。这趟跑腿可做可不做，只奖励少量经验：{area:131}的{npc:1232}和{zone:1453}的{npc:928}也提供相同任务（接受其中一个，其他的就会关闭），而且即使不做，{npc:6179}也会开启任务线。",

	-- Step 3: Duthorian Rall
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}，光明大教堂",

	-- Step 5: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {item:6775} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6171} stands inside the Cathedral of Light. He hands you the {item:6775}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6171} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6171} 站在圣光大教堂内。他会给你 {item:6775}：在背包中右键点击，开始下一个任务。如果书提示任务已经完成，销毁它，再找 {npc:6171} 要一本新的。如果手头有10块 {item:2589}，带上以备下一步使用。",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775}"] = "右键点击{item:6775}",

	-- Step 6: Stephanie Turner
	-- {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth · {zone:1436} Westfall
	["{npc:6174} stands at a corner in the middle of the {object:2096}, outside a general goods store. She wants 10 {item:2589}: humanoids drop it (Riverpaw gnolls in {zone:1436} about every other kill, Defias and kobolds a little less), or buy it at the Auction House a few steps away in the {object:2096}."] = "{npc:6174} 站在 {object:2096} 中部的一个街角，位于一家杂货店外。她需要10块 {item:2589}：人形生物会掉落（{zone:1436} 的河爪豺狼人约每杀两只掉一块，迪菲亚成员和狗头人的掉率稍低），也可以到几步之外的 {object:2096} 拍卖行购买。",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} × 10",

	-- Step 7: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {npc:6171} Duthorian Rall · {item:6866} Symbol of Life · {npc:6173} Gazin Tenorm · {npc:6172} Henze Faulk
	["Back to the Cathedral. {npc:6171} gives you the {item:6866}; {npc:6173} lies wounded by the altar of the same hall. Keep the symbol: you need it on {npc:6172}. If you lose it, {npc:6171} gives you another (The {item:6866})."] = "回到大教堂。{npc:6171} 会给你 {item:6866}；受伤的 {npc:6173} 就躺在同一大厅的祭坛旁。保留这个符记：之后还需要对 {npc:6172} 使用。如果弄丢了，{npc:6171} 会再给你一个（{item:6866}）。",

	-- Step 8: Henze Faulk
	-- {npc:6172} Henze Faulk · {area:56} Heroes' Vigil · {area:86} Stone Cairn Lake · {item:6866} Symbol of Life · {spell:116} Frostbolt
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{npc:6172} lies dead on {area:56}, the island in {area:86} in eastern Elwynn, on top of one of the mounds around the stone circle. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes. The Defias Rogue Wizards on the island (level 9-10) cast {spell:116} from far off: they stand apart, so pull one at a time."] = "{npc:6172}的尸体位于艾尔文森林东部{area:86}中的小岛{area:56}上，在石圈周围的一个土丘顶端。选中尸体，使用{item:6866}复活他，然后与他交谈。如果刚有其他圣骑士复活过他，尸体大约3分钟内会重新出现。岛上的迪菲亚流浪巫师（9-10级）会从远处施放{spell:116}：它们站得较分散，一次只引一个。",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["{item:6866} on {npc:6172}'s body"] = "{npc:6172} 尸体上的 {item:6866}。",

	-- Step 9: The Defias Script
	-- {item:6846} Defias Script
	["The {item:6846}"] = "{item:6846}",
	-- {npc:6172} Henze Faulk · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["The Defias Rogue Wizards around the big stone tablet east of {npc:6172} carry the {item:6846}: about one kill in two drops it, but some players need many kills. They respawn in three minutes."] = "{npc:6172} 东侧大石碑周围的迪菲亚流浪巫师携带 {item:6846}：大约每击杀两只会掉落一个，但有些玩家需要击杀很多只。它们每三分钟刷新。",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：{npc:474}",

	-- Step 10: Redemption
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {spell:7328} Redemption
	["Back to the Cathedral of Light: {npc:6173} takes the script, {npc:6171} teaches you {spell:7328}."] = "返回光明大教堂：将文稿交给{npc:6173}，{npc:6171}会教你{spell:7328}。",

	-- Step 11: Tiza Battleforge
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries
	["{npc:6179}, upstairs in the {object:32386}"] = "{npc:6179}，在{object:32386}楼上",

	-- Step 14: The Tome of Divinity
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {item:6916} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6179} stands upstairs in the {object:32386}, in the {object:32362}: take the ramp at the back of the hall. She hands you the {item:6916}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6179} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6179} 位于 {object:32362} 的 {object:32386} 楼上：走大厅后面的斜坡上去。她会给你 {item:6916}：在背包里右键点击它，开始下一个任务。如果书提示任务已经完成，就摧毁它，再向 {npc:6179} 要一本。有的话，带上 10 个 {item:2589}，下一步要用。",
	-- {item:6916} Tome of Divinity
	["Right-click the {item:6916}"] = "右键点击{item:6916}",

	-- Step 15: John Turner
	-- {npc:6175} John Turner · {item:2589} Linen Cloth · {npc:1245} Kogan Forgestone · {area:131} Kharanos
	-- plural, as words: Dark Iron Ambushers = {npc:1981} Dark Iron Ambusher
	["{npc:6175} walks the outer ring of the Commons, past the front gate, the bank and the Auction House. He wants 10 {item:2589}: humanoids drop it ({npc:1245} in {area:131} every time, Dark Iron Ambushers about two kills in five), or buy it at the Auction House on his ring."] = "{npc:6175} 在平民区外圈行走，会经过前门、银行和拍卖行。他需要 10 个 {item:2589}：人型生物会掉落（{area:131} 的 {npc:1245} 每次都掉，黑铁伏击者大约每击杀五只掉落两次），也可以在他行走路线上的拍卖行购买。",

	-- Step 16: The Symbol of Life
	-- {object:32386} Hall of Mysteries · {npc:6179} Tiza Battleforge · {item:6866} Symbol of Life · {npc:6178} Muiredon Battleforge · {npc:6177} Narm Faulk
	["Back upstairs in the {object:32386}. {npc:6179} gives you the {item:6866}; her husband {npc:6178} rests on the same floor. Keep the symbol: you need it on {npc:6177}. If you lose it, {npc:6179} gives you another (The {item:6866})."] = "返回 {object:32386} 楼上。{npc:6179} 会给你 {item:6866}；她的丈夫 {npc:6178} 就躺在同一层。保留这枚符记，之后要对 {npc:6177} 使用。若弄丢了，{npc:6179} 会再给你一枚（{item:6866}）。",

	-- Step 17: Narm Faulk
	-- {npc:6177} Narm Faulk · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:131} Kharanos · {area:212} Helm's Bed Lake · {object:147516} Dark Iron · {item:6866} Symbol of Life
	["{npc:6177} lies dead in {zone:1426}, not {zone:1432}: east past {area:131}, north-east of Ironband's compound, on the smallest of three little hills between {area:212} and the {object:147516} camp. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes."] = "{npc:6177} 的尸体在 {zone:1426}，不在 {zone:1432}：向东经过 {area:131}，在铁环营地东北方、{area:212} 与 {object:147516} 营地之间的三座小山丘中最小的那座上。选中他的尸体，使用 {item:6866} 将他复活，然后与他交谈。如果刚被另一位圣骑士复活过，他的尸体会在约三分钟内重新出现。",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["{item:6866} on {npc:6177}'s body"] = "{npc:6177} 尸体上的 {item:6866}。",

	-- Step 18: The Dark Iron Script
	-- {item:6847} Dark Iron Script
	["The {item:6847}"] = "{item:6847}",
	-- {item:6847} Dark Iron Script
	["The Dark Iron Spies (level 9-11, twelve of them) sneak around the little house below the lake, just south of Narm; you see them from his hill. About one kill in two drops the {item:6847}. They run for help at low health: finish them or step back. They respawn in three minutes."] = "黑铁间谍（9-11 级，共十二名）潜伏在湖下方的小屋周围，就在纳姆南侧；站在他所在的山坡上就能看到。它们大约每击杀两只会掉落一个 {item:6847}。生命值低时会逃跑求援：及时击杀，或后退避开。它们每三分钟刷新。",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}：黑铁间谍",

	-- Step 19: Redemption
	-- {object:32386} Hall of Mysteries · {npc:6178} Muiredon Battleforge · {npc:6179} Tiza Battleforge · {spell:7328} Redemption
	["Back up to the {object:32386}: {npc:6178} takes the script, {npc:6179} teaches you {spell:7328}."] = "回到 {object:32386} 楼上：{npc:6178} 收下书稿，{npc:6179} 教你 {spell:7328}。",
}
