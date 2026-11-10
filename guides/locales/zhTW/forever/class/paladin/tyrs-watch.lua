-- Chinese (traditional) (zhTW): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328} (Forsaken)"] = "",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "用{spell:7328}復活倒下的盟友，另外還有給新的被遺忘者聖騎士的一把武器和一面盾牌。",

	-- Step 1: Aramis Hammerhand
	-- {npc:1569} Shadow Priest Sarvis · {item:282423} Consecrated Scroll · {quest:364} The Mindless Ones · {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard · {area:154} Deathknell · {spell:635} Holy Light
	["{npc:1569} gives you a {item:282423} after {quest:364}: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "",
	-- {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Heal 5 {npc:259377} with {spell:635}"] = "",

	-- Step 2: Coming to Terms
	-- {npc:244808} Aramis Hammerhand · {npc:246143} Frightened Paladin
	["At 4 {npc:244808} sends you after a {npc:246143} who fled into the hills west of the church, just south of the bat cave. Talk to her to offer aid: she turns on you, and you have to put her down (level 3, easy)."] = "",
	-- {npc:246143} Frightened Paladin
	["Talk to the {npc:246143}, then defeat her"] = "",

	-- Step 3: Shari Stilwell
	-- {area:154} Deathknell · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road east out of {area:154} to {area:159}. {npc:246152}, the paladin trainer, stands in town; she trains you from here on."] = "",

	-- Step 4: A Second Home
	-- {npc:246152} Shari Stilwell · {area:159} Brill · {quest:91317} The Tarnished · {area:16881} Shadowvale
	["At 8 {npc:246152} in {area:159} sends you to the order's keep on the west coast. {quest:91317} in {area:16881} and the crypt under it hit hard at 8-9: come at 10 or later."] = "",

	-- Step 5: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {npc:267009} Hadric Harlson · {area:159} Brill
	["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after {quest:96896} from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "",

	-- Step 6: Murlocs at the Gates
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs (level 9-11) lurk on the bluffs along the road east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers x8"] = "",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers x8"] = "",

	-- Step 7: Touring the Grounds
	-- {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:246394} Ander Solliden · {npc:246393} Jorin Croge · {npc:246378} Danitha Morr
	["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246394}, the lookout, who walks the road south-east of the keep, then {npc:246393} and {npc:246378} inside the keep. Pick the conversation option with each."] = "",
	-- {npc:246349} Breton Samuels · {item:246164} Skullthumper · {item:246165} Driftwood Smasher
	["{npc:246349}: {item:246164} or {item:246165}"] = "",

	-- Step 8: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge · {quest:91317} The Tarnished
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it. {quest:91317} need level 9."] = "",

	-- Step 9: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {npc:259431} Rudolph Gelhardt
	["{quest:91317} (level 8-9) hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. Commander {npc:259431} (level 10) stands on the upper floor of a house, with Drudges below him: clear the ground floor first."] = "",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges x8"] = "",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots x6"] = "",

	-- Step 10: The crypt under Shadowvale
	-- {area:16881} Shadowvale
	["The crypt under {area:16881}"] = "",
	-- {item:246213} Sturdy Lumber · {npc:260396} Whispering Horror
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["The cellar is under the village, not on the surface: the way down is inside a burned-out house, where the arrow points. Twelve Lumber Piles (stacked beams) lie in the cellar, each good for one {item:246213}. {npc:260396}, an elite (level 11-13), sits at the far end: leave it alone."] = "",
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["Lumber Piles, in the cellar: the way down is here"] = "",

	-- Step 11: Hilda the Breaker's bones
	-- {npc:246389} Hilda the Breaker
	["{npc:246389}'s bones"] = "",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher · Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["The Shadowvale Lurchers and Mystics (level 8-10) in the crypt drop the Faintly Glowing Bones: about one in two from Lurchers, more from one kind of Mystic, less from the other."] = "",
	-- plural, as words: Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["Faintly Glowing Bones x6"] = "",

	-- Step 12: Ephram Barbaro's crystal
	-- {npc:259190} Ephram Barbaro
	["{npc:259190}'s crystal"] = "",
	-- {item:286269} Glowing Crystal Fragment
	["The {item:286269}, a green crystal, lies on the floor in the left-hand part of the crypt."] = "",

	-- Step 13: Back to the keep
	["Back to the keep"] = "返回要塞",
	-- {npc:246378} Danitha Morr · {npc:259431} Rudolph Gelhardt
	["{npc:246378} hands you {npc:259431}'s head for Sylvanas: keep it in your bags, it is what you hand in."] = "",

	-- Step 14: Hilda the Breaker
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190} wait at the forest's edge south of the gate."] = "",

	-- Step 15: Ephram Barbaro
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker
	["{npc:259190} waits at the forest's edge south of the gate, a few steps west of {npc:246389}."] = "",

	-- Step 16: A Lesson in Divinity
	-- {npc:246378} Danitha Morr · {item:2589} Linen Cloth · {zone:1458} Undercity
	["{npc:246378} offers the first Lesson in Divinity at level 12. Bring 10 {item:2589} if you have it: the {zone:1458} asks for it next."] = "",

	-- Step 17: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "從{area:159}向南走到{area:153}，再往下進入{zone:1458}。{npc:10181}在{object:36126}接見；{npc:257648}在{object:36078}乞討。",

	-- Step 18: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["{npc:257648} needs 10 {item:2589}. Humanoids drop it: the Scarlet Zealots and Friars of the glades about three kills in ten. The Undercity Auction House sells it too."] = "",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "",

	-- Step 20: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep. If you lose the symbol, {npc:246378} gives you another."] = "",
	-- {npc:257655} Deathguard Billmuth
	["{npc:257655}, downstairs"] = "",

	-- Step 21: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["{area:812} is at the far east end of the glades, a long walk. Falgan lies dead among the Scarlet Crusaders there: target his body and use the {item:6866}, then talk to him at once, as he does not stay alive long. If he is already up (another player), just talk to him; if he died again, raise him again."] = "",

	-- Step 22: The Scarlet attack plans
	["The Scarlet attack plans"] = "血色十字軍的攻擊計畫",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["The Scarlet Zealots (level 8-9), Friars (9-10) and Tarnished around {area:812} carry the attack plans. They run for help at low health and respawn in five minutes."] = "",

	-- Step 23: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, then {npc:246378}, back upstairs in the keep, teaches you {spell:7328}."] = "",
	-- {npc:246378} Danitha Morr · {spell:7328} Redemption
	["{npc:246378}, back upstairs: {spell:7328}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "回到{area:16602}。{npc:246378}會給你{item:6866}；{npc:257655}在要塞樓下等候。",
	-- ["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "回到{area:16602}：比爾穆收下計畫，{npc:246378}教你{spell:7328}。",
	-- ["Tarnished Drudges"] = "晦暗苦工",
	-- ["Tarnished Zealots"] = "晦暗狂熱者",
	-- ["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "在{area:812}周圍紮營的{npc:239036}身上帶著攻擊計畫。",
	-- ["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "邪鰭魚人潛伏在要塞東邊道路沿線的崖頂上，以及西邊湖泊周圍的營地中。",
	-- ["Tyr's Watch and {spell:7328}"] = "Tyr's Watch與{spell:7328}",
	-- ["Vile Fin Attackers"] = "邪鰭攻擊者",
	-- ["Vile Fin Seers"] = "邪鰭先知",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602}位於{area:156}西北方的崖頂上。{npc:246349}在大門等候。",
	-- ["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812}位於林地的最東端。對{npc:257663}使用{item:6866}，然後與他交談。如果你弄丟了符記，{npc:246378}會再給你一個。",
	-- ["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "在{area:159}訓練聖騎士的{npc:246152}會派你前往西海岸的騎士團要塞。",
	-- ["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378}在要塞內領導騎士團；{npc:246393}站在要塞旁。",
	-- ["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378}在12級時提供第一個神性的教誨。",
	-- ["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648}需要10份{item:2589}。血色狂熱者和血色苦行修士大約每十次掉落三次；如果你身上已有，就一起帶來。",
	-- ["{object:181686}, in the root cellar"] = "{object:181686}，在地窖裡",
	-- ["{object:554626}, in the root cellar"] = "{object:554626}，在地窖裡",
	-- ["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317}佔據要塞西南方{area:16616}中的廢棄村莊{area:16881}。{item:246213}堆放在其中一間房子的地窖裡；{npc:259431}在他的晦暗者之間走動。",
}
