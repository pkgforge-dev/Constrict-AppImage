#!/bin/sh

set -eu

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
#Build
pacman -S --noconfirm --needed meson blueprint-compiler
#Needed
pacman -S --noconfirm --needed python python-gobject python-cairo glycin-gtk4 libadwaita ffmpeg 
#Optional
pacman -S --noconfirm --needed libva-utils
    
echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Installing constrict from source packages..."
echo "---------------------------------------------------------------"
git clone https://gitlab.gnome.org/World/Constrict.git && (
	cd ./Constrict
	TAG=$(git tag --sort=-v:refname | grep -vi 'rc\|alpha' | head -1)
	git checkout "$TAG"
	echo "$TAG" > ~/version
	meson setup build --prefix=/usr
	meson compile -C build
	meson install -C build
)

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
