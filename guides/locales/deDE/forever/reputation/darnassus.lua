-- German (deDE): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Ruf: Darnassus",

	-- Step 1: Raedon Duskstriker: A Donation of Wool
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {item:14047} Runecloth · {quest:7801} Additional Runecloth
	["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} nimmt in {faction:69} Stoff für {faction:69} an. Die ersten Spenden von Wollstoff, Seidenstoff, Magiestoff und {item:14047} (je 60 Stoff) gibt es nur einmal, und sie bringen den meisten Ruf pro Stoff; danach wiederholt sich {quest:7801} bis Ehrfürchtig. Bist du bei der Hauptstadt eines anderen Volkes ehrfürchtig, kannst du dessen Reittiere kaufen. Der Vermächtnis-Vorteil „Diplomat“ von Forever erhöht den Rufgewinn.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Banditen und Zuchtmeister der Flusspfoten (Stufe 16-18) lassen ihn hier fallen. Das Auktionshaus geht auch.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Söldner des Syndikats bei Burg Stromgarde (Stufe 31-32) lassen ihn hier fallen. Das Auktionshaus geht auch.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Oger der Dünenbrecher (Stufe 45-48) lassen ihn hier fallen. Das Auktionshaus geht auch.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Dunkle Adepten und Schattenmagier (Stufe 58-60) lassen ihn hier fallen; jeder getötete Gegner der Geißel hier zählt auch für {object:92525} (siehe den Guide dazu). Das Auktionshaus geht auch.",

	-- Step 9: Raedon Duskstriker: Runecloth delivered
	-- {npc:14725} Raedon Duskstriker · {item:14047} Runecloth
	["{npc:14725}: {item:14047} delivered"] = "{npc:14725}: {item:14047} abgeliefert",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} bis Wohlwollend",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} nimmt 20 {item:14047} pro Abgabe und lässt sich beliebig oft wiederholen. Bring {item:14047} in Vielfachen von 20 mit und gib alles auf einmal ab, eine Abgabe nach der anderen. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} bis Respektvoll",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7801} ab, jeweils 20 {item:14047}. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} bis Ehrfürchtig",
	-- {quest:7801} Additional Runecloth · {faction:69} Darnassus · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Gib weiter {quest:7801} ab, bis du bei {faction:69} ehrfürchtig bist. {item:14047}: Dunkle Adepten und Schattenmagier (Stufe 58-60) in den {zone:1423} oder das Auktionshaus.",
}
