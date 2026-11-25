-- Chinese (traditional) (zhTW): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412}與{quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; the Classic item choice may be gone in Forever."] = "50級時取得經驗值和金幣，最後在{area:1417}結束；經典版的物品選擇在Forever中可能已經沒有了。",
	["Experience and gold"] = "經驗值和金幣",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, asks for the four elements for {npc:6176}."] = "50級時，{object:172957}的薩滿訓練師{npc:13417}會要你為{npc:6176}收集四種元素。",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher · {quest:8410} Elemental Mastery · {quest:8412} Spirit Totem · {quest:8411} Mastering the Elements
	["At 50 {npc:3032}, a shaman trainer on {area:1640} in {zone:1456}, asks for the four elements for {npc:6176}. Skyborne: Forever's quest page lists {quest:8410} and {quest:8412} for Orcs, Tauren and Trolls only; if {npc:3032} has nothing for you, {npc:6176}'s own {quest:8411} is open to every Horde race, but {quest:8412} after it may still turn you away."] = "50級時，{zone:1456}{area:1640}上的薩滿訓練師{npc:3032}要你為{npc:6176}收集四種元素。空裔注意：Forever的任務頁面把{quest:8410}和{quest:8412}列為僅獸人、牛頭人和食人妖可接；如果{npc:3032}不給你任務，{npc:6176}自己的{quest:8411}對所有部落種族開放，但後續的{quest:8412}仍可能拒絕你。",

	-- Step 3: The four elements
	["The four elements"] = "四種元素",
	-- {item:7069} Elemental Air · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {area:333} Circle of East Binding · {npc:2794} Summoned Guardian · {zone:1447} Azshara · {npc:14269} Seeker Aqualon · {area:69} Lakeshire
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile · Rumbling Exiles = {npc:2592} Rumbling Exile · Burning Exiles = {npc:2760} Burning Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles at its stone circles (level 38-39, respawn under seven minutes): Thundering Exiles south-east of {area:320} (air), Rumbling Exiles south-west of it (earth) and Burning Exiles far to the north-west (fire), about one kill in eight to ten each, and Cresting Exiles at the {area:333} in the north-east (water, in about one in five of the corpses you can loot). Leave the {npc:2794} in the south-west alone: it is elite. Water also comes from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by {area:69} in Redridge."] = "{item:7069}、火、土和水各一個；這四種都能交易，所以拍賣場最快。要自己刷的話，{zone:1417}的石圈旁有流放者（38-39級，重生不到七分鐘）：雷霆流放者（{npc:2762}）在{area:320}東南（空氣），隆隆流放者（{npc:2592}）在其西南（土），燃燒流放者（{npc:2760}）在遠處的西北（火），每種大約八到十次擊殺一個；湧浪流放者（{npc:2761}）在東北的{area:333}（水，大約五具可拾取的屍體裡有一個）。別去碰西南的{npc:2794}：它是精英。水也可以從{zone:1447}的元素之水（五分之二），或赤脊山{area:69}旁的{npc:14269}取得。",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}：雷霆流放者",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}：烈焰流放者",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}：頑石流放者",
	-- {item:7070} Elemental Water · {zone:1447} Azshara
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:7070}: Cresting Exiles, or {zone:1447}'s water patches"] = "{item:7070}：湧浪流放者（{npc:2761}），或{zone:1447}的水坑",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the ruins of the east of {zone:1416}: from {area:272} follow the river east of town north into the hills."] = "{npc:6176}在{zone:1416}東部的廢墟中紮營：從{area:272}沿著城鎮東邊的河往北走進丘陵。",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "蜘蛛眼和熊爪",
	-- {area:813} Bulwark · {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {item:20610} Bloodshot Spider Eye · {spell:3427} Infected Wound · {item:20611} Thick Black Claw · {area:159} Brill
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear · Carrion Vultures = {npc:1809} Carrion Vulture · Plague Lurkers = {npc:1824} Plague Lurker
	["Eight of each. Fly or ride to the {area:813} and on to the west edge of the {zone:1422}, north-west of {area:3197}: the Venom Mist Lurkers (level 50-51, they poison) give the {item:20610} and the Diseased Black Bears (level 51-52, {spell:3427}) the {item:20611}, one kill in five each; the two Carrion Vultures there drop either. The bigger Diseased Grizzlies and Plague Lurkers further east almost never drop them. A few bears and lurkers also roam south-east of {area:159} in Tirisfal."] = "每種要八個。飛或騎到{area:813}，再前往{zone:1422}西緣、{area:3197}西北方：毒霧潛伏者（50-51級，帶毒）掉{item:20610}，染病黑熊（51-52級，{spell:3427}）掉{item:20611}，都是五次擊殺出一件；那裡的兩種食腐禿鷲兩種都會掉。更東邊個頭更大的染病灰熊和瘟疫潛伏者幾乎不掉。提里斯法{area:159}東南方也有少量熊和潛伏者遊蕩。",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {spell:139} Renew · {npc:3560} Healing Ward
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["A five-player dungeon: needs a group of five, about level 50-55. Fly to {area:75} and ride east. The {area:1417} ({area:1477}) stands in the middle of the {area:74}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. Two feathers of each colour, one from each of six elite troll mini-bosses (level 51-52) on the balconies around the temple's great round room, every kill, and each player on the quest loots their own: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Mijan heals the others ({spell:139}, a {npc:3560}): kill him first; Hukku summons guardians and throws Shadow Bolt Volleys."] = "一個五人地城：需要五人小隊，等級約50-55級。飛到{area:75}後向東騎。{area:1417}（{area:1477}）矗立在{area:74}中央：從廢墟南側的臺階上去，潛入被水淹沒的大廳，向下遊穿過去，沿臺階和通道一路向下走到傳送門。每種顏色的羽毛要兩根，分別出自神殿環形大廳周圍陽臺上的六個精英食人妖小首領（51-52級），每次擊殺必掉，且每個接了任務的玩家各自拾取：加什爾和琥珀色的{npc:5716}、胡庫和藍色的米詹、佐洛和綠色的洛若。米詹會治療其他首領（{spell:139}，一個{npc:3560}）：先殺他；胡庫會召喚守衛並投擲暗影箭雨。",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}: Gasher, {npc:5716}"] = "{item:20606}：加什爾、{npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}: Hukku, Mijan"] = "{item:20607}：胡庫、米詹",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}: Zolo, Loro"] = "{item:20608}：佐洛、洛若",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher
	["{npc:6176}: the old item choice may be gone, count on the experience"] = "{npc:6176}：舊版物品選擇獎勵可能已移除，指望經驗就好",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "50級時，{zone:1456}的薩滿訓練師{npc:3032}會派你去找{npc:6176}。",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "在{zone:1422}，毒霧潛伏者會掉落{item:20610}，生病的黑熊會掉落{item:20611}（各約五次擊殺一次）。",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}、元素火焰、元素大地和元素之水各一個。阿拉希高地的流亡者會掉落，每種流亡者掉落一種元素，大約每十次擊殺掉一個：雷霆流亡者（空氣）、燃燒流亡者（火焰）、隆隆流亡者（大地）和浪潮流亡者（水）。或者在拍賣場購買。",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}、火、土、水各一個。{zone:1417}的流放者會掉落，每種一個元素，約每十次擊殺一次：雷霆流放者（風）、烈焰流放者（火）、頑石流放者（土）和水浪流放者（水）。或在拍賣場購買。",
	-- ["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles near {area:320} (level 38-39, about one kill in eight to ten, respawn under seven minutes): Thundering Exiles south-east of it (air), Rumbling Exiles south-west (earth), Burning Exiles far to the north-west (fire), and the {npc:2794} far to the south-west (water, about one in seven). Water comes easier from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by {area:69} in Redridge."] = "{item:7069}、火焰、大地、流水各一份；四種都可以交易，所以拍賣行最快。要刷的話，{zone:1417}{area:320}附近有流放者元素（38-39級，約八到十次擊殺出一件，重新出現不超過七分鐘）：東南方的雷霆流放者（空氣）、西南方的轟鳴流放者（大地）、遠西北方的燃燒流放者（火焰），以及遠西南方的{npc:2794}（流水，約七分之一）。流水更容易從{zone:1447}的元素之水窪（五分之二）或赤脊山{area:69}旁的{npc:14269}獲得。",
	-- ["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "{area:1417}（{area:1477}）位於{area:74}之下；箭頭指向其入口。加什爾或{npc:5716}會掉落{item:20606}，胡庫或米杉，祖羅或洛若爾也是：六個都是裡面的精英食人妖。找小隊一起去。",
	-- ["{item:7070}: Cresting Exiles"] = "{item:7070}：水浪流放者",
	-- ["{item:7070}: the {npc:2794}, or {zone:1447}'s water patches"] = "{item:7070}：{npc:2794}，或{zone:1447}的水窪",
}
