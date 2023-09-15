#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <caminho_do_projeto> <string_de_busca>"
    exit 1
fi

project_path="$1"
search_string="$2"
output_file="paths.txt"

# Loop pelos arquivos .tsx e paralelizar a verificação
for file in $(find "$project_path" -type f -name '*.tsx'); do
    echo "$file"
done | parallel -j "$(nproc)" "
    if grep -q '$search_string' {}; then
        echo '{}' >> '$output_file'
        echo 'Caminho do arquivo com a string encontrado: {}'
    else
        echo 'A string de busca não foi encontrada no arquivo: {}'
    fi
"

echo "Caminhos dos arquivos encontrados foram salvos em $output_file"