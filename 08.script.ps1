$izvadesFails = Join-Path $PSScriptRoot "izvade.txt"

# Pirmais veids: Get-Service
$laiks1 = Measure-Command {
    $serviss1 = Get-Service -Name "Spooler"
}

# Otrais veids: CIM
$laiks2 = Measure-Command {
    $serviss2 = Get-CimInstance `
        -ClassName Win32_Service `
        -Filter "Name = 'Spooler'"
}

$rezultats = @(
    "1. metode: Get-Service"
    "Nosaukums: $($serviss1.Name)"
    "Statuss: $($serviss1.Status)"
    "Laiks: $($laiks1.TotalMilliseconds) ms"
    ""
    "2. metode: Get-CimInstance"
    "Nosaukums: $($serviss2.Name)"
    "Statuss: $($serviss2.State)"
    "Laiks: $($laiks2.TotalMilliseconds) ms"
)

$rezultats | Tee-Object -FilePath $izvadesFails

if ($laiks1.TotalMilliseconds -lt $laiks2.TotalMilliseconds) {
    "Ātrāka bija Get-Service metode." |
        Add-Content $izvadesFails
}
elseif ($laiks2.TotalMilliseconds -lt $laiks1.TotalMilliseconds) {
    "Ātrāka bija Get-CimInstance metode." |
        Add-Content $izvadesFails
}
else {
    "Abu metožu laiki bija vienādi." |
        Add-Content $izvadesFails
}
