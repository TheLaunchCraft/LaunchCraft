$ErrorActionPreference = "Stop"

$IP = "##SERVER IP WITHHELD FROM GITHUB##"
$server = "\LaunchCraft\"
$backServerFolder = "$IP\users\$env:username"
$serverMap = "T:"
$installed = "$env:appdata\.minecraft"
$V = "A01.2"
$name = "Minecraft Launcher $V"

Write-Host $name
Clear-Host

Write-Host ""
Write-Host "Please make sure you have nothing is mapped to the T drive."
Write-Host "This launcher uses this drive because it's at the center of the"
Write-Host "letters and we think this letter wouldn't be used for anything else."
Write-Host ""
Write-Host "If you're ready!"
Pause

while ($true) {
    Write-Host ""
    Write-Host "Is there a server?"
    Write-Host ""
    if (Test-Path -Path "$serverMap\is-server.txt") {
        break
    } else {
        Clear-Host
        Write-Host "Checking of the version failed."
        Write-Host "This could be due to not being connected to the internet."
        Write-Host "Please check your internet connection and try again."
        Write-Host "After checking your connection, press any key to continue..."
        Pause
    }
}

while ($true) {
    Clear-Host
    Write-Host "Checking version"
    if (Test-Path -Path "$serverMap\$V.txt") {
        Write-Host "Match"
        break
    } else {
        Clear-Host
        Write-Host "Getting the new launcher version."
        Write-Host ""
        if (Test-Path -Path "$serverMap\update.zip") {
            break
        } else {
            Clear-Host
            Write-Host "Checking for updates failed."
            Write-Host "This could be due to a connection problem to the internet or an issue with our update server."
            Write-Host "Please check your internet connection and try again."
            Write-Host "After checking your connection, press any key to continue..."
            Pause
        }
    }
}

Clear-Host
& "$serverMap\update.bat"

Clear-Host

$backupFolder = "$serverMap\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))"

$authResult = New-PSDrive -Name "ServerMap" -PSProvider "FileSystem" -Root $backServerFolder -Persist -Credential (Get-Credential -UserName "auth" -Message "Enter your credentials")
if ($authResult) {
    if (Test-Path -Path "$serverMap\auth.txt") {
        Write-Host "Authorised"
    } else {
        if (!(Test-Path -Path "$serverMap\logs")) {
            New-Item -Path "$serverMap\logs" -ItemType Directory | Out-Null
        }
        Out-File -FilePath "$serverMap\logs\backup-started--$env:computername-$((Get-Date).ToString('MM-dd-yy')).txt" -Force
        $null = New-Item -Path "$serverMap\worlds" -ItemType Directory
        $null = New-Item -Path "$serverMap\worlds\$((Get-Date).ToString('yyyy'))" -ItemType Directory
        $null = New-Item -Path "$serverMap\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))" -ItemType Directory
        $null = New-Item -Path "$serverMap\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))" -ItemType Directory
        Copy-Item -Path "$installed\saves\*" -Destination $backupFolder -Recurse -Force -ErrorAction SilentlyContinue
        Out-File -FilePath "$serverMap\logs\backup-finished--$env:computername-$((Get-Date).ToString('MM-dd-yy')).txt" -Force
    }
    Remove-PSDrive -Name "ServerMap" -Force
} else {
    $null = New-Item -Path "C:\Minecraft\worlds" -ItemType Directory
    $null = New-Item -Path "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))" -ItemType Directory
    $null = New-Item -Path "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))" -ItemType Directory
    $null = New-Item -Path "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))" -ItemType Directory
    Copy-Item -Path "$installed\saves\*" -Destination "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))" -Recurse -Force -ErrorAction SilentlyContinue
}

Clear-Host
if (!(Test-Path -Path "C:\Program Files (x86)\Minecraft\MinecraftLauncher.exe")) {
    Write-Host ""
    Write-Host "Minecraft is not installed,"
    Write-Host "please install it from the Minecraft"
    Write-Host "website or copy this link."
    Write-Host ""
    Write-Host "https://launcher.mojang.com/download/MinecraftInstaller.msi"
    Write-Host ""
    Write-Host "Launch will exit after you press any key."
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Pause
    exit
} else {
    Start-Process -FilePath "C:\Program Files (x86)\Minecraft\MinecraftLauncher.exe"
    Write-Host "Starting Minecraft... Only close this when you've finished playing!"
    Write-Host "As this will stop the worlds from backing up."
    Pause
    goto run-backup
}

:run-backup
Clear-Host
Write-Host "Running backup..."

$null = New-PSDrive -Name "ServerMap" -PSProvider "FileSystem" -Root $backServerFolder -Persist -Credential (Get-Credential -UserName "auth" -Message "Enter your credentials")
if ($authResult) {
    if (Test-Path -Path "$serverMap\auth.txt") {
        Write-Host "Authorised"
    } else {
        if (!(Test-Path -Path "$serverMap\logs")) {
            New-Item -Path "$serverMap\logs" -ItemType Directory | Out-Null
        }
        Out-File -FilePath "$serverMap\logs\backup-started--$env:computername-$((Get-Date).ToString('MM-dd-yy')).txt" -Force
        $null = New-Item -Path "$serverMap\worlds" -ItemType Directory
        $null = New-Item -Path "$serverMap\worlds\$((Get-Date).ToString('yyyy'))" -ItemType Directory
        $null = New-Item -Path "$serverMap\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))" -ItemType Directory
        $null = New-Item -Path "$serverMap\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))" -ItemType Directory
        Copy-Item -Path "$installed\saves\*" -Destination $backupFolder -Recurse -Force -ErrorAction SilentlyContinue
        Out-File -FilePath "$serverMap\logs\backup-finished--$env:computername-$((Get-Date).ToString('MM-dd-yy')).txt" -Force
    }
    Remove-PSDrive -Name "ServerMap" -Force
} else {
    $null = New-Item -Path "C:\Minecraft\worlds" -ItemType Directory
    $null = New-Item -Path "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))" -ItemType Directory
    $null = New-Item -Path "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))" -ItemType Directory
    $null = New-Item -Path "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))" -ItemType Directory
    Copy-Item -Path "$installed\saves\*" -Destination "C:\Minecraft\worlds\$((Get-Date).ToString('yyyy'))\$((Get-Date).ToString('MM'))\$((Get-Date).ToString('dd'))" -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Backup complete."
Exit