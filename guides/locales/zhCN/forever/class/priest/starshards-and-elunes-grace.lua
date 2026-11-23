-- Chinese (simplified) (zhCN): the guide forever/class/priest/starshards-and-elunes-grace (forever/class/priest/starshards-and-elunes-grace.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["{spell:10797} and {spell:2651}"] = "{spell:10797}和{spell:2651}",
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["The Night Elf priest spells: {spell:10797} at 10, {spell:2651} at 20. Free, no objectives."] = "暗夜精灵牧师法术：10级{spell:10797}，20级{spell:2651}。免费，无任务目标。",

	-- Step 1: Starshards: Laurna Morninglight
	-- {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10, {npc:3600}, the priest trainer in the building at the north edge of {area:186}, hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}. {area:186} is on the road west to {zone:1457}."] = "10 级时，{area:186} 北侧建筑内的牧师训练师 {npc:3600} 会给你 {quest:5628}，一封交给 {zone:1457} 的 {npc:11401} 的信。{area:186} 就在向西通往 {zone:1457} 的道路上。",
	-- {npc:3600} Laurna Morninglight · {quest:5628} Returning Home
	["{npc:3600}: take {quest:5628}"] = "{npc:3600}：接取{quest:5628}",

	-- Step 2: Starshards: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}."] = "10 级时，在 {zone:1429} 的 {area:87}，狮王之傲旅店楼上的 {npc:377} 会给你 {quest:5628}，一封交给 {zone:1457} 的 {npc:11401} 的信。",
	-- {npc:377} Priestess Josetta · {quest:5628} Returning Home
	["{npc:377}: take {quest:5628}"] = "{npc:377}：接取{quest:5628}",

	-- Step 3: Starshards: Maxan Anvol
	-- {zone:1426} Dun Morogh · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10 in {zone:1426}, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}."] = "10 级时，在 {zone:1426} 的 {area:131}，{area:2102} 内的牧师训练师 {npc:1226} 会给你 {quest:5628}，一封交给 {zone:1457} 的 {npc:11401} 的信。",
	-- {npc:1226} Maxan Anvol · {quest:5628} Returning Home
	["{npc:1226}: take {quest:5628}"] = "{npc:1226}：接取{quest:5628}",

	-- Step 4: Starshards: Brother Joshua
	-- {zone:1453} Stormwind · {npc:5489} Brother Joshua · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:11397} Nara Meideros
	["At 10 in {zone:1453}, {npc:5489} at the altar of the Cathedral of Light hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}. {npc:11397} in the Park has the same letter."] = "10 级时，{zone:1453} 圣光大教堂祭坛旁的 {npc:5489} 会给你 {quest:5628}，一封交给 {zone:1457} 的 {npc:11401} 的信。花园的 {npc:11397} 也能给你同一封信。",
	-- {npc:5489} Brother Joshua · {quest:5628} Returning Home
	["{npc:5489}: take {quest:5628}"] = "{npc:5489}：接取{quest:5628}",

	-- Step 5: Starshards: Braenna Flintcrag
	-- {zone:1455} Ironforge · {npc:5142} Braenna Flintcrag · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 10 in {zone:1455}, {npc:5142} in the {object:32386} ({object:32362}) hands you {quest:5628}, a letter for {npc:11401} in {zone:1457}."] = "10级时，{zone:1455} 的 {object:32386}（{object:32362}）内的 {npc:5142} 会交给你 {quest:5628}，这是一封写给 {zone:1457} 的 {npc:11401} 的信。",
	-- {npc:5142} Braenna Flintcrag · {quest:5628} Returning Home
	["{npc:5142}: take {quest:5628}"] = "{npc:5142}：接取{quest:5628}",

	-- Step 6: Starshards: Priestess Alathea
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {quest:5627} Stars of Elune · {spell:10797} Starshards
	["At 10, go to {npc:11401} on the upper balcony of the Temple of the Moon, at the south end of {zone:1457}: take the ramp up from the temple floor; she stands beside {npc:7999}. {quest:5627} is given and taken back at once and teaches {spell:10797}. No letter needed. Forever made {spell:10797} hit much harder, on a 30-second cooldown."] = "10级时，前往 {zone:1457} 南端月神殿的上层露台找 {npc:11401}：从神殿底层沿坡道上去；她就站在 {npc:7999} 旁边。{quest:5627} 接到后即可立即交还，并教你 {spell:10797}，不需要信。无限服大幅提高了 {spell:10797} 的伤害，冷却时间为30秒。",

	-- Step 7: Starshards: Laurna Morninglight's letter
	-- {spell:10797} Starshards · {npc:3600} Laurna Morninglight
	["{spell:10797}: {npc:3600}'s letter"] = "{spell:10797}：{npc:3600}的信",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {npc:11401} Priestess Alathea · {quest:5629} Returning Home · {spell:10797} Starshards
	["Take the road west from {area:186} into {zone:1457} and go up to the upper balcony of the Temple of the Moon, beside {npc:7999}: {npc:11401} takes {quest:5629} and teaches {spell:10797}."] = "从{area:186}沿路向西进入{zone:1457}，上到月神殿上层露台、{npc:7999}旁：{npc:11401}会接收{quest:5629}，并教你{spell:10797}。",

	-- Step 8: Starshards: Josetta's letter
	-- {spell:10797} Starshards
	["{spell:10797}: Josetta's letter"] = "{spell:10797}：女牧师洁塞塔的信",
	-- {quest:5628} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5628} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5628} 交给 {zone:1457} 月神殿上层露台上的 {npc:11401}，就在 {npc:7999} 旁边：从 {area:17203}（或 {area:150}）乘船到 {area:442}，再乘船到 {area:702}，然后通过传送门进入上方的 {zone:1457}。",

	-- Step 9: Starshards: Maxan Anvol's letter
	-- {spell:10797} Starshards · {npc:1226} Maxan Anvol
	["{spell:10797}: {npc:1226}'s letter"] = "{spell:10797}：{npc:1226}的信",
	-- {quest:5630} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5630} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5630} 交给 {zone:1457} 月神殿上层露台上的 {npc:11401}，就在 {npc:7999} 旁边：从 {area:17203}（或 {area:150}）乘船到 {area:442}，再乘船到 {area:702}，然后通过传送门进入上方的 {zone:1457}。",

	-- Step 10: Starshards: Joshua's letter
	-- {spell:10797} Starshards
	["{spell:10797}: Joshua's letter"] = "{spell:10797}：乔舒的信",
	-- {quest:5631} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5631} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5631} 交给 {zone:1457} 月神殿上层露台上的 {npc:11401}，就在 {npc:7999} 旁边：从 {area:17203}（或 {area:150}）乘船到 {area:442}，再乘船到 {area:702}，然后通过传送门进入上方的 {zone:1457}。",

	-- Step 11: Starshards: Nara's letter
	-- {spell:10797} Starshards
	["{spell:10797}: Nara's letter"] = "{spell:10797}：娜拉·梅德隆的信",
	-- {quest:5632} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5632} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5632} 交给 {zone:1457} 月神殿上层露台上的 {npc:11401}，就在 {npc:7999} 旁边：从 {area:17203}（或 {area:150}）乘船到 {area:442}，再乘船到 {area:702}，然后通过传送门进入上方的 {zone:1457}。",

	-- Step 12: Starshards: Braenna Flintcrag's letter
	-- {spell:10797} Starshards · {npc:5142} Braenna Flintcrag
	["{spell:10797}: {npc:5142}'s letter"] = "{spell:10797}：{npc:5142}的信",
	-- {quest:5633} Returning Home · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["{quest:5633} goes to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: take the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "{quest:5633} 交给 {zone:1457} 月神殿上层露台上的 {npc:11401}，就在 {npc:7999} 旁边：从 {area:17203}（或 {area:150}）乘船到 {area:442}，再乘船到 {area:702}，然后通过传送门进入上方的 {zone:1457}。",

	-- Step 13: Elune's Grace: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {spell:2651} Elune's Grace · {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:11397} Nara Meideros
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you an {spell:2651} letter for {npc:11401} in {zone:1457}. {npc:11397} in the Park has the same letter."] = "20级时，在{zone:1453}圣光大教堂祭坛旁，{npc:376}会给你一封关于{spell:2651}的信，让你交给{zone:1457}的{npc:11401}。花园区的{npc:11397}也有相同的信。",
	-- {npc:376} High Priestess Laurena · {spell:2651} Elune's Grace
	["{npc:376}: take her {spell:2651} letter"] = "{npc:376}：领取她的 {spell:2651} 信件。",

	-- Step 14: Elune's Grace: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward · {spell:2651} Elune's Grace · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you an {spell:2651} letter for {npc:11401} in {zone:1457}."] = "在 {zone:1455} 达到20级后，{npc:11406} 会在 {object:32386}（{object:32362}）给你一封关于 {spell:2651} 的信，要你送给 {zone:1457} 的 {npc:11401}。",
	-- {npc:11406} High Priest Rohan · {spell:2651} Elune's Grace
	["{npc:11406}: take his {spell:2651} letter"] = "{npc:11406}：收下他关于 {spell:2651} 的信",

	-- Step 15: Elune's Grace: Priestess Alathea
	-- {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5672} Elune's Grace
	["At 20, {npc:11401} on the upper balcony of the Temple of the Moon, beside {npc:7999}, teaches {quest:5672} with a quest she gives and takes back at once. In Forever, {quest:5672} halves the chance for melee and ranged attacks to hit you for 15 seconds or until three attacks miss."] = "达到 20 级后，月神殿上层露台上、{npc:7999} 身旁的 {npc:11401} 会给予一个任务，并立即接受交还，以此教你 {quest:5672}。在无限中，{quest:5672} 会使近战和远程攻击命中你的概率减半，持续 15 秒，或直至三次攻击未命中。",

	-- Step 16: Elune's Grace: Laurena's letter
	-- {quest:5673} Elune's Grace
	["{quest:5673}: Laurena's letter"] = "{quest:5673}：高阶牧师劳瑞娜的信",
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Hand Laurena's letter to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "将劳瑞娜的信交给 {zone:1457} 月神殿上层露台上的 {npc:11401}，就在 {npc:7999} 旁边：从 {area:17203}（或 {area:150}）乘船到 {area:442}，再乘船到 {area:702}，然后通过传送门进入上方的 {zone:1457}。",

	-- Step 17: Elune's Grace: Nara's letter
	-- {quest:5674} Elune's Grace
	["{quest:5674}: Nara's letter"] = "{quest:5674}：娜拉·梅德隆的信",
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Hand Nara's letter to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "把娜拉·梅德隆的信交给 {zone:1457} 月神殿上层露台的 {npc:11401}，她在 {npc:7999} 身旁：从 {area:17203}（或 {area:150}）坐船到 {area:442}，再坐船到 {area:702}，然后通过传送门上到 {zone:1457}。",

	-- Step 18: Elune's Grace: Rohan's letter
	-- {quest:5675} Elune's Grace
	["{quest:5675}: Rohan's letter"] = "{quest:5675}：洛汉的信。",
	-- {npc:11401} Priestess Alathea · {zone:1457} Darnassus · {npc:7999} Tyrande Whisperwind · {area:17203} Stormwind Harbor · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Hand Rohan's letter to {npc:11401}, on the upper balcony of the Temple of the Moon in {zone:1457}, beside {npc:7999}: the boat from {area:17203} (or {area:150}) to {area:442}, the boat on to {area:702}, then the portal up into {zone:1457}."] = "将杀手洛汗的信交给{npc:11401}，他在{zone:1457}月神殿的上层阳台、{npc:7999}旁边：从{area:17203}（或{area:150}）乘船到{area:442}，再乘船到{area:702}，然后通过传送门上到{zone:1457}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11401} in the Temple of the Moon. Priest trainers elsewhere ({npc:3600} in {area:186}, {npc:377} in {area:87}, {npc:1226} in {area:131}) send you to her with {quest:5628}."] = "10级时，去月神殿找{npc:11401}。其他地方的牧师训练师（{area:186}的{npc:3600}、{area:87}的{npc:377}、{area:131}的{npc:1226}）会用{quest:5628}让你去找她。",
	-- ["At 20, {npc:11401} teaches {quest:5672}. {npc:376} in {zone:1453} and {npc:11406} in {zone:1455} send you to her with a quest of the same name."] = "20级时，{npc:11401}传授{quest:5672}。{zone:1453}的{npc:376}和{zone:1455}的{npc:11406}会用同名任务让你去找她。",
	-- ["The Night Elf priest spells: {spell:10797} at 10, {spell:2651} at 20."] = "暗夜精灵牧师法术：10级{spell:10797}，20级{spell:2651}。",
}
