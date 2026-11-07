-- Russian (ruRU): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Репутация: Гидраксианские Повелители Вод",
	-- {item:17333} Aqual Quintessence · {area:2717} Molten Core · {item:22754} Eternal Quintessence
	["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "{item:17333} – чтобы гасить руны ({area:2717}), многоразовая {item:22754} на уровне «Почтение» и кольцо сопротивления огню.",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {area:2717} Molten Core
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. Everyone starts Neutral with the Waterlords, and nearly all of their reputation comes from killing the servants of fire, air and earth: the quests themselves pay nothing until the last one. Take both quests: the chain goes on only when both are done. Everything past Honored happens in the {area:2717}, a raid of 40 that is not among the first raids Blizzard has announced for Forever; until it opens, Honored is as far as the Waterlords go. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%."] = "",

	-- Step 2: Stormers and Rumblers
	-- {area:2740} Crystal Vale · {zone:1451} Silithus
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers drift around the {area:2740} in the north-west of {zone:1451}. Each kill also pays 5 reputation while you are Neutral or Friendly, so stay if you mean to farm (next steps)."] = "",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {npc:8521} Blighted Horror · {npc:8522} Plague Monstrosity · {npc:13279} Discordant Surge · {item:17309} Discordant Bracers
	["Use the {item:17310} on a {npc:8521} or a {npc:8522}: it turns into a {npc:13279}. Kill the surge and loot its {item:17309}. Twelve are needed, and the vial must still be in your bags at the turn-in."] = "",
	-- {item:17310} Aspect of Neptulon
	["{item:17310}, on the poisoned elementals"] = "",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Вернитесь к NPC {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension · {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He drops the Eye and pays 50 reputation per kill up to 11,999 of 12,000 Honored. {npc:9017} in {area:1584} pays 15 the same way."] = "",
	-- {quest:6821} Eye of the Emberseer
	["{quest:6821}: raid of ten"] = "",

	-- Step 6: Attunement to the Core
	-- {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {area:2717} Molten Core · {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{npc:14387} in {area:254} attunes you to the {area:2717}: bring him a {item:18412} from beside the {area:2717}'s portal at the bottom of {area:1584}. Once attuned, he can send you straight into the {area:2717}."] = "",
	-- {item:18412} Core Fragment · {area:1584} Blackrock Depths
	["{item:18412}, at the portal in {area:1584}"] = "",

	-- Step 7: The Molten Core
	-- {quest:6822} The Molten Core · {npc:11658} Molten Giant · {npc:11668} Firelord · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {npc:13278} Duke Hydraxis · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Firelords = {npc:11668} Firelord · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{quest:6822} is a raid of 40. Kill one {npc:11658}, {npc:11668}, {npc:11673} and {npc:12101} for {npc:13278}. Every elemental there pays: Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash. The bosses pay 100 each ({npc:11988} 150, {npc:11502} 200)."] = "",
	-- {npc:11658} Molten Giant
	["{npc:11658}: raid of 40"] = "",

	-- Step 8: Elementals to Honored
	["Elementals to Honored"] = "",
	-- {quest:6823} Agent of Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {area:2740} Crystal Vale · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths · {npc:9816} Pyroguard Emberseer
	["Neutral to Honored is 9,000 reputation, and {quest:6823} asks for Honored. One {area:2717} clear pays about 4,000 of it. Without a raid it comes from the elementals: 5 per {npc:11744}, {npc:11746} or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two and {npc:9816} keep paying through Honored as well."] = "",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "",

	-- Step 9: Agent of Hydraxis
	-- {npc:13278} Duke Hydraxis · {quest:6823} Agent of Hydraxis
	["Back to {npc:13278}. {quest:6823} is done the moment you are Honored."] = "",

	-- Step 10: Hands of the Enemy
	-- {npc:12118} Lucifron · {npc:12259} Gehennas · {npc:12264} Shazzrah · {npc:12098} Sulfuron Harbinger · {area:2717} Molten Core
	["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "",
	-- {item:17332} Hand of Shazzrah
	["{item:17332}: raid of 40"] = "",

	-- Step 11: A Hero's Reward
	-- {object:179551} Hydraxis' Coffer · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["Hand in the hands, then dive under the surf at the southern foot of the island: {object:179551} holds your ring and pays the only quest reputation the Waterlords give, 200. From now on, while you are Honored or better, the Duke hands you {item:17333}: pour it on a rune in the {area:2717} to douse it. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "",
	-- {item:17333} Aqual Quintessence
	["{item:17333}, ask the Duke"] = "",

	-- Step 12: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	["Honored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "",

	-- Step 13: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "",
	-- {item:22754} Eternal Quintessence · {item:17333} Aqual Quintessence
	["At Revered the Duke gives you the {item:22754}: it does the {item:17333}'s work and is not used up, so you never come back for another vial."] = "",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "",

	-- Step 14: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Оба вида элементалей бродят на северо-западе зоны {zone:1451}; грохотуны держатся чуть севернее.",
	-- ["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Принесите из рейда ({area:2717}) руки Люцифрона, Гееннаса, Шаззраха и Сульфурона.",
	-- ["Dust Stormers and Desert Rumblers"] = "Пылевихри ({npc:11744}) и пустынные грохотуны ({npc:11746})",
	-- ["Keep clearing the {area:2717} until Exalted."] = "Зачищайте {area:2717} до превознесения.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Убейте по одному: {npc:11668}, {npc:11658}, {npc:11673} и {npc:12101} ({area:2717}). Каждый элементаль и босс ({area:2717}) также дает репутацию у Повелителей Вод.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Используйте {item:17310} на отравленных водных элементалях (зона {zone:1423}), затем заберите с них: {item:17309} (12).",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Используйте {item:17310} на отравленных водных элементалях (зона {zone:1423}), затем заберите с них: {item:17309} (12). Точек появления этих элементалей в наших данных нет.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Остальное дают зачистки ({area:2717}). Боссы засчитываются всегда; в Classic обычные противники на полпути перестают давать репутацию Повелителей Вод, так что под конец ее приносят боссы.",
	-- ["{faction:749} to Exalted"] = "{faction:749} до уровня «Превознесение»",
	-- ["{faction:749} to Revered"] = "{faction:749} до уровня «Почтение»",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} стоит на маленьком острове у восточного побережья зоны {zone:1447}; доплывите или дойдите по отмели. {faction:749}: начальная репутация – равнодушие. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816} в верхней части Вершины Черной горы роняет предмет для задания {quest:6821}. Нужна рейдовая группа.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}: нужно «Уважение». На уровне «Уважение» {npc:13278} выдает {item:17333} – им гасят руны ({area:2717}), чтобы призвать босса ({npc:12018}); на уровне «Почтение» – многоразовую: {item:22754}.",
}
