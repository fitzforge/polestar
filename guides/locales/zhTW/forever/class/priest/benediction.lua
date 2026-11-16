-- Chinese (traditional) (zhTW): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608}與咒逐",
	-- {spell:23101} Eye of Divinity · {area:2717} Molten Core · {npc:14494} Eris Havenfire
	["The epic priest staff: the {spell:23101} from {area:2717}, {npc:14494}'s peasant rescue, then the Eye of Shadow."] = "史詩牧師法杖：來自{area:2717}的{spell:23101}、{npc:14494}的農民救援，然後是暗影之眼。",

	-- Step 1: The Eye of Divinity
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {area:1584} Blackrock Depths · {item:18412} Core Fragment · {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {npc:14494} Eris Havenfire
	["{item:18646} comes from the {object:179703}, the chest that appears when {npc:12018} yields in {area:2717}, a 40-player raid (it is in the cache about half the time). {area:2717}'s portal is at the bottom of {area:1584}; once you have done Attunement to the Core (a {item:18412} from beside that portal), {npc:14387} inside {area:254} ports you straight in. Nothing in this chain starts without the Eye: {npc:14494} is invisible until you equip it."] = "{item:18646}來自{object:179703}，即{area:2717}（40人團隊副本）中{npc:12018}倒下後出現的寶箱（約一半機率開出）。{area:2717}的傳送門在{area:1584}底部；完成“熔火之心的傳送門”任務後（{item:18412}就在傳送門旁），{area:254}裡的{npc:14387}可以直接把你傳送進去。沒有暗影之眼，這條任務鏈的任何一環都無法開始：未裝備它時你看不到{npc:14494}。",
	-- {npc:14387} Lothos Riftwaker · {area:2717} Molten Core
	["{npc:14387}: the way into {area:2717} once attuned"] = "{npc:14387}：完成開門任務後進入{area:2717}的途徑",
	-- {item:18646} The Eye of Divinity · {area:2717} Molten Core · {area:254} Blackrock Mountain
	["{item:18646}: {area:2717}, through {area:254}"] = "{item:18646}：{area:2717}，經由{area:254}",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {quest:7621} A Warning · {quest:7622} The Balance of Light and Shadow · {item:13931} Nightfin Soup · {item:8956} Oil of Immolation · {item:13180} Stratholme Holy Water
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion · Dark Runes = {item:20520} Dark Rune
	["Equip {item:18646}, then find {npc:14494}, a ghost on the hillside in the north-west of the {zone:1423}, west of {area:2279}'s gate (if she does not show, take the Eye off and put it back on). {quest:7621} is only talk; {quest:7622} starts the moment you accept it, so prepare first: full mana, Major Mana Potions, Demonic or Dark Runes, mana food or {item:13931}, and a stack of {item:8956} or {item:13180} for the skeletons."] = "裝備{item:18646}，然後找到{npc:14494}，她是{zone:1423}西北山坡上的幽靈，在{area:2279}大門以西（如果她不出現，取下暗影之眼再重新戴上）。{quest:7621}只是對話；{quest:7622}一接就立即開始，所以先做好準備：滿法力、強效法力藥水、惡魔符文或黑暗符文、法力食物或{item:13931}，以及一組用於對付骷髏的{item:8956}或{item:13180}。",

	-- Step 3: The Balance of Light and Shadow
	-- {object:179694} Death Post · {npc:14494} Eris Havenfire · {spell:552} Abolish Disease · {spell:139} Renew · {spell:2061} Flash Heal · {spell:15237} Holy Nova
	["Save 50 peasants before 15 die (the {object:179694} by the path counts the dead). They walk from the cave towards {npc:14494} in waves, catch diseases and draw skeletons and skeleton archers. Cure the purple-glowing diseases first ({spell:552}), keep {spell:139} on the hurt ones, {spell:2061} the nearly dead, and kill skeletons as they spawn: one {spell:15237} of rank 3 or more kills them, oil takes two ticks while they hit you. Shield yourself at the start of each wave; friendly nameplates make the hurt peasants easy to pick out. Friends may buff you before you accept and may heal or cure peasants, but they must not heal or buff you, attack a skeleton or bring a pet once it starts, or a demon appears and kills everyone. Fail, and {npc:14494} is gone for a while (players report anything from 15 minutes to two hours); talk to her again when she is back."] = "在15個農民死亡前救下50個（路邊的{object:179694}會統計死者）。他們從洞穴一波波走向{npc:14494}，會感染疾病並召來骷髏和骷髏弓箭手。優先驅散發出紫光的疾病（{spell:552}），給受傷的農民保持{spell:139}，用{spell:2061}救快死的，骷髏一出現就殺掉：3級或更高的{spell:15237}一發就能殺掉它們，而聖油在它們打你時要跳兩下。每波開始時給自己套盾；開啟友方姓名板能更容易找出受傷的農民。朋友可以在你接任務前給你加增益，也可以治療或驅散農民，但戰鬥開始後不能治療或增益你、不能攻擊骷髏、不能帶寵物，否則會出現惡魔並殺死所有人。失敗的話，{npc:14494}會消失一段時間（玩家報告從15分鐘到兩小時不等）；等她回來後再去找她交談。",
	-- {npc:14494} Eris Havenfire
	["beside {npc:14494}, where the peasants walk to"] = "在{npc:14494}旁邊，也就是農民走去的地方",

	-- Step 5: The Eye of Shadow
	-- {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak · {zone:1419} Blasted Lands
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["The splinter needs {item:18665} as well. {npc:12397}, a world boss in the {zone:1419} (a raid), always drops it; Manahounds and Doomguard Commanders there drop it rarely (about 3% and 2%), the Hederine of Winterspring hardly ever. It can be traded: check the Auction House first."] = "碎塊還需要{item:18665}。{npc:12397}是{zone:1419}的世界首領（團隊副本），必定掉落；那裡的法力犬和末日守衛指揮官很少掉落（約3%和2%），冬泉谷的赫達林幾乎不掉。它可以交易：先去拍賣行看看。",

	-- Step 6: Benediction
	-- {item:18659} Splinter of Nordrassil · {item:18646} The Eye of Divinity · {item:18665} The Eye of Shadow · {item:18608} Benediction
	["With the {item:18659}, {item:18646} and {item:18665} in your bags, use the splinter wherever you are: it becomes {item:18608}. Use {item:18608} to turn it into Anathema, the shadow staff, and back (a 30-minute cooldown)."] = "揹包裡帶著{item:18659}、{item:18646}和{item:18665}時，在任何地方使用碎塊：它會變成{item:18608}。使用{item:18608}可將其變為暗影法杖咒逐，也能變回來（30分鐘冷卻）。",
	-- {item:18659} Splinter of Nordrassil · {item:18608} Benediction
	["Use the {item:18659} with both Eyes in your bags: {item:18608}"] = "兩顆眼睛都在背包裡時使用{item:18659}：{item:18608}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "裝備{item:18646}才能看見{npc:14494}，她是{zone:1423}西北部山坡上的一個鬼魂。帶著滿法力、極效法力藥水和{item:8956}前往：如果失敗，事件大約要兩小時才會重新出現。",
	-- ["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "在15個農民死亡之前救出50個。擊殺攻擊他們的骷髏，治癒他們的疾病（先治紫色的），並用{spell:139}治療傷者。朋友可以事先為你施加增益，但必須遠離戰鬥，否則會出現一個惡魔殺死所有人。",
	-- ["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "你需要先取得{item:18646}：它來自{area:2717}擊敗{npc:12018}後的{object:179703}。{item:18665}由精英惡魔掉落（世界首領{npc:12397}必定掉落；{npc:12396}和法力犬極少掉落）；它是裝備後綁定，所以也可以用買的。",
	-- ["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "{npc:14494}的碎片和兩顆眼睛可以製成{item:18608}，這把史詩牧師法杖可以轉變成咒逐。",
}
