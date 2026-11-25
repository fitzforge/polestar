-- Chinese (traditional) (zhTW): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Alliance)"] = "魅魔與夜魔（聯盟）",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "20級時：魅魔，以及Forever伺服器特有的夜魔——魅魔的男性孿生惡魔，各附帶一個裝靈魂碎片的靈魂袋。",

	-- Step 1: Gakin's Summons (Gnomes)
	-- {quest:1717} Gakin's Summons
	["{quest:1717} (Gnomes)"] = "{quest:1717}（地精）",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram
	["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257}."] = "20級時，{zone:1455}的{object:32383}裡的術士訓練師{npc:6120}派你去{zone:1453}的{npc:6122}處。乘坐{area:2257}。",

	-- Step 2: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:150} Menethil Harbor · {zone:1445} Dustwallow Marsh · {area:35} Booty Bay · {area:392} Ratchet
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {area:150} to Theramore and head west through {zone:1445}, or the boat from {area:35} to {area:392}."] = "20級時，{object:2101}{object:2164}地下室的{npc:6122}會派你去{zone:1413}找{npc:6244}：對聯盟來說路途遙遠。從{area:150}搭船到塞拉摩再向西穿過{zone:1445}，或從{area:35}搭船到{area:392}。",

	-- Step 3: Takar the Seer
	-- {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {npc:6247} Doan Karhan · {item:6898} Orb of Soran'ruk
	["{npc:6244} camps at a tent with a campfire just north-east of {area:378}, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "{npc:6244}在{area:378}東北不遠處、一個路口旁的帶營火帳篷紮營：那是部落地盤，所以從東邊進入，避開陶拉祖衛兵。他身旁的{npc:6247}會開啟{item:6898}。塔卡爾提供兩個分支：都接。",
	["the succubus"] = "魅魔",
	["the incubus"] = "男魅魔",

	-- Step 4: Heartswood
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {zone:1439} Darkshore · {quest:1738} Heartswood · {npc:6122} Gakin the Darkbinder
	["Ordil'Aran lies in north-west {zone:1440}, north of {area:415} along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "奧狄爾阿蘭位於{zone:1440}西北，在{area:415}以北、通往{zone:1439}的路上。約二十名暗灘教徒佔據著大樹周圍的廢墟：貼著外牆走，儘量在能點的最遠處點選{quest:1738}。它交給{npc:6122}，不是交給塔卡爾。",

	-- Step 5: The Wooden Figurine
	-- {item:190309} Wooden Figurine
	["The {item:190309}"] = "{item:190309}",
	-- {zone:1440} Ashenvale · {area:413} Maestra's Post · {quest:1738} Heartswood · {item:190307} Unlit Torch · {object:29784} Basic Campfire · {area:414} Zoram Strand · {item:190308} Burning Torch
	["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {area:413}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on {area:414}), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Throw the lit torch onto the archaeologist's cart outside the house: that draws the figure in the house away, and you take the figurine upstairs unseen."] = "房子孤零零地立在{zone:1440}西北部的樹林中，在奧狄爾阿蘭西北、{area:413}以北很遠處：和{quest:1738}在同一趟完成。拿起屋外桌上的{item:190307}，在營火上點燃（你自己的{object:29784}，或{area:414}上塔倫的火），然後直接回去：{item:190308}五分鐘後就會熄滅，所以在房子旁自己生火最快。把點燃的火把丟到房子外面考古學家的推車上：這會引開屋裡的人影，你就能不被發現地到樓上拿走小雕像。",
	-- {item:190307} Unlit Torch
	["{item:190307}, on the table outside"] = "{item:190307}，在外面桌上",
	-- {item:190309} Wooden Figurine
	["{item:190309}, upstairs"] = "{item:190309}，樓上",

	-- Step 6: The Binding: succubus
	-- {quest:1739} The Binding
	["{quest:1739}: succubus"] = "{quest:1739}：魅魔",
	-- {npc:6122} Gakin the Darkbinder · {quest:1738} Heartswood · {item:6913} Heartswood Core
	["Back to {npc:6122} with the {quest:1738}. He hands you the {item:6913}: take the stairs behind him down to the crypt; part way along the lowest corridor a side stair on the left leads to the room with the purple circle. Stand on it and use the core. Summon your voidwalker first and keep the succubus (level 20, not elite) on the circle, or the guards may kill her and the kill does not count. If she wins, use the core again; keep it, {npc:6122} takes it back."] = "帶著{quest:1738}回到{npc:6122}處。他交給你{item:6913}：從他身後的樓梯下去進入墓穴；沿最下面的走廊走一段，左側有一道側梯通往帶紫色法陣的房間。站上去，使用寶珠。先召喚你的虛空行者，讓魅魔（20級，非精英）留在法陣上，否則衛兵可能殺死她，擊殺就不算數。如果她贏了，再次使用寶珠；留著它，{npc:6122}會收回去。",
	-- {item:6913} Heartswood Core
	["{item:6913}, on the circle in the crypt"] = "{item:6913}，在墓穴法陣上",

	-- Step 7: The Binding: incubus
	-- {quest:65603} The Binding
	["{quest:65603}: incubus"] = "{quest:65603}：男魅魔",
	-- {item:190309} Wooden Figurine · {npc:6122} Gakin the Darkbinder
	["Give Gakin the figurine, then use the {item:190309} at the middle of the same circle and defeat the incubus it calls (level 20, not elite; it can charm you) with your voidwalker tanking. Keep the figurine: {npc:6122} takes it back."] = "把小雕像交給加金，然後在同一個法陣中央使用{item:190309}，擊敗它召喚的男魅魔（20級，非精英；它會魅惑你），讓虛空行者扛。留著雕像：{npc:6122}會收回去。",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in the crypt"] = "{npc:185335}，在墓穴法陣旁",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "第二種誘惑型惡魔，也就是男性的魅魔，還有一個用來裝靈魂碎片的靈魂碎片包。",
	-- ["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "回到{object:2164}的{npc:6122}處。把小雕像放在他下方地穴的召喚法陣上，擊敗它召喚出的夢魔。",
	-- ["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "從{area:415}沿著道路向西前往{area:413}：小雕像在前哨站北邊樹林中的一間房子裡。",
	-- ["Incubus (Alliance)"] = "夢魔（聯盟）",
	-- ["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {area:413}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on {area:414}), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "那座房子孤零零地立在{zone:1440}西北的樹林中，在奧狄爾阿蘭西北、{area:413}以北很遠處：與{quest:1738}同一次出門做掉。從外面的桌上拿{item:190307}，在營火處點燃（自己擺一個{object:29784}，或用{area:414}上塔倫的火），然後立刻回去：{item:190308}五分鐘後燒完，所以在房子旁邊自己生一堆火最快。沒有它，屋裡的那個人偶會攔住你。雕像在樓上。",
	-- ["{npc:6122}: he binds the incubus to you"] = "{npc:6122}：他會把夢魔束縛給你",
	-- ["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244}在{zone:1413}南部、{area:378}東北方道路的東邊紮營：從東邊過去，避開部落守衛。",
}
