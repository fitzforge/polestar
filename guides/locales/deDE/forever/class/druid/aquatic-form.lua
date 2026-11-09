-- German (deDE): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Deine Reisegestalt fürs Wasser: schnell schwimmen und unter Wasser atmen, dazu ein Gürtel und ein Götze.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. Skyborne: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up."] = "{npc:4217} steht oben im Druidengebäude der {area:1658}. Himmelsgeborene: Wirke {spell:18960} und nimm den Flug von {npc:11800} aus der Mitte von {area:2361} (sie fliegt Druiden nach {area:702}, keine Flugroute nötig), dann das Portal nach oben.",

	-- Step 3: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:29} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:29} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "Wirke {spell:18960}, um hierher zu kommen: {npc:11802} steht oben im Gebäude neben deinem Landeplatz. {quest:29} läuft auf einem 30-Minuten-Timer: Sobald du sie angenommen hast, kein Teleport und kein Ruhestein, bis {npc:11799} sie hat. Sechs Bauble Containers (Vasen) liegen in schmalen Mulden tief auf dem Grund von {area:656} unterhalb von {area:2361}, oft nahe den sprudelnden Spalten (die {object:177524} in der Mitte des Sees füllt deinen Atem auf); jede kommt drei Minuten nach dem Öffnen wieder, und andere Druiden nehmen sie ebenfalls. Prüfe, ob {item:15877} in deinen Taschen ist, bevor du auftauchst: Er verschwindet fünf Minuten nach dem Plündern. Schwimm ihn direkt zu {area:2362} am Nordwestufer, benutze ihn innerhalb des Schreingeländes und sprich mit {npc:11799} am Baum.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, aus einem {object:177785} im See",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Am {area:2362}",

	-- Step 4: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:456} Cliffspring River
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Fly from {area:2361} to {area:442}. The {object:177792} lies far out on the sea floor off the north coast, between tall rocks west of where the {area:456} reaches the sea: it cannot be seen from the east side of the rocks. Watch your breath and the Darkshore Threshers; fight above water."] = "Flieg von {area:2361} nach {area:442}. {object:177792} liegt weit draußen auf dem Meeresgrund vor der Nordküste, zwischen hohen Felsen westlich der Stelle, wo {area:456} ins Meer mündet: Von der Ostseite der Felsen aus ist sie nicht zu sehen. Achte auf deinen Atem und auf die Darkshore Threshers; kämpfe über Wasser.",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}, from the {object:177792}"] = "{item:15883}, aus {object:177792}",

	-- Step 5: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Head west to the coast: the {object:177790} lies far out on the sea floor beside a bubbling fissure (air), west of a sunken anchor. Sharks roam here; do not swim on past the wreck beyond it, the deep water brings fatigue."] = "Nimm das Boot von {area:442} nach {zone:1453} und flieg nach {area:108}. Geh nach Westen zur Küste: {object:177790} liegt weit draußen auf dem Meeresgrund neben einer sprudelnden Spalte (Luft), westlich eines versunkenen Ankers. Hier streifen Haie umher; schwimm nicht am Wrack vorbei weiter hinaus, das tiefe Wasser verursacht Erschöpfung.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "{item:15882}, aus {object:177790}",

	-- Step 6: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "Wirke {spell:18960}. Wenn du beide Hälften in den Taschen hast, stell dich an {area:2362} am Nordwestufer und benutze {item:15883}, um sie zusammenzufügen. Wirke dann {spell:18960} erneut (es funktioniert in {zone:1450}), um bei {npc:11802} zu landen. Er steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden. Danach fliegt {npc:11800} in der Mitte von {area:2361} Druiden direkt nach {area:702}.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: Füge die Hälften am Schrein zusammen",

	-- Step 7: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:31} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:31}: swim fast and breathe underwater."] = "Nimm das Portal nach oben zu {npc:4217} in der {area:1658}. {quest:31}: schnell schwimmen und unter Wasser atmen.",

	-- Step 8: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:5061} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:5061}: swim fast and breathe underwater."] = "Nimm das Portal nach oben zu {npc:4217} in der {area:1658}. {quest:5061}: schnell schwimmen und unter Wasser atmen.",

	-- Step 9: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands in the druids' hut on {area:1639}."] = "{npc:3033} steht in der Druidenhütte auf {area:1639}.",

	-- Step 10: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:28} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:28} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "Wirke {spell:18960}, um hierher zu kommen: {npc:11802} steht oben im Gebäude neben deinem Landeplatz. {quest:28} läuft auf einem 30-Minuten-Timer: Sobald du sie angenommen hast, kein Teleport und kein Ruhestein, bis {npc:11799} sie hat. Sechs Bauble Containers (Vasen) liegen in schmalen Mulden tief auf dem Grund von {area:656} unterhalb von {area:2361}, oft nahe den sprudelnden Spalten (die {object:177524} in der Mitte des Sees füllt deinen Atem auf); jede kommt drei Minuten nach dem Öffnen wieder, und andere Druiden nehmen sie ebenfalls. Prüfe, ob {item:15877} in deinen Taschen ist, bevor du auftauchst: Er verschwindet fünf Minuten nach dem Plündern. Schwimm ihn direkt zu {area:2362} am Nordwestufer, benutze ihn innerhalb des Schreingeländes und sprich mit {npc:11799} am Baum.",

	-- Step 11: Half Pendant of Aquatic Agility
	-- {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:1637} Orgrimmar · {object:177792} Strange Lockbox · {area:382} Sludge Fen
	["Take {npc:11798}'s flight to {area:1638} and fly on to {area:1637}. The {object:177792} lies underwater in the {area:382} pond, a short walk out of {area:1637}'s west gate, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "Nimm den Flug von {npc:11798} nach {area:1638} und flieg weiter nach {area:1637}. {object:177792} liegt unter Wasser im Teich von {area:382}, ein kurzes Stück vor dem Westtor von {area:1637}, vor einer Holzwand. Die Venture Co. dort schließt sich schnell einem Kampf an: Komm von Westen, um die meisten zu umgehen.",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["Back through {area:1637} to the zeppelin towers outside its main gate: the zeppelin to the {zone:1458} lands in {zone:1420}, and {zone:1421} is south of the {zone:1458}."] = "Zurück durch {area:1637} zu den Zeppelintürmen vor dem Haupttor: Der Zeppelin nach {zone:1458} landet in {zone:1420}, und {zone:1421} liegt südlich von {zone:1458}.",

	-- Step 13: Half Pendant of Aquatic Endurance
	-- {object:177790} Strange Lockbox · {area:228} Sepulcher · {spell:18960} Teleport: Moonglade
	["The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down. Then {spell:18960} takes you straight back."] = "{object:177790} liegt auf dem Grund von sehr tiefem Wasser vor der Küste nordwestlich von {area:228}, neben einer Luftspalte, an der du atmen kannst: Achte auf deinen Atem auf dem Weg nach unten. Dann bringt dich {spell:18960} direkt zurück.",

	-- Step 14: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:11798} flies druids to {area:1638}."] = "Wirke {spell:18960}. Wenn du beide Hälften in den Taschen hast, stell dich an {area:2362} am Nordwestufer und benutze {item:15883}, um sie zusammenzufügen. Wirke dann {spell:18960} erneut (es funktioniert in {zone:1450}), um bei {npc:11802} zu landen. Er steht oben in seinem Gebäude: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden. {npc:11798} fliegt Druiden nach {area:1638}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Wirke {spell:18960}. Füge die beiden Hälften beim {area:2362} am Nordwestufer des Sees zu {item:15885} zusammen und geh dann zu {npc:11802} in {area:2361}. Flieg danach nach {area:702}.",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Wirke {spell:18960}. Füge die beiden Hälften beim {area:2362} am Nordwestufer des Sees zu {item:15885} zusammen und geh dann zu {npc:11802} in {area:2361}. {npc:11798} fliegt Druiden nach {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}. Schrein-Schmuckstücke liegen in den Behältern am Grund von {area:656}, unterhalb von {area:2361}: Bring eins zum {area:2362} am Nordwestufer, benutze es dort und sprich mit {npc:11799}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Wirke {spell:18960}. {npc:11802} ist in {area:2361}. Die Schrein-Schmuckstücke liegen am Grund von {area:656} und vergehen binnen Minuten: Schwimm mit einem direkt zum {area:2362} am Nordwestufer, benutze es dort und sprich mit {npc:11799}.",
	-- ["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Flieg von {area:2361} nach {area:442}. Die {object:177792} liegt unter Wasser vor der Nordküste, westlich der {area:443}.",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Head north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Nimm das Schiff von {area:442} nach {zone:1453} und flieg nach {area:108}. Geh nach Nordwesten zur Küste: Die {object:177790} liegt vor dem Ufer auf dem Meeresgrund.",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Nimm das Boot von {area:442} nach {zone:1453} und flieg zur {area:108}. Reite nach Nordwesten zur Küste: Die {object:177790} liegt vor dem Ufer auf dem Meeresgrund.",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "Nimm das Portal hinauf zu {npc:4217} in der {area:1658}.",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Nimm den Flug von {npc:11798} nach {zone:1456}, flieg nach {zone:1454} und nimm den Zeppelin nach {zone:1420}; {zone:1421} liegt südlich von {zone:1458}. Die {object:177790} liegt an der Küste westlich von {area:240}, nördlich von {area:228}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "Die {object:177792} liegt am Nordrand von {area:382} beim Turm der Venture Co., nördlich von {area:380}.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} steht auf der {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} steht in der {area:1658}.",
}
