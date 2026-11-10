-- Chinese (simplified) (zhCN): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608}与咒逐",
	-- {spell:23101} Eye of Divinity · {area:2717} Molten Core · {npc:14494} Eris Havenfire
	["The epic priest staff: the {spell:23101} from {area:2717}, {npc:14494}'s peasant rescue, then the Eye of Shadow."] = "史诗牧师法杖：来自{area:2717}的{spell:23101}，{npc:14494}的农民救援，然后是暗影之眼。",

	-- Step 1: The Eye of Divinity
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {area:1584} Blackrock Depths · {item:18412} Core Fragment · {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {npc:14494} Eris Havenfire
	["{item:18646} comes from the {object:179703}, the chest that appears when {npc:12018} yields in {area:2717}, a 40-player raid (it is in the cache about half the time). {area:2717}'s portal is at the bottom of {area:1584}; once you have done Attunement to the Core (a {item:18412} from beside that portal), {npc:14387} inside {area:254} ports you straight in. Nothing in this chain starts without the Eye: {npc:14494} is invisible until you equip it."] = "{item:18646}来自{object:179703}，这是在40人团队副本{area:2717}中，{npc:12018}投降后出现的箱子（约一半概率开出该物品）。{area:2717}的传送门位于{area:1584}最深处；完成“熔火之心的传送门”（从该传送门旁取得{item:18412}）后，{area:254}内的{npc:14387}可将你直接传送进去。没有眼睛就无法开始这条任务链：装备后才能看见{npc:14494}。",
	-- {npc:14387} Lothos Riftwaker · {area:2717} Molten Core
	["{npc:14387}: the way into {area:2717} once attuned"] = "{npc:14387}：完成入场资格任务后，由此进入{area:2717}",
	-- {item:18646} The Eye of Divinity · {area:2717} Molten Core · {area:254} Blackrock Mountain
	["{item:18646}: {area:2717}, through {area:254}"] = "{item:18646}：经由 {area:254} 前往 {area:2717}",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {quest:7621} A Warning · {quest:7622} The Balance of Light and Shadow · {item:13931} Nightfin Soup · {item:8956} Oil of Immolation · {item:13180} Stratholme Holy Water
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion · Dark Runes = {item:20520} Dark Rune
	["Equip {item:18646}, then find {npc:14494}, a ghost on the hillside in the north-west of the {zone:1423}, west of {area:2279}'s gate (if she does not show, take the Eye off and put it back on). {quest:7621} is only talk; {quest:7622} starts the moment you accept it, so prepare first: full mana, Major Mana Potions, Demonic or Dark Runes, mana food or {item:13931}, and a stack of {item:8956} or {item:13180} for the skeletons."] = "装备 {item:18646}，然后寻找 {npc:14494}，她是位于 {zone:1423} 西北部山坡上的幽灵，在 {area:2279} 大门西边（如果看不见她，先卸下眼睛再重新装备）。{quest:7621} 只需交谈；{quest:7622} 则在接受的瞬间开始，所以先做好准备：回满法力，准备特效法力药水、恶魔符文或黑暗符文、回蓝食物或 {item:13931}，以及一组 {item:8956} 或 {item:13180} 来对付骷髅。",

	-- Step 3: The Balance of Light and Shadow
	-- {object:179694} Death Post (no name in this language: may be words) · {npc:14494} Eris Havenfire · {spell:552} Abolish Disease · {spell:139} Renew · {spell:2061} Flash Heal · {spell:15237} Holy Nova
	["Save 50 peasants before 15 die (the {object:179694} by the path counts the dead). They walk from the cave towards {npc:14494} in waves, catch diseases and draw skeletons and skeleton archers. Cure the purple-glowing diseases first ({spell:552}), keep {spell:139} on the hurt ones, {spell:2061} the nearly dead, and kill skeletons as they spawn: one {spell:15237} of rank 3 or more kills them, oil takes two ticks while they hit you. Shield yourself at the start of each wave; friendly nameplates make the hurt peasants easy to pick out. Friends may buff you before you accept and may heal or cure peasants, but they must not heal or buff you, attack a skeleton or bring a pet once it starts, or a demon appears and kills everyone. Fail, and {npc:14494} is gone for a while (players report anything from 15 minutes to two hours); talk to her again when she is back."] = "在15名农民死亡前救下50名（路边的{object:179694}会统计死亡人数）。他们分批从洞穴走向{npc:14494}，途中会染病，并引来骷髅和骷髅弓箭手。优先驱除泛紫光的疾病（{spell:552}），给受伤者保持{spell:139}，对濒死者施放{spell:2061}，并在骷髅出现时立即击杀：3级及以上的{spell:15237}一次就能杀死它们，用油则要跳两次伤害，这期间它们仍会攻击你。每波开始时给自己套盾；开启友方姓名板便于找出受伤的农民。朋友可以在你接受任务前给你增益，也能治疗农民或驱除他们的疾病；但事件开始后，不能治疗你、给你增益、攻击骷髅或带宠物来，否则会出现一个恶魔杀死所有人。失败后，{npc:14494}会消失一段时间（玩家报告的时间从15分钟到2小时不等）；她回来后再与她交谈。",

	-- Step 5: The Eye of Shadow
	-- {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak · {zone:1419} Blasted Lands
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["The splinter needs {item:18665} as well. {npc:12397}, a world boss in the {zone:1419} (a raid), always drops it; Manahounds and Doomguard Commanders there drop it rarely (about 3% and 2%), the Hederine of Winterspring hardly ever. It can be traded: check the Auction House first."] = "合成碎片还需要{item:18665}。{zone:1419}的世界首领{npc:12397}（需团队应对）必定掉落；当地的法力犬和末日守卫指挥官也有小概率掉落（约3%和2%），冬泉谷的赫达琳恶魔则极少掉落。该物品可以交易：先看看拍卖行。",

	-- Step 6: Benediction
	-- {item:18659} Splinter of Nordrassil · {item:18646} The Eye of Divinity · {item:18665} The Eye of Shadow · {item:18608} Benediction
	["With the {item:18659}, {item:18646} and {item:18665} in your bags, use the splinter wherever you are: it becomes {item:18608}. Use {item:18608} to turn it into Anathema, the shadow staff, and back (a 30-minute cooldown)."] = "背包里带着 {item:18659}、{item:18646} 和 {item:18665} 时，无论身在何处，使用碎片即可将其制成 {item:18608}。使用 {item:18608} 可将它转为暗影法杖咒逐，也能再转回来（冷却 30 分钟）。",
	-- {item:18659} Splinter of Nordrassil · {item:18608} Benediction
	["Use the {item:18659} with both Eyes in your bags: {item:18608}"] = "确保两只眼睛都在背包中，再使用 {item:18659}：获得 {item:18608}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "装备{item:18646}后才能看到{npc:14494}，一个位于{zone:1423}西北山坡上的鬼魂。带满法力、{item:13444}和{item:8956}前来：如果失败，事件大约要两小时才会重新出现。",
	-- ["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "在15个农民死亡之前救下50个。杀掉攻击他们的骷髅，治愈他们的疾病（先治紫色的），并用{spell:139}治疗伤者。朋友可以事先给你加增益，但必须远离战斗，否则会出现一个恶魔杀死所有人。",
	-- ["With both Eyes in your bags: {item:18608}"] = "两只眼睛都在背包里时：{item:18608}",
	-- ["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "你需要先拿到{item:18646}：它来自{area:2717}中{npc:12018}之后的{object:179703}。{item:18665}由精英恶魔掉落（世界首领{npc:12397}必掉；{npc:12396}和法力犬偶尔掉落）；它是装备后绑定，所以也可以买一个。",
	-- ["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "{npc:14494}的碎片和两只眼睛可以合成{item:18608}，这把史诗牧师法杖可以变成咒逐。",
}
