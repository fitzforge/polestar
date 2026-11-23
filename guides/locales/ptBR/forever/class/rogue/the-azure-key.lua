-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "Reputação com Corvoforte e experiência no nível 50; a escolha de item do Classic pode ter sumido no Forever.",
	["Ravenholdt reputation"] = "Reputação com Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Aliança)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "No nível 50, {npc:918}, em {object:2100}, em {zone:1453}, tem esta; Syurna, em {zone:1457}, e {npc:5165}, em {zone:1455}, também.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horda)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "No nível 50, {npc:3328} na {object:172960} a tem; assim como {npc:4583} no {object:36073} de {zone:1458}.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {zone:1416} Alterac Mountains
	["{area:3486} hides in the hills east of {area:272}. Horde fly to {area:272}, Alliance to {area:271}. The trail starts behind the plateau north of {area:275}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "{area:3486} fica escondida nas colinas a leste de {area:272}. A Horda voa para {area:272}, a Aliança para {area:271}. A trilha começa atrás do planalto ao norte de {area:275}, sobe pelas colinas e passa por um túnel pequeno até {zone:1416}; Lord Jorach está dentro da mansão. Não ataque ninguém na mansão: perder reputação com Corvoforte faz com que ele se recuse a falar com você.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara · {spell:921} Pick Pocket · {area:1769} Timbermaw Hold · {spell:403} Lightning Bolt · {spell:6535} Lightning Cloud
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. {spell:921} them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with {area:1769}, mark them At War in your reputation panel first. They cast {spell:403} and {spell:6535}, heal each other and run at low health."] = "A Aliança voa para {area:3137}, a Horda para {area:1237}. Só os Xamãs Presamatos de nível 50-51, nas colinas dos furbolgs do norte de {zone:1447}, carregam a bolsa (os furbolgs de nível 47-49 mais ao sul, não): cerca de uma morte em trinta solta. Use {spell:921} neles em vez de matar e você não perde reputação com os Presamatos; se você é Inamistoso ou melhor com {area:1769}, marque-os como Em Guerra no painel de reputação antes. Eles lançam {spell:403} e {spell:6535}, curam uns aos outros e fogem com pouca vida.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo · {area:1237} Valormok
	["{npc:8395}, camped below the cliffs just east of {area:1237}, teleports you up (dismount first); a trail leads to Xylem's tower."] = "{npc:8395}, acampado embaixo dos penhascos, logo a leste de {area:1237}, teletransporta você para cima (desmonte antes); uma trilha leva à torre de Xylem.",

	-- Step 6: Encoded Fragments
	-- {spell:6907} Diseased Slime · {area:2497} Bitter Reaches · {zone:1447} Azshara · {area:1237} Valormok
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, {spell:6907} up close) drop a fragment four times in five: the biggest group, seven of them, is in the {area:2497} hills of north-eastern {zone:1447}, four more south-east of {area:1237}. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "As Gosmas Florestais (nível 52-53, {spell:6907} de perto) soltam um fragmento quatro vezes em cinco: o maior grupo, de sete, fica nas colinas de {area:2497}, no nordeste de {zone:1447}, e mais quatro ao sudeste de {area:1237}. Bata a carteira delas antes de matar para ganhar um fragmento ou dois a mais. Matar os Assoladores Alanévoa e os hipogrifos que dividem os mesmos pontos faz aparecer mais gosmas.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "De volta a Tauriel",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz no {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:2094} Blind
	["Morphaz, a level 52 elite green drake, lives deep in the {area:1417}: a group of five, level 50-54. The temple stands in the {area:74}; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their {spell:12533} is nature damage: nature protection potions help; poisons and {spell:2094} do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "Morphaz, um dragão verde elite de nível 52, mora no fundo de {area:1417}: um grupo de cinco, nível 50-54. O templo fica em {area:74}; entre no prédio afundado, nade para baixo por ele e siga a passagem até o portal. Horda: voe para {area:75}; Aliança: voe para {area:1438} e continue cavalgando. Ele não está lá quando você chega: primeiro mate os seis guardiões trolls (elites de 50-52) nas plataformas do anel de cima, o que abre o caminho para baixo (a rampa da esquerda a partir da entrada) até {npc:5710}, no Fosso do Sacrifício. A morte de Jammal'an traz dois dragonetes, Tecelão e Darquimeros; quando os dois morrem, Morphaz e Hazzas aparecem juntos e lutam em dupla. O {spell:12533} deles é dano de natureza: poções de proteção contra a natureza ajudam; venenos e {spell:2094} não funcionam neles. A chave sempre cai. Caçadores, Sacerdotes e Magos de nível 50 também precisam de Morphaz: uma limpeza serve a todos.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Morphaz, dentro do templo",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Lorde Ravenholdt",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "Olhe a janela de recompensa antes de entregar: o Classic oferecia {item:19982}, {item:19984} ou {item:20255}, e as notas do Forever dizem que a escolha pode ter sumido.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "A Aliança voa para {area:3137}, a Horda para {area:1237}. Os Xamãs Presamatos nas colinas do norte de {zone:1447} deixam cair a bolsa, cerca de um em trinta.",
	-- ["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "No nível 50, {npc:918} em {object:2100} de {zone:1453} a tem; assim como Syurna em {zone:1457} e {npc:5165} e Degrauzinho em {zone:1455}.",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, um draco verde, é um chefe de elite no fundo do {area:1417}, uma masmorra de nível 50: leve um grupo de cinco. O templo fica no {area:74}; nade até a entrada. Horda: voe para {area:75}; Aliança: voe para {area:1438} e siga cavalgando.",
	-- ["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Reputação com Ravenholdt e experiência no nível 50; o Forever removeu a escolha de item do Classic.",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "As Gosmas Florestais do sul de {zone:1447} deixam cair os fragmentos.",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} se esconde nas colinas a leste de {area:272}, subindo uma trilha para as {zone:1416}. A Horda voa para {area:272}, a Aliança para {area:271}.",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768}: sem escolha de itens no Forever",
}
