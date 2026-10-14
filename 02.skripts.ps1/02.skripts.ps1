$procesi = Get-Process |
    Sort-Object -Property WorkingSet64 -Descending |
    Select-Object -First 10

foreach ($process in $procesi) {
    $atminaMB = [math]::Round(
        $process.WorkingSet64 / 1MB, 2
    )

    Write-Output (
        "Nosaukums: {0}; ID: {1}; Atmiņa: {2} MB" -f
        $process.ProcessName,
        $process.Id,
        $atminaMB
    )
}