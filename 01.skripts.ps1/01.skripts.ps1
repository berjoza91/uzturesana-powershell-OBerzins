$os = Get-CimInstance -ClassName Win32_OperatingSystem
$procesi = Get-Process
$atmina = $procesi.Count
$palaidesLaiks = $os.LastBootUpTime

Write-Output "Datora nosaukums: $env:COMPUTERNAME"
Write-Output "Operētājsistēma: $($os.Caption)"
Write-Output "Būvējuma numurs: $($os.BuildNumber)"
Write-Output "PowerShell versija: $($PSVersionTable.PSVersion)"
Write-Output "Pēdējās palaišanas laiks: $palaidesLaiks"
Write-Output "Pašlaik darbojas procesu skaits: $atmina"