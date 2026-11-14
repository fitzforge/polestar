"""Cut a built Freedoom Arcade addon down to a few maps.

  python tools/subset.py <freedoom1.wad> <addon dir built by build_assets.py> E1M1,E1M2,E1M3

The addon's tex/ and snd/ keep only the files those maps can show or play:
  walls    every sidedef texture, its switch's other half, every frame of an
           animation one of them is in, and the episode's sky
  flats    every sector floor and ceiling, with their animations
  sprites  the things placed on the maps (every skill), what they spawn
           (projectiles, drops, fog, puffs, blood) and the player's weapons,
           found by following the states and actions in data/info.lua and src/
  gfx      what src/ draws, but other episodes' intermission art and the finales
  sounds   what src/ plays by name, and the sounds of the things kept
The metadata in data/assets.lua stays whole (animations are index ranges).
The maps move into the addon (maps/<MAP>.lua, listed in its TOC) instead of
the FreedoomArcade_E<n> addons, and data/maps.lua names them (D.MAPSET), so
the game offers only those and ends after the last one.
"""
import os
import re
import shutil
import struct
import sys

WAD, OUT, MAPS = sys.argv[1], sys.argv[2], sys.argv[3].upper().split(',')
SRC = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'src')

data = open(WAD, 'rb').read()
_, numlumps, diroff = struct.unpack('<4sii', data[:12])
lumps = []
for i in range(numlumps):
    o, s, nm = struct.unpack('<ii8s', data[diroff + 16 * i: diroff + 16 * i + 16])
    lumps.append((nm.split(b'\0')[0].decode('latin1').upper(), o, s))


def map_lump(mapname, name):
    i = [n for n, _, _ in lumps].index(mapname)
    for n, o, s in lumps[i + 1:i + 11]:
        if n == name:
            return data[o:o + s]
    raise SystemExit('%s has no %s' % (mapname, name))


def name8(b):
    return b.split(b'\0')[0].decode('latin1').upper()


def unlua(s):
    return re.sub(r'\\(\d{3})', lambda m: chr(int(m.group(1))), s)


assets = open(os.path.join(OUT, 'data', 'assets.lua'), encoding='latin1').read()
info = open(os.path.join(OUT, 'data', 'info.lua'), encoding='latin1').read()


def table(src, name):
    start = src.index('D.%s = {' % name)
    end = src.index('\nD.', start + 1) if '\nD.' in src[start + 1:] else len(src)
    return src[start:end]


TEX = {unlua(n): int(i) for n, i in re.findall(r'\["((?:[^"\\]|\\\d{3})*)"\]=\{(\d+),', table(assets, 'TEXTURES'))}
FLAT = {unlua(n): int(i) for n, i in re.findall(r'\["((?:[^"\\]|\\\d{3})*)"\]=(\d+)', table(assets, 'FLATS'))}
SPR = {unlua(n): int(i) for n, i in re.findall(r'\["((?:[^"\\]|\\\d{3})*)"\]=\{(\d+),', table(assets, 'SPRITELUMPS'))}
GFX = {unlua(n): int(i) for n, i in re.findall(r'\["((?:[^"\\]|\\\d{3})*)"\]=\{(\d+),', table(assets, 'GFX'))}

sprnames = re.findall(r'"(\w{4})"', table(info, 'sprnames'))
states = [(int(a), b) for a, b in re.findall(r'^\{(\d+),[^,]+,[^,]+,(false|"\w+"),', table(info, 'states'), re.M)]
nexts = [int(n) for n in re.findall(r'^\{\d+,[^,]+,[^,]+,(?:false|"\w+"),(\d+),', table(info, 'states'), re.M)]
S = {n: int(i) for n, i in re.findall(r'(S_\w+)=(\d+)', table(info, 'S'))}
MT = {n: int(i) for n, i in re.findall(r'(MT_\w+)=(\d+)', table(info, 'MT'))}
mobjinfo = []
for body, name in re.findall(r'^\{(doomednum=.*?)\}, -- (MT_\w+)$', table(info, 'mobjinfo'), re.M):
    mobjinfo.append(dict((k, int(float(v))) for k, v in re.findall(r'(\w+)=(-?[\d.]+)', body)))
