-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}，給「沼澤之眼」加爾",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飛往{area:378}",
	["Crossroads flight master"] = "",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "在岔路往北走，前往巨魔村莊蕨牆村。",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}，在村莊南緣、道路進村的地方",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}在村莊東邊的{area:2302}等候。跟著他去找雷瑟，在爆發的戰鬥中保住他的性命。",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "伊格納茲",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "黑鰭魚人",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "黑鰭魚人聚集在{area:502}東邊和東北方的海岸；每一種都會掉落頭顱。",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "「沼澤之眼」加爾",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "加爾住在{area:502}東南方的{area:497}。",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}，在莊園旁",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}，現在{npc:4791}已經讀過報告了",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "僅限你帶著{item:3853}時（{skill:164}或拍賣場）",

	-- Step 18: The Theramore Docks
	["Underwater"] = "",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 20: Level 37.5
	["Level 37.5"] = "",
	-- {zone:1443} Desolace · {area:1316} Razorfen Downs · {area:796} Scarlet Monastery
	["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "",
	["Darkmist cavern"] = "",
	-- {npc:4377} Darkmist Lurker
	["grind on {npc:4377}"] = "",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "",
	-- {npc:3391} Gazlowe · {area:35} Booty Bay
	["{npc:3391}'s next errand takes you to {area:35}, off this part of the route: leave it."] = "",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "",

	-- Step 26: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}在{area:596}西側的哥布林營地等候。",

	-- Step 31: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 32: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard
	["North to the goblin camp on the west side of the {area:596}."] = "",

	-- Step 34: Shadowprey
	["Shadowprey"] = "",
	["West to Shadowprey."] = "",

	-- Step 35: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 36: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飛行管理員",

	-- Step 37: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",

	-- Step 39: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "",

	-- Step 40: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "暗牙蜘蛛",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "交給{object:3202}的{npc:2519}，在下一份指南",
	-- ["Hearth to Shadowprey"] = "用爐石回葬影村",
	-- ["Hearth to {area:392}"] = "用爐石回{area:392}",
	-- ["Kodo bones and ghosts"] = "科多獸骨與幽靈",
	-- ["Maraudine totems"] = "瑪洛迪圖騰",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "撿起散落在墳場各處的科多獸骨，並在骨頭之間使用{item:15848}：它吸引來的幽靈會掉落幽靈電漿。",
	-- ["Ride back west to Brackenwall with the head."] = "帶著頭顱向西騎回蕨牆村。",
	-- ["Ride east back to the {area:497}."] = "向東騎回{area:497}。",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "從{area:378}沿著道路向東騎進沼澤。燒毀的{area:403}就在過了邊界不遠的路旁；盾牌、徽章和蹄印都在廢墟裡和廢墟旁。",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "向東騎往{area:602}。在每個惡魔傳送門旁使用放逐之杖，關閉其中六個。",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "從集會所向北騎往{area:597}的{npc:5412}。",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "向北騎往{area:502}。伊格納茲站在山腳下；他在山南邊採集泥豆葉時護送他。",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "沿著道路向北騎，前往墳場北邊路旁的小屋。",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "向東北騎往{area:607}。{npc:12277}被關在瑪洛迪半人馬的營地裡；釋放她，並護送她往東離開山谷。",
	-- ["Ride on south-west to Shadowprey."] = "繼續向西南騎往葬影村。",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "從{area:2405}向南騎進{area:607}。瑪洛迪斥候、瑪洛迪爭鬥者、瑪洛迪虐待者、瑪洛迪逐風者和瑪洛迪掠奪者（36-39級）會掉落{quest:93225}。",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "向西騎回沼澤另一頭。蕨牆村北邊山脊上的暗牙毒蜘蛛會掉落毒囊。塞拉摩間諜（35-36級）在同一片樹林中潛行：他們處於潛行狀態，要仔細看。",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "向西騎往西北海岸{area:2405}的{npc:11863}塔樓。",
	-- ["Slitherblade coast"] = "滑刃海岸",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "燃刃氏族佔據{area:2407}西北方的堡壘。對堡壘中的{npc:11876}使用{item:14523}，取得{item:13542}。",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "暗霧蜘蛛聚集在蕨牆村西北方的洞穴入口；每一種都會掉落眼球。",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃納迦佔據{area:2405}北邊直到{area:598}的海岸。{npc:12369}守護著最北端的{quest:6027}。",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "商隊的終點是{area:596}東側{npc:11596}的營地。",
	-- ["The next guide takes you back to {zone:1434}."] = "下一份指南會帶你回到{zone:1434}。",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}的商隊停在{area:602}邊緣的道路上。護送商隊向東經過集會所；惡魔會攻擊兩次。",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}和{npc:5412}站在{npc:11596}營地西邊的哨站裡。",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
}
