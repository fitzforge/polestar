-- French (frFR): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "La {item:277210}, le paiement de C pour une mission en solo dans le {area:236}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "La boîte aux lettres morte de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest in a house just outside {area:204} in southern Silverpine, south of {area:236}. Open it and read C's note: the job has to be done alone, out of any group."] = "La {object:410369} est un coffre dans une maison juste à l'extérieur du {area:204}, dans le sud de la forêt des Pins-Argentés, au sud du {area:236}. Ouvrez-le et lisez le message de C : le travail doit se faire seul, hors de tout groupe.",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order · {spell:921} Pick Pocket
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon, a short way north-east of {area:460}. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers (level 18) working around him carry them in their pockets. Stealth up behind one and {spell:921} it; killing them does not give it."] = "",
	-- {spell:921} Pick Pocket · {npc:3989} Venture Co. Logger · {item:210187} Venture Co. Work Order
	["{spell:921} a {npc:3989} for a {item:210187}"] = "",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge · {item:5140} Flash Powder · {item:210213} Sister's Half-Key · {item:210212} Brother's Half-Key
	["Go in alone and use the {item:210186} at the courtyard gate. Players also report a freed prisoner opening the courtyard door for you: if you die while he is opening it, stay dead until it is open; it stays open once you release. If you know Vanish, bring {item:5140} and check its cooldown before entering; keep it ready for a failed approach. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212} (a level 20 rogue without Vanish may need ranks in Master of Deception to reach the second one unseen). Combine them somewhere safe: this breaks stealth. Free a bag slot first: opening the chest with full bags can use up the key without giving the horn. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "Entrez seul et utilisez la {item:210186} à la porte de la cour. Des joueurs signalent aussi qu'un prisonnier libéré vous ouvre la porte de la cour : si vous mourez pendant qu'il l'ouvre, restez mort jusqu'à ce qu'elle soit ouverte ; elle reste ouverte une fois que vous libérez votre esprit. Si vous connaissez Disparition, emportez de la {item:5140} et vérifiez son temps de recharge avant d'entrer ; gardez-la prête en cas d'approche ratée. Faites les poches de la sœur dans la salle à manger pour la {item:210213}, puis du frère dans la pièce à laquelle on accède en tournant à droite en haut de l'escalier pour la {item:210212} (un voleur de niveau 20 sans Disparition aura peut-être besoin de rangs dans le talent Maître de l'illusion pour atteindre le second sans être vu). Assemblez-les dans un endroit sûr : cela rompt le camouflage. Libérez d'abord un emplacement de sac : ouvrir le coffre avec des sacs pleins peut consommer la clé sans donner le cor. Retournez aux écuries de la cour et utilisez la clé assemblée sur le coffre pour obtenir le cor. Tenez-vous loin des élites voisins ; le niveau minimum de la quête ne garantit pas une approche sans danger.",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, dans le {area:236}",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "Retour à la boîte aux lettres morte",
	-- {object:410369} Dead Drop
	["Place the horn in the {object:410369} near Pyrewood. The payment may not appear immediately: check a capital mailbox for C's follow-up letter on your next planned city visit, then return to this chest for the reward quest. Do not repeat the dungeon just because the payment is not yet offered."] = "Déposez le cor dans la {object:410369} près de Bois-du-Bûcher. Le paiement peut ne pas apparaître tout de suite : vérifiez une boîte aux lettres de capitale pour la lettre suivante de C lors de votre prochaine visite prévue en ville, puis revenez à ce coffre pour la quête de récompense. Ne refaites pas le donjon simplement parce que le paiement n'est pas encore proposé.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "Entrez seul. La {item:210186} vous fait passer la porte de la cour ; les données n'indiquent pas où se trouve la corne dans le donjon.",
	-- ["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "Déposez la corne dans la {object:410369} près de Bois-du-Bûcher. Le paiement de C est la deuxième quête {item:210183}, au même coffre.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "La {object:410369} est un coffre près de {area:204}, dans le sud de la Forêt des Pins argentés (Silverpine Forest), juste au sud du {area:236}. Lisez le mot de C.",
	-- ["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon, a short way north-east of {area:460}. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers (level 18) working around him carry them."] = "{npc:4086}, un gobelin amical envers les deux factions, se tient parmi la KapitalRisk au {area:461}, dans l'est des Serres-Rocheuses, un peu au nord-est de la {area:460}. Horde : volez jusqu'à la {area:460} ; Alliance : jusqu'au {area:467}. Il veut une {item:210187} avant de vous remettre des explosifs : les Déboiseurs de la KapitalRisk (niveau 18) qui travaillent autour de lui en portent.",
	-- ["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "{npc:4086}, un gobelin amical envers les deux factions, se tient parmi la KapitalRisk au {area:461}, à l'est des Serres-Rocheuses. La Horde vole jusqu'à la {area:460} ; l'Alliance jusqu'au {area:467}. Il veut un {item:210187} avant de vous remettre des explosifs : les Déboiseurs de la KapitalRisk autour de lui en portent.",
}
