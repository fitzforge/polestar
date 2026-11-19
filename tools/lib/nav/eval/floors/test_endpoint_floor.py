import math
import unittest

from endpoint_floor import adjudicate, paired_points


def face(a,b,c,kind=0):
    return (*a,*b,*c,kind)


def platform(z, x0=-2, x1=2, kind=0, flip=False):
    vs = [(x0,-2,z), (x1,-2,z), (x1,2,z), (x0,2,z)]
    if flip:
        vs.reverse()
    return [face(vs[0],vs[1],vs[2],kind), face(vs[0],vs[2],vs[3],kind)]


class Floors(unittest.TestCase):
    def result(self, tris, z=10, boxes=(), veto=None, x=0, y=0):
        return adjudicate([x,y,z], tris, [-3,-3,3,3], boxes, lambda lo,hi: veto)

    def test_inclusive_both_sides_on_a_shared_edge(self):
        # The diagonal passes through the centre: two triangles, one physical sheet.
        for h in [9,9.1,10.9,11]:
            self.assertEqual(self.result(platform(h)),(h,'unique clear floor'))
        self.assertEqual(self.result(platform(10)),(10,'already on floor'))
        for h in [math.nextafter(9,-math.inf),math.nextafter(11,math.inf)]:
            self.assertEqual(self.result(platform(h)),(10,'no native floor in band'))

    def test_ambiguity_is_not_a_nearest_or_only_clear_test(self):
        for other in [9,10.3,math.nextafter(10.5,math.inf)]:
            self.assertEqual(self.result(platform(10.5)+platform(other)),(10,'ambiguous layers'))
        blocked = platform(9.25) + platform(10.75) + platform(11.5,flip=True)
        self.assertEqual(self.result(blocked),(10,'ambiguous layers'))
        self.assertEqual(self.result(platform(10.5)+platform(10.5))[0],10)

    def test_continuous_slope_not_a_step(self):
        ramp = [tuple(v+(t[i-2]/2) if i%3==2 and i<9 else v for i,v in enumerate(t)) for t in platform(10.5)]
        self.assertEqual(self.result(ramp),(10.5,'unique clear floor'))
        # A step away from the centre but under the shoulder.
        self.assertEqual(self.result(platform(10.25,x1=.2)+platform(10.75,x0=.2))[0],10)
        steep = [tuple(v+2*t[i-2] if i%3==2 and i<9 else v for i,v in enumerate(t)) for t in platform(10.5)]
        self.assertEqual(self.result(steep)[0],10)

    def test_complete_footprint_not_points_or_area_sum(self):
        self.assertEqual(self.result(platform(10.5,x1=.4))[0],10)
        slit = platform(10.5,x1=.217) + platform(10.5,x0=.21700000000001)
        self.assertEqual(self.result(slit)[0],10)
        self.assertEqual(self.result(platform(10.5),x=2.3)[0],10)

    def test_vertical_sweep_and_headroom(self):
        for z0,z1,ceiling in [(10,10.75,10.3),(10,10.75,12.7),(10,9.25,11.9)]:
            self.assertEqual(self.result(platform(z1)+platform(ceiling,flip=True),z0)[0],z0)
        wall = face((.31,-1,9.5),(.31,1,9.5),(.31,1,12),2)
        self.assertEqual(self.result(platform(10.5)+[wall])[0],10)
        self.assertEqual(self.result(platform(10.5)+platform(10.7,kind=4))[0],10)
        thick = platform(10.75,kind=1)+platform(3,kind=1,flip=True)
        self.assertEqual(self.result(thick)[0],10)
        self.assertEqual(self.result(platform(10.5,kind=2))[0],10)

    def test_source_and_policy_vetoes(self):
        for why in ['unresolved phase','moving support','native hole','faction or level hazard']:
            self.assertEqual(self.result(platform(10.5),veto=why),(10,why))
        self.assertEqual(self.result(platform(10.5),boxes=[(.4,.4,12.25,.48,.48,13,'hazard')])[0],10)
        self.assertEqual(self.result(platform(10.5),z=None)[0],None)

    def test_replay_uses_original_identity_xy_and_only_a_proven_z(self):
        case = {'id':'synthetic','map':7,'zone':2,'profile':'Alliance','level':23,
                'from':[0,0,10],'to':[1,1,None],'support':['untrusted']}
        overlay = {'id':case['id'],'map':7,'from':dict(originalZ=10,z=11,reason='unique clear floor'),
                   'to':dict(originalZ=None,z=None,reason='unreadable original pose')}
        self.assertEqual(paired_points(case,overlay,'v1'),[[0,0,10],[1,1,None]])
        self.assertEqual(paired_points(case,overlay,'v2'),[[0,0,11],[1,1,None]])
        self.assertEqual(case['from'],[0,0,10])
        for edit in [dict(z=11.000001),dict(reason='unsafe'),dict(originalZ=9)]:
            with self.assertRaises(ValueError):
                paired_points(case,overlay|{'from':overlay['from']|edit},'v2')


if __name__ == '__main__':
    unittest.main()
