# Install software packages using winget
winget install Neovim.Neovim Kitware.CMake zig.zig BurntSushi.ripgrep.MSVC OpenJS.NodeJS JesseDuffield.lazygit JanDeDobbeleer.OhMyPosh Golang.Go JernejSimoncic.Wget GnuWin32.UnZip GnuWin32.Zip 7zip.7zip Python.Python.3.12 RubyInstallerTeam.RubyWithDevKit.3.2

pip install cfn-lint
gem install cfn-nag

# Define the path for the PowerShell profile
$PowerShellDir = "$env:UserProfile\Documents\PowerShell"
$PowerShellProfile = "$PowerShellDir\Microsoft.PowerShell_profile.ps1"
$OMPLine = "oh-my-posh init pwsh | Invoke-Expression"

# Ensure the PowerShell directory exists
if (-not (Test-Path $PowerShellDir)) {
    Write-Host "Creating PowerShell Directory..."
    New-Item -Path $PowerShellDir -ItemType Directory
}

# Create PowerShell profile if it does not exist
if (-not (Test-Path $PowerShellProfile)) {
    Write-Host "Creating PowerShell Profile..."
    New-Item -Path $PowerShellProfile -ItemType File
}

# Check if oh-my-posh is already initialized in the profile
Write-Host "Checking if oh-my-posh is already initialized in the profile..."
$profileContent = @()
if (Test-Path $PowerShellProfile) {
    $profileContent = Get-Content $PowerShellProfile
}

if ($profileContent -notcontains $OMPLine) {
    Write-Host "Adding oh-my-posh init to the profile..."
    Add-Content -Path $PowerShellProfile -Value $OMPLine
} else {
    Write-Host "oh-my-posh is already initialized in the profile."
}

Write-Host "Done."
