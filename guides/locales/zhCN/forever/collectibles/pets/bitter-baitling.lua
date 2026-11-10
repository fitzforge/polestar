-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay · {quest:8193} Master Angler · {npc:15077} Riggle Bassbait · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks when it starts and take {quest:8193} from {npc:15077}. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "{item:276275}需要一个{item:274026}兑换，后者是赢得荆棘谷钓鱼大赛的奖励。比赛时间为服务器时间每周日下午2点到4点：开始时到{area:35}码头，向{npc:15077}接受{quest:8193}。尽量提高{skill:356}技能并带上鱼饵，避免鱼逃脱；带上坐骑、腾空背包，并将炉石绑定在{area:35}。",
	-- {npc:15077} Riggle Bassbait
	["{npc:15077}, during the contest"] = "{npc:15077}，比赛期间",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "可口鱼群",
	-- {item:19807} Speckled Tastyfish · {area:35} Booty Bay
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {area:35}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {area:35}; more schools lie further north and just south of {area:35}."] = "比赛期间，荆棘谷海岸沿线会出现{item:19807}鱼群，{area:35}里面没有。从鱼群钓取40条{item:19807}；每个鱼群只能钓几竿，消失后立即骑马寻找下一个。箭头会带你沿{area:35}北面的西海岸向北走；更北面以及{area:35}正南面还有更多鱼群。",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "返回{npc:15077}处",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "尽快返回，将 40 条可口鱼交给 {npc:15077}：最先完成的玩家获胜，获胜者会随奖品一起得到硬币。如果来不及获胜，{npc:15078} 仍会按每 5 条可口鱼支付少量金币。",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "胜者的硬币，来自 {npc:15077}",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {area:35} Booty Bay · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {area:35} docks and trades the {item:276275} for the coin."] = "{npc:15077} 的学徒 {npc:15078} 站在他旁边的 {area:35} 码头上，可以用硬币兑换 {item:276275}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "{item:276275}是钓鱼奖励：{npc:15078}用它交换一枚{item:274026}，那是{npc:15078}在{area:35}举办的钓鱼大赛的奖励。硬币的确切来源尚未公布。",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078}站在{area:35}的码头上。",
}
