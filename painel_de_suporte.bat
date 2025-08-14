@echo off
:: Painel de Suporte Tecnico - Melhorado com explicações amigáveis
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




@echo off
:: Painel de Suporte Tecnico - Protegido por senha
title Painel de Suporte Tecnico
mode con: cols=95 lines=40

:: =====================================
:: PROTEÇÃO POR SENHA
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
echo ===================================================================
echo                    CRIADO POR WESLEY BARROS
echo                   FERRAMENTA PARA USO DO TECNICO
echo                UTILIZE A FERRAMENTA COMO ADMINISTRADOR
echo ===================================================================
echo Versao Beta 1.0 
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
echo [U] Atualizar script
echo [99] Mudar cor
echo [0]  Sair
echo.

set /p opcao="Escolha uma opcao: "

:: Valida se entrada é numérica ou U
setlocal enabledelayedexpansion
set "valor=%opcao%"
for /f "delims=0123456789Uu" %%a in ("!valor!") do (
    endlocal
    echo Opcao invalida! Digite um numero valido.
    pause
    goto MENU
)
endlocal

if /I "%opcao%"=="U" goto ATUALIZAR
if "%opcao%"=="99" goto COR
if "%opcao%"=="0" exit
if %opcao% lss 1 if not "%opcao%"=="0" goto INVALIDA
if %opcao% gtr 27 if not "%opcao%"=="99" goto INVALIDA

goto EXP_%opcao%

:INVALIDA
echo Opcao invalida! Digite um numero valido.
pause
goto MENU

:: ==========================
:: Opcoes 1 a 27
:: ==========================

:EXP_1
cls
echo [1] Limpeza de arquivos temporarios
echo ------------------------------------------------
echo O que faz: Apaga arquivos temporarios do Windows que ocupam espaco inutilmente.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    del /s /q %temp%\*.* 2>nul
    echo Limpeza concluida!
    pause
)
goto MENU

:EXP_2
cls
echo [2] Limpeza de disco (cleanmgr)
echo ------------------------------------------------
echo O que faz: Abre a ferramenta do Windows para remover arquivos desnecessarios e liberar espaco.
echo Tempo estimado: 2 a 5 minutos
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Verifica arquivos protegidos do Windows e tenta reparar corrupcoes automaticamente.
echo Tempo estimado: 10 a 30 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    echo Iniciando verificacao...
    sfc /scannow
    echo Verificacao concluida.
    echo Verifique o log em C:\Windows\Logs\CBS\CBS.log se houver problemas.
    pause
)
goto MENU

:EXP_4
cls
echo [4] Reparo da imagem do Windows (DISM)
echo ------------------------------------------------
echo O que faz: Repara arquivos de sistema corrompidos usando a ferramenta DISM.
echo Tempo estimado: 10 a 30 minutos
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Reinicia os servicos do Windows Update e limpa a pasta SoftwareDistribution.
echo Tempo estimado: 2 a 5 minutos
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Reseta Winsock, IP e DNS para resolver problemas de conexao.
echo Tempo estimado: 1 a 3 minutos
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Forca atualizacao das politicas de grupo do Windows.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Apaga registros antigos de erros e avisos do Windows.
echo Tempo estimado: 1 minuto
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    wevtutil cl Application
    wevtutil cl System
    echo Limpeza concluida!
    pause
)
goto MENU

:EXP_9
cls
echo [9] Informacoes do sistema (msinfo32)
echo ------------------------------------------------
echo O que faz: Abre utilitario do Windows com informacoes detalhadas de hardware e software.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Abre o Gerenciador de Dispositivos para gerenciar hardware e drivers.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Mostra detalhes dos adaptadores de rede com ipconfig /all.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [2] Executar continuamente (monitoramento)
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    ipconfig /all
    pause
    goto MENU
)
if "%escolha%"=="2" (
    cls
    echo Monitoramento continuo iniciado. Digite 0 para voltar ao menu.
    :loop_ipconfig
    ipconfig /all
    set /p sair="Digite 0 para voltar ou ENTER para atualizar: "
    if "%sair%"=="0" goto MENU
    goto loop_ipconfig
)
if "%escolha%"=="0" goto MENU
goto EXP_11

