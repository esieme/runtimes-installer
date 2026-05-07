# =====================================================
#  ULTIMATE RUNTIMES INSTALLER - PAINEL PRINCIPAL
#  Criado por: DEV - esieme
#  Instagram: @_esieme
#  GitHub: github.com/esieme
# =====================================================

# Criar pasta temporária
$tempFolder = "$env:TEMP\RuntimeInstaller"
if (!(Test-Path $tempFolder)) { New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null }

# Função de instalação
function Install-Runtime {
    param($Name, $Url, $Args, $FileName)
    
    $filePath = "$tempFolder\$FileName"
    
    Write-Host "`n📦 Instalando: $Name" -ForegroundColor Yellow
    Write-Host "   ⏳ Baixando..." -ForegroundColor Gray
    
    try {
        Invoke-WebRequest -Uri $Url -OutFile $filePath -UseBasicParsing -ErrorAction Stop
        Write-Host "   ✅ Download concluído!" -ForegroundColor Green
        
        Write-Host "   ⚙️ Instalando..." -ForegroundColor Gray
        $process = Start-Process -FilePath $filePath -ArgumentList $Args -NoNewWindow -Wait -PassThru
        
        if ($process.ExitCode -eq 0 -or $process.ExitCode -eq 3010) {
            Write-Host "   ✅ $Name instalado com sucesso!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "   ⚠️ Código de saída: $($process.ExitCode)" -ForegroundColor Yellow
            return $false
        }
    } catch {
        Write-Host "   ❌ Falha: $_" -ForegroundColor Red
        return $false
    }
}

# Banner
Clear-Host
Write-Host @"

╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║     ██╗   ██╗██╗  ████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗
║     ██║   ██║██║  ╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝
║     ██║   ██║██║     ██║   ██║██╔████╔██║███████║   ██║   ███████╗
║     ██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ╚════██║
║     ╚██████╔╝███████╗ ██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████║
║      ╚═════╝ ╚══════╝ ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
║                                                                  ║
║            ULTIMATE RUNTIMES INSTALLER v3.0 - ONE LINE            ║
║                                                                  ║
║              👨‍💻 DEV - esieme | Instagram: @_esieme              ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Write-Host "   📌 Instalação automática para BlueStacks, jogos e aplicações" -ForegroundColor White
Write-Host ""

$menuOptions = @(
    "⚡ INSTALAR TUDO (Recomendado)",
    "📦 Visual C++ 2005-2022 (AIO)",
    "🟢 Visual C++ 2005",
    "🟡 Visual C++ 2008",
    "🟠 Visual C++ 2010",
    "🔵 Visual C++ 2012",
    "🟣 Visual C++ 2013",
    "🔴 Visual C++ 2015-2022",
    "📁 DirectX 9.0c",
    "🌐 .NET 7.0 + 8.0 + ASP.NET",
    "🌐 .NET Framework 4.8.1",
    "🔍 Verificar componentes instalados",
    "❌ Sair"
)

