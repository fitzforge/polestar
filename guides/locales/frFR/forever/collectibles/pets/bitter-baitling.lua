-- French (frFR): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay · {npc:15077} Riggle Bassbait · {quest:8193} Master Angler · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks by {npc:15077} when it starts. {quest:8193} is not a quest you take: {npc:15077} takes the fish straight from his window when you bring them. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "Bancs de courbines",
	-- {item:19807} Speckled Tastyfish · {area:35} Booty Bay
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {area:35}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {area:35}; more schools lie further north and just south of {area:35}."] = "Pendant le concours, des bancs de {item:19807} apparaissent le long de la côte de Strangleronce, aucun dans {area:35}. Pêchez-y 40 {item:19807} ; chaque banc ne dure que quelques lancers, filez donc au suivant dès qu'il a disparu. La flèche vous fait remonter la côte ouest au nord de {area:35} ; d'autres bancs se trouvent plus au nord et juste au sud de {area:35}.",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "Retournez voir {npc:15077}",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "Revenez vite remettre les 40 courbines à {npc:15077} : les premiers joueurs à le faire gagnent, et les vainqueurs reçoivent la pièce avec leur prix. Si vous arrivez trop tard pour gagner, {npc:15078} paie quand même un peu d'or pour chaque lot de 5 courbines.",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "La pièce du vainqueur, auprès de {npc:15077}",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {area:35} Booty Bay · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {area:35} docks and trades the {item:276275} for the coin."] = "{npc:15078}, l'apprenti de {npc:15077}, se tient à côté de lui sur les quais de {area:35} et échange le {item:276275} contre la pièce.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks when it starts and take {quest:8193} from {npc:15077}. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "Le {item:276275} coûte une {item:274026}, le prix du vainqueur du concours de pêche de Strangleronce. Le concours a lieu le dimanche de 14 h à 16 h, heure du serveur : soyez sur les quais de {area:35} au début et prenez {quest:8193} auprès de {npc:15077}. Venez avec votre meilleure compétence de {skill:356} et des appâts pour qu'aucun poisson ne s'échappe, une monture et des sacs vides, et liez votre pierre de foyer à {area:35}.",
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "Le {item:276275} est une récompense de pêche : {npc:15078} l'échange contre une {item:274026}, récompense du concours de pêche que {npc:15078} organise à {area:35}. La source exacte de la pièce n'est pas encore publiée.",
	-- ["{npc:15077}, during the contest"] = "{npc:15077}, pendant le concours",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078} se tient sur les quais de {area:35}.",
}
