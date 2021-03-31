# Zabbix - Monitor log

### Download the script called EventLog.ps1 to the C:\ in Windows Host

### Configure your zabbix_agentd.conf
      Timeout=30
      EnableRemoteCommands=1
      
### Zabbix Iten need all the configurations below
      Name: Event Log
      Type: zabbix-agent
      Key: system.run[powershell.exe -command c:\EventLog.ps1]
      Host interface: 192.168.0.47: 10050
      Type of information: Text
      Update(in sec): 60
      
### Zabbix Trigger need all the configurations below
      Name: Novo Evento 1053 encontrado no {HOST.NAME}
      Expression: {iakim:system.run[powershell.exe -command c:\EventLog.ps1].last()}>0
      
### Create the file called New.txt and Old.txt in your C: Windows host:

#### New.txt
- Content:
       
                                                                          Index
                                                                          -----
                                                                         310250
#### Old.txt
- Content:

      Iakim
      -----
      Isaac
      Moraes
      
#### Note: All files are in C:\, to change, change in the $new and $old variable and also in the zabbix-agent item.
