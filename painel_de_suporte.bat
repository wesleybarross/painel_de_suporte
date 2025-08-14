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




@echo off
:: ============================================================================
:: Painel de Suporte Técnico - Melhorado com explicações amigáveis
::
:: Este script Batch (.bat) foi desenvolvido para auxiliar técnicos de suporte
:: na execução de tarefas comuns de manutenção e diagnóstico em sistemas Windows.
:: Ele oferece um menu interativo com diversas opções, desde limpeza de arquivos
:: temporários até verificação de integridade do sistema e gerenciamento de rede.
::
:: Autor Original: WESLEY BARROS
:: Versão: Beta 1.0 - 2025
::
:: Requisitos:
:: - Executar como Administrador para que todas as funções operem corretamente.
:: - Conexão com a internet para funções que dependem de download ou acesso a URLs.
::
:: Estrutura do Script:
:: - Configurações Iniciais: Define o título da janela e o tamanho.
:: - Rotina de Seleção de Cor: Permite ao usuário personalizar as cores do console.
:: - Menu Principal: Apresenta as opções disponíveis para o técnico.
:: - Rotinas de Execução: Cada opção do menu principal direciona para uma rotina
::   específica que executa a tarefa correspondente, com explicações detalhadas.
:: - Rotina de Atualização: Permite baixar a versão mais recente do script via GitHub.
::
:: ============================================================================

title Painel de Suporte Técnico
mode con: cols=95 lines=40

