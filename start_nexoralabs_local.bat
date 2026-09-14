@echo off
setlocal

set "HOST_LINE=127.0.0.1 nexoralabs.local"
set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Solicitando permisos de administrador...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~f0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /b

:gotAdmin
    echo Verificando entrada %HOST_LINE% en el archivo hosts...
    findstr /C:"%HOST_LINE%" "%HOSTS%" >nul 2>&1
    if errorlevel 1 (
        echo.%HOST_LINE%>> "%HOSTS%"
        echo Entrada agregada correctamente.
    ) else (
        echo La entrada ya existe.
    )

    echo.
    echo Iniciando servidor local en: http://nexoralabs.local
    cd /d "%~dp0"
    python -m http.server 80
    pause
