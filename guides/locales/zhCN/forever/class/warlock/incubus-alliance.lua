-- Chinese (simplified) (zhCN): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Alliance)"] = "魅魔与夜魔（联盟）",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "20级时：魅魔，以及无限服务器特有的夜魔——魅魔的男性孪生恶魔，各附带一个装灵魂碎片的灵魂袋。",

	-- Step 1: Gakin's Summons (Gnomes)
	-- {quest:1717} Gakin's Summons
	["{quest:1717} (Gnomes)"] = "{quest:1717}（侏儒）",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram
	["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257}."] = "达到 20 级后，{zone:1455} 的 {object:32383} 中的术士训练师 {npc:6120} 会让你去找 {zone:1453} 的 {npc:6122}。乘坐 {area:2257} 前往。",

	-- Step 2: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:150} Menethil Harbor · {zone:1445} Dustwallow Marsh · {area:35} Booty Bay · {area:392} Ratchet
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {area:150} to Theramore and head west through {zone:1445}, or the boat from {area:35} to {area:392}."] = "20 级时，{object:2101} 的 {object:2164} 地窖内的 {npc:6122} 会让你去 {zone:1413} 找 {npc:6244}：联盟要走很远。可从 {area:150} 乘船到塞拉摩，再向西穿过 {zone:1445}；也可以从 {area:35} 乘船到 {area:392}。",

	-- Step 3: Takar the Seer
	-- {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {npc:6247} Doan Karhan · {item:6898} Orb of Soran'ruk
	["{npc:6244} camps at a tent with a campfire just north-east of {area:378}, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "{npc:6244} 在 {area:378} 东北方不远的岔路口旁，营火边的帐篷处扎营：这里是部落地盘，要从东边进入，避开陶拉祖的守卫。他身旁的 {npc:6247} 会开启 {item:6898} 的任务。塔卡尔提供两条分支：两条都接。",
	["the succubus"] = "魅魔",
	["the incubus"] = "男魅魔",

	-- Step 4: Heartswood
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {zone:1439} Darkshore · {quest:1738} Heartswood · {npc:6122} Gakin the Darkbinder
	["Ordil'Aran lies in north-west {zone:1440}, north of {area:415} along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "奥迪拉兰位于 {zone:1440} 西北部，在 {area:415} 以北、通往 {zone:1439} 的道路沿线。约二十名黑暗深渊教徒占据了大树周围的废墟：沿外墙走，在允许的最远距离点击 {quest:1738}。任务要交还给 {npc:6122}，不是塔卡尔。",

	-- Step 5: The Wooden Figurine
	-- {item:190309} Wooden Figurine
	["The {item:190309}"] = "{item:190309}",
	-- {zone:1440} Ashenvale · {area:413} Maestra's Post · {quest:1738} Heartswood · {item:190307} Unlit Torch · {object:29784} Basic Campfire · {area:414} Zoram Strand · {item:190308} Burning Torch
	["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {area:413}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on {area:414}), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "这所房子独自坐落在 {zone:1440} 西北的树林中，在奥迪拉兰西北、{area:413} 以北很远的地方：与 {quest:1738} 一趟做完。从屋外桌子上取走 {item:190307}，在营火处点燃（自己生的 {object:29784}，或 {area:414} 上塔伦的营火），然后直接返回：{item:190308} 五分钟后就会燃尽，因此在屋旁自己生火最快。没有它，屋内的身影会阻止你。雕像在楼上。",
	-- {item:190307} Unlit Torch
	["{item:190307}, on the table outside"] = "{item:190307}，在外面的桌上",
	-- {item:190309} Wooden Figurine
	["{item:190309}, upstairs"] = "楼上的 {item:190309}。",

	-- Step 6: The Binding: succubus
	-- {quest:1739} The Binding
	["{quest:1739}: succubus"] = "{quest:1739}：魅魔",
	-- {npc:6122} Gakin the Darkbinder · {quest:1738} Heartswood · {item:6913} Heartswood Core
	["Back to {npc:6122} with the {quest:1738}. He hands you the {item:6913}: take the stairs behind him down to the crypt; part way along the lowest corridor a side stair on the left leads to the room with the purple circle. Stand on it and use the core. Summon your voidwalker first and keep the succubus (level 20, not elite) on the circle, or the guards may kill her and the kill does not count. If she wins, use the core again; keep it, {npc:6122} takes it back."] = "带着 {quest:1738} 回去找 {npc:6122}。他会给你 {item:6913}：从他身后的楼梯下到地穴，沿最底层的走廊前进，途中左侧的支路楼梯通往有紫色法阵的房间。站在法阵上使用核心。先召出虚空行者，并将魅魔（20级，非精英）留在法阵上，否则守卫可能会杀死她，导致不计数。如果战斗失败，就再次使用核心；保留核心，{npc:6122} 会收回它。",
	-- {item:6913} Heartswood Core
	["{item:6913}, on the circle in the crypt"] = "{item:6913}，在墓穴内的法阵上",

	-- Step 7: The Binding: incubus
	-- {quest:65603} The Binding
	["{quest:65603}: incubus"] = "{quest:65603}：梦魇",
	-- {item:190309} Wooden Figurine · {npc:6122} Gakin the Darkbinder
	["Give Gakin the figurine, then use the {item:190309} at the middle of the same circle and defeat the incubus it calls (level 20, not elite; it can charm you) with your voidwalker tanking. Keep the figurine: {npc:6122} takes it back."] = "把雕像交给黑暗缚灵者加科因，然后在同一个法阵的中央使用{item:190309}，让虚空行者抗住伤害，击败召出的夜魔（20级，非精英；会魅惑你）。保留雕像：要交还给{npc:6122}。",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in the crypt"] = "{npc:185335}，位于墓穴中的法阵旁。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "第二个魅惑恶魔——男性萨亚德，以及一个装灵魂碎片的灵魂碎片袋。",
	-- ["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "20级时，{object:2101}{object:2164}地下室的{npc:6122}会让你去找{zone:1413}的{npc:6244}。",
	-- ["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "回到{object:2164}找{npc:6122}。把木雕放在他下方地穴的召唤法阵上，击败召唤出的夜魔。",
	-- ["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "从{area:415}沿道路向西前往{area:413}：木雕在哨站北边树林间的一座房子里。",
	-- ["Incubus (Alliance)"] = "夜魔（联盟）",
	-- ["{npc:6122}: he binds the incubus to you"] = "{npc:6122}：他将夜魔与你绑定",
	-- ["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244}在{zone:1413}南部扎营，位于{area:378}东北方道路的东侧：从东边接近，避开部落守卫。",
}
