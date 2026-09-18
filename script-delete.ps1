$actualYear = (Get-Date).Year
$rutaBase = "C:\RappiPay\CO"

$RutaCarpetaDelete = Join-Path -Path $RutaBase -ChildPath "$actualYear\*"

$LogDir = "C:\delate-script\logs"
$RutaArchivoEvidencia = Join-Path -Path $LogDir -ChildPath "logs.txt"

$SDeleteExe = "C:\sdelete\sdelete.exe"

if (-not (Test-Path -Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
}

$fechaHora = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$responsable   = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name


if (Test-Path -Path $RutaCarpetaDelete) {
    try {
        & $SDeleteExe -s -p 3 -accepteula -nobanner $RutaCarpetaDelete

        if ($LASTEXITCODE -ne 0) { throw "sdelete finalizó con código de error $LASTEXITCODE" }
        
        $LogData = "[EXITO] - Fecha/Hora: $fechaHora - Ejecutado por: $responsable - Detalle: La carpeta '$RutaCarpetaDelete' fue eliminada con exito."
        Write-Host $LogData -ForegroundColor Green
    }
    catch {
        $LogData = "[ERROR] - Fecha/Hora: $fechaHora - Ejecutado por: $responsable - Detalle: Fallo al eliminar '$RutaCarpetaDelete'. Razon: $_"
        Write-Host $LogData -ForegroundColor Red
    }
} else {
    $LogData = "[ADVERTENCIA] - Fecha/Hora: $fechaHora - Ejecutado por: $responsable   - Detalle: No se ejecuto el borrado porque la ruta '$RutaCarpetaDelete' no existe."
    Write-Host $LogData -ForegroundColor Yellow
}


Add-Content -Path $RutaArchivoEvidencia -Value @($LogData, "")