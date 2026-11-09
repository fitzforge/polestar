-- Chinese (simplified) (zhCN): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "五十多级的稀有副手，来自{zone:1448}{npc:14469}和{npc:14470}，这个营地还提供小鬼的请求任务。",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls
	-- plural, as words: Flawless Fel Essences = {quest:7602} Flawless Fel Essence
	["At 50 {npc:14469} and his imp {npc:14470} wait on a rise in central {zone:1448} just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. {npc:14469} sends you to {npc:14470}, beside him, who wants three Flawless Fel Essences from three places."] = "达到 50 级后，{npc:14469} 和他的小鬼 {npc:14470} 会在 {zone:1448} 中部、{area:1997} 东北不远处的高地等你：从 {area:1765} 的桥向北走，经过几只软泥怪后，他们就在道路东侧。{npc:14469} 会让你去找身旁的 {npc:14470}，后者需要分别来自三处地点的三份无暇的恶魔精华。",

	-- Step 2: Jaedenar
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {area:1770} Shadow Hold · {npc:9516} Lord Banehollow
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["{area:1763} lies just south of {area:1997}, west of the road. Of its two caves, {area:1770} is the northern one, further up the hill; the other has no Legionnaires. {area:1770}'s tunnels run north under the hills, and the Jaedenar Legionnaires (level 55) stand in its deeper halls, from the first ramps on toward {npc:9516}'s chamber; they Uppercut anyone in melee. Three kills in four give the essence, but only about eleven spawn: clear your way in and wait out a five-minute respawn if you must. The cultists of {area:1763} and {area:1770} are all hostile."] = "{area:1763}就在{area:1997}南面、道路西侧。两座洞穴中，{area:1770}是更靠北、位置更高的那座；另一座没有军团士兵。{area:1770}的隧道向北延伸到山丘下，加德纳尔军团士兵（55级）位于更深处的大厅，从第一段斜坡一直分布到{npc:9516}的房间；它们会对近战范围内的目标使用上勾拳。精华掉落概率为四分之三，但总共只有约11个刷新点：一路清进去，必要时等5分钟刷新。{area:1763}和{area:1770}的教徒全部敌对。",

	-- Step 3: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs (level 51-53) hold the Legash Encampment on {zone:1447}'s northern coast. Every kind drops the essence three times in four; the satyrs burn mana and the Hellcallers rain fire, so pull them singly."] = "雷加什萨特（51-53 级）占据 {zone:1447} 北部海岸的雷加什营地。各类萨特的精华掉率都是约四分之三；萨特会燃烧法力，唤魔者会施放火焰之雨，因此要逐个引来击杀。",

	-- Step 4: The Dark Portal
	-- {area:72} The Dark Portal · {zone:1419} Blasted Lands
	["The Felguard Sentries (level 54) walk around the {area:72} in the south of the {zone:1419}, each with a felhunter. Leave the level 57 Servants of Razelikh alone: they cannot be killed without their own quest."] = "地狱卫士哨兵（54 级）在 {zone:1419} 南部的 {area:72} 周围巡逻，每名都带着一只地狱猎犬。不要招惹 57 级的拉瑟莱克的仆从：没有它们对应的任务就无法杀死。",

	-- Step 5: Impsy
	-- {npc:14470} Impsy · {item:18626} Fel Fire · {npc:14467} Kroshius
	["Back to {npc:14470}. He hands you the {item:18626}: keep it, it wakes the infernal {npc:14467}."] = "返回{npc:14470}身边。他会给你{item:18626}：保留它，用来唤醒地狱火{npc:14467}。",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {area:1766} Shatter Scar Vale · {npc:14469} Niby the Almighty · {item:18626} Fel Fire · {npc:14470} Impsy
	["{npc:14467}' remains lie in {area:1766}, the burnt crater north of {npc:14469}: follow the road north from his camp; the remains lie a little east of it. Use the {item:18626} beside them and wait for him to rise. {npc:14467} is elite (level 55): grouping up is encouraged; a warlock of 55 or more can solo him with Fear and damage over time, or with Enslave Demon, but fire spells do nothing to him and he knocks you back. If you die he heals to full; he rises again three minutes after he dies. An elite infernal patrols the pool south of the remains: pull {npc:14467} away from it. He always drops his core. Lost the {item:18626}? Abandon the quest and take it again from {npc:14470}."] = "{npc:14467} 的遗骸位于 {npc:14469} 北面的焦黑陨坑 {area:1766}：从他的营地沿道路北上，遗骸就在道路稍东侧。在遗骸旁使用 {item:18626}，等待他起身。{npc:14467} 是55级精英：建议组队；55级及以上的术士可以用恐惧配合持续伤害，或用奴役恶魔单独击败他，但火焰法术对他无效，而且他会击退你。如果你死亡，他会回满生命；他死后三分钟会再次出现。遗骸南面的水池附近有精英地狱火巡逻：把 {npc:14467} 拉远再打。他必定掉落核心。弄丢了 {item:18626}？放弃任务，再向 {npc:14470} 重新接受。",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}，在{object:179677}",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "回到{npc:14469}那里",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "50级时，{npc:14469}和他的小鬼{npc:14470}在{zone:1448}中部、{area:1763}东边不远处等候。",
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "{zone:1419}南部{area:72}周围的地狱卫士斥候身上带着它的精华。",
	-- ["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "{npc:14469}西边不远处的{npc:9862}身上带着{area:1763}的精华。",
	-- ["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "{zone:1447}北部的雷加斯萨特身上带着{zone:1447}的精华。",
	-- ["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "{npc:14467}的遗骸位于{npc:14469}北边的{area:1766}。在遗骸旁使用{item:18626}，地狱火苏醒后杀死它。{npc:14467}是精英：建议组队。",
}
