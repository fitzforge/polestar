---
section: players
---
- Polestar Client: when it can't reach the Polestar recording server the
  normal way, it tries other ways before giving up: IPv4 only, its own list
  of certificate authorities added to your system's (only when your system
  doesn't know the one that signed the server's certificate; your system
  still checks it), and its own DNS lookup of the Polestar server by DNS
  over HTTPS to Cloudflare and Google. The first that works is used until
  the next start, and Status says which. If your proxy itself can't be
  reached, that one upload goes without it. A wrong clock on your PC is
  named as such, with the time it says. Uploads never follow redirects and
  use HTTPS only.
