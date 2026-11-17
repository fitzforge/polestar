"""Make curseforge/avatar.png (400x400) from Freedoom's status bar face (BSD licensed art)."""
import struct, zlib, sys
WAD = sys.argv[1] if len(sys.argv) > 1 else 'wad/freedoom-0.13.0/freedoom1.wad'
data = open(WAD, 'rb').read()
n, off = struct.unpack('<ii', data[4:12])
lumps = {}
for i in range(n):
    o, s, nm = struct.unpack('<ii8s', data[off + 16 * i: off + 16 * i + 16])
    lumps[nm.split(b'\0')[0].decode()] = data[o:o + s]
pal = lumps['PLAYPAL']
raw = lumps['STFST00']
w, h, _, _ = struct.unpack('<hhhh', raw[:8])
cols = struct.unpack('<%di' % w, raw[8:8 + 4 * w])
face = [[None] * w for _ in range(h)]
for x in range(w):
    p = cols[x]
    while raw[p] != 0xFF:
        top, ln = raw[p], raw[p + 1]
        for j in range(ln):
            c = raw[p + 3 + j]
            face[top + j][x] = (pal[c * 3], pal[c * 3 + 1], pal[c * 3 + 2])
        p += ln + 4
S, K = 400, 10
img = [[(18, 4, 4)] * S for _ in range(S)]
for y in range(S):
    for x in range(S):
        dx, dy = x - 199.5, y - 199.5
        d = (dx * dx + dy * dy) ** 0.5
        if d <= 190:
            img[y][x] = (70, 10, 10) if d <= 182 else (150, 20, 20)
ox, oy = (S - w * K) // 2, (S - h * K) // 2 + 8
for y in range(h * K):
    for x in range(w * K):
        c = face[y // K][x // K]
        if c:
            img[oy + y][ox + x] = c
rows = b''.join(b'\0' + bytes(v for px in row for v in px) for row in img)
def chunk(t, d):
    return struct.pack('>I', len(d)) + t + d + struct.pack('>I', zlib.crc32(t + d) & 0xffffffff)
png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', S, S, 8, 2, 0, 0, 0)) + chunk(b'IDAT', zlib.compress(rows, 9)) + chunk(b'IEND', b'')
open('curseforge/avatar.png', 'wb').write(png)
print('curseforge/avatar.png')
