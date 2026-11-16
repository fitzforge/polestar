-- Chinese (traditional) (zhTW): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old item choice may be gone in Forever."] = "一次性使用的石頭，可在10分鐘內大幅提升你對不死生物的戰力；舊的物品選擇在Forever中可能已經沒有了。",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 50 {npc:928}, the paladin trainer in the Cathedral of Light, sends you to {area:3197} in the {zone:1422}. {npc:5149} in {zone:1455} gives the same quest."] = "50級時，光明大教堂的聖騎士訓練師{npc:928}會讓你去{zone:1422}的{area:3197}。{zone:1455}的{npc:5149}給同樣的任務。",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 50 {npc:5149}, the paladin trainer in the {object:32362}, sends you to {area:3197} in the {zone:1422}. {npc:928} in {zone:1453} gives the same quest."] = "50級時，{object:32362}裡的聖騎士訓練師{npc:5149}會讓你去{zone:1422}的{area:3197}。{zone:1453}的{npc:928}給同樣的任務。",

	-- Step 3: Chillwind Camp
	-- {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {npc:10838} Commander Ashlam Valorfist · {npc:10840} Argent Officer Pureheart
	["{area:3197} is the Alliance camp at the south end of the {zone:1422}, north of the Alterac foothills. {npc:10838} commands it; {npc:10840} stands in the same camp."] = "{area:3197}是{zone:1422}南端的聯盟營地，在奧特蘭克丘陵以北。{npc:10838}負責指揮；{npc:10840}也在同一營地。",

	-- Step 4: The Argent Dawn Commission
	-- {quest:5401} Argent Dawn Commission
	["The {quest:5401}"] = "{quest:5401}",
	-- {quest:5401} Argent Dawn Commission · {npc:10840} Argent Officer Pureheart · {area:2268} Light's Hope Chapel
	["The Scourge drop no Scourgestones unless you wear an {quest:5401}. {npc:10840} gives you one through her quest, {quest:5401}, which you hand in straight away (if you already have one from {area:2268}, wear that). Equip it in a trinket slot: it shows as a buff that never runs out. Keep it on until you have 20 stones."] = "除非佩戴{quest:5401}，否則天災怪物不會掉落天災石。{npc:10840}會透過她的“{quest:5401}”任務給你一個，該任務可立即交還（如果你已經從{area:2268}拿到一個，就戴那個）。將它裝備到飾品欄：會顯示為一個永不消失的增益效果。收集滿20塊石頭前一直戴著。",
	-- {quest:5401} Argent Dawn Commission
	["the {quest:5401} trinket: equip it"] = "{quest:5401}的飾品：裝備上它",

	-- Step 5: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "爪牙的天譴石",
	-- {zone:1422} Western Plaguelands · {item:12840} Minion's Scourgestone · {area:197} Sorrow Hill · {area:3197} Chillwind Camp · {area:196} Uther's Tomb · {spell:120} Cone of Cold · {spell:1449} Arcane Explosion
	-- plural, as words: Flesh Golems = {npc:1805} Flesh Golem · Skeletal Guardians = {npc:10390} Skeletal Guardian · Dark Summoners = {npc:8551} Dark Summoner
	["Kill the Scourge of the {zone:1422} with the Commission on: skeletons, ghouls and cultists (level 50-58) drop a {item:12840} about two kills in five. {area:197}, just east of {area:3197} around {area:196}, is the closest farm. Avoid the Flesh Golems that patrol the fields; Skeletal Guardians cast {spell:120} and {spell:1449} up close, Dark Summoners run for help at low health."] = "戴著委任徽章在{zone:1422}殺天災：骷髏、食屍鬼和教徒（50-58級）約五次擊殺掉兩個{item:12840}。{area:197}，就在{area:3197}以東、{area:196}周圍，是最近的刷怪點。避開在田野巡邏的血肉傀儡；骷髏守衛會近身施放{spell:120}和{spell:1449}，黑暗召喚者低血量時會逃跑求援。",
	-- {item:12840} Minion's Scourgestone
	["{item:12840} x20"] = "{item:12840} × 20",

	-- Step 6: High Priest Thel'danis
	-- {npc:1854} High Priest Thel'danis · {area:196} Uther's Tomb · {area:197} Sorrow Hill · {item:20612} Inert Scourgestone
	["{npc:1854} keeps watch at {area:196} on {area:197}, east of the camp. He turns your 20 stones into one {item:20612}: keep it."] = "{npc:1854}在營地以東{area:197}的{area:196}守望。他會把你的20塊天災石合成一個{item:20612}：留著它。",

	-- Step 7: Commander Ashlam Valorfist
	-- {area:3197} Chillwind Camp · {area:1417} Sunken Temple
	["Back to {area:3197}. Ashlam needs the voodoo of the {area:1417}'s trolls for the stone."] = "回到{area:3197}。阿什蘭需要{area:1417}食人妖的巫毒來製作石頭。",

	-- Step 8: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["{area:1477}, the {area:1417}, lies in the {area:74} in eastern {zone:1435}: go up the ruin's stairs, dive into the flooded hall and follow the stairs down to the portal. It is a dungeon for a group of five at about 50-55. Six elite troll minibosses (level 51-52) stand on the balconies around the temple's great round room, each behind a pack of elites on its side path. Each drops its feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green; you need all six. Hukku calls guardians and throws Shadow Bolt Volleys, Mijan heals: kill them first."] = "{area:1477}，即{area:1417}，位於{zone:1435}東部{area:74}裡：走上廢墟的臺階，潛入被水淹沒的大廳，沿樓梯向下走到傳送門。這是一個約50-55級五人小隊的地城。六個精英食人妖小頭目（51-52級）站在神廟大圓廳周圍的陽臺上，各自守在其側路的一群精英之後。它們每次都會掉落自己的羽毛：加舍爾和琥珀色的{npc:5716}、胡庫和藍色的米詹、佐洛和綠色的洛羅；六根都需要。胡庫會召喚守衛並投擲暗影箭雨，米詹會治療：先殺它們。",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606} x2: Gasher, {npc:5716}"] = "{item:20606} x2：加舍爾、{npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607} x2: Hukku, Mijan"] = "{item:20607} x2：胡庫、米詹",
	-- {item:20608} Green Voodoo Feather
	["{item:20608} x2: Zolo, Loro"] = "{item:20608} x2：佐洛、洛羅",

	-- Step 9: Forging the Mightstone
	-- {area:3197} Chillwind Camp · {item:20620} Holy Mightstone · {item:20505} Chivalrous Signet · {item:20504} Lightforged Blade · {item:20512} Sanctified Orb · {area:2279} Stratholme · {area:2057} Scholomance
	["Back to Ashlam in {area:3197}: he forges the {item:20620}. Look at the reward window before you hand in: Classic also offered the {item:20505}, the {item:20504} or the {item:20512}, and Forever's notes say that choice may be gone. Use the stone before a fight against undead ({area:2279}, {area:2057}): it lasts ten minutes and is gone after one use."] = "回到{area:3197}的阿什蘭處：他鍛造{item:20620}。交任務前先看獎勵視窗：經典版還會提供{item:20505}、{item:20504}或{item:20512}，而Forever的說明稱該選擇可能已經取消。在與亡靈戰鬥前使用石頭（{area:2279}、{area:2057}）：它持續十分鐘，用一次就消失。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "{zone:1422}各處的天譴軍團會掉落爪牙的天譴石。",
	-- ["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477}位於{zone:1435}東部的{area:74}。在裡面，加什爾和{npc:5716}會掉落{item:20606}，胡庫和米杉掉落藍色的，祖羅和洛若爾掉落綠色的。",
	-- ["{item:20606}, inside"] = "{item:20606}，在裡面",
	-- ["{item:20607}, inside"] = "{item:20607}，在裡面",
	-- ["{item:20608}, inside"] = "{item:20608}，在裡面",
	-- ["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838}指揮{zone:1422}南部的{area:3197}。",
	-- ["{npc:5149} is in the {object:32362}."] = "{npc:5149}在{object:32362}。",
	-- ["{npc:928} is in the Cathedral of Light."] = "{npc:928}在光明大教堂裡。",
}
