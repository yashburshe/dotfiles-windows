<#
    Author: Yash Burshe
    Date: 11/17/2025
    License: MIT
#>

$dotfiles = Split-Path -Parent $MyInvocation.MyCommand.Definition

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