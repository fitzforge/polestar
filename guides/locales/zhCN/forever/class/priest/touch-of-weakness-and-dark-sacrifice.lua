-- Chinese (simplified) (zhCN): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652}与{quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} (new in Forever) at 20. Free, no objectives."] = "亡灵牧师的法术：10级的{spell:2652}，20级的{quest:5644}（无限新增）。免费，无任务目标。",

	-- Step 1: Touch of Weakness: Tai'jin
	-- {zone:1411} Durotar · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1411}, {npc:3706}, the priest trainer inside the barracks of {area:362}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "在{zone:1411}达到10级时，{area:362}兵营内的牧师训练师{npc:3706}会交给你一封关于{spell:2652}的信，让你送给{zone:1458}的{npc:4606}。",
	-- {npc:3706} Tai'jin · {spell:2652} Touch of Weakness
	["{npc:3706}: take his {spell:2652} letter"] = "{npc:3706}：收下他关于 {spell:2652} 的信",

	-- Step 2: Touch of Weakness: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity · {zone:1420} Tirisfal Glades
	["At 10 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}. The zeppelin to {zone:1420} leaves from the tower outside {zone:1454}'s front gate."] = "在{zone:1454}达到10级时，{object:172961}里的{npc:6018}会交给你一封关于{spell:2652}的信，让你送给{zone:1458}的{npc:4606}。前往{zone:1420}的飞艇从{zone:1454}正门外的塔楼出发。",
	-- {npc:6018} Ur'kyo · {spell:2652} Touch of Weakness
	["{npc:6018}: take his {spell:2652} letter"] = "{npc:6018}：收下他关于 {spell:2652} 的信",

	-- Step 3: Touch of Weakness: Var'jun
	-- {zone:1412} Mulgore · {npc:11407} Var'jun · {area:222} Bloodhoof Village · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1412}, {npc:11407}, just south-west of {area:222}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "达到 10 级后，{zone:1412} 中、{area:222} 西南不远处的 {npc:11407} 会给你一封 {spell:2652} 信件，让你交给 {zone:1458} 的 {npc:4606}。",
	-- {npc:11407} Var'jun · {spell:2652} Touch of Weakness
	["{npc:11407}: take the {spell:2652} letter"] = "{npc:11407}：领取{spell:2652}的信",

	-- Step 4: Touch of Weakness: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {spell:2652} Touch of Weakness · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 10 in {zone:1456}, {npc:3044}, the priest trainer in the cave under {area:1640}, hands you a {spell:2652} letter for {npc:4606} in the {zone:1458}."] = "10级时，{zone:1456}的{area:1640}下方洞穴中的牧师训练师{npc:3044}会给你一封关于{spell:2652}的信，让你交给{zone:1458}的{npc:4606}。",
	-- {npc:3044} Miles Welsh · {spell:2652} Touch of Weakness
	["{npc:3044}: take his {spell:2652} letter"] = "{npc:3044}：收下他关于 {spell:2652} 的信",

	-- Step 5: Touch of Weakness: Aelthalyste
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {quest:5658} Touch of Weakness · {area:159} Brill
	["At 10, go to {npc:4606}, the priest trainer in the {zone:1458}'s {object:36070}: she gives {quest:5658} and takes it back at once. No letter needed. From {area:159}, follow the road south to the ruined city of Lordaeron; the {zone:1458}'s lifts are at the back of the throne room. {quest:5658} strikes the next melee attacker for Shadow damage and lowers its melee attack power for 2 minutes."] = "达到 10 级后，去找 {zone:1458} 的 {object:36070} 中的牧师训练师 {npc:4606}：她会给予 {quest:5658}，并立即接受交还。不需要信件。从 {area:159} 沿道路向南，前往洛丹伦废墟；{zone:1458} 的升降梯位于王座大厅后方。{quest:5658} 会对下一个近战攻击你的敌人造成暗影伤害，并降低其近战攻击强度，持续 2 分钟。",

	-- Step 6: Touch of Weakness: Tai'jin's letter
	-- {quest:5660} Touch of Weakness · {npc:3706} Tai'jin
	["{quest:5660}: {npc:3706}'s letter"] = "{quest:5660}：{npc:3706}的信",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}, a short walk from the {zone:1458}."] = "将信交给 {zone:1458} 的 {object:36070} 中的 {npc:4606}：从 {zone:1454} 城外塔楼出发的飞艇会停靠在 {zone:1420}，下船后走一小段路就能到 {zone:1458}。",

	-- Step 7: Touch of Weakness: Var'jun's letter
	-- {quest:5661} Touch of Weakness · {npc:11407} Var'jun
	["{quest:5661}: {npc:11407}'s letter"] = "{quest:5661}：{npc:11407}的信",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: travel to {zone:1454} and take the zeppelin to {zone:1420}."] = "将信交给{zone:1458}的{object:36070}里的{npc:4606}：先前往{zone:1454}，再乘飞艇去{zone:1420}。",

	-- Step 8: Touch of Weakness: Ur'kyo's letter
	-- {quest:5662} Touch of Weakness · {npc:6018} Ur'kyo
	["{quest:5662}: {npc:6018}'s letter"] = "{quest:5662}：{npc:6018}的信",
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["Hand the letter to {npc:4606} in the {zone:1458}'s {object:36070}: the zeppelin from the tower outside {zone:1454} lands in {zone:1420}."] = "将信交给 {zone:1458} 的 {object:36070} 中的 {npc:4606}：从 {zone:1454} 城外塔楼出发的飞艇会停靠在 {zone:1420}。",

	-- Step 9: Touch of Weakness: Miles Welsh's letter
	-- {quest:5663} Touch of Weakness · {npc:3044} Miles Welsh
	["{quest:5663}: {npc:3044}'s letter"] = "{quest:5663}：{npc:3044}的信",

	-- Step 10: Dark Sacrifice: Ur'kyo
	-- {zone:1454} Orgrimmar · {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1454}, {npc:6018} in the {object:172961} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "20级时，{zone:1454} 的 {object:172961} 内的 {npc:6018} 会给你一封 {quest:5644} 的信，要交给 {zone:1458} 的 {npc:4606}。",
	-- {npc:6018} Ur'kyo · {quest:5644} Dark Sacrifice
	["{npc:6018}: take his {quest:5644} letter"] = "{npc:6018}：领取他的{quest:5644}信件",

	-- Step 11: Dark Sacrifice: Miles Welsh
	-- {zone:1456} Thunder Bluff · {npc:3044} Miles Welsh · {area:1640} Spirit Rise · {quest:5644} Dark Sacrifice · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["At 20 in {zone:1456}, {npc:3044} in the cave under {area:1640} hands you a {quest:5644} letter for {npc:4606} in the {zone:1458}."] = "20级时，{zone:1456}的{area:1640}下方洞穴中的{npc:3044}会给你一封{quest:5644}的信，让你交给{zone:1458}的{npc:4606}。",
	-- {npc:3044} Miles Welsh · {quest:5644} Dark Sacrifice
	["{npc:3044}: take his {quest:5644} letter"] = "{npc:3044}：领取他的{quest:5644}信件",

	-- Step 12: Dark Sacrifice: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter · {quest:5644} Dark Sacrifice · {spell:2944} Devouring Plague
	["At 20, {npc:4606} in the {object:36070} teaches {quest:5644} with a quest she gives and takes back at once (its text still speaks of {spell:2944}, which every priest now learns from the trainer)."] = "20级时，{object:36070} 的 {npc:4606} 会通过一个接到后立即交还的任务教你 {quest:5644}（任务文本仍提到 {spell:2944}，不过如今所有牧师都能向训练师学习这个法术）。",

	-- Step 13: Dark Sacrifice: Ur'kyo's letter
	-- {quest:5646} Dark Sacrifice · {npc:6018} Ur'kyo
	["{quest:5646}: {npc:6018}'s letter"] = "{quest:5646}：{npc:6018}的信",

	-- Step 14: Dark Sacrifice: Miles Welsh's letter
	-- {quest:5644} Dark Sacrifice · {npc:3044} Miles Welsh
	["{quest:5644}: {npc:3044}'s letter"] = "{quest:5644}：{npc:3044}的信",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "10级时，去{zone:1458}的{object:36070}找{npc:4606}。其他地方的牧师训练师（{zone:1454}的{npc:6018}、{area:362}的{npc:3706}、{zone:1456}的{npc:3044}）会用同名任务让你去找她。",
	-- ["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "20级时，{npc:4606}教授{quest:5644}。{zone:1454}的{npc:6018}和{zone:1456}的{npc:3044}会用同名任务让你去找她。",
	-- ["At 20, {npc:4606} teaches {spell:1277324}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "20级时，{npc:4606}教授{spell:1277324}。{zone:1454}的{npc:6018}和{zone:1456}的{npc:3044}会用同名任务让你去找她。",
	-- ["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "亡灵牧师的法术：10级的{spell:2652}，20级的{quest:5644}。",
	-- ["The Undead priest spells: {spell:2652} at 10, {spell:1277324} at 20."] = "亡灵牧师的法术：10级的{spell:2652}，20级的{spell:1277324}。",
	-- ["{spell:2652} and {quest:5644}"] = "{spell:2652}与{quest:5644}",
	-- ["{spell:2652} and {spell:1277324}"] = "{spell:2652}与{spell:1277324}",
}
