-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts · {npc:4709} Zamek
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, {npc:4709} by the goblin camp."] = "{area:2240} 位于 {zone:1441} 东南部的 {area:439}：{npc:4454} 在赛道旁的侏儒营地内，{npc:4709} 在地精营地旁。",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}：{quest:1137}，来自 {zone:1418} 的马特克",
	["He runs off to keep Rizzle busy"] = "他会跑去拖住瑞兹尔·铜栓",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "向东南骑出{area:439}进入{zone:1446}。{area:976}就在边界内。",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}，镇子北侧",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}，在水塔旁",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}，在他旁边",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}：他的箱子之后送到{area:702}",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "向东骑过沙丘到东北海岸的地精港口热砂港。",
	["The Wanted poster beside him"] = "他旁边的通缉布告",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "同一张告示：{npc:7847}要很久以后才会出现，在{area:976}之后",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}：在屋内",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "{npc:7881}，位于港口旅店内",

	-- Step 6: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}：沿途击杀以下目标",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "向西骑行返回{area:976}方向，废土强盗和窃贼占据沿途沙丘，均有几率携带水袋。\n注意：43–44 级的废土游荡者会潜行移动，可能在你未察觉时靠近。",

	-- Step 8: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "更强的废土游荡者、暗影法师和刺客在{area:976}东南、强盗区域以南扎营。南侧营地中央的{npc:7847}留到稍后再处理。\n注意：废土游荡者在非战斗状态下会保持潜行，营地中隐藏的盗贼可能加入你发起的战斗。",

	-- Step 9: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}：沿途击杀以下目标",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "沿海岸向南前往海盗海湾。南海海盗密布在海滩和船上：沿边缘推进，每次只引一名。{npc:7883} 在另一侧；{npc:7881} 被盗的货物就在营地中。\n注意：{npc:7883} 身边有两三名海盗，一旦开战，镇上还会有许多海盗加入战斗。",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "{quest:2873}：在楼上",

	-- Step 10: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}：在屋内",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "",

	-- Step 11: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "注意：窃贼会缴械，游荡者会潜行隐藏，刺客会在你生命值降到 20% 或以下时使用斩杀。",

	-- Step 13: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "{area:979}旁的水池",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "向西北骑到{area:979}的沙怒巨魔营地。在水池边缘使用{item:8584}；巨魔站得很近，先拉最近的。",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "获得{item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "{area:979}旁的水池",

	-- Step 15: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "向南骑到{area:1938}的挖掘营地。{npc:7771}会给你一顶探测头盔：戴上它才能看到{quest:3161}土堆，营地周围和向西南通往食人魔的沙地里到处都是。",

	-- Step 17: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "向西北骑行前往沙丘中的森提帕尔虫巢，所有森提帕尔异种虫都有几率掉落昆虫肢体。\n注意：森提帕尔群居蝎在战斗内外都会施放{npc:4196}，召来会打断你的幼虫。",

	-- Step 18: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "向西南骑到砂槌营地。里面满是砂槌蛮兵和砂槌执行者（46-48级）；{npc:12046}（49级）站在中间，周围有卫兵：先清理卫兵。",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}：在地下",
	-- {npc:5474} Dunemaul Brute
	["grind on {npc:5474}"] = "反复击杀{npc:5474}补足经验",

	-- Step 19: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}：沿途击杀以下目标",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "向南骑行进入{quest:3362}。露水收集者会掉落腺体，但只有部分是装满的，保留充满的那种。长瘤的灌木兽和根须挖掘者也在山谷内。灌木兽为 48–50 级，高于你当前等级，逐个拉怪。\n注意：附近其他灌木兽为 49–50 级，而且经常走动，容易额外引怪。",

	-- Step 20: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "{npc:5955}的护送",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "小乌龟{npc:5955}躲在山谷北端。带他回家去找他妻子{npc:6015}，她在{area:977}东边不远处的水边：他走得慢，沙漠里的野兽会攻击他，保护好他。",

	-- Step 21: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",

	-- Step 22: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "向东南骑行前往{area:985}。{npc:7847}站在南部废土营地中央：先清理他周围的敌人。\n小心：他走到哪里都有两名潜行的废土游荡者跟随。在他的刷新营地里，两名暗影法师及其仆从离得很近，会加入战斗。到塔楼附近就可以避开他们，单独与他交战。",

	-- Step 23: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "骑行向南经过{area:1938}，前往{area:981}的哈扎里隧道，谢申克的设备在深处。\n注意：设备旁有一只虫子守卫，隧道里还有许多巡逻虫，其中一些达到 50 级，战斗经常引来额外敌人。",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}：在地下",

	-- Step 24: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "交给{zone:1457}：路线会在47级带你去那里",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "飞往塞拉摩岛",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}的飞行管理员",

	-- Step 26: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "乘船前往{area:150}",

	-- Step 27: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "飞往{area:348}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "{area:150}的飞行管理员",

	-- Step 28: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "{npc:5636}，在飞行管理员旁",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}：在屋内",

	-- Step 31: Sprinkle's Secret Ingredient
	["Underwater"] = "在水下",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "从{area:976}飞往塞拉摩岛，乘船前往{area:150}，再飞往{area:1537}。学习技能。",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "飞往{area:348}。{zone:1425}指南从这里开始。",
	-- ["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "沿海岸向南到落帆海湾。南海海盗挤满了海滩和船：沿着边缘清理，一次拉一个。{npc:7883}站在远端；{npc:7881}被偷的货物在营地里。",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "从{area:1108}码头乘船前往羽月要塞，飞往{area:489}，然后向东骑过{zone:1441}，到{area:439}的{area:2240}。{npc:4454}和{npc:4630}在赛道旁的营地里；{npc:4709}站在地精营地旁。",
	-- ["Hearth to {area:976}."] = "用炉石返回{area:976}。",
	-- ["Ride back west to {area:976}."] = "向西骑回{area:976}。",
	-- ["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "向西骑回{area:976}。废土强盗和废土窃贼占据着沿途的沙丘；任何一个都可能带着废土水袋。",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "向西北骑到沙丘中的森提帕尔虫巢腐化之巢。任何森提帕尔都可能掉落昆虫部件。",
	-- ["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "向南骑进{quest:3362}。灌木露水收集者掉落腺体；只有部分是饱满的，留下饱满的露水腺。{npc:5490}和灌木塑根者也在山谷里。灌木怪是48-50级，比你高：一次拉一个。",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "向南经过{area:1938}到{area:981}，即哈扎里隧道；谢申克的勘探设备在深处。",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "向东南骑出{area:439}进入{area:440}。{area:976}就在边界内。",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "向东南骑到{area:985}。{npc:7847}站在南边废土营地的中央：先清理他周围。",
	-- ["Rizzle's plans"] = "Rizzle的设计图",
	-- ["The Wanted poster by {npc:7882}"] = "{npc:7882}旁的通缉布告",
	-- ["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "更强的废土游荡者、废土暗法师和废土刺客在{area:976}东南方、强盗的南边扎营。把南边营地中间的{npc:7847}留到之后。",
	-- ["Wastewander bandits"] = "废土强盗",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "{npc:4709}拖住Rizzle说话时，他的设计图就在赛道对面的侏儒营地里，无人看守。",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}，在镇子东侧",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "{npc:7583}的下一种材料生长在{zone:1425}，路线不会再回来：跳过。",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "{npc:7881}的下一趟送货要回{area:35}：跳过。",
	-- ["{npc:7881}, in the port's tavern"] = "{npc:7881}，在港口的酒馆里",
}
