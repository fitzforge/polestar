-- German (deDE): the guide forever/class/paladin/tome-of-divinity (forever/class/paladin/tome-of-divinity.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["{spell:7328} (Alliance)"] = "{spell:7328} (Allianz)",
	-- {spell:7328} Redemption
	["{spell:7328} at 12, the paladin's resurrection: an easy chain through your capital and its home zone."] = "{spell:7328} mit 12, die Wiederbelebung des Paladins: eine einfache Questreihe durch deine Hauptstadt und ihr Heimatgebiet.",

	-- Step 1: The summons (Human)
	["The summons (Human)"] = "Die Vorladung (Mensch)",
	-- {npc:927} Brother Wilhelm · {area:87} Goldshire · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 12 {npc:927}, the paladin trainer in {area:87}, sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. The errand is optional, a little XP: {npc:5149} in {zone:1455} gives the same one (taking one closes the other), and {npc:6171} starts the chain without it."] = "Mit 12 schickt dich {npc:927}, der Paladinlehrer in {area:87}, zu {npc:6171} in die Kathedrale des Lichts in {zone:1453}. Der Botengang ist optional und bringt ein wenig EP: {npc:5149} in {zone:1455} gibt dieselbe Quest (wenn du die eine annimmst, schließt sich die andere), und {npc:6171} beginnt die Questreihe auch ohne sie.",

	-- Step 2: The summons (Dwarf)
	["The summons (Dwarf)"] = "Die Vorladung (Zwerg)",
	-- {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:6179} Tiza Battleforge · {npc:1232} Azar Stronghammer · {area:131} Kharanos · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 12 {npc:5149}, the paladin trainer in {zone:1455}'s {object:32362}, sends you upstairs to {npc:6179}. The errand is optional, a little XP: {npc:1232} in {area:131} and {npc:928} in {zone:1453} give the same one (taking one closes the others), and {npc:6179} starts the chain without it."] = "Mit 12 schickt dich {npc:5149}, der Paladinlehrer in {object:32362} von {zone:1455}, die Treppe hinauf zu {npc:6179}. Der Botengang ist optional und bringt ein wenig EP: {npc:1232} in {area:131} und {npc:928} in {zone:1453} geben dieselbe Quest (wenn du eine annimmst, schließen sich die anderen), und {npc:6179} beginnt die Questreihe auch ohne sie.",

	-- Step 3: Duthorian Rall
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Kathedrale des Lichts",

	-- Step 5: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {item:6775} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6171} stands inside the Cathedral of Light. He hands you the {item:6775}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6171} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6171} steht in der Kathedrale des Lichts. Er gibt dir {item:6775}: Klicke es in deinen Taschen mit der rechten Maustaste an, um die nächste Quest zu beginnen. Wenn im Buch steht, dass die Quest schon erledigt ist, zerstöre es und bitte {npc:6171} um ein neues Exemplar. Bring für den nächsten Schritt 10 {item:2589} mit, falls du welches hast.",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775}"] = "Klicke {item:6775} mit der rechten Maustaste an",

	-- Step 6: Stephanie Turner
	-- {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth · {zone:1436} Westfall
	["{npc:6174} stands at a corner in the middle of the {object:2096}, outside a general goods store. She wants 10 {item:2589}: humanoids drop it (Riverpaw gnolls in {zone:1436} about every other kill, Defias and kobolds a little less), or buy it at the Auction House a few steps away in the {object:2096}."] = "{npc:6174} steht an einer Ecke mitten im {object:2096}, vor einem Gemischtwarenladen. Sie will 10 {item:2589}: Humanoide lassen es fallen (Riverpaw-Gnolle in {zone:1436} etwa bei jedem zweiten Kill, Defias und Kobolde etwas seltener), oder kaufe es im Auktionshaus, ein paar Schritte entfernt im {object:2096}.",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} x10",

	-- Step 7: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {npc:6171} Duthorian Rall · {item:6866} Symbol of Life · {npc:6173} Gazin Tenorm · {npc:6172} Henze Faulk
	["Back to the Cathedral. {npc:6171} gives you the {item:6866}; {npc:6173} lies wounded by the altar of the same hall. Keep the symbol: you need it on {npc:6172}. If you lose it, {npc:6171} gives you another (The {item:6866})."] = "Zurück zur Kathedrale. {npc:6171} gibt dir {item:6866}; {npc:6173} liegt verwundet am Altar derselben Halle. Behalte das Symbol: Du brauchst es bei {npc:6172}. Wenn du es verlierst, gibt dir {npc:6171} ein neues (das {item:6866}).",

	-- Step 8: Henze Faulk
	-- {npc:6172} Henze Faulk · {area:56} Heroes' Vigil · {area:86} Stone Cairn Lake · {item:6866} Symbol of Life · {spell:116} Frostbolt
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{npc:6172} lies dead on {area:56}, the island in {area:86} in eastern Elwynn, on top of one of the mounds around the stone circle. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes. The Defias Rogue Wizards on the island (level 9-10) cast {spell:116} from far off: they stand apart, so pull one at a time."] = "{npc:6172} liegt tot auf {area:56}, der Insel in {area:86} im östlichen Elwynn, oben auf einem der Hügel rund um den Steinkreis. Wähle seinen Leichnam als Ziel und belebe ihn mit {item:6866} wieder, sprich dann mit ihm. Wenn ihn gerade ein anderer Paladin wiederbelebt hat, ist sein Leichnam nach etwa drei Minuten wieder da. Die Defias Rogue Wizards auf der Insel (Stufe 9-10) wirken {spell:116} aus großer Entfernung: Sie stehen verstreut, also zieh einen nach dem anderen.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["{item:6866} on {npc:6172}'s body"] = "{item:6866} auf den Leichnam von {npc:6172}",

	-- Step 9: The Defias Script
	-- {item:6846} Defias Script
	["The {item:6846}"] = "{item:6846}",
	-- {npc:6172} Henze Faulk · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["The Defias Rogue Wizards around the big stone tablet east of {npc:6172} carry the {item:6846}: about one kill in two drops it, but some players need many kills. They respawn in three minutes."] = "Die Defias Rogue Wizards bei der großen Steintafel östlich von {npc:6172} tragen {item:6846}: Etwa jeder zweite Kill lässt es fallen, aber manche Spieler brauchen viele Kills. Sie respawnen nach drei Minuten.",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Abtrünnige Hexer der Defias",

	-- Step 10: Redemption
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {spell:7328} Redemption
	["Back to the Cathedral of Light: {npc:6173} takes the script, {npc:6171} teaches you {spell:7328}."] = "Zurück zur Kathedrale des Lichts: {npc:6173} nimmt das Schriftstück, {npc:6171} bringt dir {spell:7328} bei.",

	-- Step 11: Tiza Battleforge
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:6179}, upstairs in the {object:32386}"] = "{npc:6179}, oben im {object:32386}",

	-- Step 14: The Tome of Divinity
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6916} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6179} stands upstairs in the {object:32386}, in the {object:32362}: take the ramp at the back of the hall. She hands you the {item:6916}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6179} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6179} steht oben im {object:32386}, in {object:32362}: Nimm die Rampe am Ende der Halle. Sie gibt dir {item:6916}: Klicke es in deinen Taschen mit der rechten Maustaste an, um die nächste Quest zu beginnen. Wenn im Buch steht, dass die Quest schon erledigt ist, zerstöre es und bitte {npc:6179} um ein neues Exemplar. Bring für den nächsten Schritt 10 {item:2589} mit, falls du welches hast.",
	-- {item:6916} Tome of Divinity
	["Right-click the {item:6916}"] = "Klicke {item:6916} mit der rechten Maustaste an",

	-- Step 15: John Turner
	-- {npc:6175} John Turner · {item:2589} Linen Cloth · {npc:1245} Kogan Forgestone · {area:131} Kharanos
	-- plural, as words: Dark Iron Ambushers = {npc:1981} Dark Iron Ambusher
	["{npc:6175} walks the outer ring of the Commons, past the front gate, the bank and the Auction House. He wants 10 {item:2589}: humanoids drop it ({npc:1245} in {area:131} every time, Dark Iron Ambushers about two kills in five), or buy it at the Auction House on his ring."] = "{npc:6175} geht auf dem äußeren Ring der Commons entlang, am Haupttor, der Bank und dem Auktionshaus vorbei. Er will 10 {item:2589}: Humanoide lassen es fallen ({npc:1245} in {area:131} jedes Mal, Dark Iron Ambushers in etwa zwei von fünf Kills), oder kaufe es im Auktionshaus auf seinem Ring.",

	-- Step 16: The Symbol of Life
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6179} Tiza Battleforge · {item:6866} Symbol of Life · {npc:6178} Muiredon Battleforge · {npc:6177} Narm Faulk
	["Back upstairs in the {object:32386}. {npc:6179} gives you the {item:6866}; her husband {npc:6178} rests on the same floor. Keep the symbol: you need it on {npc:6177}. If you lose it, {npc:6179} gives you another (The {item:6866})."] = "Wieder nach oben in den {object:32386}. {npc:6179} gibt dir {item:6866}; ihr Mann {npc:6178} ruht auf demselben Stockwerk. Behalte das Symbol: Du brauchst es bei {npc:6177}. Wenn du es verlierst, gibt dir {npc:6179} ein neues (das {item:6866}).",

	-- Step 17: Narm Faulk
	-- {npc:6177} Narm Faulk · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:131} Kharanos · {area:212} Helm's Bed Lake · {object:147516} Dark Iron · {item:6866} Symbol of Life
	["{npc:6177} lies dead in {zone:1426}, not {zone:1432}: east past {area:131}, north-east of Ironband's compound, on the smallest of three little hills between {area:212} and the {object:147516} camp. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes."] = "{npc:6177} liegt tot in {zone:1426}, nicht in {zone:1432}: östlich an {area:131} vorbei, nordöstlich von Ironbands Anlage, auf dem kleinsten von drei Hügeln zwischen {area:212} und dem Lager von {object:147516}. Wähle seinen Leichnam als Ziel und belebe ihn mit {item:6866} wieder, sprich dann mit ihm. Wenn ihn gerade ein anderer Paladin wiederbelebt hat, ist sein Leichnam nach etwa drei Minuten wieder da.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["{item:6866} on {npc:6177}'s body"] = "{item:6866} auf den Leichnam von {npc:6177}",

	-- Step 18: The Dark Iron Script
	-- {item:6847} Dark Iron Script
	["The {item:6847}"] = "{item:6847}",
	-- {item:6847} Dark Iron Script
	["The Dark Iron Spies (level 9-11, twelve of them) sneak around the little house below the lake, just south of Narm; you see them from his hill. About one kill in two drops the {item:6847}. They run for help at low health: finish them or step back. They respawn in three minutes."] = "Die Dark Iron Spies (Stufe 9-11, zwölf an der Zahl) schleichen um das kleine Haus unterhalb des Sees, südlich von Narm; du siehst sie von seinem Hügel aus. Etwa jeder zweite Kill lässt {item:6847} fallen. Sie rufen bei wenig Leben um Hilfe: Erledige sie oder tritt zurück. Sie respawnen nach drei Minuten.",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Spione der Dunkeleisenzwerge",

	-- Step 19: Redemption
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6178} Muiredon Battleforge · {npc:6179} Tiza Battleforge · {spell:7328} Redemption
	["Back up to the {object:32386}: {npc:6178} takes the script, {npc:6179} teaches you {spell:7328}."] = "Zurück nach oben in den {object:32386}: {npc:6178} nimmt das Schriftstück, {npc:6179} bringt dir {spell:7328} bei.",
}
