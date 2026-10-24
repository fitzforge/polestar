-- German (deDE): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Alliance)"] = "{spell:2842} (Allianz)",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever lehrt {spell:2842} über diese Questreihe, nicht beim Lehrer; das Rezept für {item:7676} gibt es dazu.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "Auf Stufe 20 schickt dich {npc:332} bei SI:7 in {object:2100} zu {npc:7024} in {zone:1436}.",

	-- Step 2: Agent Kearnen
	-- {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {npc:7051} Malformed Defias Drone
	["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln im äußersten Osten von {zone:1436}, an der Grenze zu {zone:1431}. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}, in the {object:123214}"] = "{item:7908}, in der {object:123214}",

	-- Step 3: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh durch Elwynn nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in der {object:2100}.",

	-- Step 4: Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207} arbeitet im Keller von SI:7, der Kaserne. Gib neben ihm /hinlegen ein, um dich untersuchen zu lassen.",
	["/lay down"] = "/hinlegen",

	-- Step 5: The cure's ingredients
	["The cure's ingredients"] = "Die Zutaten für das Heilmittel",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {item:8431} Spool of Light Chartreuse Silk Thread · {item:3372} Leaded Vial · {item:4371} Bronze Tube
	["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "Alles gibt es in {zone:1453}: Die Gumps verkaufen {item:3421}, die {item:8431} liegt in der Stadt, und die nächsten Händler verkaufen eine {item:3372} und eine {item:4371}.",

	-- Step 6: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "Zurück zu {npc:7207}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Reite nach Norden durch den Wald von Elwynn nach {zone:1453}; Mathias Shaw ist bei SI:7 in {object:2100}.",
}
