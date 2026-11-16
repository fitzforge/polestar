-- Chinese (traditional) (zhTW): the guide forever/class/warrior/quelserrar (forever/class/warrior/quelserrar.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2577} Dire Maul · {npc:10184} Onyxia
	["A tank sword at 60: a {area:2577} book, then {npc:10184}'s breath tempers the blade (the sword is not in Forever's items yet)."] = "60級的坦克劍：一本{area:2577}的書，再用{npc:10184}的吐息淬鍊劍刃（該劍尚未加入 Forever 的物品資料）。",
	["Shen'dralar reputation"] = "辛德拉聲望",

	-- Step 1: Nostro's Compendium of Dragon Slaying
	-- {area:2577} Dire Maul · {npc:11496} Immol'thar · {npc:11501} King Gordok · {zone:1444} Feralas
	["The book is a rare random drop from the bosses of all three {area:2577} wings (Alzzin, Hydrospawn and the rest of the East, Tendris, Illyanna, Kalendris, {npc:11496} and the West, {npc:11501} and the North's guards) and very rarely from the tribute chest; it can be traded, so the auction house may have one. {area:2577} is a five-player dungeon in the ruins of central {zone:1444}: needs a group of five. Right-click the book to start the quest; it stays in your bags."] = "這本書是{area:2577}三個區域首領的稀有隨機掉落（東區的阿爾茲恩、海多斯帕恩等，西區的坦德里斯、伊莉安娜、卡倫德里斯、{npc:11496}，以及北區的{npc:11501}和守衛），貢品箱中極少見；它可以交易，所以拍賣行裡可能有。{area:2577}是{zone:1444}中部廢墟中的五人地城：需要五人組隊。右鍵點選書本開始任務；書會留在你的揹包裡。",
	-- {item:18401} Nostro's Compendium of Dragon Slaying
	["from {item:18401}"] = "來自{item:18401}",

	-- Step 2: Lorekeeper Lydros
	-- {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18513} A Dull and Flat Elven Blade · {item:18489} Unfired Ancient Blade
	["{npc:14368} stands in the Athenaeum, the library at the far end of Dire Maul West, past the Court of the Highborne and the Prison of Immol'thar. The West door needs the {item:18249}, which Pusillin drops in Dire Maul East (he runs; chase him), or a rogue to pick it. Clearing to the library needs your group of five. He takes the book, hands you {item:18513} to give straight back, then the {item:18489}. Keep that blade: lose it, and you must abandon the quest and take it again."] = "{npc:14368}站在圖書館（Athenaeum），即厄運之槌西區最深處的藏書室，要穿過上層精靈庭院和伊莫塔爾之牢。西門需要{item:18249}，它在厄運之槌東區由普希林掉落（他會逃跑，追上去），或者讓盜賊開鎖。清到圖書館需要你的五人小隊。他收下書，交給你{item:18513}讓你立刻交回，然後給你{item:18489}。保管好那把劍：弄丟了就必須放棄任務、重新接取。",
	-- {npc:14368} Lorekeeper Lydros
	["{npc:14368}, in the Athenaeum"] = "{npc:14368}，在圖書館（Athenaeum）",
	-- {npc:14368} Lorekeeper Lydros
	["{npc:14368}: hand back the Dull and Flat Elven Blade"] = "{npc:14368}：交回“鈍而平的精靈之劍”",

	-- Step 3: Onyxia's breath
	-- {npc:10184} Onyxia
	["{npc:10184}'s breath"] = "{npc:10184}的吐息",
	-- {npc:10184} Onyxia · {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18489} Unfired Ancient Blade · {object:179562} Ancient Heated Blade · {item:18488} Heated Ancient Blade
	["{npc:10184} is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. Tell the raid first. Late in the fight (around 10-15% health, when she has landed again) use the {item:18489} to plant it in the path of her fire breath, usually by the main tank's feet. When her breath has heated it, click the {object:179562} to take the {item:18488}: from then you have 20 minutes. Her breath can kill you while you plant or pick up the blade; if you die and nobody brings you back before she dies, wait for next week. Planted in the wrong place? Abandon the quest, take it again from Lydros for a new blade."] = "{npc:10184}是{area:2159}的40人團隊副本首領，那是在{zone:1445}南部{area:511}中的一處洞穴；她每週重新出現一次。先跟團隊說清楚。戰鬥後期（血量約10%到15%、她再次落地時），用{item:18489}把它插進她火焰吐息的路徑上，通常放在主坦克腳下。等她吐息把它加熱後，點選{object:179562}取走{item:18488}：從那時起你有20分鐘。她吐息時你插劍或取劍都可能被燒死；如果你死了，在她死前沒人把你救起，就等下週。插錯地方了？放棄任務，再從利德羅斯那裡接一次，拿一把新劍。",
	-- {item:18489} Unfired Ancient Blade
	["{item:18489}: plant it in her breath"] = "{item:18489}：插進她的吐息中",
	["click the heated blade on the ground"] = "點選地上被加熱的劍",

	-- Step 4: Onyxia's corpse
	-- {npc:10184} Onyxia
	["{npc:10184}'s corpse"] = "{npc:10184}的屍體",
	-- {npc:10184} Onyxia · {item:18488} Heated Ancient Blade · {item:18492} Treated Ancient Blade
	["Kill {npc:10184}, then target her corpse and use the {item:18488} on it before the 20 minutes run out. It becomes the {item:18492}, with no time limit."] = "殺掉{npc:10184}，然後在20分鐘結束前選中她的屍體並使用{item:18488}。它會變成{item:18492}，沒有時間限制。",
	-- {item:18488} Heated Ancient Blade
	["{item:18488}, on her corpse"] = "{item:18488}，用在她的屍體上",

	-- Step 5: The Forging of Quel'Serrar
	-- {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key
	["Back to {npc:14368} in the Athenaeum of Dire Maul West: through the West door with the {item:18249} again, and a group to reach the library."] = "回到厄運之槌西區圖書館（Athenaeum）的{npc:14368}：同樣要用{item:18249}走西門，還得帶上一隊人才能到圖書館。",
}
