-- German (deDE): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "Teufelsjäger (Horde)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "Der Teufelsjäger, der Dämon gegen Zauberwirker, und ein {item:22244} für deine Splitter.",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "Mit Stufe 30 schickt dich {npc:5875}, im Gebiet {object:172960} unter dem {object:172982}, zu {npc:6251} in {area:392}.",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {quest:2996} Seeking Strahad
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}. Take only one {quest:2996}: if {npc:6251} offers nothing, drop the duplicate from your log."] = "Mit Stufe 30 schickt dich {npc:5675} im {object:36082} zu {npc:6251} in {area:392}. Das Luftschiff von {zone:1420} fliegt nach {zone:1411}. Nimm nur eine {quest:2996}: Bietet {npc:6251} nichts an, wirf die doppelte aus deinem Log.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6293} Jorah Annison · {zone:1458} Undercity
	["{area:392}'s flight point is a short flight from {zone:1454}'s. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6293} in the {zone:1458}."] = "Der Flugpunkt von {area:392} ist ein kurzer Flug von dem von {zone:1454} entfernt. {npc:6251} steht auf dem Hügel über der Stadt, hinter der Hütte der Ingenieure, bei seinem kleinen Turm; {npc:6266} und zwei Akolythen sind bei ihm. Er schickt dich zu {npc:6293} in {zone:1458}.",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter · {zone:1458} Undercity · {quest:1801} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6293} is in the {object:36082} of the {zone:1458}. He wants two lost pieces of the {quest:1801}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6293} ist im {object:36082} von {zone:1458}. Er will zwei verlorene Teile von {quest:1801}: eines an der Küste von {area:287}, eines in {zone:1441}.",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "Der Foliant ist ein kleines graublaues Buch, das im Sand eines Murloc-Lagers am Ufer südwestlich von {area:271} liegt, nahe am Wasser. Sechs oder sieben Murlocs bewachen es und weitere lauern unter Wasser: Sie kommen in Gruppen, also schick einen in Furcht und lass deinen Leerwandler die übrigen halten. Geh zum Wasser hinunter, um es anzuklicken; vom Hang aus blockieren die Kisten den Cursor.",
	-- {item:6931} Moldy Tome · {quest:1803} Tome of the Cabal
	["{item:6931}, from the {quest:1803} on the sand"] = "{item:6931}, aus {quest:1803} im Sand",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "Die Zentaurenhöhle öffnet sich in den Klippen nördlich von {area:484}. Halte dich drinnen an jeder Gabelung rechts, überquere den Teich am kleinen Wasserfall und öffne die kleine dunkle Kiste an der Wand neben einer größeren Truhe: Die größere ist die falsche. Du kannst sie nur öffnen, solange du die Quest hast. Die Zentauren respawnen hinter dir, wenn du hinausgehst.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, in der {object:92423}",

	-- Step 7: Back to Jorah Annison
	-- {npc:6293} Jorah Annison
	["Back to {npc:6293}"] = "Zurück zu {npc:6293}",
	-- {npc:6293} Jorah Annison · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6293} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6293} setzt den Foliant zusammen und gibt dir {item:7006}: Behalte ihn, {npc:6251} nimmt ihn zusammen mit den Stäben.",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Kanalisierungsruten",
	-- {area:1036} Angerfang Encampment · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1417} Arathi Highlands
	["The Dragonmaw hold {area:1036} in the hills east of the road through the {zone:1437}, south of the {area:881} you cross from {zone:1417}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "Die Dragonmaw halten {area:1036} in den Hügeln östlich der Straße durch die {zone:1437}, südlich von {area:881}, das du von {zone:1417} aus überquerst. Nur die Zauberwirker lassen die Stäbe fallen, bei vier von fünf Kills: die Bonewarders (Stufe 27, mit Skelett-Begleitern) und Shadowwarders (28). Ein steiler Pfad nördlich des zentralen Geistheilers führt am Großteil der Krieger vorbei ins Lager hinauf.",
	["Rods of Channeling, from the Dragonmaw casters"] = "Stäbe der Kanalisierung, von den Zauberwirkern der Dragonmaw",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "Zurück zu {npc:6251} in {area:392}. Sobald du annimmst, zeichnet er den Beschwörungskreis, und seine Akolythen kanalisieren einen größeren Kreis darüber: Warte im Turm, bis beide fertig sind. Benutze dann {quest:1804} auf dem Kreis. Der Teufelsjäger (Stufe 30, kein Elite) bringt zum Schweigen und frisst Mana und verschwindet nach zwei Minuten: Hab deinen Leerwandler draußen, eröffne sofort mit deinem Schaden über Zeit und lass den Leerwandler tanken. Wenn du stirbst oder er gewinnt, brich {quest:1795} ab und nimm sie bei {npc:6251} erneut an. Behalte den Foliant: {npc:6251} nimmt ihn zurück.",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "{quest:1804}, auf dem Kreis",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Mit Stufe 30 schickt dich {npc:5675}, im {object:36082}, zu {npc:6251} in {area:392}. Der Zeppelin von {zone:1420} fliegt nach {zone:1411}.",
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Zurück zu {npc:6251} in {area:392}. Benutze den {quest:1804} am Beschwörungskreis neben ihm und besiege den Teufelsjäger, um ihn zu binden.",
	-- ["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "Flieg nach {area:392}; {npc:6251} steht auf dem Hügel im Ort.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Die Knochenwärter und Schattenwärter der Dragonmaw halten die Hügel östlich der Straße durch {zone:1437}: Die Ruten droppen von ihnen.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "Der {item:6931} liegt am Ufer westlich von {area:271}, hinter den Murloclagern der Fetzenflossen.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "Die {object:92423} liegt in der Schlucht nördlich vom {area:484}.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: Er bindet den Teufelsjäger an dich",
	-- ["{npc:6293} stands in the {object:36082}."] = "{npc:6293} steht im {object:36082}.",
}
