-- Portuguese (Brazil) (ptBR): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Reputação: Aurora Argêntea",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Aliança)",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} começa em Neutro. Pegue a Ordem com {npc:10840} em {area:3197} e equipe-a: no Classic, Pedras do Flagelo só caem enquanto o berloque {quest:5401} estiver equipado. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horda)",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:152} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} começa em Neutro. Pegue a Ordem com {npc:10839} em {area:152} e equipe-a: no Classic, Pedras do Flagelo só caem enquanto o berloque {quest:5401} estiver equipado. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "Pedras do Flagelo do Lacaio até Amistoso",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:152} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Carniçais e esqueletos por todas as {zone:1422} deixam cair Pedras do Flagelo do Lacaio cerca de metade das vezes; este agrupamento é denso. Entregue-as de 20 em 20 a qualquer Oficial Argênteo (Cândida em {area:3197}, Garush em {area:152}, {npc:11039} em {area:2268}). Cada entrega também rende um {item:12844} para os intendentes da Aurora Argêntea.",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "Pedras do Flagelo do Invasor até Honrado",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair Pedras do Flagelo do Invasor aqui, além das do Lacaio e {item:14047}. Entregue as do Invasor de 10 em 10 e as do Lacaio de 20 em 20 a {npc:11039} em {area:2268}. No Classic, as duas param de dar reputação em Honrado.",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "Pedras do Flagelo do Corruptor e masmorras até Reverenciado",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "A partir de Honrado, Pedras do Flagelo do Corruptor (uma por entrega) e mortes de Flagelo em {area:2279} e {area:2057} rendem a reputação. As do Corruptor caem dos chefes do Flagelo de lá ({npc:1853}, {npc:10433}, Vectus) e de {npc:1852} e Putrídius em {zone:1422}. Várias incursões em masmorras rendem mais rápido do que qualquer caçada em mundo aberto.",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Faça {area:2279} (as duas alas) e {area:2057}, matando todo Flagelo pelo caminho.",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529} até Exaltado",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Continue fazendo {area:2279} e {area:2057} e entregando cada {item:12843} em {area:2268} até Exaltado.",
}
