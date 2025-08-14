@echo off
:: ==================================================
:: PAINEL DE SUPORTE TECNICO - COMPLETO
:: Criado por Wesley Barros - 2025
:: ==================================================
title Painel de Suporte Tecnico
mode con: cols=95 lines=40

:: =====================================
:: VERIFICACAO DE ADMINISTRADOR
:: =====================================
net session >nul 2>&1
if errorlevel 1 (
    echo Este script precisa ser executado como ADMINISTRADOR!
    echo Clique com o botao direito no arquivo e escolha "Executar como administrador".
    pause
    exit /b
)


:: =====================================
:: PROTECAO POR SENHA
:: =====================================
set "SENHA_CORRETA=WB2025"

:LOGIN
cls
echo =======================================
echo        PAINEL DE SUPORTE TECNICO
echo =======================================
set /p "SENHA=Digite a senha de acesso: "
if "%SENHA%"=="%SENHA_CORRETA%" (
    echo Acesso permitido...
    timeout /t 1 >nul
    goto COR
) else (
    echo Senha incorreta! Tente novamente.
    timeout /t 2 >nul
    goto LOGIN
)

:: =====================================
:: ROTINA DE CORES
:: =====================================
:COR
cls
echo ================================================================
echo               SELECIONE A COR DO PAINEL
echo ------------------------------------------------
echo 0 = Preto       8 = Cinza
echo 1 = Azul        9 = Azul claro
echo 2 = Verde       A = Verde claro
echo 3 = Aqua        B = Aqua claro
echo 4 = Vermelho    C = Vermelho claro
echo 5 = Roxo        D = Roxo claro
echo 6 = Amarelo     E = Amarelo claro
echo 7 = Branco      F = Branco brilhante
echo ------------------------------------------------
echo FORMATO: FundoTexto  (Exemplo: 0B = fundo preto, texto aqua claro)
echo.
set /p cor="Digite o codigo da cor (ou pressione ENTER para usar padrao): "
if "%cor%"=="" (
    color 07
) else (
    color %cor%
)
goto MENU

:: =====================================
:: MENU PRINCIPAL
:: =====================================
:MENU
cls
echo ===================================================================
echo                    CRIADO POR WESLEY BARROS
echo                   FERRAMENTA PARA USO DO TECNICO
echo                UTILIZE A FERRAMENTA COMO ADMINISTRADOR
echo ===================================================================
echo Versao Beta 1.0 - 2025
echo.
echo [1]  Limpeza de arquivos temporarios
echo [2]  Executar limpeza de disco (cleanmgr)
echo [3]  Verificacao de arquivos do sistema (SFC)
echo [4]  Reparo da imagem do Windows (DISM)
echo [5]  Reset do Windows Update
echo [6]  Reset de configuracoes de rede
echo [7]  Atualizacao das politicas de grupo (GPO)
echo [8]  Limpeza de logs de eventos
echo [9]  Informacoes do sistema (msinfo32)
echo [10] Gerenciador de dispositivos
echo [11] Ver adaptadores de rede
echo [12] Ver e atualizar programas instalados via winget
echo [13] Ver processos em execucao
echo [14] Ver status dos principais servicos
echo [15] Executar CHKDSK no disco C:
echo [16] Abrir PowerShell
echo [17] Verificar ipconfig
echo [18] Instalar impressora / Abrir link de driver
echo [19] Abertura de chamado
echo [20] Testar velocidade da internet
echo [21] Verificar espaco em disco
echo [22] Verificar status do antivirus
echo [23] Testar conectividade com o google
echo [24] Backup dos logs de eventos
echo [25] Visualizar dispositivos USB conectados
echo [26] Ver uso de memoria e CPU
echo [27] Baixar arquivo via HTTPS (exemplo com PowerShell)
echo [28] Gerar relatorio de politicas de grupo (gpresult)
echo [U] Atualizar script
echo [99] Mudar cor
echo [0]  Sair
echo.

set /p opcao="Escolha uma opcao: "

:: Valida se a entrada do usuário é numérica ou 'U' (para atualização).
setlocal enabledelayedexpansion
set "valor=%opcao%"
for /f "delims=0123456789Uu" %%a in ("!valor!") do (
    endlocal
    echo Opcao invalida! Digite um numero valido.
    pause
    goto MENU
)
endlocal

:: Direciona para a rotina correspondente à opção escolhida.
if /I "%opcao%"=="U" goto ATUALIZAR
if "%opcao%"=="99" goto COR
if "%opcao%"=="0" exit

:: Corrigido para aceitar a opção 28
if %opcao% lss 1 if not "%opcao%"=="0" goto INVALIDA
if %opcao% gtr 28 if not "%opcao%"=="99" goto INVALIDA

goto EXP_%opcao%

:INVALIDA
echo Opcao invalida! Digite um numero valido.
pause
goto MENU
:: =====================================
:: ROTINAS COMPLETAS EXP_1 até EXP_27
:: =====================================

