[CmdletBinding(SupportsShouldProcess = $true)]
param()

$servisi = Get-CimInstance -ClassName Win32_Service |
    Where-Object {
        $_.StartMode -eq "Auto" -and
        $_.State -eq "Stopped"
    }

if ($servisi.Count -eq 0) {
    Write-Output "Nav apturētu automātisko servisu."
}
else {
    foreach ($serviss in $servisi) {
        Write-Output "Atrasts: $($serviss.Name)"

        if ($PSCmdlet.ShouldProcess(
            $serviss.Name,
            "Palaist servisu"
        )) {
            try {
                Start-Service -Name $serviss.Name -ErrorAction Stop
                Write-Output "Palaišanas komanda izpildīta."
            }
            catch {
                Write-Output "Neizdevās palaist: $($serviss.Name)"
                Write-Output "Iemesls: $($_.Exception.Message)"
            }
        }
    }
}
