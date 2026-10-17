-- Korean (koKR): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "흑마법사 공포마",
	["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "60레벨의 영웅 탈것으로, 어디서든 소환할 수 있으며 영웅 말에 골드를 쓸 필요가 없습니다.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {object:2164}의 {npc:5520}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {zone:1455}의 {npc:6382}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {object:172960}의 {npc:5815}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "60레벨에 {object:36082}의 {npc:5753}이(가) 당신을 {zone:1428}의 {quest:7562}에게 보냅니다.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain
	["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562}와(과) 그의 고블린 {npc:14437}은(는) {zone:1428} 북서쪽, {area:254} 서쪽의 {area:255}에 진을 치고 있습니다. 연계 퀘스트는 길고, {npc:14437}에게 골드가 들며, 던전 두 곳에서 끝납니다.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2255} Everlook · {spell:417141} Berserk
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "{zone:1452}의 올빼미야수는 세 마리 중 한 마리꼴로 피를 떨어뜨립니다: {area:2255} 서쪽과 주변의 털복숭이 올빼미야수와 {npc:7451}, 동쪽의 광기어린 올빼미야수, 달빛 깃든 올빼미야수, {spell:417141} 올빼미야수. 사냥하는 동안 다음 단계의 재료도 준비하세요. 경매장에 모두 있습니다.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {zone:1448} Felwood
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "{npc:14436}에게 돌아간 뒤, 그의 {item:18591}을(를) 옆의 {npc:14437}에게 건네세요. 그 후 {npc:14436}은(는) 의식 재료 세 가지를 요구하고 {npc:14437}는 당신을 {zone:1448}(으)로 보냅니다. 그 여정을 위해 {npc:14437}에게서 어둠의 물약 두 개를 사세요.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "그가 {item:18591}을(를) 줍니다",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, {npc:14437}에게서",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "의식 재료",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {area:1584} Blackrock Depths · {zone:1427} Searing Gorge · {skill:393} Skinning · {zone:1428} Burning Steppes
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437}은(는) 어둠의 힘 비약 10개({skill:171}), 큰 반짝이는 결정 6개({skill:333}), {item:11370} 25개({skill:186}, {area:1584}와(과) {zone:1427}), 검은용 비늘 35개({skill:393}, {zone:1428}의 검은용족)를 원합니다. 전문 기술로 만들거나 모을 수 있는 것은 직접 하고, 나머지는 경매장에서 사세요.",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "세 조각을 {npc:14437}에게 건네세요. 그다음 {item:12360} 3개를 원합니다. 연금술사는 변환으로 만들고, 그 외에는 경매장에서 사세요.",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {zone:1448} Felwood · {item:18802} Shadowy Potion · {quest:7623} Lord Banehollow · {area:1770} Shadow Hold
	["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763}은(는) {zone:1448} 서부에 있습니다. 들어가기 전에 {item:18802}을(를) 마시세요. 어둠의 의회 신도들이 한동안 우호적으로 변하지만 악마는 그렇지 않습니다. {quest:7623}은(는) {area:1763} 위의 동굴인 {area:1770} 깊숙한 곳, 거대한 뿌리 방의 다리 건너편에서 기다립니다.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523}은(는) 돌아 올라가는 길의 다리 옆 곁방에서 기다립니다. 그에게 말을 걸면 그와 경비병 넷이 공격합니다. 아무도 정예가 아닙니다. 그의 심장을 {npc:9516}에게 가져가고, 첫 물약 효과가 끝났다면 하나 더 마시세요.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{quest:7623} 옆의 {npc:14522}이(가) {item:18687}을(를) 팝니다. {item:18802} 효과가 있는 동안에만 거래합니다. 골드를 넉넉히 가져가세요.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, {npc:14522}에게서",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "별가루를 들고 {npc:14437}에게 돌아가세요. 그가 {area:2057}에서 쓸 {item:18688}을(를) 줍니다.",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13873} Viewing Room Key · {item:18688} Imp in a Jar · {npc:10508} Ras Frostwhisper · {npc:14500} J'eevee
	["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057}은(는) {zone:1422} 남동쪽의 섬 마을인 {area:2298} 아래에 있습니다. 문을 열려면 열쇠나 도적이 필요하고, 더 깊이 가려면 들창어금니의 {item:13873}이(가) 필요합니다. {npc:10508}의 방에 있는 연금술 실험대에서 {item:18688}을(를) 사용하세요. {npc:14500}이(가) 양피지를 만듭니다. 파티를 데려가세요.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab"] = "연금술 실험대에서 {item:18688}을(를) 사용하세요",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "{npc:14437}에게 돌아간 뒤, {npc:14436}이(가) 의식 지침을 줍니다. {npc:14437}에게서 {item:18663}, {item:18629}, {item:18670}을(를) 사고, 영혼의 조각을 10개 이상 챙기세요.",

	-- Step 16: The ritual in Dire Maul
	-- {area:2577} Dire Maul
	["The ritual in {area:2577}"] = "{area:2577}에서의 의식",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {npc:11496} Immol'thar · {item:18249} Crescent Key · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14504} Dreadsteed Spirit
	["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577}은(는) {zone:1444} 중부의 폐허에 있습니다. 의식의 원은 서쪽 구역의 {npc:11496} 너머에 있으며, 문을 열려면 {item:18249}이(가) 있거나 도적이 필요합니다. {item:18663}을(를) 사용해 시작하세요. 종, 바퀴, 양초가 희미해지면 {item:18629}(으)로 클릭하세요(각각 {item:6265} 1개). 악마가 더 이상 나오지 않으면 {item:18670}을(를) 사용하고, {npc:14502}와(과) 그 주인인 공포의군주를 물리친 뒤 {npc:14504}에게 말을 거세요. 파티를 데려가세요.",
	-- {npc:14504} Dreadsteed Spirit
	["{npc:14504}: it binds itself to you"] = "{npc:14504}: 당신에게 귀속됩니다",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "고르지키는 {spell:5896}의 비약 10개({skill:171}), {item:14344} 6개({skill:333}), {item:11370} 25개({skill:186}, {area:1584}와(과) {zone:1427}), {item:15416} 35개({skill:393}, {zone:1428}의 검은용족)를 원합니다. 전문 기술로 만들거나 모을 수 있는 것은 직접 하고, 나머지는 경매장에서 사세요.",
}
