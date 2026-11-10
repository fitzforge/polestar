-- French (frFR): the guide forever/class/shaman/call-of-earth-alliance (forever/class/shaman/call-of-earth-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94373} Call of Earth
	["{quest:94373} (Alliance)"] = "{quest:94373} (Alliance)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Votre {item:5175} : sans lui, aucun totem de terre ne peut être posé. {spell:8071} vient avec, au niveau 4.",

	-- Step 1: Archaic Rune
	-- {quest:94373} Call of Earth · {quest:98581} Archaic Rune · {npc:658} Sten Stoutarm · {area:132} Coldridge Valley · {quest:179} Dwarven Outfitters · {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["Teo's {quest:94373} needs the {quest:98581} handed in first: {npc:658}, where you entered {area:132}, gives it to Dwarf shamans after his {quest:179}. Bring it up the road to {npc:257446} inside {area:77}."] = "",

	-- Step 2: Teo Hammerstorm
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {quest:94373} Call of Earth
	["{npc:257446} trains shamans inside {area:77}, the hall at the south end of {area:132}. The quest opens at level 4. Never took it and now 10 or more? {npc:258098} in {zone:1455} or {npc:258113} in {area:131} gives you {quest:94373}, a pointer back to Teo: take it for the experience on the way."] = "{npc:257446} forme les chamans à l'intérieur d'{area:77}, la grande salle au sud de la {area:132}. La quête s'ouvre au niveau 4. Vous ne l'avez jamais prise et vous avez 10 ou plus ? {npc:258098} à {zone:1455} ou {npc:258113} à {area:131} vous donne {quest:94373}, qui vous renvoie vers Teo : prenez-la pour l'expérience en chemin.",

	-- Step 3: Iceclaw Bear Pendants
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant
	["Iceclaw Bear Pendants"] = "Pendentifs d'ours griffeglace",
	-- {area:77} Anvilmar
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp · Frostmane Novices = {npc:946} Frostmane Novice · Frostbolts = {spell:116} Frostbolt
	["The Frostmane Troll Whelps (level 3-4) hold the snowy slopes west and south-west of {area:77}, and the Frostmane Novices (level 3-4, they throw Frostbolts from range) camp south of it. Both carry the pendants; they respawn in about three minutes."] = "Les Jeunes trolls Frostmane (niveau 3-4) occupent les pentes enneigées à l'ouest et au sud-ouest d'{area:77}, et les Novices Frostmane (niveau 3-4, ils lancent des Éclairs de givre à distance) campent au sud. Les deux portent les pendentifs ; ils réapparaissent en trois minutes environ.",

	-- Step 4: Teo Hammerstorm
	-- {area:77} Anvilmar · {item:6635} Earth Sapta
	["Back to Teo inside {area:77}. He hands you the {item:6635}: do not drink it yet."] = "Retournez voir Teo à l'intérieur d'{area:77}. Il vous remet le {item:6635} : ne le buvez pas encore.",

	-- Step 5: Lost the Earth Sapta?
	-- {quest:94472} Earth Sapta
	["Lost the {quest:94472}?"] = "Vous avez perdu le {quest:94472} ?",
	-- {quest:94472} Earth Sapta
	["Only if the {quest:94472} is gone from your bags (drunk away from the stone, or sold): Teo gives you another."] = "Seulement si le {quest:94472} n'est plus dans vos sacs (bu loin de la pierre, ou vendu) : Teo vous en donne un autre.",
	-- {npc:257446} Teo Hammerstorm · {quest:94472} Earth Sapta
	["{npc:257446}: a new {quest:94472}"] = "{npc:257446} : un nouveau {quest:94472}",

	-- Step 6: The Spirit Stone
	["The Spirit Stone"] = "La Pierre de l'esprit",
	-- {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["The Spirit Stone stands on a snowy ridge north-west of {area:77}. The trail is easy to miss: it climbs the hill from the valley floor; at the small camp near the top turn left and the stone comes into view. Stand beside it, drink the {item:6635} and speak to the {npc:5891} before it fades."] = "La Pierre de l'esprit se dresse sur une crête enneigée au nord-ouest d'{area:77}. Le sentier est facile à manquer : il gravit la colline depuis le fond de la vallée ; au petit camp près du sommet, tournez à gauche et la pierre apparaît. Placez-vous à côté, buvez le {item:6635} et parlez à la {npc:5891} avant qu'elle ne disparaisse.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, à côté de la Pierre de l'esprit",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "elle vous remet le {item:6656} : gardez-le",

	-- Step 7: Teo Hammerstorm
	-- {item:6656} Rough Quartz · {area:77} Anvilmar · {item:5175} Earth Totem
	["Bring the {item:6656} back to Teo inside {area:77}. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Rapportez le {item:6656} à Teo, à l'intérieur d'{area:77}. Gardez le {item:5175} dans vos sacs pour de bon : chaque totem de terre en a besoin.",
	-- {npc:257446} Teo Hammerstorm · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {spell:8071} and your {item:5175}"] = "{npc:257446} : {spell:8071} et votre {item:5175}",
	["the level 4 shaman spells"] = "les sorts de chaman du niveau 4",
}
