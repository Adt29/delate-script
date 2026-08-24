$actualYear = (Get-Date).Year
$rutaBase = "C:\RappiPay\CO" #TODO: debo cambiar la ruta ya que puse una random para pruebas (esperando que gabriela me mande la ruta exacta)  C:/RappiPay/CO/2026/Mes/dia -  Local Disk (C:) / RappiPay / CO/ 2026/ Mes/ día

$RutaCarpetaDelate = Join-Path -Path $RutaBase -ChildPath "$actualYear\*"

$LogDir = "C:\delate-script\logs"
$RutaArchivoEvidencia = Join-Path -Path $LogDir -ChildPath "logs.txt"

# Crear la carpeta de logs si no existe
if (-not (Test-Path -Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
}

$fechaHora = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$responsable   = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name


if (Test-Path -Path $RutaCarpetaDelate) {
    try {
        Remove-Item -Path $RutaCarpetaDelate -Recurse -Force -ErrorAction Stop
        
        $LogData = "[EXITO] - Fecha/Hora: $fechaHora - Ejecutado por: $responsable - Detalle: La carpeta '$RutaCarpetaDelate' fue eliminada con exito."
        Write-Host $LogData -ForegroundColor Green
    }
    catch {
        $LogData = "[ERROR] - Fecha/Hora: $fechaHora - Ejecutado por: $responsable - Detalle: Fallo al eliminar '$RutaCarpetaDelate'. Razon: $_"
        Write-Host $LogData -ForegroundColor Red
    }
} else {
    $LogData = "[ADVERTENCIA] - Fecha/Hora: $fechaHora - Ejecutado por: $responsable   - Detalle: No se ejecuto el borrado porque la ruta '$RutaCarpetaDelate' no existe."
    Write-Host $LogData -ForegroundColor Yellow
}


Add-Content -Path $RutaArchivoEvidencia -Value @($LogData, "")  #aqui se va agregar los mensajes al log.txt