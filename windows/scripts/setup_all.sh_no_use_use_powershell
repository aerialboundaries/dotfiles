#!/usr/bin/env bash

set -euo pipefail

# 環境変数が未定義の場合のフォールバック処理
WIN_LOCALAPPDATA="${LOCALAPPDATA:-C:/Users/${USER}/AppData/Local}"
WIN_APPDATA="${APPDATA:-C:/Users/${USER}/AppData/Roaming}"

# Unix形式のパスへ変換
TARGET_NVIM="$(cygpath -u "$WIN_LOCALAPPDATA")/nvim"
TARGET_YAZI="$(cygpath -u "$WIN_APPDATA")/yazi"
TARGET_ALACRITTY="$(cygpath -u "$WIN_APPDATA")/alacritty"

echo "=== Windows環境向け シンボリックリンク作成開始 ==="

# 1. .bashrc
ln -sf "$HOME/dotfiles/windows/.bashrc_win" "$HOME/.bashrc"
echo "[✓] .bashrc のリンクを作成しました。"

# 2. Neovim (AppData/Local/nvim)
mkdir -p "$(dirname "$TARGET_NVIM")"
# すでに実ディレクトリや古いリンクが存在する場合は削除しておく
[ -e "$TARGET_NVIM" ] && rm -rf "$TARGET_NVIM"
ln -sf "$HOME/dotfiles/nvim" "$TARGET_NVIM"
echo "[✓] Neovim のリンクを作成しました。"

# 3. Yazi (AppData/Roaming/yazi/config)
mkdir -p "$TARGET_YAZI"
[ -e "$TARGET_YAZI/config" ] && rm -rf "$TARGET_YAZI/config"
ln -sfn "$HOME/dotfiles/windows/yazi/config" "$TARGET_YAZI/config"
echo "[✓] Yazi のリンクを作成しました。"

# 4. Alacritty (AppData/Roaming/alacritty)
mkdir -p "$(dirname "$TARGET_ALACRITTY")"
[ -e "$TARGET_ALACRITTY" ] && rm -rf "$TARGET_ALACRITTY"
ln -sf "$HOME/dotfiles/windows/alacritty" "$TARGET_ALACRITTY"
echo "[✓] Alacritty のリンクを作成しました。"

echo "すべてのセットアップが完了しました！"
