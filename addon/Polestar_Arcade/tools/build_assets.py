"""Convert a Doom IWAD into WoW addon assets.

Outputs (under addon dir):
  tex/w<N>.tga  wall textures (rescaled to power-of-two, tile with REPEAT)
  tex/f<N>.tga  flats (64x64)
  tex/s<N>.tga  sprite frames (padded to power-of-two)
  tex/g<N>.tga  HUD / menu graphics (padded to power-of-two)
  snd/<name>.ogg
  data/assets.lua  metadata for all of the above
  data/info.lua    states / mobjinfo / sprite names / sfx (from id's info.c)
  maps/<MAP>.lua   raw map lumps as Lua strings
"""
import os, re, struct, subprocess, sys, tempfile, shutil

WAD = sys.argv[1]
OUT = sys.argv[2]
REF = sys.argv[3]  # linuxdoom-1.10 source dir

data = open(WAD, 'rb').read()
ident, numlumps, diroff = struct.unpack('<4sii', data[:12])
lumps = []
for i in range(numlumps):
    o, s, nm = struct.unpack('<ii8s', data[diroff + 16 * i: diroff + 16 * i + 16])
    lumps.append((nm.split(b'\0')[0].decode('latin1').upper(), o, s))


def lump(name):
    for n, o, s in reversed(lumps):
        if n == name:
            return data[o:o + s]
    return None


def lump_index(name):
    for i in range(len(lumps) - 1, -1, -1):
        if lumps[i][0] == name:
            return i
    return -1


def between(a, b):
    ia, ib = lump_index(a), lump_index(b)
    return [l for l in lumps[ia + 1:ib] if l[2] > 0]


pal = lump('PLAYPAL')[:768]
PAL = [(pal[i * 3], pal[i * 3 + 1], pal[i * 3 + 2]) for i in range(256)]

for d in ('tex', 'snd', 'data'):
    os.makedirs(os.path.join(OUT, d), exist_ok=True)


def pow2(n):
    p = 1
    while p < n:
        p *= 2
    return p


def write_tga(path, w, h, px):
    """px: list of rows (top to bottom), each a list of (r,g,b,a) or None."""
    out = bytearray(struct.pack('<BBBHHBHHHHBB', 0, 0, 2, 0, 0, 0, 0, 0, w, h, 32, 8))
    for y in range(h - 1, -1, -1):
        row = px[y]
        for x in range(w):
            c = row[x]
            if c is None:
                out += b'\0\0\0\0'
            else:
                out += bytes((c[2], c[1], c[0], 255))
    open(path, 'wb').write(out)


def parse_patch(raw):
    if raw is None or len(raw) < 8:
        return None
    w, h, lo, to = struct.unpack('<hhhh', raw[:8])
    if w <= 0 or h <= 0 or w > 4096 or h > 4096 or len(raw) < 8 + 4 * w:
        return None
    cols = struct.unpack('<%di' % w, raw[8:8 + 4 * w])
    img = [[None] * w for _ in range(h)]
    try:
        for x in range(w):
            p = cols[x]
            if p < 0 or p >= len(raw):
                return None
            while raw[p] != 0xFF:
                top = raw[p]
                ln = raw[p + 1]
                for j in range(ln):
                    y = top + j
                    if 0 <= y < h:
                        img[y][x] = PAL[raw[p + 3 + j]]
                p += ln + 4
    except IndexError:
        return None
    return w, h, lo, to, img


def lua_str(b):
    out = []
    for c in b:
        if 32 <= c < 127 and c not in (34, 92):
            out.append(chr(c))
        else:
            out.append('\\%03d' % c)
    return '"' + ''.join(out) + '"'


meta = []

# ---------------------------------------------------------------- textures
pn_raw = lump('PNAMES')
npn = struct.unpack('<i', pn_raw[:4])[0]
pnames = [pn_raw[4 + 8 * i: 12 + 8 * i].split(b'\0')[0].decode('latin1').upper() for i in range(npn)]
patch_cache = {}


def get_patch(name):
    if name not in patch_cache:
        patch_cache[name] = parse_patch(lump(name))
    return patch_cache[name]


