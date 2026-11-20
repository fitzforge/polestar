'use strict';
const {test}=require('node:test');
const assert=require('node:assert/strict');
const {runAddon}=require('./helpers/lua');
const {needs}=require('./helpers/data');
const skip=needs('quests.json');

// One normal camp visit per pair. A player arriving with only one reward must never wait for its partner.
const books=[['01-stranglethorn-vale',[598,95770]],['02-feralas',[589,573]]];
const targets={598:[25],95770:[1],589:[3],573:[10,1]};
const bags={598:[3916,25],589:[3911,3],573:[737,1]};
for(const [book,ids] of books) for(const [scenario,state,order] of [
	['both ready',['ready','ready'],[0,1]],['opposite payment order',['ready','ready'],[1,0]],
	['first ready, second incomplete',['ready','partial'],[0]],['second ready, first incomplete',['partial','ready'],[1]],
	['first absent',['absent','ready'],[1]],['second already paid',['ready','paid'],[0]],
	['partial, absent',['partial','absent'],[]],['both paid',['paid','paid'],[]],['fresh with neither',['absent','absent'],[]],
]) test(`${book}: Grom'gol pays independently (${scenario})`,{skip},()=>{
	const before=["local w=stub.world;w.race='Orc';w.class='WARRIOR';w.faction='Horde';w.level=38; w.setXP(999,1000);"];
	for(let i=0;i<2;i++){const q=ids[i],st=state[i];if(st==='paid')before.push(`w.complete({${q}})`);if(st!=='ready'&&st!=='partial')continue;before.push(`w.onQuest(${q},{${targets[q]}})`);if(st==='ready'){if(bags[q])before.push(`w.addItem(${bags[q]})`);before.push(`w.finish(${q})`);}else if(targets[q][0]>1)before.push(`w.progress(${q},1,1)`);}
	const setup=`
		local E,C,w=Polestar.Engine,Polestar.Compat,stub.world
		local function tick() stub.advance(.6); stub.advance(.6) end
		stub.login(); tick(); assert(E.SetGuide('forever/horde/40-50/${book}'))
		stub.fire('QUEST_LOG_UPDATE'); tick()
		local a,b=${ids}
		-- The personalizer removes absent quest rows. Start at the earliest retained payout,
		-- or at the ordinary camp exit if it kept neither. Never seek a different camp.
		local start,exit
		for i,s in ipairs(E.GetGuide().steps) do
			if not s.feeder then
				for _,g in ipairs(s.goals) do
					if g.t=='turnin' and (g.quest==a or g.quest==b) then start=start or i end
					if (g.t=='accept' and g.quest==95141) or
					   (g.t=='goto' and g.map==1434 and g.x and math.abs(g.x-31.4)<.2 and math.abs(g.y-29.9)<.2) then exit=i end
				end
			end
		end
		assert(start or exit,'no Grom\\'gol visit'); E.SkipUpTo(start or exit); tick()
		local function offers()
			local out={}; local i=E.GetStepIndex(); local s=E.GetGuide().steps[i]
			if s then for j,h in ipairs(s.goals) do
				if h.t=='turnin' and (h.quest==a or h.quest==b) and E.Applies(i,j) and not C.IsQuestCompleted(h.quest) then
					assert(C.IsQuestReadyForTurnIn(h.quest),'sent for unready reward '..h.quest); out[h.quest]=true
				end
			end end
			return out
		end
		${order.length===2?'assert(offers()[a] and offers()[b],"both rewards on one live camp step")':''}`;
	const script=[setup];for(const i of order){const q=ids[i];script.push(`assert(offers()[${q}],'missing active reward ${q}');w.turnIn(${q});${bags[q]?`w.removeItem(${bags[q]});`:''}tick();assert(C.IsQuestCompleted(${q}));`);}
	script.push(`assert(not next(offers()),'camp held after available rewards');emit({a=not not C.IsQuestCompleted(a),b=not not C.IsQuestCompleted(b),heldA=not not C.IsOnQuest(a),heldB=not not C.IsOnQuest(b)})`);
	const x=runAddon({stubs:['stub_world.lua'],addons:[{name:'Polestar',files:['Core/Core.xml']},'Polestar_Guides','Polestar_Guides_Horde'],saved:{Polestar:'PolestarDB={schema=1,settings={behavior={autoSelectGuide=false}}}'},before:before.join('\n'),script:script.join('\n')}).emitted[0];
	assert.deepEqual([x.a,x.b],state.map(s=>s==='paid'||s==='ready'));assert.deepEqual([x.heldA,x.heldB],state.map(s=>s==='partial'));
});
