-- Chinese (simplified) (zhCN): the guide forever/class/warlock/voidwalker-horde (forever/class/warlock/voidwalker-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Horde)"] = "虚空行者（部落）",
	["Your tank demon at 10: the voidwalker, after a stolen book and a fight at a summoning circle."] = "10级获得你的坦克恶魔：虚空行者。需先找回一本被盗的书，再在召唤法阵完成一场战斗。",

	-- Step 1: Gan'rul's Summons (Orcs and Trolls)
	-- {quest:1506} Gan'rul's Summons
	["{quest:1506} (Orcs and Trolls)"] = "{quest:1506}（兽人和巨魔）",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {area:362} Razor Hill · {npc:3172} Dhugru Gorelust · {object:172960} Cleft of Shadow · {zone:1454} Orgrimmar · {object:172982} Valley of Strength · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:5724} Ageron Kargal · {area:159} Brill
	["At 10 {npc:3294} sends you to {npc:5875}. He stands outside at the back of {area:362}'s barracks, the big building on the east side of town (not the inn), a few steps from {npc:3172}, the warlock trainer. {npc:5875} stands with the senior warlocks in the {object:172960}, the cavern under {zone:1454}'s {object:172982}. An Orc or Troll leveling in {zone:1420} can take the {zone:1458} version from {npc:5724} in {area:159} instead (the {zone:1458} steps below): you can do only one of the two."] = "10级时，{npc:3294}会派你去找{npc:5875}。他站在{area:362}兵营后面的室外，兵营是城镇东侧的大建筑（不是旅店），距术士训练师{npc:3172}只有几步。{npc:5875}和资深术士们在{object:172960}，即{zone:1454}的{object:172982}下方的洞穴中。在{zone:1420}练级的兽人或巨魔也可以改从{area:159}的{npc:5724}处接受{zone:1458}版本（见下方的{zone:1458}步骤）：两者只能做一个。",

	-- Step 2: Skull Rock
	-- {area:817} Skull Rock · {zone:1454} Orgrimmar · {object:58595} Burning Blade Stash · {npc:3204} Gazz'uz
	-- plural, as words: Burning Blade Apprentices = {npc:3198} Burning Blade Apprentice
	["{area:817} is the cave in the cliffs just east of {zone:1454}'s gate. Inside, take the right-hand ramp up and follow it to the top: the {object:58595} sits on that upper ledge, which cannot be reached from the lower floor. The cave is packed with Burning Blade Apprentices and Fanatics (level 9-11, many with voidwalkers) that respawn quickly, and {npc:3204}, a level 14 Burning Blade warlock, stands near the stash. Old notes call him elite; Forever's data lists him as normal. At 10 it is hard alone: pull one pack at a time and Fear the extra, wait for 11, or go with a friend. The stash always holds the tablet."] = "{area:817} 是 {zone:1454} 城门东侧紧邻悬崖中的洞穴。进入后，沿右侧斜坡一路向上到顶：{object:58595} 就在上方岩台，无法从下层直接到达。洞里挤满了刷新很快的火刃学徒和狂热者（9-11 级，许多带着虚空行者），藏物处附近还站着 {npc:3204}，一名 14 级火刃术士。旧资料称他是精英，但无限的数据将其列为普通怪。10 级时独自完成很困难：每次只拉一组，多出的用恐惧术控制；也可以等到 11 级，或找朋友同行。藏物处必定有石板。",
	-- {item:6535} Tablet of Verga · {object:58595} Burning Blade Stash
	["{item:6535}, in the {object:58595}"] = "{item:6535}，在{object:58595}里",

	-- Step 3: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {item:7464} Glyphs of Summoning · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5875}. He hands you the {item:7464}: take them across the {object:172960} to {npc:3216}'s tent, stand on the purple circle on its floor and use them. The voidwalker (level 10, not elite) hits hard at 30% health and leaves after three minutes, so start at once: {spell:14868}, Corruption and {spell:348}, send your imp in, and Fear it when you need a breather. If it beats you or leaves, the glyphs are not used up: use them again on the circle. Keep the glyphs: {npc:5875} takes them back."] = "返回 {npc:5875} 处。他会给你 {item:7464}：穿过 {object:172960} 到 {npc:3216} 的帐篷，站在地面的紫色法阵上使用。虚空行者（10级，非精英）在生命降至30%时攻击很痛，且三分钟后会离开，因此立即开打：施放 {spell:14868}、腐蚀术和 {spell:348}，派小鬼攻击，需要喘息时用恐惧控制它。如果打输了或它离开了，符文不会消耗：在法阵上再次使用即可。保留符文：{npc:5875} 会收回它们。",
	-- {item:7464} Glyphs of Summoning
	["{item:7464}, on the circle in Neeru's tent"] = "在尼尔鲁帐篷里的法阵上使用{item:7464}",

	-- Step 4: Halgar's Summons (Undercity)
	-- {npc:5724} Ageron Kargal · {area:2119} Gallows' End Tavern · {area:159} Brill · {npc:5675} Carendin Halgar · {zone:1420} Tirisfal Glades · {npc:5875} Gan'rul Bloodeye · {zone:1458} Undercity · {object:36082} Magic Quarter
	["At 10 {npc:5724}, upstairs in the {area:2119} in {area:159}, sends you to {npc:5675}: the version for the Undead, and for Orcs and Trolls who level in {zone:1420} instead of taking {npc:5875}'s. {npc:5675} stands in the {zone:1458}'s {object:36082}, by the Temple of the Damned."] = "10级时，{area:159}的{area:2119}楼上的{npc:5724}会让你去找{npc:5675}：这是亡灵的任务版本，也适用于在{zone:1420}练级、没有接受{npc:5875}任务的兽人和巨魔。{npc:5675}站在{zone:1458}的{object:36082}、诅咒神庙旁边。",
	-- {npc:5724} Ageron Kargal · {area:159} Brill
	["{npc:5724}, upstairs in the {area:159} inn"] = "{npc:5724}，在 {area:159} 旅店楼上",

	-- Step 5: Perrine's Chest
	-- {zone:1458} Undercity · {area:154} Deathknell · {npc:1662} Captain Perrine · {npc:1537} Scarlet Zealot
	["The Scarlet tower stands in the fields west of the {zone:1458}'s ruins (not the tower near {area:154}). The grimoire is in the small chest on the ground floor, under the stairs; ignore the chest upstairs. {npc:1662} (level 9) and a {npc:1537} guard it: kill them, or Fear the zealot while you deal with Perrine. Scarlet Missionaries and Zealots (level 7-9) walk the fields around the tower. The chest is back three seconds after anyone opens it."] = "血色塔楼位于 {zone:1458} 废墟西边的田地中（不是 {area:154} 附近那座塔）。魔典在底层楼梯下的小箱子里；不用管楼上的箱子。{npc:1662}（9级）和一名 {npc:1537} 守着它：可以都杀掉，也可以先恐惧狂热者，再对付派瑞恩。血色传教士和狂热者（7—9级）在塔周围的田地里走动。任何人开箱后三秒，箱子便会刷新。",
	-- {item:6285} Egalin's Grimoire · {object:37098} Perrine's Chest
	["{item:6285}, in {object:37098}"] = "{item:6285}，在{object:37098}里",

	-- Step 6: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {item:6284} Runes of Summoning · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5675}. He hands you the {item:6284}: go down the stairs from him to the summoning circle and use them while standing on it. Fight the voidwalker (level 10, not elite) on the circle: if it wanders off, the city guards may kill it and the kill does not count. {spell:14868}, Corruption and {spell:348} with your imp tanking bring it down; it hits harder below 30%. If you lose, use the runes again. Keep the runes: {npc:5675} takes them back."] = "回去找 {npc:5675}。他会给你 {item:6284}：沿他身边的楼梯下到召唤法阵，站在法阵上使用。就在法阵上与虚空行者战斗（10 级，非精英）：如果它走远，城里的守卫可能杀死它，那样就不算你的击杀。让小鬼扛着，用 {spell:14868}、腐蚀术和 {spell:348} 击败它；生命值低于 30% 后，它的攻击会更重。如果打输了，再使用符文。保留符文：{npc:5675} 会收回。",
	-- {item:6284} Runes of Summoning · {npc:5675} Carendin Halgar
	["{item:6284}, on the circle below {npc:5675}"] = "{item:6284}，在 {npc:5675} 下方的法阵上",
}
