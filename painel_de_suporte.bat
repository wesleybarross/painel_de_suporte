@echo off
:: Painel de Suporte Tecnico - Melhorado com verificação de admin e validação de entradas
title Painel de Suporte Tecnico
mode con: cols=95 lines=40

:: Verifica se o script está rodando como administrador
net session >nul 2>&1
if errorlevel 1 (
    echo Este script precisa ser executado como ADMINISTRADOR!
    echo Clique com o botao direito no arquivo e escolha "Executar como administrador".
    pause
    exit /b
)

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
    setlocal enabledelayedexpansion
    set "valid=0123456789ABCDEFabcdef"
    set "input=%cor%"
    set "c1=!input:~0,1!"
    set "c2=!input:~1,1!"
    for %%A in (!c1!) do set "c1=%%~A"
    for %%B in (!c2!) do set "c2=%%~B"
    if "!valid:%c1%=!"=="%valid%" (
        echo Codigo de cor invalido!
        pause
        endlocal
        goto COR
    )
    if "!valid:%c2%=!"=="%valid%" (
        echo Codigo de cor invalido!
        pause
        endlocal
        goto COR
    )
    endlocal
    color %cor%
)

goto MENU

:MENU
cls
echo ================================================================================ 
echo                    CRIADO POR WESLEY BARROS
echo                   FERRAMENTA PARA USO DO TECNICO
echo                UTILIZE A FERRAMENTA COMO ADMINISTRADOR
echo ================================================================================ 
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
echo [12] Ver e atualizar programas instalados (via winget)
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
echo [99] Mudar cor
echo [0]  Sair
echo.

set /p opcao="Escolha uma opcao: "

:: Valida se entrada é numérica
setlocal enabledelayedexpansion
set "valor=%opcao%"
for /f "delims=0123456789" %%a in ("!valor!") do (
    endlocal
    echo Opcao invalida! Digite um numero valido.
    pause
    goto MENU
)
endlocal

if "%opcao%"=="99" goto COR
if "%opcao%"=="0" exit

rem Verifica intervalo válido
if %opcao% lss 1 if not "%opcao%"=="0" goto INVALIDA
if %opcao% gtr 27 if not "%opcao%"=="99" goto INVALIDA

goto EXP_%opcao%

:INVALIDA
echo Opcao invalida! Digite um numero valido.
pause
goto MENU

:EXP_1
cls
echo [1] Limpeza de arquivos temporarios
echo Apaga os arquivos temporarios do sistema, que ficam em %%temp%% — ajudam a liberar espaco e evitar lentidao.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    del /s /q %temp%\*.* 2>nul
    cls
    echo Limpeza concluida.
    pause
)
goto MENU

:EXP_2
cls
echo [2] Executar limpeza de disco (cleanmgr)
echo Abre a ferramenta do Windows "Limpeza de Disco" para remover arquivos desnecessarios e liberar espaco.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    cleanmgr
    pause
)
goto MENU

:EXP_3
cls
echo [3] Verificacao de arquivos do sistema (SFC)
echo Executa o comando sfc /scannow que verifica e repara arquivos protegidos do Windows corrompidos.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    sfc /scannow
    pause
)
goto MENU

:EXP_4
cls
echo [4] Reparo da imagem do Windows (DISM)
echo Executa DISM /Online /Cleanup-Image /RestoreHealth para reparar a imagem do sistema Windows, corrigindo arquivos corrompidos.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    DISM /Online /Cleanup-Image /RestoreHealth
    pause
)
goto MENU

:EXP_5
cls
echo [5] Reset do Windows Update
echo Para os servicos do Windows Update (wuauserv e bits), apaga a pasta SoftwareDistribution e reinicia os servicos, para resolver problemas com atualizacoes.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    net stop wuauserv
    net stop bits
    rd /s /q %windir%\SoftwareDistribution
    net start wuauserv
    net start bits
    pause
)
goto MENU

:EXP_6
cls
echo [6] Reset de configuracoes de rede
echo Reseta configuracoes de rede como o Winsock e o protocolo IP e limpa o cache DNS — util para problemas de conexao.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    netsh winsock reset
    netsh int ip reset
    ipconfig /flushdns
    pause
)
goto MENU

:EXP_7
cls
echo [7] Atualizacao das politicas de grupo (GPO)
echo Forca a atualizacao das politicas de grupo do Windows (gpupdate /force), util em ambientes corporativos.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    gpupdate /force
    pause
)
goto MENU

:EXP_8
cls
echo [8] Limpeza de logs de eventos
echo Limpa os logs dos eventos do sistema, como os logs de aplicacao e sistema.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    wevtutil cl Application
    wevtutil cl System
    pause
)
goto MENU

:EXP_9
cls
echo [9] Informacoes do sistema (msinfo32)
echo Abre o utilitario msinfo32 com informacoes detalhadas do hardware e software do computador.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start msinfo32
    pause
)
goto MENU

:EXP_10
cls
echo [10] Gerenciador de dispositivos
echo Abre o Gerenciador de Dispositivos para gerenciar hardware e drivers.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start devmgmt.msc
    pause
)
goto MENU

