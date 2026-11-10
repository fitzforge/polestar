-- Korean (koKR): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "은빛 여명회 평판",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	["Scourgestones, {area:2057} and {area:2279}: the shoulder resistance enchants and a dozen recipes."] = "",
	["Recipes for Tailors, Leatherworkers, Blacksmiths, Enchanters and Alchemists from Honored and Revered"] = "",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (얼라이언스)",
	-- {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10840} stands in {area:3197}, in the south of the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (호드)",
	-- {npc:10839} Argent Officer Garush · {area:152} Bulwark · {zone:1420} Tirisfal Glades · {zone:1422} Western Plaguelands · {object:2160} The Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	["{npc:10839} stands at the {area:152}, on the road from {zone:1420} into the {zone:1422}. {object:2160} starts at Neutral 200 for everyone. Wear the Commission trinket while you fight the Scourge: Scourgestones only drop while you wear it. {npc:11039} at {area:2268} gives the same Commission; you can only take one."] = "",

	-- Step 3: Neutral to Friendly: Scourge of the Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Neutral to Friendly: Scourge of the {zone:1422}"] = "",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {quest:5510} Minion's Scourgestones · {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Every Scourge kill in the Plaguelands gives 5 reputation (named ones 15), from the level 50 ghouls and skeletons up; at level 60 pick the level 53 and up ones, since in Classic grey mobs give only about a fifth. Neutral to Friendly is 2,800: about 560 kills, fewer with the Plaguelands quests on the way. The densest Scourge stand around the four Scourge Cauldrons: {area:199} west of Andorhal (skeletons, 50-53), {area:200} north of Andorhal (zombies and ghouls, 52-55), the {area:202} in the south (ghouls, 54-55) and {area:201} in the east (ghosts, 56-57). Keep every Scourgestone and every quest you can save: turn-ins never stop counting, kills do. {quest:5510} drop from about four in ten of these Scourge, Invader's from about a third of the level 56 and up ones. If you die, take the Commission off and put it back on: it can lose its effect. Paladins (Human and Dwarf): {npc:10838} at {area:3197} asks 20 {quest:5510} once for Dispelling Evil, 100 reputation instead of 25. The Legacy perk Diplomat adds up to 10% to every gain."] = "",
	-- {quest:5510} Minion's Scourgestones
	["{quest:5510}: keep them"] = "",
	-- {area:201} Gahrron's Withering
	-- plural, as words: Hungering Wraiths = {npc:1802} Hungering Wraith
	["Hungering Wraiths at {area:201}; any Scourge counts"] = "",
	-- {area:202} Writhing Haunt
	-- plural, as words: Soulless Ghouls = {npc:1794} Soulless Ghoul
	["Soulless Ghouls at the {area:202}"] = "",

	-- Step 4: Plaguelands quests and the Scourge Cauldrons
	-- plural, as words: Scourge Cauldrons = {object:176392} Scourge Cauldron
	["Plaguelands quests and the Scourge Cauldrons"] = "",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {npc:11055} Shadow Priestess Vandis · {area:152} Bulwark · {npc:1852} Araj the Summoner · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:12250} Zaeldarr the Outcast · {npc:11038} Caretaker Alen · {npc:11056} Alchemist Arbington · {npc:11057} Apothecary Dithers · {item:13370} Vitreous Focuser · {item:14047} Runecloth · {area:201} Gahrron's Withering · {item:13354} Ectoplasmic Resonator
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["The Plaguelands quests pay in full at 60 from level 55 up and never stop counting, about 1,500 in all; the leveling guides walk them. The cauldron chain from {npc:11053} at {area:3197} (Horde: {npc:11055} at the {area:152}): 150 per cauldron with its return, then Mission Accomplished! 200. Alas, Andorhal 150 ({npc:1852}, elite). At {area:2268}, {npc:11063}'s {area:2262} quests (Brother Carlin 50 from Chromie in Andorhal, Villains of Darrowshire 100, Marauders of Darrowshire 100) and {npc:10926}'s Hidden Treasures 200 at the end of the {area:2262} story; {npc:12250} 75 from {npc:11038}. After Mission Accomplished!, each cauldron takes a repeatable delivery: 25 reputation every time, until Exalted. {npc:11056} at {area:3197} (Horde: {npc:11057} at the {area:152}) gives you a {item:13370}, without which the reagents never drop, and sells Arcane Quickeners for 50 silver (one per delivery; it crumbles after 30 minutes, so buy it last). Each delivery also takes 4 {item:14047}. Farm {area:201}: its ghosts drop an {item:13354} about one time in four, so about 16 kills fill a delivery; the other cauldrons want 5 or 6 reagents that drop one time in ten or less. Once the Plaguelands Scourge stop counting, this earns about four times what their Scourgestones alone do."] = "",
	-- {npc:11056} Alchemist Arbington · {item:13370} Vitreous Focuser
	["{npc:11056}: ask for a {item:13370}"] = "",
	-- {npc:11057} Apothecary Dithers · {area:152} Bulwark · {item:13370} Vitreous Focuser
	["{npc:11057}, at the {area:152}: ask for a {item:13370}"] = "",
	-- {area:201} Gahrron's Withering
	["the cauldron at {area:201}"] = "",
	-- plural, as words: Ectoplasmic Resonators = {item:13354} Ectoplasmic Resonator
	["Ectoplasmic Resonators: the ghosts around the cauldron"] = "",
	-- {item:13320} Arcane Quickener
	["{item:13320}, 50 silver"] = "",

	-- Step 5: Light's Hope Chapel quests
	-- {area:2268} Light's Hope Chapel
	["{area:2268} quests"] = "",
	-- {area:2268} Light's Hope Chapel · {zone:1423} Eastern Plaguelands · {faction:529} Argent Dawn · {npc:11039} Duke Nicholas Zverenhoff · {npc:11035} Betina Bigglezink · {npc:243254} Leonid Barthalomew · {area:2279} Stratholme · {area:2057} Scholomance · {object:176317} Argent Hold
	["{area:2268}, on the east side of the {zone:1423}, is the {faction:529}'s home: {npc:11039}, {npc:11035} and {npc:243254} give its dungeon quests, 100 to 200 reputation each and about 1,700 in all. They are group quests for {area:2279} and {area:2057} (level 58-60, five players): take the ones your group will run. The Duke's chain ends at the {object:176317}, a chest of {faction:529} gear."] = "",

	-- Step 6: Stratholme
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare · {item:12843} Corruptor's Scourgestone
	["{area:2279} is a group of five at the north end of the {zone:1423}. Its Scourge give 5 reputation a kill up to the last point of Honored, and its Scourge bosses 25 until Exalted ({npc:10440} 50), each with a {item:12843}. The Black Guard Sentries by the Baron give 5 until Exalted. The Scourge side, through the service entrance, pays far more than the Scarlet side."] = "",
	-- plural, as words: Plagued Flesh Samples = {item:13174} Plagued Flesh Sample
	["Plagued Flesh Samples: the Scourge inside"] = "",
	-- {item:13180} Stratholme Holy Water
	["{item:13180}: the supply crates"] = "",
	-- {npc:10811} Archivist Galford
	["{npc:10811}, Scarlet side"] = "",

	-- Step 7: Scholomance
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {faction:529} Argent Dawn · {quest:5508} Corruptor's Scourgestones · {npc:10508} Ras Frostwhisper · {npc:1853} Darkmaster Gandling
	["{area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}; your side's {area:2057} quests give the {item:13704} that opens it. It is the best {faction:529} run: its mobs give 5 up to the last point of Honored, and its thirteen bosses about 375 reputation a full clear plus ten or so {quest:5508} (about 250 more). {npc:10508} and {npc:1853} give 50 each."] = "",
	-- {quest:5529} Plagued Hatchlings
	["{quest:5529}, in the hatchery"] = "",

	-- Step 8: Back at Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back at {area:2268}"] = "",
	-- {quest:5212} The Flesh Does Not Lie · {quest:5213} The Active Agent · {item:13176} Scourge Data · {area:2279} Stratholme · {item:13209} Seal of the Dawn · {item:19812} Rune of the Dawn · {quest:5251} The Archivist · {item:13250} Head of Balnazzar · {npc:10440} Baron Rivendare · {item:13920} Healthy Dragon Scale · {quest:5529} Plagued Hatchlings · {npc:10267} Tinkee Steamboil · {zone:1428} Burning Steppes · {area:1583} Blackrock Spire · {npc:243254} Leonid Barthalomew · {npc:11035} Betina Bigglezink · {item:12368} Dawn's Gambit · {area:2057} Scholomance
	["{quest:5212} leads to {quest:5213} (the {item:13176} in a {area:2279} ziggurat), which rewards the {item:13209} or the {item:19812}: better trinkets that also make Scourgestones drop, so they can replace the Commission. {quest:5251} leads on to the {item:13250} and {npc:10440}. A {item:13920}, a rare drop (about 6%) from the {quest:5529} once {quest:5529} is done, starts a quest worth 50 each time: keep them until Revered. {npc:10267} in the {zone:1428}, at the end of her {area:1583} quests, sends you to {npc:243254} (75) and on to {npc:11035}'s {item:12368} in {area:2057} (25 and 200)."] = "",

	-- Step 9: Friendly to Honored: stones and named Scourge
	["Friendly to Honored: stones and named Scourge"] = "",
	-- {npc:10826} Lord Darkscythe · {npc:10821} Hed'mush the Rotting · {npc:10825} Gish the Unmoving · {area:2057} Scholomance · {area:2279} Stratholme · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {area:3197} Chillwind Camp · {area:152} Bulwark · {item:12844} Argent Dawn Valor Token · {quest:5509} Invader's Scourgestones · {area:2272} Northdale · {item:12843} Corruptor's Scourgestone · {npc:1850} Putridius
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage · Dread Weavers = {npc:8528} Dread Weaver · Scourge Champions = {npc:8529} Scourge Champion · Enriched Manna Biscuits = {item:13724} Enriched Manna Biscuit
	["Normal Scourge outside the dungeons stop giving reputation halfway through Friendly (3,000 of 6,000); {npc:10826}, {npc:10821} and {npc:10825} stop at the end of Friendly. After that only Araj, the {area:2057} and {area:2279} mobs, the cauldron deliveries and Scourgestones count. Now turn in the stones you saved: {npc:11039} at {area:2268} takes all three kinds, and so do the officers at {area:3197} and the {area:152}. Every turn-in pays 25 and an {item:12844}: keep 35 tokens for the mantles at Revered and Exalted. {quest:5509} are worth twice as much per stone: the Dark Adepts, Shadowmages, Dread Weavers and Scourge Champions (level 58-60) at {area:2272}, just north of {area:2268}, drop them about a third of the time or more, next to the turn-in. The named Scourge below drop a {item:12843} half the time or more ({npc:1850} two times in three, Araj and {npc:10821} half the time) and give 15 a kill, Araj until Exalted; {npc:1850} gives no reputation, only the stone. Friendly opens the Enriched Manna Biscuits (60 silver) at the quartermasters."] = "",
	-- {item:12843} Corruptor's Scourgestone
	["{item:12843}: the named Scourge below, and dungeon bosses"] = "",
	-- {area:2272} Northdale
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Shadowmages = {npc:8550} Shadowmage
	["Dark Adepts and Shadowmages at {area:2272}"] = "",
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
	-- {area:2057} Scholomance · {area:2279} Stratholme · {quest:5509} Invader's Scourgestones · {npc:11536} Quartermaster Miranda Breechlock · {area:2268} Light's Hope Chapel · {npc:10857} Argent Quartermaster Lightspark · {area:3197} Chillwind Camp · {npc:10856} Argent Quartermaster Hasana · {area:152} Bulwark · {item:22014} Hallowed Brazier
	["Honored to Revered is 12,000: about 2,400 {area:2057} and {area:2279} mobs, fewer with their bosses. Their mobs stop at 11,999 of 12,000 Honored; a boss or a turn-in takes you over. Solo, only Scourgestones, the cauldron deliveries and Araj count: 12,000 is 480 turn-ins, or 4,800 {quest:5509}. Keep the stones you get in the dungeons until their mobs stop counting. Honored opens recipes at all three quartermasters: {npc:11536} at {area:2268}, {npc:10857} at {area:3197}, {npc:10856} at the {area:152}. Also the {item:22014} (133 gold) for the Three Kings of Flame quest."] = "",
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
	-- {quest:5508} Corruptor's Scourgestones · {area:2057} Scholomance · {item:13920} Healthy Dragon Scale
	["Revered to Exalted is 21,000: 840 Scourgestone or cauldron turn-ins, or the dungeon bosses with their {quest:5508} (a full {area:2057} clear is about 600). Turn in every stone and {item:13920} you saved."] = "",

	-- Step 13: Chromatic Mantle of the Dawn
	-- {npc:11536} Quartermaster Miranda Breechlock · {quest:5517} Chromatic Mantle of the Dawn
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["At Exalted, {npc:11536} takes 25 Argent Dawn Valor Tokens for the {quest:5517} (150 reputation): +5 to every resistance, on your shoulders. After it, the quartermasters sell more for 40 gold each."] = "",
	-- plural, as words: Argent Dawn Valor Tokens = {item:12844} Argent Dawn Valor Token
	["Argent Dawn Valor Tokens"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Corruptor's Scourgestones and dungeons to Revered"] = "{item:12843}와(과) 던전: 매우 우호적까지",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "{npc:8546}와(과) 어둠마법사(58-60레벨)가 이곳에서 {item:12841}을(를) 떨어뜨리며, 앞잡이의 스컬지석과 {item:14047}도 떨어뜨립니다. {area:2268}의 {npc:11039}에게 침입자의 스컬지석은 10개씩, 앞잡이의 스컬지석은 20개씩 제출하세요. 클래식에서는 둘 다 우호적부터 평판을 주지 않습니다.",
	-- ["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "우호적부터는 {item:12843}(제출당 1개)와(과) {area:2279}, {area:2057}의 스컬지 처치가 평판을 줍니다. 타락자의 스컬지석은 그곳의 스컬지 우두머리({npc:1853}, {npc:10433}, 벡투스)와 {zone:1422}의 {npc:1852}, 퓨트리디우스가 떨어뜨립니다. 던전을 여러 번 도는 편이 어떤 필드 사냥보다 빠릅니다.",
	-- ["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422} 곳곳의 구울과 해골이 절반 정도의 확률로 {item:12840}을(를) 떨어뜨립니다. 이 무리는 밀집해 있습니다. 20개씩 은빛장교에게 제출하세요({area:3197}의 퓨어하트, {area:152}의 가루쉬, {area:2268}의 {npc:11039}). 제출할 때마다 은빛 병참장교에게 쓸 {item:12844}도 받습니다.",
	-- ["Invader's Scourgestones to Honored"] = "{item:12841}: 우호적까지",
	-- ["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "확고한 동맹이 될 때까지 {area:2279}와(과) {area:2057}을(를) 계속 돌고 {item:12843}을(를) 모두 {area:2268}에 제출하세요.",
	-- ["Minion's Scourgestones to Friendly"] = "{item:12840}: 약간 우호적까지",
	-- ["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "{area:2279}(양쪽 구역)와(과) {area:2057}을(를) 돌며 지나가는 스컬지를 모두 처치하세요.",
	-- ["{faction:529} to Exalted"] = "{faction:529}: 확고한 동맹까지",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}은(는) 중립에서 시작합니다. {area:152}의 {npc:10839}에게서 위임장을 받아 착용하세요. 클래식에서는 {quest:5401} 장신구를 착용해야만 스컬지석이 떨어집니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}은(는) 중립에서 시작합니다. {area:3197}의 {npc:10840}에게서 위임장을 받아 착용하세요. 클래식에서는 {quest:5401} 장신구를 착용해야만 스컬지석이 떨어집니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
}
