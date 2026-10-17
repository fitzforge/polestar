-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飛往{area:42}",
	-- {area:35} Booty Bay
	["Gyll, {area:35}"] = "蓋爾，{area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "從{area:42}沿道路向東穿過{zone:1430}進入{zone:1435}；衛兵比格斯守在入口不遠處的道路岔口。{npc:217412}站在他北邊不遠處。",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}：在阿拉希高地、{zone:1443}和荊棘谷各抓一隻小動物",

	-- Step 3: The western swamp
	["The western swamp"] = "西部沼澤",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "小鹽齒鱷魚、沼澤紡絲蛛和沼澤虎都在道路周圍的沼澤遊蕩。",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "失事的商隊在衛兵比格斯附近的路邊。",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德萊尼人那裡。",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "沿道路向東前往{area:76}。{npc:256028}怪物會掉落水晶；木棒諾博魯在廢墟中走動，會掉落他的木棒。",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391}被關在聖所北端的籠子裡。釋放他並在走出去的路上保護他；之後他的保險箱就在路邊。",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "向西穿過{zone:1430}回到{area:42}。",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}，{area:17203}的路上",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}，光明大教堂",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}，城堡裡的皇家圖書館",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}在{object:2101}{object:2164}的地窖裡等著。在那裡的召喚法陣使用{item:6913}，擊敗召喚出的魅魔。如果你接了{quest:65602}，也把{item:190309}交給他，放在同一個法陣並擊敗夢魘。",
	["Subdue the succubus"] = "制服魅魔",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}，如果你有接",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}，在同一個法陣",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}會把夢魘束縛給你",

	-- Step 14: Shaman training
	["Shaman training"] = "薩滿訓練",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習。{object:32372}的{npc:1573}也能飛往{area:271}。",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "一個{npc:2434}隱身潛伏在{area:271}邊緣；殺死他並閱讀他身上的契約。",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "沿道路從{area:287}向東越過{area:1057}前往{area:320}。",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "辛迪加佔據{area:320}西北方的農場。一隻{npc:217589}在農場裡爬來爬去：用{npc:217412}的昆蟲學入門套件抓一隻，然後勾選完成。",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}：抓住牠，用於{quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "沿道路向南過橋，前往{zone:1437}那一端的{area:205}，{npc:1075}在那裡等著。",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "伊貝尼瑟的屍體",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "走回橋上：伊貝尼瑟的屍體在橋的阿拉希那一端下方。",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿海岸向西前往哥布林的海灣；哨兵魯魯在上方的岩石上守望。",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "菲茲索普教授",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "護送教授到海灣北邊的海灘，在他工作時保護他；納迦會一波波來襲。",

	-- Step 26: The wrecks
	["The wrecks"] = "沉船",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "兩艘沉船在海灣西邊的海灣裡。海圖和航海日誌在船內；寶石散落在周圍的海床上。刺脊納迦在整個海灣游動。",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "給{area:35}的{npc:2487}：先留著",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向東北騎回去經過{area:320}；{npc:2712}和{npc:2713}在{area:314}北邊的丘陵紮營。",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "被遺忘者信差帶著兩名守衛走在{area:314}西邊的道路上；把他們拉離道路。",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}與{npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}的差事",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "跟著{npc:2713}潛入{area:314}再回來；途中部落獸人會突襲你。",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "給{area:271}的{npc:2711}",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "向北經過{area:314}；碎片在{area:333}旁的山丘上閃閃發光。",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "只有在荊棘谷的戈魯格爾給了你墜飾時",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "枯鬚狗頭人在{area:321}（部落）東邊的峽谷中挖掘；從北邊繞過城鎮。他們會掉落微粒和克拉澤克要的礦石。",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "碎片在{area:318}的最深處。",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "枯木食人妖住在{area:314}南邊的丘陵；枯木巫醫站在村子裡，枯木暗影獵手守在山谷遠端。",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "每把鑰匙都在高地的一處立石圈：碎片東邊、{area:320}附近，以及西部。{object:2702}在{area:320}西邊。",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "巨魔法師{npc:2793}佔據枯木山谷南端的洞穴。",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "沿道路從{area:271}向北進入山區。山地獅在山坡上遊蕩；{area:280}的辛迪加戴著圖章戒指，{npc:2306}在鎮北側的莊園庭院走動。",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "破碎嶺巨魔",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "破碎嶺巨魔佔據{area:280}北邊的丘陵。再往北，一個破舊的木箱裡有{item:3706}；{quest:537}的{npc:2320}就站在旁邊。",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "書卷在{area:280}西邊的城堡廢墟中；暗影大法師佔據著廢墟。",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}：破碎嶺巨魔",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}"] = "{item:3659}：{object:1760}",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}西邊湖岸的祈倫托營地，就在越過邊界進入{zone:1421}之處：{npc:269127}站在那裡。大法師安斯雷姆·魯因維沃爾站在它東南方的穹頂旁。",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "給{area:35}的{npc:2542}：先留著",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "如果你沒有，向{npc:2381}購買{npc:2438}的披風所需的{item:2321}",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "給{zone:1453}的{npc:1440}：先留著",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "從{zone:1455}走隧道向東穿過{zone:1426}進入{zone:1432}，沿道路前往{area:144}。",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "沿湖向東南前往挖掘場。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德萊尼人那裡。",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}，在達拉然城內",
}
