$robezaGB = 10

$diski = Get-CimInstance -ClassName Win32_LogicalDisk |
    Where-Object { $_.DriveType -eq 3 }

foreach ($disks in $diski) {
    $kopejaisGB = [math]::Round(
        $disks.Size / 1GB, 2
    )

    $brivaVietaGB = [math]::Round(
        $disks.FreeSpace / 1GB, 2
    )

    Write-Output "Disks: $($disks.DeviceID)"
    Write-Output "Kopējais izmērs: $kopejaisGB GB"
    Write-Output "Brīvā vieta: $brivaVietaGB GB"

    if ($brivaVietaGB -lt $robezaGB) {
        Write-Output "BRĪDINĀJUMS: diskā ir maz brīvas vietas!"
    }
    else {
        Write-Output "Brīvās vietas ir pietiekami."
    }

    Write-Output "-----------------------------"
}