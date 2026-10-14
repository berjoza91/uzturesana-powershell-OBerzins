$sakne = Split-Path -Parent $PSScriptRoot
$izvadesFails = Join-Path $PSScriptRoot "izvade.txt"

$uzdevumi = @(
    @{ Nr = 1; Nosaukums = "Sistēmas apraksts"; Mape = "01" }
    @{ Nr = 3; Nosaukums = "Servisu skaitīšana"; Mape = "03" }
    @{ Nr = 5; Nosaukums = "Sistēmas žurnāla kļūdas"; Mape = "05" }
    @{ Nr = 7; Nosaukums = "Diska vieta"; Mape = "07" }
)

$kopsavilkums = foreach ($uzdevums in $uzdevumi) {
    $skriptaFails = Join-Path $sakne (
        "$($uzdevums.Mape)\skripts.ps1"
    )

    "========================================"
    "Uzdevums $($uzdevums.Nr): $($uzdevums.Nosaukums)"
    "========================================"

    if (Test-Path $skriptaFails) {
        try {
            & $skriptaFails 2>&1 | Out-String
        }
        catch {
            "Kļūda: $($_.Exception.Message)"
        }
    }
    else {
        "Nav atrasts skripts: $skriptaFails"
    }
}

$kopsavilkums |
    Set-Content -Path $izvadesFails -Encoding UTF8

Get-Content $izvadesFails
Write-Output "Kopsavilkums saglabāts: $izvadesFails"
