@echo off
setlocal

if "%~2"=="" (
    echo Uso: %~nx0 ^<caminho_do_projeto^> ^<string_de_busca^>
    exit /b 1
)

set "project_path=%~1"
set "search_string=%~2"
set "output_file=paths.txt"

REM Loop pelos arquivos .tsx e paralelizar a verificação, ignorando node_modules
for /r "%project_path%" %%f in (*.tsx) do (
    echo %%f
    findstr /c:"%search_string%" "%%f" >nul
    if not errorlevel 1 (
        echo %%f >>"%output_file%"
        echo Caminho do arquivo com a string encontrado: %%f
    ) else (
        echo A string de busca não foi encontrada no arquivo: %%f
    )
)

echo Caminhos dos arquivos encontrados foram salvos em %output_file%
endlocal