textures = []
for tl in ('TEXTURE1', 'TEXTURE2'):
    raw = lump(tl)
    if raw is None:
        continue
    n = struct.unpack('<i', raw[:4])[0]
    offs = struct.unpack('<%di' % n, raw[4:4 + 4 * n])
    for o in offs:
        name = raw[o:o + 8].split(b'\0')[0].decode('latin1').upper()
        masked, w, h, _, pc = struct.unpack('<ihhih', raw[o + 8:o + 22])
        patches = []
        for k in range(pc):
            ox, oy, pi, _, _ = struct.unpack('<hhhhh', raw[o + 22 + 10 * k: o + 32 + 10 * k])
            patches.append((ox, oy, pnames[pi]))
        textures.append((name, w, h, patches))

tex_meta = []
for idx, (name, w, h, patches) in enumerate(textures):
    img = [[None] * w for _ in range(h)]
    for ox, oy, pname in patches:
        p = get_patch(pname)
        if p is None:
            continue
        pw, ph, _, _, pimg = p
        for y in range(ph):
            ty = oy + y
            if ty < 0 or ty >= h:
                continue
            prow = pimg[y]
            trow = img[ty]
            for x in range(pw):
                tx = ox + x
                if 0 <= tx < w and prow[x] is not None:
                    trow[tx] = prow[x]
    has_holes = any(c is None for row in img for c in row)
    W, H = pow2(w), pow2(h)
    scaled = [[img[y * h // H][x * w // W] for x in range(W)] for y in range(H)]
    write_tga(os.path.join(OUT, 'tex', 'w%d.tga' % idx), W, H, scaled)
    tex_meta.append('[%s]={%d,%d,%d,%s}' % (lua_str(name.encode()), idx, w, h, 'true' if has_holes else 'false'))
print('textures', len(textures))

# ---------------------------------------------------------------- flats
flat_meta = []
for idx, (name, o, s) in enumerate(between('F_START', 'F_END')):
    if s < 4096:
        continue
    raw = data[o:o + 4096]
    img = [[PAL[raw[y * 64 + x]] for x in range(64)] for y in range(64)]
    write_tga(os.path.join(OUT, 'tex', 'f%d.tga' % idx), 64, 64, img)
    flat_meta.append('[%s]=%d' % (lua_str(name.encode()), idx))
print('flats', len(flat_meta))


# ---------------------------------------------------------------- patches (sprites + gfx)
def emit_patch(prefix, idx, p):
    w, h, lo, to, img = p
    W, H = pow2(w), pow2(h)
    padded = [img[y] + [None] * (W - w) if y < h else [None] * W for y in range(H)]
    write_tga(os.path.join(OUT, 'tex', '%s%d.tga' % (prefix, idx)), W, H, padded)
    return '{%d,%d,%d,%d,%d,%d,%d}' % (idx, w, h, lo, to, W, H)


spr_lumps = between('S_START', 'S_END')
spr_meta = []
spr_index = {}
for idx, (name, o, s) in enumerate(spr_lumps):
    p = parse_patch(data[o:o + s])
    if p is None:
        continue
    spr_index[name] = idx
    spr_meta.append('[%s]=%s' % (lua_str(name.encode()), emit_patch('s', idx, p)))
print('sprites', len(spr_meta))

GFX_PREFIX = ('ST', 'M_', 'WI', 'TITLEPIC', 'INTERPIC', 'HELP', 'CREDIT', 'VICTORY', 'PFUB', 'END',
              'AMMNUM', 'BOSSBACK', 'BRDR')
ia, ib = lump_index('S_START'), lump_index('S_END')
fa, fb = lump_index('F_START'), lump_index('F_END')
pa, pb = lump_index('P_START'), lump_index('P_END')
gfx_meta = []
gi = 0
seen = set()
for i in range(len(lumps) - 1, -1, -1):
    name, o, s = lumps[i]
    if ia <= i <= ib or fa <= i <= fb or (pa >= 0 and pa <= i <= pb) or name in seen or s == 0:
        continue
    if not name.startswith(GFX_PREFIX) or name.startswith('STEP') or name.startswith('STAR'):
        if name not in ('STARMS',):
            continue
    p = parse_patch(data[o:o + s])
    if p is None:
        continue
    seen.add(name)
    gfx_meta.append('[%s]=%s' % (lua_str(name.encode()), emit_patch('g', gi, p)))
    gi += 1
print('gfx', gi)

# minimap / addon list icon: the status bar face, scaled 2x on a dark red disc
face = parse_patch(lump('STFST00'))
if face:
    fw, fh, _, _, fimg = face
    S = 64
    icon = [[None] * S for _ in range(S)]
    for y in range(S):
        for x in range(S):
            dx, dy = x - 31.5, y - 31.5
            if dx * dx + dy * dy <= 31.5 * 31.5:
                icon[y][x] = (60, 8, 8)
    ox, oy = (S - fw * 2) // 2, (S - fh * 2) // 2 + 1
    for y in range(fh * 2):
        for x in range(fw * 2):
            c = fimg[y // 2][x // 2]
            if c is not None and 0 <= oy + y < S and 0 <= ox + x < S:
                icon[oy + y][ox + x] = c
    write_tga(os.path.join(OUT, 'tex', 'icon.tga'), S, S, icon)

# ---------------------------------------------------------------- sprite defs (R_InitSpriteDefs)
src_info = open(os.path.join(REF, 'info.c'), encoding='latin1').read()
sprnames = re.findall(r'"([A-Z0-9]{4})"', src_info[src_info.index('sprnames'):src_info.index('};', src_info.index('sprnames'))])
spritedefs = []
for sn in sprnames:
    frames = {}
    for name in spr_index:
        if name[:4] != sn:
            continue
        for fpos in (4, 6):
            if len(name) < fpos + 2:
                continue
            fr = ord(name[fpos]) - ord('A')
            rot = ord(name[fpos + 1]) - ord('0')
            flip = fpos == 6
            f = frames.setdefault(fr, {})
            if rot == 0:
                for r in range(8):
                    f[r] = (name, flip)
                f['rotate'] = False
            else:
                f[rot - 1] = (name, flip)
                f['rotate'] = True
    if not frames:
        spritedefs.append('false')
        continue
    parts = []
    for fr in sorted(frames):
        f = frames[fr]
        rots = []
        for r in range(8):
            n, fl = f.get(r, f.get(0, (None, False)))
            rots.append('%s,%s' % (lua_str(n.encode()) if n else 'false', 'true' if fl else 'false'))
        parts.append('[%d]={%s,%s}' % (fr, 'true' if f['rotate'] else 'false', ','.join(rots)))
    spritedefs.append('{' + ','.join(parts) + '}')

# ---------------------------------------------------------------- sounds
sfx_names = re.findall(r'\{\s*"(\w+)",', open(os.path.join(REF, 'sounds.c'), encoding='latin1').read().split('S_sfx[]')[1])
snd_have = []
tmp = tempfile.mkdtemp()
for sn in sfx_names:
    raw = lump('DS' + sn.upper())
    if raw is None or len(raw) < 8:
        continue
    fmt, rate, n = struct.unpack('<HHI', raw[:8])
    if fmt != 3:
        continue
    pcm = raw[8 + 16: 8 + n - 16] if n > 32 else raw[8:8 + n]
    wav = os.path.join(tmp, sn + '.wav')
    with open(wav, 'wb') as f:
        f.write(b'RIFF' + struct.pack('<I', 36 + len(pcm)) + b'WAVEfmt ' +
                struct.pack('<IHHIIHH', 16, 1, 1, rate, rate, 1, 8) + b'data' + struct.pack('<I', len(pcm)) + pcm)
    dst = os.path.join(OUT, 'snd', sn + '.ogg')
    subprocess.run(['ffmpeg', '-y', '-loglevel', 'error', '-i', wav, '-ar', '22050', '-c:a', 'libvorbis', '-q:a', '5', dst], check=True)
    snd_have.append(sn)
shutil.rmtree(tmp)
print('sounds', len(snd_have))

with open(os.path.join(OUT, 'data', 'assets.lua'), 'w', newline='\n') as f:
    f.write('-- generated by tools/build_assets.py\nlocal D = FreedoomArcade\n')
    f.write('-- name = {index, width, height, hasHoles}\nD.TEXTURES = {%s}\n' % ',\n'.join(tex_meta))
    f.write('D.FLATS = {%s}\n' % ',\n'.join(flat_meta))
    f.write('-- name = {index, width, height, leftoffset, topoffset, potW, potH}\n')
    f.write('D.SPRITELUMPS = {%s}\n' % ',\n'.join(spr_meta))
    f.write('D.GFX = {%s}\n' % ',\n'.join(gfx_meta))
    f.write('-- [sprnum] = { [frame] = {rotate, lump0, flip0, ... lump7, flip7} }\n')
    f.write('D.SPRITEDEFS = {[0]=%s}\n' % ',\n'.join(spritedefs))
    cm = lump('COLORMAP')
    def luma(c):
        return 0.299 * c[0] + 0.587 * c[1] + 0.114 * c[2]
    factors = []
    for m in range(34):
        num = den = 0.0
        for c in range(256):
            l0 = luma(PAL[c])
            if l0 > 24:
                num += luma(PAL[cm[m * 256 + c]])
                den += l0
        factors.append(num / den if den else 0)
    f.write('-- brightness multiplier per COLORMAP index (0 = full bright, 31 = darkest)\n')
    f.write('D.LIGHTFACTOR = {[0]=%s}\n' % ','.join('%.3f' % x for x in factors))
    f.write('D.SOUNDFILES = {%s}\n' % ','.join('[%s]=true' % lua_str(s.encode()) for s in snd_have))

# ---------------------------------------------------------------- maps
# Each episode becomes a LoadOnDemand addon (FreedoomArcade_E1 ...); lumps are base64 encoded.
import base64
MAPLUMPS = ('THINGS', 'LINEDEFS', 'SIDEDEFS', 'VERTEXES', 'SEGS', 'SSECTORS', 'NODES', 'SECTORS', 'REJECT', 'BLOCKMAP')
ADDONS = os.path.dirname(os.path.normpath(OUT))
episodes = {}
for i, (name, o, s) in enumerate(lumps):
    m = re.match(r'^E(\d)M\d$', name)
    if m:
        parts = []
        for k, ln in enumerate(MAPLUMPS):
            n2, o2, s2 = lumps[i + 1 + k]
            assert n2 == ln, (name, n2)
            parts.append('%s="%s"' % (ln, base64.b64encode(data[o2:o2 + s2]).decode()))
        ep = 'FreedoomArcade_E' + m.group(1)
        d = os.path.join(ADDONS, ep)
        os.makedirs(d, exist_ok=True)
        with open(os.path.join(d, name + '.lua'), 'w', newline='\n') as f:
            f.write('FreedoomArcade.MAPS["%s"] = {\n%s\n}\n' % (name, ',\n'.join(parts)))
        episodes.setdefault(ep, []).append(name)
for ep, names in episodes.items():
    with open(os.path.join(ADDONS, ep, ep + '.toc'), 'w', newline='\n') as f:
        f.write('## Interface: 16001, 120100\n## Title: Freedoom Arcade map data (%s)\n## Dependencies: FreedoomArcade\n## LoadOnDemand: 1\n' % ep[-2:])
        for n in names:
            f.write(n + '.lua\n')
print('maps', sum(len(v) for v in episodes.values()))

# ---------------------------------------------------------------- info tables
info_h = open(os.path.join(REF, 'info.h'), encoding='latin1').read()
p_mobj_h = open(os.path.join(REF, 'p_mobj.h'), encoding='latin1').read()
sounds_h = open(os.path.join(REF, 'sounds.h'), encoding='latin1').read()


def enum_names(src, start_marker, prefix):
    body = src[src.index(start_marker):]
    body = body[:body.index('}')]
    return re.findall(r'\b(%s\w+)' % prefix, body)


state_names = enum_names(info_h, 'S_NULL', 'S_')
mt_names = enum_names(info_h, 'MT_PLAYER', 'MT_')
sfx_enum = enum_names(sounds_h, 'sfx_None', 'sfx_')
consts = {}
for i, n in enumerate(state_names):
    consts[n] = i
for i, n in enumerate(mt_names):
    consts[n] = i
for i, n in enumerate(sfx_enum):
    consts[n] = i
for i, n in enumerate(sprnames):
    consts['SPR_' + n] = i
for n, v in re.findall(r'(MF_\w+)\s*=\s*(0x[0-9a-fA-F]+|\d+)', p_mobj_h):
    consts[n] = int(v, 0)
consts['FRACUNIT'] = 1
consts['NULL'] = 0


def ev(expr):
    e = expr.strip()
    e = re.sub(r'\b[A-Za-z_]\w*\b', lambda m: str(consts[m.group(0)]), e)
    return eval(e)


st_body = src_info[src_info.index('state_t\tstates'):]
st_body = st_body[:st_body.index('};')]
states = re.findall(r'\{(SPR_\w+),(\d+),(-?\d+),\{(\w+)\},(S_\w+),(\d+),(\d+)\}', st_body)
assert len(states) == len(state_names) - 1 or len(states) == len(state_names), (len(states), len(state_names))
states = [list(s) for s in states]
# Freedoom DEHACKED tweaks
for fnum in (185, 419, 685, 687, 689):
    states[fnum][1] = '32773'
states[47][2] = '4'
states[48][2] = '3'

mi_body = src_info[src_info.index('mobjinfo_t mobjinfo'):]
mi_body = mi_body[mi_body.index('{') + 1:]
entries = re.findall(r'\{\s*//\s*(MT_\w+)(.*?)\n\s*\}', mi_body, re.S)
FIELDS = ['doomednum', 'spawnstate', 'spawnhealth', 'seestate', 'seesound', 'reactiontime', 'attacksound',
          'painstate', 'painchance', 'painsound', 'meleestate', 'missilestate', 'deathstate', 'xdeathstate',
          'deathsound', 'speed', 'radius', 'height', 'mass', 'damage', 'activesound', 'flags', 'raisestate']
with open(os.path.join(OUT, 'data', 'info.lua'), 'w', newline='\n') as f:
    f.write('-- generated from id Software linuxdoom-1.10 info.c (FreedoomArcade Source License / GPL)\nlocal D = FreedoomArcade\n')
    f.write('D.sprnames = {[0]=%s}\n' % ','.join('"%s"' % s for s in sprnames))
    f.write('-- {sprite, frame, tics, action, nextstate, misc1, misc2}\nD.states = {[0]=\n')
    for s in states:
        act = s[3]
        f.write('{%d,%s,%s,%s,%d,%s,%s},\n' % (consts[s[0]], s[1], s[2], 'false' if act == 'NULL' else '"%s"' % act,
                                               consts[s[4]], s[5], s[6]))
    f.write('}\n')
    f.write('D.S = {%s}\n' % ','.join('%s=%d' % (n, i) for i, n in enumerate(state_names) if n != 'S_NULL' or True))
    f.write('D.MT = {%s}\n' % ','.join('%s=%d' % (n, i) for i, n in enumerate(mt_names) if n != 'MT_NUMMOBJTYPES' and not n.startswith('NUM')))
    f.write('D.mobjinfo = {[0]=\n')
    for name, body in entries:
        vals = []
        for line in body.split('\n'):
            line = line.split('//')[0].strip().rstrip(',')
            if line:
                vals.append(line)
        assert len(vals) == len(FIELDS), (name, vals)
        f.write('{%s}, -- %s\n' % (','.join('%s=%s' % (FIELDS[k], ev(v)) for k, v in enumerate(vals)), name))
    f.write('}\n')
    f.write('D.sfxnames = {[0]=%s}\n' % ','.join('"%s"' % s for s in sfx_names))
    f.write('D.SFX = {%s}\n' % ','.join('%s=%d' % (n[4:], i) for i, n in enumerate(sfx_enum) if n != 'sfx_None' and n != 'sfx_NUMSFX' and i < len(sfx_names)))
    f.write('D.MF = {%s}\n' % ','.join('%s=%d' % (n[3:], v) for n, v in consts.items() if n.startswith('MF_')))
print('states', len(states), 'mobjtypes', len(entries))
