-- Chinese (simplified) (zhCN): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:444} Tower of Althalaxx
	["Starts now at 22 at the {area:444}; its mobs are 28-30, so go nearer 30 or with a friend. Alliance only for now."] = "",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore · {spell:686} Shadow Bolt · {object:409311} Spear of Mannoroth (no name in this language: may be words)
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic · Dark Strand Voidcallers = {npc:2337} Dark Strand Voidcaller
	["Climb to the top of the {area:444} in northern {zone:1439}. The Dark Strand Fanatics around it are easy (level 16-17), but four Dark Strand Voidcallers (level 28-29) stand in the tower on the way to the orb: each calls a voidwalker and casts {spell:686} from range. At 22-25 bring a friend or two, pull them one at a time and step behind a wall so they have to come to you. Loot the Strange Orb at the top: it gives you the Althalaxx Orb; right-click it to start the quest. Keep the orb in your bags until the {object:409311}: three later quests need it."] = "爬到 {zone:1439} 北部 {area:444} 的塔顶。周围的暗滩狂热者比较容易对付（16-17 级），但通往宝珠的塔内有四名暗滩唤魔师（28-29 级）：每名都会召唤虚空行者，并在远处施放 {spell:686}。22-25 级时，带一两位朋友来，每次只引一名，然后躲到墙后迫使对方靠近。拾取顶层的 Strange Orb，获得 奥萨拉克斯宝珠；右键点击它开始任务。在到达 {object:409311} 之前一直把宝珠放在背包里：后面有三个任务要用到它。",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "{area:444}顶端的Strange Orb：右键点击它给的奥萨拉克斯宝珠",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale · {zone:1439} Darkshore · {zone:1453} Stormwind
	["{npc:3663} stands at {area:413} in western {zone:1440}, south of the {zone:1439} road. He sends you to {zone:1453} with the orb."] = "{npc:3663} 站在 {zone:1440} 西部的 {area:413}，位于通往 {zone:1439} 的道路南侧。他会让你带着宝珠前往 {zone:1453}。",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} stands in the Cathedral of Light; she sends you to a warlock for a second opinion."] = "{npc:5492} 站在圣光大教堂中；她会让你找一名术士听听另一种意见。",

	-- Step 4: Ursula Deline
	-- {npc:5495} Ursula Deline · {object:2101} Mage Quarter · {object:2164} Slaughtered Lamb · {item:209778} Summoner's Salt
	["{npc:5495}, the warlock trainer, is in the {object:2101}'s warlock sanctum, down in the {object:2164}'s cellar. She wants 14 {item:209778} to read the orb."] = "术士训练师{npc:5495}在{object:2101}的术士密室中，位于{object:2164}的地下室深处。她需要14个{item:209778}来解读宝珠。",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt · {area:69} Lakeshire · {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner · Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The Blackrock Summoners, Champions and Trackers (level 22-25, not elite) camp in the north-west of Redridge and drop the {item:209778}; you need 14. Two elite Blackrock Shadowcasters (22-23) stand at the cave mouth at the camp's east end: pull around them. The Blackrock camps east of {area:69} drop the salt too, but their Shadowcasters, Sentries and Hunters are elite (level 21-24), and so is {npc:334} (26): stay in the north-west."] = "黑石召唤师、黑石勇士和黑石追踪者（22-25 级，非精英）驻扎在赤脊山西北部，会掉落 {item:209778}；你需要 14 个。营地东端洞口站着两名精英黑石暗影法师（22-23 级）：拉怪时要避开它们。{area:69} 东侧的黑石营地也会掉落这种盐，但那里的暗影法师、哨兵和猎人都是精英（21-24 级），{npc:334}（26 级）也是精英：留在西北部刷。",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "回到{npc:5495}处",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "玛诺洛斯微粒",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale · {area:431} Splintertree Post · {spell:686} Shadow Bolt · {spell:348} Immolate
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}, east of {area:431} (a Horde camp: go round it). The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds (level 29-30, not elite) drop the Motes of Mannoroth; you need 12. Below about 27 they are hard alone: come with a second player or later. Felguards knock you down, Lashers cast {spell:686} and {spell:348}, Infernals keep a fire shield up. They respawn in five minutes."] = "{area:435} 位于 {zone:1440} 东南、{area:431} 以东（那里是部落营地，要绕开）。玛诺洛克鞭笞者、灼热的地狱火、地狱卫士和恶魔指挥官（29-30 级，非精英）会掉落 玛诺洛斯微粒，需要收集 12 个。大约 27 级以下很难单人应付：找另一名玩家同行，或晚些再来。地狱卫士会击倒，鞭笞者会施放 {spell:686} 和 {spell:348}，地狱火会一直保持火焰护盾。它们每五分钟刷新一次。",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words)
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words) · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb (no name in this language: may be words)
	["The {object:409311} stands at the east end of {area:435}. Hand in the motes at the spear with the Althalaxx Orb in your bags: the orb shatters, and the {object:409315} beside it starts the last quest."] = "{object:409311} 位于 {area:435} 的东端。把 奥萨拉克斯宝珠 放在背包里，在长矛处交还微粒：宝珠会碎裂，旁边的 {object:409315} 随即提供最后一个任务。",
	-- {object:409315} Shattered Orb (no name in this language: may be words)
	["from the {object:409315}"] = "来自{object:409315}",

	-- Step 9: Return to Delgren
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Back to {npc:3663} at {area:413} in western {zone:1440}, across the whole zone."] = "横穿整个地区，返回 {zone:1440} 西部 {area:413} 的 {npc:3663} 处。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "来自旧版{spell:407778}故事的30级稀有披风；目前只有联盟圣骑士能完成。",
	-- ["Back to {area:413}."] = "回到{area:413}。",
	-- ["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "黑石召唤师、黑石勇士和黑石追踪者驻扎在赤脊山西北部；它们掉落{item:209778}。",
	-- ["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "爬到{zone:1439}北部{area:444}的顶端。拾取上面的Strange Orb：它会给你奥萨拉克斯宝珠，由此开始任务。",
	-- ["Climb to the top of the {area:444} in northern {zone:1439}. The Dark Strand Fanatics around it are easy (level 16-17), but four Dark Strand Voidcallers (level 28-29) stand in the tower on the way to the orb: each calls a voidwalker and casts {spell:686} from range. At 22-25 bring a friend or two, pull them one at a time and step behind a wall so they have to come to you. Loot the Strange Orb at the top: it gives you the Althalaxx Orb; right-click it to start the quest. Keep the orb in your bags until the {object:409311}: three later quests need it."] = "爬到 {zone:1439} 北部 {area:444} 的塔顶。周围的暗滩狂热者比较容易对付（16-17 级），但通往宝珠的塔内有四名暗滩唤魔师（28-29 级）：每名都会召唤虚空行者，并在远处施放 {spell:686}。22-25 级时，带一两位朋友来，每次只引一名，然后躲到墙后迫使对方靠近。拾取顶层的 Strange Orb，获得 奥萨拉克斯宝珠；右键点击它开始任务。在到达 {object:409311} 之前一直把宝珠放在背包里：后面有三个任务要用到它。",
	-- ["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "凯瑟琳让你去找{object:2101}的术士；{npc:5495}代表他们。",
	-- ["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "{area:444}顶端的Strange Orb：右键点击它给的奥萨拉克斯宝珠",
	-- ["The Strange Orb"] = "Strange Orb",
	-- ["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311}矗立在{area:435}东端。在它上面击碎宝珠；{object:409315}会出现在旁边。",
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311}矗立在{area:435}东端。对上面的宝珠施放{spell:11170}；{object:409315}会出现在旁边。",
	-- ["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435}位于{zone:1440}东南部。里面的玛诺洛克鞭笞者、灼热的地狱火、恶魔守卫和恶魔指挥官掉落玛诺洛斯微粒。",
	-- ["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663}站在{zone:1440}西部的{area:413}。",
	-- ["{npc:5492} is in the Cathedral of Light."] = "{npc:5492}在光明大教堂。",
	-- ["{npc:5492} is in the 光明大教堂."] = "{npc:5492}在光明大教堂。",
}
