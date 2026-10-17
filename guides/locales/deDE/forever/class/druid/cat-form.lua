-- German (deDE): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "Deine Tarn- und Nahkampfgestalt: In Forever gibt diese Questreihe {spell:768} auf Stufe 20, nicht der Lehrer.",

	-- Step 1: The Great Cat Spirit
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {area:442} Auberdine
	["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217} steht im {area:1658}. Himmelsgeborene ohne die Flugroute nach Rut'theran: Nimm das Boot von {area:442}.",

	-- Step 2: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}; hol dir dort die Flugroute, falls du sie noch nicht hast.",

	-- Step 3: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Die Relikte der Grabhügel",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:2363} Stormrage Barrow Dens · {item:280680} Relic of the Silent Shadow
	["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Nachtelfen) wartet auf dem südlichen Hügel über der Brücke, der {npc:272054} (Himmelsgeborene) südlich der Zwillingsbrücken. Die Relikte liegen in den {area:2363} östlich des Sees: Verlasse deine Gestalt, klick die Statue am Eingang für fünf Minuten Verstohlenheit, halte dich von den Geistern drinnen fern und nimm je ein Relikt; das {item:280680} liegt am Fuß der weißen Katzenstatue. Ein Relikt gibt keine Beute, solange ein anderer Spieler es plündert: Warte kurz und versuch es erneut.",

	-- Step 4: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Zurück zu {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "Zurück zu {npc:11802} in {area:2361}, dann flieg nach {area:702}.",

	-- Step 5: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Nimm das Portal hinauf zu {npc:4217} im {area:1658}.",

	-- Step 6: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} steht auf der {area:1639}.",

	-- Step 7: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}.",

	-- Step 8: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "Die {area:2363}",
	-- {quest:98342} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:2363} Stormrage Barrow Dens · {item:280680} Relic of the Silent Shadow
	["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342} (Tauren) wartet auf dem südlichen Hügel über der Brücke, der {npc:272054} (Himmelsgeborene) südlich der Zwillingsbrücken. Die Relikte liegen in den {area:2363} östlich des Sees: Verlasse deine Gestalt, klick die Statue am Eingang für fünf Minuten Verstohlenheit, halte dich von den Geistern drinnen fern und nimm je ein Relikt; das {item:280680} liegt am Fuß der weißen Katzenstatue. Ein Relikt gibt keine Beute, solange ein anderer Spieler es plündert: Warte kurz und versuch es erneut.",

	-- Step 9: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "Zurück zu {npc:11802} in {area:2361}, dann nimm den Flug von {npc:11798} nach {area:1638}.",
}
