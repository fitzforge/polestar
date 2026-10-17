-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mirage Raceway
	-- {area:1108} Forgotten Coast · {area:489} Thalanaar · {zone:1441} Thousand Needles · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "從{area:1108}的碼頭搭船前往羽月要塞並飛往{area:489}，然後向東騎過{zone:1441}，前往{area:439}上的{area:2240}。{npc:4454}和{npc:4630}在賽道旁的營地裡；{npc:4709}站在哥布林營地旁。",
	["He runs off to keep Rizzle busy"] = "他跑去拖住瑞茲爾",

	-- Step 2: Rizzle's plans
	["Rizzle's plans"] = "瑞茲爾的設計圖",
	-- {npc:4709} Zamek
	["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "趁{npc:4709}拖住瑞茲爾說話時，他的設計圖就無人看守地放在賽道對面的地精營地裡。",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "向東南騎離{area:439}進入{zone:1446}。{area:976}就在邊界內側。",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}，在城鎮北側",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}，在水塔旁",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}，在他旁邊",

	-- Step 5: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "向東騎過沙丘，前往東北海岸的哥布林港口。",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern"] = "{npc:7881}，在港口的旅店裡",
	["The Wanted poster beside him"] = "他旁邊的通緝告示",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "同一張告示：{npc:7847}要很久以後才會出現，在{area:976}之後",

	-- Step 6: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "沿著海岸向南前往海盜灣。南海海盜擠滿了海灘和船隻：沿著邊緣推進，一次拉一隻。{npc:7883}站在另一頭；{npc:7881}被偷的貨物在營地裡。",

	-- Step 7: Steamwheedle Port
	-- {npc:7881} Stoley · {area:35} Booty Bay
	["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "{npc:7881}的下一批貨要送回{area:35}：跳過。",

	-- Step 8: Wastewander bandits
	["Wastewander bandits"] = "廢土強盜",
	-- {area:976} Gadgetzan
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "向西騎回{area:976}。廢土強盜和廢土竊賊佔據沿途的沙丘；他們都可能帶著水袋。",

	-- Step 10: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "更強的廢土遊蕩者、廢土暗法師和廢土刺客在{area:976}東南方、強盜的南邊紮營。南方營地中央的{npc:7847}留到之後再處理。",

	-- Step 11: Gadgetzan
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}：他的箱子要送到{area:702}，稍後",

	-- Step 12: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "{area:979}旁的水池",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "向西北騎往{area:979}的沙怒食人妖營地。在水池邊緣使用{item:8584}；食人妖站得很近，先拉最近的。",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "會給你{item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "{area:979}旁的水池",

	-- Step 14: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "{area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "向南騎往{area:1938}的挖掘營地。{npc:7771}會給你一頂探測頭盔：戴上它就能看見{quest:3161}土堆，它們密集分布在營地周圍的沙地上，以及往西南方巨魔那邊。",

	-- Step 15: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "向西南騎往巨魔營地。裡面滿是砂槌蠻兵和砂槌執行者（46-48級）；{npc:12046}（49級）站在中央，周圍有守衛：先清掉守衛。",

	-- Step 16: The Noxious Lair
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "向西北騎往沙丘中的森提帕爾蟲巢。所有森提帕爾都可能掉落昆蟲肢體。",

	-- Step 17: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "向南騎進{quest:3362}。灌木露水收集者會掉落腺體；只有一部分是飽滿的，所以保留飽滿的露水腺。長瘤的灌木獸和灌木塑根者也在山谷裡。灌木獸是48-50級，比你高：一次拉一隻。",

	-- Step 18: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "護送{npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "小烏龜{npc:5955}躲在山谷北端。帶他回家找他的妻子{npc:6015}，她在{area:977}東邊的水邊：他走得很慢，沙漠的野獸會攻擊他，所以要保住他的性命。",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "向西騎回{area:976}。",
	-- {npc:11758} Andi Lynn
	["{npc:11758}, on the east side of town"] = "{npc:11758}，在城鎮東側",
	-- {npc:7583} Sprinkle · {zone:1425} Hinterlands
	["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "{npc:7583}的下一種材料生長在{zone:1425}，而路線不會再帶你回來：跳過。",

	-- Step 20: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "向東南騎往{area:985}。{npc:7847}站在南方廢土營地的中央：先清掉他周圍的敵人。",

	-- Step 21: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "向南騎過{area:1938}前往{area:981}，也就是哈札里的隧道；謝申克的設備在深處。",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}."] = "用爐石回{area:976}。",
	-- {zone:1457} Darnassus
	["for {zone:1457}: the route takes you there at 47"] = "交給{zone:1457}：路線會在47級時帶你去那裡",

	-- Step 23: Ironforge
	-- {area:976} Gadgetzan · {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "從{area:976}飛往塞拉摩，搭船前往{area:150}，再飛往{area:1537}。訓練。",

	-- Step 24: Aerie Peak
	-- {area:348} Aerie Peak · {zone:1425} Hinterlands
	["Fly to {area:348}. {zone:1425} guide starts here."] = "飛往{area:348}。{zone:1425}指南從這裡開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "飛往{area:348}。{zone:1425}指南從這裡開始。",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "向南騎過{area:1938}前往{area:981}，也就是哈札里的隧道；謝申克的設備在深處。",
	-- ["The Wanted poster by {npc:7882}"] = "{npc:7882}旁邊的通緝告示",
}
