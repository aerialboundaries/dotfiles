@echo off
chcp 65001 >nul
echo === Windows環境向け シンボリックリンク作成開始 ===

:: 1. .bashrc のリンク (Git Bash用)
if exist "%USERPROFILE%\.bashrc" del "%USERPROFILE%\.bashrc"
mklink "%USERPROFILE%\.bashrc" "%USERPROFILE%\dotfiles\windows\.bashrc_win"
echo [✓] .bashrc のリンクを作成しました。

:: 2. Neovim 設定のリンク
if not exist "%LOCALAPPDATA%\nvim" mkdir "%LOCALAPPDATA%\nvim"
if exist "%LOCALAPPDATA%\nvim" rmdir "%LOCALAPPDATA%\nvim"
mklink /d "%LOCALAPPDATA%\nvim" "%USERPROFILE%\dotfiles\nvim"
echo [✓] Neovim のリンクを作成しました。

:: 3. Yazi 設定のリンク
if not exist "%APPDATA%\yazi" mkdir "%APPDATA%\yazi"
if exist "%APPDATA%\yazi" rmdir "%APPDATA%\yazi"
mklink /d "%APPDATA%\yazi" "%USERPROFILE%\dotfiles\windows\yazi"
echo [✓] Yazi のリンクを作成しました。

:: 4. Alacritty 設定のリンク
if not exist "%APPDATA%\alacritty" mkdir "%APPDATA%\alacritty"
if exist "%APPDATA%\alacritty" rmdir "%APPDATA%\alacritty"
mklink /d "%APPDATA%\alacritty" "%USERPROFILE%\dotfiles\windows\alacritty"
echo [✓] Alacritty のリンクを作成しました。

echo.
echo すべてのセットアップが完了しました！
pause
