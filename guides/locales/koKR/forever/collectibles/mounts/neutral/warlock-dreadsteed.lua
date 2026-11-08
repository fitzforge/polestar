-- Korean (koKR): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "흑마법사 공포마",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {zone:1428} Burning Steppes · {npc:14522} Ur'dan
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the Altar of Storms, in the far north-west of the {zone:1428}, west of Blackrock Mountain. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the Scholomance and Dire Maul. Start buying or gathering the materials of the next steps now."] = "",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. Owl Wing Thicket, in the north-east, and the Hidden Grove's surroundings are packed with them, and they respawn in five and a half minutes."] = "",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in Jaedenar: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "그가 {item:18591}을(를) 줍니다",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, {npc:14437}에게서",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "의식 재료",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and Blackrock Depths) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "",

	-- Step 10: Lord Banehollow
	-- {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow
	["Jaedenar lies just south of Bloodvenom Post in western {zone:1448}, west of the road; of its two caves, Shadow Hold is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own (Taint of Shadow). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "",
	["Shadow Hold"] = "",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your Taint of Shadow aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, {npc:14522}에게서",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the Scholomance. Put a group of five together now: a party, not a raid group."] = "",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "",

	-- Step 14: The Scholomance
	["The Scholomance"] = "",
	-- {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The Scholomance (level 58-60, a group of five) lies under Caer Darrow, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "",
	-- {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["Dire Maul stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "",

	-- Step 17: The ritual
	["The ritual"] = "",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {object:2164}의 {npc:5520}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",
	-- ["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {object:36082}의 {npc:5753}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",
	-- ["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {object:172960}의 {npc:5815}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",
	-- ["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {zone:1455}의 {npc:6382}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "{npc:14436}에게 돌아간 뒤, 그의 {item:18591}을(를) 옆의 {npc:14437}에게 건네세요. 그 후 {npc:14436}은(는) 의식 재료 세 가지를 요구하고 {npc:14437}는 당신을 {zone:1448}(으)로 보냅니다. 그 여정을 위해 {npc:14437}에게서 어둠의 물약 두 개를 사세요.",
	-- ["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "별가루를 들고 {npc:14437}에게 돌아가세요. 그가 {area:2057}에서 쓸 {item:18688}을(를) 줍니다.",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "{npc:14437}에게 돌아간 뒤, {npc:14436}이(가) 의식 지침을 줍니다. {npc:14437}에게서 {item:18663}, {item:18629}, {item:18670}을(를) 사고, 영혼의 조각을 10개 이상 챙기세요.",
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "고르지키는 {spell:5896}의 비약 10개({skill:171}), {item:14344} 6개({skill:333}), {item:11370} 25개({skill:186}, {area:1584}와(과) {zone:1427}), {item:15416} 35개({skill:393}, {zone:1428}의 검은용족)를 원합니다. 전문 기술로 만들거나 모을 수 있는 것은 직접 하고, 나머지는 경매장에서 사세요.",
	-- ["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "세 조각을 {npc:14437}에게 건네세요. 그다음 {item:12360} 3개를 원합니다. 연금술사는 변환으로 만들고, 그 외에는 경매장에서 사세요.",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "{zone:1452}의 올빼미야수는 세 마리 중 한 마리꼴로 피를 떨어뜨립니다: {area:2255} 서쪽과 주변의 털복숭이 올빼미야수와 {npc:7451}, 동쪽의 광기어린 올빼미야수, 달빛 깃든 올빼미야수, {spell:417141} 올빼미야수. 사냥하는 동안 다음 단계의 재료도 준비하세요. 경매장에 모두 있습니다.",
	-- ["The ritual in {area:2577}"] = "{area:2577}에서의 의식",
	-- ["The {area:2057}"] = "{area:2057}",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057}은(는) {zone:1422} 남동쪽의 섬 마을인 {area:2298} 아래에 있습니다. 문을 열려면 열쇠나 도적이 필요하고, 더 깊이 가려면 들창어금니의 {item:13873}이(가) 필요합니다. {npc:10508}의 방에 있는 연금술 실험대에서 {item:18688}을(를) 사용하세요. {npc:14500}이(가) 양피지를 만듭니다. 파티를 데려가세요.",
	-- ["Use the {item:18688} at the alchemy lab"] = "연금술 실험대에서 {item:18688}을(를) 사용하세요",
	-- ["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "60레벨의 영웅 탈것으로, 어디서든 소환할 수 있으며 영웅 말에 골드를 쓸 필요가 없습니다.",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763}은(는) {zone:1448} 서부에 있습니다. 들어가기 전에 {item:18802}을(를) 마시세요. 어둠의 의회 신도들이 한동안 우호적으로 변하지만 악마는 그렇지 않습니다. {quest:7623}은(는) {area:1763} 위의 동굴인 {area:1770} 깊숙한 곳, 거대한 뿌리 방의 다리 건너편에서 기다립니다.",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577}은(는) {zone:1444} 중부의 폐허에 있습니다. 의식의 원은 서쪽 구역의 {npc:11496} 너머에 있으며, 문을 열려면 {item:18249}이(가) 있거나 도적이 필요합니다. {item:18663}을(를) 사용해 시작하세요. 종, 바퀴, 양초가 희미해지면 {item:18629}(으)로 클릭하세요(각각 {item:6265} 1개). 악마가 더 이상 나오지 않으면 {item:18670}을(를) 사용하고, {npc:14502}와(과) 그 주인인 공포의군주를 물리친 뒤 {npc:14504}에게 말을 거세요. 파티를 데려가세요.",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437}은(는) 어둠의 힘 비약 10개({skill:171}), 큰 반짝이는 결정 6개({skill:333}), {item:11370} 25개({skill:186}, {area:1584}와(과) {zone:1427}), 검은용 비늘 35개({skill:393}, {zone:1428}의 검은용족)를 원합니다. 전문 기술로 만들거나 모을 수 있는 것은 직접 하고, 나머지는 경매장에서 사세요.",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504}: 당신에게 귀속됩니다",
	-- ["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{quest:7623} 옆의 {npc:14522}이(가) {item:18687}을(를) 팝니다. {item:18802} 효과가 있는 동안에만 거래합니다. 골드를 넉넉히 가져가세요.",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523}은(는) 돌아 올라가는 길의 다리 옆 곁방에서 기다립니다. 그에게 말을 걸면 그와 경비병 넷이 공격합니다. 아무도 정예가 아닙니다. 그의 심장을 {npc:9516}에게 가져가고, 첫 물약 효과가 끝났다면 하나 더 마시세요.",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562}와(과) 그의 고블린 {npc:14437}은(는) {zone:1428} 북서쪽, {area:254} 서쪽의 {area:255}에 진을 치고 있습니다. 연계 퀘스트는 길고, {npc:14437}에게 골드가 들며, 던전 두 곳에서 끝납니다.",
}
