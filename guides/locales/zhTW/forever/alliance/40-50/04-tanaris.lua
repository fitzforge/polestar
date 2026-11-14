-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, Zamek by the goblin camp."] = "{area:2240}位於{zone:1441}東南部的{area:439}：{npc:4454}在賽道旁的地精營地內，札米克在哥布林營地旁。",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "向東南騎離{area:439}進入{zone:1446}。{area:976}就在邊界內側。",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}，在城鎮北側",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}，在水塔旁",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}，在他旁邊",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}：他的箱子要送到{area:702}，稍後",

	-- Step 5: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod
	["For your {area:978} run, later in this guide: {quest:2864} wants scarab shells, {npc:7407}, by the water tower, his {quest:2768} back, and Trenton Lighthammer Troll Temper from the Sandfury trolls."] = "為了你稍後在本指南中的{area:978}之行：{quest:2864}要聖甲蟲殼，水塔旁的{npc:7407}要拿回他的{quest:2768}，特倫頓·輕錘要沙怒食人妖身上的食人妖回火劑。",

	-- Step 6: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "向東騎過沙丘，前往東北海岸的哥布林港口。",
	["The Wanted poster beside him"] = "他旁邊的通緝告示",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "同一張告示：{npc:7847}要很久以後才會出現，在{area:976}之後",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "{npc:7881}，在港口的旅店裡；在裡面",

	-- Step 7: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "向西騎回{area:976}。廢土強盜和廢土竊賊佔據沿途的沙丘；他們都可能帶著水袋。\n小心：廢土遊蕩者（43-44級）會潛行移動，可能在你沒察覺時接近。",

	-- Step 9: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "更強的廢土遊蕩者、廢土暗法師和廢土刺客在{area:976}東南方、強盜的南邊紮營。南方營地中央的{npc:7847}留到之後再處理。\n小心：廢土遊蕩者在戰鬥外會一直保持潛行，所以你在營地開打時，隱藏的遊蕩者可能會加入。",

	-- Step 10: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "沿著海岸向南前往海盜灣。南海海盜擠滿了海灘和船隻：沿著邊緣推進，一次拉一隻。{npc:7883}站在另一頭；{npc:7881}被偷的貨物在營地裡。\n小心：{npc:7883}身邊站著兩三個海盜，戰鬥一開始，城裡還會有更多海盜加入。",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "",

	-- Step 11: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "",

	-- Step 12: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "",

	-- Step 14: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "{area:979}旁的水池",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "向西北騎往{area:979}的沙怒食人妖營地。在水池邊緣使用{item:8584}；食人妖站得很近，先拉最近的。",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "會給你{item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "{area:979}旁的水池",

	-- Step 15: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the pool.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978}是五人地城；這裡的相關任務是45到47級。它的大門在水池北邊約400碼處。\n裡面：聖甲蟲會掉落甲殼，每個沙怒食人妖都可能掉落{quest:3042}，{npc:7604}身上帶著{quest:2768}。",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865}：聖甲蟲，在裡面",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042}：沙怒食人妖，在裡面",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768}：{npc:7604}，在裡面",

	-- Step 17: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, on the north side of town."] = "你{area:978}的聖甲蟲殼：{npc:7876}，在城鎮北側。",

	-- Step 18: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "{quest:2768}：{npc:7407}，在水塔旁。",

	-- Step 19: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, in town."] = "{quest:3042}：{npc:7804}，在城裡。",

	-- Step 20: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "向南騎往{area:1938}的挖掘營地。{npc:7771}會給你一頂探測頭盔：戴上它就能看見{quest:3161}土堆，它們密集分布在營地周圍的沙地上，以及往西南方巨魔那邊。",

	-- Step 22: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 23: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager · {quest:3362} Thistleshrub Valley
	-- plural, as words: Dunemaul Ogres = {npc:5471} Dunemaul Ogre
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first.\nWhy the grind to 47: the {quest:3362} comes next, with mobs of 48-50 and quests of level 50. Grind it on the Dunemaul Ogres (45-46) at the compound's south end, the safer camp, not on the Brutes."] = "向西南騎往巨魔營地。裡面滿是砂槌蠻兵和砂槌執行者（46-48級）；{npc:12046}（49級）站在中央，周圍有守衛：先清掉守衛。\n為什麼要刷到47級：接下來是{quest:3362}，那裡的怪是48-50級，任務是50級。在營地南端較安全的營地刷砂槌巨魔（45-46級），不要刷砂槌蠻兵。",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "",
	-- {npc:5471} Dunemaul Ogre
	["grind on {npc:5471}, at the compound's south end"] = "刷{npc:5471}，在營地南端",

	-- Step 24: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "向南騎進{quest:3362}。灌木露水收集者會掉落腺體；只有一部分是飽滿的，所以保留飽滿的露水腺。長瘤的灌木獸和灌木塑根者也在山谷裡。灌木獸是48-50級，比你高：一次拉一隻。\n小心：這一帶其他的灌木怪是49-50級，而且到處遊蕩，很容易多拉到怪。",

	-- Step 25: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "護送{npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "小烏龜{npc:5955}躲在山谷北端。帶他回家找他的妻子{npc:6015}，她在{area:977}東邊的水邊：他走得很慢，沙漠的野獸會攻擊他，所以要保住他的性命。",

	-- Step 26: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 27: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 28: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "向南騎過{area:1938}前往{area:981}，也就是哈札里的隧道；謝申克的設備在深處。\n小心：有一隻蟲子守著設備。許多蟲子在隧道裡巡邏，有些是50級，所以戰鬥常常會引來額外的怪。",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "",

	-- Step 29: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}, next"] = "給{zone:1457}，接下來",

	-- Step 30: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飛往{area:442}",
	-- {zone:1457} Darnassus · {npc:7763} Curgle Cranklehop · {area:442} Auberdine · {area:150} Menethil Harbor · {area:348} Aerie Peak
	["{zone:1457} first, while you are on this side of the sea: Troyas' answer, {npc:7763}'s crate, Tyrande and the soil errand, then the boat from {area:442} to {area:150} and the gryphon to {area:348}."] = "趁你還在海的這一側，先去{zone:1457}：特洛亞斯的回覆、{npc:7763}的箱子、泰蘭妲和土壤的差事，然後從{area:442}搭船到{area:150}，再搭獅鷲前往{area:348}。",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}飛行管理員",

	-- Step 31: Teldrassil
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:3838} Vesprystus
	["Take the boat from {area:442}'s dock to {area:702}; {npc:3838}, the hippogryph master, stands on the rise just east of the landing: learn the flight path on the way up to the village."] = "從{area:442}的碼頭搭船前往{area:702}；角鷹獸管理員{npc:3838}站在碼頭東邊不遠的坡上：上坡前往村莊的路上學會飛行路線。",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}飛行管理員",

	-- Step 32: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}站在樓上，在{npc:7916}上方：從裡面走上去，箭頭無法分辨樓層。",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}的下一個差事要去{zone:1446}：跳過它。",
	-- {npc:7916} Erelas Ambersky · {zone:1425} Hinterlands
	["{npc:7916}: the feathers lie in the {zone:1425}, next"] = "{npc:7916}：羽毛在{zone:1425}，接下來",
	["the book on her table"] = "她桌上的書",

	-- Step 34: Temple of the Moon
	["Temple of the Moon"] = "月神殿",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "穿過傳送門進入{zone:1457}。月神殿在城市南部。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}，在她旁邊",

	-- Step 38: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}，在樹頂",

	-- Step 39: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 40: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "土壤來自{zone:1449}，稍後",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "前往{zone:1438}的傳送門",

	-- Step 43: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "搭船前往{area:150}",

	-- Step 44: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 45: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",

	-- Step 46: Hinterlands
	-- {area:348} Aerie Peak · {area:271} Southshore · {zone:1425} Hinterlands
	["No flight path to {area:348} yet: ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border."] = "還沒有{area:348}的飛行路線：沿道路從{area:271}向東北騎進{zone:1425}；{area:348}就在邊界過去不遠。",

	-- Step 47: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "",

	-- Step 50: Sprinkle's Secret Ingredient
	["Underwater"] = "在水下",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "從{area:976}飛往塞拉摩，搭船前往{area:150}，再飛往{area:1537}。訓練。",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "飛往{area:348}。{zone:1425}指南從這裡開始。",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "從{area:1108}的碼頭搭船前往羽月要塞並飛往{area:489}，然後向東騎過{zone:1441}，前往{area:439}上的{area:2240}。{npc:4454}和{npc:4630}在賽道旁的營地裡；{npc:4709}站在哥布林營地旁。",
	-- ["He runs off to keep Rizzle busy"] = "他跑去拖住瑞茲爾",
	-- ["Hearth to {area:976}."] = "用爐石回{area:976}。",
	-- ["Ride back west to {area:976}."] = "向西騎回{area:976}。",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "向西北騎往沙丘中的森提帕爾蟲巢。所有森提帕爾都可能掉落昆蟲肢體。",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "向東南騎離{area:439}進入{area:440}。{area:976}就在邊界內側。",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "向東南騎往{area:985}。{npc:7847}站在南方廢土營地的中央：先清掉他周圍的敵人。",
	-- ["Rizzle's plans"] = "瑞茲爾的設計圖",
	-- ["The Wanted poster by {npc:7882}"] = "{npc:7882}旁邊的通緝告示",
	-- ["Wastewander bandits"] = "廢土強盜",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "趁{npc:4709}拖住瑞茲爾說話時，他的設計圖就無人看守地放在賽道對面的地精營地裡。",
	-- ["for {zone:1457}: the route takes you there at 47"] = "交給{zone:1457}：路線會在47級時帶你去那裡",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}，在城鎮東側",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "{npc:7583}的下一種材料生長在{zone:1425}，而路線不會再帶你回來：跳過。",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "{npc:7881}的下一批貨要送回{area:35}：跳過。",
}