:EXP_11
cls
echo [11] Ver adaptadores de rede
echo Mostra as informacoes completas dos adaptadores de rede usando ipconfig /all.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    ipconfig /all
    pause
)
goto MENU

:EXP_12
cls
echo [12] Ver e atualizar programas instalados via winget
echo Este comando lista os programas com atualizacoes disponiveis usando winget.
echo.
echo [1] Ver atualizacoes disponiveis
echo [2] Atualizar todos os programas com atualizacoes
echo [0] Voltar
set /p escolha="Escolha uma opcao: "

if "%escolha%"=="1" (
    echo Verificando atualizacoes disponiveis via winget...
    winget upgrade
    echo.
    pause
    goto EXP_12
)

if "%escolha%"=="2" (
    echo Iniciando atualizacao de todos os programas...
    winget upgrade --accept-source-agreements --accept-package-agreements --silent
    echo.
    pause
    goto MENU
)

if "%escolha%"=="0" goto MENU

goto EXP_12

:EXP_13
cls
echo [13] Ver processos em execucao
echo Lista todos os processos rodando atualmente com o comando tasklist.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    tasklist
    pause
)
goto MENU

:EXP_14
cls
echo [14] Ver status dos principais servicos
echo Mostra os servicos Windows que estao iniciados (em execucao) com o comando net start.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    net start
    pause
)
goto MENU

:EXP_15
cls
echo [15] Executar CHKDSK no disco C:
echo Roda o comando chkdsk C: /f /r para verificar e reparar erros no disco C:.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    chkdsk C: /f /r
    pause
)
goto MENU

:EXP_16
cls
echo [16] Abrir PowerShell
echo Abre uma janela do PowerShell.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start powershell
    pause
)
goto MENU

:EXP_17
cls
echo [17] Verificar ipconfig
echo Mostra as configuracoes basicas de IP da maquina com o comando ipconfig.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    ipconfig
    pause
)
goto MENU

:EXP_18
cls
echo [18] Instalar impressora / Abrir link de driver
echo Abre a janela de impressoras do Windows (painel de controle) para instalacao ou configuracao.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start control printers
    pause
)
goto MENU

:EXP_19
cls
echo [19] Abertura de chamado
echo Abre um link na web para o sistema de chamados (helpdesk) da empresa.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start https://grupohmaisbrasil.softexpert.com/softexpert/login
    pause
)
goto MENU

:EXP_20
cls
echo [20] Testar velocidade da internet
echo Abre o site Speedtest.net para testar a velocidade da conexao de internet.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start https://www.speedtest.net
    pause
)
goto MENU

:EXP_21
cls
echo [21] Verificar espaco em disco
echo Mostra a capacidade total, espaco livre e espaco usado da unidade C: em GB.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    for /f "tokens=1,2 delims==" %%a in ('wmic logicaldisk where "DeviceID='C:'" get Size^,FreeSpace /format:value') do (
        if "%%a"=="Size" set size=%%b
        if "%%a"=="FreeSpace" set free=%%b
    )
    set /a sizeGB=%size:~0,-9%
    set /a freeGB=%free:~0,-9%
    set /a usedGB=%sizeGB%-%freeGB%
    echo.
    echo Unidade C:
    echo Capacidade total: %sizeGB% GB
    echo Espaco livre:     %freeGB% GB
    echo Espaco usado:     %usedGB% GB
    pause
)
goto MENU

:EXP_22
cls
echo [22] Verificar status do antivirus
echo Mostra o status do servico do Windows Defender (antivirus nativo do Windows).
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    sc query windefend
    pause
)
goto MENU

:EXP_23
cls
echo [23] Testar conectividade com o Google
echo Roda um ping para google.com para testar se a internet esta funcionando.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    ping google.com
    pause
)
goto MENU

:EXP_24
cls
echo [24] Backup dos logs de eventos
echo Exporta o log do sistema para um arquivo .evtx para analise posterior.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    wevtutil epl System C:\backup_logs_system.evtx
    pause
)
goto MENU

:EXP_25
cls
echo [25] Visualizar dispositivos USB conectados
echo Lista os dispositivos USB conectados no momento.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    wmic path Win32_USBHub get DeviceID,Description
    pause
)
goto MENU

:EXP_26
cls
echo [26] Ver uso de memoria e CPU
echo Lista os processos com informacoes detalhadas, incluindo uso de CPU e memoria.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    tasklist /v
    pause
)
goto MENU

:EXP_27
cls
echo [27] Baixar arquivo via HTTPS (exemplo com PowerShell)
echo Permite baixar um arquivo da internet via HTTPS usando PowerShell.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    set /p url="Digite a URL do arquivo para download: "
    if "%url%"=="" (
        echo URL invalida.
        pause
        goto MENU
    )
    set "outfile=%TEMP%\download_%RANDOM%.bin"
    echo Baixando arquivo...
    powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%outfile%'"
    if errorlevel 1 (
        echo Falha no download.
        pause
    ) else (
        echo Download concluido com sucesso.
        echo Arquivo salvo em: %outfile%
        pause
    )
)
goto MENU
