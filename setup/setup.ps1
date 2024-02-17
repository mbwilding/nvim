# Install software packages using winget
winget install Neovim.Neovim Kitware.CMake zig.zig BurntSushi.ripgrep.MSVC OpenJS.NodeJS JesseDuffield.lazygit JanDeDobbeleer.OhMyPosh

# Define the path for the PowerShell profile
$PowerShellProfile = "$env:UserProfile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$OMPLine = "oh-my-posh init pwsh | Invoke-Expression"

# Create PowerShell profile if it does not exist
if (-not (Test-Path $PowerShellProfile)) {
    Write-Host "Creating PowerShell Profile..."
    New-Item -Path $PowerShellProfile -ItemType File
}

# Check if oh-my-posh is already initialized in the profile
Write-Host "Checking if oh-my-posh is already initialized in the profile..."
$profileContent = Get-Content $PowerShellProfile

if ($profileContent -notcontains $OMPLine) {
    Write-Host "Adding oh-my-posh init to the profile..."
    Add-Content -Path $PowerShellProfile -Value $OMPLine
} else {
    Write-Host "oh-my-posh is already initialized in the profile."
}

Write-Host "Done."
