-- German (deDE): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "Teufelsjäger (Allianz)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "Der Teufelsjäger, der Dämon gegen Zauberwirker, und {item:22244} für deine Splitter.",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "Mit 30 schickt dich {npc:6122} im Keller von {object:2164} in {object:2101} zu {npc:6251} in {area:392}.",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "Mit 30 schickt dich {npc:6120} in {object:32383} zu {npc:6251} in {area:392}.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["{area:392} is a neutral goblin port on the {zone:1413} coast: the boat from {area:35} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "{area:392} ist ein neutraler Goblinhafen an der Küste des {zone:1413}: Das Boot von {area:35} legt dort an. {npc:6251} steht auf dem Hügel über der Stadt, hinter der Hütte der Ingenieure, bei seinem kleinen Turm; {npc:6266} und zwei Akolythen sind bei ihm. Er schickt dich zu {npc:6294} in {zone:1455}.",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers (no name in this language: may be words) · {quest:1758} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6294} ist in der Bibliothek von {object:32356}. Er will zwei verlorene Teile von {quest:1758}: eines an der Küste von {area:287}, eines in {zone:1441}.",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "Der Foliant ist ein kleines graublaues Buch, das im Sand eines Murloc-Lagers am Ufer südwestlich von {area:271} liegt, nahe am Wasser. Sechs oder sieben Murlocs bewachen es und weitere lauern unter Wasser: Sie kommen in Gruppen, also schick einen in Furcht und lass deinen Leerwandler die übrigen halten. Geh zum Wasser hinunter, um es anzuklicken; vom Hang aus blockieren die Kisten den Cursor.",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "{item:6931}, aus {quest:1802} im Sand",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "Die Zentaurenhöhle öffnet sich in den Klippen nördlich von {area:484}, einer Hordestadt: Halt dich von den Wachen fern. Halte dich drinnen an jeder Gabelung rechts, überquere den Teich am kleinen Wasserfall und öffne die kleine dunkle Kiste an der Wand neben einer größeren Truhe: Die größere ist die falsche. Du kannst sie nur öffnen, solange du die Quest hast. Die Zentauren respawnen hinter dir, wenn du hinausgehst.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, in {object:92423}",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "Zurück zu {npc:6294}",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6294} setzt den Foliant zusammen und gibt dir {item:7006}: Behalte ihn, {npc:6251} nimmt ihn zusammen mit den Stäben.",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Ruten des Kanalisierens",
	-- {area:1036} Angerfang Encampment · {area:150} Menethil Harbor · {area:836} Dun Algaz
	["The Dragonmaw hold {area:1036} in the hills east of the road from {area:150} to {area:836}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "Die Dragonmaw halten {area:1036} in den Hügeln östlich der Straße von {area:150} nach {area:836}. Nur die Zauberwirker lassen die Stäbe fallen, bei vier von fünf Kills: die Bonewarders (Stufe 27, mit Skelett-Begleitern) und Shadowwarders (28). Ein steiler Pfad nördlich des zentralen Geistheilers führt am Großteil der Krieger vorbei ins Lager hinauf.",
	["Rods of Channeling, from the Dragonmaw casters"] = "Stäbe der Kanalisierung, von den Zauberwirkern der Dragonmaw",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "Zurück zu {npc:6251} in {area:392}. Sobald du annimmst, zeichnet er den Beschwörungskreis, und seine Akolythen kanalisieren einen größeren Kreis darüber: Warte im Turm, bis beide fertig sind. Benutze dann {quest:1804} auf dem Kreis. Der Teufelsjäger (Stufe 30, kein Elite) bringt zum Schweigen und frisst Mana und verschwindet nach zwei Minuten: Hab deinen Leerwandler draußen, eröffne sofort mit deinem Schaden über Zeit und lass den Leerwandler tanken. Wenn du stirbst oder er gewinnt, brich {quest:1795} ab und nimm sie bei {npc:6251} erneut an. Behalte den Foliant: {npc:6251} nimmt ihn zurück.",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "{quest:1804}, auf dem Kreis",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Zurück zu {npc:6251} in {area:392}. Benutze {quest:1804} am Beschwörungskreis neben ihm und besiege den Teufelsjäger, um ihn zu binden.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Die Knochenwärter und Schattenwärter der Dragonmaw halten die Hügel östlich der Straße durch {zone:1437}: Die Ruten fallen von ihnen.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931} liegt am Ufer westlich von {area:271}, hinter den Lagern der Murlocs der Fetzenflossen.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423} liegt in der Schlucht nördlich von {area:484}.",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392} liegt an der Küste von {zone:1413}; {npc:6251} steht auf dem Hügel im Ort.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: Er bindet den Teufelsjäger an dich",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294} steht in {object:32356}.",
}
