-- Chinese (simplified) (zhCN): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773}与{spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10 (new in Forever), {spell:13896} at 20. Free, no objectives."] = "人类牧师的法术：10级的{quest:94773}（无限新增），20级的{spell:13896}。免费，无目标。",

	-- Step 1: Divine Grace: Priestess Josetta
	-- {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a letter for {npc:376}. {area:87} is on the road north to {zone:1453}, so it costs no detour."] = "10级时，{area:87}狮王之傲旅店楼上的{npc:377}会交给你一封送给{npc:376}的信。北上{zone:1453}的路会经过{area:87}，无需绕路。",
	-- {npc:377} Priestess Josetta · {quest:94773} Divine Grace
	["{npc:377}: take her {quest:94773} letter"] = "{npc:377}：领取她的{quest:94773}信件",

	-- Step 2: Divine Grace: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["A Human priest in {zone:1438} at 10: {npc:3600}, in the building at the north edge of {area:186}, hands you a letter for {npc:376} in {zone:1453}."] = "在{zone:1438}的人类牧师到10级时：{area:186}北缘建筑内的{npc:3600}会给你一封信，让你交给{zone:1453}的{npc:376}。",
	-- {npc:3600} Laurna Morninglight · {quest:94773} Divine Grace
	["{npc:3600}: take her {quest:94773} letter"] = "{npc:3600}：领取她的{quest:94773}信件",

	-- Step 3: Divine Grace: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {object:2098} Cathedral Square · {quest:94773} Divine Grace · {spell:6788} Weakened Soul
	["At 10, go to {npc:376} at the altar of the Cathedral of Light, in {zone:1453}'s {object:2098}, and take her quest: she teaches {quest:94773} on the spot. No letter needed; one from another trainer works too (next steps). {quest:94773} instantly heals a friend below half health and clears {spell:6788}, so you can shield them again (5-minute cooldown); it does not work on yourself. Human priests do not get Desperate Prayer in Forever: this is their spell instead."] = "10 级时，前往 {zone:1453} 的 {object:2098}，在圣光大教堂祭坛旁找 {npc:376} 接任务：她会当场教你 {quest:94773}。不需要介绍信；其他训练师给的信也可以（见后续步骤）。{quest:94773} 能立即治疗一名生命值低于一半的友方，并清除 {spell:6788}，让你可以再次给其套盾（冷却 5 分钟）；不能对自己使用。无限的人类牧师没有绝望祷言，改为使用这个法术。",

	-- Step 4: Divine Grace: Josetta's letter
	-- {quest:94774} Divine Grace
	["{quest:94774}: Josetta's letter"] = "{quest:94774}：女牧师洁塞塔的信",
	-- {npc:376} High Priestess Laurena · {quest:94774} Divine Grace
	["Hand Josetta's letter to {npc:376} at the altar of the Cathedral of Light: she teaches {quest:94774}."] = "将女牧师洁塞塔的信交给光明大教堂祭坛旁的{npc:376}：她会教你{quest:94774}。",

	-- Step 5: Divine Grace: Laurna Morninglight's letter
	-- {quest:94775} Divine Grace · {npc:3600} Laurna Morninglight
	["{quest:94775}: {npc:3600}'s letter"] = "{quest:94775}：{npc:3600}的信",
	-- {npc:3600} Laurna Morninglight · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {quest:94775} Divine Grace
	["Hand {npc:3600}'s letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1438}: the boat from {area:702} to {area:442}, then the boat to {area:17203}): she teaches {quest:94775}."] = "把 {npc:3600} 的信交给 {zone:1453} 圣光大教堂祭坛旁的 {npc:376}（从 {zone:1438} 出发：先从 {area:702} 乘船到 {area:442}，再乘船前往 {area:17203}）：她会教你 {quest:94775}。",

	-- Step 6: Divine Grace: a letter from another trainer
	-- {quest:94776} Divine Grace
	["{quest:94776}: a letter from another trainer"] = "{quest:94776}：另一位训练师的来信",
	-- {quest:94776} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94776} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "任何 {quest:94776} 的信件都要交给圣光大教堂祭坛旁的 {npc:376}。",

	-- Step 7: Divine Grace: a letter from another trainer
	-- {quest:94777} Divine Grace
	["{quest:94777}: a letter from another trainer"] = "{quest:94777}：另一位训练师的来信",
	-- {quest:94777} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94777} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "任何 {quest:94777} 的信件都要交给圣光大教堂祭坛旁的 {npc:376}。",

	-- Step 8: Divine Grace: a letter from another trainer
	-- {quest:94778} Divine Grace
	["{quest:94778}: a letter from another trainer"] = "{quest:94778}：另一位训练师的来信",
	-- {quest:94778} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94778} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "任何 {quest:94778} 的信件都要交给圣光大教堂祭坛旁的 {npc:376}。",

	-- Step 9: Divine Grace: a letter from another trainer
	-- {quest:94779} Divine Grace
	["{quest:94779}: a letter from another trainer"] = "{quest:94779}：另一位训练师的来信",
	-- {quest:94779} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94779} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "任何 {quest:94779} 的信件都要交给圣光大教堂祭坛旁的 {npc:376}。",

	-- Step 10: Feedback: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you a letter for {npc:376} in {zone:1453}. The {area:2257} from {object:171524} takes you there."] = "在{zone:1455}达到20级时，{object:32386}（{object:32362}）里的{npc:11406}会交给你一封送给{zone:1453}的{npc:376}的信。从{object:171524}乘坐{area:2257}即可前往。",
	-- {npc:11406} High Priest Rohan · {quest:5676} Arcane Feedback
	["{npc:11406}: take his {quest:5676} letter"] = "{npc:11406}：领取他的{quest:5676}信件",

	-- Step 11: Feedback: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a letter for {npc:376} in {zone:1453}."] = "在{zone:1457}达到20级时，月神殿上层阳台、{npc:7999}旁的{npc:11401}会交给你一封送给{zone:1453}的{npc:376}的信。",
	-- {npc:11401} Priestess Alathea · {quest:5676} Arcane Feedback
	["{npc:11401}: take her {quest:5676} letter"] = "{npc:11401}：领取她的{quest:5676}信件",

	-- Step 12: Feedback: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback
	["At 20, {npc:376} at the altar of the Cathedral of Light teaches {spell:13896} with a quest she gives and takes back at once."] = "20级时，光明大教堂祭坛旁的{npc:376}会通过一个当场接受并立即交还的任务，教你{spell:13896}。",

	-- Step 13: Feedback: Rohan's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Rohan's letter"] = "{spell:13896}：杀手洛汗的信",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1455} Ironforge · {spell:13896} Feedback
	["Hand Rohan's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (the {area:2257} from {object:171524} in {zone:1455}): she teaches {spell:13896}."] = "把洛汉的信交给 {zone:1453} 圣光大教堂祭坛旁的 {npc:376}（从 {zone:1455} 的 {object:171524} 进入 {area:2257} 前往）：她会教你 {spell:13896}。",

	-- Step 14: Feedback: Alathea's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Alathea's letter"] = "{spell:13896}：女祭司阿兰希雅的信",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {spell:13896} Feedback
	["Hand Alathea's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1457}: the portal down to {area:702}, the boat to {area:442}, then the boat to {area:17203}): she teaches {spell:13896}."] = "把女祭司阿兰希雅的信交给 {zone:1453} 圣光大教堂祭坛旁的 {npc:376}（从 {zone:1457} 出发：通过传送门下到 {area:702}，坐船到 {area:442}，再坐船到 {area:17203}）：她会教你 {spell:13896}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "10级时，去光明大教堂找{npc:376}。{area:87}的{npc:377}会用同名任务让你去找她。",
	-- ["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "20级时，{npc:376}教授{spell:13896}。{zone:1455}的{npc:11406}和{zone:1457}的{npc:11401}会用同名任务让你去找她。",
	-- ["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "人类牧师的法术：10级的{quest:94773}，20级的{spell:13896}。",
}
