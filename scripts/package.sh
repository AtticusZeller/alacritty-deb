#!/bin/bash
set -e

VERSION=$1
ARCH=$(dpkg --print-architecture)

# mkdir package directory
PACKAGE_DIR="alacritty-package"
mkdir -p "$PACKAGE_DIR/DEBIAN"
mkdir -p "$PACKAGE_DIR/usr/bin"
mkdir -p "$PACKAGE_DIR/usr/share/applications"
mkdir -p "$PACKAGE_DIR/usr/share/pixmaps"

# copy binary
cp alacritty/target/release/alacritty "$PACKAGE_DIR/usr/bin/"
# copy desktop icon
cp alacritty/extra/logo/alacritty-term.svg "$PACKAGE_DIR/usr/share/pixmaps/Alacritty.svg"

# control
cat > "$PACKAGE_DIR/DEBIAN/control" << EOF
Package: alacritty
Version: ${VERSION#v}
Section: utils
Priority: optional
Architecture: $ARCH
Maintainer: Your Name <your.email@example.com>
Depends: libc6
Description: GPU-accelerated terminal emulator
 Alacritty is a modern terminal emulator that
 utilizes GPU acceleration for improved performance.
EOF

# desktop
# Ref: https://github.com/alacritty/alacritty/blob/master/extra/linux/Alacritty.desktop
cat > "$PACKAGE_DIR/usr/share/applications/alacritty.desktop" << EOF
[Desktop Entry]
Type=Application
TryExec=alacritty
Exec=alacritty
Icon=Alacritty
Terminal=false
Categories=System;TerminalEmulator;

Name=Alacritty
GenericName=Terminal
Comment=A fast, cross-platform, OpenGL terminal emulator
StartupNotify=true
StartupWMClass=Alacritty
Actions=New;

[Desktop Action New]
Name=New Terminal
Exec=alacritty
EOF

chmod 755 "$PACKAGE_DIR/usr/bin/alacritty"
chmod -R 755 "$PACKAGE_DIR/DEBIAN"
find "$PACKAGE_DIR" -type d -exec chmod 755 {} \;

dpkg-deb --build "$PACKAGE_DIR"
mv "${PACKAGE_DIR}.deb" "alacritty_${VERSION#v}_${ARCH}.deb"
