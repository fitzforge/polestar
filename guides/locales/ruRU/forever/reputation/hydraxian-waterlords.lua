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
	-- {item:22754} Eternal Quintessence · {area:2717} Molten Core
	["The reputation kills to Honored, and the reusable {item:22754} at Revered once the {area:2717} opens."] = "Убийства для репутации до уважения и многоразовая {item:22754} при почтении, когда откроется {area:2717}.",

	-- Step 1: Elementals to Honored
	["Elementals to Honored"] = "",
	-- {npc:13278} Duke Hydraxis · {area:2717} Molten Core · {npc:11744} Dust Stormer · {npc:11746} Desert Rumbler · {area:2740} Crystal Vale · {zone:1451} Silithus · {npc:7032} Greater Obsidian Elemental · {zone:1428} Burning Steppes · {npc:14478} Huricanian · {npc:9017} Lord Incendius · {object:174825} Black Anvil (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Everyone starts Neutral with the Waterlords, and their reputation comes from killing the servants of fire, air and earth. {npc:13278}'s quests aren't offered on Forever yet: they come back when the {area:2717} opens. The numbers in this guide leave out the Legacy perk Diplomat, which adds up to 10%.\nNeutral to Honored is 9,000 reputation. It comes from the elementals: 5 per {npc:11744} or {npc:11746}, which drift around the {area:2740} in the north-west of {zone:1451}, or {npc:7032} (the {zone:1428}), about 1,800 kills from Neutral. They stop at 5,999 of 6,000 Friendly, one point short, so the last point needs a kill that still counts there: {npc:14478}, a rare air elemental in the {area:2740} (25), or {npc:9017} at the {object:174825} in {area:1584} (15, a five-player dungeon). Those two keep paying through Honored as well."] = "Все начинают с равнодушия к Гидраксианским Повелителям Вод, а репутация идет за убийство слуг огня, воздуха и земли. Задания NPC {npc:13278} на Forever пока не предлагаются: они вернутся, когда откроется {area:2717}. Числа в этом гайде не учитывают перк наследия «Дипломат», который добавляет до 10%.\nОт равнодушия до уважения – 9000 репутации. Ее дают элементали: 5 за {npc:11744} или {npc:11746}, которые бродят вокруг места {area:2740} на северо-западе зоны {zone:1451}, или {npc:7032} ({zone:1428}), около 1800 убийств от равнодушия. Они перестают давать на 5999 из 6000 дружелюбия, за одно очко до конца, так что последнее очко требует убийства, которое там еще засчитывается: {npc:14478}, редкий элементаль воздуха в месте {area:2740} (25), или {npc:9017} у места {object:174825} ({area:1584}) (15, подземелье на пятерых). Эти двое продолжают давать репутацию и при уважении.",
	-- {npc:14478} Huricanian
	["{npc:14478}, rare, 25"] = "",
	-- {npc:9017} Lord Incendius · {area:1584} Blackrock Depths
	["{npc:9017}, {area:1584}: 15, group up"] = "",

	-- Step 2: Pyroguard Emberseer
	-- {npc:9816} Pyroguard Emberseer · {area:254} Blackrock Mountain · {item:12344} Seal of Ascension
	["{npc:9816} is a boss in Upper Blackrock Spire, inside {area:254}: a group of up to ten, and someone needs the {item:12344} to open the door. He pays 50 reputation per kill up to 11,999 of 12,000 Honored."] = "{npc:9816} – босс Верхней части Вершины Черной горы, внутри места {area:254}: группа до десяти человек, и кому-то нужна {item:12344}, чтобы открыть дверь. Он дает 50 репутации за убийство до 11 999 из 12 000 уважения.",
	-- {npc:9816} Pyroguard Emberseer
	["{npc:9816}: raid of ten"] = "{npc:9816}: рейд на десятерых",

	-- Step 3: Molten Core to Revered
	-- {area:2717} Molten Core
	["{area:2717} to Revered"] = "",
	-- {npc:227939} The Molten Core · {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros · {npc:9017} Lord Incendius · {npc:9816} Pyroguard Emberseer
	-- plural, as words: Firewalkers = {npc:11666} Firewalker · Flameguards = {npc:11667} Flameguard · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer · Lava Surgers = {npc:12101} Lava Surger · Molten Giants = {npc:11658} Molten Giant · Ancient Core Hounds = {npc:11673} Ancient Core Hound
	["{npc:227939} is a raid of 40 and not open on Forever yet. Once it is: every elemental there pays, Firewalkers, Flameguards, Lava Elementals, Lava Reavers and Molten Destroyers 40, Firelords, Lava Surgers, Molten Giants and Ancient Core Hounds 20, up to 11,999 of 12,000 Honored; about 3,360 for a full clear of the trash.\nHonored to Revered is 12,000 reputation. The trash still counts, so a full clear pays about 3,360 plus 700 from the seven bosses, 150 from {npc:11988} and 200 from {npc:11502}: about three clears. {npc:9017} (15) and {npc:9816} (50) count too while you are Honored. The trash stops at 11,999 of 12,000 Honored; the bosses carry you over."] = "{npc:227939} – рейд на 40 и на Forever пока не открыт. Когда откроется: каждый элементаль там дает репутацию: огнеходцы ({npc:11666}), стражи пламени ({npc:11667}), лавовые элементали ({npc:12076}), лавовые разорители ({npc:12100}) и расплавленные разрушители ({npc:11659}) – 40, повелители огня, лавовые волнорезы ({npc:12101}), расплавленные великаны ({npc:11658}) и древние гончие Недр ({npc:11673}) – 20, до 11 999 из 12 000 уважения; около 3360 за полную зачистку мобов.\nОт уважения до почтения – 12 000 репутации. Мобы по-прежнему засчитываются, так что полная зачистка дает около 3360 плюс 700 за семь боссов, 150 за {npc:11988} и 200 за {npc:11502}: примерно три зачистки. {npc:9017} (15) и {npc:9816} (50) тоже засчитываются, пока вы на уважении. Мобы перестают давать на 11 999 из 12 000 уважения; боссы переносят вас дальше.",
	-- {npc:12118} Lucifron
	["{npc:12118} and the other bosses, 100: they carry you past 11,999"] = "",

	-- Step 4: The Eternal Quintessence
	-- {item:22754} Eternal Quintessence
	["The {item:22754}"] = "{item:22754}",
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {item:22754} Eternal Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {npc:11502} Ragnaros
	["{npc:13278} stands on a small island off the east coast of {zone:1447}; swim out to him. At Revered he gives you the {item:22754}: pour it on a rune in the {area:2717} to douse it. It is not used up, so you never come back for another. With every rune doused, {npc:12018} comes out, and after him {npc:11502}."] = "{npc:13278} стоит на маленьком острове у восточного побережья зоны {zone:1447}; доплывите до него. При почтении он дает {item:22754}: вылейте ее на руну в месте {area:2717}, чтобы погасить ее. Она не расходуется, так что за новой возвращаться не нужно. Когда все руны погашены, выходит {npc:12018}, а после него {npc:11502}.",
	-- {item:22754} Eternal Quintessence
	["{item:22754}, ask the Duke"] = "",

	-- Step 5: Molten Core to Exalted
	-- {area:2717} Molten Core
	["{area:2717} to Exalted"] = "",
	-- {npc:11988} Golemagg the Incinerator · {npc:11502} Ragnaros
	["Revered to Exalted is 21,000 reputation. The trash has stopped, but all nine bosses still pay while you are Revered: 100 each from the seven, 150 from {npc:11988} and 200 from {npc:11502}, 1,050 a clear: about 20 clears. The seven stop at 20,999 of 21,000 Revered, so the last point comes from {npc:11988} or {npc:11502}, and from Exalted on only those two pay."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:13278}"] = "Вернитесь к NPC {npc:13278}",
	-- ["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Оба вида элементалей бродят на северо-западе зоны {zone:1451}; грохотуны держатся чуть севернее.",
	-- ["Dust Stormers and Desert Rumblers"] = "Пылевихри ({npc:11744}) и пустынные грохотуны ({npc:11746})",
	-- ["Keep clearing the {area:2717} until Exalted."] = "Зачищайте {area:2717} до превознесения.",
	-- ["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Убейте по одному: {npc:11668}, {npc:11658}, {npc:11673} и {npc:12101} ({area:2717}). Каждый элементаль и босс ({area:2717}) также дает репутацию у Повелителей Вод.",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "Используйте {item:17310} на отравленных водных элементалях (зона {zone:1423}), затем заберите с них: {item:17309} (12).",
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Используйте {item:17310} на отравленных водных элементалях (зона {zone:1423}), затем заберите с них: {item:17309} (12). Точек появления этих элементалей в наших данных нет.",
	-- ["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Остальное дают зачистки ({area:2717}). Боссы засчитываются всегда; в Classic обычные противники на полпути перестают давать репутацию Повелителей Вод, так что под конец ее приносят боссы.",
	-- ["{faction:749} to Exalted"] = "{faction:749} до уровня «Превознесение»",
	-- ["{faction:749} to Revered"] = "{faction:749} до уровня «Почтение»",
	-- ["{item:17333} to douse the {area:2717}'s runes, the reusable {item:22754} at Revered and a fire resistance ring."] = "{item:17333} – чтобы гасить руны ({area:2717}), многоразовая {item:22754} на уровне «Почтение» и кольцо сопротивления огню.",
	-- ["{npc:12118}, {npc:12259}, {npc:12264} and {npc:12098} are {area:2717} bosses: each drops his hand for the quest."] = "{npc:12118}, {npc:12259}, {npc:12264} и {npc:12098} – боссы рейда {area:2717}: с каждого падает его рука для задания.",
	-- ["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} стоит на маленьком острове у восточного побережья зоны {zone:1447}; доплывите или дойдите по отмели. {faction:749}: начальная репутация – равнодушие. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",
	-- ["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816} в верхней части Вершины Черной горы роняет предмет для задания {quest:6821}. Нужна рейдовая группа.",
	-- ["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}: нужно «Уважение». На уровне «Уважение» {npc:13278} выдает {item:17333} – им гасят руны ({area:2717}), чтобы призвать босса ({npc:12018}); на уровне «Почтение» – многоразовую: {item:22754}.",
}
