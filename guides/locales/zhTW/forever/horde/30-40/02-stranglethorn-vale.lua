-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "搭飛艇前往{object:3202}",
	-- {zone:1458} Undercity · {object:3202} Grom'gol
	["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "搭升降梯離開{zone:1458}，穿過廢墟走上飛艇塔；前往{object:3202}的飛艇在西南邊那座塔。",
	["Zeppelin towers"] = "飛艇塔",

	-- Step 2: Grom'gol Base Camp
	["The zeppelin lands at the tower on the west side of the camp."] = "飛艇降落在營地西側的塔。",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "在{object:3202}西側的塔搭乘前往{zone:1454}的飛艇，並在繼續飛行前於城裡學習技能。",

	-- Step 4: Islen Waterseer
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "在{object:3202}西側的塔搭乘前往{zone:1454}的飛艇，然後飛往{area:392}。{npc:5901}在它南邊不遠處的海岸紮營。",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}：{npc:3527}和你的{item:5177}",

	-- Step 5: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "返回{object:3202}",

	-- Step 6: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的營地",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "沿著道路從{object:3202}向北走；奈辛瓦里的狩獵營地在河東北方的山丘上。從現在起，保留你拾取的每一頁{quest:338}：{npc:716}稍後會要。",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "小老虎與小獵豹",
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "小荊棘谷猛虎在營地西邊徘徊，小獵豹在營地南邊和東邊。",

	-- Step 9: Tigers and panthers
	["Tigers and panthers"] = "老虎與黑豹",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "荊棘谷猛虎和黑豹（32-33級）在營地東邊、沿著湖岸的山丘上遊蕩。",

	-- Step 10: Raptors and the Bloodscalp trolls
	["Raptors and the Bloodscalp trolls"] = "迅猛龍與血頂食人妖",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "向西經過營地。荊棘谷迅猛龍（33-34級）在林間空地獵食，血頂食人妖佔據海岸上的遺跡：每個血頂食人妖都可能掉落獠牙。他們極少數會掉落{item:4614}：如果掉了，閱讀它。",

	-- Step 12: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "老虎與鞭尾迅猛龍",
	-- {object:3202} Grom'gol
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "老年荊棘谷猛虎（34-35級）在營地西南方的山丘上遊蕩；鞭尾迅猛龍（35-36級）在更南邊、靠近{object:3202}處獵食。",

	-- Step 13: Grom'gol
	-- {object:3202} Grom'gol
	["Follow the road south to {object:3202}."] = "沿著道路向南前往{object:3202}。",

	-- Step 14: Nesingwary's camp
	["Back north to the camp."] = "向北回到營地。",

	-- Step 15: Sin'Dall
	-- {npc:729} Sin'Dall
	["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}是一隻37級的老虎，在營地西南方的山頂上徘徊。",

	-- Step 17: Bloodscalp headhunters
	["Bloodscalp headhunters"] = "血頂獵頭者",
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "海岸村莊裡的血頂獵頭者（36-37級）身上帶著縮小的頭顱。",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol
	["Hearth to {object:3202}"] = "使用爐石前往{object:3202}",

	-- Step 19: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "沿著道路向南前往山谷南端的{area:35}，從懸崖中的隧道進入。待在道路上：路旁叢林的等級比你高很多。部落飛行管理員{npc:2858}在上層平台等候。",

	-- Step 20: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",

	-- Step 21: The camp by the river
	["The camp by the river"] = "河邊的營地",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}失蹤的獵人營地就是奈辛瓦里的營地：在帳篷之間走一走，調查就會完成。淡水鱷沿著營地下方的河邊趴著。",

	-- Step 22: Basilisks and the Bloodscalp village
	["Basilisks and the Bloodscalp village"] = "蜥蜴與血頂村莊",
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "向西經過營地，晶背蜥蜴（34-35級）坐在岩石上；再過去的村莊裡，每個血頂食人妖都可能掉落耳朵。",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Ride south down the coast to {object:3202} and fly to {area:35}."] = "沿著海岸向南騎往{object:3202}，飛往{area:35}。",

	-- Step 24: Fly to Grom'gol
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}：給阿拉希，在路線稍後",

	-- Step 25: Lashtail raptors
	["Lashtail raptors"] = "鞭尾迅猛龍",
	-- {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "鞭尾迅猛龍（35-36級）在{object:3202}東北方不遠處的叢林中獵食。",

	-- Step 27: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "莫什奧格營地",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "莫什奧格巨魔在{object:3202}東邊不遠處的山丘上紮營。擊殺一個莫什奧格蠻兵和一個莫什奧格巫醫（36-37級）；一次拉一隻。",

	-- Step 28: Shadowmaw jungle and the Snapjaw river
	["Shadowmaw jungle and the Snapjaw river"] = "深喉叢林與鉗嘴河",
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "在巨魔東邊，深喉獵豹（37-38級）在攻擊之前都隱形潛行；荊棘谷雌虎在同一區域遊蕩，偶爾會掉落完好的尖牙。鉗嘴鱷魚沿著叢林西邊的河岸分布；把牠們的皮留給{npc:2495}。",

	-- Step 29: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "返回{object:3202}。",

	-- Step 30: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "{area:104}位於格羅姆高營地西北方的外海水下。{item:4094}在沉沒遺跡旁的海底；注意你的呼吸和魚人。",

	-- Step 31: Bloodscalp ruins
	["Bloodscalp ruins"] = "血頂遺跡",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "血頂食人妖佔據暗礁北邊海岸上的遺跡和更遠處的村莊；每一個都可能掉落{item:3915}。繼續拾取{quest:338}的書頁。",

	-- Step 32: Grom'gol
	-- {object:3202} Grom'gol
	["Ride back south to {object:3202}."] = "向南騎回{object:3202}。",

	-- Step 33: Nesingwary's camp
	["Follow the road north to the camp."] = "沿著道路向北前往營地。",

	-- Step 34: Green Hills pages
	["Green Hills pages"] = "荊棘谷的青山書頁",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}的每一頁從血頂和劈顱食人妖身上的掉落率約為1%；保留你拾取的每一頁，其餘的到拍賣場找。{npc:716}會在本指南稍後收下這些章節。",

	-- Step 35: Shadowmaw panthers
	["Shadowmaw panthers"] = "深喉獵豹",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "深喉獵豹（37-38級）在莫什奧格山丘東邊以及往東北通往湖泊的叢林中潛行；牠們會從潛行中發動攻擊。沿途拾取你找到的每一頁荊棘谷的青山。",

	-- Step 36: Green Hills pages
	-- {item:2755} Green Hills of Stranglethorn
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "{item:2755}的每一頁從血頂和劈顱食人妖身上的掉落率約為1%；拿下掉落的書頁，其餘的到拍賣場看看。",

	-- Step 39: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "叢林捕獵者",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "叢林捕獵者（40-41級）在{object:3202}南邊的海岸獵食。牠們比你高很多：一次拉一隻，戰鬥之間休息。",

	-- Step 41: Mistvale gorillas
	["Mistvale gorillas"] = "迷霧谷猩猩",
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "沿著道路向南前往{area:35}。老邁的迷霧谷猩猩（40-41級）住在道路東邊的{area:1737}；大約每二十隻有一隻帶著老化的肌腱。",

	-- Step 42: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road on south into {area:35}."] = "沿著道路繼續向南進入{area:35}。",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}：先前收集的鉗嘴鱷魚皮",

	-- Step 44: Venture Co. camp
	["Venture Co. camp"] = "風險投資公司營地",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "向北騎過奈辛瓦里的營地前往湖邊。風險投資公司地質學家（34-36級）在湖西岸的營地工作；他們身上帶著打磨過的水晶。",

	-- Step 45: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "使用爐石前往{area:35}",
	-- {area:272} Tarren Mill · {zone:1417} Arathi Highlands
	["The next guide flies you north to {area:272} and into the {zone:1417}."] = "下一份指南會帶你向北飛往{area:272}，然後進入{zone:1417}。",
}
