-- Chinese (traditional) (zhTW): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s from {npc:6266}; its last parts wait for levels 35 and 37."] = "30多級用的稀有布甲長袍，由{npc:6266}製作；最後幾樣材料要等到35級和37級。",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "31級時，{object:2101}{object:2164}的{npc:461}會派你去找{area:392}的{npc:6266}。先買一個{item:5770}和一個{item:3577}（接下來的步驟），省得多跑一趟。",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "31級時，{zone:1455}的{npc:5172}會派你去找{area:392}的{npc:6266}。先買一個{item:5770}和一個{item:3577}（接下來的步驟），省得多跑一趟。",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "31級時，{object:172960}的{npc:3326}會派你去找{area:392}的{npc:6266}。先買一個{item:5770}和一個{item:3577}（接下來的步驟），省得多跑一趟。",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}; the zeppelin from {zone:1420} flies to {zone:1411}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "",

	-- Step 5: Robes of Arcana and a Gold Bar
	-- {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["{item:5770} and a {item:3577}"] = "",
	-- {item:5770} Robes of Arcana · {item:2776} Gold Ore · {npc:6266} Menara Voidrender
	-- plural, as words: Gold Bars = {item:3577} Gold Bar
	["Tailors sew the {item:5770} from a rare pattern; miners smelt Gold Bars from {item:2776}. Everyone else buys both at the Auction House. If you wear the robe, take it off: {npc:6266} keeps it."] = "",
	-- {item:5770} Robes of Arcana
	["{item:5770}: the Auction House"] = "",
	-- {item:3577} Gold Bar
	["{item:3577}: the Auction House"] = "",

	-- Step 6: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet · {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:6266} stands by {npc:6251}'s tower on the hill above {area:392}, behind the engineers' hut. She takes the robe, then sends the gold bar to {npc:2670} in {area:35}."] = "",

	-- Step 7: Xizk Goodstitch
	-- {area:392} Ratchet · {area:35} Booty Bay · {npc:2670} Xizk Goodstitch · {object:59851} A Tailor to Cities (no name in this language: may be words) · {item:3577} Gold Bar
	["The boat from {area:392} sails to {area:35}. {npc:2670} runs {object:59851} on an upper level of the town. Give him the {item:3577}; he will spin the thread later."] = "",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "返回{npc:6266}",
	-- {npc:6266} Menara Voidrender · {zone:1443} Desolace
	["You need no thread yet: {npc:6266} wants demon parts from {zone:1443} next."] = "",

	-- Step 9: Hatefury satyrs
	["Hatefury satyrs"] = "怨怒薩特",
	-- {area:603} Sargeron · {zone:1443} Desolace · {area:608} Nijel's Point
	["The Hatefury satyrs (level 31-32) hold {area:603} in the far north-east of {zone:1443}, past {area:608}: two kills in five give a vial, so plan on about 25."] = "怨怒薩特（31-32級）盤踞在{zone:1443}最東北端、{area:608}再過去的{area:603}：大約每擊殺五隻掉兩瓶，預計要殺25隻左右。",
	["Vials of Hatefury Blood"] = "怨怒薩特之血",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {spell:686} Shadow Bolt
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal · Demon Portal Guardians = {npc:11937} Demon Portal Guardian
	["The Lesser Infernals (36-37) and Demon Portal Guardians (38) of {area:602}, in the south of {zone:1443}, drop the stone half the time. The guide waits for level 35 first: at 31 they are too strong to solo. They resist fire, so use {spell:686} and Corruption."] = "{zone:1443}南部{area:602}的次級地獄火（36-37級）和惡魔之門的衛士（38級）有一半機率掉落石頭。指南會先等到35級：31級時牠們太強，無法單刷。牠們有火焰抗性，所以使用{spell:686}和腐蝕術。",

	-- Step 11: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "再次找{npc:6266}",

	-- Step 12: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {quest:4785} Fine Gold Thread
	["Back to {npc:2670} in {area:35}: he offers {quest:4785} as a quest you hand straight back to him. He may show no quest marker; talk to him anyway."] = "",
	-- {npc:2670} Xizk Goodstitch · {quest:4785} Fine Gold Thread
	["{npc:2670}: {quest:4785}, handed straight back"] = "{npc:2670}：{quest:4785}，當場繳交",

	-- Step 13: Smoldering Coal
	-- {area:334} Circle of West Binding · {zone:1417} Arathi Highlands · {spell:686} Shadow Bolt · {area:321} Hammerfall · {item:6265} Soul Shard · {spell:1120} Drain Soul
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Cresting Charms = {item:4481} Cresting Charm · Cresting Exiles = {npc:2761} Cresting Exile
	["The Burning Exiles (level 38-39), fire elementals at the {area:334} in western {zone:1417}, drop the coal about one time in three. The guide waits for level 37 first: below it they hit too hard to solo. They resist fire: {spell:686} and Corruption. The Cresting Charms from the Cresting Exiles near {area:321} finish one off once you have hurt it. Make a {item:6265} with {spell:1120} on the way."] = "烈焰流放者（38-39級）是{zone:1417}西部{area:334}的火元素，煤炭掉落率約三分之一。指南會先等到37級：低於這個等級時牠們打得太痛，無法單刷。牠們抵抗火焰：使用{spell:686}和腐蝕術。先把牠打傷，再用{area:321}附近水浪流放者掉落的海浪符咒就能解決牠。途中用{spell:1120}製作一個{item:6265}。",
	-- {item:6265} Soul Shard · {spell:1120} Drain Soul
	["{item:6265}: {spell:1120} on an Exile as it dies"] = "",

	-- Step 14: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coals and a {item:6265}. Then wait beside her while she works the robe (do not attack her: the quest log calls it a kill), and speak to her again."] = "帶著線、煤塊和一個{item:6265}返回{npc:6266}。然後在她旁邊等她製作長袍（不要攻擊她：任務日誌把這稱為擊殺），再和她交談。",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she finishes the robe"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "30多級用的稀有布甲長袍，由{npc:6266}用你帶來的材料製作。",
	-- ["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "31級時，{object:36082}的{npc:4563}會派你去找{area:392}的{npc:6266}。從{zone:1420}出發的飛艇飛往{zone:1411}。",
	-- ["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "帶一件{item:5770}給{npc:6266}：裁縫可用掉落的圖樣縫製；否則在拍賣場購買。她的下一個差事需要一個{item:3577}：由{item:2776}熔煉，或在拍賣場購買。",
	-- ["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "{zone:1417}西部的火元素烈焰流放者會掉落悶燒煤。",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "{zone:1443}東北部{area:603}的怨怒薩特身上帶著血；南部瑪諾洛克集會所的次級地獄火身上帶著石頭。",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "{zone:1443}東北部{area:603}的怨怒薩特身上帶著血；南部{area:602}的次級地獄火身上帶著石頭。",
	-- ["Wait for the robe"] = "等待長袍完成",
	-- ["{npc:2670} in {area:35} has the thread for you."] = "{area:35}的{npc:2670}有你要的線。",
	-- ["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670}在{area:35}出售裁縫用品。把{item:3577}交給他。",
	-- ["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}站在{area:392}上方山丘的塔裡，{npc:6251}旁邊。",
	-- ["{zone:1443} demons"] = "{zone:1443}的惡魔",
}
