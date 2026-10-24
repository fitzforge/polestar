// node sdiff.js <Faction> <Race> <stream.json> <written-guides>: JS-model hours of the order's goal stream vs the
// written guides' walk, and where the written quest-event order departs from the order's.
process.env.POLESTAR_CAS='off';process.env.POLESTAR_CAS_SKIP='walks';
const path=require('path');const JR=process.env.JUDGE_ROOT;const SIM=process.env.SIM;
const [faction,race,sf,gd]=process.argv.slice(2);const S=path.resolve(sf),G=path.resolve(gd);process.chdir(JR);
(async()=>{
const sim=require(JR+'/tools/lib/sim/index');const {compileSequence}=require(JR+'/tools/lib/sim/sequence');const {K_GRIND}=require(JR+'/tools/lib/sim/run');const {LEVEL_XP}=require(JR+'/tools/lib/game/xp');
const {world}=await sim.loadWorld({faction,simDir:SIM,offline:true,walks:false,log:()=>{}});const {mean}=sim.paramsFor(SIM,null);
const {run,ev}=sim.makeRun(world,{race,cls:null,params:mean,family:'solo'});
const play=(goals,tm)=>{ev.reset();let h30=null;for(const g of goals){let e=null;if(g.t==='level')e={t:'level',level:g.level,xp:null};else if(g.q==null)continue;else if(g.t==='accept'||g.t==='turnin')e={t:g.t,q:g.q};else e={t:'complete',q:g.q,obj:g.oi};const s=compileSequence(run,[e]);for(let k=0;k<s.kind.length;k++){if(s.kind[k]===K_GRIND)ev.grindTo(s.q[k],s.task[k]);else ev.step(s.kind[k],s.q[k],s.task[k],s.pt[k]);}const L=ev.level+(ev.level<60?ev.xp/LEVEL_XP[ev.level]:0);if(h30==null&&L>=30)h30=ev.time/3600;if(tm&&(g.t==='accept'||g.t==='turnin')&&!tm.has(`${g.t} ${g.q}`))tm.set(`${g.t} ${g.q}`,ev.time);if(L>=60)break;}return {h30,h60:ev.time/3600,end:ev.level+(ev.level<60?ev.xp/LEVEL_XP[ev.level]:0)};};
const st=require(S).goals.map(g=>({...g,t:g.t==='collect'?'complete':g.t,oi:g.oi??null}));st.push({t:'level',level:60});
const {walkChain}=require(JR+'/tools/lib/judge/walk');const w=await walkChain({guides:G,faction,race,simDir:SIM,to:61});
const ta=new Map(),tb=new Map();const a=play(st,ta),b=play(w.goals,tb);
const fx=(v)=>v==null?"-":v.toFixed(2);console.log(`order stream: ${fx(a.h30)} / ${a.h60.toFixed(2)} h (end level ${a.end.toFixed(2)}); written: ${fx(b.h30)} / ${b.h60.toFixed(2)} h (end level ${b.end.toFixed(2)})`);
const ev2=(gs)=>{const seen=new Set(),out=[];for(const g of gs){if(g.q==null||g.t==='level'||g.t==='note')continue;const k=(g.t==='accept'||g.t==='turnin')?`${g.t} ${g.q}`:`work ${g.q}`;if(seen.has(k))continue;seen.add(k);out.push(k);}return out;};
const A=ev2(st),B=ev2(w.goals);const ia=new Map(A.map((x,i)=>[x,i]));
const inBoth=B.filter(x=>ia.has(x));const onlyA=A.filter(x=>!B.includes(x)),onlyB=B.filter(x=>!ia.has(x));
// LIS of positions
const seq=inBoth.map(x=>ia.get(x));const tails=[],prev=new Array(seq.length),idx=[];
for(let i=0;i<seq.length;i++){let lo=0,hi=tails.length;while(lo<hi){const m=(lo+hi)>>1;if(seq[tails[m]]<seq[i])lo=m+1;else hi=m;}prev[i]=lo?tails[lo-1]:-1;tails[lo]=i;}
const keep=new Set();for(let i=tails[tails.length-1];i>=0;i=prev[i])keep.add(i);
const out=inBoth.filter((x,i)=>!keep.has(i));
if(process.env.JSON_OUT)require("fs").writeFileSync(process.env.JSON_OUT,JSON.stringify({order:a,written:b,orderEvents:A.length,writtenEvents:B.length,inBoth:inBoth.length,outOfOrder:out.length,onlyInOrder:onlyA.length,onlyWritten:onlyB.length}));
console.log(`events: order ${A.length}, written ${B.length}, in both ${inBoth.length}, out of order ${out.length}; only in order ${onlyA.length}, only written ${onlyB.length}`);
const Q=require(JR+'/data/forever/quests.json');const nm=(x)=>{const q=x.split(' ')[1];return `${x} ${(Q[q]||{}).title}`;};
console.log('only in order:',onlyA.slice(0,15).map(nm).join('; '));console.log('only written:',onlyB.slice(0,15).map(nm).join('; '));
const bi=new Map(B.map((x,i)=>[x,i]));
console.log('out of order (order idx -> written idx):');for(const x of out.slice(0,int(process.env.N||30)))console.log(`  ${ia.get(x)} -> ${bi.get(x)} ${nm(x)}`);
function int(v){return Number(v);}
// where the written walk loses time: the gap's growth between consecutive common events
let last=0,lastE=null;const jumps=[];for(const x of A){if(!tb.has(x)||!ta.has(x))continue;const gap=tb.get(x)-ta.get(x);jumps.push({x,from:lastE,d:gap-last});last=gap;lastE=x;}
console.log(`gap at the last common event ${lastE}: ${(last/3600).toFixed(2)} h`);jumps.sort((p,q)=>q.d-p.d);console.log('biggest losses (min):');for(const j of jumps.slice(0,int(process.env.J||20)))console.log(`  +${(j.d/60).toFixed(1)} before ${nm(j.x)} (after ${j.from?nm(j.from):'-'})`);
})();