:EXP_12
cls
echo [12] Ver e atualizar programas instalados via winget
echo ------------------------------------------------
echo O que faz: Lista programas que podem ser atualizados e permite atualizar.
echo Tempo estimado: Varia dependendo do numero de programas
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Ver atualizacoes disponiveis
echo [2] Atualizar todos os programas
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    winget upgrade
    pause
    goto EXP_12
)
if "%escolha%"=="2" (
    winget upgrade --accept-source-agreements --accept-package-agreements --silent
    pause
    goto MENU
)
if "%escolha%"=="0" goto MENU
goto EXP_12

:EXP_13
cls
echo [13] Ver processos em execucao
echo ------------------------------------------------
echo O que faz: Lista todos os processos que estao rodando no momento.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Mostra os servicos do Windows que estao em execucao.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Verifica o disco C: e corrige erros encontrados.
echo Tempo estimado: Depende do tamanho do disco, pode demorar varios minutos.
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Abre uma janela do PowerShell para comandos avancados.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Mostra as configuracoes de IP do computador.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Abre o painel de impressoras do Windows.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Abre o sistema de chamados da empresa no navegador.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo O que faz: Abre o teste de velocidade via navegador.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    start https://www.speedtest.net/
    pause
)
goto MENU

:EXP_21
cls
echo [21] Verificar espaco em disco
echo ------------------------------------------------
echo O que faz: Mostra o espaco livre e ocupado em todos os discos.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    wmic logicaldisk get size,freespace,caption
    pause
)
goto MENU

:EXP_22
cls
echo [22] Verificar status do antivirus
echo ------------------------------------------------
echo O que faz: Mostra status do Windows Defender e outros antivirus compativeis com WMI.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    powershell -command "Get-MpComputerStatus | Format-List AMServiceEnabled,AntispywareEnabled,AntivirusEnabled,RealTimeProtectionEnabled"
    pause
)
goto MENU

:EXP_23
cls
echo [23] Testar conectividade com o Google
echo ------------------------------------------------
echo O que faz: Verifica se a internet esta funcionando via ping.
echo Tempo estimado: Contínuo (pressione Ctrl+C para parar)
echo Afeta meus arquivos pessoais? Nao
echo.
echo Ao parar com CTRL+C, digite N para voltar ao menu sem fechar o programa.
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "

if "%escolha%"=="1" (
    call :PING_LOOP
    goto MENU
)

if "%escolha%"=="0" goto MENU
goto EXP_23

:PING_LOOP
REM Ativar tratamento de CTRL+C
break off
ping google.com -t
goto MENU

:EXP_24
cls
echo [24] Backup dos logs de eventos
echo ------------------------------------------------
echo O que faz: Copia logs importantes do Windows para pasta de backup.
echo Tempo estimado: 1 a 2 minutos
echo Afeta meus arquivos pessoais? Nao
echo.
set backupdir=%userprofile%\Desktop\LogsBackup
if not exist "%backupdir%" mkdir "%backupdir%"
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    xcopy C:\Windows\System32\winevt\Logs "%backupdir%" /s /i /y
    echo Backup concluido em %backupdir%
    pause
)
goto MENU

:EXP_25
cls
echo [25] Visualizar dispositivos USB conectados
echo ------------------------------------------------
echo O que faz: Lista todos os dispositivos USB atualmente conectados.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar
echo [0] Voltar
set /p escolha="Escolha uma opcao: "
if "%escolha%"=="1" (
    wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value
    pause
)
goto MENU

:EXP_26
cls
echo [26] Ver uso de memoria e CPU
echo ------------------------------------------------
echo O que faz: Mostra o uso atual de memoria RAM e CPU.
echo Tempo estimado: Imediato
echo Afeta meus arquivos pessoais? Nao
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
echo ------------------------------------------------
echo    O que faz: Baixa um arquivo de um link seguro.
echo    Tempo estimado: Varia conforme o tamanho e velocidade da internet
echo    Afeta meus arquivos pessoais? Nao
echo.
echo [1] Executar (Iniciar o processo de download)
echo [0] Voltar (Sair)
echo.
set /p main_choice="Escolha uma opcao: "

