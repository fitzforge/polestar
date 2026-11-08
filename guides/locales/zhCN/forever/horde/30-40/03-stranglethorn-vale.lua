-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["{object:176946} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {zone:1454} Orgrimmar
	["Fly from {object:176946} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to {zone:1454} from there."] = "",

	-- Step 3: Back to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Back to {zone:1454}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 6: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",

	-- Step 7: Grom'gol
	["The zeppelin lands at the tower on the west side of the camp."] = "飞艇降落在营地西侧的塔上。",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}：交给阿拉希高地，路线后面会去",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的营地",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "沿道路向北离开{object:3202}；奈辛瓦里的狩猎营地在河东北边的山上。从现在起，留着拾取到的每一页{quest:338}：{npc:716}之后会要。",

	-- Step 9: Nesingwary's Expedition: kill these as you meet them
	["Nesingwary's Expedition: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 10: Booty Bay
	-- {object:3204} Booty Bay (no name in this language: may be words) · {npc:2858} Gringer
	["Follow the road south to {object:3204} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	["Upstairs"] = "",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["{object:3204} flight master"] = "",

	-- Step 12: Grom'gol
	-- {npc:2497} Nimboya · {object:3202} Grom'gol
	["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "",

	-- Step 14: The camp by the river
	["The camp by the river"] = "河边的营地",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}失踪猎人的营地就是奈辛瓦里的营地：在帐篷间走一圈，调查就会完成。淡水鳄趴在营地下方的河边。",

	-- Step 16: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by Lake Nazferiti, south-east of the camp."] = "",

	-- Step 17: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "深喉猎豹要很久以后才会遇到，在{object:3202}附近",

	-- Step 18: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "老年猛虎和鞭尾迅猛龙",
	-- {object:3202} Grom'gol
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 19: Nesingwary's camp
	["Back north to the camp."] = "向北回到营地。",

	-- Step 20: The Savage Coast: kill these as you meet them
	["The Savage Coast: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 22: Level 35
	["Level 35"] = "",
	-- {object:3204} Booty Bay (no name in this language: may be words) · {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{object:3204}'s and {object:3202}'s next quests are 35-38. Below 35? The Lashtail Raptors (35) hunt the slopes south of the camp, on your way back to {object:3202}: kill them until level 35. Or, with a group, run the Scarlet Monastery dungeon (Library or Armory) instead."] = "",
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "",

	-- Step 23: Fly to Booty Bay
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Fly to {object:3204}"] = "",
	-- {object:3202} Grom'gol · {object:3204} Booty Bay (no name in this language: may be words)
	["Head south down the coast to {object:3202} and fly to {object:3204}."] = "",

	-- Step 24: Fly to Grom'gol
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}, beside the flight master: the Shadowmaw and tigress parts come after the trolls"] = "",

	-- Step 25: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "鞭尾迅猛龙（35-36级）在{object:3202}东北不远的丛林里捕猎。",

	-- Step 26: The Vile Reef
	-- {item:4094} Tablet Shard
	["North-west of Grom'gol the Vile Reef lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "",
	["Underwater"] = "",

	-- Step 27: Ruins of Zul'Kunda: kill these as you meet them
	["Ruins of Zul'Kunda: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "",

	-- Step 29: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 30: Green Hills pages
	["Green Hills pages"] = "荆棘谷的青山书页",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}的每一页从血顶巨魔和劈颅巨魔身上的掉率约为1%；留着拾取到的每一页，其余的去拍卖行找。{npc:716}会在本指南稍后收取各章节。",

	-- Step 31: Shadowmaw panthers
	["Shadowmaw panthers"] = "深喉猎豹",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "深喉猎豹（37-38级）在莫什奥格山丘东边和东北方通往湖泊的丛林里潜行；它们会从潜行中发动攻击。沿途拾取你找到的每一页荆棘谷的青山。",

	-- Step 32: Venture Co. camp
	["Venture Co. camp"] = "风险投资公司营地",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north to Lake Nazferiti, south-east of Nesingwary's camp: the Venture Co. Geologists (34-36) work the camps by the lake and carry the Tumbled Crystals."] = "",

	-- Step 33: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "莫什奥格营地",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "莫什奥格食人魔在{object:3202}正东的山丘上扎营。杀死一个莫什奥格蛮兵和一个莫什奥格巫医（36-37级）；一次引一个。",

	-- Step 34: Level 36
	["Level 36"] = "",
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Below 36? Keep killing the Mosh'Ogg Brutes and Witch Doctors here until level 36; pull one at a time. Or, with a group, run the Scarlet Monastery dungeon (Armory) or the Razorfen Downs dungeon instead."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "",

	-- Step 35: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "返回{object:3202}。",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "",
}
