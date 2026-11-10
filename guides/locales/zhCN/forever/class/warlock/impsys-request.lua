-- Chinese (simplified) (zhCN): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "50多级的法杖、副手或长袍；这是{npc:14470}自己的差事，不属于恐惧战马任务线。",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "50级时，{object:2101} 的 {object:2164} 内的 {npc:461} 会派你带上一块 {item:14256}，去 {zone:1448} 找 {npc:14470}。",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "50级时，{zone:1455}的{npc:5172}会派你带一块{item:14256}去{zone:1448}找{npc:14470}。",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "50级时，{object:172960} 内的 {npc:3326} 会派你带上一块 {item:14256}，去 {zone:1448} 找 {npc:14470}。",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "50级时，{object:36082} 内的 {npc:4563} 会派你带上一块 {item:14256}，去 {zone:1448} 找 {npc:14470}。",

	-- Step 5: Felcloth
	-- {item:14256} Felcloth · {zone:1448} Felwood · {quest:8419} An Imp's Request · {npc:14470} Impsy · {quest:8420} Hot and Itchy
	["One {item:14256}: the Jadefire satyrs of {zone:1448} drop it about one kill in fourteen, and so do the Legashi satyrs and the Felguard Sentries you hunt for Niby's essences. Quicker: buy one at the Auction House. You need it for the trainer's {quest:8419} or for {npc:14470}'s own {quest:8420}, the same errand: whichever you hold."] = "一份 {item:14256}：{zone:1448} 的碧火萨特掉率约为十四分之一；你为万能的尼比收集精华时猎杀的雷加斯萨特和恶魔卫士哨兵也会掉落。更快的办法是去拍卖行买一份。无论你接的是训练师的 {quest:8419}，还是 {npc:14470} 自己提供的 {quest:8420}，都需要它；两者是同一项差事。",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8419} An Imp's Request · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Hand him the trainer's {quest:8419} with the cloth. Next he wants ten {item:20613} and four {item:20614}."] = "{npc:14470}在{area:1997}东北方不远的高地上，站在{npc:14469}旁边：向北过{area:1765}的桥后，经过几只软泥怪，他们就在道路东侧。将训练师的{quest:8419}连同布料一起交给他。接下来他需要十个{item:20613}和四个{item:20614}。",

	-- Step 7: Impsy: Hot and Itchy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8420} Hot and Itchy · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Take his own {quest:8420} and hand him the cloth at once. Next he wants ten {item:20613} and four {item:20614}."] = "{npc:14470}在{area:1997}东北方不远的高地上，站在{npc:14469}旁边：向北过{area:1765}的桥后，经过几只软泥怪，他们就在道路东侧。接受他自己的{quest:8420}，并立即交给他布料。接下来他需要十个{item:20613}和四个{item:20614}。",

	-- Step 8: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613}和血毒",
	-- {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {item:20613} Rotting Wood · {npc:7149} Withered Protector · {npc:14470} Impsy
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants (level 52) of {area:1767}, in northern {zone:1448} west of {area:1998}, drop {item:20613} one time in four; the big {npc:7149} (55) often drops three at once but hits hard and dazes. The Tainted Oozes (51) around {npc:14470} and along the Bloodvenom drop the essence one time in five."] = "{zone:1448}北部、{area:1998}以西{area:1767}的铁木树人（52级）掉落{item:20613}的概率为四分之一；体型巨大的{npc:7149}（55级）经常一次掉3个，但伤害很高，还会造成眩晕。{npc:14470}周围及血毒河沿岸的被污染的软泥怪（51级）掉落精华的概率为五分之一。",

	-- Step 9: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "再次找{npc:14470}",
	-- {npc:14470} Impsy · {item:20609} Voodoo Feathers · {area:1417} Sunken Temple
	["{npc:14470} now wants six {item:20609} from the {area:1417}: a dungeon run."] = "{npc:14470} 现在需要来自 {area:1417} 的六份 {item:20609}：要打一次地下城。",

	-- Step 10: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor
	["The {area:1417} ({area:1477}, level 50-56, a group of five) stands in the middle of the {area:74}: swim down into the temple and take the stairs to the entrance. The six troll guardians (level 51-52, elite) stand on the balconies around the central pit, each with adds; each drops his feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Not soloable at 52."] = "{area:1417}（{area:1477}，50—56级，五人小队）位于 {area:74} 中央：游入水下神庙，再沿楼梯前往入口。六名巨魔守护者（51—52级精英）站在中央深坑周围的看台上，每名身旁都有其他敌人；每次击杀都必定掉落对应的羽毛：加什尔和 {npc:5716} 掉落琥珀色，胡库和米杉掉落蓝色，祖罗和洛若尔掉落绿色。52级时无法单刷。",
	-- {npc:5716} Zul'Lor
	-- plural, as words: Amber Voodoo Feathers = {item:20606} Amber Voodoo Feather
	["Amber Voodoo Feathers: Gasher, {npc:5716}"] = "琥珀巫毒羽毛：加什尔、{npc:5716}",
	-- plural, as words: Blue Voodoo Feathers = {item:20607} Blue Voodoo Feather
	["Blue Voodoo Feathers: Hukku, Mijan"] = "蓝色巫毒羽毛：胡库、米杉",
	-- plural, as words: Green Voodoo Feathers = {item:20608} Green Voodoo Feather
	["Green Voodoo Feathers: Zolo, Loro"] = "绿色巫毒羽毛：祖罗、洛若",

	-- Step 11: Trolls of a Feather
	-- {item:20536} Soul Harvester · {item:20534} Abyss Shard · {item:20530} Robes of Servitude
	["Choose the {item:20536} (staff), the {item:20534} (off-hand) or the {item:20530}."] = "选择 {item:20536}（法杖）、{item:20534}（副手）或 {item:20530}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448}."] = "50级时，{object:172960}的{npc:3326}会让你去找{zone:1448}的{npc:14470}。",
	-- ["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448}."] = "50级时，{object:36082}的{npc:4563}会让你去找{zone:1448}的{npc:14470}。",
	-- ["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448}."] = "50级时，{object:2101}中{object:2164}的{npc:461}会让你去找{zone:1448}的{npc:14470}。",
	-- ["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448}."] = "50级时，{zone:1455}的{npc:5172}会让你去找{zone:1448}的{npc:14470}。",
	-- ["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "{zone:1448}北部的铁木树人掉落{item:20613}；{area:1763}周围的被污染的软泥怪掉落{item:20614}。",
	-- ["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "{area:1417}是50级地下城，其中六个巨魔守卫各掉落一根巫毒羽毛：请带上五人小队。神庙位于{area:74}中央；潜下去即可到达入口。",
	-- ["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470}在{zone:1448}中部、{area:1763}东边，等在{npc:14469}旁。这条任务线是{npc:14470}自己的，不属于恐惧战马任务线；尼比和{npc:14470}在这里也提供{item:18762}任务线。",
	-- ["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470}要一块{item:14256}：碧火萨特和{area:1763}的恶魔会掉落。",
}
