"""Prepare paired poses from a trusted, complete native export (Python 3.10+).

  python tools/lib/nav/eval/floors/poses.py INPUT.jsonl --sha256 TRUSTED_SHA256 > paired.jsonl

Get the expected digest from the independent exporter's trusted receipt, not from
this command or a field in the input. It binds all original identities, sides,
levels, frames, endpoint coordinates, geometry, policy and denominators to one
export. A digest does not prove that the exporter observed the whole world.

Line 1: {"schema":1,"directions":{"outdoor":3640,"named":586,"geographic":898,
"terrain":1682,"named-independent":30}}. Small synthetic inputs must carry
"controls":true and use --controls. Each row is one direction, not one per side.
Rows: cohort, id (opaque direction key), map, profiles (list), level, from, to,
evidence. Each pose has frame and xyz. evidence.from and evidence.to each have
source ("native"), complete (boolean), window [xmin,ymin,xmax,ymax], triangles,
hazards, at (map, frame, xyz and level at extraction), and profiles (map of side
to policy fields). Supply all intersecting native triangles, not just allowed or
upward contacts. Triangle and hazard formats are
listed in endpoint_floor.py and below. Each policy field describes the ENTIRE
shoulder and original-to-floor swept pose in this map/frame at this level.
Missing evidence or uncertain policy retains the original height. Never use a
route's support list, a pathfinding mesh or a guessed permission. The output is
one row per direction and a final per-cohort count, not walking results.
"""
import argparse
import hashlib
import json
import math
import re
import sys
import tempfile
from collections import Counter
from pathlib import Path

from endpoint_floor import adjudicate, paired_points


COHORTS = {'outdoor':3640,'named':586,'geographic':898,'terrain':1682,'named-independent':30}
# These facts are not supplied by geometry alone. None, missing and False veto.
FACTS = ('frameKnown','phaseKnown','stationary','dry','noNativeHole','accessAllowed',
         'factionAllowed','levelAllowed','noKnownHazard','sweepAttested')


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def unique_keys(items):
    result = {}
    for key,value in items:
        need(key not in result,'duplicate JSON key')
        result[key] = value
    return result


def decoded(line):
    result = json.loads(line,object_pairs_hook=unique_keys)
    need(isinstance(result,dict),'object required')
    return result


def number(n):
    return type(n) in (int,float) and math.isfinite(n)


def vector(v, size):
    return isinstance(v,list) and len(v)==size and all(number(n) for n in v)


def decision(pose, evidence, context):
    point = pose['xyz']
    z = point[2]
    if pose['frame'] is None:
        return z,'unreadable original frame'
    if not isinstance(evidence,dict) or evidence.get('source')!='native' or evidence.get('complete') is not True:
        return z,'missing complete native evidence'
    if evidence.get('at')!={'map':context['map'],'level':context['level'],'frame':pose['frame'],'xyz':point}:
        return z,'evidence for another pose or character'
    window = evidence.get('window')
    faces = evidence.get('triangles')
    masks = evidence.get('hazards')
    if window is None or faces is None or masks is None:
        return z,'missing native window or exclusions'
    need(vector(window,4) and window[0]<window[2] and window[1]<window[3],'invalid native window')
    need(isinstance(faces,list) and all(vector(r,10) and r[9] in (0,1,2,3,4) for r in faces),'invalid native triangles')
    # A hazard is a CLOSED box: [xmin,ymin,zmin,xmax,ymax,zmax,label].
    need(isinstance(masks,list) and all(isinstance(b,list) and len(b)==7 and vector(b[:6],6) and
         all(b[i]<=b[i+3] for i in range(3)) and isinstance(b[6],str) for b in masks),'invalid hazard box')
    sides = evidence.get('profiles')
    def policy(low, high):
        for profile in context['profiles']:
            record = sides.get(profile) if isinstance(sides,dict) else None
            for fact in FACTS:
                if not isinstance(record,dict) or record.get(fact) is not True:
                    return 'unproven '+fact
            # Native exporter attests policy only across this vertical interval.
            span = record.get('clearZ')
            if not vector(span,2) or not span[0]<=low<=high+2<=span[1]:
                return 'unproven vertical policy extent'
        return None
    return adjudicate(point,faces,window,masks,policy)


