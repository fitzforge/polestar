-- Chinese (traditional) (zhTW): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "地獄獵犬（部落）",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "地獄獵犬是對付施法者的惡魔，另附一個{item:22244}存放靈魂碎片。",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "30級時，{object:172982}下方{object:172960}的{npc:5875}會派你去找{area:392}的{npc:6251}。",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {quest:3001} Seeking Strahad
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}. Take only one {quest:3001}: if {npc:6251} offers nothing, drop the duplicate from your log."] = "30級時，{object:36082}的{npc:5675}會派你去找{area:392}的{npc:6251}。從{zone:1420}出發的飛艇飛往{zone:1411}。{quest:3001}只接一個：如果{npc:6251}沒有提供任何任務，就從任務日誌中放棄重複的那個。",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6293} Jorah Annison · {zone:1458} Undercity
	["{area:392}'s flight point is a short flight from {zone:1454}'s. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6293} in the {zone:1458}."] = "{area:392}的飛行點離{zone:1454}的飛行點只有一小段航程。{npc:6251}站在鎮上的山丘上，工程師小屋後面，他那座小塔旁邊；{npc:6266}和兩名助手跟他在一起。他派你去找{zone:1458}的{npc:6293}。",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter · {zone:1458} Undercity · {quest:1801} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6293} is in the {object:36082} of the {zone:1458}. He wants two lost pieces of the {quest:1801}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6293}在{zone:1458}的{object:36082}裡。他需要{quest:1801}的兩件失落部件：一件在{area:287}海岸，一件在{zone:1441}。",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "那本書是一本灰藍色的小書，躺在{area:271}西南海岸一處魚人營地的沙地上，靠近水邊。六七隻魚人守著它，水下還藏著一批：它們成群出現，所以恐懼一隻，讓虛空行者對付其餘的。走到水邊才能點它；從山坡上點會被木箱擋住游標。",
	-- {item:6931} Moldy Tome · {quest:1803} Tome of the Cabal
	["{item:6931}, from the {quest:1803} on the sand"] = "{item:6931}，出自沙地上的{quest:1803}",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "半人馬的洞穴在{area:484}以北的崖壁上。進去後每個岔路都往右，穿過小瀑布旁的水池，開啟靠牆在大箱子旁邊的小黑箱：大的那個是錯的。只有接了任務才能開啟它。出來時半人馬會在你身後重新整理。",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}，在{object:92423}裡",

	-- Step 7: Back to Jorah Annison
	-- {npc:6293} Jorah Annison
	["Back to {npc:6293}"] = "回到{npc:6293}",
	-- {npc:6293} Jorah Annison · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6293} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6293}把書拼合起來，交給你{item:7006}：留著它，{npc:6251}會連同導能法杖一起收走。",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "導能魔棒",
	-- {area:1036} Angerfang Encampment · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1417} Arathi Highlands
	["The Dragonmaw hold {area:1036} in the hills east of the road through the {zone:1437}, south of the {area:881} you cross from {zone:1417}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "龍喉的據點{area:1036}位於穿過{zone:1437}那條路以東的山丘裡，在你從{zone:1417}穿過來的{area:881}以南。只有施法者掉導能法杖，大約五隻掉四隻：白骨守衛（27級，帶骷髏寵物）和暗影守衛（28級）。中央靈魂醫者以北的一條陡峭小路能直接進營地，繞過大部分戰士。",
	["Rods of Channeling, from the Dragonmaw casters"] = "導能法杖，由龍喉施法者掉落",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "回到{area:392}找{npc:6251}。接受任務後，他會畫出召喚法陣，他的助手們會在上面引導一個更大的法陣：在塔裡等到兩個法陣都完成。然後在法陣上使用{quest:1804}。地獄犬（30級，非精英）會沉默並吸取法力，兩分鐘後消失：先放出你的虛空行者，立刻掛上持續傷害，讓虛空行者負責扛。如果你死了或它贏了，放棄{quest:1795}，再從{npc:6251}那裡重新接。留著那本書：{npc:6251}會把它收回去。",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "{quest:1804}，在法陣上",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}. Take only one {quest:2996}: if {npc:6251} offers nothing, drop the duplicate from your log."] = "30級時，{object:36082}的{npc:5675}會派你去找{area:392}的{npc:6251}。從{zone:1420}出發的飛艇飛往{zone:1411}。{quest:2996}只接一個：如果{npc:6251}沒有提供任何任務，就從任務日誌中放棄重複的那個。",
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "返回{area:392}找{npc:6251}。對他身旁的召喚法陣使用{quest:1804}，擊敗地獄獵犬以束縛牠。",
	-- ["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "飛往{area:392}；{npc:6251}站在鎮上的山丘上。",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "龍喉白骨守衛和龍喉暗影守衛佔據{zone:1437}道路東側的丘陵：魔棒由他們掉落。",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}在{area:271}西邊的海岸上，過了碎鰭魚人的營地。",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}在{area:484}北邊的峽谷中。",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}：他會把地獄獵犬束縛給你",
	-- ["{npc:6293} stands in the {object:36082}."] = "{npc:6293}站在{object:36082}。",
}