sfxnames = re.findall(r'"(\w+)"', table(info, 'sfxnames'))
assert len(states) == len(nexts) and len(mobjinfo) == len(MT), (len(states), len(nexts), len(mobjinfo), len(MT))

# ---------------------------------------------------------------- what the code spawns, enters and plays
# A thing type counts as spawned where it is passed or assigned (P.SpawnMobj(..., MT.X), item = MT.X),
# not where a type is compared or looked up. In p_enemy.lua, what an action and the helpers it calls
# spawn or enter counts only when a kept state runs that action.
SPAWN = re.compile(r'(?<![=~]= )(?<!\[)\bMT\.(MT_\w+)')
ENTER = re.compile(r'\bS\.(S_\w+)')
chunks, code_mts, code_states, code_sfx = {}, set(), set(), set()
for f in sorted(os.listdir(SRC)):
    if not f.endswith('.lua'):
        continue
    text = open(os.path.join(SRC, f), encoding='latin1').read()
    code_sfx.update(re.findall(r'\bSFX\.(\w+)', text))
    if f != 'p_enemy.lua':
        code_mts.update(SPAWN.findall(text))
        code_states.update(ENTER.findall(text))
        continue
    parts = re.split(r'^((?:local )?function (?:A\.)?(\w+)\(.*)$', text, flags=re.M)
    code_mts.update(SPAWN.findall(parts[0]))
    code_states.update(ENTER.findall(parts[0]))
    for k in range(1, len(parts), 3):
        chunks[parts[k + 1]] = parts[k + 2]


def reach(name, seen=None):
    """The thing types and states action/helper `name` spawns or enters, with the helpers it calls."""
    seen = seen if seen is not None else set()
    if name in seen or name not in chunks:
        return set(), set()
    seen.add(name)
    body = chunks[name]
    mts, sts = set(SPAWN.findall(body)), set(ENTER.findall(body))
    for other in chunks:
        if other != name and not other.startswith('A_') and re.search(r'\b%s\(' % re.escape(other), body):
            m2, s2 = reach(other, seen)
            mts |= m2
            sts |= s2
    return mts, sts


action_mts, action_states = {}, {}
for name in chunks:
    if name.startswith('A_'):
        action_mts[name], action_states[name] = reach(name)

# ---------------------------------------------------------------- the maps
walls, flats, things = {'SKY%s' % MAPS[0][1]}, set(), set()
for m in MAPS:
    for k in range(0, len(map_lump(m, 'SIDEDEFS')), 30):
        sd = map_lump(m, 'SIDEDEFS')[k:k + 30]
        for o in (4, 12, 20):
            n = name8(sd[o:o + 8])
            if n and n != '-':
                walls.add(n)
    sec = map_lump(m, 'SECTORS')
    for k in range(0, len(sec), 26):
        flats.add(name8(sec[k + 4:k + 12]))
        flats.add(name8(sec[k + 12:k + 20]))
    th = map_lump(m, 'THINGS')
    for k in range(0, len(th), 10):
        things.add(struct.unpack('<h', th[k + 6:k + 8])[0])

# switches and animations (p_spec.lua's lists)
spec = open(os.path.join(SRC, 'p_spec.lua'), encoding='latin1').read()
for a, b in re.findall(r'\{ "(SW1\w+)", "(SW2\w+)" \}', spec):
    if a in walls or b in walls:
        walls.update((a, b))
for istex, last, first in re.findall(r'\{ (true|false), "(\w+)", "(\w+)", \d+ \}', spec):
    used, index = (walls, TEX) if istex == 'true' else (flats, FLAT)
    if first in index and last in index:
        names = [n for n, i in index.items() if index[first] <= i <= index[last]]
        if used & set(names):
            used.update(names)

