$PackageFile = ".\SecureSecrets.sws"
$Repository  = "DataFlex-dev/SecureSecrets"

$content = Get-Content $PackageFile -Raw

if ($content -match '"version"\s*:\s*"(\d+)\.(\d+)\.(\d+)"')
{
    $newVersion = "$($matches[1]).$($matches[2]).$([int]$matches[3] + 1)"

    $content = $content -replace `
        '"version"\s*:\s*"\d+\.\d+\.\d+"',
        "`"version`": `"$newVersion`""

    Set-Content $PackageFile $content

    Write-Host "New version: $newVersion"
}

df-cli package push -y $PackageFile $Repository