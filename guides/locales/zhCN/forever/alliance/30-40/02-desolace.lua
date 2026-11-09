-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "沿道路向西经过{area:460}（部落），再向西南穿过{area:465}进入{zone:1443}；{area:608}在山口顶部。",
	-- {npc:5642} Vahlarriel Demonslayer · {area:599} Thunder Axe Fortress
	["{npc:5642}: the Burning Blade in {area:599}, where her search leads"] = "",

	-- Step 2: Malem chest
	["Malem chest"] = "玛雷姆的箱子",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "箱子在{area:608}西南方的废墟里。",

	-- Step 3: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue · Hatefury Tricksters = {npc:4671} Hatefury Trickster
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}.\nCareful: Hatefury Rogues spawn stealthed, and Hatefury Tricksters have a poison proc on their attacks."] = "怨怒萨特占据{area:608}以东的{area:603}废墟。\n注意：怨怒潜行者出现时就处于潜行状态，怨怒欺诈者的攻击有几率触发中毒。",

	-- Step 6: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "{npc:11863}的塔在{area:599}西边的山丘上：先接他的任务，他要的权杖在要塞里。",

	-- Step 7: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644}躲在{area:608}西南方燃烧之刃的要塞里。",
	["Inside"] = "在里面",

	-- Step 8: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643}和先知",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer · {npc:5642} Vahlarriel Demonslayer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building. {npc:5642} wants four of each kind of cultist on the way."] = "",
	-- {item:6767} Tyranis' Pendant
	["{item:6767}; inside"] = "{item:6767}：在屋内",
	-- {quest:5741} Sceptre of Light
	["{quest:5741}; on the top floor"] = "{quest:5741}，位于最顶层",

	-- Step 9: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "护送{npc:5644}",
	-- {npc:5644} Dalinda Malem
	["{npc:5644}, inside"] = "{npc:5644}：在屋内",
	["Out of Thunder Axe Fortress"] = "离开雷斧堡垒",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "带{npc:5644}离开要塞；离开要塞后她会自行离去。指南结尾在{area:608}向{npc:5642}交任务。",

	-- Step 10: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "{npc:11596}的营地在{area:609}南边的路上，{area:596}旁。",

	-- Step 11: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo · Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 13: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "科卡尔半人马在{area:609}周围的平原上游荡；它们的耳朵交给{npc:5752}。",

	-- Step 15: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "{area:608}的飞行管理员",

	-- Step 16: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "乘船前往{area:17203}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Escort the caravan"] = "护送车队",
	-- ["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "从{area:415}向西南到{area:1276}，这是一条穿过山脉通往石爪山脉的隧道。",
	-- ["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "从{area:415}向西北骑进山丘：{quest:1738}是通往{area:413}的道路北边一棵发光的树。如果你接了{quest:65602}，{item:190309}在{area:413}北边树林中的一座房子里（26.6,22.0）。然后经过{area:415}返回{area:1276}。",
	-- ["From {zone:1455}'s {npc:1573}"] = "从{zone:1455}的{npc:1573}处",
	-- ["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "她的哥哥{npc:5643}（36级）和火刃氏族的祭司（30-33级）在要塞里巡逻：单独把他拉出来。{npc:13019}把权杖放在要塞的主建筑里。",
	-- ["Scorpashi venom"] = "荒土蝎子毒液",
	-- ["Take the boat to {area:442} from Menethil's docks."] = "从米奈希尔港码头乘船前往{area:442}。",
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "从米奈希尔港码头乘船前往{area:442}。{npc:3649}在{area:442}飞行管理员北边。",
	-- ["The Gizelton Caravan waits at {area:2407}."] = "基泽尔顿车队在{area:2407}等候。",
	-- ["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "怨怒萨特占据着{area:608}东边的{area:603}废墟。",
	-- ["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "荒土蝎子在南边道路上的{area:2407}周围山丘上捕猎。",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "对一只{npc:4700}使用{npc:11596}的{item:13892}，然后带着驯服的科多兽走回他的营地，共五次；老迈的科多兽也会掉落皮，在墓地周围捕猎的荒土鞭笞者身上有毒液。",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "对一只{npc:4700}使用{npc:11596}的{item:13892}，然后带着驯服的科多兽走回他的营地，共五次；老迈的科多兽也会掉落皮。",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp. There, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "对一只 {npc:4700} 使用 {npc:11596} 的 {item:13892}，将驯服的科多兽带回他的营地。到达后与科多兽交谈，才会计入进度，并能驯服下一只。共需五只，一次一只；老迈的科多兽也会掉落皮，墓地周围捕猎的荒土鞭尾蝎会掉落毒液。",
	-- ["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "跟着车队向南经过{area:609}；途中科卡尔伏击者会袭击车队。一直跟在旁边，直到它停在{area:2617}。伏击者为34-35级，分批出现：低于33级就跳过。",
	-- ["{item:190309}, north of {area:413}"] = "{item:190309}，在{area:413}北边",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}：{item:279915}，来自米奈希尔港的Sylessa",
}
