-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {npc:1573} Gryth Thurden
	["From {zone:1455}'s {npc:1573}"] = "來自{zone:1455}的{npc:1573}",

	-- Step 2: Auberdine
	-- {area:442} Auberdine · {npc:3649} Thundris Windweaver
	["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "在米奈希爾的碼頭搭船前往{area:442}。{npc:3649}站在{area:442}飛行管理員的北邊。",
	-- {npc:3649} Thundris Windweaver · {item:279915} Nord'el
	["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}：{item:279915}，來自米奈希爾",

	-- Step 3: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {area:1276} Talondeep Path
	["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "從{area:415}向西北騎進山丘：{quest:1738}是前往{area:413}道路北邊一棵發光的樹。如果你接了{quest:65602}，{item:190309}在{area:413}北邊樹林中的一間房子裡（26.6,22.0）。然後經過{area:415}回到{area:1276}。",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}，在{area:413}北邊",

	-- Step 4: Talondeep Path
	-- {area:415} Astranaar · {area:1276} Talondeep Path
	["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "從{area:415}向西南前往{area:1276}，這是一條穿過山脈通往石爪山脈的隧道。",

	-- Step 5: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "沿著道路向西經過{area:460}（部落），再向西南穿過{area:465}進入{zone:1443}；{area:608}位於山口頂端。",

	-- Step 6: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "怨怒薩特佔據{area:608}東邊的{area:603}廢墟。",

	-- Step 8: Malem chest
	["Malem chest"] = "瑪雷姆的箱子",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "箱子在{area:608}西南方的廢墟中。",

	-- Step 10: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "{npc:11863}的塔位於{area:599}西邊的山丘上：先接他的任務，他要的權杖就在要塞裡。",

	-- Step 11: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644}躲在{area:608}西南方火刃的要塞裡。",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643}與先知",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "她的哥哥{npc:5643}（36級）和燃刃氏族教徒（30-33級）一起在要塞裡走動：單獨把他拉出來。{npc:13019}把權杖放在要塞的主建築裡。",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "護送{npc:5644}",
	["Out of Thunder Axe Fortress"] = "離開雷斧堡壘",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "帶{npc:5644}走出要塞；離開要塞後她就會自行離去。指南結尾時在{area:608}向{npc:5642}繳交。",

	-- Step 15: Scorpashi venom
	["Scorpashi venom"] = "荒土蠍毒液",
	-- {area:2407} Kormek's Hut
	["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "荒土蠍在往南道路上的{area:2407}周圍山丘獵食。",

	-- Step 16: Cork Gizelton
	-- {area:2407} Kormek's Hut
	["The Gizelton Caravan waits at {area:2407}."] = "基澤爾頓車隊在{area:2407}等候。",

	-- Step 17: Escort the caravan
	["Escort the caravan"] = "護送車隊",
	-- {area:609} Kolkar Village · {area:2617} Scrabblescrew's Camp
	["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "跟著車隊向南經過{area:609}；途中科卡爾伏擊者會襲擊車隊。待在附近直到它停在{area:2617}。伏擊者是34-35級，而且分波出現：如果你低於33級就跳過。",

	-- Step 18: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "{npc:11596}的營地在{area:609}南邊的路上，位於{area:596}旁。",

	-- Step 19: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4700} Aged Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo
	["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "對{npc:4700}使用{npc:11596}的{item:13892}，把馴服的科多獸帶回他的營地，共五次；老邁的科多獸也會掉落獸皮。",

	-- Step 21: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "科卡爾半人馬在{area:609}周圍的平原上遊蕩；牠們的耳朵是給{npc:5752}的。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1276}"] = "{area:1276}",
}
