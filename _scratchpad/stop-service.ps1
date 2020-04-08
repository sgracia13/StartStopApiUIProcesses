
while ($isRunning)
{
    $ErrorActionPreference = 'SilentlyContinue'
    $ApiProcesses = $ApiProcesses | ForEach-Object { try { Get-Process -id $_.id } catch{} }

    if ($null -eq $ApiProcesses)
    {
        $ErrorActionPreference = 'Continue'
        $isRunning = $false
    }
}
