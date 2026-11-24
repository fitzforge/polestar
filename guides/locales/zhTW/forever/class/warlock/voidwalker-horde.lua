-- Chinese (traditional) (zhTW): the guide forever/class/warlock/voidwalker-horde (forever/class/warlock/voidwalker-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Horde)"] = "虛空行者（部落）",
	["Your tank demon at 10: the voidwalker, after a stolen book and a fight at a summoning circle."] = "10級獲得你的坦克惡魔：虛空行者。需先找回一本被盜的書，再在召喚法陣完成一場戰鬥。",

	-- Step 1: Gan'rul's Summons (Orcs and Trolls)
	-- {quest:1506} Gan'rul's Summons
	["{quest:1506} (Orcs and Trolls)"] = "{quest:1506}（獸人和食人妖）",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {area:362} Razor Hill · {npc:3172} Dhugru Gorelust · {object:172960} Cleft of Shadow · {zone:1454} Orgrimmar · {object:172982} Valley of Strength · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:5724} Ageron Kargal · {area:159} Brill
	["At 10 {npc:3294} sends you to {npc:5875}. He stands outside at the back of {area:362}'s barracks, the big building on the east side of town (not the inn), a few steps from {npc:3172}, the warlock trainer. {npc:5875} stands with the senior warlocks in the {object:172960}, the cavern under {zone:1454}'s {object:172982}. An Orc or Troll leveling in {zone:1420} can take the {zone:1458} version from {npc:5724} in {area:159} instead (the {zone:1458} steps below): you can do only one of the two."] = "10級時{npc:3294}讓你去找{npc:5875}。他站在{area:362}兵營的後門外，兵營是鎮子東側的大建築（不是旅店），離術士訓練師{npc:3172}只有幾步。{npc:5875}與資深術士們一起站在{object:172960}裡，即{zone:1454}{object:172982}下方的洞窟。在{zone:1420}練級的獸人或食人妖也可以改從{area:159}的{npc:5724}那裡接{zone:1458}版本（下面列出的{zone:1458}步驟）：兩者只能做一個。",

	-- Step 2: Skull Rock
	-- {area:817} Skull Rock · {zone:1454} Orgrimmar · {object:58595} Burning Blade Stash · {npc:3204} Gazz'uz
	-- plural, as words: Burning Blade Apprentices = {npc:3198} Burning Blade Apprentice
	["{area:817} is the cave in the cliffs just east of {zone:1454}'s gate. Inside, take the right-hand ramp up and follow it to the top: the {object:58595} sits on that upper ledge, which cannot be reached from the lower floor. The cave is packed with Burning Blade Apprentices and Fanatics (level 9-11, many with voidwalkers) that respawn quickly, and {npc:3204}, a level 14 Burning Blade warlock, stands near the stash. Old notes call him elite; Forever's data lists him as normal. At 10 it is hard alone: pull one pack at a time and Fear the extra, wait for 11, or go with a friend. The stash always holds the tablet."] = "{area:817}是{zone:1454}城門正東懸崖上的洞穴。進洞後走右側的坡道一路向上到頂：{object:58595}就在上層巖臺上，從下層走不上去。洞裡擠滿了火刃學徒和火刃狂熱者（9-11級，很多帶著虛空行者），重新出現很快；{npc:3204}是一名14級火刃術士，就站在儲物點旁。舊資料把他標為精英；Forever的資料把他列為普通怪。10級時單人很難打：一次只拉一波並恐懼多餘目標，或者等到11級，或者找個朋友一起去。儲物點必定藏有那塊石板。",
	-- {item:6535} Tablet of Verga · {object:58595} Burning Blade Stash
	["{item:6535}, in the {object:58595}"] = "{item:6535}，在{object:58595}裡",

	-- Step 3: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {item:7464} Glyphs of Summoning · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5875}. He hands you the {item:7464}: take them across the {object:172960} to {npc:3216}'s tent, stand on the purple circle on its floor and use them. The voidwalker (level 10, not elite) hits hard at 30% health and leaves after three minutes, so start at once: {spell:14868}, Corruption and {spell:348}, send your imp in, and Fear it when you need a breather. If it beats you or leaves, the glyphs are not used up: use them again on the circle. Keep the glyphs: {npc:5875} takes them back."] = "回到{npc:5875}處。他把{item:7464}交給你：拿著它們穿過{object:172960}到{npc:3216}的帳篷，站在帳內的紫色法陣上使用。虛空行者（10級，非精英）血量30%時打得很疼，且三分鐘後就會消失，所以立刻開打：{spell:14868}、腐蝕術和{spell:348}，派小鬼上，需要喘息時就恐懼它。如果它擊敗你或消失了，銘文不會被消耗：在法陣上再用一次。留著銘文：{npc:5875}會收回。",
	-- {item:7464} Glyphs of Summoning
	["{item:7464}, on the circle in Neeru's tent"] = "{item:7464}，在尼魯帳篷裡的法陣上",

	-- Step 4: Halgar's Summons (Undercity)
	-- {npc:5724} Ageron Kargal · {area:2119} Gallows' End Tavern · {area:159} Brill · {npc:5675} Carendin Halgar · {zone:1420} Tirisfal Glades · {npc:5875} Gan'rul Bloodeye · {zone:1458} Undercity · {object:36082} Magic Quarter
	["At 10 {npc:5724}, upstairs in the {area:2119} in {area:159}, sends you to {npc:5675}: the version for the Undead, and for Orcs and Trolls who level in {zone:1420} instead of taking {npc:5875}'s. {npc:5675} stands in the {zone:1458}'s {object:36082}, by the Temple of the Damned."] = "10級時，{area:159}{area:2119}樓上的{npc:5724}讓你去找{npc:5675}：這個版本面向不死族，以及在{zone:1420}練級、不接{npc:5875}版本的獸人和食人妖。{npc:5675}站在{zone:1458}的{object:36082}裡，就在詛咒神廟旁。",
	-- {npc:5724} Ageron Kargal · {area:159} Brill
	["{npc:5724}, upstairs in the {area:159} inn"] = "{npc:5724}，在{area:159}旅店樓上",

	-- Step 5: Perrine's Chest
	-- {zone:1458} Undercity · {area:154} Deathknell · {npc:1662} Captain Perrine · {npc:1537} Scarlet Zealot
	["The Scarlet tower stands in the fields west of the {zone:1458}'s ruins (not the tower near {area:154}). The grimoire is in the small chest on the ground floor, under the stairs; ignore the chest upstairs. {npc:1662} (level 9) and a {npc:1537} guard it: kill them, or Fear the zealot while you deal with Perrine. Scarlet Missionaries and Zealots (level 7-9) walk the fields around the tower. The chest is back three seconds after anyone opens it."] = "血色十字軍的塔樓矗立在{zone:1458}廢墟以西的田野裡（不是{area:154}附近那座）。魔典在一樓樓梯下的小箱子裡；樓上那個箱子不用管。{npc:1662}（9級）和一名{npc:1537}守著它：殺掉他們，或者在你對付佩林時恐懼狂熱者。血色傳教士和血色狂熱者（7-9級）在塔周圍的田野裡走動。任何人開過箱子三秒後它就會重新出現。",
	-- {item:6285} Egalin's Grimoire · {object:37098} Perrine's Chest
	["{item:6285}, in {object:37098}"] = "{item:6285}，在{object:37098}裡",

	-- Step 6: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {item:6284} Runes of Summoning · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5675}. He hands you the {item:6284}: go down the stairs from him to the summoning circle and use them while standing on it. Fight the voidwalker (level 10, not elite) on the circle: if it wanders off, the city guards may kill it and the kill does not count. {spell:14868}, Corruption and {spell:348} with your imp tanking bring it down; it hits harder below 30%. If you lose, use the runes again. Keep the runes: {npc:5675} takes them back."] = "回到{npc:5675}處。他把{item:6284}交給你：從他那裡下樓梯到召喚法陣，站在法陣上使用符文。在法陣上與虛空行者（10級，非精英）戰鬥：如果它跑出法陣，城市守衛可能殺掉它且不算你的擊殺。讓你的小鬼抗住，用{spell:14868}、腐蝕術和{spell:348}把它打死；它血量低於30%時傷害更高。如果你輸了，再用一次符文。留著符文：{npc:5675}會收回。",
	-- {item:6284} Runes of Summoning · {npc:5675} Carendin Halgar
	["{item:6284}, on the circle below {npc:5675}"] = "{item:6284}，在{npc:5675}下方的法陣上",
}
