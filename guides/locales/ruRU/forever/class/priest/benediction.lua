-- Russian (ruRU): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608} и Анафема",
	-- {spell:23101} Eye of Divinity · {area:2717} Molten Core · {npc:14494} Eris Havenfire
	["The epic priest staff: the {spell:23101} from {area:2717}, {npc:14494}'s peasant rescue, then the Eye of Shadow."] = "Эпический посох жреца: «{spell:23101}» из {area:2717}, спасение крестьян с NPC {npc:14494}, затем Око Тени.",

	-- Step 1: The Eye of Divinity
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {area:1584} Blackrock Depths · {item:18412} Core Fragment · {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {npc:14494} Eris Havenfire
	["{item:18646} comes from the {object:179703}, the chest that appears when {npc:12018} yields in {area:2717}, a 40-player raid (it is in the cache about half the time). {area:2717}'s portal is at the bottom of {area:1584}; once you have done Attunement to the Core (a {item:18412} from beside that portal), {npc:14387} inside {area:254} ports you straight in. Nothing in this chain starts without the Eye: {npc:14494} is invisible until you equip it."] = "",
	-- {npc:14387} Lothos Riftwaker · {area:2717} Molten Core
	["{npc:14387}: the way into {area:2717} once attuned"] = "",
	-- {item:18646} The Eye of Divinity · {area:2717} Molten Core · {area:254} Blackrock Mountain
	["{item:18646}: {area:2717}, through {area:254}"] = "",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {quest:7621} A Warning · {quest:7622} The Balance of Light and Shadow · {item:13931} Nightfin Soup · {item:8956} Oil of Immolation · {item:13180} Stratholme Holy Water
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion · Dark Runes = {item:20520} Dark Rune
	["Equip {item:18646}, then find {npc:14494}, a ghost on the hillside in the north-west of the {zone:1423}, west of {area:2279}'s gate (if she does not show, take the Eye off and put it back on). {quest:7621} is only talk; {quest:7622} starts the moment you accept it, so prepare first: full mana, Major Mana Potions, Demonic or Dark Runes, mana food or {item:13931}, and a stack of {item:8956} or {item:13180} for the skeletons."] = "",

	-- Step 3: The Balance of Light and Shadow
	-- {object:179694} Death Post (no name in this language: may be words) · {npc:14494} Eris Havenfire · {spell:552} Abolish Disease · {spell:139} Renew · {spell:2061} Flash Heal · {spell:15237} Holy Nova
	["Save 50 peasants before 15 die (the {object:179694} by the path counts the dead). They walk from the cave towards {npc:14494} in waves, catch diseases and draw skeletons and skeleton archers. Cure the purple-glowing diseases first ({spell:552}), keep {spell:139} on the hurt ones, {spell:2061} the nearly dead, and kill skeletons as they spawn: one {spell:15237} of rank 3 or more kills them, oil takes two ticks while they hit you. Shield yourself at the start of each wave; friendly nameplates make the hurt peasants easy to pick out. Friends may buff you before you accept and may heal or cure peasants, but they must not heal or buff you, attack a skeleton or bring a pet once it starts, or a demon appears and kills everyone. Fail, and {npc:14494} is gone for a while (players report anything from 15 minutes to two hours); talk to her again when she is back."] = "",

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
	-- ["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "Наденьте {item:18646}, чтобы увидеть NPC {npc:14494} — призрака на склоне горы на северо-западе зоны {zone:1423}. Приходите с полной маной, запасом хороших зелий маны и предметом {item:8956}: при провале событие возвращается примерно через два часа.",
	-- ["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "Спасите 50 крестьян, пока не погибли 15. Убивайте нападающих на них скелетов, лечите их болезни (сначала фиолетовые) и исцеляйте раненых заклинанием «{spell:139}». Друзья могут наложить на вас бафы заранее, но должны держаться вне боя, иначе появится демон и убьет всех.",
	-- ["With both Eyes in your bags: {item:18608}"] = "С обоими Оками в сумках: {item:18608}",
	-- ["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "Сначала нужен предмет {item:18646}: он лежит в объекте {object:179703} после победы над NPC {npc:12018} ({area:2717}). {item:18665} падает с элитных демонов ({npc:12397}, мировой босс — всегда; стражники ужаса-командиры и гончие маны — редко); он становится персональным при надевании, так что его можно и купить.",
	-- ["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "Осколок {npc:14494} и два Ока дают {item:18608}, эпический посох жреца, который превращается в Анафему.",
}
