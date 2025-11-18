<#
    Author: Yash Burshe
    Date: 11/17/2025
    License: MIT
#>

$currentPSVersion = $PSVersionTable.PSVersion | Select-Object -ExpandProperty Major

$dotfiles = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "Current PowerShell Major Version: $currentPSVersion"

function InstallPowerShell() {
    Write-Host "Installing PowerShell"
    winget install --id Microsoft.PowerShell --source winget
    Write-Host "Latest PowerShell installed. Please open it and run this script "
    exit
}

if($currentPSVersion -lt 7) {
    Write-Host "This script requires minimum PowerShell verison 7 to run"
    $IsInstallPowerShell = Read-Host "Would you like to install the latest PowerShell from winget? [Y/N]"
    switch ($IsInstallPowerShell) {
        "Y" { InstallPowerShell }
        "N" { exit }
    }
}

Write-Host "Installing Visual Studio Code"

winget install --id Microsoft.VisualStudioCode --source winget

Write-Host "Installing Visual Studio Code Extensions"

code --install-extension ms-python.autopep8
code --install-extension esbenp.prettier-vscode
code --install-extension enkia.tokyo-night

Write-Host "Installing Git for Windows"

winget install --id Git.Git -e --source winget --custom "/LOADINF=$dotfiles\git\git_options.ini"

Write-Host "Git Installed. Please make sure to set the config using`ngit config --global user.email`ngit config --global user.name"

Write-Host "Installing Microsoft Terminal"

winget install --id Microsoft.WindowsTerminal --source winget

Write-Host "Installing Oh-My-Posh"

winget install --id JanDeDobbeleer.OhMyPosh --source winget

Write-Host "Finished Installing Applications"

Write-Host "Installing dotfiles"

function CreateLink($Source, $Target) {
    if(Test-Path $Target) {
        Write-Host "$Target already exists, creating a backup $Target.bak"
        Move-Item $Target "$Target.bak" -Force
    } else {
        New-Item -ItemType Directory -Force -Path (Split-Path $Target)
    }

    Write-Host "Creating Link $Target to $Source"
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force
}

$pwshProfile = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
CreateLink "$dotfiles\powershell\Microsoft.PowerShell_profile.ps1" $pwshProfile

$ompTheme = "$env:USERPROFILE\mina.omp.json"
CreateLink "$dotfiles\powershell\mina.omp.json" $ompTheme

$vscodeSettings = "$env:USERPROFILE\AppData\Roaming\Code\User\settings.json"
CreateLink "$dotfiles\vscode\settings.json" $vscodeSettings

$terminalSettings = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
CreateLink "$dotfiles\terminal\settings.json" $terminalSettings