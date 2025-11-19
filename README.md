# Dotfiles

Dotfiles for my personal Windows 11 setup. If you want to use the script, please fork the repository, adjust the configuration files and then replace `yashburshe` to your GitHub username in the command in the Installation section.

## Requirements

- PowerShell 7
- Running this script involves creating symbolic links. As stated by Microsoft [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.5#:~:text=HardLink-,Note,-Creating%20a%20SymbolicLink), "Creating a SymbolicLink type on Windows requires elevation as administrator. However, Windows 10 (build 14972 or newer) with Developer Mode enabled no longer requires elevation creating symbolic links.".

## Installation

Run the following in PowerShell

```powershell
irm "https://raw.githubusercontent.com/yashburshe/dotfiles/main/setup.ps1" | iex
```

The script does the following:
- Downloads and unpacks a zip of this repository into `$USERPROFILE\dotfiles`
- Installs the required applications. A list can be found below.
- Sets up symbolic links from `$USERPROFILE\dotfiles` to the respective application config locations

## Applications

The following applications are installed:
- Visual Studio Code
- Git for Windows (Options for the installer can be found in `git/git_options.ini`)
- Microsoft Terminal
- Oh-My-Posh