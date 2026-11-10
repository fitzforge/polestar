-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-earth-alliance (forever/class/shaman/call-of-earth-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94373} Call of Earth
	["{quest:94373} (Alliance)"] = "{quest:94373} (Aliança)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Seu {item:5175}: sem ele, nenhum totem de terra pode ser lançado. {spell:8071} vem junto, no nível 4.",

	-- Step 1: Archaic Rune
	-- {quest:94373} Call of Earth · {quest:98581} Archaic Rune · {npc:658} Sten Stoutarm · {area:132} Coldridge Valley · {quest:179} Dwarven Outfitters · {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["Teo's {quest:94373} needs the {quest:98581} handed in first: {npc:658}, where you entered {area:132}, gives it to Dwarf shamans after his {quest:179}. Bring it up the road to {npc:257446} inside {area:77}."] = "{quest:94373}, do Teo, exige a entrega prévia de {quest:98581}: {npc:658}, onde você entrou em {area:132}, dá essa missão aos xamãs anões depois de {quest:179}. Leve a entrega pela estrada até {npc:257446}, dentro de {area:77}.",

	-- Step 2: Teo Hammerstorm
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {quest:94373} Call of Earth
	["{npc:257446} trains shamans inside {area:77}, the hall at the south end of {area:132}. The quest opens at level 4. Never took it and now 10 or more? {npc:258098} in {zone:1455} or {npc:258113} in {area:131} gives you {quest:94373}, a pointer back to Teo: take it for the experience on the way."] = "{npc:257446} ensina xamãs dentro de {area:77}, o salão no extremo sul de {area:132}. A missão abre no nível 4. Nunca pegou e agora está no 10 ou mais? {npc:258098}, em {zone:1455}, ou {npc:258113}, em {area:131}, entrega {quest:94373}, uma indicação de volta a Teo: pegue pela experiência no caminho.",

	-- Step 3: Iceclaw Bear Pendants
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant
	["Iceclaw Bear Pendants"] = "Pingentes de Urso Garrálgido",
	-- {area:77} Anvilmar
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp · Frostmane Novices = {npc:946} Frostmane Novice · Frostbolts = {spell:116} Frostbolt
	["The Frostmane Troll Whelps (level 3-4) hold the snowy slopes west and south-west of {area:77}, and the Frostmane Novices (level 3-4, they throw Frostbolts from range) camp south of it. Both carry the pendants; they respawn in about three minutes."] = "Os Filhotes de Troll Jubafria (nível 3-4) ocupam as encostas nevadas a oeste e sudoeste de {area:77}, e os Noviços Jubafria (nível 3-4, jogam Seta de Gelo à distância) acampam ao sul dela. Os dois carregam os pingentes; voltam em cerca de três minutos.",

	-- Step 4: Teo Hammerstorm
	-- {area:77} Anvilmar · {item:6635} Earth Sapta
	["Back to Teo inside {area:77}. He hands you the {item:6635}: do not drink it yet."] = "De volta a Teo, dentro de {area:77}. Ele entrega {item:6635} a você: não beba ainda.",

	-- Step 5: Lost the Earth Sapta?
	-- {quest:94472} Earth Sapta
	["Lost the {quest:94472}?"] = "Perdeu {quest:94472}?",
	-- {quest:94472} Earth Sapta
	["Only if the {quest:94472} is gone from your bags (drunk away from the stone, or sold): Teo gives you another."] = "Só se {quest:94472} sumiu das suas bolsas (bebida longe da pedra, ou vendida): Teo entrega outra.",
	-- {npc:257446} Teo Hammerstorm · {quest:94472} Earth Sapta
	["{npc:257446}: a new {quest:94472}"] = "{npc:257446}: uma nova {quest:94472}",

	-- Step 6: The Spirit Stone
	["The Spirit Stone"] = "A Pedra dos Espíritos",
	-- {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["The Spirit Stone stands on a snowy ridge north-west of {area:77}. The trail is easy to miss: it climbs the hill from the valley floor; at the small camp near the top turn left and the stone comes into view. Stand beside it, drink the {item:6635} and speak to the {npc:5891} before it fades."] = "A Pedra dos Espíritos fica numa crista nevada a noroeste de {area:77}. A trilha é fácil de perder: sobe o morro a partir do fundo do vale; no pequeno acampamento perto do topo, vire à esquerda e a pedra aparece. Fique ao lado dela, beba {item:6635} e fale com {npc:5891} antes que ele suma.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, ao lado da Pedra Espiritual",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "ele entrega {item:6656} a você: guarde",

	-- Step 7: Teo Hammerstorm
	-- {item:6656} Rough Quartz · {area:77} Anvilmar · {item:5175} Earth Totem
	["Bring the {item:6656} back to Teo inside {area:77}. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Leve {item:6656} de volta a Teo, dentro de {area:77}. Guarde {item:5175} nas suas bolsas para sempre: todo totem de terra precisa dele.",
	-- {npc:257446} Teo Hammerstorm · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {spell:8071} and your {item:5175}"] = "{npc:257446}: {spell:8071} e seu {item:5175}",
	["the level 4 shaman spells"] = "as magias de xamã do nível 4",
}
