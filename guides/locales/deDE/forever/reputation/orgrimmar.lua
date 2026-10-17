-- German (deDE): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "Ruf: Orgrimmar",

	-- Step 1: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {faction:76} Orgrimmar · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726} nimmt Stoff für {faction:76} in {faction:76} an. Die ersten Spenden von Wollstoff, Seidenstoff, Magiestoff und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach ist {quest:7832} bis Ehrfürchtig wiederholbar. Ehrfürchtig bei der Stadt eines anderen Volkes erlaubt dir, dessen Reittiere zu kaufen. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Vollstrecker der Venture Co. in der {area:381} (Stufe 16-17) lassen ihn hier fallen. Das Auktionshaus geht auch.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Kolkar-Zentauren (Stufe 30-33) lassen ihn hier fallen. Das Auktionshaus geht auch.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder Kill der Geißel hier zählt auch für die {object:92525} (siehe diesen Guide). Das Auktionshaus geht auch.",

	-- Step 9: Rashona Straglash: Runecloth delivered
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth
	["{npc:14726}: {item:14047} delivered"] = "{npc:14726}: {item:14047} abgeliefert",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832} bis Wohlwollend",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832} nimmt 20 {item:14047} pro Abgabe und ist beliebig oft wiederholbar. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832} bis Respektvoll",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7832} ab, je 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832} bis Ehrfürchtig",
	-- {quest:7832} Additional Runecloth · {faction:76} Orgrimmar · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7832} ab, bis {faction:76} auf Ehrfürchtig ist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
}
