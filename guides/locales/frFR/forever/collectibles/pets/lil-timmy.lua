-- French (frFR): the guide forever/collectibles/pets/lil-timmy (forever/collectibles/pets/lil-timmy.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Lil Timmy
	-- {npc:8666} Lil Timmy · {npc:7386} White Kitten · {object:2098} Cathedral Square · {object:2096} Trade District · {object:2100} Old Town · {object:28027} Dwarven District
	["{npc:8666} sells the {npc:7386} (60s). He starts at {object:2098} and walks through the {object:2096}, {object:2100} and the {object:28027} before he vanishes near the square again; if he is not around, wait for him at {object:2098}. By beta reports he carries one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "{npc:8666} vend le {npc:7386} (60 pa). Il part de la {object:2098} et passe par le {object:2096}, la {object:2100} et le {object:28027} avant de disparaître de nouveau près de la place ; s'il n'est pas dans le coin, attendez-le à la {object:2098}. D'après les retours de la bêta, il n'a qu'un chaton à la fois : s'il n'en a pas, quelqu'un vient de l'acheter. Chaque objet de mascotte apprend son compagnon quand vous l'utilisez ; l'objectif reste coché ensuite.",
	-- {item:8489} Cat Carrier (White Kitten)
	["{item:8489}, 60s"] = "{item:8489}, 60 pa",

	-- Step 2: Xaphod Bizznox
	-- {npc:7386} White Kitten · {npc:262471} Xaphod Bizznox · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains · {zone:1413} Barrens
	["Horde players buy the {npc:7386} (60s) from {npc:262471}, a trader new in Forever, at {area:2539}, the Darkspear camp at the southern tip of {zone:1442}, on the way up from the {zone:1413}. He keeps one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Horde players buy the {npc:7386} (60s) from {npc:262471}, a trader new in Forever, at {area:2539}, the Darkspear camp at the southern tip of {zone:1442}, on the way up from the {zone:1413}. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "Les joueurs de la Horde achètent le {npc:7386} (60 pa) à {npc:262471}, un marchand nouveau dans Forever, à {area:2539}, le camp des Sombrelances à la pointe sud des {zone:1442}, sur la route qui monte depuis les {zone:1413}. Chaque objet de mascotte apprend son compagnon quand vous l'utilisez ; l'objectif reste coché ensuite.",
	-- ["{npc:8666} sells the {npc:7386} (60s). He walks around the city, so the waypoint is only one point on his path; look along the nearby streets if he is not there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8666} vend le {npc:7386} (60 pa). Il se promène dans la ville, le point de passage n'est donc qu'un point de son trajet ; cherchez dans les rues voisines s'il n'y est pas. Chaque objet de mascotte apprend sa compagnie quand vous l'utilisez ; les objectifs restent cochés ensuite.",
}
