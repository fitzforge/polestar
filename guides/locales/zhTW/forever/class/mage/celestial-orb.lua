-- Chinese (traditional) (zhTW): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515}與手杖",
	["An off-hand orb or a staff for the late 30s, your pick."] = "30多級後段的副手寶珠或法杖，任你挑選。",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453}{object:2101}法師塔頂端的{npc:5497}會派你回去找{npc:6546}；{zone:1455}的彬克也提供同一個任務。",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}位於{object:173161}的法師訓練師之一{npc:5885}會派你回去找{npc:6546}；{zone:1458}的{npc:4568}和{zone:1456}的{npc:3048}也提供同一個任務。",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}; come in from the west road, the elites roam its east side."] = "{npc:6546}的小屋在塞拉摩西邊的沼澤深處，就在{area:508}北邊；從西邊的道路進去，精英在它的東側遊蕩。",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:686} Shadow Bolt · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the {area:602} in southern {zone:1443}, east of {area:2408}, and every one carries an {item:7291}. They cast {spell:686} from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Hand in the orb now; {quest:1955} waits for level 38. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "回到{npc:6546}那裡。現在先繳交寶珠；{quest:1955}要等到38級。先清掉小屋周圍的小動物，牠們也會加入戰鬥。接取{quest:1955}即開始三分鐘倒數，{npc:6546}會在花園召喚出{npc:6549}。牠是40級精英，對許多法術、定身和緩速有較強抗性。建議組隊，40級法師可能需要幫手或藥水，約45級時可單人完成。可以從碼頭遠程拉怪。擊殺後倒數仍會繼續，務必立刻繳交任務。若時間用完，放棄任務後重新接取，她會再次召喚惡魔。",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {area:1898} Dustwind Gulch · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["{area:1517} is a dungeon in the northern {zone:1418}: a group of five, from level 40 here. Go in by the rear entrance, a cave in {area:1898} south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "{area:1517}是{zone:1418}北部的五人地城，本指南從40級起前往。從主入口東南側{area:1898}的洞穴後門進入（附近有精英龍飛行）：42級精英{npc:7023}就在第一扇門後。它在80%、60%、40%和20%生命值時各分裂出一個同為精英的{npc:7209}；碎片存活時，兩者都會反射指向性法術，改用範圍法術和魔杖。單人技巧：每次碎片出現，就從附近的區域邊界走出去；哨兵會回血，但會持續縮小。能量源必定掉落，兩小時後重生。",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges · {spell:403} Lightning Bolt
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and {spell:403}) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {area:978} Zul'Farrak · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in {area:978}, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. The reward window shows the {item:9527} and the {item:9531}."] = "40級時，指引你去找{npc:6546}的法師訓練師（{npc:5497}、彬克、{npc:4568}、{npc:5885}）也會提供任何職業都能完成的{quest:2861}。接著{npc:6546}需要{area:978}的46級精英納迦{npc:7795}身上的{quest:2846}；那是{zone:1446}西北部的食人妖地城，需要五人小隊，44-54級。獎勵視窗會顯示{item:9527}和{item:9531}。",

	-- Step 9: Tiara of the Deep in Zul'Farrak
	-- {quest:2846} Tiara of the Deep · {area:978} Zul'Farrak
	["{quest:2846} in {area:978}"] = "{area:978}中的{quest:2846}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:7795} Hydromancer Velratha
	["{area:978}, the troll dungeon in north-western {zone:1446}, needs a group of five; the guide waits for level 44. {npc:7795} is one of the bosses by the sacred pool, and the tiara always drops."] = "{area:978}是{zone:1446}西北部的食人妖地城，需要五人小隊；指南會等到44級。{npc:7795}是聖池旁的首領之一，頭冠必定掉落。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "回到{npc:6546}處。她會在小屋旁打開一道法力裂縫：在十分鐘內擊殺十二個{quest:1957}。",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "火刃召喚師在{zone:1443}南部的{area:602}活動；他們每一個都帶著{item:7291}。",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517}是{zone:1418}北部的地城，位於{object:178824}旁：五人小隊。擊敗裡面的{npc:7023}取得它的能量源。",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546}會在她的小屋旁把惡魔從寶珠中引出來。{npc:6549}是精英：建議組隊。你有三分鐘，之後它就會溜回寶珠裡。",
}
