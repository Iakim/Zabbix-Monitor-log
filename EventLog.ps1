###########################################################################
# NOME: Zabbix-Monitor log advanced
# AUTOR: Isaac de Moraes
# COMENTÁRIO: Script para monitorar logs do Windows com busca avançada
# HISTÓRICO DE VERSÃO: 1.0
# 1.0 | 22/03/2018 - Versão inicial - Isaac de Moraes
############################################################################

# Variável do ID do evento no Event Viwer.
$id = 1503

# Variável do nome do valor da propriedade log, não o display name.
# Mais informações: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1
$name = "System"

# Variável do arquivo coletado
$new = "C:\new.txt"

# Variável do último arquivo coletado
$old = "C:\old.txt"

# Obtendo coletada de informações do Event Viwer
Get-EventLog -InstanceId $id -LogName $name -Newest 1 | Select-Object "Index" | Out-File C:\new.txt

# Condição para criar o arquivo old.txt, pois ele é necessário para comparação, e é necessário ter conteúdo arquivos vazios não funcinam
if (Test-Path $old){
#echo "Arquivo old.txt existe" #Descomente para Debug do script
}
else {
New-Item $old -ItemType file
echo "
Iakim
-----
Isaac
Moraes" > $old
#echo "Arquivo old.txt criado" #Descomente para Debug do script
}

# Comparando se os arquivos são iguais, se a index for igual, isso significa que não há um log do eventID novo.
if (Compare-Object -ReferenceObject $(Get-Content $new) -DifferenceObject $(Get-Content $old)) {
Remove-Item -Path $old
Rename-Item -NewName "old.txt" -Path $new
# Envia para o zabbix
echo "1"
#echo "Alterado" #Descomente para Debug do script
}
else{
# Envia para o zabbix
echo "0"
#echo "Não alterado" #Descomente para Debug do script
}
