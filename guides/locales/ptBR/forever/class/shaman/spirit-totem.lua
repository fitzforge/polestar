-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412} e {quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "Experiência e ouro no nível 50, terminando no {area:1417}; o Forever removeu o item à escolha do Classic.",
	["Experience and gold"] = "Experiência e ouro",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom (no name in this language: may be words) · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "No nível 50, {npc:13417}, o instrutor de xamãs no {object:172957}, envia você a {npc:6176}.",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "No nível 50, {npc:3032}, instrutor de xamãs em {zone:1456}, envia você a {npc:6176}.",

	-- Step 3: The four elements
	["The four elements"] = "Os quatro elementos",
	-- {item:7069} Elemental Air
	["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Um de cada: {item:7069}, Fogo, Terra e Água Elemental. Os Exilados do Planalto Arathi os soltam, um elemento cada, em cerca de uma morte em dez: Trovejantes (ar), em Chamas (fogo), Tonitruantes (terra) e Vagalhantes (água). Ou compre na Casa de Leilões.",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}: Exilados Trovejantes",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}: Exilados em Chamas",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}: Exilados Tonitruantes",
	-- {item:7070} Elemental Water
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:7070}: Cresting Exiles"] = "{item:7070}: Exilados Vagalhantes",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} acampa no leste de {zone:1416}, a nordeste de {area:272}.",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "Olho de aranha e garra de urso",
	-- {zone:1422} Western Plaguelands · {item:20610} Bloodshot Spider Eye · {item:20611} Thick Black Claw
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear
	["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "Nas {zone:1422}, as Tocaieiras Rasterruças soltam o {item:20610} e os Ursos Pretos Doentes a {item:20611} (cerca de uma morte em cinco, cada).",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "O {area:1417} ({area:1477}) fica sob o {area:74}; a seta aponta para a entrada. Talho ou {npc:5716} soltam a {item:20606}, Hukkah ou Mirran a azul, Zolo ou Lorro a verde: os seis são trolls elite lá dentro. Leve um grupo.",
}
