-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "Magos de {area:279}",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "{npc:1920}, um mago raro de nível 21 em {area:233}, no sul de {zone:1421}, solta {npc:7383} em cerca de uma morte em 6. Ele tem um único ponto e pode levar horas para voltar, então olhe sempre que passar. Enquanto ele está morto, os Escudeiros de Dalaran, Teurgistas e Invocadores (nível 31-35) na cratera de {area:279}, onde {zone:1416} encontra {zone:1424}, também soltam, mas em cerca de uma morte em 500. O gato pode ser negociado: olhe também a Casa de Leilões.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "O {npc:1920}, um raro entre os magos de {area:233} no sul de {zone:1421}, o deixa cair em cerca de 17% das vezes nos nossos dados; os outros magos de {area:279} em {area:233} e em volta da cratera de {area:279} o deixam cair em cerca de 0,2%. Mate os magos até o Escriba aparecer. Jogadores da Aliança o compram na Casa de Leilões.",
}
