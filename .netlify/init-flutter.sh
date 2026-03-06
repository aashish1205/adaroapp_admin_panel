#!/usr/bin/env bash
set -e

FLUTTER_DIR="/opt/buildhome/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
  git clone --depth 1 https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter --version

flutter pub get

flutter build web --no-tree-shake-icons