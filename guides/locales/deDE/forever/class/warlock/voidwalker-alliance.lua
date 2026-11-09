-- German (deDE): the guide forever/class/warlock/voidwalker-alliance (forever/class/warlock/voidwalker-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Alliance)"] = "Leerwandler (Allianz)",
	-- {npc:6122} Gakin the Darkbinder
	["Your tank demon at 10: the voidwalker, after a dark sorceress's choker and a fight in {npc:6122}'s crypt."] = "Dein Tank-Dämon auf Stufe 10: der Leerwandler, nach dem Halsband einer dunklen Zauberin und einem Kampf in der Krypta von {npc:6122}.",

	-- Step 1: Gakin's Summons (Humans)
	-- {quest:1685} Gakin's Summons
	["{quest:1685} (Humans)"] = "{quest:1685} (Menschen)",
	-- {npc:6121} Remen Marcot · {area:87} Goldshire · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 10 {npc:6121}, in the cellar of the Lion's Pride Inn in {area:87} (the stairs down are in the back room past the butcher's table), sends you to {npc:6122} in {zone:1453}."] = "Mit Stufe 10 schickt dich {npc:6121}, im Keller des Lion's Pride Inn in {area:87} (die Treppe nach unten ist im Hinterzimmer hinter dem Fleischertisch), zu {npc:6122} in {zone:1453}.",
	-- {npc:6121} Remen Marcot
	["{npc:6121}, Lion's Pride Inn cellar"] = "{npc:6121}, Keller des Lion's Pride Inn",

	-- Step 2: The Slaughtered Lamb (Gnomes)
	-- {quest:1715} The Slaughtered Lamb
	["{quest:1715} (Gnomes)"] = "{quest:1715} (Gnome)",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 10 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257} from {object:171524}. If {npc:6120} does not offer it, go to {npc:6122} anyway: he still gives you the next quest."] = "Mit Stufe 10 schickt dich {npc:6120}, der Hexenmeisterlehrer in {object:32383} von {zone:1455}, zu {npc:6122} in {zone:1453}. Nimm die {area:2257} ab {object:171524}. Bietet {npc:6120} sie nicht an, geh trotzdem zu {npc:6122}: Er gibt dir trotzdem die nächste Quest.",

	-- Step 3: Gakin the Darkbinder
	-- {quest:1715} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{quest:1715} is the tavern in the {object:2101}; {npc:6122} is in its cellar, down the stairs inside."] = "{quest:1715} ist die Taverne im {object:2101}; {npc:6122} ist in ihrem Keller, die Treppe drinnen hinunter.",

	-- Step 4: Surena Caledon
	-- {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch · {npc:473} Morgan the Collector
	["{npc:881} (level 9) is inside the farmhouse at the {area:62}, south-east Elwynn near the Redridge road. {npc:473} (level 10) and a warrior stand with her and join the fight; Morgan gouges and goes for your imp, so keep him Feared. Put your damage over time on {npc:881} first, Fear the others, and loot her choker before you finish them: it stays yours even if you die after. She throws fireballs from range and is back three minutes after she dies. Have the quest before you kill her, or the choker does not drop."] = "{npc:881} (Stufe 9) ist im Bauernhaus am {area:62}, im Südosten von Elwynn nahe der Straße nach Redridge. {npc:473} (Stufe 10) und ein Krieger stehen bei ihr und greifen in den Kampf ein; Morgan hebelt aus und geht auf deinen Wichtel los, halte ihn also in Furcht. Setz deinen Schaden über Zeit zuerst auf {npc:881}, schick die anderen in Furcht und plündere ihr Halsband, bevor du sie erledigst: Es bleibt deins, auch wenn du danach stirbst. Sie wirft aus der Distanz Feuerbälle und ist drei Minuten nach ihrem Tod wieder da. Hab die Quest, bevor du sie tötest, sonst fällt das Halsband nicht.",

	-- Step 5: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:6122}. He hands you the {item:6928}. The circle is hard to find: take the stairs behind {npc:6122} down; part way along the lowest corridor a side stair on the left leads into a room with a glowing purple circle in the middle. Stand on it and use the choker. The voidwalker (level 10, not elite) gets dangerous below 30% health: {spell:14868}, Corruption and {spell:348} with your imp on it, Fear when it gets close. If it beats you, use the choker again. Keep the choker: {npc:6122} takes it back."] = "Zurück zu {npc:6122}. Er gibt dir {item:6928}. Der Kreis ist schwer zu finden: Nimm die Treppe hinter {npc:6122} nach unten; ein Stück weit im untersten Gang führt links eine Seitentreppe in einen Raum mit einem leuchtenden violetten Kreis in der Mitte. Stell dich darauf und benutze das Halsband. Der Leerwandler (Stufe 10, kein Elite) wird unter 30 % Gesundheit gefährlich: {spell:14868}, Verderbnis und {spell:348} mit deinem Wichtel darauf, Furcht, wenn er nah kommt. Besiegt er dich, benutze das Halsband erneut. Behalte das Halsband: {npc:6122} nimmt es zurück.",
	-- {item:6928} Bloodstone Choker
	["{item:6928}, on the circle in the crypt"] = "{item:6928}, auf dem Kreis in der Krypta",
}
