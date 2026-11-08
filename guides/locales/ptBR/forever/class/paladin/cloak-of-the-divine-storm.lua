-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A rare cloak at 30 from the old Divine Storm story; for now only Alliance paladins can finish it."] = "",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "O Orbe Estranho",
	-- {zone:1439} Darkshore · {object:409311} Spear of Mannoroth (no name in this language: may be words)
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic · Dark Strand Voidcallers = {npc:2337} Dark Strand Voidcaller
	["Climb to the top of the Tower of Althalaxx in northern {zone:1439}. The Dark Strand Fanatics around it are easy (level 16-17), but four Dark Strand Voidcallers (level 28-29) stand in the tower on the way to the orb: each calls a voidwalker and casts Shadow Bolt from range. At 22-25 bring a friend or two, pull them one at a time and step behind a wall so they have to come to you. Loot the Strange Orb at the top: it gives you the Althalaxx Orb; right-click it to start the quest. Keep the orb in your bags until the {object:409311}: three later quests need it."] = "",
	["Strange Orb atop the Tower of Althalaxx: right-click the Althalaxx Orb it gives"] = "",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {object:19863} Maestra's Post (no name in this language: may be words) · {zone:1440} Ashenvale · {zone:1439} Darkshore · {zone:1453} Stormwind
	["{npc:3663} stands at {object:19863} in western {zone:1440}, south of the {zone:1439} road. He sends you to {zone:1453} with the orb."] = "",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} stands in the Cathedral of Light; she sends you to a warlock for a second opinion."] = "",

	-- Step 4: Ursula Deline
	-- {npc:5495} Ursula Deline · {object:2101} Mage Quarter · {object:2164} Slaughtered Lamb · {item:209778} Summoner's Salt
	["{npc:5495}, the warlock trainer, is in the {object:2101}'s warlock sanctum, down in the {object:2164}'s cellar. She wants 14 {item:209778} to read the orb."] = "",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt · {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner · Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The Blackrock Summoners, Champions and Trackers (level 22-25, not elite) camp in the north-west of Redridge and drop the {item:209778}; you need 14. Two elite Blackrock Shadowcasters (22-23) stand at the cave mouth at the camp's east end: pull around them. The Blackrock camps east of Lakeshire drop the salt too, but their Shadowcasters, Sentries and Hunters are elite (level 21-24), and so is {npc:334} (26): stay in the north-west."] = "",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "De volta a {npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Partículas de Mannoroth",
	-- {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["Demon Fall Canyon is in south-east {zone:1440}, east of Splintertree Post (a Horde camp: go round it). The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds (level 29-30, not elite) drop the Motes of Mannoroth; you need 12. Below about 27 they are hard alone: come with a second player or later. Felguards knock you down, Lashers cast Shadow Bolt and Immolate, Infernals keep a fire shield up. They respawn in five minutes."] = "",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words)
	["The {object:409311}"] = "A {object:409311}",
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words) · {object:409315} Shattered Orb (no name in this language: may be words)
	["The {object:409311} stands at the east end of Demon Fall Canyon. Hand in the motes at the spear with the Althalaxx Orb in your bags: the orb shatters, and the {object:409315} beside it starts the last quest."] = "",
	-- {object:409315} Shattered Orb (no name in this language: may be words)
	["from the {object:409315}"] = "do {object:409315}",

	-- Step 9: Return to Delgren
	-- {npc:3663} Delgren the Purifier · {object:19863} Maestra's Post (no name in this language: may be words) · {zone:1440} Ashenvale
	["Back to {npc:3663} at {object:19863} in western {zone:1440}, across the whole zone."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Um manto raro no nível 30, da antiga história de {spell:407778}; por enquanto só paladinos da Aliança podem concluí-la.",
	-- ["Back to {area:413}."] = "De volta a {area:413}.",
	-- ["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Evocadores, Campeões e Rastreadores Rocha Negra acampam no noroeste das Montanhas Cristarrubra; eles deixam cair o {item:209778}.",
	-- ["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Suba ao topo da {area:444}, no norte de {zone:1439}. Saqueie o Orbe Estranho lá em cima: ele dá o Orbe de Althalaxx, que inicia a missão.",
	-- ["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Katherine manda você aos bruxos no {object:2101}; {npc:5495} fala por eles.",
	-- ["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Orbe Estranho no topo da {area:444}: clique com o botão direito no Orbe de Althalaxx que ele dá",
	-- ["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "A {object:409311} fica na ponta leste de {area:435}. Use Estilhaçar no orbe dela; o {object:409315} aparece ao lado.",
	-- ["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435} fica no sudeste de {zone:1440}. As Açoitadeiras Mannoroc, Infernais Abrasadores, Guardas Vis e Farejadores Legionários de lá deixam cair as Partículas de Mannoroth.",
	-- ["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} fica em {area:413}, no oeste de {zone:1440}.",
	-- ["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} está na Catedral da Luz.",
}
