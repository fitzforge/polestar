-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 2: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "搭飛艇前往{object:3202}",

	-- Step 3: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	["The zeppelin lands at the tower on the west side of the camp."] = "飛艇降落在營地西側的塔。",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}：給阿拉希，在路線稍後",

	-- Step 4: Bloody Bone Necklace on the way
	-- {item:3915} Bloody Bone Necklace
	["{item:3915} on the way"] = "",

	-- Step 5: Islen Waterseer
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {area:1637} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short walk south of it."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}：{npc:3527}和你的{item:5177}",

	-- Step 6: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的營地",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "沿著道路從{object:3202}向北走；奈辛瓦里的狩獵營地在河東北方的山丘上。從現在起，保留你拾取的每一頁{quest:338}：{npc:716}稍後會要。",

	-- Step 9: Young Panther on the way
	-- {npc:683} Young Panther
	["{npc:683} on the way"] = "",

	-- Step 10: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 11: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "沿著道路向南前往山谷南端的{area:35}，從懸崖中的隧道進入。待在道路上：路旁叢林的等級比你高很多。部落飛行管理員{npc:2858}在上層平台等候。",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	["Upstairs"] = "",

	-- Step 12: Bloodscalp Ear on the way
	-- {item:1519} Bloodscalp Ear
	["{item:1519} on the way"] = "",

	-- Step 13: Tumbled Crystal on the way
	-- {item:4106} Tumbled Crystal
	["{item:4106} on the way"] = "",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 15: Grom'gol
	-- {object:3202} Grom'gol
	["Follow the road south to {object:3202}."] = "沿著道路向南前往{object:3202}。",

	-- Step 17: The camp by the river
	["The camp by the river"] = "河邊的營地",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}失蹤的獵人營地就是奈辛瓦里的營地：在帳篷之間走一走，調查就會完成。淡水鱷沿著營地下方的河邊趴著。",

	-- Step 19: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "荊棘谷猛虎和黑豹（32-33級）在營地東邊、沿著湖岸的山丘上遊蕩。",

	-- Step 20: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "深喉獵豹要很久以後才會遇到，在{object:3202}附近",

	-- Step 21: Shadowmaw Panther on the way
	-- {npc:684} Shadowmaw Panther
	["{npc:684} on the way"] = "",

	-- Step 22: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "老虎與鞭尾迅猛龍",
	-- {object:3202} Grom'gol
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 23: Nesingwary's camp
	["Back north to the camp."] = "向北回到營地。",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 26: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "使用爐石前往{area:35}",

	-- Step 27: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",
	-- {object:3202} Grom'gol · {area:35} Booty Bay
	["Head south down the coast to {object:3202} and fly to {area:35}."] = "",

	-- Step 29: Lashtail Raptor on the way
	-- {npc:686} Lashtail Raptor
	["{npc:686} on the way"] = "",
	-- {npc:686} Lashtail Raptor · {object:3202} Grom'gol
	["{npc:686} along the way to {object:3202}"] = "",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "鞭尾迅猛龍（35-36級）在{object:3202}東北方不遠處的叢林中獵食。",

	-- Step 31: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "{area:104}位於格羅姆高營地西北方的外海水下。{item:4094}在沉沒遺跡旁的海底；注意你的呼吸和魚人。",
	["Underwater"] = "",

	-- Step 32: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "",

	-- Step 33: Grom'gol
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "",

	-- Step 34: Mosh'Ogg Brute on the way
	-- {npc:1142} Mosh'Ogg Brute
	["{npc:1142} on the way"] = "",

	-- Step 35: Mosh'Ogg Witch Doctor on the way
	-- {npc:1144} Mosh'Ogg Witch Doctor
	["{npc:1144} on the way"] = "",

	-- Step 36: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 37: Green Hills pages
	["Green Hills pages"] = "荊棘谷的青山書頁",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}的每一頁從血頂和劈顱食人妖身上的掉落率約為1%；保留你拾取的每一頁，其餘的到拍賣場找。{npc:716}會在本指南稍後收下這些章節。",

	-- Step 38: Shadowmaw panthers
	["Shadowmaw panthers"] = "深喉獵豹",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "深喉獵豹（37-38級）在莫什奧格山丘東邊以及往東北通往湖泊的叢林中潛行；牠們會從潛行中發動攻擊。沿途拾取你找到的每一頁荊棘谷的青山。",
	-- {npc:684} Shadowmaw Panther
	["grind on {npc:684}"] = "",

	-- Step 39: Venture Co. camp
	["Venture Co. camp"] = "風險投資公司營地",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "",

	-- Step 40: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "",

	-- Step 41: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "返回{object:3202}。",

	-- Step 42: Level 36
	["Level 36"] = "",
	-- {area:321} Hammerfall
	["Top up here to level 36 before the hand-ins at {area:321}: they take you to level 37."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {object:3202}"] = "返回{object:3202}",
	-- ["Basilisks and the Bloodscalp village"] = "蜥蜴與血頂村莊",
	-- ["Bloodscalp headhunters"] = "血頂獵頭者",
	-- ["Bloodscalp ruins"] = "血頂遺跡",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "在巨魔東邊，深喉獵豹（37-38級）在攻擊之前都隱形潛行；荊棘谷雌虎在同一區域遊蕩，偶爾會掉落完好的尖牙。鉗嘴鱷魚沿著叢林西邊的河岸分布；把牠們的皮留給{npc:2495}。",
	-- ["Follow the road north to the camp."] = "沿著道路向北前往營地。",
	-- ["Follow the road on south into {area:35}."] = "沿著道路繼續向南進入{area:35}。",
	-- ["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "向西經過營地。荊棘谷迅猛龍（33-34級）在林間空地獵食，血頂食人妖佔據海岸上的遺跡：每個血頂食人妖都可能掉落獠牙。他們極少數會掉落{item:4614}：如果掉了，閱讀它。",
	-- ["Hearth to {object:3202}"] = "使用爐石前往{object:3202}",
	-- ["Jungle Stalkers"] = "叢林捕獵者",
	-- ["Lashtail raptors"] = "鞭尾迅猛龍",
	-- ["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "搭升降梯離開{zone:1458}，穿過廢墟走上飛艇塔；前往{object:3202}的飛艇在西南邊那座塔。",
	-- ["Mistvale gorillas"] = "迷霧谷猩猩",
	-- ["Mosh'Ogg camp"] = "莫什奧格營地",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "{item:2755}的每一頁從血頂和劈顱食人妖身上的掉落率約為1%；拿下掉落的書頁，其餘的到拍賣場看看。",
	-- ["Raptors and the Bloodscalp trolls"] = "迅猛龍與血頂食人妖",
	-- ["Ride back south to {object:3202}."] = "向南騎回{object:3202}。",
	-- ["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "向北騎過奈辛瓦里的營地前往湖邊。風險投資公司地質學家（34-36級）在湖西岸的營地工作；他們身上帶著打磨過的水晶。",
	-- ["Ride south down the coast to {object:3202} and fly to {area:35}."] = "沿著海岸向南騎往{object:3202}，飛往{area:35}。",
	-- ["Shadowmaw jungle and the Snapjaw river"] = "深喉叢林與鉗嘴河",
	-- ["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "沿著道路向南前往{area:35}。老邁的迷霧谷猩猩（40-41級）住在道路東邊的{area:1737}；大約每二十隻有一隻帶著老化的肌腱。",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "在{object:3202}西側的塔搭乘前往{zone:1454}的飛艇，然後飛往{area:392}。{npc:5901}在它南邊不遠處的海岸紮營。",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "在{object:3202}西側的塔搭乘前往{zone:1454}的飛艇，並在繼續飛行前於城裡學習技能。",
	-- ["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "海岸村莊裡的血頂獵頭者（36-37級）身上帶著縮小的頭顱。",
	-- ["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "血頂食人妖佔據暗礁北邊海岸上的遺跡和更遠處的村莊；每一個都可能掉落{item:3915}。繼續拾取{quest:338}的書頁。",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "老年荊棘谷猛虎（34-35級）在營地西南方的山丘上遊蕩；鞭尾迅猛龍（35-36級）在更南邊、靠近{object:3202}處獵食。",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "叢林捕獵者（40-41級）在{object:3202}南邊的海岸獵食。牠們比你高很多：一次拉一隻，戰鬥之間休息。",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "莫什奧格巨魔在{object:3202}東邊不遠處的山丘上紮營。擊殺一個莫什奧格蠻兵和一個莫什奧格巫醫（36-37級）；一次拉一隻。",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "下一份指南會帶你向北飛往{area:272}，然後進入{zone:1417}。",
	-- ["Tigers and panthers"] = "老虎與黑豹",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "向西經過營地，晶背蜥蜴（34-35級）坐在岩石上；再過去的村莊裡，每個血頂食人妖都可能掉落耳朵。",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "小荊棘谷猛虎在營地西邊徘徊，小獵豹在營地南邊和東邊。",
	-- ["Young tigers and panthers"] = "小老虎與小獵豹",
	-- ["Zeppelin towers"] = "飛艇塔",
	-- ["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}：先前收集的鉗嘴鱷魚皮",
	-- ["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}是一隻37級的老虎，在營地西南方的山頂上徘徊。",
}
