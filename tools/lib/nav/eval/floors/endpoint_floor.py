"""Offline fixture construction. No router input, path search, XY motion or arrival decision.

Triangle rows are the native world-space vertices (nine binary64s), then a type:
0 ADT terrain, 1 placed WMO, 2 placed model, 3 placed prop, 4 liquid.
The caller supplies a complete authenticated window and its independent policy.
"""
from collections import defaultdict
from fractions import Fraction as F
from math import isfinite

R = F(46, 100)  # frozen player's square shoulder, in native yards
HEAD = 2


def clip(poly, distance):
    if not poly:
        return []
    result = []
    a = poly[-1]
    u = distance(a)
    for b in poly:
        v = distance(b)
        if (u < 0) != (v < 0):
            t = u / (u - v)
            result.append(tuple(p + (q-p)*t for p, q in zip(a, b)))
        if v >= 0:
            result.append(b)
        a, u = b, v
    return result


def side(a, b, p):
    return (b[0]-a[0])*(p[1]-a[1]) - (b[1]-a[1])*(p[0]-a[0])


def edges(poly):
    return zip(poly, (*poly[1:], poly[0]))


def area2(poly):
    return abs(sum(a[0]*b[1]-a[1]*b[0] for a, b in edges(poly))) if poly else 0


def in_face(poly, vertices):
    for a, b in edges(vertices):
        poly = clip(poly, lambda p: side(a, b, p))
    return poly


class Face:
    def __init__(self, row, x, y, z):
        self.kind = int(row[9])
        self.v = tuple((F(a)-x, F(b)-y, F(c)-z) for a,b,c in (row[:3], row[3:6], row[6:9]))
        self.patch = self.v
        for axis in (0, 1):
            self.patch = clip(self.patch, lambda p: R+p[axis])
            self.patch = clip(self.patch, lambda p: R-p[axis])
        a,b,c = self.v
        self.nz = side(a,b,c)
        self.up = self.nz > 0 and self.kind != 4
        if self.up:
            self.dx = ((b[2]-a[2])*(c[1]-a[1])-(c[2]-a[2])*(b[1]-a[1])) / self.nz
            self.dy = ((b[0]-a[0])*(c[2]-a[2])-(c[0]-a[0])*(b[2]-a[2])) / self.nz
        self.walkable = self.up and self.dx**2 + self.dy**2 <= 1

    def height(self, x, y):
        a = self.v[0]
        return a[2] + (x-a[0])*self.dx + (y-a[1])*self.dy


