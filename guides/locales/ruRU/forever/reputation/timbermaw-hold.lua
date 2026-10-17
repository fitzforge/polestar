-- Russian (ruRU): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Репутация: Древобрюхи",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576}: репутация начинается с враждебности, и фурболги в туннелях нападают, пока вы не достигнете неприязни. Каждый убитый фурболг из племен Мертвого Леса и Зимней Спячки повышает ее, так что задания ниже окупаются дважды. Бонус наследия Forever «Дипломат» увеличивает получаемую репутацию.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Фурболги из племени Мертвого Леса (уровень 48-50) стоят лагерем на южном краю зоны {zone:1448}. Сохраняйте каждый выпавший {item:21377}: позже их примут {npc:11554} и {npc:15395}.",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Вернитесь: {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} ждет на севере зоны {zone:1448} у туннеля: {faction:576}.",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Северные фурболги из племени Мертвого Леса (уровень 53-55) занимают лагеря чуть южнее туннеля. Их перья тоже сохраняйте.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Вернитесь: {npc:15395}",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Пройдите через туннель ({faction:576}) к выходу в {zone:1452}; {npc:11556} стоит сразу снаружи. Задания и убийства к этому моменту обычно дают неприязнь, и тогда Древобрюхи пропускают вас. Если они все еще красные, сначала убейте больше фурболгов Мертвого Леса у туннеля.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244} — на восточной стороне зоны {zone:1452}. Сохраняйте каждый добытый предмет {item:21383}: их принимает {npc:11556}.",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Вернитесь: {npc:11556}",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "Перья и бусины до дружелюбия",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "«Перья для Гразла» ({npc:11554}), «Перья для Нафиэна» ({npc:15395}) (перья из головного убора Мертвого Леса) и «Бусы для Сальфы» ({npc:11556}; {item:21383}) повторяются сколько угодно; каждое убийство фурболга Мертвого Леса или Зимней Спячки тоже идет в зачет. {area:2244} — лучшее место для бусин.",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: «Бусы для Сальфы» ({npc:11556})",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "Перья до уважения",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Северные лагеря Мертвого Леса у туннеля — лучшее место для перьев (там шанс 35%). Сдавайте перья: {npc:15395} у туннеля или {npc:11554} на юге.",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: «Перья для Нафиэна» ({npc:15395})",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576}: до почтения",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Чередуйте перья Мертвого Леса ({npc:15395}) и бусины Зимней Спячки ({npc:11556}) — где лагерь свободнее.",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576}: до превознесения",
	["Keep turning in feathers and beads until Exalted."] = "Сдавайте перья и бусины до превознесения.",
}
