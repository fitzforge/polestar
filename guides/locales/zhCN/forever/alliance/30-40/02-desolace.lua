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
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:5638}: the wreck's chest lies below {npc:11863}'s tower, on the way to {area:599}"] = "{npc:5638}：沉船的箱子在{npc:11863}的塔下方，位于前往{area:599}的路上",

	-- Step 2: Malem chest
	["Malem chest"] = "玛雷姆的箱子",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "箱子在{area:608}西南方的废墟里。",

	-- Step 3: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue · Hatefury Tricksters = {npc:4671} Hatefury Trickster
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}.\nCareful: Hatefury Rogues spawn stealthed, and Hatefury Tricksters have a poison proc on their attacks."] = "怨怒萨特占据{area:608}以东的{area:603}废墟。\n注意：怨怒潜行者出现时就处于潜行状态，怨怒欺诈者的攻击有几率触发中毒。",

	-- Step 5: Nijel's Point
	-- {npc:5642} Vahlarriel Demonslayer · {area:599} Thunder Axe Fortress
	["{npc:5642}: the Burning Blade in {area:599}, where her search leads"] = "{npc:5642}：追查线索将指向{area:599}的火刃",
	-- {npc:5752} Corporal Melkins
	["{npc:5752}: the Kolkar are at the end of this guide"] = "{npc:5752}：科卡尔半人马在本指南末尾",
	-- {npc:5396} Captain Pentigast · {npc:5752} Corporal Melkins
	["{npc:5396}, beside {npc:5752}"] = "{npc:5396}，在{npc:5752}旁边",

	-- Step 6: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "{npc:11863}的塔在{area:599}西边的山丘上：先接他的任务，他要的权杖在要塞里。",

	-- Step 7: Karnitol's Chest
	-- {npc:11863} Azore Aldamort · {object:177787} Rackmore's Log
	["The wrecked ship lies just south-west of {npc:11863}'s tower; its chest sits beside {object:177787}."] = "沉船就在{npc:11863}的塔西南方不远处；箱子在{object:177787}旁边。",
	-- {npc:5638} Kreldig Ungor
	["For {npc:5638}, at the end of this guide"] = "交给{npc:5638}，在本指南结尾",
	-- {object:177787} Rackmore's Log
	["{object:177787}, beside the chest: its two keys drop only while you have the quest"] = "{object:177787}，在箱子旁边：它的两把钥匙只有在你带着任务时才会掉落",

	-- Step 8: Rackmore's Silver Key
	-- {item:15878} Rackmore's Silver Key
	-- plural, as words: Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore: the Drysnap Crawlers and Pincers (33-35) on the beach and the clam beds around the wreck carry {item:15878}, about one in seven."] = "向西到海边：海滩上和沉船周围蚌床一带的枯钳龙虾人（33–35）带着{item:15878}，大约七只掉一把。",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878}，击杀干钳蟹获取",

	-- Step 9: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it. Work the Naga, Sorceresses and Warriors (32-34) of the strand's southern half until it drops.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), and Tidehunters (36-37) swim off the northern tip: on the way to the chest, keep to the beach and swim straight across."] = "继续向北到{area:598}获取{item:15881}：任何滑刃纳迦都可能掉落。刷海岸南半段的纳迦、巫师和战士（32–34）直到掉落。\n注意：滑刃侍从（34–35）与滑刃海巫、滑刃神谕者（34–36，施法者）盘踞海滩北半段，滑刃潮汐猎手（36–37）在北端外海游弋：去箱子的一路上贴着海滩走，径直游过去。",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}，击杀滑刃纳迦获取",

	-- Step 10: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "从最北端游到{area:2406}：{object:177786}在岸边的{object:177673}旁。用两把钥匙打开它；别碰雕像。",

	-- Step 11: Dalinda Malem
	-- {npc:11863} Azore Aldamort · {npc:5644} Dalinda Malem
	["Back south-east past {npc:11863}'s tower to the Burning Blade's fortress: {npc:5644} hides inside it."] = "向东南返回，路过{npc:11863}的塔，前往火刃要塞：{npc:5644}藏在要塞里。",
	["Inside"] = "在里面",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643}和先知",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer · {npc:5642} Vahlarriel Demonslayer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building. {npc:5642} wants four of each kind of cultist on the way."] = "她的兄弟{npc:5643}（36级）和火刃信徒（30-33级）在要塞里巡逻：单独把他引出来。{npc:13019}在要塞的主建筑内，身上带着权杖。{npc:5642}要求沿途每种信徒各杀四名。",
	-- {item:6767} Tyranis' Pendant
	["{item:6767}; inside"] = "{item:6767}：在屋内",
	-- {quest:5741} Sceptre of Light
	["{quest:5741}; on the top floor"] = "{quest:5741}，位于最顶层",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "护送{npc:5644}",
	-- {npc:5644} Dalinda Malem
	["{npc:5644}, inside"] = "{npc:5644}：在屋内",
	["Out of Thunder Axe Fortress"] = "离开雷斧堡垒",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "带{npc:5644}离开要塞；离开要塞后她会自行离去。指南结尾在{area:608}向{npc:5642}交任务。",

	-- Step 14: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:2407} Kormek's Hut
	["Back west up the hill to {npc:11863}'s tower with the sceptre, then south along the road to {area:2407}."] = "带着权杖向西上山，回到{npc:11863}的塔，再沿路向南到{area:2407}。",
	-- {npc:11863} Azore Aldamort · {npc:12369} Lord Kragaru · {object:177673} Serpent Statue
	["{npc:11863}: {npc:12369} (38) rises at the {object:177673}, for the south loop at the end of 30-40 (06b): keep it"] = "{npc:11863}：{npc:12369}（38）会在{object:177673}处出现，留给 30–40 末尾的南部环线（06b）：保留此任务",

	-- Step 15: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut · {npc:11596} Smeed Scrabblescrew · {npc:11438} Bibbly F'utzbuckle · {object:176751} Kodo Bones · {area:596} Kodo Graveyard
	["{area:2407} stands by the road south of the fortress, on the way to {npc:11596}'s camp. {npc:11438} collects {object:176751}; they lie among the skeletons of the {area:596}, where {npc:11596}'s kodos are."] = "{area:2407}在要塞以南的路边、去{npc:11596}营地的路上。{npc:11438}在收集{object:176751}；它们散落在{area:596}的骸骨堆里，那里有{npc:11596}的科多兽。",

	-- Step 16: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "{npc:11596}的营地在{area:609}南边的路上，{area:596}旁。",

	-- Step 17: Kodo Bones
	-- {area:596} Kodo Graveyard · {npc:11438} Bibbly F'utzbuckle · {object:176751} Kodo Bones · {object:417353} Extinguished Campfire (no name in this language: may be words) · {quest:79229} Highway Robbery
	["West into the {area:596} first: {npc:11438}'s {object:176751} lie among the skeletons on its western side. Just north of them an {object:417353} starts {quest:79229}, also for {npc:11438}."] = "先向西进入{area:596}：{npc:11438}要的{object:176751}散落在西侧的骸骨堆中。就在其北面，一堆熄灭的营火能开启{quest:79229}，同样是{npc:11438}的任务。",
	-- {item:13703} Kodo Bone
	["{item:13703}, among the skeletons"] = "{item:13703}，在骸骨堆里",
	-- {quest:79229} Highway Robbery · {object:417353} Extinguished Campfire (no name in this language: may be words)
	["{quest:79229}: the {object:417353}"] = "{quest:79229}：那堆熄灭的营火",

	-- Step 18: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	-- plural, as words: Ancient Kodos = {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: the Ancient Kodos (36-37) hit hard: tame them, don't fight them."] = "对老迈的科多兽、濒死的科多兽或{npc:4702}使用{npc:11596}给的{item:13892}，驯服后它就会跟着你。带回{npc:11596}的营地，再与科多兽交谈才计入进度，也才能驯服下一只。共需五只，一次一只。注意：远古科多兽（36–37级）伤害很高，直接驯服，别打。",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "对墓地里的老迈的科多兽、濒死的科多兽或{npc:4702}使用；不要击杀",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "把驯服的科多兽带到{npc:11596}的营地，与它交谈；重复五次",

	-- Step 19: Kodo Graveyard: hides and venom
	-- {area:596} Kodo Graveyard
	["{area:596}: hides and venom"] = "{area:596}：兽皮和毒液",
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo · Scorpashi Lashers = {npc:4697} Scorpashi Lasher · Ancient Kodos = {npc:4702} Ancient Kodo
	["The Aged Kodos in the graveyard drop the hides, and the Scorpashi Lashers that hunt around it carry the venom. Careful: the Ancient Kodos (36-37) hit hard: fight only the Aged Kodos."] = "在墓地击杀老迈的科多兽收集皮，墓地周围的荒土鞭尾蝎会掉落毒液。注意：远古科多兽（36–37级）伤害很高，收集皮时只打老迈的科多兽。",

	-- Step 21: Kolkar Village
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:608} Nijel's Point · {npc:5752} Corporal Melkins · {quest:93224} Carved Centaur Totems · {npc:5396} Captain Pentigast
	-- plural, as words: Centaur Ears = {item:6067} Centaur Ear
	["North-east from {npc:11596}'s camp to {area:609}, on the way back to {area:608}: every Kolkar drops Centaur Ears for {npc:5752} and {quest:93224} for {npc:5396}. The Magram south-east of {npc:11596}'s camp drop them too, but their village holds Necromancers (42-43) and Guardians (39-41): stay with the Kolkar (30-35)."] = "从{npc:11596}的营地向东北前往{area:609}，就在返回{area:608}的路上。所有科卡尔半人马都会掉落「半人马的耳朵」，交给{npc:5752}。它们也会掉落{quest:93224}所需的物品，交给{npc:5396}。{npc:11596}营地东南方的玛格拉姆半人马也会掉落这些东西，但村里有42–43级的通灵师和39–41级的守卫，打30–35级的科卡尔半人马即可。",

	-- Step 22: Kormek's Hut
	-- {area:609} Kolkar Village · {area:608} Nijel's Point · {npc:11438} Bibbly F'utzbuckle · {area:2407} Kormek's Hut · {area:35} Booty Bay
	["North-west from {area:609} back along the road to {area:608}: {npc:11438} waits at {area:2407}. He sends you after the robber to {area:35}, where the next guide ends: keep it."] = "从{area:609}向西北沿路返回{area:608}：{npc:11438}在{area:2407}等你。他会派你去{area:35}追捕劫匪，下一份指南在那里结束：保留此任务",
	-- {npc:11438} Bibbly F'utzbuckle · {area:35} Booty Bay
	["{npc:11438}: Tokal waits in {area:35}, at the end of the next guide"] = "{npc:11438}：托卡尔在{area:35}等着，在下一份指南的结尾",

	-- Step 23: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {zone:1443} Desolace
	["{npc:5638}: the satchel lies off the north-west coast, on {zone:1443}'s south loop at the end of 30-40: keep it"] = "在{npc:5638}处接下任务，先留着。走到30–40级路线末段的{zone:1443}南线时，再去西北海岸外找挎包。",

	-- Step 24: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",
	-- {area:608} Nijel's Point
	["{area:608} flight master"] = "{area:608}的飞行管理员",

	-- Step 25: Boat to Stormwind Harbor
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
	-- ["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "科卡尔半人马在{area:609}周围的平原上游荡；它们的耳朵交给{npc:5752}。",
	-- ["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "荒土蝎子在南边道路上的{area:2407}周围山丘上捕猎。",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702}: it becomes a tamed kodo that follows you. Walk it back to {npc:11596}'s camp; there, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "对老迈的科多兽、濒死的科多兽或{npc:4702}使用{npc:11596}的{item:13892}，它就会被驯服并跟随。将它带回{npc:11596}的营地，再与科多兽交谈，才会计入进度，并能驯服下一只。共需五只，一次一只；老迈的科多兽也会掉落皮，墓地周围活动的荒土鞭尾蝎会掉落毒液。",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "对一只{npc:4700}使用{npc:11596}的{item:13892}，然后带着驯服的科多兽走回他的营地，共五次；老迈的科多兽也会掉落皮，在墓地周围捕猎的荒土鞭笞者身上有毒液。",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "对一只{npc:4700}使用{npc:11596}的{item:13892}，然后带着驯服的科多兽走回他的营地，共五次；老迈的科多兽也会掉落皮。",
	-- ["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp. There, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time; Aged Kodos also drop the hides, and the Scorpashi Lashers that hunt around the graveyard carry the venom."] = "对一只 {npc:4700} 使用 {npc:11596} 的 {item:13892}，将驯服的科多兽带回他的营地。到达后与科多兽交谈，才会计入进度，并能驯服下一只。共需五只，一次一只；老迈的科多兽也会掉落皮，墓地周围捕猎的荒土鞭尾蝎会掉落毒液。",
	-- ["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "跟着车队向南经过{area:609}；途中科卡尔伏击者会袭击车队。一直跟在旁边，直到它停在{area:2617}。伏击者为34-35级，分批出现：低于33级就跳过。",
	-- ["{item:190309}, north of {area:413}"] = "{item:190309}，在{area:413}北边",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}：{item:279915}，来自米奈希尔港的Sylessa",
	-- ["{npc:5638}: the satchel lies off the north-west coast, on the south loop at the end of 30-40 (06-badlands): keep it"] = "{npc:5638}：挎包在西北海岸外，位于30-40结尾南线（06-badlands）上：先留着它",
	-- ["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644}躲在{area:608}西南方燃烧之刃的要塞里。",
	-- ["{object:177787}, beside the chest: keep it, its keys and chest come on {zone:1443}'s south loop at the end of 30-40"] = "{object:177787}：在箱子旁。先保留，钥匙和箱子在30-40级末尾{zone:1443}南部环线时再做",
}
