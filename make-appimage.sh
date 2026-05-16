#!/bin/sh
set -eu

# Setup
ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.wartybix.Constrict.svg
export DESKTOP=/usr/share/applications/io.github.wartybix.Constrict.desktop
export PATH_MAPPING='/usr/share/constrict:${SHARUN_DIR}/share/constrict'
export DEPLOY_PYTHON=1

# Deploy dependencies
quick-sharun \
  /usr/bin/constrict \
  /usr/bin/ffprobe \
  /usr/bin/ffmpeg \
  /usr/lib/libgtk-4.so* \
  /usr/lib/libadwaita-1.so* \
  /usr/share/constrict
  
# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
