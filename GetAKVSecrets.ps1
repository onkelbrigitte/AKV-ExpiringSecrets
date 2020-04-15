#read config file (with sensitive data)
$config = Get-Content ".\config.json" -Raw | ConvertFrom-Json

#assign variables
$vaultName = $config.vaultName
$appID = $config.appID
$secret = $config.secret
$tenantID = $config.tenantID
$inXDays = $config.inXDays

#calculate end date
$endDate = (Get-Date).AddDays($inXDays)

#authicate with SPN credentials
$passwd = ConvertTo-SecureString $secret -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential($appID, $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenantId

#get all secrets, filter for secrets without expiration date and expiration date nearer than set 
Get-AzKeyVaultSecret -VaultName $vaultName | Where-Object {$_.Expires -ne $null} | Where-Object {$_.Expires -lt $endDate} 