#!/bin/sh
# Copy sources into build/FreedoomArcade (assets are produced by build_assets.py)
set -e
mkdir -p build/FreedoomArcade/src
cp src/*.lua build/FreedoomArcade/src/
cp src/FreedoomArcade.toc build/FreedoomArcade/
cp wad/freedoom-0.13.0/COPYING.txt build/FreedoomArcade/FREEDOOM-COPYING.txt
cp LICENSE build/FreedoomArcade/LICENSE.txt
echo "built build/FreedoomArcade"
