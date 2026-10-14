$servisi = Get-Service

$darbojas = 0
$aptureti = 0
$kopejais = 0

foreach ($serviss in $servisi) {
    $kopejais++

    if ($serviss.Status -eq "Running") {
        $darbojas++
    }
    elseif ($serviss.Status -eq "Stopped") {
        $aptureti++
    }
}

Write-Output "Kopējais servisu skaits: $kopejais"
Write-Output "Darbojas: $darbojas"
Write-Output "Apturēti: $aptureti"

if (($darbojas + $aptureti) -eq $kopejais) {
    Write-Output "Pārbaude: skaits sakrīt."
}
else {
    Write-Output "Pārbaude: skaits nesakrīt."
    Write-Output "Dažiem servisiem var būt cits statuss."
}