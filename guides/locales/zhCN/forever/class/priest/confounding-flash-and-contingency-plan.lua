-- Chinese (simplified) (zhCN): the guide forever/class/priest/confounding-flash-and-contingency-plan (forever/class/priest/confounding-flash-and-contingency-plan.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["{quest:94817} and {quest:94818}"] = "{quest:94817}和{quest:94818}",
	-- {quest:94817} Confounding Flash · {quest:94818} Contingency Plan
	["The Gnome priest spells, new in Forever: {quest:94817} at 10, {quest:94818} at 20. Free, no objectives."] = "无限新增的侏儒牧师法术：10级学{quest:94817}，20级学{quest:94818}。免费，没有任务目标。",

	-- Step 1: Confounding Flash: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:94817} letter for {npc:258785} in {zone:1455}. {area:131} is on the road up to the city."] = "达到 10 级后，{area:131} 的 {area:2102} 内的牧师训练师 {npc:1226} 会给你一封 {quest:94817} 信件，让你交给 {zone:1455} 的 {npc:258785}。{area:131} 位于上山进城的道路旁。",
	-- {npc:1226} Maxan Anvol · {quest:94817} Confounding Flash
	["{npc:1226}: take his {quest:94817} letter"] = "{npc:1226}：领取他的{quest:94817}信件",

	-- Step 2: Confounding Flash: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:94817} letter for {npc:258785} in {zone:1455}."] = "在{zone:1429}达到10级时，{area:87}狮王之傲旅店楼上的{npc:377}会交给你一封{quest:94817}信件，让你送给{zone:1455}的{npc:258785}。",
	-- {npc:377} Priestess Josetta · {quest:94817} Confounding Flash
	["{npc:377}: take her {quest:94817} letter"] = "{npc:377}：领取她的{quest:94817}信件",

	-- Step 3: Confounding Flash: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:94817} Confounding Flash · {npc:258785} High Priestess Mims · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 10 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:94817} letter for {npc:258785} in {zone:1455} (the {area:2257} from the {object:28027})."] = "10级时，在 {zone:1453} 圣光大教堂祭坛旁的 {npc:376} 会给你一封 {quest:94817} 的信，要交给 {zone:1455} 的 {npc:258785}（从 {object:28027} 乘坐 {area:2257} 前往）。",
	-- {npc:376} High Priestess Laurena · {quest:94817} Confounding Flash
	["{npc:376}: take her {quest:94817} letter"] = "{npc:376}：领取她的{quest:94817}信件",

	-- Step 4: Confounding Flash: High Priestess Mims
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:11406} High Priest Rohan · {quest:94817} Confounding Flash
	["At 10, go to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362} (north-west of the city), right beside {npc:11406}: she gives {quest:94817} and takes it back at once. No letter needed. {quest:94817} confuses up to five enemies around you for 3 seconds (any damage wakes them) on a 2-minute cooldown: time to step back and heal, or to run."] = "10级时，前往 {zone:1455} 西北部 {object:32362} 内的 {object:32386}，找就在 {npc:11406} 身旁的 {npc:258785}：她会给予 {quest:94817}，并立即接受交还，不需要信。{quest:94817} 可使周围最多五个敌人迷惑3秒（受到任何伤害都会清醒），冷却时间2分钟：可趁机退后治疗，或逃跑。",

	-- Step 5: Confounding Flash: Maxan Anvol's letter
	-- {quest:94824} Confounding Flash · {npc:1226} Maxan Anvol
	["{quest:94824}: {npc:1226}'s letter"] = "{quest:94824}：{npc:1226}的信",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {quest:94824} Confounding Flash
	["Follow the road up from {area:131} into {zone:1455} and to the {object:32362}: {npc:258785} in the {object:32386} takes the letter and teaches {quest:94824}."] = "从 {area:131} 沿路上山进入 {zone:1455}，前往 {object:32362}：{object:32386} 内的 {npc:258785} 会收下信件，并教你 {quest:94824}。",

	-- Step 6: Confounding Flash: Josetta's letter
	-- {quest:94822} Confounding Flash
	["{quest:94822}: Josetta's letter"] = "{quest:94822}：女牧师洁塞塔的信",
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "将信交给{zone:1455}的{object:32362}内、{object:32386}中的{npc:258785}：从{zone:1453}的{object:28027}搭乘{area:2257}前往。",

	-- Step 7: Confounding Flash: Laurena's letter
	-- {quest:94821} Confounding Flash
	["{quest:94821}: Laurena's letter"] = "{quest:94821}：高阶牧师劳瑞娜的信",

	-- Step 8: Confounding Flash: a letter from another trainer
	-- {quest:94823} Confounding Flash
	["{quest:94823}: a letter from another trainer"] = "{quest:94823}：另一位训练师的来信",
	-- {quest:94823} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["Any {quest:94823} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "任何 {quest:94823} 信件都交给 {npc:258785}，他位于 {zone:1455} 的 {object:32362} 中的 {object:32386}。",

	-- Step 9: Confounding Flash: a letter from another trainer
	-- {quest:94825} Confounding Flash
	["{quest:94825}: a letter from another trainer"] = "{quest:94825}：另一位训练师的来信",
	-- {quest:94825} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["Any {quest:94825} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "任何 {quest:94825} 信件都交给 {npc:258785}，他位于 {zone:1455} 的 {object:32362} 中的 {object:32386}。",

	-- Step 10: Confounding Flash: a letter from another trainer
	-- {quest:94826} Confounding Flash
	["{quest:94826}: a letter from another trainer"] = "{quest:94826}：另一位训练师的来信",
	-- {quest:94826} Confounding Flash · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["Any {quest:94826} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "任何 {quest:94826} 信件都交给 {npc:258785}，他位于 {zone:1455} 的 {object:32362} 中的 {object:32386}。",

	-- Step 11: Contingency Plan: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:94818} Contingency Plan · {npc:258785} High Priestess Mims · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:94818} letter for {npc:258785} in {zone:1455} (the {area:2257} from the {object:28027})."] = "达到 20 级后，在 {zone:1453} 圣光大教堂祭坛旁的 {npc:376} 会给你一封 {quest:94818} 信件，让你交给 {zone:1455} 的 {npc:258785}（从 {object:28027} 乘坐 {area:2257} 前往）。",
	-- {npc:376} High Priestess Laurena · {quest:94818} Contingency Plan
	["{npc:376}: take her {quest:94818} letter"] = "{npc:376}：领取她的{quest:94818}信件",

	-- Step 12: Contingency Plan: High Priestess Mims
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {quest:94818} Contingency Plan · {spell:139} Renew · {spell:17} Power Word: Shield
	["At 20, {npc:258785} in the {object:32386} teaches {quest:94818} with a quest she gives and takes back at once. {quest:94818} wards a friend for 30 seconds: if they drop below 35% health, they get a shield and a heal over time at once (it stacks with {spell:139} and {spell:17}). 5-minute cooldown."] = "20级时，{object:32386} 内的 {npc:258785} 会给予一个可立即交还的任务，教你 {quest:94818}。{quest:94818} 可守护一位友方目标30秒：如果其生命值降到35%以下，就会立即获得护盾和持续治疗效果（可与 {spell:139} 和 {spell:17} 叠加）。冷却时间5分钟。",

	-- Step 13: Contingency Plan: Laurena's letter
	-- {quest:94819} Contingency Plan
	["{quest:94819}: Laurena's letter"] = "{quest:94819}：高阶牧师劳瑞娜的信",
	-- {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand Laurena's letter to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "将高阶牧师劳瑞娜的信交给{npc:258785}，她在{zone:1455}的{object:32362}内的{object:32386}：从{zone:1453}的{object:28027}乘坐{area:2257}前往。",

	-- Step 14: Contingency Plan: a letter from another trainer
	-- {quest:94820} Contingency Plan
	["{quest:94820}: a letter from another trainer"] = "{quest:94820}：另一位训练师的来信",
	-- {quest:94820} Contingency Plan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["Any {quest:94820} letter goes to {npc:258785} in the {object:32386}, {zone:1455}'s {object:32362}."] = "任何 {quest:94820} 信件都交给 {npc:258785}，他位于 {zone:1455} 的 {object:32362} 中的 {object:32386}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:258785} in the {object:32386}, in {zone:1455}'s {object:32362}. {npc:1226} in {area:131}, {npc:377} in {area:87} and {npc:376} in {zone:1453} send you to her with a quest of the same name (its text may say {zone:1453}: Mims is in {zone:1455})."] = "10级时，去{zone:1455}{object:32362}的{object:32386}找{npc:258785}。{area:131}的{npc:1226}、{area:87}的{npc:377}和{zone:1453}的{npc:376}会用同名任务把你派去找她（任务文本可能写的是{zone:1453}：米姆斯在{zone:1455}）。",
	-- ["At 20, {npc:258785} teaches {quest:94818}. {npc:376} in {zone:1453} sends you to her with a quest of the same name."] = "20级时，{npc:258785}传授{quest:94818}。{zone:1453}的{npc:376}会用同名任务把你派去找她。",
	-- ["The Gnome priest spells, new in Forever: one at 10, one at 20."] = "Forever新增的侏儒牧师法术：一个在10级，一个在20级。",
}
