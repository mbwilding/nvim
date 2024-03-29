$ErrorActionPreference = "Stop"

$fontPath = $env:USERPROFILE\AppData\Local\Microsoft\Windows\Fonts
New-Item -ItemType Directory -Force -Path $fontPath
Push-Location -Path $env:USERPROFILE\AppData\Local\Microsoft\Windows\Fonts
Remove-Item -Path NeoSpleen*.ttf -Force
Invoke-WebRequest -Uri "https://github.com/mbwilding/NeoSpleen/releases/latest/download/NeoSpleen-NerdFont.ttf" -OutFile "NeoSpleen-NerdFont.ttf"
Pop-Location
