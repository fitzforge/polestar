-- French (frFR): the guide forever/collectibles/pets/baby-crocolisk (forever/collectibles/pets/baby-crocolisk.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sewer Beast
	-- {npc:3581} Sewer Beast · {zone:1453} Stormwind · {item:282047} Baby Crocolisk
	["The {npc:3581} is a rare level 50 crocolisk, much tougher than a normal mob of its level. It swims {zone:1453}'s canals and appears at one of six spots, about two hours after it last died; the arrow takes you round them. Below 60, bring a group; at 60, a well-geared character can try it alone. It drops the {item:282047} about once in 70 kills, and the pet binds when picked up, so the Auction House never has it. Horde players can farm it too, but inside an enemy capital."] = "La {npc:3581} est un crocilisque rare de niveau 50, bien plus coriace qu'un monstre normal de son niveau. Elle nage dans les canaux de {zone:1453} et apparaît à l'un de six endroits, environ deux heures après sa dernière mort ; la flèche vous en fait faire le tour. En dessous du niveau 60, venez en groupe ; au niveau 60, un personnage bien équipé peut tenter seul. Elle lâche le {item:282047} environ une fois sur 70, et la mascotte est liée quand elle est ramassée : l'hôtel des ventes ne l'a donc jamais. Les joueurs de la Horde peuvent aussi la farmer, mais dans une capitale ennemie.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:3581} is a rare level 50 crocolisk that swims {zone:1453}'s canals; early kill counts give about 1.5% per kill. It is friendly to nobody: Horde players can farm it too, but they are in an enemy capital."] = "Le {npc:3581} est un crocilisque rare de niveau 50 qui nage dans les canaux de {zone:1453} ; les premiers relevés donnent environ 1.5% par victoire. Il n'est amical envers personne : les joueurs de la Horde peuvent aussi le chasser, mais ils sont dans une capitale ennemie.",
}
