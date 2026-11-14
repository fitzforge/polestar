-- Chinese (simplified) (zhCN): the guide forever/miscellaneous/cozy-sleeping-bag (forever/miscellaneous/cozy-sleeping-bag.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:211527} Cozy Sleeping Bag · {item:221498} Old Toolbox
	["A trail of hidden notes across both continents: the {item:211527} at the end, a 12-slot {item:221498} on the way."] = "沿着藏在两块大陆各处的纸条寻找线索：最终获得{item:211527}，途中还能拿到12格{item:221498}。",

	-- Step 1: The note in Westfall
	-- {zone:1436} Westfall
	["The note in {zone:1436}"] = "{zone:1436}的纸条",
	-- {zone:1436} Westfall
	["The chain opens at level 14. A burned-out campfire in western {zone:1436}, with a nailed plank beside it."] = "这条任务链14级开放。地点在 {zone:1436} 西部的一处熄灭营火旁，旁边有一块钉着钉子的木板。",

	-- Step 2: Its twin in the Barrens
	-- {zone:1413} Barrens
	["Its twin in the {zone:1413}"] = "{zone:1413}的另一处线索",
	-- {zone:1413} Barrens
	["The note's \"twin land\" is the {zone:1413}: the same burned-out campfire stands in the southern {zone:1413}."] = "纸条所说的另一片土地是{zone:1413}：同样燃尽的营火位于{zone:1413}南部。",

	-- Step 3: The note in the Barrens
	-- {zone:1413} Barrens
	["The note in the {zone:1413}"] = "{zone:1413}的纸条",
	-- {zone:1413} Barrens
	["The chain opens at level 14. A burned-out campfire in the southern {zone:1413}, with a nailed plank beside it."] = "这条任务链14级开放。起点是{zone:1413}南部一处烧尽的营火，旁边有块钉着钉子的木板。",

	-- Step 4: Along the coast to Westfall
	-- {zone:1436} Westfall
	["Along the coast to {zone:1436}"] = "沿海岸前往{zone:1436}",
	-- {object:3202} Grom'gol · {zone:1436} Westfall · {zone:1431} Duskwood
	["From {object:3202} follow Stranglethorn's west coast north to {zone:1436}, swimming where the beach runs out. It is shorter than the jungle road north and keeps you clear of Stranglethorn's level 30+ beasts and of {zone:1431}."] = "从{object:3202}沿荆棘谷西海岸向北前往{zone:1436}，没有沙滩的地方就游过去。这比向北走丛林道路更近，还能避开荆棘谷30级以上的野兽和{zone:1431}。",
	["Stranglethorn's west coast"] = "荆棘谷西海岸",

	-- Step 5: Its twin in Westfall
	-- {zone:1436} Westfall
	["Its twin in {zone:1436}"] = "{zone:1436}的另一处线索",
	-- {zone:1436} Westfall
	["The note's \"twin land\" is {zone:1436}: the same burned-out campfire stands in western {zone:1436}."] = "纸条所说的另一片土地是{zone:1436}：同样燃尽的营火位于{zone:1436}西部。",

	-- Step 6: Stonetalon from the north
	["Stonetalon from the north"] = "从北边进入石爪山脉",
	-- {zone:1413} Barrens · {area:1702} Honor's Stand · {area:2539} Malaka'jin · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {area:415} Astranaar · {area:1276} Talondeep Path · {zone:1440} Ashenvale
	["{zone:1413}' way into Stonetalon runs through {area:1702}, and the road on to the hills passes {area:2539} and {area:460}: all Horde posts. Come in from the north instead. With the {area:467} flight path, fly there and follow the road south. Otherwise fly to {area:415} and walk south-west to the {area:1276}, the tunnel from {zone:1440} into Stonetalon."] = "{zone:1413}进入石爪山脉的路要经过{area:1702}，继续通往山区的道路则经过{area:2539}和{area:460}：全是部落据点。改从北边进入。如果有{area:467}的飞行路线，就飞过去再沿道路向南走。否则飞往{area:415}，向西南步行到{area:1276}，也就是从{zone:1440}通往石爪山脉的隧道。",

	-- Step 7: Stonetalon Mountains
	-- {area:460} Sun Rock Retreat · {zone:1442} Stonetalon Mountains · {object:424005} Pocket Litter
	["The next hideout is a small camp in the hills north-west of {area:460}, in the middle of the {zone:1442}. Leave the road where a path climbs west into the hills and follow it to the camp; the {object:424005} lies on a crate beside its tent."] = "下一个藏身处位于 {zone:1442} 中部、{area:460} 西北方山丘中的小营地。从向西上山的小路离开主路，沿小路到达营地；{object:424005} 就在帐篷旁的箱子上。",
	["Path into the hills"] = "上山小径",

	-- Step 8: A hundred paces north
	["A hundred paces north"] = "向北一百步",
	-- {object:424012} Mound of Dirt
	["Walk north through the camp and drop carefully down the steep slope to the {object:424012} on the ledge below. A missed jump only slides you down: hug the cliff and walk back up."] = "向北穿过营地，小心沿陡坡下到下方岩台上的{object:424012}。跳偏只会滑到下面：贴着崖壁绕路走回上方即可。",

	-- Step 9: Tarren Mill on the way
	-- {area:272} Tarren Mill
	["{area:272} on the way"] = "顺路经过{area:272}",
	-- {area:272} Tarren Mill · {zone:1432} Loch Modan · {area:1057} Thoradin's Wall · {zone:1437} Wetlands
	["Passing {area:272} on the way to {zone:1432}? Set your Hearthstone here: after the dam, it brings you back next to {area:1057} instead of the long walk through the {zone:1437} and Arathi. Skip this step to keep your Hearthstone where it is."] = "前往{zone:1432}时经过{area:272}？在这里绑定炉石：过了大坝之后，它能把你直接带回{area:1057}旁边，省去穿过{zone:1437}和阿拉希的漫长路程。跳过此步骤可让炉石保持原绑定位置。",

	-- Step 10: The dam in Loch Modan
	-- {zone:1432} Loch Modan
	["The dam in {zone:1432}"] = "{zone:1432}的水坝",
	-- {area:146} Stonewrought Dam
	["The figurine is on a ledge just below the top of the {area:146}, on its north face. Step off slowly; walking backwards keeps you from overshooting the ledge."] = "雕像位于{area:146}北侧、接近坝顶的岩台上。慢慢挪下边缘，倒退走可以避免冲过头。",

	-- Step 11: Out of the river
	["Out of the river"] = "离开河流",
	-- {zone:1437} Wetlands · {area:880} Thandol Span · {area:272} Tarren Mill
	["Careful: off the dam's ledge you land in the river below it, in the {zone:1437}. Climb out on its west bank well before the waterfall at about 65,77: the fall kills. Then head north-west to the road and follow it north over {area:880} into Arathi, or hearth if your Hearthstone is set at {area:272}."] = "小心：从大坝的岩台下来，你会落入下方{zone:1437}的河中。在约65,77处的瀑布之前尽早从西岸爬上去：掉下瀑布会摔死。然后向西北走到道路上，沿路向北经过{area:880}进入阿拉希；如果炉石绑定在{area:272}，也可以直接用炉石。",
	["West bank, before the waterfall"] = "西岸，瀑布之前",
	["West bank"] = "西岸",

	-- Step 12: Thoradin's Wall
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad
	["At the gate in {area:1057} between Arathi and {area:287}, turn north and follow the wall on the {area:287} side to a fallen cart leaning against it. Jump up the cart and its ladder onto the wall, then over the rocks to the hidden camp. Some characters cannot fit under the cargo netting at the camp; another race or a smaller form gets through."] = "在阿拉希与{area:287}之间的{area:1057}关口转向北，沿{area:287}这一侧的城墙走，找到倚在墙边的翻倒货车。跳上货车，再沿梯子登上城墙，越过岩石到达隐蔽营地。部分角色的体型无法穿过营地的货网；其他种族或较小的形态可以通过。",
	["Fallen cart"] = "翻倒的货车",

	-- Step 13: The hidden camp
	["The hidden camp"] = "隐蔽营地",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A burned-out campfire in the southern {zone:1413}, with a nailed plank beside it."] = "{zone:1413}南部一堆燃尽的营火旁，有一块钉着纸条的木板。",
	-- ["A burned-out campfire in western {zone:1436}, with a nailed plank beside it."] = "{zone:1436}西部一堆燃尽的营火旁，有一块钉着纸条的木板。",
	-- ["North of Honor's Stand"] = "荣耀岗哨以北",
	-- ["Round {area:1702}"] = "绕过{area:1702}",
	-- ["The next hideout is a small camp in the hills of eastern Stonetalon. Leave the road where a path climbs into the hills and follow it to the camp; the {object:424005} lies on a crate beside its tent."] = "下一处藏物点在石爪山脉东部山丘上的小营地。从道路旁上山的小径攀上山丘，沿小径走到营地；{object:424005}就在帐篷旁的箱子上。",
	-- ["The road west runs through {area:1702}, a Horde post; this way goes round it."] = "向西的道路会穿过部落哨所{area:1702}；这条路线会绕开它。",
}