:: ============================================================================
:: ROTINA DE SELEÇÃO DE COR DO PAINEL
:: Esta seção permite ao usuário escolher as cores de fundo e texto do console.
:: As cores são definidas por um código hexadecimal (ex: 07 para fundo preto e texto branco).
:: ============================================================================
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
    :: Se o usuário não digitar nada, define a cor padrão (preto e branco).
    color 07
) else (
    :: Validação da entrada de cor para garantir que é um código válido.
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

:: ============================================================================
:: MENU PRINCIPAL
:: Esta seção exibe todas as opções disponíveis para o técnico e gerencia a navegação.
:: ============================================================================
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
if %opcao% lss 1 if not "%opcao%"=="0" goto INVALIDA
if %opcao% gtr 27 if not "%opcao%"=="99" goto INVALIDA

goto EXP_%opcao%

:INVALIDA
echo Opcao invalida! Digite um numero valido.
pause
goto MENU

:: ============================================================================
:: ROTINAS DE EXECUÇÃO DAS OPÇÕES DO MENU
:: Cada seção abaixo corresponde a uma opção do menu principal e contém:
:: - Título da opção.
:: - Descrição do que a função faz.
:: - Tempo estimado de execução.
:: - Informação se afeta arquivos pessoais.
:: - Opções para executar a tarefa ou voltar ao menu.
:: ============================================================================

:: ----------------------------------------------------------------------------
:: OPÇÃO 1: Limpeza de arquivos temporários
:: Remove arquivos temporários do sistema para liberar espaço em disco.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 2: Limpeza de disco (cleanmgr)
:: Abre a ferramenta nativa do Windows para limpeza de disco, permitindo remover
:: arquivos desnecessários e liberar espaço de forma segura.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 3: Verificação de arquivos do sistema (SFC)
:: Executa o System File Checker (SFC) para verificar e reparar arquivos de sistema
:: corrompidos ou modificados, restaurando a integridade do Windows.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 4: Reparo da imagem do Windows (DISM)
:: Utiliza a ferramenta Deployment Image Servicing and Management (DISM) para
:: reparar a imagem do Windows, corrigindo problemas mais profundos que o SFC.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 5: Reset do Windows Update
:: Interrompe os serviços do Windows Update e BITS, limpa o cache de atualização
:: e reinicia os serviços, útil para resolver problemas de atualização.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 6: Reset de configurações de rede
:: Redefine as configurações de rede (Winsock, IP e DNS) para solucionar
:: problemas de conectividade e acesso à internet.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 7: Atualização das políticas de grupo (GPO)
:: Força a atualização das políticas de grupo do Windows, garantindo que as
:: configurações de segurança e sistema mais recentes sejam aplicadas.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 8: Limpeza de logs de eventos
:: Apaga registros antigos de eventos do Windows (aplicativo e sistema),
:: o que pode ajudar a liberar espaço e melhorar o desempenho.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 9: Informações do sistema (msinfo32)
:: Abre o utilitário 


do Windows que exibe informações detalhadas sobre o hardware e software do computador.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 10: Gerenciador de dispositivos
:: Abre o Gerenciador de Dispositivos, onde é possível gerenciar drivers,
:: hardware e identificar problemas em dispositivos conectados.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 11: Ver adaptadores de rede
:: Exibe informações detalhadas sobre todos os adaptadores de rede instalados,
:: incluindo configurações de IP, DNS, e status da conexão.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 12: Ver e atualizar programas instalados via winget
:: Utiliza o gerenciador de pacotes Winget para listar programas com atualizações
:: disponíveis e permite a atualização de todos eles de uma vez.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 13: Ver processos em execução
:: Lista todos os processos e aplicativos que estão sendo executados no momento
:: no sistema, útil para identificar programas que consomem muitos recursos.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 14: Ver status dos principais serviços
:: Exibe uma lista dos serviços do Windows que estão em execução, permitindo
:: verificar o status de componentes importantes do sistema.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 15: Executar CHKDSK no disco C:
:: Inicia a ferramenta Check Disk (CHKDSK) para verificar e corrigir erros
:: no sistema de arquivos e setores defeituosos no disco C:.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 16: Abrir PowerShell
:: Abre uma nova janela do PowerShell, um ambiente de linha de comando mais
:: avançado para execução de scripts e comandos administrativos.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 17: Verificar ipconfig
:: Exibe as configurações de rede IP do computador, incluindo endereço IP,
:: máscara de sub-rede, gateway padrão e servidores DNS.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 18: Instalar impressora / Abrir link de driver
:: Abre o painel de 


impressoras do Windows, permitindo adicionar novas impressoras ou gerenciar as existentes.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 19: Abertura de chamado
:: Abre o sistema de chamados da empresa no navegador padrão, facilitando
:: o registro de novas solicitações de suporte.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 20: Testar velocidade da internet
:: Abre um site de teste de velocidade da internet no navegador padrão,
:: permitindo verificar a qualidade da conexão.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 21: Verificar espaço em disco
:: Exibe o espaço livre e ocupado em todas as unidades de disco lógicas
:: do sistema, útil para monitorar o armazenamento.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 22: Verificar status do antivírus
:: Utiliza PowerShell para verificar o status do Windows Defender e outros
:: antivírus compatíveis com WMI, mostrando se estão ativos.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 23: Testar conectividade com o Google
:: Realiza um teste de ping contínuo para o Google, verificando a conectividade
:: com a internet. Pode ser interrompido com Ctrl+C.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: ROTINA DE PING CONTÍNUO
:: Sub-rotina para executar o ping contínuo. Permite tratamento de Ctrl+C.
:: ----------------------------------------------------------------------------
:PING_LOOP
REM Ativar tratamento de CTRL+C
break off
ping google.com -t
goto MENU

:: ----------------------------------------------------------------------------
:: OPÇÃO 24: Backup dos logs de eventos
:: Copia os logs de eventos importantes do Windows para uma pasta de backup
:: na área de trabalho do usuário, útil para análise posterior.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 25: Visualizar dispositivos USB conectados
:: Lista todos os dispositivos USB que estão atualmente conectados ao computador,
:: incluindo detalhes como tipo e status.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 26: Ver uso de memória e CPU
:: Exibe o uso atual da memória RAM e da CPU, juntamente com a lista de processos,
:: ajudando a identificar gargalos de desempenho.
:: ----------------------------------------------------------------------------
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

:: ----------------------------------------------------------------------------
:: OPÇÃO 27: Baixar arquivo via HTTPS (exemplo com PowerShell)
:: Permite baixar um arquivo de um link HTTPS seguro usando PowerShell.
:: Inclui opções para executar o arquivo após o download.
:: ----------------------------------------------------------------------------
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


:: ============================================================================
:: ROTINA DE ATUALIZAÇÃO DO SCRIPT
:: Permite baixar a versão mais recente do script diretamente do GitHub.
:: Garante que o técnico esteja sempre utilizando a versão mais atualizada.
:: ============================================================================
:ATUALIZAR
@echo off
cls
mode con: cols=80 lines=25

:: Define cor branca para fonte
color 07

:: Caminho do ZIP temporário para o download da atualização.
set "ZIP_PATH=%TEMP%\painel_atualizado.zip"

:: Tela inicial da atualização.
call :title
echo.
echo                   Baixando a ultima versao do GitHub...
echo.

:: Download do arquivo ZIP da última versão do repositório GitHub via PowerShell.
powershell -Command ^
"try { $url = 'https://github.com/wesleybarross/painel_de_suporte/archive/refs/heads/main.zip'; $output = '%ZIP_PATH%'; $wc = New-Object System.Net.WebClient; $wc.DownloadFile($url, $output) } catch { exit 1 }"

:: Verifica se houve erro no download.
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

:: Extrai o conteúdo do arquivo ZIP baixado para o diretório atual, sobrescrevendo arquivos existentes.
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

:: ----------------------------------------------------------------------------
:: FUNÇÃO AUXILIAR: title
:: Exibe um cabeçalho padronizado para a rotina de atualização.
:: ----------------------------------------------------------------------------
:title
cls
echo.
echo  ================================================================================
echo                                   Atualizacao do Script
echo  ================================================================================
exit /b