:EXP_1
cls
echo [1] Limpeza de arquivos temporarios
echo ------------------------------------------------
echo O que faz: Apaga arquivos temporarios do Windows que ocupam espaco inutilmente.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" del /s /q %temp%\*.* 2>nul & echo Limpeza concluida! & pause
goto MENU

:EXP_2
cls
echo [2] Limpeza de disco (cleanmgr)
echo ------------------------------------------------
echo O que faz: Abre a ferramenta do Windows para remover arquivos desnecessarios e liberar espaco.
echo Tempo estimado: 2 a 5 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" cleanmgr & pause
goto MENU

:EXP_3
cls
echo [3] Verificacao de arquivos do sistema (SFC)
echo ------------------------------------------------
echo O que faz: Verifica arquivos protegidos do Windows e tenta reparar corrupcoes automaticamente.
echo Tempo estimado: 10 a 30 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" sfc /scannow & pause
goto MENU

:EXP_4
cls
echo [4] Reparo da imagem do Windows (DISM)
echo ------------------------------------------------
echo O que faz: Repara corrupcoes na imagem do Windows.
echo Tempo estimado: 10 a 20 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" dism /online /cleanup-image /restorehealth & pause
goto MENU

:EXP_5
cls
echo [5] Reset do Windows Update
echo ------------------------------------------------
echo O que faz: Reinicia os servicos do Windows Update e limpa caches.
echo Tempo estimado: 5 a 10 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    net stop wuauserv
    net stop bits
    rd /s /q %windir%\SoftwareDistribution
    net start wuauserv
    net start bits
    echo Reset do Windows Update concluido!
)
pause
goto MENU

:EXP_6
cls
echo [6] Reset de configuracoes de rede
echo ------------------------------------------------
echo O que faz: Reseta IP, Winsock e configuracoes TCP/IP.
echo Tempo estimado: 1 a 3 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    ipconfig /release
    ipconfig /renew
    ipconfig /flushdns
    netsh winsock reset
    netsh int ip reset
    echo Configuracoes de rede resetadas!
)
pause
goto MENU

:EXP_7
cls
echo [7] Atualizacao das politicas de grupo (GPO)
echo ------------------------------------------------
echo O que faz: Atualiza politicas de grupo locais e de dominio.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" gpupdate /force & pause
goto MENU

:EXP_8
cls
echo [8] Limpeza de logs de eventos
echo ------------------------------------------------
echo O que faz: Limpa todos os logs do Visualizador de Eventos.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" for /F "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G"
echo Logs limpos!
pause
goto MENU

:EXP_9
cls
echo [9] Informacoes do sistema (msinfo32)
echo ------------------------------------------------
echo O que faz: Abre o painel de informacoes detalhadas do sistema.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" start msinfo32
goto MENU

:EXP_10
cls
echo [10] Gerenciador de dispositivos
echo ------------------------------------------------
echo O que faz: Abre o Gerenciador de Dispositivos do Windows.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" start devmgmt.msc
goto MENU

:EXP_11
cls
echo [11] Ver adaptadores de rede
echo ------------------------------------------------
echo O que faz: Mostra todos os adaptadores de rede e suas configuracoes.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" ipconfig /all & pause
goto MENU

:EXP_12
cls
echo [12] Ver e atualizar programas instalados via winget
echo ------------------------------------------------
echo O que faz: Lista programas instalados e verifica atualizacoes com winget.
echo Tempo estimado: Variavel
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" winget upgrade & pause
goto MENU

:EXP_13
cls
echo [13] Ver processos em execucao
echo ------------------------------------------------
echo O que faz: Exibe todos os processos em execucao no momento.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" tasklist & pause
goto MENU

:EXP_14
cls
echo [14] Ver status dos principais servicos
echo ------------------------------------------------
echo O que faz: Mostra status de servicos importantes do Windows.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    net start
)
pause
goto MENU

:EXP_15
cls
echo [15] Executar CHKDSK no disco C:
echo ------------------------------------------------
echo O que faz: Verifica e repara erros no disco C:.
echo Tempo estimado: 5 a 20 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" chkdsk C: /f /r
pause
goto MENU

:EXP_16
cls
echo [16] Abrir PowerShell
echo ------------------------------------------------
echo O que faz: Abre o Windows PowerShell.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" start powershell
goto MENU

:EXP_17
cls
echo [17] Verificar ipconfig
echo ------------------------------------------------
echo O que faz: Exibe informacoes de IP e rede.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" ipconfig & pause
goto MENU

:EXP_18
cls
echo [18] Instalar impressora / Abrir link de driver
echo ------------------------------------------------
echo O que faz: Abre o painel de impressoras ou link de drivers.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" start control printers
goto MENU

:EXP_19
cls
echo [19] Abertura de chamado
echo ------------------------------------------------
echo O que faz: Abre portal interno de abertura de chamados.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
:: Aqui voce pode colocar URL do chamado
if "%escolha%"=="1" start https://suporte.exemplo.com
goto MENU

