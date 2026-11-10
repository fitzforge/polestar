-- Chinese (simplified) (zhCN): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "地狱猎犬（联盟）",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "地狱猎犬，对付施法者的恶魔，外加一个用来装灵魂碎片的{item:22244}。",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "30级时，{object:2101}{object:2164}地下室的{npc:6122}会让你去{area:392}找{npc:6251}。",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "30级时，{object:32383}的{npc:6120}会让你去{area:392}找{npc:6251}。",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["{area:392} is a neutral goblin port on the {zone:1413} coast: the boat from {area:35} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "{area:392}是{zone:1413}海岸的一座中立地精港口：从{area:35}来的船在此停靠。{npc:6251}站在镇子上方的山丘上，工程师小屋后方、他的小塔旁；{npc:6266}和两名侍僧也在。他会派你去{zone:1455}找{npc:6294}。",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers · {quest:1758} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6294}在{object:32356}的图书馆里。他需要{quest:1758}遗失的两部分：一部分在{area:287}海岸，另一部分在{zone:1441}。",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "那本典籍是一本灰蓝色小书，躺在{area:271}西南面海岸鱼人营地的沙地上，靠近水边。有六七只鱼人守着，水下还潜伏着更多：它们会成群过来，用恐惧控制一只，让虚空行者扛住其他鱼人。走下到水边再点击书本；从山坡上点击会被箱子挡住鼠标。",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "{item:6931}，来自沙地上的 {quest:1802}",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "半人马洞穴入口位于 {area:484} 北边的悬崖上，那是部落城镇，要避开守卫。进去后每个岔路都靠右走，穿过小瀑布旁的水池，打开墙边、大箱子旁的小型深色箱子：大箱子不是目标。只有接了任务才能打开。离开时，身后的半人马会重新刷新。",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}，在{object:92423}里",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "返回{npc:6294}处",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6294} 会将典籍拼好，并给你 {item:7006}：留着它，{npc:6251} 会连同魔棒一起收走。",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "导能魔棒",
	-- {area:1036} Angerfang Encampment · {area:150} Menethil Harbor · {area:836} Dun Algaz
	["The Dragonmaw hold {area:1036} in the hills east of the road from {area:150} to {area:836}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "龙喉氏族占据了 {area:1036}，位于 {area:150} 通往 {area:836} 的道路东侧山丘中。只有施法者会掉落魔棒，概率为五分之四：护骨者（27 级，带骷髅宠物）和暗影守卫（28 级）。中央灵魂医者北侧有一条陡峭小路，沿路可绕过大多数战士，进入营地。",
	["Rods of Channeling, from the Dragonmaw casters"] = "从龙喉施法者处获取引导魔棒。",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "回到 {area:392} 找 {npc:6251}。接受任务后，他会画出召唤法阵，学徒们会在上方引导出一个更大的法阵：留在塔内，等两者都完成。然后对法阵使用 {quest:1804}。地狱猎犬（30级，非精英）会沉默并消耗法力，而且两分钟后就会消失：提前召出虚空行者，开战立刻施加持续伤害技能，让虚空行者扛住。如果你死亡或战斗失败，就放弃 {quest:1795}，再从 {npc:6251} 处重接。保留魔典：{npc:6251} 会收回它。",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "在法阵上使用 {quest:1804}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "回到{area:392}找{npc:6251}。在他身旁的召唤法阵上使用{quest:1804}，击败地狱猎犬将其束缚。",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "{npc:1057}和龙喉暗影守卫占据着穿过{zone:1437}的道路东边的山丘：魔棒由它们掉落。",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}在{area:271}西边的海岸上，越过碎鳍鱼人的营地即可找到。",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}在{area:484}北边的峡谷里。",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392}位于{zone:1413}海岸；{npc:6251}站在镇里的山丘上。",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}：他把地狱猎犬束缚给你",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294}站在{object:32356}。",
}
