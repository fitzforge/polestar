-- French (frFR): the guide forever/class/mage/atiesh (forever/class/mage/atiesh.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2279} Stratholme
	["The legendary staff of the Guardian: forty splinters from Naxxramas, two raid bosses and a demon in {area:2279}."] = "Le bâton légendaire du Gardien : quarante éclats de Naxxramas, deux boss de raid et un démon à {area:2279}.",

	-- Step 1: Splinters of Atiesh
	["Splinters of Atiesh"] = "Éclats d'Atiesh",
	-- {area:2277} Plaguewood · {zone:1423} Eastern Plaguelands · {npc:15990} Kel'Thuzad
	["Forty Splinters of Atiesh drop in Naxxramas, the 40-player raid in the necropolis over the {area:2277} in {zone:1423}: each of its twelve bosses before Sapphiron and {npc:15990}, and the Four Horsemen's chest, drops one about a third of the time, and the raid shares them out. It takes many weeks of clears. Keep every splinter in one stack."] = "Quarante Éclats d'Atiesh tombent dans Naxxramas, le raid à 40 joueurs dans la nécropole au-dessus du {area:2277}, en {zone:1423} : chacun de ses douze boss avant Saphiron et {npc:15990}, ainsi que le coffre des Quatre cavaliers, en laisse tomber un environ une fois sur trois, et le raid se les partage. Il faut de nombreuses semaines de raids. Gardez tous les éclats en une seule pile.",
	-- {spell:28324} Forming Frame of Atiesh · {quest:9250} Frame of Atiesh
	["{spell:28324}: forty splinters become the {quest:9250}"] = "{spell:28324} : quarante éclats deviennent le {quest:9250}",

	-- Step 2: Anachronos
	-- {quest:9250} Frame of Atiesh · {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Right-click the {quest:9250} to start the quest, then take it to {npc:15192}, the bronze dragon in elf form who stands outside the {area:2300} in eastern {zone:1446}. Fly to {area:976} and ride east."] = "Faites un clic droit sur le {quest:9250} pour lancer la quête, puis apportez-le à {npc:15192}, le dragon de bronze sous forme d'elfe qui se tient devant les {area:2300}, dans l'est de {zone:1446}. Volez jusqu'à {area:976} et continuez vers l'est à monture.",

	-- Step 3: The Staff Head and the Base
	["The Staff Head and the Base"] = "La tête du bâton et la base",
	-- {item:22733} Staff Head of Atiesh · {npc:15990} Kel'Thuzad · {item:22734} Base of Atiesh · {npc:15727} C'Thun · {area:16076} Temple of Ahn'Qiraj · {area:3478} Gates of Ahn'Qiraj · {zone:1451} Silithus
	["Two more raid bosses, a full 40-player raid each, both pieces always drop: the {item:22733} from {npc:15990} on his throne at the top of Naxxramas, the {item:22734} from {npc:15727} at the bottom of the {area:16076}, behind the {area:3478} in southern {zone:1451}. Each boss comes back once a week."] = "Deux autres boss de raid, chacun pour un raid complet de 40 joueurs, et les deux pièces tombent toujours : la {item:22733} sur {npc:15990}, sur son trône au sommet de Naxxramas, la {item:22734} sur {npc:15727}, tout au fond du {area:16076}, derrière les {area:3478} dans le sud de {zone:1451}. Chaque boss revient une fois par semaine.",
	-- {item:22733} Staff Head of Atiesh · {npc:15990} Kel'Thuzad
	["{item:22733}: {npc:15990}, Naxxramas"] = "{item:22733} : {npc:15990}, Naxxramas",
	-- {item:22734} Base of Atiesh · {npc:15727} C'Thun · {area:16076} Temple of Ahn'Qiraj · {object:176146} Gate of Ahn'Qiraj (no name in this language: may be words)
	["{item:22734}: {npc:15727}, {area:16076}, past the {object:176146}"] = "{item:22734} : {npc:15727}, {area:16076}, après la porte d'Ahn'Qiraj",

	-- Step 4: Back to Anachronos
	-- {npc:15192} Anachronos
	["Back to {npc:15192}"] = "Retour auprès d'{npc:15192}",
	-- {npc:16387} Atiesh
	["your class's {npc:16387} quest; he hands you the befouled staff"] = "la quête {npc:16387} de votre classe ; il vous remet le bâton souillé",

	-- Step 5: Atiesh, Hand of Sargeras
	-- {npc:16387} Atiesh
	["{npc:16387}, Hand of Sargeras"] = "{npc:16387}, Main de Sargeras",
	-- {area:2279} Stratholme · {zone:1423} Eastern Plaguelands · {object:175433} Festival Lane (no name in this language: may be words) · {object:181206} Consecrated Earth (no name in this language: may be words) · {npc:16387} Atiesh · {spell:17466} Unholy Aura · {spell:28342} Breath of Sargeras
	["Take the befouled staff to {area:2279}, the dungeon at the north end of {zone:1423}, through the main gate. On {object:175433} find the patch of {object:181206} with a small white flame on it, stand on it and use the staff: {npc:16387}, Hand of Sargeras (level 63 boss) steps out. Bring a strong group: his {spell:17466} hurts everyone and cannot be dispelled (shadow resistance helps), his {spell:28342} curse must be removed at once, and a warrior's Disarm makes him drop his sword, which a melee player can pick up and use against him. He stays up to two and a half hours, so you can regroup."] = "Apportez le bâton souillé à {area:2279}, le donjon à l'extrémité nord des {zone:1423}, par la porte principale. Dans l'allée du Festival, trouvez la parcelle de Terre consacrée où brûle une petite flamme blanche, placez-vous dessus et utilisez le bâton : {npc:16387}, Main de Sargeras (boss de niveau 63), apparaît. Venez avec un groupe solide : son {spell:17466} blesse tout le monde et ne peut pas être dissipé (la résistance à l'Ombre aide), sa malédiction {spell:28342} doit être retirée immédiatement, et le Désarmement d'un guerrier lui fait lâcher son épée, qu'un joueur de mêlée peut ramasser et utiliser contre lui. Il reste jusqu'à deux heures et demie, vous pouvez donc vous regrouper.",
	-- {object:181206} Consecrated Earth (no name in this language: may be words) · {area:2279} Stratholme
	["the befouled staff, on the {object:181206} inside {area:2279}"] = "le bâton souillé, sur la Terre consacrée à l'intérieur de {area:2279}",

	-- Step 6: The Greatstaff
	["The Greatstaff"] = "Le grand bâton",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["Back to {npc:15192} at the {area:2300}."] = "Retour auprès d'{npc:15192} aux {area:2300}.",
}
