mkdir -p /usr/local/ltechagent/cybercns && cd /usr/local/ltechagent/cybercns && wget @linux_url@ && chmod +x cybercnsagent_linux && ./cybercnsagent_linux -c @cybercns_companyId@ -a @cybercns_clientId@ -s @cybercns_clientSecret@ -b @cns-domain@ -i @AgentType@

cd C:\Windows\LTSVC && powershell.exe -NoProfile -ExecutionPolicy unrestricted -command "& {$source = '@win_url@' $destination = 'cybercnsagent.exe' Invoke-WebRequest -Uri $source -OutFile $destination cybercnsagent.exe -c @cybercns_companyId@ -a @cybercns_clientId@ -s @cybercns_clientSecret@ -b @cns-domain@ -i @AgentType@}"



$source = '@@' $destination = 'cybercnsagent.exe' Invoke-WebRequest -Uri $source -OutFile $destination cybercnsagent.exe -c @cybercns_companyId@ -a @cybercns_clientId@ -s @cybercns_clientSecret@ -b @cns-domain@ -i @AgentType@