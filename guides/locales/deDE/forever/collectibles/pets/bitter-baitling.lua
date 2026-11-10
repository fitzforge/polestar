-- German (deDE): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay · {quest:8193} Master Angler · {npc:15077} Riggle Bassbait · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks when it starts and take {quest:8193} from {npc:15077}. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "Der {item:276275} kostet einen {item:274026}, den Preis für den Sieg im Stranglethorn Fishing Extravaganza. Der Wettbewerb läuft sonntags von 14 bis 16 Uhr Serverzeit: Sei bei seinem Start an den Docks von {area:35} und nimm {quest:8193} von {npc:15077} an. Bring deine beste {skill:356}-Fertigkeit und Köder mit, damit kein Fisch entkommt, ein Reittier und leere Taschen, und binde deinen Ruhestein in {area:35}.",
	-- {npc:15077} Riggle Bassbait
	["{npc:15077}, during the contest"] = "{npc:15077}, während des Wettbewerbs",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "Schwärme von Tastyfish",
	-- {item:19807} Speckled Tastyfish · {area:35} Booty Bay
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {area:35}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {area:35}; more schools lie further north and just south of {area:35}."] = "Solange der Wettbewerb läuft, erscheinen entlang der Küste von Stranglethorn Schwärme von {item:19807}, keiner in {area:35}. Angle 40 {item:19807} aus ihnen; jeder Schwarm hält nur ein paar Würfe, reite also zum nächsten, sobald einer verschwunden ist. Der Pfeil führt dich die Westküste nördlich von {area:35} hinauf; weitere Schwärme liegen weiter nördlich und knapp südlich von {area:35}.",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "Zurück zu {npc:15077}",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "Beeil dich und gib die 40 Tastyfish bei {npc:15077} ab: Die ersten Spieler, die das tun, gewinnen, und die Sieger bekommen die Münze mit ihrem Preis. Bist du zu spät, zahlt {npc:15078} trotzdem etwas Gold für je 5 Tastyfish.",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "Die Münze des Siegers, von {npc:15077}",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {area:35} Booty Bay · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {area:35} docks and trades the {item:276275} for the coin."] = "{npc:15078}, der Lehrling von {npc:15077}, steht neben ihm an den Docks von {area:35} und tauscht den {item:276275} gegen die Münze.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "{item:276275} ist eine Angelbelohnung: {npc:15078} tauscht sie gegen eine {item:274026}, eine Belohnung des Angelwettbewerbs, den {npc:15078} in {area:35} veranstaltet. Die genaue Quelle der Münze ist noch nicht veröffentlicht.",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078} steht an den Docks von {area:35}.",
}
