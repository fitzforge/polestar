-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {object:3204} Booty Bay (no name in this language: may be words) · {quest:8193} Master Angler · {npc:15077} Riggle Bassbait · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {object:3204} docks when it starts and take {quest:8193} from {npc:15077}. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {object:3204}."] = "",
	-- {npc:15077} Riggle Bassbait
	["{npc:15077}, during the contest"] = "",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "",
	-- {item:19807} Speckled Tastyfish · {object:3204} Booty Bay (no name in this language: may be words)
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {object:3204}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {object:3204}; more schools lie further north and just south of {object:3204}."] = "",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {object:3204} Booty Bay (no name in this language: may be words) · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {object:3204} docks and trades the {item:276275} for the coin."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "{item:276275}是釣魚獎勵：{npc:15078}會用它交換一枚{item:274026}，那是{npc:15078}在{area:35}舉辦的釣魚比賽的獎勵。這枚硬幣的確切來源尚未公布。",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078}站在{area:35}的碼頭上。",
}
