-- German (deDE): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Ruf: Argentumdämmerung",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Allianz)",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "Bei {object:2160} beginnst du neutral. Hol dir die Ernennung bei {npc:10840} im {area:3197} und leg sie an: In Classic fallen Geißelsteine nur, solange das Schmuckstück aus {quest:5401} angelegt ist. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horde)",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:813} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:813} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "Bei {object:2160} beginnst du neutral. Hol dir die Ernennung bei {npc:10839} am {area:813} und leg sie an: In Classic fallen Geißelsteine nur, solange das Schmuckstück aus {quest:5401} angelegt ist. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "Geißelsteine des Dieners bis Freundlich",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:813} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:813}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Ghule und Skelette überall in den {zone:1422} lassen in etwa jedem zweiten Fall Geißelsteine des Dieners fallen; hier stehen sie dicht. Gib sie zu je 20 bei einem beliebigen Argentumoffizier ab (Argentumoffizier Pureheart im {area:3197}, Argentumoffizier Garush am {area:813}, {npc:11039} in der {area:2268}). Jede Abgabe bringt auch ein {item:12844} für die Rüstmeister der Argentumdämmerung.",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "Geißelsteine des Eindringlings bis Wohlwollend",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen hier Geißelsteine des Eindringlings fallen, dazu Geißelsteine des Dieners und {item:14047}. Gib die des Eindringlings zu je 10 und die des Dieners zu je 20 bei {npc:11039} in der {area:2268} ab. In Classic bringen beide ab Wohlwollend keinen Ruf mehr.",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "Geißelsteine des Verderbers und Dungeons bis Respektvoll",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "Ab Wohlwollend bringen Geißelsteine des Verderbers (einer pro Abgabe) und getötete Gegner der Geißel in {area:2279} und {area:2057} den Ruf. Geißelsteine des Verderbers fallen bei den Bossen der Geißel dort ({npc:1853}, {npc:10433}, Vectus) sowie bei {npc:1852} und Putridius in den {zone:1422}. Viele Dungeonläufe lohnen sich schneller als jedes Farmen in der offenen Welt.",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Lauf {area:2279} (beide Flügel) und {area:2057} und töte jeden Gegner der Geißel auf dem Weg.",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529} bis Ehrfürchtig",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Lauf weiter {area:2279} und {area:2057} und gib jeden {item:12843} in der {area:2268} ab, bis du ehrfürchtig bist.",
}
