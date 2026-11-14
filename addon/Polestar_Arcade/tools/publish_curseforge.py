"""Upload a release zip to CurseForge.

Usage: python tools/publish_curseforge.py <zip> <version> [release|beta|alpha]

Environment:
  CF_API_TOKEN   CurseForge API token (https://authors.curseforge.com/#/settings/api-tokens)
  CF_PROJECT_ID  numeric project id (shown on the project's overview page)
  CF_GAME_VERSIONS  optional comma separated version names to tag, e.g. "12.1.0,1.15.7".
                 Default: derived from the ## Interface line of the toc.

The changelog is the section for <version> in CHANGELOG.md.
"""
import json
import os
import re
import sys
import urllib.request
import uuid

API = 'https://wow.curseforge.com/api'


def die(msg):
    print('error: ' + msg, file=sys.stderr)
    sys.exit(1)


def request(method, path, token, body=None, content_type=None):
    req = urllib.request.Request(API + path, data=body, method=method)
    req.add_header('X-Api-Token', token)
    req.add_header('User-Agent', 'FreedoomArcade-publisher')
    if content_type:
        req.add_header('Content-Type', content_type)
    try:
        with urllib.request.urlopen(req, timeout=300) as r:
            return json.loads(r.read().decode())
    except urllib.error.HTTPError as e:
        die('%s %s -> HTTP %d: %s' % (method, path, e.code, e.read().decode(errors='replace')[:500]))


def interface_versions():
    toc = open('src/FreedoomArcade.toc').read()
    m = re.search(r'^## Interface:\s*(.+)$', toc, re.M)
    names = []
    for part in m.group(1).split(','):
        n = int(part.strip())
        names.append('%d.%d.%d' % (n // 10000, (n // 100) % 100, n % 100))
    return names


def changelog(version):
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from changelog import section
    text = section(version)
    if text is None:
        die('no "## %s" section in CHANGELOG.md' % version)
    return text


def multipart(fields, file_field, file_path):
    boundary = uuid.uuid4().hex
    parts = []
    for name, value in fields.items():
        parts.append(('--%s\r\nContent-Disposition: form-data; name="%s"\r\n\r\n%s\r\n' % (boundary, name, value)).encode())
    with open(file_path, 'rb') as f:
        data = f.read()
    parts.append(('--%s\r\nContent-Disposition: form-data; name="%s"; filename="%s"\r\nContent-Type: application/zip\r\n\r\n'
                  % (boundary, file_field, os.path.basename(file_path))).encode() + data + b'\r\n')
    parts.append(('--%s--\r\n' % boundary).encode())
    return b''.join(parts), 'multipart/form-data; boundary=' + boundary


def main():
    if len(sys.argv) < 3:
        die(__doc__)
    zip_path, version = sys.argv[1], sys.argv[2]
    release_type = sys.argv[3] if len(sys.argv) > 3 else 'release'
    token = os.environ.get('CF_API_TOKEN') or die('CF_API_TOKEN is not set')
    project = os.environ.get('CF_PROJECT_ID') or die('CF_PROJECT_ID is not set')

    wanted = [v.strip() for v in os.environ.get('CF_GAME_VERSIONS', '').split(',') if v.strip()] or interface_versions()
    known = request('GET', '/game/versions', token)
    ids = []
    for name in wanted:
        match = [v['id'] for v in known if v.get('name') == name]
        if match:
            ids.append(match[0])
            print('game version %s -> id %d' % (name, match[0]))
        else:
            print('warning: CurseForge has no game version named %s; skipping it' % name)
    if not ids:
        die('none of %s are known CurseForge game versions; set CF_GAME_VERSIONS' % wanted)

    metadata = {
        'changelog': changelog(version),
        'changelogType': 'markdown',
        'displayName': 'Freedoom Arcade v%s' % version,
        'gameVersions': ids,
        'releaseType': release_type,
    }
    body, ctype = multipart({'metadata': json.dumps(metadata)}, 'file', zip_path)
    result = request('POST', '/projects/%s/upload-file' % project, token, body, ctype)
    print('uploaded %s as CurseForge file id %s' % (zip_path, result.get('id')))


if __name__ == '__main__':
    main()
