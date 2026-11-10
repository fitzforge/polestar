-- Chinese (simplified) (zhCN): the guide forever/class/shaman/call-of-air-horde (forever/class/shaman/call-of-air-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1531} Call of Air
	["{quest:1531} and the Tempest's Weapons (Horde)"] = "{quest:1531}和风暴武器（部落）",
	-- {item:5178} Air Totem
	["The {item:5178} that lets you place air totems, then a weapon of your choice at 40."] = "获得能放置空气图腾的{item:5178}，然后在40级自选一把武器。",

	-- Step 1: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {item:5178} Air Totem
	["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the {item:5178} she gives."] = "30级时，{object:172957}的{npc:5892}会让你去找{zone:1441}的{npc:5905}。你的30级空气图腾（根基图腾、{spell:10596}）需要她给的{item:5178}。",

	-- Step 2: Alaana Stormwalker
	-- {quest:96136} Call of Air · {npc:259119} Alaana Stormwalker · {zone:1412} Mulgore · {zone:1456} Thunder Bluff · {npc:5906} Xanis Flameweaver
	["At 30 Skyborne shamans get their own {quest:96136}. {npc:259119} waits where the airship from Zephras Isle lands, in northern {zone:1412} beside {zone:1456}. Your level 30 air totems need the Air Totem Prate Cloudseer gives. If she has nothing for you, head up to {npc:5906} in {zone:1456} (next step): the trainers' {quest:96136} is open to Skyborne and gives the same totem."] = "30 级时，天裔萨满祭司会获得专属的 {quest:96136}。{npc:259119} 在泽风岛飞船的降落点等着，位于 {zone:1412} 北部、{zone:1456} 旁边。30 级的空气系图腾需要普拉特·白云给予的空气图腾。如果她不给任务，就上去找 {zone:1456} 的 {npc:5906}（下一步）：训练师提供的 {quest:96136} 也对天裔开放，奖励同一个图腾。",

	-- Step 3: Xanis Flameweaver
	-- {npc:5906} Xanis Flameweaver · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:5905} Prate Cloudseer · {zone:1441} Thousand Needles · {spell:10596} Nature Resistance · {npc:5892} Searn Firewarder · {quest:1531} Call of Air · {zone:1454} Orgrimmar
	["At 30 {npc:5906}, a shaman trainer on {area:1640} in {zone:1456}, sends you to {npc:5905} in {zone:1441}. Your level 30 air totems (Grounding, {spell:10596}) need the Air Totem Prate gives. Already carry {npc:5892}'s {quest:1531} from {zone:1454}? It goes to {npc:5905} too: skip {npc:5906}."] = "30 级时，{zone:1456} 的 {area:1640} 上的萨满祭司训练师 {npc:5906} 会让你去 {zone:1441} 找 {npc:5905}。30 级的空气系图腾（根基图腾、{spell:10596}）需要普拉特给予的空气图腾。已经带着 {zone:1454} 的 {npc:5892} 给你的 {quest:1531}？它也是去找 {npc:5905}：跳过 {npc:5906} 即可。",

	-- Step 4: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} stands on a ledge above a cave mouth in the canyon wall north-east of the post, not inside the cave: climb the slope beside it. She also gives you an hour of faster attacks and running."] = "飞往 {area:484}。{npc:5905} 站在哨站东北方峡谷崖壁洞口上方的岩台上，不在洞内：沿洞口旁的斜坡爬上去。她还会让你的攻击速度和奔跑速度提高一小时。",

	-- Step 5
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",

	-- Step 9: Charlga Razorflank
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {npc:4421} Charlga Razorflank · {spell:8292} Chain Bolt · {spell:139} Renew · {item:274463} Tattered Note
	["{area:1717} is a five-player dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} (level 33 elite) is its last boss. She casts {spell:8292}, {spell:139} on her allies and Purity; the {item:274463} drops only from her."] = "{area:1717} 是位于 {zone:1413} 南缘的五人地下城（箭头指向入口）；{npc:4421}（33级精英）是最终首领。她会施放 {spell:8292}、对盟友施放 {spell:139}，还会使用 纯净术；{item:274463} 只有她会掉落。",
	-- {item:274463} Tattered Note · {npc:4421} Charlga Razorflank
	["{item:274463}, from {npc:4421}"] = "{item:274463}，来自{npc:4421}",

	-- Step 10: Rau Cliffrunner
	-- {npc:4722} Rau Cliffrunner · {area:484} Freewind Post
	["{npc:4722} stands at {area:484}."] = "{npc:4722}站在{area:484}。",

	-- Step 12: Twisted Air Totems
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Twisted Air Totems"] = "扭曲的空气图腾",
	-- {area:2408} Shadowprey Village · {zone:1443} Desolace · {spell:9654} Jumping Lightning
	-- plural, as words: Twisted Air Totems = {item:274047} Twisted Air Totem
	["Five Twisted Air Totems. The Maraudine centaurs (level 36-40) north and north-east of {area:2408} in western {zone:1443} carry them; the Scouts drop one nearly every other kill. Wranglers Net and Disarm, Windchasers heal, Stormers throw {spell:9654}: pull one at a time. Respawn about five minutes."] = "需要五个扭曲的空气图腾。{zone:1443}西部{area:2408}以北和东北方的玛洛迪半人马（36-40级）会携带；斥候的掉率接近两只出一个。玛洛迪争斗者会施放网和缴械，玛洛迪逐风者会治疗，玛洛迪狂怒者会施放{spell:9654}：每次只引一个。刷新约需五分钟。",

	-- Step 13: Twisted Water Totems
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Twisted Water Totems"] = "扭曲的水之图腾",
	-- {area:496} Brackenwall Village · {zone:1445} Dustwallow Marsh
	-- plural, as words: Twisted Water Totems = {item:274046} Twisted Water Totem
	["Five Twisted Water Totems. The Mirefin murlocs (level 35-38) north-east of {area:496} in northern {zone:1445} carry them."] = "五个扭曲的水之图腾。{zone:1445} 北部、{area:496} 东北面的 黑鳍 鱼人（35—38级）携带这些图腾。",

	-- Step 14: Twisted Fire Totems
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem
	["Twisted Fire Totems"] = "扭曲的火焰图腾",
	-- {area:338} Angor Fortress · {zone:1418} Badlands · {npc:3560} Healing Ward
	-- plural, as words: Twisted Fire Totems = {item:274044} Twisted Fire Totem · Fire Nova Totems = {npc:5879} Fire Nova Totem
	["Five Twisted Fire Totems. The Stonevault troggs (Skullthumpers, Bonesnappers and Shamans, level 37-41) south of {area:338} in the {zone:1418} carry them; the Shamans drop Fire Nova Totems and a {npc:3560}, the Bonesnappers run for help when hurt. Respawn about five minutes."] = "需要五个扭曲的火焰图腾。它们由 {zone:1418} 的 {area:338} 南边的石窟穴居人携带（击颅者、断骨者和萨满祭司，37-41 级）；萨满祭司会放置火焰新星图腾和 {npc:3560}，断骨者受伤后会逃跑求援。大约五分钟刷新。",

	-- Step 15: Twisted Earth Totems
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem
	["Twisted Earth Totems"] = "扭曲的大地图腾",
	-- {area:75} Stonard · {zone:1435} Swamp of Sorrows
	-- plural, as words: Twisted Earth Totems = {item:274045} Twisted Earth Totem · The Lost Ones = {npc:256028} The Lost One
	["Five Twisted Earth Totems. The Lost Ones (murlocs, level 34-39) north and north-east of {area:75} in the {zone:1435} carry them; most run for help when hurt."] = "五个扭曲的大地图腾。{zone:1435} 的 {area:75} 北侧及东北侧的失落者（鱼人，34-39 级）携带这些图腾；它们大多会在受伤后逃跑求援。",

	-- Step 17: The steam pools
	["The steam pools"] = "蒸汽池",
	-- {npc:5905} Prate Cloudseer · {item:268582} Corrupted Totems · {area:484} Freewind Post · {npc:216474} Ravaging Tempest · {item:212792} Eye of the Tempest
	["{npc:5905} hands you the {item:268582}. Place the {item:268582} at the steam pools north-west of {area:484} to call the corrupted elementals and then the {npc:216474}; Razormane quilboar join the fight while the ritual runs. A group quest: bring at least one or two friends. The {item:212792} drops about every other kill, and every group member can loot it."] = "{npc:5905} 会给你 {item:268582}。把 {item:268582} 放在 {area:484} 西北的蒸汽池，召出腐化元素，之后是 {npc:216474}；仪式进行期间，钢鬃野猪人也会加入战斗。这是小队任务：至少带一两位朋友。{item:212792} 大约每两次击杀掉落一次，每名队员都能拾取。",
	-- {item:212792} Eye of the Tempest · {npc:216474} Ravaging Tempest
	["{item:212792}, from the {npc:216474}"] = "{item:212792}，来自{npc:216474}",

	-- Step 19: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill · {item:280607} Lightning's Grasp · {item:280605} Tidebringer's Claw · {item:280604} Rage of the Storm · {item:280696} Elementalist's Guard
	["{npc:6176} camps in the ruins in the east of {zone:1416}: from {area:272} follow the river east of town north into the hills. Pick your weapon: {item:280607}, {item:280605} or {item:280604}; the {item:280696} shield comes with it."] = "{npc:6176} 驻扎在 {zone:1416} 东部的遗迹里：从 {area:272} 出发，沿镇子东边的河流向北进入山区。选择武器：{item:280607}、{item:280605} 或 {item:280604}；另外还会一并获得盾牌 {item:280696}。",
	-- {npc:6176} Bath'rah the Windwatcher · {item:280696} Elementalist's Guard
	["{npc:6176}: the {item:280696} and your weapon"] = "{npc:6176}：{item:280696}和你的武器",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5892} in the {object:172957} sends you to {npc:5905} in {zone:1441}."] = "30级时，{object:172957}的{npc:5892}会让你去找{zone:1441}的{npc:5905}。",
	-- ["At 30 {npc:5906}, a shaman trainer in {zone:1456}, sends you to {npc:5905} in {zone:1441}."] = "30级时，{zone:1456}的萨满祭司训练师{npc:5906}会让你去找{zone:1441}的{npc:5905}。",
	-- ["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post. Skyborne: your own {quest:1531} (96136) ends with her too."] = "飞往{area:484}。{npc:5905}藏在营地东北峡谷崖壁上的一个小洞里。天裔：你自己的{quest:1531}（96136）也在她这里交还。",
	-- ["The Lost Ones in the north of the {zone:1435} carry the Twisted Earth Totems."] = "{zone:1435}北部的失落者携带扭曲的大地图腾。",
	-- ["The Maraudine centaurs of western {zone:1443} carry the Twisted Air Totems."] = "{zone:1443}西部的玛洛迪半人马携带扭曲的空气图腾。",
	-- ["The Mirefin murlocs of northern {zone:1445} carry the Twisted Water Totems."] = "{zone:1445}北部的黑鳍鱼人携带扭曲的水之图腾。",
	-- ["The Stonevault troggs in the south of the {zone:1418} carry the Twisted Fire Totems."] = "{zone:1418}南部的石窟穴居人携带扭曲的火焰图腾。",
	-- ["{area:1717} is a dungeon at the southern edge of the {zone:1413} (the arrow points at its entrance); {npc:4421} is its last boss. Bring a group."] = "{area:1717}是{zone:1413}南缘的地下城（箭头指向入口）；{npc:4421}是最后一个首领。请带上小队。",
	-- ["{npc:5905} hands you the {item:268582}: place them at the steam pools west of {area:484} and defeat the {npc:216474} they call. {quest:79366} is an elite quest: grouping up is advised."] = "{npc:5905}会给你{item:268582}：把它们放在{area:484}以西的蒸汽池，然后击败它们召来的{npc:216474}。{quest:79366}是精英任务：建议组队。",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}在{zone:1416}东部扎营，位于{area:272}东北。",
	-- ["{npc:6176}: the {item:213086} and your weapon"] = "{npc:6176}：{item:213086}和你的武器",
}