def direction(row):
    common = {k:row[k] for k in ('cohort','id','map','profiles','level')}
    need(common['cohort'] in COHORTS and isinstance(common['id'],str) and common['id'],'invalid direction identity')
    need(type(common['map']) is int and type(common['level']) is int and common['level']>0,'invalid map or level')
    profiles = common['profiles']
    need(isinstance(profiles,list) and profiles and all(p in ('Alliance','Horde') for p in profiles) and
         len(profiles)==len(set(profiles)),'invalid profile set')
    evidence = row.get('evidence',{})
    need(isinstance(evidence,dict),'invalid endpoint evidence')
    original = {k:row[k] for k in ('id','map')}
    overlay = dict(original)
    reasons = {}
    for k in ('from','to'):
        p = row[k]
        need(isinstance(p,dict) and 'frame' in p and (p['frame'] is None or type(p['frame']) is int),'invalid original frame')
        xyz = p.get('xyz')
        need(isinstance(xyz,list) and len(xyz)==3 and vector(xyz[:2],2) and (xyz[2] is None or number(xyz[2])),'invalid original coordinates')
        original[k] = xyz
        h,why = decision(p,evidence.get(k),common)
        overlay[k] = dict(originalZ=xyz[2],z=h,reason=why)
        reasons[k] = why
    for arm in ('v1','v2'):
        common[arm] = {k:dict(frame=row[k]['frame'],xyz=point)
                       for k,point in zip(('from','to'),paired_points(original,overlay,arm))}
    return common | dict(reasons=reasons)


def prepare(path,expected,output,controls=False):
    need(re.fullmatch(r'[0-9a-fA-F]{64}',expected),'expected an independent SHA-256 receipt')
    # Authenticate an immutable copy before parsing its geometry or producing output.
    # Stage output too: a bad last row must not leave earlier rows looking complete.
    with path.open('rb') as src, tempfile.TemporaryFile() as snapshot, tempfile.TemporaryFile(mode='w+t') as staged:
        h = hashlib.sha256()
        while chunk := src.read(1<<20):
            h.update(chunk)
            snapshot.write(chunk)
        need(h.hexdigest()==expected.lower(),'input differs from trusted digest')
        snapshot.seek(0)
        header = decoded(snapshot.readline())
        need(type(header.get('schema')) is int and header['schema']==1,'unsupported pose schema')
        sizes = header.get('directions')
        need(isinstance(sizes,dict) and bool(sizes) and sizes.keys()<=COHORTS.keys() and all(type(n) is int and n>=0 for n in sizes.values()),'invalid cohort counts')
        need(header.get('controls',False) is controls and (controls or sizes==COHORTS),'not the complete direction set')
        seen = {s:set() for s in sizes}
        changed = Counter()
        for line in snapshot:
            r = direction(decoded(line))
            s,k = r['cohort'],r['id']
            need(s in sizes and k not in seen[s] and len(seen[s])<sizes[s],'unexpected or duplicate direction')
            seen[s].add(k)
            changed[s] += sum(r['v1'][p]['xyz'][2]!=r['v2'][p]['xyz'][2] for p in ('from','to'))
            print(json.dumps(r,separators=(',',':'),allow_nan=False),file=staged)
        need(all(len(v)==sizes[s] for s,v in seen.items()),'incomplete cohort')
        summary = dict(schema=1,controls=controls,inputSHA256=expected.lower(),directions=sizes,
                       adjustedEndpoints={s:changed[s] for s in sizes},acceptanceNumerators=None)
        print(json.dumps(summary,separators=(',',':')),file=staged)
        staged.seek(0)
        while chunk := staged.read(1<<20):
            output.write(chunk)


if __name__=='__main__':
    cli = argparse.ArgumentParser(description=__doc__,formatter_class=argparse.RawDescriptionHelpFormatter)
    cli.add_argument('input',type=Path)
    cli.add_argument('--sha256',required=True)
    cli.add_argument('--controls',action='store_true',help='require an explicitly marked synthetic input')
    args = cli.parse_args()
    try:
        prepare(args.input,args.sha256,sys.stdout,args.controls)
    except (OSError,KeyError,TypeError,ValueError,OverflowError) as e:
        cli.exit(2,f'pose input refused: {e}\n')
