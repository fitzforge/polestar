"""Portable synthetic controls: python -B -m unittest discover -s tools/lib/nav/eval/floors.
The CLI test runs the documented command on both a clear and a stacked floor.
"""
import copy
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from poses import FACTS, prepare
from test_endpoint_floor import platform


def fixture():
    facts = dict.fromkeys(FACTS,True) | {'clearZ':[5,15]}
    native = dict(source='native',complete=True,window=[-2,-2,2,2],triangles=platform(11),hazards=[],
                  profiles={'Alliance':facts,'Horde':facts.copy()})
    clear = dict(cohort='outdoor',id='one',map=1,profiles=['Alliance','Horde'],level=23,
                 evidence={'from':native,'to':copy.deepcopy(native)})
    clear['from'] = dict(frame=4,xyz=[-.25,-.25,10])
    clear['to'] = dict(frame=4,xyz=[.25,.25,12])
    for k in ('from','to'):
        clear['evidence'][k]['at'] = dict(map=1,level=23,**copy.deepcopy(clear[k]))
    stacked = copy.deepcopy(clear)
    stacked.update(cohort='named',profiles=['Alliance'])
    stacked['evidence']['from']['triangles'] += platform(9.5)
    stacked['evidence']['to']['profiles']['Alliance']['phaseKnown'] = False
    return [{'schema':1,'controls':True,'directions':{'outdoor':1,'named':1}},clear,stacked]


def export(path,rows):
    data = ''.join(json.dumps(r,separators=(',',':'))+'\n' for r in rows).encode()
    path.write_bytes(data)
    return hashlib.sha256(data).hexdigest()


class PoseCommand(unittest.TestCase):
    def test_cli_positive_negative_and_separate_counts(self):
        with tempfile.TemporaryDirectory() as td:
            f = Path(td)/'input.jsonl'
            rows = fixture()
            stamp = export(f,rows)
            cmd = [sys.executable,'-B',str(Path(__file__).with_name('poses.py')),str(f),'--sha256',stamp,'--controls']
            with self.assertRaisesRegex(ValueError,'complete direction set'):
                prepare(f,stamp,io.StringIO())
            proc = subprocess.run(cmd,capture_output=True,text=True,check=True)
            clear,stacked,summary = map(json.loads,proc.stdout.splitlines())
            for original,output in zip(rows[1:],(clear,stacked)):
                self.assertEqual(output['v1'],{k:original[k] for k in ('from','to')})
                for k in ('cohort','map','profiles','level','id'):
                    self.assertEqual(output[k],original[k])
                for k in ('from','to'):
                    self.assertEqual(output['v2'][k]['frame'],original[k]['frame'])
                    self.assertEqual(output['v2'][k]['xyz'][:2],original[k]['xyz'][:2])
            self.assertEqual([clear['v2'][k]['xyz'][2] for k in ('from','to')],[11,11])
            self.assertEqual(stacked['v2'],stacked['v1'])
            self.assertEqual(stacked['reasons'],{'from':'ambiguous layers','to':'unproven phaseKnown'})
            self.assertEqual(summary['directions'],{'outdoor':1,'named':1})
            self.assertEqual(summary['adjustedEndpoints'],{'outdoor':2,'named':0})
            self.assertIsNone(summary['acceptanceNumerators'])
            with f.open('ab') as dest:
                dest.write(b' ')
            bad = subprocess.run(cmd,capture_output=True,text=True)
            self.assertNotEqual(bad.returncode,0)
            self.assertEqual(bad.stdout,'')
            self.assertIn('trusted digest',bad.stderr)

    def test_missing_policy_for_either_side_or_swept_span_cannot_grant(self):
        with tempfile.TemporaryDirectory() as td:
            f = Path(td)/'input.jsonl'
            for mutation in ('side','extent','incomplete','foreign_source','foreign_frame','missing_geometry'):
                with self.subTest(mutation=mutation):
                    rows = fixture()
                    for k in ('from','to'):
                        native = rows[1]['evidence'][k]
                        if mutation=='side':
                            del native['profiles']['Horde']
                        elif mutation=='extent':
                            native['profiles']['Horde']['clearZ'] = [10,12]
                        elif mutation=='foreign_frame':
                            native['at']['frame'] = 1
                        elif mutation=='incomplete':
                            native['complete'] = False
                        elif mutation=='foreign_source':
                            native['source'] = 'router'
                        else:
                            del native['hazards']
                    out = io.StringIO()
                    prepare(f,export(f,rows),out,controls=True)
                    first = json.loads(out.getvalue().splitlines()[0])
                    self.assertEqual(first['v1'],first['v2'])

    def test_partial_or_repeated_direction_never_leaks_partial_output(self):
        with tempfile.TemporaryDirectory() as td:
            f = Path(td)/'input.jsonl'
            rows = fixture()
            for cases in (rows[:-1],rows+[rows[-1]]):
                out = io.StringIO()
                with self.assertRaises(ValueError):
                    prepare(f,export(f,cases),out,controls=True)
                self.assertEqual(out.getvalue(),'')


if __name__=='__main__':
    unittest.main()