def adjudicate(point, triangles, window, hazards, policy):
    """Return (new_z, reason). Policy(map/profile/frame state bound by caller) takes
    absolute min/max foot Z over the swept pose and returns None or a veto reason.
    Closed contacts, including between original and corrected poses, are tested.
    Exact rational predicates avoid rounding two different storeys into one.
    """
    x,y,z = point
    if z is None or not all(isfinite(i) for i in point) or z == 0:
        return z, 'unreadable original pose'
    x,y,origin = map(F, point)
    left,bottom,right,top = map(F, window)
    if not (left <= x-R and x+R <= right and bottom <= y-R and y+R <= top):
        return z, 'incomplete shoulder window'
    faces = []
    L,B,U,T = x-R,y-R,x+R,y+R
    for row in triangles:
        if len(row) != 10 or not all(map(isfinite,row)) or row[9] not in (0,1,2,3,4):
            raise ValueError('invalid native triangle')
        # Cheap rejection; use exact predicates at the actual boundary.
        if (max(row[0:9:3]) < L or min(row[0:9:3]) > U or
                max(row[1:9:3]) < B or min(row[1:9:3]) > T):
            continue
        f = Face(row,x,y,origin)
        if f.patch:
            faces.append(f)
    # Count every upward contact BEFORE slope, policy or clearance filtering.
    # Coincident centre hits are only one floor if welded into one local sheet.
    seeds = [f for f in faces if f.up and abs(f.height(0,0)) <= 1 and
             all(side(a,b,(0,0)) >= 0 for a,b in edges(f.v))]
    if not seeds:
        return z, 'no native floor in band'
    root = seeds[0]
    dz = root.height(0,0)
    if any(f.height(0,0) != dz for f in seeds):
        return z, 'ambiguous layers'
    if not all(f.walkable for f in seeds):
        return z, 'steep stance'
    links = defaultdict(list)
    for f in faces:
        if f.walkable:
            for a,b in edges(f.v):
                # A weld outside the footprint cannot join two sheets inside it.
                segment = [a,b]
                for axis in (0,1):
                    segment = clip(segment,lambda p: R+p[axis])
                    segment = clip(segment,lambda p: R-p[axis])
                if segment:
                    links[tuple(sorted((a,b)))].append(f)
    sheet = {root}
    pending = [root]
    while pending:
        for a,b in edges(pending.pop().v):
            for f in links.get(tuple(sorted((a,b))), ()):
                if f not in sheet:
                    sheet.add(f)
                    pending.append(f)
    if not sheet.issuperset(seeds):
        return z, 'disconnected layers'
    # Exact area of non-overlapping clipped patches must equal the WHOLE square.
    # Never let overlap compensate a hole. Zero-area walls/contacts still block.
    covered = 0
    low, high = None, None
    for f in sheet:
        ar = area2(f.patch)
        if not ar:
            continue
        if f.kind in (2,3):
            # The archived collision soup has no per-placement animation state.
            return z, 'unproven static model or prop stance'
        covered += ar
        for p in f.patch:
            h = p[2]
            low = h if low is None else min(low,h)
            high = h if high is None else max(high,h)
        for other in faces:
            if other is f:
                continue
            contact = in_face(other.patch,f.v)
            if not contact:
                continue
            ds = [p[2]-f.height(p[0],p[1]) for p in contact]
            if other in sheet:
                if area2(contact) or min(ds) != 0 or max(ds) != 0:
                    return z, 'overlapping or folded sheet'
                continue
            if dz > 0 and f.kind != 0 and other.kind == f.kind and other.nz < 0 and min(ds) < 0:
                # A lower underside can enclose the original feet INSIDE a thick
                # solid, even when the bottom itself is outside the one-yard band.
                return z, 'unproven inside of solid'
            if other.kind == 4:
                if max(ds) >= min(0,-dz)-F(1,10):
                    return z, 'liquid'
            elif min(ds) <= HEAD+max(0,-dz) and max(ds) >= min(0,-dz):
                return z, 'solid in swept stance'
    if covered != 8*R*R:
        return z, 'unsupported shoulder'
    low += origin + min(0,-dz)
    high += origin + max(0,-dz)
    for a,b,c,A,B,C,_label in hazards:
        if (a<=x+R and b<=y+R and A>=x-R and B>=y-R and
                c<=high+HEAD and C>=low-F(1,10)):
            return z, 'source hazard'
    reason = policy(low, high)
    if reason is not None:
        return z, reason
    result = float(origin+dz)
    if result == 0 or abs(F(result)-origin) > 1:
        return z, 'unrepresentable or unreadable height'
    return result, 'already on floor' if result == z else 'unique clear floor'


def paired_points(original, overlay, version):
    """Materialize just the two poses. Never pass guide support or precomputed routes to a player."""
    if version not in ('v1','v2') or any(original[k]!=overlay[k] for k in ('id','map')):
        raise ValueError('foreign fixture overlay')
    points = []
    for k in ('from','to'):
        x,y,old = original[k]
        decision = overlay[k]
        new = decision['z']
        if old!=decision['originalZ'] or (new!=old and
                (decision['reason']!='unique clear floor' or old is None or new is None or
                 not isfinite(new) or abs(F(new)-F(old))>1)):
            raise ValueError('unjustified change to original pose')
        points.append([x,y,new if version=='v2' else old])
    return points
