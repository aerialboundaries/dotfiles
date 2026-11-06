# エラー時にスクリプトを停止する
$ErrorActionPreference = "Stop"

# Windowsのパスを取得
$WinLocalAppData = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { "C:\Users\$env:USERNAME\AppData\Local" }
$WinAppData = if ($env:APPDATA) { $env:APPDATA } else { "C:\Users\$env:USERNAME\AppData\Roaming" }

# ホームディレクトリのパスを取得
$HomeDir = $env:USERPROFILE

# 各ターゲットパス
$TargetBashrc = "$HomeDir\.bashrc"
$TargetNvim = "$WinLocalAppData\nvim"
$TargetYaziConfig = "$WinAppData\yazi\config"
$TargetAlacritty = "$WinAppData\alacritty"

# 各リンク元のパス (dotfilesの場所)
$DotfilesHome = "$HomeDir\dotfiles"

Write-Host "=== Windows環境向け シンボリックリンク作成開始 ===" -ForegroundColor Cyan

# 1. .bashrc (ファイルリンク)
if (Test-Path $TargetBashrc) {
    Remove-Item -Path $TargetBashrc -Force
}
New-Item -ItemType SymbolicLink -Path $TargetBashrc -Value "$DotfilesHome\windows\.bashrc_win" | Out-Null
Write-Host "[✓] .bashrc のリンクを作成しました。" -ForegroundColor Green

# 2. Neovim (ディレクトリリンク)
if (Test-Path $TargetNvim) {
    Remove-Item -Path $TargetNvim -Recurse -Force
}
New-Item -ItemType SymbolicLink -Path $TargetNvim -Value "$DotfilesHome\nvim" | Out-Null
Write-Host "[✓] Neovim のリンクを作成しました。" -ForegroundColor Green

# 3. Yazi config (ディレクトリリンク)
$YaziParent = "$WinAppData\yazi"
if (-not (Test-Path $YaziParent)) {
    New-Item -ItemType Directory -Path $YaziParent -Force | Out-Null
}
if (Test-Path $TargetYaziConfig) {
    Remove-Item -Path $TargetYaziConfig -Recurse -Force
}
New-Item -ItemType SymbolicLink -Path $TargetYaziConfig -Value "$DotfilesHome\windows\yazi\config" | Out-Null
Write-Host "[✓] Yazi のリンクを作成しました。" -ForegroundColor Green

# 4. Alacritty (ディレクトリリンク)
if (Test-Path $TargetAlacritty) {
    Remove-Item -Path $TargetAlacritty -Recurse -Force
}
New-Item -ItemType SymbolicLink -Path $TargetAlacritty -Value "$DotfilesHome\windows\alacritty" | Out-Null
Write-Host "[✓] Alacritty のリンクを作成しました。" -ForegroundColor Green

Write-Host "すべてのセットアップが完了しました！" -ForegroundColor Cyan