:EXP_20
cls
echo [20] Testar velocidade da internet
echo ------------------------------------------------
echo O que faz: Abre pagina de teste de velocidade.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" start https://www.speedtest.net
goto MENU

:EXP_21
cls
echo [21] Verificar espaco em disco
echo ------------------------------------------------
echo O que faz: Mostra o espaço livre em cada unidade do sistema.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    echo Verificando espaco em disco...
    wmic logicaldisk get name,size,freespace
    echo.
    pause
)
goto MENU

:EXP_22
cls
echo [22] Verificar status de todos os antivírus
echo ------------------------------------------------
echo O que faz: Mostra todos os antivírus instalados e seu status.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    echo Verificando todos os antivírus instalados...
    powershell -NoProfile -Command ^
        "Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntivirusProduct | ForEach-Object { $_.displayName + ' - Estado: ' + $_.productState }"
    echo.
    echo ===== FIM DA VERIFICACAO =====
    pause
)
goto MENU

:EXP_23
cls
echo [23] Testar conectividade com o Google
echo ------------------------------------------------
echo O que faz: Verifica se a rede esta conectada. Teste contínuo.
echo Tempo estimado: Contínuo (pressione Ctrl+C para parar)
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    echo Iniciando ping continuo. Para parar pressione Ctrl+C.
    ping www.google.com -t
    echo.
    pause
)
goto MENU


:EXP_24
cls
echo [24] Backup dos logs de eventos
echo ------------------------------------------------
echo O que faz: Exporta logs de eventos para pasta BackupEventos.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    mkdir "%USERPROFILE%\BackupEventos" 2>nul
    for /F "tokens=*" %%G in ('wevtutil el') do wevtutil epl "%%G" "%USERPROFILE%\BackupEventos\%%G.evtx"
    echo Backup concluido!
)
pause
goto MENU

:EXP_25
cls
echo [25] Visualizar dispositivos USB conectados
echo ------------------------------------------------
echo O que faz: Lista todos os dispositivos USB atualmente conectados.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" wmic path Win32_USBHub get DeviceID,Description & pause
goto MENU

:EXP_26
cls
echo [26] Ver uso de memoria e CPU
echo ------------------------------------------------
echo O que faz: Mostra uso atual de CPU e memoria.
echo Tempo estimado: Instantaneo
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" systeminfo | findstr /C:"Total Physical Memory" & wmic cpu get loadpercentage & pause
goto MENU

:EXP_27
cls
echo [27] Baixar arquivo via HTTPS (exemplo com PowerShell)
echo ------------------------------------------------
set /p url="Cole o link HTTPS: "
if "%url%"=="" echo Nenhum link fornecido! & pause & goto MENU
set "downloadPath=%USERPROFILE%\Downloads"
if not exist "%downloadPath%" mkdir "%downloadPath%"
for %%i in ("%url%") do set "filename=%%~nxi"
if "%filename%"=="" set "filename=downloaded_file"
set "destino=%downloadPath%\%filename%"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Invoke-WebRequest -Uri '%url%' -OutFile '%destino%' -UseBasicParsing"
echo Download concluido em %destino%
pause
goto MENU



:EXP_28
cls
echo [28] Gerar relatorio de politicas de grupo (gpresult)
echo ------------------------------------------------
echo O que faz: Mostra as politicas aplicadas e gera arquivo de relatorio.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
echo.
set /p escolha="Deseja executar? (1=Sim / 0=Voltar): "
if "%escolha%"=="1" (
    cls
    echo Gerando relatorio de politicas de grupo...
    echo.
    gpresult /R
    echo.
    pause
)
goto MENU



:: =====================================
:: ATUALIZACAO AUTOMATICA DO PAINEL
:: =====================================
:ATUALIZAR
cls
echo Baixando ultima versao do GitHub...
set "ZIP_PATH=%TEMP%\painel_atualizado.zip"
set "TEMP_DIR=%TEMP%\painel_atualizado"

:: Baixa o ZIP
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/wesleybarross/painel_de_suporte/archive/refs/heads/main.zip' -OutFile '%ZIP_PATH%'"

echo Extraindo arquivos...
:: Remove pasta temporaria antiga se existir
if exist "%TEMP_DIR%" rd /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

:: Extrai o ZIP
powershell -Command "Expand-Archive -Force -Path '%ZIP_PATH%' -DestinationPath '%TEMP_DIR%'"

:: Copia os arquivos para a pasta atual, sobrescrevendo
echo Atualizando arquivos do painel...
xcopy "%TEMP_DIR%\painel_de_suporte-main\*" "%~dp0" /s /e /y

:: Mostra a data e hora
echo.
echo Atualizacao concluida em:
echo ------------------------
echo %date% %time%
echo.

:: Lista os arquivos atualizados
echo Conteudo do painel atualizado:
echo -----------------------------
dir /b "%~dp0"
echo.

:: Limpa arquivos temporarios
rd /s /q "%TEMP_DIR%"
del /q "%ZIP_PATH%"

pause
goto MENU
