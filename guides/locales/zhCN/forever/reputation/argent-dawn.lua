-- Chinese (simplified) (zhCN): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "银色黎明声望",
	["Scourgestones, Scholomance and Stratholme: the shoulder resistance enchants and a dozen recipes."] = "",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "尊敬和崇敬时可获得裁缝、制皮、锻造、附魔和炼金术配方",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401}（联盟）",
	-- {npc:10840} Argent Officer Pureheart · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff
	["{npc:10840} stands in Chillwind Camp, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at Light's Hope Chapel gives the same Commission; you can only take one."] = "",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401}（部落）",
	-- {npc:10839} Argent Officer Garush · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff
	["{npc:10839} stands at the Bulwark, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at Light's Hope Chapel gives the same Commission; you can only take one."] = "",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "",
	-- {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: Felstone Field west of Andorhal (skeletons, 50-53), Dalson's Tears north of Andorhal (zombies and ghouls, 52-55), the Writhing Haunt in the south (ghouls, 54-55) and Gahrron's Withering in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at Chillwind Camp asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "",
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at Gahrron's Withering; any Scourge counts"] = "",
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the Writhing Haunt"] = "",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "",
	-- {npc:11053} High Priestess MacDonnell · {npc:11055} Shadow Priestess Vandis · {npc:1852} Araj the Summoner · {npc:11063} Carlin Redpath · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at Chillwind Camp (Horde: {npc:11055} at the Bulwark): 150 per cauldron with its return (Felstone Field's pair is level 53: in Classic it pays three fifths at 60), then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At Light's Hope Chapel, {npc:11063}'s Darrowshire quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the Darrowshire story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at Chillwind Camp (Horde: {npc:11057} at the Bulwark) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm Gahrron's Withering: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "",
	-- {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser
	["{npc:11057}, at the Bulwark: ask for a {item:13370}"] = "",
	["the cauldron at Gahrron's Withering"] = "",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "",

	-- Step 5: Light's Hope Chapel quests
	["Light's Hope Chapel quests"] = "",
	-- {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243254} Leonid Barthalomew · {object:176317} Argent Hold
	["Light's Hope Chapel, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243254} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for Stratholme and Scholomance (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "",

	-- Step 6: Stratholme
	["Stratholme"] = "",
	-- {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["Stratholme is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "",

	-- Step 7: Scholomance
	["Scholomance"] = "",
	-- {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["Scholomance lies under Caer Darrow, the island town in the south-east of the {zone:1422}; your side's Scholomance quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "",

	-- Step 8: Back at Light's Hope Chapel
	["Back at Light's Hope Chapel"] = "",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {npc:243254} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a Stratholme ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her Blackrock Spire quests, sends you to {npc:243254} (75) and on to {npc:11035}'s {item:12368} in Scholomance (25 and 200)."] = "",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {npc:11039} Duke Nicholas Zverenhoff · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the Scholomance and Stratholme mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at Light's Hope Chapel takes all three kinds, and so do the officers at Chillwind Camp and the Bulwark. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at Northdale, just north of Light's Hope Chapel, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "",
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at Northdale"] = "",
	-- {npc:1852} Araj the Summoner
	["{npc:1852}, Andorhal"] = "",
	-- {npc:1850} Putridius · {zone:1422} Western Plaguelands
	["{npc:1850}, {zone:1422}: the stone only"] = "",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: 20 for 25 reputation"] = "",
	-- {quest:5509} Invader's Scourgestones
	["{quest:5509}: 10 for 25 reputation"] = "",
	-- {quest:5508} Corruptor's Scourgestones
	["{quest:5508}: 1 for 25 reputation"] = "",

	-- Step 10: Honored to Revered: dungeons and stones
	["Honored to Revered: dungeons and stones"] = "",
	-- {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {npc:10857} Argent Quartermaster Lightspark · {npc:10856} Argent Quartermaster Hasana · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 Scholomance and Stratholme mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at Light's Hope Chapel, {npc:10857} at Chillwind Camp, {npc:10856} at the Bulwark. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "",
	-- {item:19446} Formula: Enchant Bracer - Mana Regeneration
	["{item:19446}, 3 gold"] = "",
	-- {item:19216} Pattern: Argent Boots · {skill:197} Tailoring
	["{item:19216} ({skill:197}), 2 gold 20 silver"] = "",
	-- {item:19328} Pattern: Dawn Treaders · {skill:165} Leatherworking
	["{item:19328} ({skill:165}), 2 gold 20 silver"] = "",
	-- {item:19203} Plans: Girdle of the Dawn · {skill:164} Blacksmithing
	["{item:19203} ({skill:164}), 2 gold 20 silver"] = "",
	-- {item:13482} Recipe: Transmute Air to Fire · {skill:171} Alchemy
	["{item:13482} ({skill:171}), 1 gold 50 silver"] = "",
	-- {item:19442} Formula: Powerful Anti-Venom · {skill:129} First Aid
	["{item:19442} ({skill:129}), 10 gold"] = "",

	-- Step 11: Mantles of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5504} Mantles of the Dawn · {faction:529} Argent Dawn · {item:18173} Shadow Mantle of the Dawn · {item:13810} Blessed Sunfruit
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Revered, {npc:11536} takes 10 Argent Dawn Valor Tokens for {quest:5504} (100 reputation). After it, any {faction:529} quartermaster sells the five shoulder enchants for 10 gold each: Flame, Frost, Arcane, Nature and {item:18173}, +5 to that resistance. Revered also opens the {item:13810} and its juice (60 silver) and the Revered recipes."] = "",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens, from the stone turn-ins"] = "",
	-- {item:18170} Frost Mantle of the Dawn
	["{item:18170}: pick the resistance you need, 10 gold"] = "",
	-- {item:19447} Formula: Enchant Bracer - Healing
	["{item:19447}, 6 gold"] = "",
	-- {item:19217} Pattern: Argent Shoulders · {skill:197} Tailoring
	["{item:19217} ({skill:197}), 4 gold"] = "",
	-- {item:19329} Pattern: Golden Mantle of the Dawn · {skill:165} Leatherworking
	["{item:19329} ({skill:165}), 4 gold"] = "",
	-- {item:19205} Plans: Gloves of the Dawn · {skill:164} Blacksmithing
	["{item:19205} ({skill:164}), 4 gold"] = "",

	-- Step 12: Revered to Exalted
	["Revered to Exalted"] = "",
	-- {quest:5508} Corruptor's Scourgestones · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full Scholomance clear is about 600). Turn in every stone and {item:13920} you saved."] = "",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "用堕落者的天灾石和地下城刷到崇敬",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "这里的黑暗教徒和暗影法师（58-60级）掉落侵略者的天灾石，还有爪牙的天灾石和{item:14047}。把侵略者的天灾石每10个、爪牙的天灾石每20个交给{area:2268}的{npc:11039}。在经典版中，两者到尊敬后就不再给声望。",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "从尊敬开始，声望来自堕落者的天灾石（每次交还一个）和在{area:2279}、{area:2057}中击杀天灾军团。堕落者的天灾石由那里的天灾首领（{npc:1853}、{npc:10433}、维克图斯）以及{zone:1422}的{npc:1852}和普特迪乌斯掉落。多刷地下城比任何野外刷怪都快。",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422}各处的食尸鬼和骷髅约有一半几率掉落爪牙的天灾石；这一片怪物密集。每20个交给任意一位银色黎明军官（{area:3197}的普尔哈特、{area:152}的加鲁什、{area:2268}的{npc:11039}）。每次交还还会得到一枚{item:12844}，可在银色黎明军需官处使用。",
	-- ["Invader's Scourgestones to Honored"] = "用侵略者的天灾石刷到尊敬",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "继续刷{area:2279}和{area:2057}，并在{area:2268}交还每一个{item:12843}，直到崇拜。",
	-- ["Minion's Scourgestones to Friendly"] = "用爪牙的天灾石刷到友善",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "刷{area:2279}（两个区域）和{area:2057}，击杀沿途所有天灾军团。",
	-- ["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "天灾石、{area:2057}和{area:2279}：肩部抗性附魔和十几种配方。",
	-- ["{faction:529} to Exalted"] = "{faction:529}刷到崇拜",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始为中立。从{area:152}的{npc:10839}处领取委任徽章并装备：在经典版中，只有装备了{quest:5401}饰品时才会掉落天灾石。Forever的传承外交官特权可提高声望获取。",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始为中立。从{area:3197}的{npc:10840}处领取委任徽章并装备：在经典版中，只有装备了{quest:5401}饰品时才会掉落天灾石。Forever的传承外交官特权可提高声望获取。",
}
