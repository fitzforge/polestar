-- Chinese (traditional) (zhTW): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "奧拉赫寶珠",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "30多級後期的副手寶珠或法杖，走地獄犬或地獄火的路線，任你選擇。",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in Ratchet."] = "",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in Ratchet."] = "",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in Ratchet."] = "",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in Ratchet. The zeppelin from {zone:1420} flies to {zone:1411}."] = "",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan
	["{npc:6266} and her two acolytes stand in {npc:6251}'s tower on the hill above Ratchet."] = "",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "選擇一名侍僧",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, the shadow versions; {npc:6252}'s infernal path with the Orb or {item:15105}, much the same items on the fire side. Most warlocks lean on shadow, but compare the four in their tooltips first. The guide follows the one you take. Keep the ruby or the emerald: it is handed back."] = "",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}：她會給你{item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}：他會給你{item:12646}",

	-- Step 7: Mannoroc Coven
	["Mannoroc Coven"] = "",
	-- {zone:1443} Desolace · {object:176946} Shadowprey Village (no name in this language: may be words) · {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter · Ley Hunters = {npc:4685} Ley Hunter · Lesser Infernals = {npc:4676} Lesser Infernal
	["Mannoroc Coven fills south-central {zone:1443}, east of {object:176946}. The Burning Blade Summoners (level 38-39, warlocks with imps) carry the {item:7291} every time. For the spirit, bring your demon to low health with your damage over time, then channel the ruby or the emerald on it and keep channelling while it dies, as with Drain Soul: the gem does no damage of its own. The ruby works on the coven's felhounds: the two Mana Eaters (37-38) in the north, and the Mage Hunters (38) and Ley Hunters (39) further south. The emerald works on the Lesser Infernals (36-37, sixteen of them, fire-resistant)."] = "",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}，來自火刃召喚師",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater · {npc:4681} Mage Hunter · {npc:4685} Ley Hunter
	["{item:12648}, from a {npc:4678}, {npc:4681} or {npc:4685}"] = "",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}，來自{npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "惡魔的靈魂",
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266} in the tower above Ratchet with the spirit and the gem first: her orb follows from it."] = "",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {npc:6549} Demon of the Orb
	["{npc:6546} lives at her farm in the middle of {zone:1445}, south of the road from the {zone:1413} and south-west of Theramore; a spirit healer stands beside it. Deadmire, a level 45 crocolisk, patrols the creeks just north-east. Before you accept Cleansing, clear the spiders and crocolisks around her paddock. Accepting starts a 3-minute timer: she walks to the paddock and lets the {npc:6549} out. It is elite (level 40): grouping up is encouraged; a warlock of about 40 can solo it with Fear or Banish and damage over time, a level 35-38 one brings a friend. The timer keeps running after the kill, so hand in at once. If time runs out, abandon the quest and take it from {npc:6546} again."] = "",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above Ratchet with the cleansed orb. On the felhound path, accept her last quest and wait beside her while she completes the {item:15108} (do not attack her: the quest log calls it a kill), then speak to her again and pick the off-hand orb or the staff."] = "",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she makes the orb"] = "",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, accept her last quest and wait beside {npc:6266} while she completes the {item:15107}, then speak to her again and pick the off-hand orb or the staff."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "35級時，{object:172960}的{npc:3326}會派你去找{area:392}的{npc:6266}。",
	-- ["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "35級時，{object:36082}的{npc:4563}會派你去找{area:392}的{npc:6266}。從{zone:1420}出發的飛艇飛往{zone:1411}。",
	-- ["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "35級時，{object:2101}{object:2164}的{npc:461}會派你去找{area:392}的{npc:6266}。",
	-- ["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "35級時，{zone:1455}的{npc:5172}會派你去找{area:392}的{npc:6266}。",
	-- ["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "帶著淨化過的寶珠回到{area:392}上方塔裡的{npc:6266}那裡。走地獄犬路線時，等她完成{item:15108}，然後再和她說話。",
	-- ["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "先帶著靈魂回到{area:392}上方塔裡的{npc:6266}：之後才是{npc:6546}的淨化。",
	-- ["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "走地獄火路線時，等{npc:6266}完成{item:15107}，然後再和她說話。",
	-- ["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "選擇一名侍僧：他們的任務你只能接其中一個。{npc:6254}的地獄犬路線最後獲得寶珠或{item:15106}，{npc:6252}的地獄火路線最後獲得寶珠或{item:15105}。本指南會依照你接的那條路線。",
	-- ["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "{zone:1443}南部{area:602}的惡魔有你需要的一切。火刃召喚師帶著{item:7291}。走地獄犬路線時，對地獄犬{npc:4678}使用{item:12647}，然後擊殺牠取得靈魂；走地獄火路線時，對{npc:4676}使用{item:12646}並擊殺牠。",
	-- ["Wait for the orb"] = "等待寶珠完成",
	-- ["{item:12648}, from a {npc:4678}"] = "{item:12648}，來自{npc:4678}",
	-- ["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}和她的兩名侍僧站在{area:392}上方山丘的塔裡，就在{npc:6251}旁邊。",
	-- ["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546}住在{zone:1445}西部她的農場。她會從{item:7291}中召喚出{npc:6549}；它是精英：建議組隊。",
}
