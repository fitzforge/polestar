-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",
	-- {zone:1458} Undercity · {object:3202} Grom'gol
	["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "乘升降梯离开{zone:1458}，穿过废墟走到飞艇塔；前往{object:3202}的飞艇在西南边的塔上。",
	["Zeppelin towers"] = "飞艇塔",

	-- Step 2: Grom'gol Base Camp
	["The zeppelin lands at the tower on the west side of the camp."] = "飞艇降落在营地西侧的塔上。",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "在{object:3202}西侧的塔上乘坐前往{zone:1454}的飞艇，继续飞行前先在城里训练。",

	-- Step 4: Islen Waterseer
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "在{object:3202}西侧的塔上乘坐前往{zone:1454}的飞艇，然后飞往{area:392}。{npc:5901}在它南边不远的海岸上扎营。",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}：{npc:3527}和你的{item:5177}",

	-- Step 5: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "返回{object:3202}",

	-- Step 6: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的营地",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "沿道路向北离开{object:3202}；奈辛瓦里的狩猎营地在河东北边的山上。从现在起，留着拾取到的每一页{quest:338}：{npc:716}之后会要。",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "猛虎幼崽和猎豹幼崽",
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "荆棘谷猛虎幼崽在营地西边游荡，猎豹幼崽在营地南边和东边。",

	-- Step 9: Tigers and panthers
	["Tigers and panthers"] = "猛虎和黑豹",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "荆棘谷猛虎和黑豹（32-33级）在营地东边沿湖岸的山丘上游荡。",

	-- Step 10: Raptors and the Bloodscalp trolls
	["Raptors and the Bloodscalp trolls"] = "迅猛龙和血顶巨魔",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "向西经过营地。荆棘谷迅猛龙（33-34级）在林间空地捕猎，血顶巨魔占据着海岸边的废墟：每个血顶巨魔都可能掉落獠牙。他们极少掉落{item:4614}：如果掉了，就阅读它。",

	-- Step 12: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "老年猛虎和鞭尾迅猛龙",
	-- {object:3202} Grom'gol
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "老年荆棘谷猛虎（34-35级）在营地西南的山丘上游荡；鞭尾迅猛龙（35-36级）在更南边、靠近{object:3202}的地方捕猎。",

	-- Step 13: Grom'gol
	-- {object:3202} Grom'gol
	["Follow the road south to {object:3202}."] = "沿道路向南前往{object:3202}。",

	-- Step 14: Nesingwary's camp
	["Back north to the camp."] = "向北回到营地。",

	-- Step 15: Sin'Dall
	-- {npc:729} Sin'Dall
	["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}是一只37级的老虎，在营地西南的山顶上游荡。",

	-- Step 17: Bloodscalp headhunters
	["Bloodscalp headhunters"] = "血顶猎头者",
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "海岸村庄里的血顶猎头者（36-37级）携带皱缩的头颅。",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol
	["Hearth to {object:3202}"] = "用炉石回到{object:3202}",

	-- Step 19: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "沿道路向南前往山谷南端的{area:35}，从悬崖上的隧道进入。别离开道路：路旁丛林里的怪物比你高得多。部落飞行管理员{npc:2858}在上层甲板等候。",

	-- Step 20: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",

	-- Step 21: The camp by the river
	["The camp by the river"] = "河边的营地",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}失踪猎人的营地就是奈辛瓦里的营地：在帐篷间走一圈，调查就会完成。淡水鳄趴在营地下方的河边。",

	-- Step 22: Basilisks and the Bloodscalp village
	["Basilisks and the Bloodscalp village"] = "蜥蜴和血顶村庄",
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "向西经过营地，晶背蜥蜴（34-35级）趴在岩石上；再往前的村庄里每个血顶巨魔都可能掉落耳朵。",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Ride south down the coast to {object:3202} and fly to {area:35}."] = "沿海岸向南骑往{object:3202}，然后飞往{area:35}。",

	-- Step 24: Fly to Grom'gol
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}：交给阿拉希高地，路线后面会去",

	-- Step 25: Lashtail raptors
	["Lashtail raptors"] = "鞭尾迅猛龙",
	-- {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "鞭尾迅猛龙（35-36级）在{object:3202}东北不远的丛林里捕猎。",

	-- Step 27: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "莫什奥格营地",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "莫什奥格食人魔在{object:3202}正东的山丘上扎营。杀死一个莫什奥格蛮兵和一个莫什奥格巫医（36-37级）；一次引一个。",

	-- Step 28: Shadowmaw jungle and the Snapjaw river
	["Shadowmaw jungle and the Snapjaw river"] = "深喉猎豹的丛林和钳嘴鳄鱼的河流",
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "在食人魔东边，深喉猎豹（37-38级）在攻击前都是隐形的；荆棘谷雌虎在同一片地方游荡，偶尔掉落雌虎的牙齿。钳嘴鳄鱼分布在丛林正西的河边；留着它们的皮交给{npc:2495}。",

	-- Step 29: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "返回{object:3202}。",

	-- Step 30: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "{area:104}位于格罗姆高营地西北的近海水下。{item:4094}躺在沉没废墟旁的海底；注意呼吸和鱼人。",

	-- Step 31: Bloodscalp ruins
	["Bloodscalp ruins"] = "血顶废墟",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "血顶巨魔占据着暗礁北边沿海的废墟和更远处的村庄；每个都可能掉落{item:3915}。继续拾取{quest:338}的书页。",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol
	["Ride back south to {object:3202}."] = "向南骑回{object:3202}。",

	-- Step 33: Nesingwary's camp
	["Follow the road north to the camp."] = "沿道路向北前往营地。",

	-- Step 34: Green Hills pages
	["Green Hills pages"] = "荆棘谷的青山书页",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}的每一页从血顶巨魔和劈颅巨魔身上的掉率约为1%；留着拾取到的每一页，其余的去拍卖行找。{npc:716}会在本指南稍后收取各章节。",

	-- Step 35: Shadowmaw panthers
	["Shadowmaw panthers"] = "深喉猎豹",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "深喉猎豹（37-38级）在莫什奥格山丘东边和东北方通往湖泊的丛林里潜行；它们会从潜行中发动攻击。沿途拾取你找到的每一页荆棘谷的青山。",

	-- Step 36: Green Hills pages
	-- {item:2755} Green Hills of Stranglethorn
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "{item:2755}的每一页从血顶巨魔和劈颅巨魔身上的掉率约为1%；拿上掉落的，其余的去拍卖行找。",

	-- Step 39: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "丛林捕猎者",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "丛林捕猎者（40-41级）在{object:3202}南边的海岸捕猎。它们比你高得多：一次引一只，战斗间隙休息。",

	-- Step 41: Mistvale gorillas
	["Mistvale gorillas"] = "迷雾谷猩猩",
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "沿道路向南朝{area:35}前进。老迈的迷雾谷猩猩（40-41级）住在道路东边的{area:1737}；大约二十分之一带着成年大猩猩的肌腱。",

	-- Step 42: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road on south into {area:35}."] = "沿道路继续向南进入{area:35}。",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}：之前收集的钳嘴鳄鱼的皮",

	-- Step 44: Venture Co. camp
	["Venture Co. camp"] = "风险投资公司营地",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "向北骑过奈辛瓦里的营地前往湖边。风险投资公司地质学家（34-36级）在湖西岸的营地里干活；他们携带打磨过的水晶。",

	-- Step 45: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "用炉石回到{area:35}",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "下一个指南会带你向北飞往{area:272}，进入{zone:1417}。",
}
