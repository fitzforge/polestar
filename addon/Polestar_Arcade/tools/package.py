"""Zip the built addon for release: dist/FreedoomArcade-v<version>.zip

The zip holds only the addon folders at its root (FreedoomArcade, FreedoomArcade_E1..E4),
which is the layout CurseForge and manual installs both expect.
Prints the zip path and version.
"""
import os
import re
import sys
import zipfile

BUILD = 'build'
FOLDERS = ['FreedoomArcade'] + ['FreedoomArcade_E%d' % e for e in range(1, 5)]


def version():
    toc = open(os.path.join(BUILD, 'FreedoomArcade', 'FreedoomArcade.toc')).read()
    m = re.search(r'^## Version:\s*(\S+)', toc, re.M)
    if not m:
        sys.exit('no ## Version in toc')
    return m.group(1)


def main():
    v = version()
    os.makedirs('dist', exist_ok=True)
    out = os.path.join('dist', 'FreedoomArcade-v%s.zip' % v)
    with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for folder in FOLDERS:
            root_dir = os.path.join(BUILD, folder)
            if not os.path.isdir(root_dir):
                sys.exit('missing ' + root_dir)
            for root, _, files in os.walk(root_dir):
                for f in sorted(files):
                    p = os.path.join(root, f)
                    z.write(p, os.path.relpath(p, BUILD).replace(os.sep, '/'))
    print(out)
    print(v)


if __name__ == '__main__':
    main()
