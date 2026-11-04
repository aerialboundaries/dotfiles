#!/usr/bin/env bash

set -euo pipefail

# Windowsの環境変数を取得（未定義なら標準パスをフォールバック）
WIN_LOCALAPPDATA="${LOCALAPPDATA:-C:/Users/${USER}/AppData/Local}"
WIN_APPDATA="${APPDATA:-C:/Users/${USER}/AppData/Roaming}"

# cygpath が利用可能なら変換し、なければパス区切り文字を置換してフォールバック
to_unix_path() {
    local p="$1"
    if command -v cygpath >/dev/null 2>&1; then
        cygpath -u "$p"
    else
        # cygpathがない場合はバックスラッシュをスラッシュに置換し、ドライブレターを小文字化 (/c/...)
        echo "$p" | sed 's|\\|/|g' | sed -E 's|^([A-Za-z]):|/\L\1|'
    fi
}

TARGET_NVIM="$(to_unix_path "$WIN_LOCALAPPDATA")/nvim"
TARGET_YAZI="$(to_unix_path "$WIN_APPDATA")/yazi"
TARGET_ALACRITTY="$(to_unix_path "$WIN_APPDATA")/alacritty"

echo "=== Windows環境向け シンボリックリンク作成開始 ==="

# 1. .bashrc
ln -sf "$HOME/dotfiles/windows/.bashrc_win" "$HOME/.bashrc"
echo "[✓] .bashrc のリンクを作成しました。"

# 2. Neovim (AppData/Local/nvim)
mkdir -p "$(dirname "$TARGET_NVIM")"
ln -sf "$HOME/dotfiles/nvim" "$TARGET_NVIM"
echo "[✓] Neovim のリンクを作成しました。"

# 3. Yazi (AppData/Roaming/yazi)
mkdir -p "$(dirname "$TARGET_YAZI")"
ln -sf "$HOME/dotfiles/windows/yazi" "$TARGET_YAZI"
echo "[✓] Yazi のリンクを作成しました。"

# 4. Alacritty (AppData/Roaming/alacritty)
mkdir -p "$(dirname "$TARGET_ALACRITTY")"
ln -sf "$HOME/dotfiles/windows/alacritty" "$TARGET_ALACRITTY"
echo "[✓] Alacritty のリンクを作成しました。"

echo "すべてのセットアップが完了しました！"
