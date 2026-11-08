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
	["Experience and gold at 50, ending in the Sunken Temple; the Classic item choice may be gone in Forever."] = "",
	["Experience and gold"] = "經驗值和金幣",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, asks for the four elements for {npc:6176}."] = "",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {object:50495} Spirit Rise (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher · {quest:8410} Elemental Mastery · {quest:8412} Spirit Totem · {quest:8411} Mastering the Elements
	["At 50 {npc:3032}, a shaman trainer on {object:50495} in {zone:1456}, asks for the four elements for {npc:6176}. Skyborne: Forever's quest page lists {quest:8410} and {quest:8412} for Orcs, Tauren and Trolls only; if {npc:3032} has nothing for you, {npc:6176}'s own {quest:8411} is open to every Horde race, but {quest:8412} after it may still turn you away."] = "",

	-- Step 3: The four elements
	["The four elements"] = "四種元素",
	-- {item:7069} Elemental Air · {zone:1417} Arathi Highlands · {object:2685} Refuge Pointe (no name in this language: may be words) · {npc:2794} Summoned Guardian · {zone:1447} Azshara · {npc:14269} Seeker Aqualon
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile · Rumbling Exiles = {npc:2592} Rumbling Exile · Burning Exiles = {npc:2760} Burning Exile
	["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles near {object:2685} (level 38-39, about one kill in eight to ten, respawn under seven minutes): Thundering Exiles south-east of it (air), Rumbling Exiles south-west (earth), Burning Exiles far to the north-west (fire), and the {npc:2794} far to the south-west (water, about one in seven). Water comes easier from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by Lakeshire in Redridge."] = "",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}：雷霆流放者",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}：烈焰流放者",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}：頑石流放者",
	-- {item:7070} Elemental Water · {npc:2794} Summoned Guardian · {zone:1447} Azshara
	["{item:7070}: the {npc:2794}, or {zone:1447}'s water patches"] = "",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:6176} camps in the ruins of the east of {zone:1416}: from {object:1772} follow the river east of town north into the hills."] = "",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "蜘蛛眼和熊爪",
	-- {zone:1422} Western Plaguelands · {item:20610} Bloodshot Spider Eye · {item:20611} Thick Black Claw
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear · Carrion Vultures = {npc:1809} Carrion Vulture · Plague Lurkers = {npc:1824} Plague Lurker
	["Eight of each. Fly or ride to the Bulwark and on to the west edge of the {zone:1422}, north-west of Chillwind Camp: the Venom Mist Lurkers (level 50-51, they poison) give the {item:20610} and the Diseased Black Bears (level 51-52, Infected Wound) the {item:20611}, one kill in five each; the two Carrion Vultures there drop either. The bigger Diseased Grizzlies and Plague Lurkers further east almost never drop them. A few bears and lurkers also roam south-east of Brill in Tirisfal."] = "",

	-- Step 7: The Sunken Temple
	["The Sunken Temple"] = "",
	-- {npc:5716} Zul'Lor · {npc:3560} Healing Ward
	["A five-player dungeon: needs a group of five, about level 50-55. Fly to Stonard and ride east. The Sunken Temple (Temple of Atal'Hakkar) stands in the middle of the Pool of Tears: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. Two feathers of each colour, one from each of six elite troll mini-bosses (level 51-52) on the balconies around the temple's great round room, every kill, and each player on the quest loots their own: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Mijan heals the others (Renew, a {npc:3560}): kill him first; Hukku summons guardians and throws Shadow Bolt Volleys."] = "",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}: Gasher, {npc:5716}"] = "",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}: Hukku, Mijan"] = "",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}: Zolo, Loro"] = "",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher
	["{npc:6176}: the old item choice may be gone, count on the experience"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "50級時，{object:172957}的薩滿訓練師{npc:13417}會派你去找{npc:6176}。",
	-- ["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "50級時，{zone:1456}的薩滿訓練師{npc:3032}會派你去找{npc:6176}。",
	-- ["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "50級時取得經驗值和金幣，最後在{area:1417}結束；Forever移除了經典版的物品選擇。",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "在{zone:1422}，毒霧潛伏者會掉落{item:20610}，生病的黑熊會掉落{item:20611}（各約五次擊殺一次）。",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}、元素火焰、元素大地和元素之水各一個。阿拉希高地的流亡者會掉落，每種流亡者掉落一種元素，大約每十次擊殺掉一個：雷霆流亡者（空氣）、燃燒流亡者（火焰）、隆隆流亡者（大地）和浪潮流亡者（水）。或者在拍賣場購買。",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of {zone:1417} drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "{item:7069}、火、土、水各一個。{zone:1417}的流放者會掉落，每種一個元素，約每十次擊殺一次：雷霆流放者（風）、烈焰流放者（火）、頑石流放者（土）和水浪流放者（水）。或在拍賣場購買。",
	-- ["The {area:1417}"] = "{area:1417}",
	-- ["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "{area:1417}（{area:1477}）位於{area:74}之下；箭頭指向其入口。加什爾或{npc:5716}會掉落{item:20606}，胡庫或米杉，祖羅或洛若爾也是：六個都是裡面的精英食人妖。找小隊一起去。",
	-- ["{item:7070}: Cresting Exiles"] = "{item:7070}：水浪流放者",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176}在{zone:1416}東部、{area:272}東北方紮營。",
}
