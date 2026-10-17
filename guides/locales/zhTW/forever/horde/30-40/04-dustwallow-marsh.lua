-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飛往{area:378}",

	-- Step 2: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "從{area:378}沿著道路向東騎進沼澤。燒毀的{area:403}就在過了邊界不遠的路旁；盾牌、徽章和蹄印都在廢墟裡和廢墟旁。",

	-- Step 3: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "在岔路往北走，前往巨魔村莊蕨牆村。",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}，在村莊南緣、道路進村的地方",

	-- Step 4: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}在村莊東邊的{area:2302}等候。跟著他去找雷瑟，在爆發的戰鬥中保住他的性命。",

	-- Step 5: Stinky Ignatz
	["Stinky Ignatz"] = "伊格納茲",
	-- {area:502} Witch Hill
	["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "向北騎往{area:502}。伊格納茲站在山腳下；他在山南邊採集泥豆葉時護送他。",

	-- Step 6: Mirefin murlocs
	["Mirefin murlocs"] = "黑鰭魚人",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "黑鰭魚人聚集在{area:502}東邊和東北方的海岸；每一種都會掉落頭顱。",

	-- Step 7: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "「沼澤之眼」加爾",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "加爾住在{area:502}東南方的{area:497}。",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}，在莊園旁",

	-- Step 8: Darkfang spiders
	["Darkfang spiders"] = "暗牙蜘蛛",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator
	["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "向西騎回沼澤另一頭。蕨牆村北邊山脊上的暗牙毒蜘蛛會掉落毒囊。塞拉摩間諜（35-36級）在同一片樹林中潛行：他們處於潛行狀態，要仔細看。",

	-- Step 9: Darkmist Cavern
	["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "暗霧蜘蛛聚集在蕨牆村西北方的洞穴入口；每一種都會掉落眼球。",

	-- Step 11: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Ride east back to the {area:497}."] = "向東騎回{area:497}。",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "僅限你帶著{item:3853}時（{skill:164}或拍賣場）",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}，現在{npc:4791}已經讀過報告了",

	-- Step 12: Brackenwall Village
	["Ride back west to Brackenwall with the head."] = "帶著頭顱向西騎回蕨牆村。",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in the next guide"] = "交給{object:3202}的{npc:2519}，在下一份指南",

	-- Step 13: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "用爐石回{area:392}",

	-- Step 15: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "向東北騎往{area:607}。{npc:12277}被關在瑪洛迪半人馬的營地裡；釋放她，並護送她往東離開山谷。",

	-- Step 16: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}在{area:596}西側的哥布林營地等候。",

	-- Step 17: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:602} Mannoroc Coven
	["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}的商隊停在{area:602}邊緣的道路上。護送商隊向東經過集會所；惡魔會攻擊兩次。",

	-- Step 18: Scrabblescrew's Camp
	-- {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "商隊的終點是{area:596}東側{npc:11596}的營地。",

	-- Step 19: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane · {npc:11596} Smeed Scrabblescrew
	["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}和{npc:5412}站在{npc:11596}營地西邊的哨站裡。",

	-- Step 20: Kormek's Hut
	["Ride north up the road to the hut by the road north of the graveyard."] = "沿著道路向北騎，前往墳場北邊路旁的小屋。",

	-- Step 21: Kodo bones and ghosts
	["Kodo bones and ghosts"] = "科多獸骨與幽靈",
	-- {item:15848} Crate of Ghost Magnets
	["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "撿起散落在墳場各處的科多獸骨，並在骨頭之間使用{item:15848}：它吸引來的幽靈會掉落幽靈電漿。",

	-- Step 24: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "燃刃氏族佔據{area:2407}西北方的堡壘。對堡壘中的{npc:11876}使用{item:14523}，取得{item:13542}。",

	-- Step 25: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "向西騎往西北海岸{area:2405}的{npc:11863}塔樓。",

	-- Step 26: Slitherblade coast
	["Slitherblade coast"] = "滑刃海岸",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃納迦佔據{area:2405}北邊直到{area:598}的海岸。{npc:12369}守護著最北端的{quest:6027}。",

	-- Step 28: Maraudine totems
	["Maraudine totems"] = "瑪洛迪圖騰",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "從{area:2405}向南騎進{area:607}。瑪洛迪斥候、瑪洛迪爭鬥者、瑪洛迪虐待者、瑪洛迪逐風者和瑪洛迪掠奪者（36-39級）會掉落{quest:93225}。",

	-- Step 29: Shadowprey Village
	["Ride on south-west to Shadowprey."] = "繼續向西南騎往葬影村。",

	-- Step 30: Portals of the Legion
	-- {area:602} Mannoroc Coven
	["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "向東騎往{area:602}。在每個惡魔傳送門旁使用放逐之杖，關閉其中六個。",

	-- Step 31: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Ride north from the coven to {npc:5412} at {area:597}."] = "從集會所向北騎往{area:597}的{npc:5412}。",

	-- Step 32: Hearth to Shadowprey
	["Hearth to Shadowprey"] = "用爐石回葬影村",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "下一份指南會帶你回到{zone:1434}。",
}
