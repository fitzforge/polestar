"""Make curseforge/logo.png (1200x400 banner) and curseforge/logo_square.png (400x400, the CurseForge avatar).

All artwork comes from Freedoom (BSD): the title uses Freedoom's HUD font (STCFNxxx),
the cabinet screen shows a frame rendered by the addon (shots/e1m1.ppm from
tools/test_render.lua), the marquee shows the
status bar face. Usage: python tools/make_logo.py [freedoom1.wad] [screen.ppm]
"""
import struct
import sys
import zlib

WAD = sys.argv[1] if len(sys.argv) > 1 else 'wad/freedoom-0.13.0/freedoom1.wad'
SCREEN = sys.argv[2] if len(sys.argv) > 2 else 'shots/e1m1.ppm'

data = open(WAD, 'rb').read()
n, off = struct.unpack('<ii', data[4:12])
lumps = {}
for i in range(n):
    o, s, nm = struct.unpack('<ii8s', data[off + 16 * i: off + 16 * i + 16])
    lumps[nm.split(b'\0')[0].decode('latin1')] = data[o:o + s]
pal = lumps['PLAYPAL']


def patch(name):
    raw = lumps[name]
    w, h, lo, to = struct.unpack('<hhhh', raw[:8])
    cols = struct.unpack('<%di' % w, raw[8:8 + 4 * w])
    img = [[None] * w for _ in range(h)]
    for x in range(w):
        p = cols[x]
        while raw[p] != 0xFF:
            top, ln = raw[p], raw[p + 1]
            for j in range(ln):
                if top + j < h:
                    c = raw[p + 3 + j]
                    img[top + j][x] = (pal[c * 3], pal[c * 3 + 1], pal[c * 3 + 2])
            p += ln + 4
    return img


def read_ppm(path):
    d = open(path, 'rb').read()
    parts = d.split(b'\n', 3)
    w, h = map(int, parts[1].split())
    px = parts[3]
    return [[tuple(px[(y * w + x) * 3:(y * w + x) * 3 + 3]) for x in range(w)] for y in range(h)], w, h


class Canvas:
    def __init__(self, w, h):
        self.w, self.h = w, h
        self.px = [[(0, 0, 0)] * w for _ in range(h)]

    def put(self, x, y, c, a=1.0):
        if 0 <= x < self.w and 0 <= y < self.h:
            if a >= 1:
                self.px[y][x] = c
            else:
                o = self.px[y][x]
                self.px[y][x] = tuple(int(o[k] * (1 - a) + c[k] * a) for k in range(3))

    def rect(self, x0, y0, x1, y1, c, a=1.0):
        for y in range(max(0, y0), min(self.h, y1)):
            for x in range(max(0, x0), min(self.w, x1)):
                self.put(x, y, c, a)

    def blit(self, img, x0, y0, scale, tint=None):
        for y, row in enumerate(img):
            for x, c in enumerate(row):
                if c is None:
                    continue
                if tint:
                    c = tint(c, y / max(1, len(img) - 1))
                for dy in range(scale):
                    for dx in range(scale):
                        self.put(x0 + x * scale + dx, y0 + y * scale + dy, c)

    def save(self, path):
        rows = b''.join(b'\0' + bytes(v for p in row for v in p) for row in self.px)

        def chunk(t, d):
            return struct.pack('>I', len(d)) + t + d + struct.pack('>I', zlib.crc32(t + d) & 0xffffffff)
        png = (b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', self.w, self.h, 8, 2, 0, 0, 0))
               + chunk(b'IDAT', zlib.compress(rows, 9)) + chunk(b'IEND', b''))
        open(path, 'wb').write(png)


def text_image(text, spacing=1):
    """Render text with the STCFN font into a single bitmap (list of rows)."""
    glyphs = []
    for ch in text.upper():
        if ch == ' ':
            glyphs.append(None)
        else:
            glyphs.append(patch('STCFN%03d' % ord(ch)))
    h = max(len(g) for g in glyphs if g)
    width = sum((len(g[0]) + spacing) if g else 5 for g in glyphs)
    img = [[None] * width for _ in range(h)]
    x = 0
    for g in glyphs:
        if not g:
            x += 5
            continue
        gh = len(g)
        for y in range(gh):
            for xx, c in enumerate(g[y]):
                if c is not None:
                    img[h - gh + y][x + xx] = c
        x += len(g[0]) + spacing
    return img


def big_text(text, spacing=1):
    """Render text with Freedoom's big menu font (DBIGFONT, ZDoom FON2 format)."""
    d = lumps['DBIGFONT']
    height, first, last, constant, _shading, palsize, flags = struct.unpack('<HBBBBBB', d[4:12])
    p = 12
    if flags & 1:
        p += 2
    count = last - first + 1
    if constant:
        widths = [struct.unpack('<H', d[p:p + 2])[0]] * count
        p += 2
    else:
        widths = list(struct.unpack('<%dH' % count, d[p:p + 2 * count]))
        p += 2 * count
    fpal = [tuple(d[p + i * 3:p + i * 3 + 3]) for i in range(palsize + 1)]
    p += (palsize + 1) * 3
    glyphs = {}
    for i in range(count):
        w = widths[i]
        if w == 0:
            continue
        need = w * height
        out = bytearray()
        while len(out) < need:  # PackBits
            code = d[p]
            p += 1
            if code < 128:
                out += d[p:p + code + 1]
                p += code + 1
            elif code > 128:
                out += bytes([d[p]]) * (257 - code)
                p += 1
        glyphs[first + i] = [[fpal[out[y * w + x]] if out[y * w + x] else None for x in range(w)] for y in range(height)]
    chars = [glyphs.get(ord(ch)) for ch in text.upper()]
    width = sum((len(g[0]) + spacing) if g else 8 for g in chars)
    img = [[None] * width for _ in range(height)]
    x = 0
    for g in chars:
        if not g:
            x += 8
            continue
        for y in range(height):
            for xx, c in enumerate(g[y]):
                if c is not None:
                    img[y][x + xx] = c
        x += len(g[0]) + spacing
    return img


