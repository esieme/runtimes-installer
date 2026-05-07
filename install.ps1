# =====================================================
#  BOOTSTRAP - ULTIMATE RUNTIMES INSTALLER
#  Criado por: DEV - esieme
#  Instagram: @_esieme
#  GitHub: github.com/esieme
# =====================================================

# Verificar administrador
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ Execute como Administrador!" -ForegroundColor Red
    Write-Host "Feche e abra o PowerShell como Administrator" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "🚀 Baixando instalador principal..." -ForegroundColor Cyan

# URLs dos scripts (mude SEU-USUARIO para seu nome do GitHub)
$mainScriptUrl = "https://raw.githubusercontent.com/esieme/runtimes-installer/main/runtime-painel.ps1"
$tempScript = "$env:TEMP\runtime-painel.ps1"

try {
    Invoke-WebRequest -Uri $mainScriptUrl -OutFile $tempScript -UseBasicParsing -ErrorAction Stop
    Write-Host "✅ Download concluído!" -ForegroundColor Green
    
    Write-Host "🎮 Iniciando painel de instalação..." -ForegroundColor Magenta
    & $tempScript
    
    # Limpeza
    Remove-Item $tempScript -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "❌ Erro ao baixar o instalador: $_" -ForegroundColor Red
    Write-Host "`nVerifique se o repositório está público e os arquivos existem." -ForegroundColor Yellow
    pause
}