# things: every type placed, then what their states run, to a fixed point
types = {i for i, mi in enumerate(mobjinfo) if mi['doomednum'] in things}
types |= {MT[n] for n in code_mts}
kept_states = {S[n] for n in code_states}
FIELDS = ('spawnstate', 'seestate', 'painstate', 'meleestate', 'missilestate', 'deathstate', 'xdeathstate', 'raisestate')
while True:
    before = (len(types), len(kept_states))
    for t in types:
        kept_states.update(mobjinfo[t][f] for f in FIELDS if mobjinfo[t][f])
    todo = list(kept_states)
    while todo:
        s = todo.pop()
        for n in (nexts[s],):
            if n not in kept_states:
                kept_states.add(n)
                todo.append(n)
        act = states[s][1].strip('"')
        types |= {MT[n] for n in action_mts.get(act, ())}
        for n in action_states.get(act, ()):
            if S[n] not in kept_states:
                kept_states.add(S[n])
                todo.append(S[n])
    if (len(types), len(kept_states)) == before:
        break
sprites = {sprnames[states[s][0]] for s in kept_states if s < len(states)}
sounds = set(code_sfx)
for t in types:
    for f in ('seesound', 'attacksound', 'painsound', 'deathsound', 'activesound'):
        if mobjinfo[t][f]:
            sounds.add(sfxnames[mobjinfo[t][f]])
if 'pistol' in sounds:
    sounds.add('chgun')  # sound.lua plays chgun as pistol

# gfx: all but other episodes' intermission art, their level names and the finales
ep = int(MAPS[0][1])
last = max(int(m[3]) for m in MAPS)
DROP_GFX = re.compile(r'^(WIMAP(?!%d$)\d|WIA(?!%d)\d|WILV(?!%d[0-%d]$)\d\d|M_EPI(?!%d$)\d|VICTORY|PFUB|END\d|ENDPIC|BOSSBACK|CREDIT|HELP|INTERPIC)'
                      % (ep - 1, ep - 1, ep - 1, last - 1, ep))
# and only what src/ draws: a graphic named in the code, or one a name built in the code starts with
# ("STKEYS" .. k, string.format("STCFN%03d", c))
src_text = ''.join(open(os.path.join(SRC, f), encoding='latin1').read() for f in sorted(os.listdir(SRC)) if f.endswith('.lua'))
named = set(re.findall(r'"([A-Z][A-Z0-9_]+)(?:%[^"]*)?"', src_text))
gfx = {n for n in GFX if not DROP_GFX.match(n) and any(n == x or (n.startswith(x) and len(x) >= 3) for x in named)}

# ---------------------------------------------------------------- write
keep = {'icon.tga'}
keep |= {'w%d.tga' % TEX[n] for n in walls if n in TEX}
keep |= {'f%d.tga' % FLAT[n] for n in flats if n in FLAT}
keep |= {'s%d.tga' % i for n, i in SPR.items() if n[:4] in sprites}
keep |= {'g%d.tga' % GFX[n] for n in gfx}
tex = os.path.join(OUT, 'tex')
removed = 0
for f in os.listdir(tex):
    if f not in keep:
        os.remove(os.path.join(tex, f))
        removed += 1
snd = os.path.join(OUT, 'snd')
for f in os.listdir(snd):
    if f[:-4] not in sounds:
        os.remove(os.path.join(snd, f))
        removed += 1

maps_dir = os.path.join(OUT, 'maps')
os.makedirs(maps_dir, exist_ok=True)
built = os.path.dirname(os.path.normpath(OUT))
for m in MAPS:
    shutil.copy(os.path.join(built, 'FreedoomArcade_E' + m[1], m + '.lua'), os.path.join(maps_dir, m + '.lua'))
with open(os.path.join(OUT, 'data', 'maps.lua'), 'w', newline='\n') as f:
    f.write('-- generated by tools/subset.py: the maps this copy holds, in play order\nlocal D = FreedoomArcade\n')
    f.write('D.MAPSET = {%s}\n' % ', '.join('"%s"' % m for m in MAPS))

print('kept: %d walls, %d flats, %d sprite names, %d gfx, %d sounds; removed %d files'
      % (len([n for n in walls if n in TEX]), len([n for n in flats if n in FLAT]), len(sprites), len(gfx), len(sounds), removed))
print('things: ' + ', '.join(sorted(n for n, i in MT.items() if i in types)))