if "%main_choice%"=="27" goto :start_download
if "%main_choice%"=="1" goto :start_download
if "%main_choice%"=="0" goto :eof

echo Opcao invalida. Tente novamente.
pause
goto :main_menu

:start_download
cls
echo ================================
echo Baixar arquivo via HTTPS
echo ================================

set "url="
set /p url="Cole o link HTTPS: "

if "%url%"=="" (
    echo Nenhum link fornecido!
    pause
    goto :main_menu
)

set "downloadPath=%USERPROFILE%\Downloads"
if not exist "%downloadPath%" mkdir "%downloadPath%"

rem Extrai o nome do arquivo da URL. Isso é uma heurística e pode não funcionar para todas as URLs.
for %%i in ("%url%") do set "filename=%%~nxi"

rem Se o nome do arquivo estiver vazio ou for apenas um ponto, tenta uma alternativa ou define um nome padrão.
if "%filename%"=="" set "filename=downloaded_file"
if "%filename%"=="." set "filename=downloaded_file"

set "destino=%downloadPath%\%filename%"

echo Iniciando download de: %url%
echo Salvando em: %destino%

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"try { ^
    $url = \"%url%\" ; ^
    $destination = \"%destino%\" ; ^
    $userAgent = \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36\" ; ^
    Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing -UserAgent $userAgent ; ^
    Write-Host \"Download concluido! Arquivo salvo em: \"$destination\"\" ; ^
} catch { ^
    Write-Host \"Erro: O download falhou. Verifique o link ou a conexao.\" ; ^
    Write-Host $_.Exception.Message ; ^
} ; Read-Host \"Pressione Enter para continuar...\""

:post_download_menu
cls
echo ================================
echo Download Concluido!
echo ================================
echo 1. Executar o arquivo baixado
echo 2. Baixar outro arquivo
echo 3. Voltar ao Menu Principal
echo 4. Sair
set /p choice="Escolha uma opcao: "

if "%choice%"=="1" (
    if exist "%destino%" (
        start "" "%destino%"
        echo Executando %filename%...
        pause
    ) else (
        echo Arquivo nao encontrado para execucao.
        pause
    )
    goto :post_download_menu
) else if "%choice%"=="2" (
    goto :start_download
) else if "%choice%"=="3" (
    goto :main_menu
) else if "%choice%"=="4" (
    goto :eof
) else (
    echo Opcao invalida. Tente novamente.
    pause
    goto :post_download_menu
)




:ATUALIZAR
@echo off
cls
mode con: cols=80 lines=25

:: Define cor branca para fonte
color 07

:: Caminho do ZIP temporário
set "ZIP_PATH=%TEMP%\painel_atualizado.zip"

:: Tela inicial
call :title
echo.
echo                   Baixando a ultima versao do GitHub...
echo.

:: Download com PowerShell
powershell -Command ^
"try { $url = 'https://github.com/wesleybarross/painel_de_suporte/archive/refs/heads/main.zip'; $output = '%ZIP_PATH%'; $wc = New-Object System.Net.WebClient; $wc.DownloadFile($url, $output) } catch { exit 1 }"

:: Verifica erro de download
if %errorlevel% neq 0 (
    call :title
    echo.
    echo                   ERRO: Falha ao baixar a ultima versao!
    echo      Verifique sua conexao com a internet ou se o link esta correto.
    echo.
    pause
    goto MENU
)

call :title
echo.
echo Download concluido em:
echo %ZIP_PATH%
echo.
echo                   Extraindo arquivos...

powershell -Command "Expand-Archive -Force -Path '%ZIP_PATH%' -DestinationPath '.'"

call :title
echo.
echo                   Substituindo arquivos antigos...
timeout /t 1 >nul

call :title
echo.
echo  ================================================================================
echo                         Script atualizado com sucesso!
echo  ================================================================================
echo.

pause
goto MENU

:: ---------- Funcoes ----------
:title
cls
echo.
echo  ================================================================================
echo                                   Atualizacao do Script
echo  ================================================================================
exit /b
