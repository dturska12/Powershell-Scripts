param(
    [Parameter(Mandatory=$true)][string]$ListFilePath,
    [Parameter(Mandatory=$true)][string]$OutputFolderPath
)

if (-not (Test-Path $ListFilePath)) {
    Write-Error "The specified list file does not exist: $ListFilePath"
    exit 1
}

if (-not (Test-Path $OutputFolderPath)) {
    Write-Error "The specified output folder does not exist: $OutputFolderPath"
    exit 1
}

$fileList = Get-Content $ListFilePath

foreach ($file in $fileList) {
    $jsonFilePath = Join-Path -Path $OutputFolderPath -ChildPath "$file.json"
    $emptyJsonObject = @{}
    $emptyJsonObject | ConvertTo-Json | Set-Content $jsonFilePath
    Write-Output "Created JSON file: $jsonFilePath"
}
