"""Print the CHANGELOG.md section for a version: python tools/changelog.py 0.3.0"""
import re
import sys


def section(version, path='CHANGELOG.md'):
    text = open(path, encoding='utf-8').read()
    m = re.search(r'^## v?%s\b.*?$(.*?)(?=^## |\Z)' % re.escape(version), text, re.M | re.S)
    return m.group(1).strip() if m else None


if __name__ == '__main__':
    s = section(sys.argv[1])
    if s is None:
        sys.exit('no "## %s" section in CHANGELOG.md' % sys.argv[1])
    print(s)