do {
    Write-Host "`n╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║              📋 MENU DE INSTALAÇÃO               ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    for ($i = 0; $i -lt $menuOptions.Count; $i++) {
        $num = $i + 1
        if ($i -eq 0) { Write-Host "   [$num] $($menuOptions[$i])" -ForegroundColor Green }
        else { Write-Host "   [$num] $($menuOptions[$i])" }
    }
    
    Write-Host ""
    $choice = Read-Host "👉 Escolha uma opção (1-$($menuOptions.Count))"
    
    switch ($choice) {
        "1" {
            Write-Host "`n🚀 INSTALAÇÃO COMPLETA INICIADA..." -ForegroundColor Magenta
            Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
            
            Install-Runtime -Name "VC++ All-In-One 2005-2022" -Url "https://github.com/abbodi1406/vcredist/releases/download/v0.85.0/VisualCppRedist_AIO_x86_x64.exe" -Args "/y" -FileName "VisualCppRedist_AIO.exe"
            Install-Runtime -Name "DirectX 9.0c" -Url "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -Args "/silent" -FileName "dxwebsetup.exe"
            Install-Runtime -Name ".NET 7.0 Desktop Runtime" -Url "https://download.visualstudio.microsoft.com/download/pr/0e9d208b-7e86-4503-aa09-a6b93f32f8b6/302a887b20be568f58db086b4ae9e160/windowsdesktop-runtime-7.0.20-win-x64.exe" -Args "/quiet /norestart" -FileName "net7-runtime.exe"
            Install-Runtime -Name ".NET 8.0 Desktop Runtime" -Url "https://download.visualstudio.microsoft.com/download/pr/e2a5fd81-026e-4ab1-badf-2737e7d0f027/0d172e110af599e7684a60e581cc49d6/dotnet-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "net8-runtime.exe"
            Install-Runtime -Name "ASP.NET Core 8.0" -Url "https://download.visualstudio.microsoft.com/download/pr/1fcedc74-2052-4768-8a5b-ca139b427d1e/42f48f1d36a37225e2c676201a31e15b/aspnetcore-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "aspnet-runtime.exe"
            Install-Runtime -Name ".NET Framework 4.8.1" -Url "https://go.microsoft.com/fwlink/?linkid=2203308" -Args "/quiet /norestart" -FileName "net481.exe"
            
            Write-Host "`n✅ INSTALAÇÃO COMPLETA FINALIZADA!" -ForegroundColor Green
            Write-Host "⚠️ REINICIE O COMPUTADOR para finalizar!" -ForegroundColor Red
        }
        "2" { Install-Runtime -Name "VC++ AIO" -Url "https://github.com/abbodi1406/vcredist/releases/download/v0.85.0/VisualCppRedist_AIO_x86_x64.exe" -Args "/y" -FileName "VisualCppRedist_AIO.exe" }
        "3" { Install-Runtime -Name "VC++ 2005" -Url "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.exe" -Args "/q" -FileName "vcredist2005.exe" }
        "4" { Install-Runtime -Name "VC++ 2008" -Url "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -Args "/qb" -FileName "vcredist2008.exe" }
        "5" { Install-Runtime -Name "VC++ 2010" -Url "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe" -Args "/passive /norestart" -FileName "vcredist2010.exe" }
        "6" { Install-Runtime -Name "VC++ 2012" -Url "https://download.microsoft.com/download/1/6/B/16B06F60-1923-4A5A-855E-3454F30C55C6/vcredist_x86.exe" -Args "/passive /norestart" -FileName "vcredist2012.exe" }
        "7" { Install-Runtime -Name "VC++ 2013" -Url "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E8-D4B2314350D6/vcredist_x86.exe" -Args "/passive /norestart" -FileName "vcredist2013.exe" }
        "8" { Install-Runtime -Name "VC++ 2015-2022" -Url "https://aka.ms/vs/17/release/vc_redist.x64.exe" -Args "/passive /norestart" -FileName "VC_redist.exe" }
        "9" { Install-Runtime -Name "DirectX 9.0c" -Url "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -Args "/silent" -FileName "dxwebsetup.exe" }
        "10" {
            Install-Runtime -Name ".NET 7.0" -Url "https://download.visualstudio.microsoft.com/download/pr/0e9d208b-7e86-4503-aa09-a6b93f32f8b6/302a887b20be568f58db086b4ae9e160/windowsdesktop-runtime-7.0.20-win-x64.exe" -Args "/quiet /norestart" -FileName "net7-runtime.exe"
            Install-Runtime -Name ".NET 8.0" -Url "https://download.visualstudio.microsoft.com/download/pr/e2a5fd81-026e-4ab1-badf-2737e7d0f027/0d172e110af599e7684a60e581cc49d6/dotnet-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "net8-runtime.exe"
            Install-Runtime -Name "ASP.NET Core 8.0" -Url "https://download.visualstudio.microsoft.com/download/pr/1fcedc74-2052-4768-8a5b-ca139b427d1e/42f48f1d36a37225e2c676201a31e15b/aspnetcore-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "aspnet-runtime.exe"
        }
        "11" { Install-Runtime -Name ".NET Framework 4.8.1" -Url "https://go.microsoft.com/fwlink/?linkid=2203308" -Args "/quiet /norestart" -FileName "net481.exe" }
        "12" {
            Write-Host "`n🔍 COMPONENTES INSTALADOS:" -ForegroundColor Cyan
            Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
            
            # Verificar .NET
            $dotnet = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue
            if ($dotnet) {
                $release = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -Name "Release" -ErrorAction SilentlyContinue).Release
                Write-Host "   ✅ .NET Framework: $release" -ForegroundColor Green
            }
            
            Write-Host "`n💡 Dica: Reinicie após instalar os runtimes!" -ForegroundColor Yellow
        }
        "13" {
            Write-Host "`n👋 Saindo..." -ForegroundColor Yellow
            break
        }
        default { Write-Host "❌ Opção inválida!" -ForegroundColor Red }
    }
    
    if ($choice -ne "13") {
        Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
        Write-Host "✅ Operação concluída!" -ForegroundColor Green
        Write-Host "⚠️ Lembre-se de REINICIAR o computador!" -ForegroundColor Red
        Read-Host "`nPressione ENTER para voltar ao menu"
        Clear-Host
        # Banner simplificado no retorno
        Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║     ULTIMATE RUNTIMES INSTALLER - DEV - esieme (@_esieme)  ║" -ForegroundColor Cyan
        Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    }
    
} while ($choice -ne "13")

# Limpeza
try { Remove-Item $tempFolder -Recurse -Force -ErrorAction SilentlyContinue } catch {}