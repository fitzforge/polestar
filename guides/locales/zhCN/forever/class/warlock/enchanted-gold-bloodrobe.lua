-- Chinese (simplified) (zhCN): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "31级时，{object:2101}{object:2164}的{npc:461}会让你去找{area:392}的{npc:6266}。",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "31级时，{zone:1455}的{npc:5172}会让你去找{area:392}的{npc:6266}。",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "31级时，{object:172960}的{npc:3326}会让你去找{area:392}的{npc:6266}。",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "31级时，{object:36082}的{npc:4563}会让你去找{area:392}的{npc:6266}。从{zone:1420}出发的飞艇飞往{zone:1411}。",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}站在{area:392}上方山丘的塔楼里，在{npc:6251}旁边。",

	-- Step 6: Robes of Arcana
	-- {npc:6266} Menara Voidrender · {item:5770} Robes of Arcana · {item:3577} Gold Bar · {item:2776} Gold Ore
	["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "给{npc:6266}带一件{item:5770}：裁缝可用掉落的图样缝制；否则在拍卖行购买。她的下一个差事需要一块{item:3577}：用{item:2776}熔炼，或在拍卖行购买。",

	-- Step 7: Xizk Goodstitch
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {item:3577} Gold Bar
	["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670}在{area:35}出售裁缝用品。把{item:3577}交给他。",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "回到{npc:6266}处",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "{zone:1443}的恶魔",
	-- {area:603} Sargeron · {zone:1443} Desolace
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal
	["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "{zone:1443}东北部{area:603}的怨怒萨特携带鲜血；南部玛诺洛克集会所的{npc:4676}携带石头。",
	["Vials of Hatefury Blood"] = "怨怒萨特之血",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "再次找{npc:6266}",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:2670} in {area:35} has the thread for you."] = "{area:35}的{npc:2670}为你准备了金线。",

	-- Step 12: Smoldering Coal
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "{zone:1417}西部的火元素烈焰流放者掉落煤块。",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "带着金线、煤块和一块{item:6265}回到{npc:6266}处。等她完成长袍，然后再次与她交谈。",
	["Wait for the robe"] = "等待长袍",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "{zone:1443}东北部{area:603}的怨怒萨特携带鲜血；南部{area:602}的次级地狱火携带石头。",
}
