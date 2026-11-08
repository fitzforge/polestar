-- Chinese (simplified) (zhCN): the guide forever/class/warrior/voodoo-feathers (forever/class/warrior/voodoo-feathers.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience at 50, ending in the Sunken Temple; Classic's item choice may be gone on Forever."] = "",
	["Experience"] = "经验",

	-- Step 1: A Troubled Spirit (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to the {npc:7572} in the {zone:1435}."] = "",

	-- Step 2: A Troubled Spirit (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5113}, the warrior trainer of {zone:1455}, sends you to the {npc:7572} in the {zone:1435}."] = "50级时，{zone:1455}的战士训练师{npc:5113}会让你去{zone:1435}找{npc:7572}。",

	-- Step 3: A Troubled Spirit (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:7315}, the warrior trainer of {zone:1457}, sends you to the {npc:7572} in the {zone:1435}."] = "50级时，{zone:1457}的战士训练师{npc:7315}会让你去{zone:1435}找{npc:7572}。",

	-- Step 4: A Troubled Spirit (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3354} in the {object:172958} sends you to the {npc:7572} in the {zone:1435}."] = "50级时，{object:172958}的{npc:3354}会让你去{zone:1435}找{npc:7572}。",

	-- Step 5: A Troubled Spirit (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3041}, the warrior trainer of {zone:1456}, sends you to the {npc:7572} in the {zone:1435}."] = "50级时，{zone:1456}的战士训练师{npc:3041}会让你去{zone:1435}找{npc:7572}。",

	-- Step 6: A Troubled Spirit (Undercity)
	-- {npc:4593} Christoph Walker · {zone:1458} Undercity · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:4593}, a warrior trainer of the {zone:1458}, sends you to the {npc:7572} in the {zone:1435}."] = "50级时，{zone:1458}的一位战士训练师{npc:4593}会让你去{zone:1435}找{npc:7572}。",

	-- Step 7: The Fallen Hero of the Horde
	-- {npc:7572} Fallen Hero of the Horde
	["The {npc:7572}"] = "{npc:7572}",
	-- {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["The {npc:7572}, a ghost, stands in the south-west of the {zone:1435}, at the pass into the {zone:1419}, a short ride south-west of Stonard. Horde: fly to Stonard. Alliance: fly to Nethergarde Keep in the {zone:1419} and ride north through the pass. High-level beasts roam the way."] = "",

	-- Step 8: Helboars
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Helboars"] = "{npc:5993}",
	-- {zone:1419} Blasted Lands
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Seven Helboars (level 52-53, not elite) roam the north-west of the {zone:1419}, south-west of Nethergarde Keep; some stand near the ogres on the mountainside by the road. They charge from 25 yards and cast Fire Nova. They share spawn points with the Felbeasts and scorpids: if no boars are around, kill those and boars may appear instead. Back in 5 minutes."] = "",

	-- Step 10: Shadowsworn camps
	["Shadowsworn camps"] = "魔誓营地",
	["The Shadowsworn camp around the mouth of the Serpent's Coil cave, south of Nethergarde Keep on the way to the Dark Portal. You need 20 Adepts (level 52-53, they leech blood and heal hurt allies: kill them first), 10 Cultists (51-52, they throw from range, so close in) and 20 Thugs (52-53, Thrash and Kick). Thugs can run short before the others: kill every Shadowsworn you pass."] = "",

	-- Step 12: The Sunken Temple
	["The Sunken Temple"] = "",
	-- {npc:5710} Jammal'an the Prophet · {npc:5716} Zul'Lor · {zone:1435} Swamp of Sorrows · {npc:3560} Healing Ward
	["You need two feathers of each colour from the six Atal'ai troll guardians (level 51-52, elite) on the Sunken Temple's balcony, who hold the barrier in front of {npc:5710}: Gasher and {npc:5716} drop the amber, Hukku and Mijan the blue, Zolo and Loro the green, every kill; each player on the quest loots their own set. The Sunken Temple is a five-player dungeon: needs a group of five. It lies in the Pool of Tears in eastern {zone:1435}: climb the temple's outer steps, dive into the flooded hall and follow the stairs down to the entrance. Inside, reach the balcony by the stairs or the path on the right, not the spiral stairs. Hukku calls guardians and casts Shadow Bolt Volley and Curse of Blood; Mijan heals the others (Renew, a {npc:3560}, Healing Wave below half health): kill her or her ward fast; {npc:5716} cleaves."] = "",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}, from Gasher and {npc:5716}"] = "",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, from Hukku and Mijan"] = "",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, from Zolo and Loro"] = "",

	-- Step 13: Back to the Fallen Hero
	-- {npc:10996} Fallen Hero
	["Back to the {npc:10996}"] = "回到{npc:10996}那里",
	-- {npc:10996} Fallen Hero · {item:20130} Diamond Flask · {item:20521} Fury Visor · {item:20517} Razorsteel Shoulders
	["In Classic the {npc:10996} let you choose the {item:20130}, the {item:20521} or the {item:20517} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to the {npc:7572} in the {zone:1435}."] = "50级时，{object:2100}酒馆旁的{npc:5479}会让你去{zone:1435}找{npc:7572}。",
	-- ["Experience at 50, ending in the {area:1417}; Classic's item choice may be gone on Forever."] = "50级时获取经验，最终前往{area:1417}；Forever 可能已取消经典版的物品选择。",
	-- ["Experience at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "50级时获取经验，最终前往{area:1417}；Forever 取消了经典版的物品选择。",
	-- ["The Helboars roam the north of the {zone:1419}, south of the {npc:10996}."] = "{npc:5993}在{zone:1419}北部、{npc:10996}南边游荡。",
	-- ["The Shadowsworn cultists hold the east of the {zone:1419}."] = "魔誓教徒占据着{zone:1419}东部。",
	-- ["The {area:1417}"] = "{area:1417}",
	-- ["The {area:1417} lies under the {area:74} in the east of the {zone:1435}. Each of the six Atal'ai trolls on the balcony drops a voodoo feather: Gasher or {npc:5716} the amber, Hukku or Mijan the blue, Zolo or Loro the green. The {area:1417} is a dungeon and the trolls are elite: grouping up is advised."] = "{area:1417}位于{zone:1435}东部的{area:74}下方。阳台上的六个阿塔莱巨魔各掉落一根巫毒羽毛：加什尔或{npc:5716}掉落琥珀色，胡库或米杉掉落蓝色，祖罗或洛若尔掉落绿色。{area:1417}是地下城，巨魔都是精英：建议组队。",
	-- ["The {npc:7572} stands in the south-west of the {zone:1435}, at the entrance to the {zone:1419}."] = "{npc:7572}站在{zone:1435}西南部、{zone:1419}的入口处。",
}
