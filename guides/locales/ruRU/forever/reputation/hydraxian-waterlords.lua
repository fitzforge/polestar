-- Russian (ruRU): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "Репутация: Гидраксианские Повелители Вод",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278} стоит на маленьком острове у восточного побережья зоны {zone:1447}; доплывите или дойдите по отмели. {faction:749}: начальная репутация – равнодушие. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "Пылевихри ({npc:11744}) и пустынные грохотуны ({npc:11746})",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "Оба вида элементалей бродят на северо-западе зоны {zone:1451}; грохотуны держатся чуть севернее.",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "Используйте {item:17310} на отравленных водных элементалях (зона {zone:1423}), затем заберите с них: {item:17309} (12). Точек появления этих элементалей в наших данных нет.",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "Вернитесь к NPC {npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "{npc:9816} в верхней части Вершины Черной горы роняет предмет для задания {quest:6821}. Нужна рейдовая группа.",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "Убейте по одному: {npc:11668}, {npc:11658}, {npc:11673} и {npc:12101} ({area:2717}). Каждый элементаль и босс ({area:2717}) также дает репутацию у Повелителей Вод.",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}: нужно «Уважение». На уровне «Уважение» {npc:13278} выдает {item:17333} – им гасят руны ({area:2717}), чтобы призвать босса ({npc:12018}); на уровне «Почтение» – многоразовую: {item:22754}.",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "Принесите из рейда ({area:2717}) руки Люцифрона, Гееннаса, Шаззраха и Сульфурона.",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749} до уровня «Почтение»",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "Остальное дают зачистки ({area:2717}). Боссы засчитываются всегда; в Classic обычные противники на полпути перестают давать репутацию Повелителей Вод, так что под конец ее приносят боссы.",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749} до уровня «Превознесение»",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "Зачищайте {area:2717} до превознесения.",
}
