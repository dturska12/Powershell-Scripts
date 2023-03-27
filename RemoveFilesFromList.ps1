param(
    [Parameter(Mandatory=$true)][string]$FolderPath,
    [Parameter(Mandatory=$true)][string]$ListFilePath
)

if (-not (Test-Path $FolderPath)) {
    Write-Error "The specified folder does not exist: $FolderPath"
    exit 1
}

if (-not (Test-Path $ListFilePath)) {
    Write-Error "The specified list file does not exist: $ListFilePath"
    exit 1
}

$fileList = Get-Content $ListFilePath
$removedCount = 0

foreach ($file in $fileList) {
    $filePath = Join-Path -Path $FolderPath -ChildPath $file
    if (Test-Path $filePath) {
        Remove-Item $filePath -Force
        Write-Output "Removed: $filePath"
        $removedCount++
    } else {
        Write-Warning "File not found: $filePath"
    }
}

Write-Output "Total files removed: $removedCount"
