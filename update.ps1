$ErrorActionPreference = "Stop"

$IP = "##SERVER IP WITHHELD FROM GITHUB##"
$server = "\LaunchCraft\"
$backServerFolder = "##SERVER IP WITHHELD FROM GITHUB##\users\$env:username"
$serverMap = "T:"
$installed = "$env:appdata\.minecraft"
$LauncherVersion = "A01.2"
$V = "A01.0"
$name = "Launcher Updater $V"

Write-Host $name
Clear-Host

while ($true) {
    Clear-Host
    NET USE $serverMap /DELETE /Y
    NET USE $serverMap "$server\updates\" /P:No /user:launchcraft "##passwordwithheld##"
    Write-Host "Getting the new version, depending on your internet this could take a while."
    Write-Host "After it has completed, it will automatically continue!"
    $null = New-Item -Path "C:\Minecraft\updates" -ItemType Directory -Force
    Copy-Item -Path "$serverMap\update-$LauncherVersion.zip" -Destination "C:\Minecraft\updates" -Force -ErrorAction SilentlyContinue
    if ($?) {
        break
    }
    Start-Sleep -Seconds 10
}

Clear-Host
Expand-Archive -Path "C:\Minecraft\updates\update-$LauncherVersion.zip" -DestinationPath "C:\Minecraft" -Force
Remove-Item -Path "C:\Minecraft\updates\update-$LauncherVersion.zip" -Force
Move-Item -Path "C:\Minecraft\updates\*.*" -Destination "C:\Minecraft" -Force
Remove-Item -Path "C:\Minecraft\updates" -Force
Clear-Host
Exit