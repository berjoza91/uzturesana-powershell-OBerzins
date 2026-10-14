$csvFails = Join-Path $PSScriptRoot "draiveri.csv"
$izvadesFails = Join-Path $PSScriptRoot "izvade.txt"

try {
    $draiveri = @(
        Get-CimInstance -ClassName Win32_PnPSignedDriver |
        Where-Object {
            $_.DriverProviderName -and
            $_.DriverProviderName -ne "Microsoft"
        } |
        Select-Object DeviceName, DriverProviderName,
            DriverVersion, InfName
    )

    $draiveri | Export-Csv -Path $csvFails `
        -NoTypeInformation -Encoding UTF8

    $csvRindas = @(
        Import-Csv -Path $csvFails
    )

    "CSV datu rindu skaits: $($csvRindas.Count)" |
        Set-Content -Path $izvadesFails -Encoding UTF8

    Write-Output "CSV fails: $csvFails"
    Write-Output "Datu rindu skaits: $($csvRindas.Count)"
}
catch {
    Write-Output "Radās kļūda: $($_.Exception.Message)"
}
