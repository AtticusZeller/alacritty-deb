#!/bin/bash
set -e

VERSION=$(cat version.txt)
ARCH=$(dpkg --print-architecture)

# 创建打包目录结构
PACKAGE_DIR="alacritty-package"
mkdir -p "$PACKAGE_DIR/DEBIAN"
mkdir -p "$PACKAGE_DIR/usr/bin"
mkdir -p "$PACKAGE_DIR/usr/share/applications"
mkdir -p "$PACKAGE_DIR/usr/share/pixmaps"

# 复制二进制文件
cp alacritty/target/release/alacritty "$PACKAGE_DIR/usr/bin/"

# 复制图标
cp alacritty/extra/logo/alacritty-term.svg "$PACKAGE_DIR/usr/share/pixmaps/Alacritty.svg"

# 生成 control 文件
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

# 生成桌面文件
cat > "$PACKAGE_DIR/usr/share/applications/alacritty.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Alacritty
Comment=A GPU-accelerated terminal emulator
Exec=alacritty
Icon=Alacritty
Terminal=false
Categories=System;TerminalEmulator;
EOF

# 设置权限
chmod 755 "$PACKAGE_DIR/usr/bin/alacritty"
chmod -R 755 "$PACKAGE_DIR/DEBIAN"
find "$PACKAGE_DIR" -type d -exec chmod 755 {} \;

# 构建 deb 包
dpkg-deb --build "$PACKAGE_DIR"
mv "${PACKAGE_DIR}.deb" "alacritty_${VERSION#v}_${ARCH}.deb"