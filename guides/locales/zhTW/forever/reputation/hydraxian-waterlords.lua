-- Chinese (traditional) (zhTW): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "海達希亞水元素聲望",
	-- {item:22754} Eternal Quintessence · {area:2717} Molten Core
	["The reputation kills to Honored, and the reusable {item:22754} at Revered once the {area:2717} opens."] = "擊殺到尊敬的聲望，以及{area:2717}開放後在崇敬時取得的可重複使用的{item:22754}。",

	-- Step 1: Elementals to Honored
	["Elementals to Honored"] = "元素生物到尊敬",
	-- {npc:13278} Duke Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {area:2740} Crystal Vale · {zone:1451} Silithus · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Everyone starts Neutral with the Waterlords, and their reputation comes from killing the servants of fire, air and earth. {npc:13278}'s quests aren't offered on Forever yet: they come back when the {area:2717} opens. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%.\nNeutral to Honored is 9,000 reputation. It comes from the elementals: 5 per {npc:11744} or {npc:11746}, which drift around the {area:2740} in the north-west of {zone:1451}, or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two keep paying through Honored as well."] = "每個人與水元素領主的關係都從中立開始，聲望來自擊殺火、空氣和土的僕從。{npc:13278}的任務在Forever上還未提供：等{area:2717}開放後才會回來。本指南中的數字沒有計入傳承特權外交家，它最多增加10%。\n從中立到尊敬需要9,000聲望。聲望來自元素：每隻{npc:11744}或{npc:11746}5點，牠們在{zone:1451}西北部的{area:2740}周圍遊蕩，或者{npc:7032}（{zone:1428}），從中立開始大約1,800次擊殺。牠們在友好5,999/6,000時停止，差一點，所以最後一點需要一次在那裡仍然計數的擊殺：{npc:14478}，{area:2740}中的稀有空氣元素（25），或{area:1584}的{object:174825}處的{npc:9017}（15，五人地城）。這兩者在尊敬期間也會繼續給聲望。",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "{npc:14478}，稀有，25",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "{npc:9017}，{area:1584}：15點，組隊前往",

	-- Step 2: Pyroguard Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He pays 50 reputation per kill up to 11,999 of 12,000 Honored."] = "{npc:9816}是黑石塔上層的首領，在{area:254}裡面：最多十人的小隊，需要有人帶著{item:12344}才能開門。每次擊殺他給50聲望，直到尊敬11,999/12,000。",
	-- {npc:9816} Pyroguard Emberseer
	["{npc:9816}: raid of ten"] = "{npc:9816}：十人團隊",

	-- Step 3: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "{area:2717}到崇敬",
	-- {npc:227939} The Molten Core · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{npc:227939} is a raid of 40 and not open on Forever yet. Once it is: every elemental there pays, Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash.\nHonored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "{npc:227939}是40人團隊副本，Forever上還未開放。開放後：那裡的每個元素都給聲望，火焰行者（{npc:11666}）、烈焰守衛（{npc:11667}）、熔岩元素（{npc:12076}）、熔岩掠奪者（{npc:12100}）和熔火毀滅者（{npc:11659}）40點，火焰領主、熔岩奔騰者（{npc:12101}）、熔火巨人（{npc:11658}）和上古熔火惡犬（{npc:11673}）20點，直到尊敬11,999/12,000；清完全部小怪大約3,360點。\n從尊敬到崇敬需要12,000聲望。小怪仍然計數，所以一次全清大約3,360，加上七個首領700點、{npc:11988}150點和{npc:11502}200點：大約三次全清。尊敬期間{npc:9017}（15）和{npc:9816}（50）也計數。小怪在尊敬11,999/12,000時停止；首領會讓你越過。",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "{npc:12118}和其他首領，100：他們把你帶過11,999",

	-- Step 4: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "{item:22754}",
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {item:22754} Eternal Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. At Revered he gives you the {item:22754}: pour it on a rune in the {area:2717} to douse it. It is not used up, so you never come back for another. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "{npc:13278}站在{zone:1447}東海岸外的一個小島上；游過去找他。崇敬時他會給你{item:22754}：把它倒在{area:2717}裡的符文上熄滅它。它不會用完，所以你不用再回來拿。所有符文熄滅後，{npc:12018}會出來，之後是{npc:11502}。",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "{item:22754}，向公爵索要",

	-- Step 5: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "{area:2717}到崇拜",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "崇敬到崇拜需要21,000聲望。小怪已不再計數，但在崇敬階段九個首領仍然給：七個各100，{npc:11988}給150，{npc:11502}給200，一次全清1,050：大約20次全清。那七個在崇敬20,999/21,000處停止，所以最後一點來自{npc:11988}或{npc:11502}；到崇拜之後只有這兩個還給。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "崇敬時公爵會給你{item:22754}：它能起到{item:17333}的作用，而且不會消耗，所以你不用再回來領新的瓶子。",
	-- ["Back to {npc:13278}"] = "返回{npc:13278}",
	-- ["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "回到{npc:13278}。一到尊敬，{quest:6823}就完成了。",
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "這兩種元素都在{zone:1451}西北部遊蕩；沙漠奔行者聚集在稍微更北的地方。",
	-- ["Dust Stormers and Desert Rumblers"] = "灰塵風暴與沙漠奔行者",
	-- ["Dust Stormers and Desert Rumblers drift around the {area:2740} in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "塵暴元素和沙漠奔行者在{zone:1451}西北的{area:2740}一帶遊蕩。在中立或友善階段，每殺一個還給5點聲望，所以打算刷的話就留在這裡（見後續步驟）。",
	-- ["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the {area:2717} to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "交掉那些首領之手，然後潛入島南端腳下的海浪下：{object:179551}裡放著你的戒指，並給出水元素領主唯一的任務聲望，200點。從此以後，只要你達到尊敬或更高，公爵就會給你{item:17333}：把它澆在{area:2717}的符文上將其熄滅。所有符文都熄滅後，{npc:12018}會出現，之後是{npc:11502}。",
	-- ["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "尊敬到崇敬需要12,000聲望。小怪仍然計數，所以一次全清約給3,360，加上七個首領的700、{npc:11988}的150和{npc:11502}的200：大約三次全清。處於尊敬階段時，{npc:9017}（15）和{npc:9816}（50）也計數。小怪在尊敬11,999/12,000處停止；靠首領把你帶過去。",
	-- ["Keep clearing the {area:2717} until Exalted."] = "繼續清{area:2717}直到崇拜。",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "在{area:2717}擊殺一個{npc:11668}、一個{npc:11658}、一個{npc:11673}和一個{npc:12101}。{area:2717}的每個元素和首領也都會計入此聲望。",
	-- ["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One {area:2717} clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "中立到尊敬需要9,000聲望，而{quest:6823}要求尊敬。一次{area:2717}全清約給其中4,000。不組團的話就靠元素生物：{npc:11744}、{npc:11746}或{npc:7032}（{zone:1428}）每隻5點，從中立起約需1,800次擊殺。它們在友善5,999/6,000處停止，差一點，所以最後一點需要一次在那裡仍計數的擊殺：{area:2740}的稀有空氣元素{npc:14478}（25點），或{npc:9017}在{area:1584}的{object:174825}處（15點，五人地城）。後兩者和{npc:9816}在尊敬階段也繼續給聲望。",
	-- ["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "對{npc:8521}或{npc:8522}使用{item:17310}：它會變成一個{npc:13279}。殺掉它並拾取它的{item:17309}。需要十二個，而且交任務時瓶子必須還在你的揹包裡。",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "對{zone:1423}中毒的水元素使用{item:17310}，然後拾取牠們的{item:17309}（12個）。",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "對{zone:1423}中毒的水元素使用{item:17310}，然後拾取牠們的{item:17309}（12個）。我們的資料沒有這些水元素的重生點。",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "其餘的靠清{area:2717}。首領一定會計入；在經典版中，小怪的聲望在中途就會停止，所以後期要靠首領。",
	-- ["{faction:749} to Exalted"] = "{faction:749}到崇拜",
	-- ["{faction:749} to Revered"] = "{faction:749}到崇敬",
	-- ["{item:17310}, on the poisoned elementals"] = "{item:17310}，用在被汙染的元素生物上",
	-- ["{item:17332}: raid of 40"] = "{item:17332}：40人團隊副本",
	-- ["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "{item:17333}用來熄滅{area:2717}的符文，崇敬時可換的永久物品{item:22754}，以及一枚火焰抗性戒指。",
	-- ["{item:17333}, ask the Duke"] = "{item:17333}，向公爵索要",
	-- ["{item:18412}, at the portal in {area:1584}"] = "{item:18412}，在{area:1584}的傳送門處",
	-- ["{npc:11658}: raid of 40"] = "{npc:11658}：40人團隊副本",
	-- ["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}、{npc:12259}、{npc:12264}和{npc:12098}是{area:2717}的首領：每一個都會掉落任務要的手。",
	-- ["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the {area:2717}, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "{npc:13278}站在{zone:1447}東海岸外的一座小島上；游過去找他。所有人一開始與水元素領主都是中立，而他們的聲望幾乎全部來自擊殺火焰、空氣和土元素的僕從：任務本身直到最後一個都不給聲望。兩個任務都接：只有兩個都完成，任務鏈才會繼續。尊敬之後的一切都在{area:2717}中進行——那是一個40人團隊副本，並不在暴雪為 Forever 公佈的首批團隊副本之列；在它開放之前，水元素領主的聲望最多到尊敬。本篇攻略的數字不含傳承特長“外交家”，它最多可加10%。",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278}站在{zone:1447}東海岸外的一座小島上；游泳或涉過淺灘到他那裡。{faction:749}一開始是中立。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14387} in {area:254} attunes you to the {area:2717}: bring him a {item:18412} from beside the {area:2717}'s portal at the bottom of {area:1584}. Once attuned, he can send you straight into the {area:2717}."] = "{area:254}的{npc:14387}能讓你與{area:2717}同調：給他帶一個{item:18412}，它就在{area:1584}底部{area:2717}傳送門旁。同調之後，他可以直接把你送進{area:2717}。",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "黑石塔上層的{npc:9816}會掉落{quest:6821}。這需要團隊。",
	-- ["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in {area:1584} pays 15 the same way."] = "{npc:9816}是{area:254}內黑石塔上層的首領：最多十人，需要有人帶著{item:12344}才能開門。他掉落“眼睛”，並且每次擊殺給50聲望，直到尊敬11,999/12,000。{area:1584}的{npc:9017}以同樣方式給15點。",
	-- ["{quest:6821}: raid of ten"] = "{quest:6821}：十人團隊副本",
	-- ["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "{quest:6822}是40人團隊副本。為{npc:13278}各殺一隻{npc:11658}、{npc:11668}、{npc:11673}和{npc:12101}。那裡每個元素生物都給聲望：火焰行者、烈焰守衛、熔岩元素、熔岩掠奪者和熔火摧毀者40點，火焰領主、熔岩奔騰者、熔火巨人和上古熔火犬20點，直到尊敬11,999/12,000；全清小怪約3,360點。首領各給100（{npc:11988}150，{npc:11502}200）。",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}需要尊敬。達到尊敬時，{npc:13278}會發放{item:17333}，用來熄滅{area:2717}中召喚{npc:12018}的符文；達到崇敬時則給可重複使用的{item:22754}。",
}