def fire_tint(c, t):
    # keep the font's shading, recolour from yellow (top) to deep red (bottom)
    lum = (0.3 * c[0] + 0.59 * c[1] + 0.11 * c[2]) / 255
    lum = 0.55 + 0.6 * lum
    top, bot = (255, 230, 90), (210, 30, 10)
    col = [top[k] * (1 - t) + bot[k] * t for k in range(3)]
    return tuple(max(0, min(255, int(v * lum))) for v in col)


def outlined(canvas, img, x0, y0, scale, tint, shadow=6):
    mask = [[c is not None for c in row] for row in img]
    # drop shadow
    canvas.blit([[(0, 0, 0) if m else None for m in row] for row in mask], x0 + shadow, y0 + shadow, scale)
    # outline: draw the mask offset in 8 directions
    o = max(2, scale // 2)
    for dx in (-o, 0, o):
        for dy in (-o, 0, o):
            if dx or dy:
                canvas.blit([[(20, 0, 0) if m else None for m in row] for row in mask], x0 + dx, y0 + dy, scale)
    canvas.blit(img, x0, y0, scale, tint)


def background(cv):
    for y in range(cv.h):
        t = y / cv.h
        c = (int(70 * (1 - t) + 8 * t), int(6 * (1 - t)), int(4 * (1 - t) + 6 * t))
        for x in range(cv.w):
            cv.px[y][x] = c
    # scanlines
    for y in range(0, cv.h, 4):
        for x in range(cv.w):
            p = cv.px[y][x]
            cv.px[y][x] = (p[0] * 3 // 4, p[1] * 3 // 4, p[2] * 3 // 4)


def cabinet(cv, x0, y0, scale_screen):
    """Draw a simple arcade cabinet with the game frame on its screen."""
    screen, sw, sh = read_ppm(SCREEN)
    sh_view = int(sh * 168 / 200)  # 3D view only, no status bar padding
    tw = int(sw * scale_screen)
    th = int(sh_view * scale_screen)
    body = (38, 34, 48)
    edge = (90, 20, 20)
    pad = 26
    cw = tw + pad * 2
    # marquee
    cv.rect(x0 - 6, y0, x0 + cw + 6, y0 + 58, (20, 18, 26))
    cv.rect(x0, y0 + 6, x0 + cw, y0 + 52, (150, 20, 15))
    face = patch('STFST00')
    fs = 2
    fx = x0 + cw // 2 - len(face[0]) * fs // 2
    cv.blit(face, fx, y0 + 7, fs)
    # body + screen bezel
    top = y0 + 58
    cv.rect(x0, top, x0 + cw, top + th + pad * 2 + 60, body)
    cv.rect(x0 - 6, top, x0 + 4, top + th + pad * 2 + 60, edge)
    cv.rect(x0 + cw - 4, top, x0 + cw + 6, top + th + pad * 2 + 60, edge)
    cv.rect(x0 + pad - 6, top + pad - 6, x0 + pad + tw + 6, top + pad + th + 6, (5, 5, 8))
    for y in range(th):
        sy = int(y / scale_screen)
        row = screen[sy]
        for x in range(tw):
            c = row[int(x / scale_screen)]
            if y % 3 == 2:
                c = (c[0] * 4 // 5, c[1] * 4 // 5, c[2] * 4 // 5)
            cv.put(x0 + pad + x, top + pad + y, c)
    # control panel
    cp = top + pad * 2 + th
    cv.rect(x0 - 10, cp, x0 + cw + 10, cp + 22, (60, 54, 70))
    stick_x = x0 + cw // 3
    cv.rect(stick_x - 3, cp - 16, stick_x + 3, cp + 4, (20, 20, 20))
    cv.rect(stick_x - 9, cp - 26, stick_x + 9, cp - 12, (200, 30, 20))
    for i, col in enumerate([(230, 200, 40), (60, 140, 230), (200, 30, 20)]):
        bx = x0 + cw // 2 + 20 + i * 26
        cv.rect(bx, cp + 4, bx + 16, cp + 14, col)
    return cw


def centered(cv, img, cx, y, scale, outline=True):
    w = len(img[0]) * scale
    x = cx - w // 2
    if outline:
        outlined(cv, img, x, y, scale, None, shadow=max(2, scale * 2))
    else:
        cv.blit(img, x, y, scale)
    return len(img) * scale


def banner():
    cv = Canvas(1200, 400)
    background(cv)
    cabinet(cv, 40, 30, 0.42)
    logo = patch('M_DOOM')
    centered(cv, logo, 790, 50, 4)
    centered(cv, big_text('ARCADE', 2), 790, 215, 6)
    centered(cv, big_text('PLAY FREEDOOM INSIDE YOUR UI', 1), 790, 338, 2, outline=False)
    cv.save('curseforge/logo.png')


def square():
    cv = Canvas(400, 400)
    background(cv)
    centered(cv, patch('M_DOOM'), 200, 14, 2)
    cabinet(cv, 132, 98, 0.2)
    centered(cv, big_text('ARCADE', 2), 200, 342, 3)
    cv.save('curseforge/logo_square.png')


if __name__ == '__main__':
    banner()
    square()
    print('curseforge/logo.png curseforge/logo_square.png')
