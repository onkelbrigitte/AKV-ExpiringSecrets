#read config file (with sensitive data)
$config = Get-Content ".\config.json" -Raw | ConvertFrom-Json

#assign variables
$vaultName = $config.vaultName
$appID = $config.appID
$secret = $config.secret
$tenantID = $config.tenantID

#authicate with SPN credentials
$passwd = ConvertTo-SecureString $secret -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential($appID, $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -Tenant $tenantId

#get all secrets
Get-AzKeyVaultSecret -VaultName $vaultName