-- Chinese (simplified) (zhCN): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "海达希亚水元素声望",
	-- {item:17333} Aqual Quintessence · {area:2717} Molten Core · {item:22754} Eternal Quintessence
	["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "可获得用来熄灭{area:2717}符文的{item:17333}、崇敬时可重复使用的{item:22754}，以及一枚火焰抗性戒指。",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {area:2717} Molten Core
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the {area:2717}, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "{npc:13278} 站在 {zone:1447} 东海岸外的一座小岛上；游过去找他。所有人的海达希亚水元素声望都从中立开始，几乎全部声望都来自击杀火、风和土的仆从：任务本身直到最后一个才奖励声望。两个任务都接：全部完成后，任务链才会继续。尊敬之后的内容都在 {area:2717} 内，这是一个 40 人团队副本，不在暴雪已公布的无限首批团队副本之列；开放前，海达希亚水元素声望最多只能到尊敬。本指南的数值不包括传承天赋“外交家”最多额外 10% 的加成。",

	-- Step 2: Stormers and Rumblers
	-- {area:2740} Crystal Vale · {zone:1451} Silithus
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers drift around the {area:2740} in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "灰尘风暴和沙漠奔行者在 {zone:1451} 西北面的 {area:2740} 周围游荡。中立或友善时，每次击杀还给5声望，因此如果打算刷怪（见后续步骤），可以留在这里。",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {npc:8521} Blighted Horror · {npc:8522} Plague Monstrosity · {npc:13279} Discordant Surge · {item:17309} Discordant Bracers
	["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "对一只 {npc:8521} 或 {npc:8522} 使用 {item:17310}：它会变成 {npc:13279}。击杀变出的元素并拾取其 {item:17309}。共需十二个，而且交还任务时瓶子仍必须在背包中。",
	-- {item:17310} Aspect of Neptulon
	["{item:17310}, on the poisoned elementals"] = "对中毒的元素使用{item:17310}",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "回到{npc:13278}处",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension · {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in {area:1584} pays 15 the same way."] = "{npc:9816} 是黑石塔上层的首领，位于 {area:254} 内：小队最多十人，需要有人持有 {item:12344} 才能开门。他会掉落眼睛，每次击杀奖励50点声望，直到尊敬12,000中的11,999点。{area:1584} 的 {npc:9017} 以同样规则奖励15点。",
	-- {quest:6821} Eye of the Emberseer
	["{quest:6821}: raid of ten"] = "{quest:6821}：10 人团队",

	-- Step 6: Attunement to the Core
	-- {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {area:2717} Molten Core · {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{npc:14387} in {area:254} attunes you to the {area:2717}: bring him a {item:18412} from beside the {area:2717}'s portal at the bottom of {area:1584}. Once attuned, he can send you straight into the {area:2717}."] = "{area:254}的{npc:14387}能为你取得{area:2717}的入场资格：从{area:1584}底部、{area:2717}传送门旁带回一个{item:18412}给他。取得资格后，他就能直接将你传入{area:2717}。",
	-- {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{item:18412}, at the portal in {area:1584}"] = "{item:18412}，在{area:1584}的传送门旁",

	-- Step 7: The Molten Core
	-- {quest:6822} The Molten Core · {npc:11658} Molten Giant · {npc:11668} Firelord · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {npc:13278} Duke Hydraxis · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Firelords = {npc:11668} Firelord · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "{quest:6822} 需要40人团队。为 {npc:13278} 各击杀一只 {npc:11658}、{npc:11668}、{npc:11673} 和 {npc:12101}。那里的所有元素怪都会奖励声望：火焰行者、烈焰守卫、熔岩元素、熔岩掠夺者和熔核摧毁者各40点，火焰之王、熔岩奔腾者、熔核巨人和上古熔火恶犬各20点，直到尊敬12,000中的11,999点；完整清掉普通怪约获3,360点。首领各奖励100点（{npc:11988} 为150点，{npc:11502} 为200点）。",
	-- {npc:11658} Molten Giant
	["{npc:11658}: raid of 40"] = "{npc:11658}：40人团队",

	-- Step 8: Elementals to Honored
	["Elementals to Honored"] = "刷元素至尊敬",
	-- {quest:6823} Agent of Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {area:2740} Crystal Vale · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths · {npc:9816} Pyroguard Emberseer
	["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One {area:2717} clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "从中立到尊敬需要9,000声望，而 {quest:6823} 要求达到尊敬。通关一次 {area:2717} 大约可得4,000。没有团队时就刷元素：每只 {npc:11744}、{npc:11746} 或 {npc:7032}（{zone:1428}）给5点，从中立起约需1,800次击杀。它们到友善5,999/6,000时不再提供声望，差最后一点，所以要击杀此时仍有声望的目标：{area:2740} 的稀有空气元素 {npc:14478}（25点），或五人地下城 {area:1584} 中 {object:174825} 处的 {npc:9017}（15点）。这两个目标和 {npc:9816} 在尊敬阶段也会继续提供声望。",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "{npc:14478}，稀有，25",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "{npc:9017}，{area:1584}：15 点声望，组队完成",

	-- Step 9: Agent of Hydraxis
	-- {npc:13278} Duke Hydraxis · {quest:6823} Agent of Hydraxis
	["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "回去找 {npc:13278}。声望一到尊敬，{quest:6823} 就会完成。",

	-- Step 10: Hands of the Enemy
	-- {npc:12118} Lucifron · {npc:12259} Gehennas · {npc:12264} Shazzrah · {npc:12098} Sulfuron Harbinger · {area:2717} Molten Core
	["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}、{npc:12259}、{npc:12264}和{npc:12098}都是{area:2717}首领：各自会掉落任务所需的手。",
	-- {item:17332} Hand of Shazzrah
	["{item:17332}: raid of 40"] = "{item:17332}：40人团队",

	-- Step 11: A Hero's Reward
	-- {object:179551} Hydraxis' Coffer · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the {area:2717} to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "交还手掌，然后潜入小岛南侧山脚的海水中：{object:179551}中有你的戒指，并奖励海达希亚水元素唯一的任务声望，共200。从此以后，只要声望保持尊敬或更高，公爵就会给你{item:17333}：将它倒在{area:2717}的符文上即可熄灭符文。所有符文都熄灭后，{npc:12018}就会出现，之后是{npc:11502}。",
	-- {item:17333} Aqual Quintessence
	["{item:17333}, ask the Duke"] = "{item:17333}，向公爵索取",

	-- Step 12: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "在 {area:2717} 提升至崇敬。",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "从尊敬到崇敬需要12,000声望。小怪仍提供声望，因此完整通关一次，小怪约给3,360，七名首领共700，另有 {npc:11988} 的150和 {npc:11502} 的200：大约三次即可。尊敬时，{npc:9017}（15）和 {npc:9816}（50）也提供声望。小怪到尊敬11,999/12,000时停止提供声望；靠首领跨过最后一点。",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "{npc:12118} 及其他首领，100点：可让你越过11,999点门槛",

	-- Step 13: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "{item:22754}",
	-- {item:22754} Eternal Quintessence · {item:17333} Aqual Quintessence
	["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "崇敬后，公爵会给你 {item:22754}：它的作用与 {item:17333} 相同，而且不会消耗，再也不必回来领取新的水瓶。",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "{item:22754}，向公爵索取",

	-- Step 14: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "在 {area:2717} 提升至崇拜",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "从崇敬到崇拜需要21,000声望。小怪已不再提供，但崇敬时全部九名首领仍有声望：七名各100，{npc:11988} 给150，{npc:11502} 给200，每次通关1,050：大约20次。七名首领到崇敬20,999/21,000时停止提供，所以最后一点要靠 {npc:11988} 或 {npc:11502}；达到崇拜后，也只有这两名继续提供声望。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "这两种元素都在{zone:1451}西北部游荡；沙漠奔行者聚集在稍北一些的地方。",
	-- ["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "从{area:2717}带回鲁西弗隆之手、基赫纳斯之手、沙斯拉尔之手和萨弗隆之手。",
	-- ["Dust Stormers and Desert Rumblers"] = "灰尘风暴和沙漠奔行者",
	-- ["Keep clearing the {area:2717} until Exalted."] = "继续通关{area:2717}，直到崇拜。",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "在{area:2717}中击杀一个{npc:11668}、一个{npc:11658}、一只{npc:11673}和一个{npc:12101}。{area:2717}中的每个元素和首领也都会提升海达希亚水元素声望。",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "对{zone:1423}中被污染的水元素使用{item:17310}，然后拾取它们的{item:17309}（12个）。",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "对{zone:1423}中被污染的水元素使用{item:17310}，然后拾取它们的{item:17309}（12个）。我们的数据中没有这些元素的刷新点。",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "剩下的靠通关{area:2717}。首领总能给声望；在经典版中，小怪到一定声望后就不再给海达希亚水元素声望，所以后期主要靠首领。",
	-- ["{faction:749} to Exalted"] = "{faction:749}刷到崇拜",
	-- ["{faction:749} to Revered"] = "{faction:749}刷到崇敬",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278}站在{zone:1447}东海岸外的一座小岛上；游过去或沿浅滩走过去。{faction:749}初始为中立。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "黑石塔上层的{npc:9816}掉落{quest:6821}。需要一支团队。",
	-- ["{npc:9816} in Upper {area:1583} drops the {quest:6821}. This needs a raid group."] = "{area:1583}上层的{npc:9816}掉落{quest:6821}。这需要团队。",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}需要尊敬。尊敬时，{npc:13278}会给予{item:17333}，用来熄灭{area:2717}中的符文以召唤{npc:12018}；崇敬时给予可重复使用的{item:22754}。",
}
