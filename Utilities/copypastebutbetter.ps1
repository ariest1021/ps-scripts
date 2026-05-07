# =========================
# CONFIGURATION
# =========================
$sevenZipPath = "7zip PATH"
$sourceFolder = "SOURCE_FOLDER"
$stagingFolder = "STAGING_FOLDER"
$destinationFolder = "DESTINATION_FOLDER"

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$archiveName = "Backup_$timestamp.7z"
$archivePath = Join-Path $stagingFolder $archiveName

# =========================
# PREP FOLDERS
# =========================
if (!(Test-Path $stagingFolder)) {
    New-Item -ItemType Directory -Path $stagingFolder | Out-Null
}
if (!(Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# =========================
# STEP 1: COMPRESS WITH 7-ZIP
# =========================
Write-Host "Starting compression with 7-Zip..." -ForegroundColor Cyan

& $sevenZipPath a -mx0 -mmt=on -ms=off $archivePath $sourceFolder
$exit = $LASTEXITCODE

if ($exit -ne 0) {
    Write-Host "7-Zip failed with exit code $exit" -ForegroundColor Red
    exit 1
}

Write-Host "Compression complete: $archivePath" -ForegroundColor Green

# =========================
# STEP 2: MOVE WITH ROBOCOPY
# =========================
Write-Host "Moving archive to SSD..." -ForegroundColor Cyan

& robocopy $stagingFolder $destinationFolder $archiveName /Z /J /R:1 /W:1
$exit = $LASTEXITCODE

if ($exit -ge 8) {
    Write-Host "Robocopy failed with code $exit" -ForegroundColor Red
    exit 1
}

Write-Host "Transfer complete!" -ForegroundColor Green

# =========================
# CLEANUP
# =========================
$destFile = Join-Path $destinationFolder $archiveName

if (Test-Path $destFile) {
    $sourceSize = (Get-Item $archivePath).Length
    $destSize = (Get-Item $destFile).Length

    if ($sourceSize -eq $destSize) {
        Remove-Item $archivePath -Force
        Write-Host "Staging file cleaned up." -ForegroundColor Gray
    } else {
        Write-Host "Size mismatch - NOT deleting staging file!" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "Done. Backup successful." -ForegroundColor Green
