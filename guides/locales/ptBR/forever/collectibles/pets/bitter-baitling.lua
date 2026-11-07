-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay · {quest:8193} Master Angler · {npc:15077} Riggle Bassbait · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks when it starts and take {quest:8193} from {npc:15077}. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "{item:276275} custa uma {item:274026}, o prêmio de vencer a Stranglethorn Fishing Extravaganza. O torneio acontece aos domingos, das 14h às 16h no horário do servidor: esteja nas docas de {area:35} quando começar e pegue {quest:8193} com {npc:15077}. Leve sua melhor perícia de {skill:356} e iscas para nenhum peixe escapar, uma montaria e bolsas vazias, e vincule sua Pedra de Regresso em {area:35}.",
	-- {npc:15077} Riggle Bassbait
	["{npc:15077}, during the contest"] = "{npc:15077}, durante o torneio",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "Cardumes de Peixe Saboroso",
	-- {item:19807} Speckled Tastyfish · {area:35} Booty Bay
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {area:35}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {area:35}; more schools lie further north and just south of {area:35}."] = "Enquanto o torneio dura, cardumes de {item:19807} aparecem ao longo da costa do Espinhaço, nenhum dentro de {area:35}. Pesque 40 {item:19807} neles; cada cardume dura só alguns lançamentos, então siga para o próximo assim que um acabar. A seta leva você pela costa oeste, ao norte de {area:35}; mais cardumes ficam mais ao norte e logo ao sul de {area:35}.",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "De volta a {npc:15077}",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "Volte depressa e entregue os 40 Peixes Saborosos a {npc:15077}: os primeiros jogadores a fazer isso vencem, e os vencedores recebem a moeda junto com o prêmio. Se for tarde demais para vencer, {npc:15078} ainda paga um pouco de ouro a cada 5 Peixes Saborosos.",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "A moeda do vencedor, de {npc:15077}",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {area:35} Booty Bay · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {area:35} docks and trades the {item:276275} for the coin."] = "{npc:15078}, aprendiz de {npc:15077}, fica ao lado dele nas docas de {area:35} e troca {item:276275} pela moeda.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "O {item:276275} é uma recompensa de pesca: {npc:15078} o troca por uma {item:274026}, recompensa do torneio de pesca que {npc:15078} organiza em {area:35}. A origem exata da moeda ainda não foi divulgada.",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078} fica nas docas de {area:35}.",
}
