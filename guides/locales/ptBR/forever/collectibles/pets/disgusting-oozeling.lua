-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozes
	["Oozes"] = "Gosmas",
	-- {item:20768} Oozing Bag · {npc:12387} Large Vile Slime · {zone:1422} Western Plaguelands · {item:20769} Disgusting Oozeling
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768} about once in 20-30 kills; the best are the Vile Slimes, Devouring Oozes and the {npc:12387} in the ooze field of eastern {zone:1422} (level 54-57). Open every bag: most hold potions or herbs, and only about one bag in 50 holds the {item:20769}, so expect over a thousand kills. Both the bags and the pet can be traded: unopened bags on the Auction House are lottery tickets, the pet itself the sure buy."] = "Gosmas soltam {item:20768} em cerca de uma morte em 20-30; as melhores são os Visgos Torpes, as Gosmas Devoradoras e {npc:12387} no campo de gosmas do leste de {zone:1422} (nível 54-57). Abra todas as bolsas: a maioria guarda poções ou ervas, e só cerca de uma bolsa em 50 guarda {item:20769}, então conte com mais de mil mortes. As bolsas e o mascote podem ser negociados: bolsas fechadas na Casa de Leilões são bilhetes de loteria, o mascote em si é a compra certa.",
	-- plural, as words: Oozing Bags = {item:20768} Oozing Bag
	["Open your Oozing Bags"] = "Abra suas Sacolas Gosmentas",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "Gosmas derrubam a {item:20768}: os Visgos Torpes, Visgos Torpes Enormes e Gosmas Devoradoras das Terras Pestilentas Ocidentais, e as gosmas de {zone:1448}, {zone:1449} e {zone:1423}, com cerca de 0,07-0,09% por abate em nossos dados. O ponto de rota é um local de surgimento de {npc:1806} no leste de {zone:1422}.",
	-- ["Open the {item:20768}"] = "Abra a {item:20768}",
	-- ["Open the {item:20768} from your bags."] = "Abra a {item:20768} das suas bolsas.",
	-- ["Vile Slimes, {zone:1422}"] = "Visgos Torpes, {zone:1422}",
}
