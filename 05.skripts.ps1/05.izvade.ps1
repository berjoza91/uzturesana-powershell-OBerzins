$sakums = (Get-Date).AddHours(-48)

try {
    $kludas = @(
        Get-WinEvent -FilterHashtable @{
            LogName   = "System"
            Level     = 2
            StartTime = $sakums
        } -ErrorAction Stop
    )

    Write-Output "Laika periods: no $sakums līdz $(Get-Date)"
    Write-Output "Kopējais kļūdu ierakstu skaits: $($kludas.Count)"

    $avoti = @{}

    foreach ($kluda in $kludas) {
        $avots = $kluda.ProviderName

        if ($avoti.ContainsKey($avots)) {
            $avoti[$avots]++
        }
        else {
            $avoti[$avots] = 1
        }
    }

    foreach ($avots in ($avoti.Keys | Sort-Object)) {
        Write-Output "$avots : $($avoti[$avots]) kļūdas"
    }
}
catch {
    Write-Output "Neizdevās nolasīt sistēmas žurnālu."
    Write-Output "Iemesls: $($_.Exception.Message)"
}
