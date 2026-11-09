-- Chinese (simplified) (zhCN): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "一件适合30多级的稀有布甲长袍，{npc:6266}会用你带来的材料制作。",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "31级时，{object:2101} 的 {object:2164} 内的 {npc:461} 会派你去 {area:392} 找 {npc:6266}。先买好一件 {item:5770} 和一块 {item:3577}（见后续步骤），可以省去往返。",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "31级时，{zone:1455}的{npc:5172}会派你去{area:392}找{npc:6266}。先买一个{item:5770}和一个{item:3577}（接下来的步骤会用到），省得多跑一趟。",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "31级时，{object:172960} 的 {npc:3326} 会派你去找 {area:392} 的 {npc:6266}。先买一件 {item:5770} 和一块 {item:3577}（后续步骤要用），免得多跑一趟。",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}; the zeppelin from {zone:1420} flies to {zone:1411}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "达到 31 级后，{object:36082} 中的 {npc:4563} 会让你去找 {area:392} 的 {npc:6266}；从 {zone:1420} 出发的飞艇会飞往 {zone:1411}。先买好一个 {item:5770} 和一个 {item:3577}（见后续步骤），免得多跑一趟。",

	-- Step 5: Robes of Arcana and a Gold Bar
	-- {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["{item:5770} and a {item:3577}"] = "{item:5770} 和一块 {item:3577}",
	-- {item:5770} Robes of Arcana · {item:2776} Gold Ore · {npc:6266} Menara Voidrender
	-- plural, as words: Gold Bars = {item:3577} Gold Bar
	["Tailors sew the {item:5770} from a rare pattern; miners smelt Gold Bars from {item:2776}. Everyone else buys both at the Auction House. If you wear the robe, take it off: {npc:6266} keeps it."] = "裁缝可以用稀有图样制作 {item:5770}；采矿者可以用 {item:2776} 熔炼金锭。其他人可在拍卖行购买这两样物品。如果你正穿着这件长袍，先脱下来：{npc:6266} 会将它收走。",
	-- {item:5770} Robes of Arcana
	["{item:5770}: the Auction House"] = "{item:5770}：从拍卖行购买",
	-- {item:3577} Gold Bar
	["{item:3577}: the Auction House"] = "{item:3577}：从拍卖行购买",

	-- Step 6: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet · {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:6266} stands by {npc:6251}'s tower on the hill above {area:392}, behind the engineers' hut. She takes the robe, then sends the gold bar to {npc:2670} in {area:35}."] = "{npc:6266} 站在 {area:392} 上方山坡上、工程师小屋后面的 {npc:6251} 高塔旁。她会收下长袍，然后让你把金锭送给 {area:35} 的 {npc:2670}。",

	-- Step 7: Xizk Goodstitch
	-- {area:392} Ratchet · {area:35} Booty Bay · {npc:2670} Xizk Goodstitch · {object:59851} A Tailor to Cities (no name in this language: may be words) · {item:3577} Gold Bar
	["The boat from {area:392} sails to {area:35}. {npc:2670} runs {object:59851} on an upper level of the town. Give him the {item:3577}; he will spin the thread later."] = "从 {area:392} 出发的船驶往 {area:35}。{npc:2670} 在镇内上层经营 {object:59851}。将 {item:3577} 交给他；他稍后会纺好线。",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "回到{npc:6266}处",
	-- {npc:6266} Menara Voidrender · {zone:1443} Desolace
	["You need no thread yet: {npc:6266} wants demon parts from {zone:1443} next."] = "暂时不需要线：接下来{npc:6266}要你去{zone:1443}收集恶魔的身体部件。",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "{zone:1443}的恶魔",
	-- {area:603} Sargeron · {zone:1443} Desolace · {area:608} Nijel's Point · {area:602} Mannoroc Coven · {spell:686} Shadow Bolt
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal · Demon Portal Guardians = {npc:11937} Demon Portal Guardian
	["The Hatefury satyrs (level 31-32) hold {area:603} in the far north-east of {zone:1443}, past {area:608}: two kills in five give a vial, so plan on about 25. The Lesser Infernals (36-37) and Demon Portal Guardians (38) of {area:602}, in the south, drop the stone half the time; they resist fire, so use {spell:686} and Corruption."] = "怨怒萨特（31-32级）盘踞在{zone:1443}最东北端、{area:608}后面的{area:603}：约五只出两瓶，预计需要击杀25只。南部{area:602}的次级地狱火（36-37级）和恶魔之门的卫士（38级）掉石头的概率为一半；它们有火焰抗性，因此使用{spell:686}和腐蚀术。",
	["Vials of Hatefury Blood"] = "怨怒萨特之血",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "再次找{npc:6266}",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {quest:4785} Fine Gold Thread
	["Back to {npc:2670} in {area:35}: he offers {quest:4785} as a quest you hand straight back to him. He may show no quest marker; talk to him anyway."] = "返回 {area:35} 的 {npc:2670} 处：他提供的 {quest:4785} 可以接到后立即交还。他可能没有任务标记，仍然要与他交谈。",

	-- Step 12: Smoldering Coal
	-- {area:334} Circle of West Binding · {zone:1417} Arathi Highlands · {spell:686} Shadow Bolt · {area:321} Hammerfall · {item:6265} Soul Shard · {spell:1120} Drain Soul
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Cresting Charms = {item:4481} Cresting Charm · Cresting Exiles = {npc:2761} Cresting Exile
	["The Burning Exiles (level 38-39), fire elementals at the {area:334} in western {zone:1417}, drop the coal about one time in three. They resist fire: {spell:686} and Corruption. Below 38 they hit hard; the Cresting Charms from the Cresting Exiles near {area:321} finish one off once you have hurt it. Make a {item:6265} with {spell:1120} on the way."] = "烈焰流放者（38—39级）是 {zone:1417} 西部 {area:334} 的火元素，煤炭掉率约为三分之一。它们抵抗火焰：使用 {spell:686} 和腐蚀术。未到38级时，它们打人很痛；先打伤它们，再使用 {area:321} 附近水浪流放者掉落的海浪咒符，就能将其消灭。路上用 {spell:1120} 制作一块 {item:6265}。",
	-- {item:6265} Soul Shard · {spell:1120} Drain Soul
	["{item:6265}: {spell:1120} on an Exile as it dies"] = "{item:6265}：在一只流放者即将死亡时对其使用 {spell:1120}。",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coals and a {item:6265}. Then wait beside her while she works the robe (do not attack her: the quest log calls it a kill), and speak to her again."] = "带着线、煤和一个 {item:6265} 返回 {npc:6266} 处。随后待在她身旁，等她制作长袍（不要攻击她：任务日志将其描述为击杀），再与她交谈。",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she finishes the robe"] = "待在 {npc:6266} 身旁，等她完成长袍。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "31级时，{object:172960}的{npc:3326}会让你去找{area:392}的{npc:6266}。",
	-- ["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "31级时，{object:36082}的{npc:4563}会让你去找{area:392}的{npc:6266}。从{zone:1420}出发的飞艇飞往{zone:1411}。",
	-- ["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "31级时，{object:2101}{object:2164}的{npc:461}会让你去找{area:392}的{npc:6266}。",
	-- ["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "31级时，{zone:1455}的{npc:5172}会让你去找{area:392}的{npc:6266}。",
	-- ["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "带着金线、煤块和一块{item:6265}回到{npc:6266}处。等她完成长袍，然后再次与她交谈。",
	-- ["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "给{npc:6266}带一件{item:5770}：裁缝可用掉落的图样缝制；否则在拍卖行购买。她的下一个差事需要一块{item:3577}：用{item:2776}熔炼，或在拍卖行购买。",
	-- ["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "{zone:1417}西部的火元素烈焰流放者掉落煤块。",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "{zone:1443}东北部{area:603}的怨怒萨特携带鲜血；南部玛诺洛克集会所的{npc:4676}携带石头。",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "{zone:1443}东北部{area:603}的怨怒萨特携带鲜血；南部{area:602}的次级地狱火携带石头。",
	-- ["Wait for the robe"] = "等待长袍",
	-- ["{npc:2670} in {area:35} has the thread for you."] = "{area:35}的{npc:2670}为你准备了金线。",
	-- ["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670}在{area:35}出售裁缝用品。把{item:3577}交给他。",
	-- ["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}站在{area:392}上方山丘的塔楼里，在{npc:6251}旁边。",
}
