-- Chinese (traditional) (zhTW): the guide forever/class/paladin/tome-of-divinity (forever/class/paladin/tome-of-divinity.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["{spell:7328} (Alliance)"] = "{spell:7328}（聯盟）",
	-- {spell:7328} Redemption
	["{spell:7328} at 12, the paladin's resurrection: an easy chain through your capital and its home zone."] = "12級學習{spell:7328}，聖騎士的復活技能：一條簡單的任務鏈，途經你的主城及其所在地區。",

	-- Step 1: The summons (Human)
	["The summons (Human)"] = "召喚（人類）",
	-- {npc:927} Brother Wilhelm · {area:87} Goldshire · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 12 {npc:927}, the paladin trainer in {area:87}, sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. The errand is optional, a little XP: {npc:5149} in {zone:1455} gives the same one (taking one closes the other), and {npc:6171} starts the chain without it."] = "12級時，{area:87}的聖騎士訓練師{npc:927}會讓你去{zone:1453}光明大教堂的{npc:6171}。這個差事是可選的，能給一點經驗：{zone:1455}的{npc:5149}給同樣的任務（接其中一個會關閉另一個），而且不接它{npc:6171}也會開啟這條任務鏈。",

	-- Step 2: The summons (Dwarf)
	["The summons (Dwarf)"] = "召喚（矮人）",
	-- {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:6179} Tiza Battleforge · {npc:1232} Azar Stronghammer · {area:131} Kharanos · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 12 {npc:5149}, the paladin trainer in {zone:1455}'s {object:32362}, sends you upstairs to {npc:6179}. The errand is optional, a little XP: {npc:1232} in {area:131} and {npc:928} in {zone:1453} give the same one (taking one closes the others), and {npc:6179} starts the chain without it."] = "12級時，{zone:1455}的{object:32362}裡的聖騎士訓練師{npc:5149}會派你上樓去找{npc:6179}。這個差事是可選的，能給一點經驗：{area:131}的{npc:1232}和{zone:1453}的{npc:928}給同樣的任務（接其中一個會關閉其他），而且不接它{npc:6179}也會開啟這條任務鏈。",

	-- Step 3: Duthorian Rall
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}，光明大教堂",

	-- Step 5: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {quest:2998} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6171} stands inside the Cathedral of Light. He hands you the {quest:2998}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6171} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "",
	-- {quest:2998} Tome of Divinity
	["Right-click the {quest:2998}"] = "",

	-- Step 6: Stephanie Turner
	-- {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth · {zone:1436} Westfall
	["{npc:6174} stands at a corner in the middle of the {object:2096}, outside a general goods store. She wants 10 {item:2589}: humanoids drop it (Riverpaw gnolls in {zone:1436} about every other kill, Defias and kobolds a little less), or buy it at the Auction House a few steps away in the {object:2096}."] = "{npc:6174}站在{object:2096}中部的一個轉角，一家雜貨店門外。她要10塊{item:2589}：人形怪會掉落（{zone:1436}的河爪豺狼人約每兩次擊殺掉一個，迪菲亞和狗頭人略少一些），或者在幾步之外{object:2096}裡的拍賣行購買。",
	-- {item:2589} Linen Cloth
	["{item:2589} x10: humanoids, or the Auction House"] = "{item:2589} x10：人型生物，或拍賣場",

	-- Step 7: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {npc:6171} Duthorian Rall · {item:6866} Symbol of Life · {npc:6173} Gazin Tenorm · {npc:6172} Henze Faulk
	["Back to the Cathedral. {npc:6171} gives you the {item:6866}; {npc:6173} lies wounded by the altar of the same hall. Keep the symbol: you need it on {npc:6172}. If you lose it, {npc:6171} gives you another (The {item:6866})."] = "回到大教堂。{npc:6171}給你{item:6866}；{npc:6173}受傷躺在同一座大廳的祭壇旁。留著這個符號：在{npc:6172}身上要用到。如果丟了，{npc:6171}會再給你一個（{item:6866}）。",

	-- Step 8: Henze Faulk
	-- {npc:6172} Henze Faulk · {area:56} Heroes' Vigil · {area:86} Stone Cairn Lake · {item:6866} Symbol of Life · {spell:116} Frostbolt
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{npc:6172} lies dead on {area:56}, the island in {area:86} in eastern Elwynn, on top of one of the mounds around the stone circle. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes. The Defias Rogue Wizards on the island (level 9-10) cast {spell:116} from far off: they stand apart, so pull one at a time."] = "{npc:6172}死在{area:56}上，那是艾爾文東部{area:86}中的小島，就在石陣周圍一座土丘頂上。選中他的屍體並使用{item:6866}把他復活，然後與他交談。如果剛有另一個聖騎士復活了他，他的屍體會在約三分鐘內重新出現。島上的迪菲亞流氓巫師（9-10級）會遠端施放{spell:116}：它們站得分散，所以一隻一隻拉。",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["{item:6866} on {npc:6172}'s body"] = "{item:6866}在{npc:6172}的屍體上",

	-- Step 9: The Defias Script
	-- {item:6846} Defias Script
	["The {item:6846}"] = "{item:6846}",
	-- {npc:6172} Henze Faulk · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["The Defias Rogue Wizards around the big stone tablet east of {npc:6172} carry the {item:6846}: about one kill in two drops it, but some players need many kills. They respawn in three minutes."] = "在{npc:6172}以東那座大石板周圍，迪菲亞流氓巫師身上帶著{item:6846}：約兩次擊殺掉一個，但有些玩家殺了很多次才出。三分鐘重新整理。",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：迪菲亞流浪巫師",

	-- Step 10: Redemption
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {spell:7328} Redemption
	["Back to the Cathedral of Light: {npc:6173} takes the script, {npc:6171} teaches you {spell:7328}."] = "回到光明大教堂：{npc:6173}收下名冊，{npc:6171}教你{spell:7328}。",

	-- Step 11: Tiza Battleforge
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries
	["{npc:6179}, upstairs in the {object:32386}"] = "{npc:6179}，{object:32386}樓上",

	-- Step 14: The Tome of Divinity
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {quest:2997} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6179} stands upstairs in the {object:32386}, in the {object:32362}: take the ramp at the back of the hall. She hands you the {quest:2997}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6179} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "",
	-- {quest:2997} Tome of Divinity
	["Right-click the {quest:2997}"] = "",

	-- Step 15: John Turner
	-- {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1432} Loch Modan
	-- plural, as words: Dark Iron Ambushers = {npc:1981} Dark Iron Ambusher
	["{npc:6175} walks the outer ring of the Commons, past the front gate, the bank and the Auction House. He wants 10 {item:2589}: humanoids drop it (in {zone:1432} the Dark Iron Ambushers, Tunnel Rat kobolds and Stonesplinter troggs about two kills in five), or buy it at the Auction House on his ring."] = "",

	-- Step 16: The Symbol of Life
	-- {object:32386} Hall of Mysteries · {npc:6179} Tiza Battleforge · {item:6866} Symbol of Life · {npc:6178} Muiredon Battleforge · {npc:6177} Narm Faulk
	["Back upstairs in the {object:32386}. {npc:6179} gives you the {item:6866}; her husband {npc:6178} rests on the same floor. Keep the symbol: you need it on {npc:6177}. If you lose it, {npc:6179} gives you another (The {item:6866})."] = "回到{object:32386}樓上。{npc:6179}給你{item:6866}；她的丈夫{npc:6178}在同一層休息。留著這個符號：在{npc:6177}身上要用到。如果丟了，{npc:6179}會再給你一個（{item:6866}）。",

	-- Step 17: Narm Faulk
	-- {npc:6177} Narm Faulk · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:131} Kharanos · {area:212} Helm's Bed Lake · {object:147516} Dark Iron · {item:6866} Symbol of Life
	["{npc:6177} lies dead in {zone:1426}, not {zone:1432}: east past {area:131}, north-east of Ironband's compound, on the smallest of three little hills between {area:212} and the {object:147516} camp. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes."] = "{npc:6177}死在{zone:1426}，而不是{zone:1432}：向東經過{area:131}，在鐵帶營地東北，{area:212}與{object:147516}營地之間三座小丘中最矮的那座頂上。選中他的屍體並使用{item:6866}把他復活，然後與他交談。如果剛有另一個聖騎士復活了他，他的屍體會在約三分鐘內重新出現。",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["{item:6866} on {npc:6177}'s body"] = "{item:6866}在{npc:6177}的屍體上",

	-- Step 18: The Dark Iron Script
	-- {item:6847} Dark Iron Script
	["The {item:6847}"] = "{item:6847}",
	-- {item:6847} Dark Iron Script
	["The Dark Iron Spies (level 9-11, twelve of them) sneak around the little house below the lake, just south of Narm; you see them from his hill. About one kill in two drops the {item:6847}. They run for help at low health: finish them or step back. They respawn in three minutes."] = "黑鐵間諜（9-11級，共十二個）在湖下方的小屋周圍潛行，就在納姆以南；從他所在的山丘能看見它們。約兩次擊殺掉一個{item:6847}。它們低血量時會逃跑求援：殺掉它們或者後退。三分鐘重新整理。",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}：黑鐵間諜",

	-- Step 19: Redemption
	-- {object:32386} Hall of Mysteries · {npc:6178} Muiredon Battleforge · {npc:6179} Tiza Battleforge · {spell:7328} Redemption
	["Back up to the {object:32386}: {npc:6178} takes the script, {npc:6179} teaches you {spell:7328}."] = "回到{object:32386}上層：{npc:6178}收下名冊，{npc:6179}教你{spell:7328}。",
}
