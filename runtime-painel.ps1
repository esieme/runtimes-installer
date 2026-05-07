# ULTIMATE RUNTIMES INSTALLER - PAINEL PRINCIPAL
# DEV - esieme | Instagram: @_esieme

$tempFolder = "$env:TEMP\RuntimeInstaller"
if (!(Test-Path $tempFolder)) { New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null }

function Install-Runtime {
    param($Name, $Url, $Args, $FileName)
    $filePath = "$tempFolder\$FileName"
    Write-Host "Instalando: $Name" -ForegroundColor Yellow
    Write-Host "   Baixando..." -ForegroundColor Gray
    try {
        Invoke-WebRequest -Uri $Url -OutFile $filePath -UseBasicParsing -ErrorAction Stop
        Write-Host "   Download OK!" -ForegroundColor Green
        Write-Host "   Instalando..." -ForegroundColor Gray
        $process = Start-Process -FilePath $filePath -ArgumentList $Args -NoNewWindow -Wait -PassThru
        if ($process.ExitCode -eq 0 -or $process.ExitCode -eq 3010) {
            Write-Host "   Instalado com sucesso!" -ForegroundColor Green
            return $true
        } else {
            Write-Host "   Codigo: $($process.ExitCode)" -ForegroundColor Yellow
            return $false
        }
    } catch {
        Write-Host "   Falha: $_" -ForegroundColor Red
        return $false
    }
}

Clear-Host
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "       ULTIMATE RUNTIMES INSTALLER v3.0" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "       Criado por: DEV - esieme" -ForegroundColor Yellow
Write-Host "       Instagram: @_esieme" -ForegroundColor Yellow
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host ""

do {
    Write-Host ""
    Write-Host "MENU DE INSTALACAO" -ForegroundColor Cyan
    Write-Host "----------------" -ForegroundColor Gray
    Write-Host "1. INSTALAR TUDO (Recomendado)"
    Write-Host "2. Visual C++ 2005-2022 (AIO)"
    Write-Host "3. DirectX 9.0c"
    Write-Host "4. .NET 7.0 + 8.0 + ASP.NET"
    Write-Host "5. .NET Framework 4.8.1"
    Write-Host "6. Sair"
    Write-Host ""
    $choice = Read-Host "Digite a opcao (1-6)"
    
    switch ($choice) {
        "1" {
            Write-Host "Instalacao completa iniciada..." -ForegroundColor Magenta
            Install-Runtime -Name "VC++ All-In-One 2005-2022" -Url "https://github.com/abbodi1406/vcredist/releases/download/v0.85.0/VisualCppRedist_AIO_x86_x64.exe" -Args "/y" -FileName "VisualCppRedist_AIO.exe"
            Install-Runtime -Name "DirectX 9.0c" -Url "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -Args "/silent" -FileName "dxwebsetup.exe"
            Install-Runtime -Name ".NET 7.0 Desktop" -Url "https://download.visualstudio.microsoft.com/download/pr/0e9d208b-7e86-4503-aa09-a6b93f32f8b6/302a887b20be568f58db086b4ae9e160/windowsdesktop-runtime-7.0.20-win-x64.exe" -Args "/quiet /norestart" -FileName "net7-runtime.exe"
            Install-Runtime -Name ".NET 8.0 Desktop" -Url "https://download.visualstudio.microsoft.com/download/pr/e2a5fd81-026e-4ab1-badf-2737e7d0f027/0d172e110af599e7684a60e581cc49d6/dotnet-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "net8-runtime.exe"
            Install-Runtime -Name "ASP.NET Core 8.0" -Url "https://download.visualstudio.microsoft.com/download/pr/1fcedc74-2052-4768-8a5b-ca139b427d1e/42f48f1d36a37225e2c676201a31e15b/aspnetcore-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "aspnet-runtime.exe"
            Install-Runtime -Name ".NET Framework 4.8.1" -Url "https://go.microsoft.com/fwlink/?linkid=2203308" -Args "/quiet /norestart" -FileName "net481.exe"
            Write-Host ""
            Write-Host "Instalacao finalizada!" -ForegroundColor Green
            Write-Host "REINICIE O COMPUTADOR!" -ForegroundColor Red
        }
        "2" { Install-Runtime -Name "VC++ AIO" -Url "https://github.com/abbodi1406/vcredist/releases/download/v0.85.0/VisualCppRedist_AIO_x86_x64.exe" -Args "/y" -FileName "VisualCppRedist_AIO.exe" }
        "3" { Install-Runtime -Name "DirectX 9.0c" -Url "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -Args "/silent" -FileName "dxwebsetup.exe" }
        "4" {
            Install-Runtime -Name ".NET 7.0" -Url "https://download.visualstudio.microsoft.com/download/pr/0e9d208b-7e86-4503-aa09-a6b93f32f8b6/302a887b20be568f58db086b4ae9e160/windowsdesktop-runtime-7.0.20-win-x64.exe" -Args "/quiet /norestart" -FileName "net7-runtime.exe"
            Install-Runtime -Name ".NET 8.0" -Url "https://download.visualstudio.microsoft.com/download/pr/e2a5fd81-026e-4ab1-badf-2737e7d0f027/0d172e110af599e7684a60e581cc49d6/dotnet-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "net8-runtime.exe"
            Install-Runtime -Name "ASP.NET Core 8.0" -Url "https://download.visualstudio.microsoft.com/download/pr/1fcedc74-2052-4768-8a5b-ca139b427d1e/42f48f1d36a37225e2c676201a31e15b/aspnetcore-runtime-8.0.12-win-x64.exe" -Args "/quiet /norestart" -FileName "aspnet-runtime.exe"
        }
        "5" { Install-Runtime -Name ".NET Framework 4.8.1" -Url "https://go.microsoft.com/fwlink/?linkid=2203308" -Args "/quiet /norestart" -FileName "net481.exe" }
        "6" {
            Write-Host "Saindo..." -ForegroundColor Yellow
            break
        }
        default { Write-Host "Opcao invalida!" -ForegroundColor Red }
    }
    
    if ($choice -ne "6") {
        Write-Host ""
        Write-Host "--------------------------------------------" -ForegroundColor Gray
        Read-Host "Pressione ENTER para continuar"
        Clear-Host
        Write-Host "===========================================================" -ForegroundColor Cyan
        Write-Host "       ULTIMATE RUNTIMES INSTALLER v3.0" -ForegroundColor Cyan
        Write-Host "===========================================================" -ForegroundColor Cyan
    }
} while ($choice -ne "6")

try { Remove-Item $tempFolder -Recurse -Force -ErrorAction SilentlyContinue } catch {}
