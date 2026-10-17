-- French (frFR): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Réputation : Aube d'argent",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Alliance)",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} commence au niveau Neutre. Prenez le brevet auprès de {npc:10840} à {area:3197} et portez-le : en Classic, les Pierres du Fléau ne tombent que si le bijou {quest:5401} est équipé. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horde)",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:813} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:813} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} commence au niveau Neutre. Prenez le brevet auprès de {npc:10839} à {area:813} et portez-le : en Classic, les Pierres du Fléau ne tombent que si le bijou {quest:5401} est équipé. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "Pierres du Fléau des serviteurs jusqu'à Amical",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:813} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:813}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Les goules et squelettes de tout {zone:1422} laissent tomber des Pierres du Fléau des serviteurs environ une fois sur deux ; ce secteur est dense. Rendez-les par 20 à n'importe quel officier de l'Aube d'argent (Pureheart à {area:3197}, Garush à {area:813}, {npc:11039} à {area:2268}). Chaque remise rapporte aussi une {item:12844} pour les intendants de l'Aube d'argent.",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "Pierres du Fléau des envahisseurs jusqu'à Honoré",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) laissent tomber ici des Pierres du Fléau des envahisseurs, ainsi que des pierres des serviteurs et de l'{item:14047}. Rendez celles des envahisseurs par 10 et celles des serviteurs par 20 à {npc:11039} à {area:2268}. En Classic, les deux ne rapportent plus de réputation à partir d'Honoré.",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "Pierres du Fléau des corrupteurs et donjons jusqu'à Révéré",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "À partir d'Honoré, les Pierres du Fléau des corrupteurs (une par remise) et les morts du Fléau à {area:2279} et à {area:2057} apportent la réputation. Les pierres des corrupteurs tombent des boss du Fléau de ces donjons ({npc:1853}, {npc:10433}, Vectus) ainsi que de {npc:1852} et Putridius dans {zone:1422}. Enchaîner les donjons rapporte plus vite que tout farm en extérieur.",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Faites {area:2279} (les deux ailes) et {area:2057} en tuant tous les membres du Fléau croisés.",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529} jusqu'à Exalté",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Continuez {area:2279} et {area:2057} et rendez chaque {item:12843} à {area:2268} jusqu'à Exalté.",
}
