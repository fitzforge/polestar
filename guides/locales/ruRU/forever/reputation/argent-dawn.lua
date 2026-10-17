-- Russian (ruRU): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Репутация: Серебряный Рассвет",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Альянс)",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}: начальная репутация – равнодушие. Возьмите жетон у NPC {npc:10840} ({area:3197}) и наденьте: в Classic камни Плети падают, только пока надет аксессуар {quest:5401}. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Орда)",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:813} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:813} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}: начальная репутация – равнодушие. Возьмите жетон у NPC {npc:10839} ({area:813}) и наденьте: в Classic камни Плети падают, только пока надет аксессуар {quest:5401}. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "Камни приспешников Плети ({item:12840}) до уровня «Дружелюбие»",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:813} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:813}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Вурдалаки и скелеты по всей зоне {zone:1422} примерно в половине случаев роняют: {item:12840}; здесь они встречаются густо. Сдавайте по 20 любому офицеру Серебряного Рассвета (Чистосердая – {area:3197}, Гаруш – {area:813}, {npc:11039} – {area:2268}). Каждая сдача также дает {item:12844} для интендантов Серебряного Рассвета.",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "Камни захватчиков Плети ({item:12841}) до уровня «Уважение»",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Адепты Тьмы ({npc:8546}) и темные маги (уровень 58-60) роняют здесь {item:12841}, а также камни приспешников и {item:14047}. Сдавайте камни захватчиков по 10, а камни приспешников по 20: {npc:11039} – {area:2268}. В Classic и те и другие перестают давать репутацию на уровне «Уважение».",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "Камни осквернителей Плети ({item:12843}) и подземелья до уровня «Почтение»",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "С уровня «Уважение» репутацию дают {item:12843} (по одному за сдачу) и убийства Плети: {area:2279} и {area:2057}. Камни осквернителей падают с боссов Плети там ({npc:1853}, {npc:10433}, Вектус), а также с NPC {npc:1852} и Гнилиуса (зона {zone:1422}). Многократные походы в подземелья окупаются быстрее любого фарма в открытом мире.",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Проходите {area:2279} (обе части) и {area:2057}, убивая всю Плеть на пути.",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529} до уровня «Превознесение»",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Проходите {area:2279} и {area:2057} и сдавайте каждый {item:12843} ({area:2268}) до превознесения.",
}
