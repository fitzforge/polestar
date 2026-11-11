-- German (deDE): the guide forever/class/shaman/call-of-earth-alliance (forever/class/shaman/call-of-earth-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94373} Call of Earth
	["{quest:94373} (Alliance)"] = "{quest:94373} (Allianz)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Dein {item:5175}: Ohne es kann kein Erdtotem gewirkt werden. {spell:8071} kommt mit Stufe 4 dazu.",

	-- Step 1: Archaic Rune
	-- {quest:94373} Call of Earth · {quest:98581} Archaic Rune · {npc:658} Sten Stoutarm · {area:132} Coldridge Valley · {quest:179} Dwarven Outfitters · {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["Teo's {quest:94373} needs the {quest:98581} handed in first: {npc:658}, where you entered {area:132}, gives it to Dwarf shamans after his {quest:179}. Bring it up the road to {npc:257446} inside {area:77}."] = "Teos {quest:94373} verlangt, dass du zuerst {quest:98581} abgibst: {npc:658}, dort, wo du {area:132} betreten hast, gibt sie Zwergen-Schamanen nach seiner {quest:179}. Bring sie die Straße hinauf zu {npc:257446} in {area:77}.",

	-- Step 2: Teo Hammerstorm
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {quest:94373} Call of Earth
	["{npc:257446} trains shamans inside {area:77}, the hall at the south end of {area:132}. The quest opens at level 4. Never took it and now 10 or more? {npc:258098} in {zone:1455} or {npc:258113} in {area:131} gives you {quest:94373}, a pointer back to Teo: take it for the experience on the way."] = "{npc:257446} bildet Schamanen in {area:77} aus, der Halle am Südende von {area:132}. Die Quest wird mit Stufe 4 frei. Hast du sie nie angenommen und bist jetzt 10 oder höher? {npc:258098} in {zone:1455} oder {npc:258113} in {area:131} gibt dir {quest:94373}, einen Hinweis zurück zu Teo: Nimm sie für die Erfahrung auf dem Weg mit.",

	-- Step 3: Iceclaw Bear Pendants
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant
	["Iceclaw Bear Pendants"] = "Iceclaw Bear Pendants",
	-- {area:77} Anvilmar
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp · Frostmane Novices = {npc:946} Frostmane Novice · Frostbolts = {spell:116} Frostbolt
	["The Frostmane Troll Whelps (level 3-4) hold the snowy slopes west and south-west of {area:77}, and the Frostmane Novices (level 3-4, they throw Frostbolts from range) camp south of it. Both carry the pendants; they respawn in about three minutes."] = "Die Frostmane Troll Whelps (Stufe 3-4) halten die verschneiten Hänge westlich und südwestlich von {area:77}, und die Frostmane Novices (Stufe 3-4, sie werfen aus der Ferne Frostblitze) lagern südlich davon. Beide tragen die Anhänger; sie respawnen nach etwa drei Minuten.",

	-- Step 4: Teo Hammerstorm
	-- {area:77} Anvilmar · {item:6635} Earth Sapta
	["Back to Teo inside {area:77}. He hands you the {item:6635}: do not drink it yet."] = "Zurück zu Teo in {area:77}. Er gibt dir {item:6635}: Trink es noch nicht.",

	-- Step 5: Lost the Earth Sapta?
	-- {quest:94472} Earth Sapta
	["Lost the {quest:94472}?"] = "{quest:94472} verloren?",
	-- {quest:94472} Earth Sapta
	["Only if the {quest:94472} is gone from your bags (drunk away from the stone, or sold): Teo gives you another."] = "Nur wenn {quest:94472} nicht mehr in deinen Taschen ist (abseits des Steins getrunken oder verkauft): Teo gibt dir ein neues.",
	-- {npc:257446} Teo Hammerstorm · {quest:94472} Earth Sapta
	["{npc:257446}: a new {quest:94472}"] = "{npc:257446}: ein neues {quest:94472}",

	-- Step 6: The Spirit Stone
	["The Spirit Stone"] = "Der Geisterstein",
	-- {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["The Spirit Stone stands on a snowy ridge north-west of {area:77}. The trail is easy to miss: it climbs the hill from the valley floor; at the small camp near the top turn left and the stone comes into view. Stand beside it, drink the {item:6635} and speak to the {npc:5891} before it fades."] = "Der Geisterstein steht auf einem verschneiten Kamm nordwestlich von {area:77}. Der Pfad ist leicht zu übersehen: Er führt vom Talboden den Hügel hinauf; am kleinen Lager nahe der Spitze biegst du links ab, und der Stein kommt in Sicht. Stell dich neben ihn, trink {item:6635} und sprich mit {npc:5891}, bevor sie verblasst.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, neben dem Geisterstein",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "sie gibt dir {item:6656}: Behalte ihn",

	-- Step 7: Teo Hammerstorm
	-- {item:6656} Rough Quartz · {area:77} Anvilmar · {item:5175} Earth Totem
	["Bring the {item:6656} back to Teo inside {area:77}. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Bring {item:6656} zurück zu Teo in {area:77}. Behalte {item:5175} dauerhaft in deinen Taschen: Jedes Erdtotem braucht es.",
	-- {npc:257446} Teo Hammerstorm · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {spell:8071} and your {item:5175}"] = "{npc:257446}: {spell:8071} und dein {item:5175}",
	["the level 4 shaman spells"] = "die Schamanenzauber der Stufe 4",
}
