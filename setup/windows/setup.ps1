$ErrorActionPreference = "Stop"

winget install Neovim Kitware.CMake zig.zig BurntSushi.ripgrep.MSVC OpenJS.NodeJS JesseDuffield.lazygit JanDeDobbeleer.OhMyPosh Golang.Go JernejSimoncic.Wget GnuWin32.UnZip GnuWin32.Zip 7zip.7zip python3 RubyInstallerTeam.RubyWithDevKit.3.2 StrawberryPerl.StrawberryPerl jqlang.jq mbuilov.sed Microsoft.PowerShell

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# pip install cfn-lint
# gem install cfn-nag

Write-Host "Done"
