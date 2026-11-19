-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",

	-- Step 2: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom (no name in this language: may be words) · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: guarde-a para {zone:1451}",

	-- Step 3: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010} trabalha no Arrasto.",

	-- Step 4: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1423} Eastern Plaguelands
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "Só se {quest:4494} ainda não estiver feita: {npc:7010} trabalha no Arrasto. Pestlezugg a recebe em {area:976}, no caminho do Guia de {zone:1423} para Un'Goro.",

	-- Step 5: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 6: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "A oficina de Liv fica no extremo norte das docas de {area:392}; {object:149036} está lá dentro.",
	["Inside"] = "Lá dentro",

	-- Step 7: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} acampa na praia logo ao norte de {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "A Água Purificada vai para o {area:2479} em {zone:1448}: guarde-a para depois.",

	-- Step 8: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "As caixas de {npc:256386}",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "Siga a cavalo pela estrada ao norte até a Encruzilhada; {npc:256386} fica lá. Abra cada caixa que ela entregar e traga de volta o que estiver dentro. Siga voando para {area:1237} a partir da Encruzilhada.",

	-- Step 9: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Voe para {area:1237}",
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 10: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}: {quest:91569}, uma varinha dos arcanistas elfos sangrentos",

	-- Step 11: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}: vá matando estes pelo caminho",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "Siga para o leste até as ruínas na costa. As quatro tábuas estão entre as ruínas, guardadas por nagas Açoitadores (52-55): puxe um de cada vez.",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Siga para leste até as ruínas na costa. Encha os quatro frascos de Cuely nas poças de maré ao longo da praia; nagas Iralisca patrulham entre elas.",

	-- Step 13: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "Escavadores Makrinni",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "Os Escavadores Makrinni (50-51) cavam nas areias logo a leste das ruínas, no caminho para nordeste; eles e os esconderijos enterrados ali fornecem os Fragmentos de Tesouro Altaneiro.",

	-- Step 14: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "Continue para nordeste pelo centro de {zone:1447}: {npc:235903} acampa junto à estrada.",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}: {quest:86746}, os sátiros ao norte do acampamento dos elfos sangrentos",

	-- Step 15: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "Siga para nordeste até o acampamento do goblin nos penhascos acima da {area:1227}, logo ao norte dos elfos sangrentos.",

	-- Step 16: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Os elfos sangrentos acampam nos penhascos a nordeste, junto à {area:1227}. As quatro peças de equipamento de {npc:8420} estão nos caixotes em volta do acampamento; os Arcanistas Elfos Sangrentos carregam a varinha de {npc:247473}.\nCuidado: um {npc:250023}, elite de nível 55-57, fica na borda oeste do acampamento: enfrente os elfos sangrentos pelo lado leste dele.",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}, dos Arcanistas Elfos Sangrentos",

	-- Step 17: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "O acampamento da {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "O acampamento de Rimtori fica no extremo leste do acampamento-base. Leia o {object:151286} lá: no Forever, o Tomo Sin'dorei ao lado pede então os selos dos três oficiais do acampamento.",

	-- Step 18: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "Cada um dos três oficiais do acampamento (53) carrega um selo: {npc:247006} no centro do acampamento, {npc:247013} no extremo leste e {npc:246991}, que patrulha a metade oeste: enfrente-o no lado leste da patrulha, onde a Seta aponta.\nCuidado: o {npc:250023}, elite de nível 55-57, fica na borda oeste do acampamento, perto do fim da patrulha de Hawkhelm: espere Hawkhelm voltar para o leste.",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}, de {npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}, de {npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}, de {npc:247013}",

	-- Step 19: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "Volte ao Tomo Sin'dorei: entregue os selos e use-o para invocar {npc:8578}.\nCuidado: qual cristal está ligado a Rimtori é aleatório. Cada um dos outros dois invoca um infernal hostil.",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}: para {npc:8587} em {area:1237}",

	-- Step 20: The Legashi satyrs
	["The Legashi satyrs"] = "Os sátiros Legashi",
	-- {npc:235903} Ekkal
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "Os sátiros Legashi (51-52) ocupam as colinas ao norte do acampamento dos elfos sangrentos: {npc:235903} quer cinco de cada tipo.",

	-- Step 21: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "Volte para noroeste até {npc:8420}.",

	-- Step 22: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "Siga para o sul até a borda norte das {area:1221}. As Sirenas e os Mirmidões Iralisca (50-52) dali carregam a runa de {npc:8420}; ela não cai com frequência, então avance pela borda até conseguir.",

	-- Step 23: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "Volte para o norte até {npc:8420} com a runa e depois siga para sudoeste pela estrada.",

	-- Step 24: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "Para sudoeste pela estrada: {npc:235903} recebe os sátiros.",

	-- Step 25: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Volte para oeste até {area:1237}.",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}: {quest:91531}, para {npc:4485} em {zone:1454}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}: o tomo vai para {npc:3326} em {zone:1454}",
	-- {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1456} Thunder Bluff
	["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "Guarde as entregas para {npc:8659}, {npc:6522}, {npc:4485} e {npc:3326}: você passa por {zone:1454} e pela {zone:1458} em seguida. A de Magatha, em {zone:1456}, fica fora desta rota: deixe-a.",

	-- Step 26: Archmage Xylem
	-- {area:1237} Valormok · {npc:8395} Sanath Lim-yo
	["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "A torre de Xylem fica no penhasco logo ao norte de {area:1237}: {npc:8395}, em {area:1237}, teleporta você lá para cima de graça (fale com ele); senão, o caminho sobe serpenteando pelo lado norte.",
	["Upstairs"] = "No andar de cima",

	-- Step 28: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "Mestre de voo de {area:1237}",

	-- Step 29: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {zone:1454} não tem instrutor de paladino",

	-- Step 30: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "Voe para {zone:1454} e treine.",

	-- Step 31: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "Voe para {zone:1454}; {npc:4485} está no {object:172958}, {npc:3326} e {npc:8659} na {object:172960}.",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words)
	["{npc:3326}, the {object:172960}"] = "{npc:3326}, {object:172960}",

	-- Step 32: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "Rumo a {zone:1411}",

	-- Step 33: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 34: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390} e {npc:8393} trabalham no Apothecarium.",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, ao lado dele",

	-- Step 35: Andron Gant
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["{npc:6522} stands in the {object:36073}."] = "{npc:6522} fica no {object:36073}.",

	-- Step 36: The Undercity
	-- {object:36126} Royal Quarter (no name in this language: may be words)
	["Lady Sylvanas holds the {object:36126}."] = "Lady Sylvanas fica no {object:36126}.",

	-- Step 39: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, por perto",

	-- Step 40: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} volta para {npc:10778} nas {zone:1422}: guarde-a.",

	-- Step 41: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "Só com {quest:79095}, da loja de alquimia de {area:159}, nas bolsas (o guia dos Livros da Biblioteca)",

	-- Step 43: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "Siga a cavalo para leste, saindo da {zone:1458}, pela estrada; {area:152} guarda o caminho para {zone:1422}.",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}: os cupins estão em {area:2627}, no próximo guia",

	-- Step 45: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "A fazenda de {npc:10778} é a primeira a leste de {area:152}. Os Carniçais Grasnantes da fazenda carregam a outra metade do pingente dela; {npc:11075} guarda o caldeirão no campo.\nCuidado: um ou dois mortos-vivos costumam lutar ao lado dele, e mais mestres da caldeira podem atacar depois que você usar o caldeirão.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "As duas doações de {item:14047} são entregues mais adiante na rota: comece a guardar {item:14047}.",
	-- ["Fly to the {area:380}"] = "Voe para {area:380}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "Voe para {zone:1454}; {npc:4485} está no {object:172958}.",
	-- ["In the {object:172958}."] = "No {object:172958}.",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "No {object:172961}. Tenha Lã, Seda e Magitrama na bolsa.",
	-- ["Open {object:149036} for the {item:10556}"] = "Abra {object:149036} para pegar o {item:10556}",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "O acampamento de Rimtori fica no extremo leste do acampamento-base. Leia o {object:151286} lá e depois mate a Maga.",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "O acampamento da Rimtori fica na ponta leste do acampamento-base. Leia o {object:151286} de lá e depois mate a Maga.\nCuidado: qual cristal está ligado à Rimtori é aleatório. Cada um dos outros dois invoca um infernal hostil.",
	-- ["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Pegue o zepelim na torre do lado de fora de {zone:1454} até {zone:1420} e entre a cavalo em {zone:1458}. Lady Sylvana ocupa o {object:36126}.",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "Os elfos sangrentos acampam nos penhascos a nordeste, junto à {area:1227}.\nCuidado: um {npc:250023}, elite de nível 55-57, fica na borda oeste do acampamento: enfrente os elfos sangrentos pelo lado leste dele.",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "A torre do zepelim fica logo a nordeste do portão principal de {zone:1454}; pegue o zepelim para {zone:1458}.",
	-- ["Zeppelin to the {zone:1458}"] = "Zepelim para {zone:1458}",
	-- ["Zeppelin tower"] = "Torre do zepelim",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}, no Apothecarium",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} fica na {area:380}. Abra cada caixa que ela lhe entregar e traga de volta o que houver dentro.",
	-- ["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "{npc:4485}, {object:172958}: trazida da primeira visita a {zone:1447}; senão, pegue-a aqui para {npc:8576} em {area:1237}",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050} volta para {npc:10778} em {area:28}: guarde-a.",
}
