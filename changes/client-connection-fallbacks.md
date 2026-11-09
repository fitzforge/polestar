---
section: players
---
- Polestar Client: when it can't connect the normal way, it tries other ways
  before giving up: IPv4 only, its own list of certificate authorities beside
  your system's, its own DNS lookup (DNS over HTTPS), and without your proxy.
  The first that works is used until the next start, and Status says which
  ("Connected using IPv4 only", for example). Certificates are always
  checked. A wrong clock on your PC (which makes every certificate look
  expired) is named as such, with the time it says.
