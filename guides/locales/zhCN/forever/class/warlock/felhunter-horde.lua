-- Chinese (simplified) (zhCN): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "地狱猎犬（部落）",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "地狱猎犬，对付施法者的恶魔，外加一个用来装灵魂碎片的{item:22244}。",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "30级时，{object:172982}下方{object:172960}的{npc:5875}会让你去{area:392}找{npc:6251}。",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {quest:2996} Seeking Strahad
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}. Take only one {quest:2996}: if {npc:6251} offers nothing, drop the duplicate from your log."] = "30级时，{object:36082} 的 {npc:5675} 会派你去找 {area:392} 的 {npc:6251}。从 {zone:1420} 出发的飞艇前往 {zone:1411}。只接一个 {quest:2996}：如果 {npc:6251} 没有任务可接，就放弃任务日志中重复的那个。",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6293} Jorah Annison · {zone:1458} Undercity
	["{area:392}'s flight point is a short flight from {zone:1454}'s. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6293} in the {zone:1458}."] = "从{zone:1454}飞到{area:392}的飞行点只需很短时间。{npc:6251}站在镇上方的山丘上、工程师小屋后方、自己的小塔旁；{npc:6266}和两名侍僧也在那里。他会让你去找{zone:1458}的{npc:6293}。",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter · {zone:1458} Undercity · {quest:1801} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6293} is in the {object:36082} of the {zone:1458}. He wants two lost pieces of the {quest:1801}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6293} 位于 {zone:1458} 的 {object:36082}。他需要找回 {quest:1801} 遗失的两部分：一部分在 {area:287} 海岸，一部分在 {zone:1441}。",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "那本典籍是一本灰蓝色小书，躺在{area:271}西南面海岸鱼人营地的沙地上，靠近水边。有六七只鱼人守着，水下还潜伏着更多：它们会成群过来，用恐惧控制一只，让虚空行者扛住其他鱼人。走下到水边再点击书本；从山坡上点击会被箱子挡住鼠标。",
	-- {item:6931} Moldy Tome · {quest:1803} Tome of the Cabal
	["{item:6931}, from the {quest:1803} on the sand"] = "{item:6931}，来自沙地上的 {quest:1803}",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "半人马洞穴入口位于 {area:484} 北边的悬崖上。进去后每个岔路都靠右走，穿过小瀑布旁的水池，打开墙边、大箱子旁的小型深色箱子：大箱子不是目标。只有接了任务才能打开。离开时，身后的半人马会重新刷新。",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}，在{object:92423}里",

	-- Step 7: Back to Jorah Annison
	-- {npc:6293} Jorah Annison
	["Back to {npc:6293}"] = "返回{npc:6293}处",
	-- {npc:6293} Jorah Annison · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6293} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6293} 会将典籍拼好，并给你 {item:7006}：留着它，{npc:6251} 会连同魔棒一起收走。",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "导能魔棒",
	-- {area:1036} Angerfang Encampment · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1417} Arathi Highlands
	["The Dragonmaw hold {area:1036} in the hills east of the road through the {zone:1437}, south of the {area:881} you cross from {zone:1417}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "龙喉氏族占据了贯穿{zone:1437}的道路以东山丘中的{area:1036}，在你从{zone:1417}过来时经过的{area:881}南面。只有施法者掉落法杖，概率为五分之四：龙喉白骨守卫（27级，带骷髅宠物）和 龙喉暗影守卫（28级）。中央灵魂医者北面有一条陡峭小径，可绕过大多数战士进入营地。",
	["Rods of Channeling, from the Dragonmaw casters"] = "从龙喉施法者处获取引导魔棒。",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "回到 {area:392} 找 {npc:6251}。接受任务后，他会画出召唤法阵，学徒们会在上方引导出一个更大的法阵：留在塔内，等两者都完成。然后对法阵使用 {quest:1804}。地狱猎犬（30级，非精英）会沉默并消耗法力，而且两分钟后就会消失：提前召出虚空行者，开战立刻施加持续伤害技能，让虚空行者扛住。如果你死亡或战斗失败，就放弃 {quest:1795}，再从 {npc:6251} 处重接。保留魔典：{npc:6251} 会收回它。",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "在法阵上使用 {quest:1804}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "30级时，{object:36082}的{npc:5675}会让你去{area:392}找{npc:6251}。从{zone:1420}出发的飞艇飞往{zone:1411}。",
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "回到{area:392}找{npc:6251}。在他身旁的召唤法阵上使用{quest:1804}，击败地狱猎犬将其束缚。",
	-- ["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "飞往{area:392}；{npc:6251}站在镇里的山丘上。",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "{npc:1057}和龙喉暗影守卫占据着穿过{zone:1437}的道路东边的山丘：魔棒由它们掉落。",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}在{area:271}西边的海岸上，越过碎鳍鱼人的营地即可找到。",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}在{area:484}北边的峡谷里。",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}：他把地狱猎犬束缚给你",
	-- ["{npc:6293} stands in the {object:36082}."] = "{npc:6293}站在{object:36082}。",
}
