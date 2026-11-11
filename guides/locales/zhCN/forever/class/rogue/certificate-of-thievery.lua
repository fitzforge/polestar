-- Chinese (simplified) (zhCN): the guide forever/class/rogue/certificate-of-thievery (forever/class/rogue/certificate-of-thievery.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6966} Lucius · {quest:2282} Alther's Mill · {quest:2300} SI:7
	["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "16级时你的第一份开锁工作：为{quest:2300}打开{quest:2282}的{npc:6966}的锁箱。",

	-- Step 1: SI:7 (Goldshire)
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:6946} Renzik "The Shiv" · {zone:1453} Stormwind
	["At 16 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}. Taking it shuts out the other towns' breadcrumbs."] = "16 级时，{area:87} 狮王之傲旅店楼上的潜行者训练师 {npc:917} 会让你去 {zone:1453} 找 {npc:6946}。接下后就不能再接其他城镇的同类引导任务。",

	-- Step 2: To Hulfdan! (Kharanos)
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge · {object:32383} Forlorn Cavern
	["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165} in {zone:1455}'s {object:32383}."] = "达到 16 级后，{area:131} 的 {area:2102} 中的 {npc:1234} 会让你去找 {zone:1455} 的 {object:32383} 中的 {npc:5165}。",

	-- Step 3: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["{npc:5165} is in the house with a shady dealer outside, in the {object:32383}, down the stairs. Then fly or take the {area:2257} to {zone:1453}."] = "{npc:5165}在{object:32383}的一栋房子里，下楼梯即可找到；屋外有个可疑的商人。然后飞往{zone:1453}，或乘坐{area:2257}前往。",

	-- Step 4: Erion Shadewhisper (Dolanaar)
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {quest:2259} Erion Shadewhisper · {zone:1457} Darnassus
	["At 16 {npc:3599} in the {area:186} inn sends you to {quest:2259} in {zone:1457}."] = "16级时，{area:186} 旅店内的 {npc:3599} 会派你前往 {zone:1457} 进行 {quest:2259}。",

	-- Step 5: Erion Shadewhisper
	-- {npc:4214} Erion Shadewhisper · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor
	["{npc:4214} stands in the {area:1658}. Then the boat from {area:702} to {area:442}, and the boat from {area:442} to {area:17203}."] = "{npc:4214}站在{area:1658}。之后从{area:702}乘船到{area:442}，再从{area:442}乘船到{area:17203}。",

	-- Step 6: Renzik "The Shiv"
	-- {npc:6946} Renzik "The Shiv" · {quest:2300} SI:7 · {object:2100} Old Town · {spell:1804} Pick Lock · {npc:13283} Lord Tony Romano
	["{npc:6946} stands upstairs in the {quest:2300} building in {object:2100}, behind the rogue trainers. Before you leave: if you lack {spell:1804}, {npc:13283} in the {quest:2300} building teaches it; Lockpicking is the test of the next quest."] = "{npc:6946} 在 {object:2100} 的 {quest:2300} 建筑楼上，位于潜行者训练师后方。离开前：如果还不会 {spell:1804}，可向 {quest:2300} 建筑里的 {npc:13283} 学习；下一个任务考验的就是开锁。",

	-- Step 7: Lucius
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {npc:6966} Lucius · {item:5060} Thieves' Tools · {npc:3090} Gerald Crawley · {spell:1804} Pick Lock
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} stands on a crate on one of the {area:69} docks, south of town; he gives you {item:5060} with the job ({npc:3090} in {area:69} sells more). {spell:1804} does not work without the tools in your bags."] = "向东穿过 {zone:1429} 进入赤脊山，或飞往 {area:69}。{npc:6966} 站在镇子南边 {area:69} 的某个码头上的箱子上；接到任务时他会给你 {item:5060}（{area:69} 的 {npc:3090} 也出售）。背包里没有工具就无法使用 {spell:1804}。",

	-- Step 8: Alther's Mill
	-- {quest:2282} Alther's Mill · {area:69} Lakeshire · {object:121264} Lucius's Lockbox
	["{quest:2282} stands east of {area:69}, up off the road; Blackrock orcs roam near it. Inside, the Practice Lockboxes come back almost at once: pick them until {object:121264} opens for you (about 25 Lockpicking). Your Lockpicking cap rises 5 per level, so a low character may stall. Some boxes are trapped (a frost trap, for one); the skill still goes up. On Forever level 20 spiders wander near the boxes: clear them first or bring a friend. The lockbox always holds the token and is back two seconds after use. Practise on while it still gives skill: the next class quest needs about 75."] = "{quest:2282}位于{area:69}东面、道路上方；附近有黑石兽人游荡。里面的练习用保险箱几乎立即刷新：持续开锁，直到能打开{object:121264}（大约需要25点开锁技能）。开锁技能上限每升一级提高5点，因此等级太低可能无法继续提升。有些箱子设有陷阱（例如冰霜陷阱），但仍可提升技能。无限中，箱子附近有20级蜘蛛游荡：先清掉它们或带个朋友来。保险箱必定装有信物，使用后2秒刷新。只要还能提升技能就继续练习：下一个职业任务约需75点。",

	-- Step 9: Back to Lucius
	-- {npc:6966} Lucius
	["Back to {npc:6966}"] = "回到{npc:6966}那里",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165}, in the north of {zone:1455}."] = "16级时，{area:131}{area:2102}的{npc:1234}会让你去{zone:1455}北部找{npc:5165}。",
	-- ["At 16 {npc:3599} in {area:186} sends you to {quest:2259} in {zone:1457}."] = "16级时，{area:186}的{npc:3599}会让你去{zone:1457}找{quest:2259}。",
	-- ["At 16 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}."] = "16级时，{area:87}狮王之傲旅店的潜行者训练师{npc:917}会让你去{zone:1453}找{npc:6946}。",
	-- ["Ride east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "向东穿过{zone:1429}进入赤脊山，或飞往{area:69}。{npc:6966}在{area:69}西侧等候，会给你{item:5060}。",
	-- ["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "16级时你的第一份开锁工作：为{quest:2300}打开{quest:2282}的{npc:6966}的锁箱。",
	-- ["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}."] = "{npc:6946}站在{object:2100}{quest:2300}的{npc:332}身旁。矮人和侏儒从{zone:1455}乘{area:2257}；暗夜精灵从{area:442}乘船前往{area:17203}。",
	-- ["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}. Learn Lockpicking from a rogue trainer before leaving for Redridge."] = "{npc:6946}站在{object:2100}{quest:2300}的{npc:332}身旁。矮人和侏儒从{zone:1455}乘{area:2257}；暗夜精灵从{area:442}乘船前往{area:17203}。前往赤脊山前，先向潜行者训练师学会开锁。",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {item:7869} there."] = "{quest:2282}位于{area:69}东边，道路上方。在那里打开{item:7869}。",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there."] = "{quest:2282}位于{area:69}东边，道路上方。在那里打开{object:121264}。",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there. Keep the {item:5060} supplied by {npc:6966} in your bags. Clear nearby spiders before practicing; lower-level rogues should bring help if the boxes are guarded. Use the practice locks until the quest lock is within your current skill, then recover the token. If useful practice remains, do it before returning to town; stop when the locks no longer improve your skill."] = "{quest:2282}位于{area:69}东边，道路上方。在那里打开{object:121264}。把{npc:6966}给你的{item:5060}留在背包里。练锁前先处理附近的蜘蛛；低等级时如果箱子有怪守着，建议找人帮忙。先用练习锁提高技能，达到当前任务锁的要求后再取出徽记。回城前可顺手继续练习，但锁已经不能提升技能时就不用继续了。",
}
