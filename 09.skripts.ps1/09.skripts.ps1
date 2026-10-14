$izvadesFails = Join-Path $PSScriptRoot "izvade.txt"

$rezultati = foreach ($process in (Get-CimInstance Win32_Process)) {
    try {
        $owner = Invoke-CimMethod -InputObject $process `
            -MethodName GetOwner -ErrorAction Stop

        if ($owner.ReturnValue -eq 0) {
            [PSCustomObject]@{
                Process = $process.Name
                ID      = $process.ProcessId
                Lietotajs = "$($owner.Domain)\$($owner.User)"
                Kluda   = ""
            }
        }
        else {
            [PSCustomObject]@{
                Process = $process.Name
                ID      = $process.ProcessId
                Lietotajs = "Nav pieejams"
                Kluda   = "GetOwner kods: $($owner.ReturnValue)"
            }
        }
    }
    catch {
        [PSCustomObject]@{
            Process = $process.Name
            ID      = $process.ProcessId
            Lietotajs = "Nav pieejams"
            Kluda   = $_.Exception.Message
        }
    }
}

$rezultati |
    Format-Table -AutoSize |
    Out-String -Width 240 |
    Tee-Object -FilePath $izvadesFails

$nepieejami = @(
    $rezultati | Where-Object { $_.Lietotajs -eq "Nav pieejams" }
).Count

Write-Output "Kopējais procesu skaits: $($rezultati.Count)"
Write-Output "Procesi, kuru īpašnieks nav noskaidrots: $nepieejami"