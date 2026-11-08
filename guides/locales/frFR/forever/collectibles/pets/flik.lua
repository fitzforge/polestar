-- French (frFR): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "Grenouilles de la foire de Sombrelune",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "{npc:14860} à la foire de Sombrelune",
	-- {npc:14860} Flik · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {item:11027} Wood Frog Box
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town; Forever has not shown the Faire yet. In Classic it sets up south of Goldshire in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. {npc:14860} runs all over the Faire grounds, so look around for him. He carries only one {item:11027} at a time and restocks it about every 30 minutes: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}, 1 po",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}, 1 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:14860} vend deux grenouilles (1 po chacune) pendant la foire de Sombrelune. Dans Era, la foire s'installe au sud de {area:87}, dans {zone:1429}, un mois, puis près de {zone:1456}, dans {zone:1412}, le mois suivant ; allez à celle qui est ouverte. Chaque objet de mascotte apprend sa mascotte quand vous l'utilisez ; les objectifs restent cochés ensuite.",
	-- ["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town; Forever has not shown the Faire yet. In Classic it sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. {npc:14860} runs all over the Faire grounds, so look around for him. He carries only one {item:11027} at a time and restocks it about every 30 minutes: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:14860} vend deux grenouilles (1 po chacune) quand la foire de Sombrelune est en ville ; Forever n'a pas encore montré la foire. Dans Classic, elle s'installe un mois au sud de {area:87}, dans la {zone:1429}, et le mois suivant près des {zone:1456}, en {zone:1412} ; allez à celle qui est ouverte. {npc:14860} court partout sur le terrain de la foire : cherchez-le bien. Il n'a qu'une {item:11027} à la fois et se réapprovisionne environ toutes les 30 minutes : s'il n'en a pas, quelqu'un vient de l'acheter. Chaque objet de mascotte apprend son compagnon quand vous l'utilisez ; les objectifs restent cochés ensuite.",
}
