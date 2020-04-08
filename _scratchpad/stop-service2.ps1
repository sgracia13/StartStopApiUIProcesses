#Possible solution to catch process by adding notepropertyname
$RunningApis = @()
$CompanyApi = Start-Process -FilePath 'dotnet' -WorkingDirectory $url.CompanyApi.Path -ArgumentList 'watch run' -PassThru
$CompanyApi | Add-Member -NotePropertyName "ApiName" -NotePropertyValue "CompanyApi"

$RunningApis += $CompanyApi

$ApiToStop = "Company Api"
$RunningApis | Where-Object { $_.ApiName -eq "$ApiToStop" } | Stop-Process
