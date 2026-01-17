#!/usr/bin/env bash
set -euo pipefail

# このスクリプトは、生成済み keiba_viewer.html を docs/keiba_viewer.html にコピーしてコミットする補助です。

if [ ! -f "keiba_viewer.html" ]; then
  echo "[ERROR] keiba_viewer.html が見つかりません（リポジトリ直下で実行してください）"
  exit 1
fi

mkdir -p docs
cp -f keiba_viewer.html docs/keiba_viewer.html

git add docs/keiba_viewer.html docs/index.html
echo "[OK] docs/ に反映しました。次に commit / push してください。"
