-- Korean (koKR): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608} 및 저주의 지팡이",
	-- {npc:14494} Eris Havenfire
	["The epic priest staff: the Eye of Divinity from Molten Core, {npc:14494}'s peasant rescue, then the Eye of Shadow."] = "",

	-- Step 1: The Eye of Divinity
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {item:18412} Core Fragment · {npc:14387} Lothos Riftwaker · {npc:14494} Eris Havenfire
	["{item:18646} comes from the {object:179703}, the chest that appears when {npc:12018} yields in Molten Core, a 40-player raid (it is in the cache about half the time). Molten Core's portal is at the bottom of Blackrock Depths; once you have done Attunement to the Core (a {item:18412} from beside that portal), {npc:14387} inside Blackrock Mountain ports you straight in. Nothing in this chain starts without the Eye: {npc:14494} is invisible until you equip it."] = "",
	-- {npc:14387} Lothos Riftwaker
	["{npc:14387}: the way into Molten Core once attuned"] = "",
	-- {item:18646} The Eye of Divinity
	["{item:18646}: Molten Core, through Blackrock Mountain"] = "",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {quest:7621} A Warning · {quest:7622} The Balance of Light and Shadow · {item:13931} Nightfin Soup · {item:8956} Oil of Immolation · {item:13180} Stratholme Holy Water
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion · Dark Runes = {item:20520} Dark Rune
	["Equip {item:18646}, then find {npc:14494}, a ghost on the hillside in the north-west of the {zone:1423}, west of Stratholme's gate (if she does not show, take the Eye off and put it back on). {quest:7621} is only talk; {quest:7622} starts the moment you accept it, so prepare first: full mana, Major Mana Potions, Demonic or Dark Runes, mana food or {item:13931}, and a stack of {item:8956} or {item:13180} for the skeletons."] = "",

	-- Step 3: The Balance of Light and Shadow
	-- {object:179694} Death Post (no name in this language: may be words) · {npc:14494} Eris Havenfire
	["Save 50 peasants before 15 die (the {object:179694} by the path counts the dead). They walk from the cave towards {npc:14494} in waves, catch diseases and draw skeletons and skeleton archers. Cure the purple-glowing diseases first (Abolish Disease), keep Renew on the hurt ones, Flash Heal the nearly dead, and kill skeletons as they spawn: one Holy Nova of rank 3 or more kills them, oil takes two ticks while they hit you. Shield yourself at the start of each wave; friendly nameplates make the hurt peasants easy to pick out. Friends may buff you before you accept and may heal or cure peasants, but they must not heal or buff you, attack a skeleton or bring a pet once it starts, or a demon appears and kills everyone. Fail, and {npc:14494} is gone for a while (players report anything from 15 minutes to two hours); talk to her again when she is back."] = "",

	-- Step 5: The Eye of Shadow
	-- {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak · {zone:1419} Blasted Lands
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["The splinter needs {item:18665} as well. {npc:12397}, a world boss in the {zone:1419} (a raid), always drops it; Manahounds and Doomguard Commanders there drop it rarely (about 3% and 2%), the Hederine of Winterspring hardly ever. It can be traded: check the Auction House first."] = "",

	-- Step 6: Benediction
	-- {item:18659} Splinter of Nordrassil · {item:18646} The Eye of Divinity · {item:18665} The Eye of Shadow · {item:18608} Benediction
	["With the {item:18659}, {item:18646} and {item:18665} in your bags, use the splinter wherever you are: it becomes {item:18608}. Use {item:18608} to turn it into Anathema, the shadow staff, and back (a 30-minute cooldown)."] = "",
	-- {item:18659} Splinter of Nordrassil · {item:18608} Benediction
	["Use the {item:18659} with both Eyes in your bags: {item:18608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "{item:18646}을(를) 착용하면 {zone:1423} 북서쪽 산비탈의 유령 {npc:14494}이(가) 보입니다. 마나를 가득 채우고 일급 마나 물약과 {item:8956}을(를) 챙겨 오십시오. 실패하면 이벤트가 다시 열리기까지 약 두 시간이 걸립니다.",
	-- ["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "농민 15명이 죽기 전에 50명을 구하세요. 농민을 공격하는 해골을 처치하고, 질병을 치료하고(보라색부터), 부상자는 {spell:139}(으)로 치유하세요. 친구가 미리 강화 효과를 걸어 줄 수는 있지만 전투에는 끼면 안 됩니다. 그렇지 않으면 악마가 나타나 모두를 죽입니다.",
	-- ["With both Eyes in your bags: {item:18608}"] = "두 눈을 가방에 넣고: {item:18608}",
	-- ["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "먼저 {item:18646}이(가) 필요합니다. {area:2717}에서 {npc:12018} 처치 후 나오는 {object:179703}에서 얻습니다. {item:18665}은(는) 정예 악마에게서 떨어집니다(필드 우두머리 {npc:12397}은(는) 항상, 파멸의수호대 사령관과 마나사냥개는 드물게). 착용 시 귀속이므로 구매해도 됩니다.",
	-- ["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "{npc:14494}의 조각과 두 개의 눈으로 {item:18608}을(를) 만듭니다. 저주의 지팡이로 변하는 사제 영웅 지팡이입니다.",
}
