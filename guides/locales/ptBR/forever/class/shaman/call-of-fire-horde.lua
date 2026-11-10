-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-fire-horde (forever/class/shaman/call-of-fire-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1522} Call of Fire
	["{quest:1522} (Horde)"] = "{quest:1522} (Horda)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Seu {item:5176} para todo totem de fogo, {spell:3599} junto com ele, e {item:263412} do Forever.",

	-- Step 1: Swart
	-- {npc:3173} Swart · {area:362} Razor Hill · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5892} Searn Firewarder · {zone:1454} Orgrimmar
	["At 10 {npc:3173}, the shaman trainer on the east side of {area:362}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5892}'s letter from {zone:1454}? It goes to {npc:5907} too: skip {npc:3173}."] = "No nível 10, {npc:3173}, o instrutor de xamã no lado leste de {area:362}, manda você para {npc:5907}, em {zone:1413}. Já tem a carta de {npc:5892}, de {zone:1454}? Ela vai para {npc:5907} também: pule {npc:3173}.",

	-- Step 2: Narm Skychaser
	-- {npc:3066} Narm Skychaser · {area:222} Bloodhoof Village · {npc:5907} Kranal Fiss · {zone:1413} Barrens · {npc:5906} Xanis Flameweaver · {zone:1456} Thunder Bluff
	["At 10 {npc:3066}, the shaman trainer in {area:222}, sends you to {npc:5907} in the {zone:1413}. Already carry {npc:5906}'s letter from {zone:1456}? It goes to {npc:5907} too: skip Narm."] = "No nível 10, {npc:3066}, o instrutor de xamã em {area:222}, manda você para {npc:5907}, em {zone:1413}. Já tem a carta de {npc:5906}, de {zone:1456}? Ela vai para {npc:5907} também: pule Narm.",

	-- Step 3: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {zone:1411} Durotar · {area:1704} Grol'dom Farm · {area:379} Far Watch Post · {zone:1440} Ashenvale
	["{npc:5907} is not in the Crossroads: take the road north from the Crossroads and fork east towards {zone:1411}; past {area:1704} he paces by a tall tower east of the road (from {zone:1411}: over the Southfury bridge, past {area:379}). If you reach {zone:1440} you went too far."] = "{npc:5907} não fica na Encruzilhada: siga a estrada para o norte a partir da Encruzilhada e pegue o desvio para leste rumo a {zone:1411}; depois de {area:1704}, ele anda ao lado de uma torre alta a leste da estrada (de {zone:1411}: pela ponte do Rio Furiaustral, depois de {area:379}). Se chegar a {zone:1440}, você foi longe demais.",

	-- Step 4
	-- {npc:5907} Kranal Fiss · {npc:3173} Swart
	["{npc:5907}: {npc:3173}'s letter"] = "{npc:5907}: a carta de {npc:3173}",

	-- Step 5
	-- {npc:5907} Kranal Fiss · {npc:5892} Searn Firewarder
	["{npc:5907}: {npc:5892}'s letter"] = "{npc:5907}: a carta de {npc:5892}",

	-- Step 6
	-- {npc:5907} Kranal Fiss · {npc:3066} Narm Skychaser
	["{npc:5907}: {npc:3066}'s letter"] = "{npc:5907}: a carta de {npc:3066}",

	-- Step 7
	-- {npc:5907} Kranal Fiss · {npc:5906} Xanis Flameweaver
	["{npc:5907}: {npc:5906}'s letter"] = "{npc:5907}: a carta de {npc:5906}",

	-- Step 8: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:6653} Torch of the Dormant Flame
	["{npc:5907} hands you the {item:6653}: keep it until the end of the chain."] = "{npc:5907} entrega {item:6653} a você: guarde até o fim da cadeia.",

	-- Step 9: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back east over the bridge, then south along the {zone:1411} bank of the river to where the mountains meet the water. The trail up starts at the foot of the mountain beside a small dark stone carved with symbols, near the quilboar camp; it is narrow, and a slip costs fall damage. {npc:5900} keeps the shrine at the top."] = "De volta a leste pela ponte, depois para o sul, pela margem de {zone:1411} do rio, até onde as montanhas encontram a água. A trilha que sobe começa ao pé da montanha, ao lado de uma pequena pedra escura entalhada com símbolos, perto do acampamento dos quilboar; é estreita, e um escorregão causa dano de queda. {npc:5900} cuida do santuário no topo.",

	-- Step 10: Fire Tar
	-- {item:5026} Fire Tar
	-- plural, as words: Fireballs = {spell:133} Fireball
	["The Razormane casters north-east of the Crossroads drop the {item:5026} three times in four: Water Seekers and Thornweavers (level 10-11), Geomancers (level 12-13, they throw Fireballs and run for help when hurt) and Mystics (level 13-14, they heal themselves at low health). Pull them one at a time."] = "Os conjuradores Crinavalha a nordeste da Encruzilhada soltam {item:5026} três vezes em quatro: Rabdomantes e Tecespinhos (nível 10-11), Geomantes (nível 12-13, jogam Bolas de Fogo e correm atrás de ajuda quando feridos) e Místicos (nível 13-14, se curam com pouca vida). Puxe um de cada vez.",

	-- Step 11: Reagent Pouch
	-- {spell:348} Immolate · {area:371} Dustwind Cave · {area:362} Razor Hill · {area:817} Skull Rock · {zone:1454} Orgrimmar
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["The Burning Blade Cultists (level 10-11, they call imps and cast {spell:348}) live deep in {area:371} north of {area:362}: climb the ramp just north-east of town and stay on the high ground above the ravines. The orcs at the cave mouth are not cultists; the cultists are further in, off to the left. Three kills in four drop a pouch. {area:817} by {zone:1454} is the wrong cave."] = "Os Sectários da Lâmina Ardente (nível 10-11, chamam diabretes e lançam {spell:348}) vivem no fundo de {area:371}, ao norte de {area:362}: suba a rampa logo a nordeste da cidade e fique nas partes altas acima das ravinas. Os orcs na boca da caverna não são sectários; os sectários estão mais para dentro, à esquerda. Três mortes em quatro soltam uma bolsinha. {area:817}, perto de {zone:1454}, é a caverna errada.",

	-- Step 12: Telf Joolam
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["Back up the trail to {npc:5900}. He makes the {quest:1464} from the tar and the pouch and hands it to you with the torch: keep both."] = "De volta pela trilha até {npc:5900}. Ele faz {quest:1464} com o piche e a bolsinha e entrega a você junto com a tocha: guarde os dois.",

	-- Step 13: Lost the Fire Sapta?
	-- {quest:1464} Fire Sapta
	["Lost the {quest:1464}?"] = "Perdeu {quest:1464}?",
	-- {quest:1464} Fire Sapta · {npc:5900} Telf Joolam
	["Only if the {quest:1464} is gone from your bags: {npc:5900} gives you another."] = "Só se {quest:1464} sumiu das suas bolsas: {npc:5900} entrega outra.",
	-- {npc:5900} Telf Joolam · {quest:1464} Fire Sapta
	["{npc:5900}: a new {quest:1464}"] = "{npc:5900}: uma nova {quest:1464}",

	-- Step 14: The Minor Manifestation of Fire
	-- {npc:5893} Minor Manifestation of Fire
	["The {npc:5893}"] = "{npc:5893}",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words) · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Drink the {item:6636} beside the {object:63674}, the big grey stone just below the summit, then climb to the plateau. Of the fire elementals there only the one in the middle can be attacked: it is level 12, immune to fire and grows stronger the longer the fight lasts, so open at once with {spell:8017} and {spell:8042} and leave the others alone. Its {item:6655} drops every time."] = "Beba {item:6636} ao lado do {object:63674}, a grande pedra cinza logo abaixo do cume, depois suba até o platô. Dos elementais de fogo ali, só o do meio pode ser atacado: ele é de nível 12, imune a fogo e fica mais forte quanto mais a luta dura, então abra na hora com {spell:8017} e {spell:8042} e deixe os outros em paz. Dele sempre cai {item:6655}.",
	-- {item:6636} Fire Sapta · {object:63674} Shaman Shrine (no name in this language: may be words)
	["{item:6636}, beside the {object:63674}"] = "{item:6636}, ao lado do {object:63674}",

	-- Step 15: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} on the plateau with the torch in your bags to place the ember, then click it a second time: the next quest does not open by itself. It gives you the lit {item:277329}."] = "Clique em {object:61934}, no platô, com a tocha nas suas bolsas, para colocar a brasa, e depois clique uma segunda vez: a próxima missão não abre sozinha. Ela entrega {item:277329} acesa a você.",

	-- Step 16: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {item:5176} Fire Totem
	["Down the trail, back over the bridge to {npc:5907} by his tower. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Desça a trilha, volte pela ponte até {npc:5907}, ao lado da torre dele. Guarde {item:5176} nas suas bolsas para sempre: todo totem de fogo precisa dele.",
	-- {npc:5907} Kranal Fiss · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {spell:3599}, seu {item:5176} e {item:263412}",

	-- Step 17: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {npc:251968} Ayessa Dawnsinger · {area:16638} Valanaar · {item:6653} Torch of the Dormant Flame · {npc:254082} Aarnor Galestrike · {quest:97243} Call of Fire · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {spell:8050} Flame Shock · {npc:268605} Kuramaa
	["At 10 {npc:252382}, the shaman trainer beside {npc:251968} in {area:16638}, hands you the {item:6653} ({npc:254082} offers the same quest). Already left the isle? A {quest:97243} sends you back to them: take the skycutter from the cliffs south of {area:17045}, north of {zone:1456}. Learn {spell:8050} from her now: {npc:268605}, later in the chain, only takes fire damage."] = "No nível 10, {npc:252382}, o instrutor de xamã ao lado de {npc:251968}, em {area:16638}, entrega {item:6653} a você ({npc:254082} oferece a mesma missão). Já saiu da ilha? {quest:97243} manda você de volta a eles: pegue o barco celeste nos penhascos ao sul de {area:17045}, ao norte de {zone:1456}. Aprenda {spell:8050} com ela agora: {npc:268605}, mais adiante na cadeia, só sofre dano de fogo.",

	-- Step 18: Olariaan Swiftburn
	-- {area:16638} Valanaar · {area:16663} Windfield Orchard · {npc:268592} Olariaan Swiftburn
	["The Shrine of Flames hides on the island's outer rim south-west of {area:16638}, just south-east of {area:16663}: {npc:268592} keeps it."] = "O Santuário das Chamas fica escondido na borda externa da ilha, a sudoeste de {area:16638}, logo a sudeste de {area:16663}: {npc:268592} cuida dele.",

	-- Step 19: Skypriest Faladiel
	-- {npc:268602} Skypriest Faladiel · {area:16638} Valanaar · {area:16629} Shrine of Akir · {area:17675} East Pylon Watchtower
	["{npc:268602} (level 10, a turncoat Windshaper with a single spawn) holds the farm north-east past {area:16638}, just south of the {area:16629}, on the hill west of the falls north of the {area:17675}. Kill him and take his heart."] = "{npc:268602} (nível 10, um Moldavento traidor com um único ponto de aparição) ocupa a fazenda a nordeste, depois de {area:16638}, logo ao sul de {area:16629}, no morro a oeste da cachoeira ao norte de {area:17675}. Mate-o e pegue o coração dele.",

	-- Step 20: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn
	["Back to {npc:268592} at the Shrine of Flames."] = "De volta a {npc:268592}, no Shrine of Flames.",

	-- Step 21: Kuramaa
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words) · {area:16638} Valanaar · {npc:268605} Kuramaa · {spell:8050} Flame Shock
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["{object:660848} is the twisted stump on the hilltop by the Shen'dar Highlands Anchor Pylon, west of {area:16638}, in the hills south of the Windsong Crawlers' lakes. Knock on it to call {npc:268605} (level 10). The spirit shrugs off most magic: only fire hurts it, so keep {spell:8050} on it. Take its wooden mask."] = "{object:660848} é o toco retorcido no topo da colina junto ao Shen'dar Highlands Anchor Pylon, a oeste de {area:16638}, nas colinas ao sul dos lagos dos Rastejantes Cantéolos. Bata nele para chamar {npc:268605} (nível 10). O espírito ignora a maior parte da magia: só o fogo o machuca, então mantenha {spell:8050} nele. Pegue a máscara de madeira dele.",
	-- {object:660848} Kuramaa's Stump (no name in this language: may be words)
	["{object:660848}: knock on the bark"] = "{object:660848}: bata na casca",

	-- Step 22: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {object:148418} Eternal Flame · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Accept the last quest, then wait by the {npc:268762} while he performs the ritual; when the fire spirits light the {object:148418}, hold the torch to it. From then you have six minutes: carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638}, with no detours or fights. Timer out? Abandon the quest and take it again from {npc:268592}."] = "De volta a {npc:268592}. Aceite a última missão e espere ao lado de {npc:268762} enquanto ele faz o ritual; quando os espíritos do fogo acenderem {object:148418}, encoste a tocha nele. A partir daí, você tem seis minutos: leve a chama direto até {npc:268679}, ao lado de {npc:252382}, em {area:16638}, sem desvios nem lutas. O tempo acabou? Abandone a missão e pegue de novo com {npc:268592}.",
	-- {npc:268679} Brazier of Eternal Flame · {area:16638} Valanaar
	["the ritual, then the {npc:268679} in {area:16638}"] = "o ritual, e depois {npc:268679}, em {area:16638}",

	-- Step 23: Sessaria Skystride
	-- {item:5176} Fire Totem
	["Keep the {item:5176} in your bags for good: every fire totem needs it."] = "Guarde {item:5176} nas suas bolsas para sempre: todo totem de fogo precisa dele.",
	-- {npc:252382} Sessaria Skystride · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {spell:3599}, seu {item:5176} e {item:263412}",
}
